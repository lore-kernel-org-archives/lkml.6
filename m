Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2466C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1137B2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeLNUkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:40:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeLNUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:40:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKdbBl1455955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:39:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKdaMa1455952;
        Fri, 14 Dec 2018 12:39:36 -0800
Date:   Fri, 14 Dec 2018 12:39:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-b4ab1b4fa1995ceb1b7ba9d1b51a5124d28c5f0f@git.kernel.org>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        will.deacon@arm.com, peterz@infradead.org, jolsa@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          namhyung@kernel.org, tglx@linutronix.de, f.fainelli@gmail.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          jolsa@redhat.com, will.deacon@arm.com, mingo@kernel.org,
          acme@redhat.com
In-Reply-To: <20181203191138.2419-1-f.fainelli@gmail.com>
References: <20181203191138.2419-1-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests ARM: Disable breakpoint tests 32-bit
Git-Commit-ID: b4ab1b4fa1995ceb1b7ba9d1b51a5124d28c5f0f
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

Commit-ID:  b4ab1b4fa1995ceb1b7ba9d1b51a5124d28c5f0f
Gitweb:     https://git.kernel.org/tip/b4ab1b4fa1995ceb1b7ba9d1b51a5124d28c5f0f
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Mon, 3 Dec 2018 11:11:36 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:21 -0300

perf tests ARM: Disable breakpoint tests 32-bit

The breakpoint tests on the ARM 32-bit kernel are broken in several
ways.

The breakpoint length requested does not necessarily match whether the
function address has the Thumb bit (bit 0) set or not, and this does
matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
background.

[1]: https://lkml.org/lkml/2018/11/15/205

As Will indicated, the overflow handling would require single-stepping
which is not supported at the moment. Just disable those tests for the
ARM 32-bit platforms and update the comment above to explain these
limitations.

Co-developed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203191138.2419-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..910e25e64188 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -291,12 +291,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 
 bool test__bp_signal_is_supported(void)
 {
-/*
- * The powerpc so far does not have support to even create
- * instruction breakpoint using the perf event interface.
- * Once it's there we can release this.
- */
-#if defined(__powerpc__) || defined(__s390x__)
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * ARM requires explicit rounding down of the instruction
+	 * pointer in Thumb mode, and then requires the single-step
+	 * to be handled explicitly in the overflow handler to avoid
+	 * stepping into the SIGIO handler and getting stuck on the
+	 * breakpointed instruction.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
 	return false;
 #else
 	return true;
