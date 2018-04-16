Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeDPGrQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:47:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeDPGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:47:15 -0400
Date: Sun, 15 Apr 2018 23:47:07 -0700
From: tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-4b163ca343b45855b03114ef2ab47c454989d55c@git.kernel.org>
Cc: acme@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com, mingo@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        sandipan@linux.vnet.ibm.com
Reply-To: sandipan@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        acme@redhat.com, jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mingo@kernel.org
In-Reply-To: <20180412162140.2992-1-sandipan@linux.vnet.ibm.com>
References: <20180412162140.2992-1-sandipan@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Disable breakpoint accounting test
 for powerpc
Git-Commit-ID: 4b163ca343b45855b03114ef2ab47c454989d55c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4b163ca343b45855b03114ef2ab47c454989d55c
Gitweb:     https://git.kernel.org/tip/4b163ca343b45855b03114ef2ab47c454989d55c
Author:     Sandipan Das <sandipan@linux.vnet.ibm.com>
AuthorDate: Thu, 12 Apr 2018 21:51:40 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 14:20:21 -0300

perf tests: Disable breakpoint accounting test for powerpc

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
