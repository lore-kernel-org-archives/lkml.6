Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA98EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611402087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lcIaVxHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611402087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeLMQ4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:56:37 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:39848 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeLMQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:56:36 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6007624E2469;
        Thu, 13 Dec 2018 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544720196; bh=AVqLSA76qPDDsVls95bgBNJyrjfb+hPtQ9rJoqPgQyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcIaVxHEIjhJWBtrU63ShzRNhzEBe/a6COQpCTmySzLrlwyArkBfXZGQtFgme4RQ7
         WWeBpC4DNY0Jts/ABUZAYMjsN/N3gxjy53SlYYTau7pYc9Tu9KgpINhjMAqPgualea
         63ysKuXDyTHL9ix8xuHgxlznJCdK4rT0DwY1NyppWaWk7gRs+EQcDj/tZ5de/yuW47
         y89LZ6Wjs8H6VXqxz/ndYy7xi9iBnUm40Z2oVM3oSqAhfWzovhwrM0c9ocPzo9FGAz
         a3D38bOI6OaIlgsTr/CE2tCTwTUvQ6v75R216scMvSpKct0yk+vk74wSkQMcjFRHd0
         gIIY8zN2tVtOw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9DCE8300C;
        Thu, 13 Dec 2018 08:56:31 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/4] ARC: perf: trivial code cleanup
Date:   Thu, 13 Dec 2018 19:56:18 +0300
Message-Id: <20181213165621.20817-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
References: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Use BIT(), lower_32_bits(), upper_32_bits() macroses,
  fix code style violations.
* Use u32, u64, s64 instead of uint32_t, uint64_t, int64_t
* Fix description comment as this code doesn't belong only to
  ARC700 anymore.
* Use SPDX License Identifier.
* Remove useless ifdefs. ifdef around 'arc_pmu_match' structure
  declaration is useless as we refer to 'arc_pmu_match' in
  several places which aren't guarded with ifdef. Nevertheless
  'ARC' option selects 'OF' unconditionally so we can simply
  get rid of this ifdef.

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Squash first four cleanup patches into this one.

 arch/arc/kernel/perf_event.c | 85 ++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 8aec462d90fb..693f32d60c35 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -1,15 +1,10 @@
