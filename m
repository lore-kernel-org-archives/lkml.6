Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCADC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F2720863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBKKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:46:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:46:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAk08v3498002
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:46:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAjxMk3497999;
        Mon, 11 Feb 2019 02:45:59 -0800
Date:   Mon, 11 Feb 2019 02:45:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-bef9f2714f8cf036af3af52a15f534d2cc40c230@git.kernel.org>
Cc:     vincent.weaver@maine.edu, tglx@linutronix.de, eranian@google.com,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
        peterz@infradead.org, namhyung@kernel.org,
        torvalds@linux-foundation.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          torvalds@linux-foundation.org, namhyung@kernel.org,
          dsahern@gmail.com, eranian@google.com,
          alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
          tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <1549319013-4522-4-git-send-email-kan.liang@linux.intel.com>
References: <1549319013-4522-4-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Clean up counter freezing quirk
Git-Commit-ID: bef9f2714f8cf036af3af52a15f534d2cc40c230
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

Commit-ID:  bef9f2714f8cf036af3af52a15f534d2cc40c230
Gitweb:     https://git.kernel.org/tip/bef9f2714f8cf036af3af52a15f534d2cc40c230
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 4 Feb 2019 14:23:32 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:00:41 +0100

perf/x86/intel: Clean up counter freezing quirk

Clean up counter freezing quirk to use the new facility to check for
min microcode revisions.

Rename the counter freezing quirk related functions. Because other
platforms, e.g. Goldmont, also needs to call the quirk.

Only check the boot CPU, assuming models and features are consistent
over all CPUs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1549319013-4522-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 87f4ed203c07..c79c0165d838 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3923,23 +3923,18 @@ static __init void intel_nehalem_quirk(void)
 	}
 }
 
-static bool intel_glp_counter_freezing_broken(int cpu)
-{
-	u32 rev = UINT_MAX; /* default to broken for unknown stepping */
-
-	switch (cpu_data(cpu).x86_stepping) {
-	case 1:
-		rev = 0x28;
-		break;
-	case 8:
-		rev = 0x6;
-		break;
-	}
+static const struct x86_cpu_desc counter_freezing_ucodes[] = {
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	8, 0x00000006),
+	{}
+};
 
-	return (cpu_data(cpu).microcode < rev);
+static bool intel_counter_freezing_broken(void)
+{
+	return !x86_cpu_has_min_microcode_rev(counter_freezing_ucodes);
 }
 
-static __init void intel_glp_counter_freezing_quirk(void)
+static __init void intel_counter_freezing_quirk(void)
 {
 	/* Check if it's already disabled */
 	if (disable_counter_freezing)
@@ -3949,7 +3944,7 @@ static __init void intel_glp_counter_freezing_quirk(void)
 	 * If the system starts with the wrong ucode, leave the
 	 * counter-freezing feature permanently disabled.
 	 */
-	if (intel_glp_counter_freezing_broken(raw_smp_processor_id())) {
+	if (intel_counter_freezing_broken()) {
 		pr_info("PMU counter freezing disabled due to CPU errata,"
 			"please upgrade microcode\n");
 		x86_pmu.counter_freezing = false;
@@ -4326,7 +4321,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-		x86_add_quirk(intel_glp_counter_freezing_quirk);
+		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
