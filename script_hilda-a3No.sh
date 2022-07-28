#!/bin/bash

csvstack 2019-Oct-sample.csv 2019-Nov-sample.csv >> Oct_Nov.csv

csvgrep -c "event_type" -m "purchase" Oct_Nov.csv | csvcut -c 2-5,7-8,6 > purchase_raw.csv

csvgrep -c "event_type" -m "purchase" Oct_Nov.csv | awk -F "." '{print $1}' | csvcut -c "category_code" > purchase_category.csv

cat purchase_raw.csv | awk -F "." '{print $NF}' | csvcut -c 1 > purchase_product_name.csv

csvgrep -c "event_type" -m "purchase" Oct_Nov.csv | csvcut -c 2-5,7-8 > purchase_filter.csv

paste -d , purchase_filter.csv purchase_category.csv purchase_product_name.csv > purchase_data_cleaning.csv
