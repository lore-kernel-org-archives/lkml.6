Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5160B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfAQJqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:46:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729275AbfAQJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:46:33 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H9iQh8048124
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:46:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2k6h1f85-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:46:31 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Thu, 17 Jan 2019 09:46:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 09:46:25 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0H9kOPE62849054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:46:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D897011C058;
        Thu, 17 Jan 2019 09:46:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79A4D11C04A;
        Thu, 17 Jan 2019 09:46:23 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.35.202])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 09:46:23 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com
Subject: [PATCH v2] perf scripts python: Add Python 3 support to syscall-counts-by-pid.py
Date:   Thu, 17 Jan 2019 15:15:42 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011709-0028-0000-0000-0000033A5AF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011709-0029-0000-0000-000023F78511
Message-Id: <1547718344-27382-15-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in syscall-counts-by-pid.py. ``print``
is now a function rather than a statement. This should have no functional
change.

Fix lambda syntax error.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/syscall-counts-by-pid.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/perf/scripts/python/syscall-counts-by-pid.py
index daf314c..3146094 100644
--- a/tools/perf/scripts/python/syscall-counts-by-pid.py
+++ b/tools/perf/scripts/python/syscall-counts-by-pid.py
@@ -4,6 +4,7 @@
 #
 # Displays system-wide system call totals, broken down by syscall.
 # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+from __future__ import print_function
 
 import os, sys
 
@@ -31,7 +32,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_syscall_totals()
@@ -55,20 +56,20 @@ def syscalls__sys_enter(event_name, context, common_cpu,
 
 def print_syscall_totals():
     if for_comm is not None:
-	    print "\nsyscall events for %s:\n\n" % (for_comm),
+	    print("\nsyscall events for %s:\n\n" % (for_comm)),
     else:
-	    print "\nsyscall events by comm/pid:\n\n",
+	    print("\nsyscall events by comm/pid:\n\n"),
 
-    print "%-40s  %10s\n" % ("comm [pid]/syscalls", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "----------"),
+    print("%-40s  %10s\n" % ("comm [pid]/syscalls", "count")),
+    print("%-40s  %10s\n" % ("----------------------------------------", \
+                                 "----------")),
 
     comm_keys = syscalls.keys()
     for comm in comm_keys:
 	    pid_keys = syscalls[comm].keys()
 	    for pid in pid_keys:
-		    print "\n%s [%d]\n" % (comm, pid),
+		    print("\n%s [%d]\n" % (comm, pid)),
 		    id_keys = syscalls[comm][pid].keys()
 		    for id, val in sorted(syscalls[comm][pid].iteritems(), \
-				  key = lambda(k, v): (v, k),  reverse = True):
-			    print "  %-38s  %10d\n" % (syscall_name(id), val),
+				  key = lambda k_v: (k_v[1], k_v[0]),  reverse = True):
+			    print("  %-38s  %10d\n" % (syscall_name(id), val)),
-- 
1.8.3.1