-/*
- * Linux performance counter support for ARC700 series
- *
- * Copyright (C) 2013-2015 Synopsys, Inc. (www.synopsys.com)
- *
- * This code is inspired by the perf support of various other architectures.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Linux performance counter support for ARC CPUs.
+// This code is inspired by the perf support of various other architectures.
+//
+// Copyright (C) 2013-2018 Synopsys, Inc. (www.synopsys.com)
+
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -19,6 +14,9 @@
 #include <asm/arcregs.h>
 #include <asm/stacktrace.h>
 
+/* HW holds 8 symbols + one for null terminator */
+#define ARCPMU_EVENT_NAME_LEN	9
+
 struct arc_pmu {
 	struct pmu	pmu;
 	unsigned int	irq;
@@ -49,6 +47,7 @@ static int callchain_trace(unsigned int addr, void *data)
 {
 	struct arc_callchain_trace *ctrl = data;
 	struct perf_callchain_entry_ctx *entry = ctrl->perf_stuff;
+
 	perf_callchain_store(entry, addr);
 
 	if (ctrl->depth++ < 3)
@@ -57,8 +56,8 @@ static int callchain_trace(unsigned int addr, void *data)
 	return -1;
 }
 
-void
-perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+			   struct pt_regs *regs)
 {
 	struct arc_callchain_trace ctrl = {
 		.depth = 0,
@@ -68,8 +67,8 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	arc_unwind_core(NULL, regs, callchain_trace, &ctrl);
 }
 
-void
-perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
 {
 	/*
 	 * User stack can't be unwound trivially with kernel dwarf unwinder
@@ -82,10 +81,10 @@ static struct arc_pmu *arc_pmu;
 static DEFINE_PER_CPU(struct arc_pmu_cpu, arc_pmu_cpu);
 
 /* read counter #idx; note that counter# != event# on ARC! */
-static uint64_t arc_pmu_read_counter(int idx)
+static u64 arc_pmu_read_counter(int idx)
 {
-	uint32_t tmp;
-	uint64_t result;
+	u32 tmp;
+	u64 result;
 
 	/*
 	 * ARC supports making 'snapshots' of the counters, so we don't
@@ -94,7 +93,7 @@ static uint64_t arc_pmu_read_counter(int idx)
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);
 	tmp = read_aux_reg(ARC_REG_PCT_CONTROL);
 	write_aux_reg(ARC_REG_PCT_CONTROL, tmp | ARC_REG_PCT_CONTROL_SN);
-	result = (uint64_t) (read_aux_reg(ARC_REG_PCT_SNAPH)) << 32;
+	result = (u64) (read_aux_reg(ARC_REG_PCT_SNAPH)) << 32;
 	result |= read_aux_reg(ARC_REG_PCT_SNAPL);
 
 	return result;
@@ -103,9 +102,9 @@ static uint64_t arc_pmu_read_counter(int idx)
 static void arc_perf_event_update(struct perf_event *event,
 				  struct hw_perf_event *hwc, int idx)
 {
-	uint64_t prev_raw_count = local64_read(&hwc->prev_count);
-	uint64_t new_raw_count = arc_pmu_read_counter(idx);
-	int64_t delta = new_raw_count - prev_raw_count;
+	u64 prev_raw_count = local64_read(&hwc->prev_count);
+	u64 new_raw_count = arc_pmu_read_counter(idx);
+	s64 delta = new_raw_count - prev_raw_count;
 
 	/*
 	 * We aren't afraid of hwc->prev_count changing beneath our feet
@@ -155,7 +154,7 @@ static int arc_pmu_event_init(struct perf_event *event)
 	int ret;
 
 	if (!is_sampling_event(event)) {
-		hwc->sample_period  = arc_pmu->max_period;
+		hwc->sample_period = arc_pmu->max_period;
 		hwc->last_period = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
@@ -192,6 +191,7 @@ static int arc_pmu_event_init(struct perf_event *event)
 		pr_debug("init cache event with h/w %08x \'%s\'\n",
 			 (int)hwc->config, arc_pmu_ev_hw_map[ret]);
 		return 0;
+
 	default:
 		return -ENOENT;
 	}
@@ -200,7 +200,7 @@ static int arc_pmu_event_init(struct perf_event *event)
 /* starts all counters */
 static void arc_pmu_enable(struct pmu *pmu)
 {
-	uint32_t tmp;
+	u32 tmp;
 	tmp = read_aux_reg(ARC_REG_PCT_CONTROL);
 	write_aux_reg(ARC_REG_PCT_CONTROL, (tmp & 0xffff0000) | 0x1);
 }
@@ -208,7 +208,7 @@ static void arc_pmu_enable(struct pmu *pmu)
 /* stops all counters */
 static void arc_pmu_disable(struct pmu *pmu)
 {
-	uint32_t tmp;
+	u32 tmp;
 	tmp = read_aux_reg(ARC_REG_PCT_CONTROL);
 	write_aux_reg(ARC_REG_PCT_CONTROL, (tmp & 0xffff0000) | 0x0);
 }
@@ -228,7 +228,7 @@ static int arc_pmu_event_set_period(struct perf_event *event)
 		local64_set(&hwc->period_left, left);
 		hwc->last_period = period;
 		overflow = 1;
-	} else	if (unlikely(left <= 0)) {
+	} else if (unlikely(left <= 0)) {
 		/* left underflowed by less than period. */
 		left += period;
 		local64_set(&hwc->period_left, left);
@@ -246,8 +246,8 @@ static int arc_pmu_event_set_period(struct perf_event *event)
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);
 
 	/* Write value */
-	write_aux_reg(ARC_REG_PCT_COUNTL, (u32)value);
-	write_aux_reg(ARC_REG_PCT_COUNTH, (value >> 32));
+	write_aux_reg(ARC_REG_PCT_COUNTL, lower_32_bits(value));
+	write_aux_reg(ARC_REG_PCT_COUNTH, upper_32_bits(value));
 
 	perf_event_update_userpage(event);
 
@@ -277,7 +277,7 @@ static void arc_pmu_start(struct perf_event *event, int flags)
 	/* Enable interrupt for this counter */
 	if (is_sampling_event(event))
 		write_aux_reg(ARC_REG_PCT_INT_CTRL,
-			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
+			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | BIT(idx));
 
 	/* enable ARC pmu here */
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);		/* counter # */
@@ -295,9 +295,9 @@ static void arc_pmu_stop(struct perf_event *event, int flags)
 		 * Reset interrupt flag by writing of 1. This is required
 		 * to make sure pending interrupt was not left.
 		 */
-		write_aux_reg(ARC_REG_PCT_INT_ACT, 1 << idx);
+		write_aux_reg(ARC_REG_PCT_INT_ACT, BIT(idx));
 		write_aux_reg(ARC_REG_PCT_INT_CTRL,
-			      read_aux_reg(ARC_REG_PCT_INT_CTRL) & ~(1 << idx));
+			      read_aux_reg(ARC_REG_PCT_INT_CTRL) & ~BIT(idx));
 	}
 
 	if (!(event->hw.state & PERF_HES_STOPPED)) {
@@ -349,9 +349,10 @@ static int arc_pmu_add(struct perf_event *event, int flags)
 
 	if (is_sampling_event(event)) {
 		/* Mimic full counter overflow as other arches do */
-		write_aux_reg(ARC_REG_PCT_INT_CNTL, (u32)arc_pmu->max_period);
+		write_aux_reg(ARC_REG_PCT_INT_CNTL,
+			      lower_32_bits(arc_pmu->max_period));
 		write_aux_reg(ARC_REG_PCT_INT_CNTH,
-			      (arc_pmu->max_period >> 32));
+			      upper_32_bits(arc_pmu->max_period));
 	}
 
 	write_aux_reg(ARC_REG_PCT_CONFIG, 0);
