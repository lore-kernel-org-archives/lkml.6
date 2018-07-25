Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2DCC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8B520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8B520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeGYPpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:45:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeGYPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:45:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEX1of403058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:33:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEX1kV403055;
        Wed, 25 Jul 2018 07:33:01 -0700
Date:   Wed, 25 Jul 2018 07:33:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-ec71a398c1bf6d8188cb24ebab6f5202523d95e1@git.kernel.org>
Cc:     hpa@zytor.com, alexander.shishkin@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        vincent.weaver@maine.edu, eranian@google.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, kan.liang@linux.intel.com, jolsa@redhat.com
Reply-To: torvalds@linux-foundation.org, vincent.weaver@maine.edu,
          eranian@google.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          jolsa@redhat.com, kan.liang@linux.intel.com, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20180309021542.11374-3-kan.liang@linux.intel.com>
References: <20180309021542.11374-3-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/ds: Handle PEBS overflow for fixed
 counters
Git-Commit-ID: ec71a398c1bf6d8188cb24ebab6f5202523d95e1
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

Commit-ID:  ec71a398c1bf6d8188cb24ebab6f5202523d95e1
Gitweb:     https://git.kernel.org/tip/ec71a398c1bf6d8188cb24ebab6f5202523d95e1
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 8 Mar 2018 18:15:41 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:50:50 +0200

perf/x86/intel/ds: Handle PEBS overflow for fixed counters

The pebs_drain() need to support fixed counters. The DS Save Area now
include "counter reset value" fields for each fixed counters.

Extend the related variables (e.g. mask, counters, error) to support
fixed counters. There is no extended PEBS in PEBS v2 and earlier PEBS
format. Only need to change the code for PEBS v3 and later PEBS format.

Extend the pebs_event_reset[] logic to support new "counter reset value" fields.

Increase the reserve space for fixed counters.

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
Link: http://lkml.kernel.org/r/20180309021542.11374-3-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c    |  5 ++++-
 arch/x86/events/intel/ds.c      | 36 +++++++++++++++++++++++++++---------
 arch/x86/include/asm/intel_ds.h |  3 ++-
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d5a3124605f5..b1a49a108a59 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2282,7 +2282,10 @@ again:
 	 * counters from the GLOBAL_STATUS mask and we always process PEBS
 	 * events via drain_pebs().
 	 */
-	status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		status &= ~cpuc->pebs_enabled;
+	else
+		status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
 
 	/*
 	 * PEBS overflow sets bit 62 in the global status register
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9fd9cb1d2cc8..595b96ae8a00 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -903,10 +903,16 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
 	u64 threshold;
+	int reserved;
+
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		reserved = x86_pmu.max_pebs_events + x86_pmu.num_counters_fixed;
+	else
+		reserved = x86_pmu.max_pebs_events;
 
 	if (cpuc->n_pebs == cpuc->n_large_pebs) {
 		threshold = ds->pebs_absolute_maximum -
-			x86_pmu.max_pebs_events * x86_pmu.pebs_record_size;
+			reserved * x86_pmu.pebs_record_size;
 	} else {
 		threshold = ds->pebs_buffer_base + x86_pmu.pebs_record_size;
 	}
@@ -970,7 +976,11 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
 	 */
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		ds->pebs_event_reset[hwc->idx] =
+		unsigned int idx = hwc->idx;
+
+		if (idx >= INTEL_PMC_IDX_FIXED)
+			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+		ds->pebs_event_reset[idx] =
 			(u64)(-hwc->sample_period) & x86_pmu.cntval_mask;
 	} else {
 		ds->pebs_event_reset[hwc->idx] = 0;
@@ -1488,9 +1498,10 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
 	void *base, *at, *top;
-	short counts[MAX_PEBS_EVENTS] = {};
-	short error[MAX_PEBS_EVENTS] = {};
-	int bit, i;
+	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	int bit, i, size;
+	u64 mask;
 
 	if (!x86_pmu.pebs_active)
 		return;
@@ -1500,6 +1511,13 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
+	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
+	size = x86_pmu.max_pebs_events;
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
+		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
+		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
+	}
+
 	if (unlikely(base >= top)) {
 		/*
 		 * The drain_pebs() could be called twice in a short period
@@ -1509,7 +1527,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		 * update the event->count for this case.
 		 */
 		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
-				 x86_pmu.max_pebs_events) {
+				 size) {
 			event = cpuc->events[bit];
 			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 				intel_pmu_save_and_restart_reload(event, 0);
@@ -1522,12 +1540,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		u64 pebs_status;
 
 		pebs_status = p->status & cpuc->pebs_enabled;
-		pebs_status &= (1ULL << x86_pmu.max_pebs_events) - 1;
+		pebs_status &= mask;
 
 		/* PEBS v3 has more accurate status bits */
 		if (x86_pmu.intel_cap.pebs_format >= 3) {
 			for_each_set_bit(bit, (unsigned long *)&pebs_status,
-					 x86_pmu.max_pebs_events)
+					 size)
 				counts[bit]++;
 
 			continue;
@@ -1575,7 +1593,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		counts[bit]++;
 	}
 
-	for (bit = 0; bit < x86_pmu.max_pebs_events; bit++) {
+	for (bit = 0; bit < size; bit++) {
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 62a9f4966b42..ae26df1c2789 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -8,6 +8,7 @@
 
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS		8
+#define MAX_FIXED_PEBS_EVENTS	3
 
 /*
  * A debug store configuration.
@@ -23,7 +24,7 @@ struct debug_store {
 	u64	pebs_index;
 	u64	pebs_absolute_maximum;
 	u64	pebs_interrupt_threshold;
-	u64	pebs_event_reset[MAX_PEBS_EVENTS];
+	u64	pebs_event_reset[MAX_PEBS_EVENTS + MAX_FIXED_PEBS_EVENTS];
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct debug_store, cpu_debug_store);
