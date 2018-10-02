Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A357C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F5920878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F5920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJBQvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:51:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJBQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:51:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A8Rsd1915838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:08:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A8RgJ1915835;
        Tue, 2 Oct 2018 03:08:27 -0700
Date:   Tue, 2 Oct 2018 03:08:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-ba12d20edc5caf9835006d8f3efd4ed18465c75b@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        eranian@google.com, mingo@kernel.org, vincent.weaver@maine.edu
Reply-To: eranian@google.com, mingo@kernel.org, vincent.weaver@maine.edu,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, peterz@infradead.org,
          jolsa@redhat.com, torvalds@linux-foundation.org,
          tglx@linutronix.de
In-Reply-To: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
References: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Factor out common code of PMI
 handler
Git-Commit-ID: ba12d20edc5caf9835006d8f3efd4ed18465c75b
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

Commit-ID:  ba12d20edc5caf9835006d8f3efd4ed18465c75b
Gitweb:     https://git.kernel.org/tip/ba12d20edc5caf9835006d8f3efd4ed18465c75b
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Wed, 8 Aug 2018 00:12:06 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:14:30 +0200

perf/x86/intel: Factor out common code of PMI handler

The Arch Perfmon v4 PMI handler is substantially different than
the older PMI handler. Instead of adding more and more ifs cleanly
fork the new handler into a new function, with the main common
code factored out into a common function.

Fix complaint from checkpatch.pl by removing "false" from "static bool
warned".

No functional change.

Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Link: http://lkml.kernel.org/r/1533712328-2834-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 109 ++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 035c37481f57..9b320a51f82f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2200,59 +2200,15 @@ static void intel_pmu_reset(void)
 	local_irq_restore(flags);
 }
 
-/*
- * This handler is triggered by the local APIC, so the APIC IRQ handling
- * rules apply:
- */
-static int intel_pmu_handle_irq(struct pt_regs *regs)
+static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
-	struct cpu_hw_events *cpuc;
-	int bit, loops;
-	u64 status;
-	int handled;
-	int pmu_enabled;
-
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-
-	/*
-	 * Save the PMU state.
-	 * It needs to be restored when leaving the handler.
-	 */
-	pmu_enabled = cpuc->enabled;
-	/*
-	 * No known reason to not always do late ACK,
-	 * but just in case do it opt-in.
-	 */
-	if (!x86_pmu.late_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
-	intel_bts_disable_local();
-	cpuc->enabled = 0;
-	__intel_pmu_disable_all();
-	handled = intel_pmu_drain_bts_buffer();
-	handled += intel_bts_interrupt();
-	status = intel_pmu_get_status();
-	if (!status)
-		goto done;
-
-	loops = 0;
-again:
-	intel_pmu_lbr_read();
-	intel_pmu_ack_status(status);
-	if (++loops > 100) {
-		static bool warned = false;
-		if (!warned) {
-			WARN(1, "perfevents: irq loop stuck!\n");
-			perf_event_print_debug();
-			warned = true;
-		}
-		intel_pmu_reset();
-		goto done;
-	}
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int bit;
+	int handled = 0;
 
 	inc_irq_stat(apic_perf_irqs);
 
-
 	/*
 	 * Ignore a range of extra bits in status that do not indicate
 	 * overflow by themselves.
@@ -2261,7 +2217,7 @@ again:
 		    GLOBAL_STATUS_ASIF |
 		    GLOBAL_STATUS_LBRS_FROZEN);
 	if (!status)
-		goto done;
+		return 0;
 	/*
 	 * In case multiple PEBS events are sampled at the same time,
 	 * it is possible to have GLOBAL_STATUS bit 62 set indicating
@@ -2331,6 +2287,61 @@ again:
 			x86_pmu_stop(event, 0);
 	}
 
+	return handled;
+}
+
+/*
+ * This handler is triggered by the local APIC, so the APIC IRQ handling
+ * rules apply:
+ */
+static int intel_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc;
+	int loops;
+	u64 status;
+	int handled;
+	int pmu_enabled;
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * Save the PMU state.
+	 * It needs to be restored when leaving the handler.
+	 */
+	pmu_enabled = cpuc->enabled;
+	/*
+	 * No known reason to not always do late ACK,
+	 * but just in case do it opt-in.
+	 */
+	if (!x86_pmu.late_ack)
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+	intel_bts_disable_local();
+	cpuc->enabled = 0;
+	__intel_pmu_disable_all();
+	handled = intel_pmu_drain_bts_buffer();
+	handled += intel_bts_interrupt();
+	status = intel_pmu_get_status();
+	if (!status)
+		goto done;
+
+	loops = 0;
+again:
+	intel_pmu_lbr_read();
+	intel_pmu_ack_status(status);
+	if (++loops > 100) {
+		static bool warned;
+
+		if (!warned) {
+			WARN(1, "perfevents: irq loop stuck!\n");
+			perf_event_print_debug();
+			warned = true;
+		}
+		intel_pmu_reset();
+		goto done;
+	}
+
+	handled += handle_pmi_common(regs, status);
+
 	/*
 	 * Repeat if there is more work to be done:
 	 */
