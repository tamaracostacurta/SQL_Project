# 1) Which courses the schools offer? 
select distinct courses, school
from sql_project2.courses;

# 2) How many courses each school offer?
#to check each school, just change the name on '%..%'
SELECT COUNT(*)
FROM (SELECT DISTINCT courses
      FROM  sql_project2.courses
      where school like '%ironhack%' ) as number_courses;
      
# 3) How many reviews each school received in the period that goes from 2020 until 2022? What was the average of the Overall Score for each school?
drop table if exists sql_project2.score_count;
create temporary table sql_project2.score_count
SELECT * from sql_project2.comments_analysis
WHERE graduatingYear > 2019 and overallScore IS NOT NULL;

select school as "school reviewed", avg(overallScore), count(review_body) as "number of reviews"
from sql_project2.score_count
group by school
Limit 0, 999999;

# 4) Which is the average mean of each school considering overall, curriculum, jop support and overall score?
select school, round(avg(overall),2), round(avg(curriculum),2), round(avg(jobSupport),2), round(avg(overallScore),2)
from sql_project2.comments_analysis
where sql_project2.comments_analysis.graduatingYear > 2019 AND
sql_project2.comments_analysis.overallScore IS NOT NULL
group by sql_project2.comments_analysis.school
Limit 0, 999999; 

# 5) Which school has the best Overall Score?
select school as "school reviewed", avg(overallScore), count(review_body) as "number of reviews"
from sql_project2.score_count
group by school
order by avg(overallScore) desc
Limit 0, 999999;

# 6) What is the weight of the different comment ratings?
select school, round(avg(overallScore)-avg(overall),2) AS 'dif_overall' , round(avg(overallScore)-avg(curriculum),2) as 'dif_curr' , round(avg(overallScore)-avg(jobSupport),2) as 'dif_jobsupport', round(avg(overallScore),2)
from sql_project2.comments_analysis
where sql_project2.comments_analysis.graduatingYear > 2019
AND
sql_project2.comments_analysis.overallScore IS NOT NULL
group by sql_project2.comments_analysis.school
Limit 0, 999999; 

select school, round(avg(overall),2) as overall,
round(avg(curriculum),2) as curriculum,
round(avg(jobSupport),2) as jobSupport,
round(avg(overallScore),2) as overallScore,
round(avg(overallScore - overall),2) as dif_overall,
round(avg(overallScore - curriculum),2) as dif_curr,
round(avg(overallScore - jobSupport),2) as dif_jobSupport
from sql_project2.comments_analysis
where sql_project2.comments_analysis.graduatingYear > 2019 AND
jobsupport < 4 AND
sql_project2.comments_analysis.overallScore IS NOT NULL
group by sql_project2.comments_analysis.school
Limit 0, 999999;

# 7) Which are the locations available per school?
drop table if exists sql_project2.locations2;
create temporary table sql_project2.locations2
SELECT * from sql_project2.locations
WHERE `country.name` IS NOT NULL;

select distinct school,(`country.name`)
from sql_project2.locations2;

# 8) Which school has the most locations available? 
#Total of schools per country:

select `country.name`, school, count(`country.name`)
from sql_project2.locations2
group by sql_project2.locations2.`country.name`
Limit 0, 999999;

# 9) Which are the comments that gives the lowest overall score to the schools?
SELECT * FROM sql_project2.comments_analysis
where graduatingYear = 2020
or graduatingYear= 2021
or graduatingYear= 2022
order by overallScore asc;

SELECT * FROM sql_project2.comments_analysis
where graduatingYear > 2019
and review_body like '%assistant%'
order by overallScore asc;

SELECT * FROM sql_project2.comments_analysis
where graduatingYear > 2019
and review_body like '%teacher%'
order by overallScore asc;

SELECT * FROM sql_project2.comments_analysis
where graduatingYear > 2019
and review_body like '%support%'
order by overallScore asc;

SELECT * FROM sql_project2.comments_analysis
where graduatingYear > 2019
and review_body like '%career%'
order by overallScore asc;

# 10) UX/UI Design courses available
SELECT school, courses as UX
FROM SQL_PROJECT2.courses
WHERE courses like '%ux%'
or courses like '%user experience%'
or courses like '%user interface%';

# 11) Cyber Security courses available
SELECT school, courses as cyber
FROM SQL_PROJECT2.courses
WHERE courses like '%cyber%';

# 12) Data Analytics courses available
SELECT school, courses as data_analysis
FROM SQL_PROJECT2.courses
WHERE courses like '%analytics%';

# 13) Checking online courses and flexible classes
SELECT NAME, SCHOOL AS online
FROM SQL_PROJECT2.BADGES
WHERE NAME = "AVAILABLE ONLINE";

SELECT NAME, SCHOOL AS flexib8le
FROM SQL_PROJECT2.BADGES
WHERE NAME = "Flexible Classes";





