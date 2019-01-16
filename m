Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F64F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405447AbfAPQYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbfAPQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:04 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGJqE1007060
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q27hqhnv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:02 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:23:57 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGNusY59310088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:23:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DA5842041;
        Wed, 16 Jan 2019 16:23:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F34C42042;
        Wed, 16 Jan 2019 16:23:54 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:23:53 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to event_analyzing_sample.py
Date:   Wed, 16 Jan 2019 21:53:30 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0020-0000-0000-0000030757CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0021-0000-0000-00002158755B
Message-Id: <1547655825-28754-2-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in event_analyzing_sample.py. ``print``
is now a function rather than a statement. This should have no functional
change.

Fixes indentation issue, replace spaces with tab. The "has_key()" method
is deprecated in favor of the "in" operator. So incorporate those changes
here.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../perf/scripts/python/event_analyzing_sample.py  | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index 4e843b9..8cb116f 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -37,20 +37,20 @@ con = sqlite3.connect("/dev/shm/perf.db")
 con.isolation_level = None
 
 def trace_begin():
-	print "In trace_begin:\n"
+	print("In trace_begin:\n")
 
         #
         # Will create several tables at the start, pebs_ll is for PEBS data with
         # load latency info, while gen_events is for general event.
         #
-        con.execute("""
+	con.execute("""
                 create table if not exists gen_events (
                         name text,
                         symbol text,
                         comm text,
                         dso text
                 );""")
-        con.execute("""
+	con.execute("""
                 create table if not exists pebs_ll (
                         name text,
                         symbol text,
@@ -76,12 +76,12 @@ def process_event(param_dict):
         name       = param_dict["ev_name"]
 
         # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
+        if ('dso' in param_dict):
                 dso = param_dict["dso"]
         else:
                 dso = "Unknown_dso"
 
-        if (param_dict.has_key("symbol")):
+        if ('symbol' in param_dict):
                 symbol = param_dict["symbol"]
         else:
                 symbol = "Unknown_symbol"
@@ -102,11 +102,11 @@ def insert_db(event):
                                 event.ip, event.status, event.dse, event.dla, event.lat))
 
 def trace_end():
-	print "In trace_end:\n"
+	print("In trace_end:\n")
         # We show the basic info for the 2 type of event classes
-        show_general_events()
-        show_pebs_ll()
-        con.close()
+	show_general_events()
+	show_pebs_ll()
+	con.close()
 
 #
 # As the event number may be very big, so we can't use linear way
@@ -123,29 +123,29 @@ def show_general_events():
         # Check the total record number in the table
         count = con.execute("select count(*) from gen_events")
         for t in count:
-                print "There is %d records in gen_events table" % t[0]
+                print("There is %d records in gen_events table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the general events grouped by thread/symbol/dso: \n"
+        print("Statistics about the general events grouped by thread/symbol/dso: \n")
 
          # Group by thread
         commq = con.execute("select comm, count(comm) from gen_events group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from gen_events group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dso
-        print "\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74)
+        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74))
         dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
         for row in dsoq:
-             print "%40s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 #
 # This function just shows the basic info, and we could do more with the
@@ -156,35 +156,35 @@ def show_pebs_ll():
 
         count = con.execute("select count(*) from pebs_ll")
         for t in count:
-                print "There is %d records in pebs_ll table" % t[0]
+                print("There is %d records in pebs_ll table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n"
+        print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
 
         # Group by thread
         commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from pebs_ll group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dse
         dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
-        print "\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58))
         for row in dseq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by latency
         latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
-        print "\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58))
         for row in latq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
-- 
1.8.3.1