@@ -392,7 +393,7 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 		idx = __ffs(active_ints);
 
 		/* Reset interrupt flag by writing of 1 */
-		write_aux_reg(ARC_REG_PCT_INT_ACT, 1 << idx);
+		write_aux_reg(ARC_REG_PCT_INT_ACT, BIT(idx));
 
 		/*
 		 * On reset of "interrupt active" bit corresponding
@@ -400,7 +401,7 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 		 * Now we need to re-enable interrupt for the counter.
 		 */
 		write_aux_reg(ARC_REG_PCT_INT_CTRL,
-			read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
+			read_aux_reg(ARC_REG_PCT_INT_CTRL) | BIT(idx));
 
 		event = pmu_cpu->act_counter[idx];
 		hwc = &event->hw;
@@ -414,7 +415,7 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 				arc_pmu_stop(event, 0);
 		}
 
-		active_ints &= ~(1U << idx);
+		active_ints &= ~BIT(idx);
 	} while (active_ints);
 
 done:
@@ -450,10 +451,10 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 
 	union cc_name {
 		struct {
-			uint32_t word0, word1;
+			u32 word0, word1;
 			char sentinel;
 		} indiv;
-		char str[9];
+		char str[ARCPMU_EVENT_NAME_LEN];
 	} cc_name;
 
 
@@ -481,9 +482,9 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 
 	pr_info("ARC perf\t: %d counters (%d bits), %d conditions%s\n",
 		arc_pmu->n_counters, counter_size, cc_bcr.c,
-		has_interrupts ? ", [overflow IRQ support]":"");
+		has_interrupts ? ", [overflow IRQ support]" : "");
 
-	cc_name.str[8] = 0;
+	cc_name.str[ARCPMU_EVENT_NAME_LEN - 1] = 0;
 	for (i = 0; i < PERF_COUNT_ARC_HW_MAX; i++)
 		arc_pmu->ev_hw_idx[i] = -1;
 
@@ -538,14 +539,12 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	return perf_pmu_register(&arc_pmu->pmu, pdev->name, PERF_TYPE_RAW);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id arc_pmu_match[] = {
 	{ .compatible = "snps,arc700-pct" },
 	{ .compatible = "snps,archs-pct" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, arc_pmu_match);
-#endif
 
 static struct platform_driver arc_pmu_driver = {
 	.driver	= {
-- 
2.14.5

