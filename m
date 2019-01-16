Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66187C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EB120651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405486AbfAPQYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbfAPQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:16 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGMhDZ179556
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2832g2gu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:14 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGO7oE7078308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20DAE42042;
        Wed, 16 Jan 2019 16:24:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D68F14203F;
        Wed, 16 Jan 2019 16:24:04 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:04 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to failed-syscalls-by-pid.py
Date:   Wed, 16 Jan 2019 21:53:33 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0016-0000-0000-000002465468
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0017-0000-0000-000032A07294
Message-Id: <1547655825-28754-5-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in failed-syscalls-by-pid.py.
``print`` is now a function rather than a statement. This should have
no functional change.

Fixes lambda syntax error.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Please enter the commit message for your changes. Lines starting
---
 tools/perf/scripts/python/failed-syscalls-by-pid.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
index cafeff3..333c762 100644
--- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
+++ b/tools/perf/scripts/python/failed-syscalls-by-pid.py
@@ -32,7 +32,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_error_totals()
@@ -57,22 +57,22 @@ def syscalls__sys_exit(event_name, context, common_cpu,
 
 def print_error_totals():
     if for_comm is not None:
-	    print "\nsyscall errors for %s:\n\n" % (for_comm),
+	    print("\nsyscall errors for %s:\n\n" % (for_comm)),
     else:
-	    print "\nsyscall errors:\n\n",
+	    print("\nsyscall errors:\n\n"),
 
-    print "%-30s  %10s\n" % ("comm [pid]", "count"),
-    print "%-30s  %10s\n" % ("------------------------------", \
-                                 "----------"),
+    print("%-30s  %10s\n" % ("comm [pid]", "count")),
+    print("%-30s  %10s\n" % ("------------------------------", \
+                                 "----------")),
 
     comm_keys = syscalls.keys()
     for comm in comm_keys:
 	    pid_keys = syscalls[comm].keys()
 	    for pid in pid_keys:
-		    print "\n%s [%d]\n" % (comm, pid),
+		    print("\n%s [%d]\n" % (comm, pid)),
 		    id_keys = syscalls[comm][pid].keys()
 		    for id in id_keys:
-			    print "  syscall: %-16s\n" % syscall_name(id),
+			    print("  syscall: %-16s\n" % syscall_name(id)),
 			    ret_keys = syscalls[comm][pid][id].keys()
-			    for ret, val in sorted(syscalls[comm][pid][id].iteritems(), key = lambda(k, v): (v, k),  reverse = True):
-				    print "    err = %-20s  %10d\n" % (strerror(ret), val),
+			    for ret, val in sorted(syscalls[comm][pid][id].iteritems(), key = lambda k_v: (k_v[1], k_v[0]),  reverse = True):
+				    print("    err = %-20s  %10d\n" % (strerror(ret), val)),
-- 
1.8.3.1

