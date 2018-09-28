Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F339C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1821821748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1821821748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeI1OGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:06:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbeI1OGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:06:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S7hnNu015864
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 03:43:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2msce70716-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 03:43:49 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 28 Sep 2018 08:43:44 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 08:43:42 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8S7hft963242424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 07:43:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82384C040;
        Fri, 28 Sep 2018 10:43:24 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 849024C044;
        Fri, 28 Sep 2018 10:43:24 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 10:43:24 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: S390 does not support watchpoints in test 22
Date:   Fri, 28 Sep 2018 09:43:17 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18092807-0008-0000-0000-00000278241F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092807-0009-0000-0000-000021E12FBB
Message-Id: <20180928074317.42893-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S390 does not support the perf_event_open system call for
attribute type PERF_TYPE_BREAKPOINT. This results in test
failure for test 22:

[root@s8360046 perf]# ./perf test 22
22: Watchpoint                                :
22.1: Read Only Watchpoint                    : FAILED!
22.2: Write Only Watchpoint                   : FAILED!
22.3: Read / Write Watchpoint                 : FAILED!
22.4: Modify Watchpoint                       : FAILED!
[root@s8360046 perf]#

Add s390 support to avoid these tests being executed on
s390 platform:

[root@s8360046 perf]# ./perf test 22
22: Watchpoint                                :
22.1: Read Only Watchpoint                    : Skip
22.2: Write Only Watchpoint                   : Skip
22.3: Read / Write Watchpoint                 : Skip
22.4: Modify Watchpoint                       : Skip
[root@s8360046 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 tools/perf/tests/wp.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54ca7d87236f..e83c15a95c43 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -124,7 +124,7 @@ static struct test generic_tests[] = {
 		.desc = "Watchpoint",
 		.func = test__wp,
 		.subtest = {
-			.skip_if_fail	= false,
+			.skip_if_fail	= true,
 			.get_nr		= test__wp_subtest_get_nr,
 			.get_desc	= test__wp_subtest_get_desc,
 		},
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 017a99317f94..85c66f978732 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -162,7 +162,7 @@ static int wp_modify_test(void)
 
 static bool wp_ro_supported(void)
 {
-#if defined (__x86_64__) || defined (__i386__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__s390x__)
 	return false;
 #else
 	return true;
@@ -171,7 +171,7 @@ static bool wp_ro_supported(void)
 
 static void wp_ro_skip_msg(void)
 {
-#if defined (__x86_64__) || defined (__i386__)
+#if defined(__x86_64__) || defined (__i386__) || defined(__s390x__)
 	pr_debug("Hardware does not support read only watchpoints.\n");
 #endif
 }
-- 
2.17.0

