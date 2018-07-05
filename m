Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7811C240E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O1kG2u7F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="al4zC+/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7811C240E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754447AbeGEUYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:24:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeGEUYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:24:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96ACE60A06; Thu,  5 Jul 2018 20:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822247;
        bh=dhev9XvX2qcFup6mlSCJqcQBLWR5CCiP08Tphfnl1/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1kG2u7FMvbPpKKEKrj2Vv1aKlr4RS+ck9wXZQmozj8kilUPRbhb3m+MuqY8dK1DN
         lIu88ROEhkBk2znMUlkCxW7I5CrY2jnZ/jmuhfIUm6cSBzVZNV9QR2aI2MADeMiQcL
         4Nq50ZhUgkUjy6hrZ2+p5UuKMb1ySi4/+N1/zYb4=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C383A60721;
        Thu,  5 Jul 2018 20:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822245;
        bh=dhev9XvX2qcFup6mlSCJqcQBLWR5CCiP08Tphfnl1/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al4zC+/EeWTowwNHVBKlWCax1+30xoWycNvyumTLFnBga0bVLMeboI2kCvxyukCqr
         KxrAqx8v8xM0QKrlZZLqinhUurpyVsTXjkkA7DGxg0ehRh5xGQdQGu5WLmaSI0EGej
         VocTADKgH6UlDR36iJDy7IlLWuKKLtrius1Kly0k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C383A60721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Phani Pabba <pabba@codeaurora.org>,
        Richard Ruigrok <rruigrok@codeaurora.org>,
        Vijaya Kilari <vkilari@codeaurora.org>,
        Jeff Hugo <jhugo@codeaurora.org>,
        Rahul Ramasubramanian <rahulr@codeaurora.org>,
        Agustin Vega-Frias <agustin.vega.frias@gmail.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [RFC V4 3/4] perf: qcom: Add PC capture support to CPU PMU
Date:   Thu,  5 Jul 2018 16:23:20 -0400
Message-Id: <1530822201-5890-4-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PC capture is an IMPLEMENTATION DEFINED extension to the ARMv8 PMUv3 that
allows more precise PC sampling by storing the PC in a separate system
register when an event counter overflow occurs. Reduces skid and allows
sampling when interrupts are disabled (since the PMI is a maskable interrupt
in arm64). Note that there is only one PC capture register so we only
allow one event at a time to use it.

