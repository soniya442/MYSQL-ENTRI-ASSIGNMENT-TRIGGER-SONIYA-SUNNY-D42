CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    experience INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO teachers (name, subject, experience, salary) VALUES
('Alice Johnson', 'Math', 5, 45000),
('Bob Smith', 'Physics', 12, 60000),
('Catherine Lee', 'Chemistry', 8, 52000),
('David Brown', 'Biology', 3, 40000),
('Eva Adams', 'English', 6, 47000),
('Frank White', 'History', 11, 58000),
('Grace Kelly', 'Geography', 2, 39000),
('Hank Taylor', 'Computer Science', 9, 55000);

select * from teachers ;

delimiter $$
create trigger before_insert_teacher
before insert on teachers 
 for each row
 begin
 if new. salary < 0 then
 signal sqlstate '45000'
 set message_text ='salary cannot be negative' ;
 end if ;
 end $$
 delimiter ;
 
 CREATE TABLE teacher_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT NOT NULL,
    action VARCHAR(50) NOT NULL,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_insert_teacher
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action, log_timestamp)
    VALUES (NEW.id, 'INSERT', NOW());
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON teachers
FOR EACH ROW
BEGIN
    IF OLD.experience > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a teacher with experience greater than 10 years';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_delete_teacher
AFTER DELETE ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action, log_timestamp)
    VALUES (OLD.id, 'DELETE', NOW());
END $$

DELIMITER ;



















