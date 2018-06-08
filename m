Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wMxIGvWBGluKWwAAmS7hNA
	; Fri, 08 Jun 2018 13:17:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 53A176089E; Fri,  8 Jun 2018 13:17:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C272060275;
	Fri,  8 Jun 2018 13:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C272060275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFHNRi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:17:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751025AbeFHNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:17:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58DFFqJ018717
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 09:17:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfsfkuenh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 09:17:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 8 Jun 2018 14:17:35 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 14:17:33 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58DHXAc31850590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 13:17:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21CEE42045;
        Fri,  8 Jun 2018 14:07:51 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A1542041;
        Fri,  8 Jun 2018 14:07:50 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 14:07:50 +0100 (BST)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test 6 dumps core on s390
Date: Fri,  8 Jun 2018 15:17:28 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18060813-0020-0000-0000-00000298AE4A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060813-0021-0000-0000-000020E4B9E8
Message-Id: <20180608131728.75084-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf test case 6 "Parse event definition strings"
dumps core when executed on s390.
Root case is a NULL pointer supplied in function

 test_event()
 +---> parse_events()

The third parameter is set to NULL:
(gdb) where
 #0  parse_events (evlist=0x149dc90, str=0x133242a "intel_pt//u", err=0x0)
	at util/parse-events.c:1835
 #1  0x00000000010d3d1c in test_event (e=0x14330e0 <test.events+1272>)
	at tests/parse-events.c:1696
 #2  0x00000000010d3e88 in test_events (events=0x1432be8 <test.events>, cnt=54)
	at tests/parse-events.c:1718
 #3  0x00000000010d44c0 in test__parse_events (test=0x142b500
		 <generic_tests+280>, subtest=-1) at tests/parse-events.c:1838

Function parse_events(xx, xx, struct parse_events_error *err) dives
into a bison generated scanner and creates
parser state information for it first:

   struct parse_events_state parse_state = {
      .list   = LIST_HEAD_INIT(parse_state.list),
      .idx    = evlist->nr_entries,
      .error  = err,   <--- NULL POINTER !!!
      .evlist = evlist,
   };

Now various functions inside the bison scanner are called to end up in
__parse_events_add_pmu(struct parse_events_state *parse_state, ..) with
first parameter being a pointer to above structure definition.

Now the event name is not found (because being executed on s390) and
this function tries to create an error message with

   asprintf(&parse_state->error.str, ....)

which references above NULL pointer and dumps core.

Fix this by providing a pointer to the necessary error information
instead of NULL.
Please note that the test still fails on non x86 platforms but for
different and valid reason.

Output with this fix:
[root@s35lp76 perf]# ./perf test -vvvvv -F 6
6: Parse event definition strings                        :
 --- start ---
running test 0 'syscalls:sys_enter_openat'
Using CPUID IBM,3906,703,M03,3.5,002f
running test 1 'syscalls:*'
running test 2 'r1a'
running test 3 '1:1'
running test 4 'instructions'
...
running test 51 'L1-dcache-misses/name=cachepmu/'
running test 52 'intel_pt//u'
failed to parse event 'intel_pt//u', err 1
omitting PMU cpu tests
omitting PMU cpu tests
running test 0 'config=10,config1,config2=3,umask=1'
 ---- end ----
Parse event definition strings: FAILED!

Fixes: b3f58c8da64b ("perf tests parse-events: Add intel_pt parse test")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/parse-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b9ebe15afb13..f1012d7aea7a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1686,6 +1686,7 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error errinfo;
 	struct perf_evlist *evlist;
 	int ret;
 
@@ -1693,7 +1694,7 @@ static int test_event(struct evlist_test *e)
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, NULL);
+	ret = parse_events(evlist, e->name, &errinfo);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
 			 e->name, ret);
-- 
2.14.3
