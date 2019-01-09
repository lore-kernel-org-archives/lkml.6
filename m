Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4C420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfAIHNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:13:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfAIHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:13:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097Bwxr3855652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:11:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097Bw2g3855649;
        Tue, 8 Jan 2019 23:11:58 -0800
Date:   Tue, 8 Jan 2019 23:11:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-21327c7843e9169d5e2e527713e60e6c9842a56c@git.kernel.org>
Cc:     peterz@infradead.org, tmricht@linux.ibm.com, f.fainelli@gmail.com,
        ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
        kim.phillips@arm.com, namhyung@kernel.org,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, cphealy@gmail.com, acme@redhat.com
Reply-To: l.stach@pengutronix.de, rmk+kernel@armlinux.org.uk,
          ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
          kim.phillips@arm.com, namhyung@kernel.org, f.fainelli@gmail.com,
          tmricht@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de,
          gregkh@linuxfoundation.org, cphealy@gmail.com, acme@redhat.com,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, jolsa@kernel.org
In-Reply-To: <20181221034337.26663-3-f.fainelli@gmail.com>
References: <20181221034337.26663-3-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Add a test for the ARM 32-bit
 [vectors] page
Git-Commit-ID: 21327c7843e9169d5e2e527713e60e6c9842a56c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  21327c7843e9169d5e2e527713e60e6c9842a56c
Gitweb:     https://git.kernel.org/tip/21327c7843e9169d5e2e527713e60e6c9842a56c
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Thu, 20 Dec 2018 19:43:37 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

perf tests: Add a test for the ARM 32-bit [vectors] page

perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
independance with respect to the ARM CPU being used. Add a test which
tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
turned on to help asses the system's health.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20181221034337.26663-3-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/Build          |  1 +
 tools/perf/arch/arm/tests/arch-tests.c   |  4 ++++
 tools/perf/arch/arm/tests/vectors-page.c | 24 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  5 +++++
 4 files changed, 34 insertions(+)

diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index 883c57ff0c08..d9ae2733f9cc 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,4 +1,5 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+libperf-y += vectors-page.o
 
 libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 5b1543c98022..6848101a855f 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Vectors page",
+		.func = test__vectors_page,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
new file mode 100644
index 000000000000..7ffdd79971c8
--- /dev/null
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+
+#include "debug.h"
+#include "tests/tests.h"
+#include "util/find-map.c"
+
+#define VECTORS__MAP_NAME "[vectors]"
+
+int test__vectors_page(struct test *test __maybe_unused,
+		       int subtest __maybe_unused)
+{
+	void *start, *end;
+
+	if (find_map(&start, &end, VECTORS__MAP_NAME)) {
+		pr_err("%s not found, is CONFIG_KUSER_HELPERS enabled?\n",
+		       VECTORS__MAP_NAME);
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b82f55fcc294..399f18ca71a3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -119,4 +119,9 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread);
 #endif
 #endif
+
+#if defined(__arm__)
+int test__vectors_page(struct test *test, int subtest);
+#endif
+
 #endif /* TESTS_H */
