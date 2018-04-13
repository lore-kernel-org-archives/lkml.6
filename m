Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeDMOCT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753588AbeDMOCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:02:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91558217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/17] perf tests: Disable breakpoint accounting test for powerpc
Date: Fri, 13 Apr 2018 11:01:07 -0300
Message-Id: <20180413140111.25313-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

We disable this test as instruction breakpoints (HW_BREAKPOINT_X) are
not available for powerpc.

Before applying patch:

  21: Breakpoint accounting                                 :
  --- start ---
  test child forked, pid 3635
  failed opening event 0
  failed opening event 0
  watchpoints count 1, breakpoints count 0, has_ioctl 1, share 0
  test child finished with -2
  ---- end ----
  Breakpoint accounting: Skip

After applying patch:

  21: Breakpoint accounting                                 : Disabled

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180412162140.2992-1-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 625f5a6772af..cac8f8889bc3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -118,6 +118,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Breakpoint accounting",
 		.func = test__bp_accounting,
+		.is_supported = test__bp_signal_is_supported,
 	},
 	{
 		.desc = "Number of exit events of a simple workload",
-- 
2.14.3
