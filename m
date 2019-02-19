Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47955C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508B21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfBSPg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:36:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbfBSPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:36:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JFU0ZK035311
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 10:36:57 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qrmfg8fqk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 10:36:56 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 19 Feb 2019 15:36:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 15:36:50 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JFane728836058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 15:36:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47910A405C;
        Tue, 19 Feb 2019 15:36:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE13DA4054;
        Tue, 19 Feb 2019 15:36:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 15:36:48 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix failure of test 14 on s390
Date:   Tue, 19 Feb 2019 16:36:39 +0100
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19021915-0012-0000-0000-000002F79A1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021915-0013-0000-0000-0000212F278F
Message-Id: <20190219153639.31267-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 489338a717a0 ("perf tests evsel-tp-sched: Fix bitwise operator")
causes test case 14 "Parse sched tracepoints fields" to fail on s390.
This test succeeds on x86.
In fact this test now fails on all architectures with type char
treated as type unsigned char.

The root cause is the signed-ness of character arrays in the
tracepoints sched_switch for structure members prev_comm and
next_comm.

On s390 the output of
 [root@m35lp76 perf]# cat /sys/kernel/debug/tracing/events/\
				sched/sched_switch/format
 name: sched_switch
 ID: 287
 format:
   field:unsigned short common_type; offset:0; size:2;	signed:0;
   ...
   field:char prev_comm[16]; offset:8; size:16;	signed:0;
   ...
   field:char next_comm[16]; offset:40; size:16; signed:0;

reveals the character arrays prev_comm and next_comm are per
default unsigned char and have values in the range of 0..255.

On x86 both fields are signed as this output shows:
 [root@f29]# cat /sys/kernel/debug/tracing/events/sched/\
			sched_switch/format
 name: sched_switch
 ID: 287
 format:
   field:unsigned short common_type; offset:0; size:2;	signed:0;
   ...
   field:char prev_comm[16]; offset:8; size:16;	signed:1;
   ...
   field:char next_comm[16]; offset:40; size:16; signed:1;

and the character arrays prev_comm and next_comm are per
default signed char and have values in the range of -1..127.
The implementation of type char is architecture specific.

Since the character arrays in both tracepoints
sched_switch and sched_wakeup should contain ascii characters,
simply omit the check for signedness in the test case.

Output before:
[root@m35lp76 perf]# ./perf test -F 14
14: Parse sched tracepoints fields                        :
--- start ---
sched:sched_switch: "prev_comm" signedness(0) is wrong, should be 1
sched:sched_switch: "next_comm" signedness(0) is wrong, should be 1
sched:sched_wakeup: "comm" signedness(0) is wrong, should be 1
---- end ----
14: Parse sched tracepoints fields                        : FAILED!
[root@m35lp76 perf]#

Output after:
[root@m35lp76 perf]# ./perf test -Fv 14
14: Parse sched tracepoints fields                        :
--- start ---
---- end ----
Parse sched tracepoints fields: Ok
[root@m35lp76 perf]#

Fixes: 489338a717a0 ("perf tests evsel-tp-sched: Fix bitwise operator")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/evsel-tp-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 5cbba70bcdd0..ea7acf403727 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -43,7 +43,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 		return -1;
 	}
 
-	if (perf_evsel__test_field(evsel, "prev_comm", 16, true))
+	if (perf_evsel__test_field(evsel, "prev_comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "prev_pid", 4, true))
@@ -55,7 +55,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (perf_evsel__test_field(evsel, "next_comm", 16, true))
+	if (perf_evsel__test_field(evsel, "next_comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "next_pid", 4, true))
@@ -73,7 +73,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 		return -1;
 	}
 
-	if (perf_evsel__test_field(evsel, "comm", 16, true))
+	if (perf_evsel__test_field(evsel, "comm", 16, false))
 		ret = -1;
 
 	if (perf_evsel__test_field(evsel, "pid", 4, true))
-- 
2.19.1

