Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C196C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B5520651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405569AbfAPQYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731613AbfAPQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGL8lO126058
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:39 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q26gbvt4v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:39 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:36 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGOWn526804370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CE2E42047;
        Wed, 16 Jan 2019 16:24:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB7304203F;
        Wed, 16 Jan 2019 16:24:29 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:29 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to sctop.py
Date:   Wed, 16 Jan 2019 21:53:40 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0008-0000-0000-000002B1E66B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0009-0000-0000-0000221E0086
Message-Id: <1547655825-28754-12-git-send-email-s1seetee@linux.vnet.ibm.com>
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

Support both Python 2 and Python 3 in sctop.py.``print``
is now a function rather than a statement. This should have no
functional change.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/sctop.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 61621b9..ea8edcf 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -62,18 +62,18 @@ def print_syscall_totals(interval):
 	while 1:
 		clear_term()
 		if for_comm is not None:
-			print "\nsyscall events for %s:\n\n" % (for_comm),
+			print("\nsyscall events for %s:\n\n" % (for_comm)),
 		else:
-			print "\nsyscall events:\n\n",
+			print("\nsyscall events:\n\n"),
 
-		print "%-40s  %10s\n" % ("event", "count"),
-		print "%-40s  %10s\n" % ("----------------------------------------", \
-						 "----------"),
+		print("%-40s  %10s\n" % ("event", "count")),
+		print("%-40s  %10s\n" % ("----------------------------------------", \
+						 "----------")),
 
-		for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
+		for id, val in sorted(syscalls.iteritems(), key = lambda k_v: (k_v[1], k_v[0]), \
 					      reverse = True):
 			try:
-				print "%-40s  %10d\n" % (syscall_name(id), val),
+				print("%-40s  %10d\n" % (syscall_name(id), val)),
 			except TypeError:
 				pass
 		syscalls.clear()
-- 
1.8.3.1