Support for this extension is signaled by the presence of the Falkor or
Saphira PMU device node under a CPU device node in the DSDT ACPI table
containing the u8 _DSD property "qcom,pmu-pcc-support" set to non-zero.
E.g.:

    Device (CPU0)
    {
        Name (_HID, "ACPI0007" /* Processor Device */)
        ...
        Device (PMU0)
        {
            Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */
            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"qcom,pmu-pcc-support", 1},
                }
            })
        }
    }

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 arch/arm64/include/asm/perf_event.h |  18 ++
 arch/arm64/kernel/perf_event.c      |  18 --
 drivers/perf/Makefile               |   2 +-
 drivers/perf/qcom_arm_pmu.c         | 398 ++++++++++++++++++++++++++++++++++++
 include/linux/perf_event.h          |   4 +-
 5 files changed, 420 insertions(+), 20 deletions(-)
 create mode 100644 drivers/perf/qcom_arm_pmu.c

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index f9ccc36..76b95a3 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -24,6 +24,24 @@
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
 
 /*
+ * Perf Events' indices
+ */
+#define	ARMV8_IDX_CYCLE_COUNTER	0
+#define	ARMV8_IDX_COUNTER0	1
+#define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
+	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
+
+/*
+ * ARMv8 low level PMU access
+ */
+
+/*
+ * Perf Event to low level counters mapping
+ */
+#define	ARMV8_IDX_TO_COUNTER(x)	\
+	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
+
+/*
  * Per-CPU PMCR: config reg
  */
 #define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 33147aa..81b32fb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -457,24 +457,6 @@
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
-/*
- * Perf Events' indices
- */
-#define	ARMV8_IDX_CYCLE_COUNTER	0
-#define	ARMV8_IDX_COUNTER0	1
-#define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
-	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
-
-/*
- * ARMv8 low level PMU access
- */
-
-/*
- * Perf Event to low level counters mapping
- */
-#define	ARMV8_IDX_TO_COUNTER(x)	\
-	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
-
 static inline u32 armv8pmu_pmcr_read(void)
 {
 	return read_sysreg(pmcr_el0);
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b3902bd..a61afd9 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
 obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
-obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o qcom_arm_pmu.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
diff --git a/drivers/perf/qcom_arm_pmu.c b/drivers/perf/qcom_arm_pmu.c
new file mode 100644
index 0000000..5893b4c
--- /dev/null
+++ b/drivers/perf/qcom_arm_pmu.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Qualcomm Technologies CPU PMU IMPLEMENTATION DEFINED extensions support
+ *
+ * Current extensions supported:
+ *
+ * - PC capture (PCC):
+ *   Allows more precise PC sampling by storing the PC in a separate system
+ *   register when an event counter overflow occurs. Reduces skid and allows
+ *   sampling when interrupts are disabled (the PMI is a maskable interrupt
+ *   in arm64). Note that there is only one PC capture register so we only
+ *   allow one event at a time to use it.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/sysreg.h>
+
+#include <linux/perf/arm_pmu.h>
+
+/*
+ * Low-level PCC definitions
+ */
+
+#define PCCPTR_UNAUTH       BIT(0)
+#define PCCPTR_PC_MS_SP     BIT(55)
+#define PCCPTR_PC_MASK_SP   GENMASK_ULL(55,2)
+#define PCCPTR_SIGN_EXT_SP  GENMASK_ULL(63,56);
+#define PCC_CPT_PME0        BIT(0)
+#define PCC_CPT_EVENT_EN(x) (PCC_CPT_PME0 << (x))
+#define PCC_CPT_PMOVNEVT0   BIT(16)
+#define PCC_CPT_EVENT_OV(x) (PCC_CPT_PMOVNEVT0 << (x))
+#define QC_EVT_PCC_SHIFT    0
+#define QC_EVT_PCC_MASK     GENMASK(QC_EVT_PCC_SHIFT + 1, QC_EVT_PCC_SHIFT)
+#define QC_EVT_PCC(event)						\
+	(((event)->attr.config1 & QC_EVT_PCC_MASK) >> QC_EVT_PCC_SHIFT)
+
+struct pcc_ops {
+	/* Retrieve the PC from the IMP DEF pmpccptr_el0 register */
+	void (*read_pmpccptr_el0_pc)(u64 *pc);
+	/* Read/write the IMP DEF pmpccptcr0_el0 register */
+	u64 (*read_pmpccptcr0_el0)(void);
+	void (*write_pmpccptcr0_el0)(u64 val);
+};
+
+static struct arm_pmu *def_ops;
+static const struct pcc_ops *pcc_ops;
+
+/*
+ * Low-level Falkor operations
+ */
+
+static void falkor_read_pmpccptr_el0_pc(u64 *pc)
+{
+	u64 pcc = read_sysreg_s(sys_reg(3, 5, 11, 4, 0));
+
+	/*
+	 * Leave pc unchanged if we are not allowed to read the PC
+	 *  (e.g. if the overflow occurred in secure code)
+	 */
+	if (pcc & PCCPTR_UNAUTH)
+		return;
+
+	*pc = pcc;
+}
+
+static void falkor_write_pmpccptcr0_el0(u64 val)
+{
+	write_sysreg_s(val, sys_reg(3, 5, 11, 4, 1));
+}
+
+static u64 falkor_read_pmpccptcr0_el0(void)
+{
+	return read_sysreg_s(sys_reg(3, 5, 11, 4, 1));
+}
+
+static const struct pcc_ops falkor_pcc_ops = {
+	.read_pmpccptr_el0_pc = falkor_read_pmpccptr_el0_pc,
+	.read_pmpccptcr0_el0 = falkor_read_pmpccptcr0_el0,
+	.write_pmpccptcr0_el0 = falkor_write_pmpccptcr0_el0
+};
+
+/*
+ * Low-level Saphira operations
+ */
+
+static void saphira_read_pmpccptr_el0_pc(u64 *pc)
+{
+	u64 pcc = read_sysreg_s(sys_reg(3, 5, 11, 5, 0));
+
+	/*
+	 * Leave pc unchanged if we are not allowed to read the PC
+	 *  (e.g. if the overflow occurred in secure code)
+	 */
+	if (pcc & PCCPTR_UNAUTH)
+		return;
+
+	*pc = pcc & PCCPTR_PC_MASK_SP;
+	/* In Saphira we need to sign extend */
+	if (pcc & PCCPTR_PC_MS_SP)
+		*pc |= PCCPTR_SIGN_EXT_SP;
+}
+
+static void saphira_write_pmpccptcr0_el0(u64 val)
+{
+	write_sysreg_s(val, sys_reg(3, 5, 11, 5, 1));
+}
+
+static u64 saphira_read_pmpccptcr0_el0(void)
+{
+	return read_sysreg_s(sys_reg(3, 5, 11, 5, 1));
+}
+
+static const struct pcc_ops saphira_pcc_ops = {
+	.read_pmpccptr_el0_pc = saphira_read_pmpccptr_el0_pc,
+	.read_pmpccptcr0_el0 = saphira_read_pmpccptcr0_el0,
+	.write_pmpccptcr0_el0 = saphira_write_pmpccptcr0_el0
+};
+
+/*
+ * Check if the given event uses PCC
+ */
+static bool has_pcc(struct perf_event *event)
+{
+	/* PCC not enabled */
+	if (!pcc_ops)
+		return false;
+
+	/* PCC only used for sampling events */
+	if (!is_sampling_event(event))
+		return false;
+
+	/*
+	 * PCC only used without callchain because software callchain might
+	 * provide misleading entries
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		return false;
+
+	return QC_EVT_PCC(event);
+}
+
+/*
+ * Check if the given event is for the raw or dynamic PMU type
+ */
+static inline bool is_raw_or_dynamic(struct perf_event *event)
+{
+	int type = event->attr.type;
+
+	return (type == PERF_TYPE_RAW) || (type == event->pmu->type);
+}
+
+/*
+ * Check if e1 and e2 conflict with each other
+ *
+ * e1 is an event that has extensions and we are checking against e2.
+ */
+static inline bool events_conflict(struct perf_event *e1, struct perf_event *e2)
+{
+	int type = e2->attr.type;
+	int dynamic = e1->pmu->type;
+
+	/* Same event? */
+	if (e1 == e2)
+		return false;
+
+	/* Other PMU that is not the RAW or this PMU's dynamic type? */
+	if ((e1->pmu != e2->pmu) && (type != PERF_TYPE_RAW) && (type != dynamic))
+		return false;
+
+	/* No conflict if using different pcc or if pcc is not enabled */
+	if (pcc_ops && is_sampling_event(e2) && (QC_EVT_PCC(e1) == QC_EVT_PCC(e2))) {
+		pr_debug_ratelimited("PCC exclusion: conflicting events %llx %llx\n",
+				     e1->attr.config,
+				     e2->attr.config);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Handle a PCC event overflow
+ *
+ * No extra checks needed here since we do all of that during map, event_idx,
+ * and enable. We only let one PCC event per-CPU pass-through to this.
+ */
+static void pcc_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+	u64 irq_pc = regs->pc;
+
+	/* Override with hardware PC */
+	pcc_ops->read_pmpccptr_el0_pc(&regs->pc);
+
+	/* Let the original handler finish the operation */
+	event->orig_overflow_handler(event, data, regs);
+
+	/* Restore */
+	regs->pc = irq_pc;
+}
+
+/*
+ * Check if the given event is valid for the PMU and if so return the value
+ * that can be used in PMXEVTYPER_EL0 to select the event
+ */
+static int qcom_arm_pmu_map_event(struct perf_event *event)
+{
+	if (is_raw_or_dynamic(event) && has_pcc(event)) {
+		struct perf_event *leader;
+		struct perf_event *sibling;
+
+		/* Check if the event is compatible with its group */
+		leader = event->group_leader;
+		if (events_conflict(event, leader))
+			return -ENOENT;
+
+		for_each_sibling_event(sibling, leader)
+			if (events_conflict(event, sibling))
+				return -ENOENT;
+	}
+
+	return def_ops->map_event(event);
+}
+
+/*
+ * Find a slot for the event on the current CPU
+ */
+static int qcom_arm_pmu_get_event_idx(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	int idx;
+
+	if (is_raw_or_dynamic(event) && has_pcc(event)) {
+		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+		int idx;
+
+		/* Check for conflicts with existing events */
+		for_each_set_bit(idx, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
+			if (cpuc->events[idx] &&
+			    events_conflict(event, cpuc->events[idx]))
+				return -ENOENT;
+
+		/*
+		 * PCC is requested for this event so we need to use an event
+		 * counter even for the cycle counter (PCC does not work with
+		 * the dedicated cycle counter).
+		 */
+		for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
+			if (!test_and_set_bit(idx, cpuc->used_mask))
+				return idx;
+		}
+
+		/* The counters are all in use. */
+		return -EAGAIN;
+	}
+
+	/* Let the original op handle the rest */
+	idx = def_ops->get_event_idx(cpuc, event);
+
+	/*
+	 * This is called for actually allocating the events, but also with
+	 * a dummy pmu_hw_events when validating groups, for that case we
+	 * need to ensure that cpuc->events[idx] is NULL so we don't use
+	 * an uninitialized pointer. Conflicts for matrix events in groups
+	 * are checked during event mapping anyway (see falkor_event_map).
+	 */
+	cpuc->events[idx] = NULL;
+
+	return idx;
+}
+
+/*
+ * Enable the given event
+ */
+static void qcom_arm_pmu_enable(struct perf_event *event)
+{
+	if (has_pcc(event)) {
+		int idx = event->hw.idx;
+		u32 pcc = PCC_CPT_EVENT_EN(ARMV8_IDX_TO_COUNTER(idx)) |
+			  PCC_CPT_EVENT_OV(ARMV8_IDX_TO_COUNTER(idx));
+
+		pcc_ops->write_pmpccptcr0_el0(pcc);
+		event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
+		WRITE_ONCE(event->overflow_handler, pcc_overflow_handler);
+	}
+
+	/* Let the original op handle the rest */
+	def_ops->enable(event);
+}
+
+/*
+ * Disable the given event
+ */
+static void qcom_arm_pmu_disable(struct perf_event *event)
+{
+	/* Use the original op to disable the counter and interrupt  */
+	def_ops->enable(event);
+
+	if (has_pcc(event)) {
+		int idx = event->hw.idx;
+		u32 pcc = pcc_ops->read_pmpccptcr0_el0();
+
+		pcc &= ~(PCC_CPT_EVENT_EN(ARMV8_IDX_TO_COUNTER(idx)) |
+			 PCC_CPT_EVENT_OV(ARMV8_IDX_TO_COUNTER(idx)));
+		pcc_ops->write_pmpccptcr0_el0(pcc);
+		if (event->orig_overflow_handler)
+			WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
+	}
+}
+
+PMU_FORMAT_ATTR(event, "config:0-15");
+PMU_FORMAT_ATTR(pcc,   "config1:0");
+
+static struct attribute *pmu_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_pcc.attr,
+	NULL,
+};
+
+static struct attribute_group pmu_format_attr_group = {
+	.name = "format",
+	.attrs = pmu_formats,
+};
+
+static inline bool pcc_supported(struct device *dev)
+{
+	u8 pcc = 0;
+
+	acpi_node_prop_read(dev->fwnode, "qcom,pmu-pcc-support",
+			    DEV_PROP_U8, &pcc, 1);
+	return pcc != 0;
+}
+
+static int qcom_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	/* Save base arm_pmu so we can invoke its ops when appropriate */
+	def_ops = devm_kmemdup(dev, pmu, sizeof(*def_ops), GFP_KERNEL);
+	if (!def_ops) {
+		pr_warn("Failed to allocate arm_pmu for QCOM extensions");
+		return -ENODEV;
+	}
+
+	pmu->name = "qcom_pmuv3";
+
+	/* Override the necessary ops */
+	pmu->map_event     = qcom_arm_pmu_map_event;
+	pmu->get_event_idx = qcom_arm_pmu_get_event_idx;
+	pmu->enable        = qcom_arm_pmu_enable;
+	pmu->disable       = qcom_arm_pmu_disable;
+
+	/* Override the necessary attributes */
+	pmu->pmu.attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&pmu_format_attr_group;
+
+	return 1;
+}
+
+static int qcom_falkor_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	if (pcc_supported(dev))
+		pcc_ops = &falkor_pcc_ops;
+	else
+		return -ENODEV;
+
+	return qcom_pmu_init(pmu, dev);
+}
+
+static int qcom_saphira_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	if (pcc_supported(dev))
+		pcc_ops = &saphira_pcc_ops;
+	else
+		return -ENODEV;
+
+	return qcom_pmu_init(pmu, dev);
+}
+
+ACPI_DECLARE_PMU_VARIANT(qcom_falkor,  "QCOM8150", qcom_falkor_pmu_init);
+ACPI_DECLARE_PMU_VARIANT(qcom_saphira, "QCOM8151", qcom_saphira_pmu_init);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1fa1288..ae204d1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -677,8 +677,10 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-#ifdef CONFIG_BPF_SYSCALL
+#if defined(CONFIG_BPF_SYSCALL) || defined(CONFIG_ARM_PMU_ACPI)
 	perf_overflow_handler_t		orig_overflow_handler;
+#endif
+#ifdef CONFIG_BPF_SYSCALL
 	struct bpf_prog			*prog;
 #endif
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

