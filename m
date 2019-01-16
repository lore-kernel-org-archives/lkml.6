Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1BAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0650D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405617AbfAPQZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:25:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731019AbfAPQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGJp2i007000
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q27hqhq0q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:57 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGOoFx57540640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B68942042;
        Wed, 16 Jan 2019 16:24:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4806C42056;
        Wed, 16 Jan 2019 16:24:48 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:48 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to export-to-postgresql.py
Date:   Wed, 16 Jan 2019 21:53:45 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0020-0000-0000-0000030757DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0021-0000-0000-000021587569
Message-Id: <1547655825-28754-17-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in export-to-postgresql.py. ``print``
is now a function rather than a statement. This should have no functional
change.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 0564dd7..6774909 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -273,7 +273,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+print(datetime.datetime.today(), "Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -564,7 +564,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing to intermediate files..."
+	print(datetime.datetime.today(), "Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -579,7 +579,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print datetime.datetime.today(), "Copying to database..."
+	print(datetime.datetime.today(), "Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -594,7 +594,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print datetime.datetime.today(), "Removing intermediate files..."
+	print(datetime.datetime.today(), "Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -609,7 +609,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print datetime.datetime.today(), "Adding primary keys"
+	print(datetime.datetime.today(), "Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -624,7 +624,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print datetime.datetime.today(), "Adding foreign keys"
+	print(datetime.datetime.today(), "Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -659,8 +659,8 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
+	print(datetime.datetime.today(), "Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
-- 
1.8.3.1

