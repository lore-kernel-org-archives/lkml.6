Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94336C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEBD240E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I2nTKUzF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iANpliKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEBD240E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeGEUYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:24:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754337AbeGEUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:24:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D306360B3B; Thu,  5 Jul 2018 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822249;
        bh=5Wz6NRt9+Pf+ZMLb4EZ8ghmJ0oOanhuULUy77I2zVn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2nTKUzFcQmMGHAE/GJBazCpaL4wBBH8EkS/IKZ8jHhl2TASvpHjbdaPLX/X3iPgX
         B8TfcE1zC1MQMytBJOZSi1n1FxR40xNUUHXd/xDhywNv92ccnSfsJuaU3AXgrBT5og
         Y4pHydOtYN67uOvuYl7J2s0neb+ZQGONOibMc71Q=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C100B60B73;
        Thu,  5 Jul 2018 20:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822247;
        bh=5Wz6NRt9+Pf+ZMLb4EZ8ghmJ0oOanhuULUy77I2zVn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iANpliKkCvV9nckLnWraZGqegUME87FaOeV9c1OQj8Dxqt07ZEoTLP4CAkrOvyZ+4
         fW+kTW3lpkyaKkvU9IllJIQur3GKvnw/mba7VLcQCd5Fq/296EMCQxVJE1bNDbx+MW
         X55V3yFjz6FB/wOcflwOtFFFujbf9cIBBqju+5RA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C100B60B73
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
Subject: [RFC V4 4/4] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION DEFINED event support
Date:   Thu,  5 Jul 2018 16:23:21 -0400
Message-Id: <1530822201-5890-5-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selection of these events can be envisioned as indexing them from
a 3D matrix:
- the first index selects a Region Event Selection Register (PMRESRx_EL0)
- the second index selects a group from which only one event at a time
  can be selected
- the third index selects the event

These events are encoded into perf_event_attr as:
  mbe      [config1:1   ]  (flag that indicates a matrix-based event)
  reg      [config:12-15]  (specifies the PMRESRx_EL0 instance)
  group    [config:0-3  ]  (specifies the event group)
  code     [config:4-11 ]  (specifies the event)

Events with the mbe flag set to zero are treated as common or raw PMUv3
events and are handled by the base PMUv3 driver code.

The first two indexes are set combining the RESR and group number with
a base number and writing it into the architected PMXEVTYPER_EL0 register.
The third index is set by writing the code into the bits corresponding
with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
register.

Support for this extension is signaled by the presence of the Falkor PMU
device node under each Falkor CPU device node in the DSDT ACPI table. E.g.:

    Device (CPU0)
    {
        Name (_HID, "ACPI0007" /* Processor Device */)
        ...
        Device (PMU0)
        {
            Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */
            ...
        }
    }

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/perf/qcom_arm_pmu.c | 306 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 287 insertions(+), 19 deletions(-)

diff --git a/drivers/perf/qcom_arm_pmu.c b/drivers/perf/qcom_arm_pmu.c
index 5893b4c..6dae1152 100644
--- a/drivers/perf/qcom_arm_pmu.c
+++ b/drivers/perf/qcom_arm_pmu.c
@@ -22,6 +22,30 @@
  *   sampling when interrupts are disabled (the PMI is a maskable interrupt
  *   in arm64). Note that there is only one PC capture register so we only
  *   allow one event at a time to use it.
+ *
+ * - Matrix-based microarchitectural events support
+ *
+ *   Selection of these events can be envisioned as indexing them from
+ *   a 3D matrix:
+ *   - the first index selects a Region Event Selection Register (PMRESRx_EL0)
+ *   - the second index selects a group from which only one event at a time
+ *     can be selected
+ *   - the third index selects the event
+ *
+ *   These events are encoded into perf_event_attr as:
+ *     mbe      [config1:1   ]  (flag that indicates a matrix-based event)
+ *     reg      [config:12-15]  (specifies the PMRESRx_EL0 instance)
+ *     group    [config:0-3  ]  (specifies the event group)
+ *     code     [config:4-11 ]  (specifies the event)
+ *
+ *   Events with the mbe flag set to zero are treated as common or raw PMUv3
+ *   events and are handled by the base PMUv3 driver code.
+ *
+ *   The first two indexes are set combining the RESR and group number with a
+ *   base number and writing it into the architected PMXEVTYPER_EL0.evtCount.
+ *   The third index is set by writing the code into the bits corresponding
+ *   with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
+ *   register.
  */
 
 #include <linux/acpi.h>
@@ -61,8 +85,54 @@ struct pcc_ops {
 	void (*write_pmpccptcr0_el0)(u64 val);
 };
 
+/*
+ * Low-level MBE definitions
+ */
+
+#define pmresr0_el0         sys_reg(3, 5, 11, 3, 0)
+#define pmresr1_el0         sys_reg(3, 5, 11, 3, 2)
+#define pmresr2_el0         sys_reg(3, 5, 11, 3, 4)
+#define pmxevcntcr_el0      sys_reg(3, 5, 11, 0, 3)
+
+#define QC_EVT_MBE_SHIFT    1
+#define QC_EVT_REG_SHIFT    12
+#define QC_EVT_CODE_SHIFT   4
+#define QC_EVT_GRP_SHIFT    0
+#define QC_EVT_MBE_MASK     GENMASK(QC_EVT_MBE_SHIFT + 1,  QC_EVT_MBE_SHIFT)
+#define QC_EVT_REG_MASK     GENMASK(QC_EVT_REG_SHIFT + 3,  QC_EVT_REG_SHIFT)
+#define QC_EVT_CODE_MASK    GENMASK(QC_EVT_CODE_SHIFT + 7, QC_EVT_CODE_SHIFT)
+#define QC_EVT_GRP_MASK     GENMASK(QC_EVT_GRP_SHIFT + 3,  QC_EVT_GRP_SHIFT)
+#define QC_EVT_RG_MASK      (QC_EVT_REG_MASK | QC_EVT_GRP_MASK)
+#define QC_EVT_RG(event)    ((event)->attr.config & QC_EVT_RG_MASK)
+#define QC_EVT_MBE(event)						\
+	(((event)->attr.config1 & QC_EVT_MBE_MASK) >> QC_EVT_MBE_SHIFT)
+#define QC_EVT_REG(event)						\
+	(((event)->attr.config & QC_EVT_REG_MASK) >> QC_EVT_REG_SHIFT)
+#define QC_EVT_CODE(event)						\
+	(((event)->attr.config & QC_EVT_CODE_MASK) >> QC_EVT_CODE_SHIFT)
+#define QC_EVT_GROUP(event)						\
+	(((event)->attr.config & QC_EVT_GRP_MASK) >> QC_EVT_GRP_SHIFT)
+
+#define QC_MAX_GROUP        7
+#define QC_MAX_RESR         2
+#define QC_BITS_PER_GROUP   8
+#define QC_RESR_ENABLE      BIT_ULL(63)
+#define QC_RESR_EVT_BASE    0xd8
+
+struct mbe_ops {
+	/* Enable a MBE event */
+	void (*enable)(struct perf_event *event);
+	/* Enable a MBE event */
+	void (*disable)(struct perf_event *event);
+};
+
+/*
+ * Common state
+ */
+
 static struct arm_pmu *def_ops;
 static const struct pcc_ops *pcc_ops;
+static const struct mbe_ops *mbe_ops;
 
 /*
  * Low-level Falkor operations
@@ -92,12 +162,84 @@ static u64 falkor_read_pmpccptcr0_el0(void)
 	return read_sysreg_s(sys_reg(3, 5, 11, 4, 1));
 }
 
+static inline void falkor_write_pmresr(u64 reg, u64 val)
+{
+	switch (reg) {
+	case 0:
+		write_sysreg_s(val, pmresr0_el0);
+		return;
+	case 1:
+		write_sysreg_s(val, pmresr1_el0);
+		return;
+	default:
+		write_sysreg_s(val, pmresr2_el0);
+		return;
+	}
+}
+
+static inline u64 falkor_read_pmresr(u64 reg)
+{
+	switch (reg) {
+	case 0:
+		return read_sysreg_s(pmresr0_el0);
+	case 1:
+		return read_sysreg_s(pmresr1_el0);
+	default:
+		return read_sysreg_s(pmresr2_el0);
+	}
+}
+
+static void falkor_set_resr(u64 reg, u64 group, u64 code)
+{
+	u64 shift = group * QC_BITS_PER_GROUP;
+	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
+	u64 val;
+
+	val = falkor_read_pmresr(reg) & ~mask;
+	val |= (code << shift);
+	val |= QC_RESR_ENABLE;
+	falkor_write_pmresr(reg, val);
+}
+
+static void falkor_clear_resr(u64 reg, u64 group)
+{
+	u32 shift = group * QC_BITS_PER_GROUP;
+	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
+	u64 val = falkor_read_pmresr(reg) & ~mask;
+
+	falkor_write_pmresr(reg, val == QC_RESR_ENABLE ? 0 : val);
+}
+
+static void falkor_mbe_enable(struct perf_event *event)
+{
+	/* Program the appropriate PMRESRx_EL0 */
+	u64 reg = QC_EVT_REG(event);
+	u64 code = QC_EVT_CODE(event);
+	u64 group = QC_EVT_GROUP(event);
+
+	falkor_set_resr(reg, group, code);
+}
+
+static void falkor_mbe_disable(struct perf_event *event)
+{
+	/* De-program the appropriate PMRESRx_EL0 */
+	u64 reg = QC_EVT_REG(event);
+	u64 group = QC_EVT_GROUP(event);
+
+	falkor_clear_resr(reg, group);
+}
+
 static const struct pcc_ops falkor_pcc_ops = {
 	.read_pmpccptr_el0_pc = falkor_read_pmpccptr_el0_pc,
 	.read_pmpccptcr0_el0 = falkor_read_pmpccptcr0_el0,
 	.write_pmpccptcr0_el0 = falkor_write_pmpccptcr0_el0
 };
 
+static const struct mbe_ops falkor_mbe_ops = {
+	.enable = falkor_mbe_enable,
+	.disable = falkor_mbe_disable
+};
+
 /*
  * Low-level Saphira operations
  */
@@ -159,6 +301,18 @@ static bool has_pcc(struct perf_event *event)
 }
 
 /*
+ * Check if the given event uses MBE
+ */
+static bool has_mbe(struct perf_event *event)
+{
+	/* MBE not enabled */
+	if (!mbe_ops)
+		return false;
+
+	return QC_EVT_MBE(event);
+}
+
+/*
  * Check if the given event is for the raw or dynamic PMU type
  */
 static inline bool is_raw_or_dynamic(struct perf_event *event)
@@ -169,6 +323,56 @@ static inline bool is_raw_or_dynamic(struct perf_event *event)
 }
 
 /*
+ * Check if e1 and e2 have conflicting PCC settings
+ */
+static inline bool pcc_conflict(struct perf_event *e1, struct perf_event *e2)
+{
+	bool pcc1 = has_pcc(e1), pcc2= has_pcc(e2);
+
+	/* No conflict if none of the events is using PCC */
+	if (!pcc1 && !pcc2)
+		return false;
+
+	/* No conflict if one of the events is not using PCC */
+	if (pcc1 != pcc2)
+		return false;
+
+	pr_warn_ratelimited("PCC exclusion: conflicting events %llx %llx\n",
+			     e1->attr.config,
+			     e2->attr.config);
+	return true;
+}
+
+/*
+ * Check if e1 and e2 have conflicting MBE settings
+ */
+static inline bool mbe_conflict(struct perf_event *e1, struct perf_event *e2)
+{
+	bool mbe1 = has_mbe(e1), mbe2= has_mbe(e2);
+
+	/* No conflict if none of the events is using MBE */
+	if (!mbe1 && !mbe2)
+		return false;
+
+	/* No conflict if one of the events is not using MBE */
+	if (mbe1 != mbe2)
+		return false;
+
+	/* No conflict if using different reg or group */
+	if (QC_EVT_RG(e1) != QC_EVT_RG(e2))
+		return false;
+
+	/* Same mbe, reg and group is fine so long as code matches */
+	if (QC_EVT_CODE(e1) == QC_EVT_CODE(e2))
+		return false;
+
+	pr_warn_ratelimited("Group exclusion: conflicting events %llx %llx\n",
+			     e1->attr.config,
+			     e2->attr.config);
+	return true;
+}
+
+/*
  * Check if e1 and e2 conflict with each other
  *
  * e1 is an event that has extensions and we are checking against e2.
@@ -186,15 +390,7 @@ static inline bool events_conflict(struct perf_event *e1, struct perf_event *e2)
 	if ((e1->pmu != e2->pmu) && (type != PERF_TYPE_RAW) && (type != dynamic))
 		return false;
 
-	/* No conflict if using different pcc or if pcc is not enabled */
-	if (pcc_ops && is_sampling_event(e2) && (QC_EVT_PCC(e1) == QC_EVT_PCC(e2))) {
-		pr_debug_ratelimited("PCC exclusion: conflicting events %llx %llx\n",
-				     e1->attr.config,
-				     e2->attr.config);
-		return true;
-	}
-
-	return false;
+	return pcc_conflict(e1, e2) || mbe_conflict(e1, e2);;
 }
 
 /*
@@ -225,7 +421,10 @@ static void pcc_overflow_handler(struct perf_event *event,
  */
 static int qcom_arm_pmu_map_event(struct perf_event *event)
 {
-	if (is_raw_or_dynamic(event) && has_pcc(event)) {
+	if (!is_raw_or_dynamic(event))
+		goto done;
+
+	if (has_pcc(event) || has_mbe(event)) {
 		struct perf_event *leader;
 		struct perf_event *sibling;
 
@@ -239,6 +438,16 @@ static int qcom_arm_pmu_map_event(struct perf_event *event)
 				return -ENOENT;
 	}
 
+	if (has_mbe(event)) {
+		u64 reg = QC_EVT_REG(event);
+		u64 group = QC_EVT_GROUP(event);
+
+		if ((group > QC_MAX_GROUP) || (reg > QC_MAX_RESR))
+			return -ENOENT;
+		return QC_RESR_EVT_BASE + reg * 8 + group;
+	}
+
+done:
 	return def_ops->map_event(event);
 }
 
@@ -249,15 +458,20 @@ static int qcom_arm_pmu_get_event_idx(struct pmu_hw_events *cpuc, struct perf_ev
 {
 	int idx;
 
-	if (is_raw_or_dynamic(event) && has_pcc(event)) {
-		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-		int idx;
+	if (!is_raw_or_dynamic(event))
+		goto done;
 
+	if (has_pcc(event) || has_mbe(event)) {
 		/* Check for conflicts with existing events */
 		for_each_set_bit(idx, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
 			if (cpuc->events[idx] &&
 			    events_conflict(event, cpuc->events[idx]))
 				return -ENOENT;
+	}
+
+	if (has_pcc(event)) {
+		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+		int idx;
 
 		/*
 		 * PCC is requested for this event so we need to use an event
@@ -273,6 +487,7 @@ static int qcom_arm_pmu_get_event_idx(struct pmu_hw_events *cpuc, struct perf_ev
 		return -EAGAIN;
 	}
 
+done:
 	/* Let the original op handle the rest */
 	idx = def_ops->get_event_idx(cpuc, event);
 
@@ -303,6 +518,9 @@ static void qcom_arm_pmu_enable(struct perf_event *event)
 		WRITE_ONCE(event->overflow_handler, pcc_overflow_handler);
 	}
 
+	if (has_mbe(event))
+		mbe_ops->enable(event);
+
 	/* Let the original op handle the rest */
 	def_ops->enable(event);
 }
@@ -325,20 +543,59 @@ static void qcom_arm_pmu_disable(struct perf_event *event)
 		if (event->orig_overflow_handler)
 			WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	}
+
+	if (has_mbe(event))
+		mbe_ops->disable(event);
+}
+
+/*
+ * Reset the PMU
+ */
+static void qcom_arm_pmu_falkor_reset(void *info)
+{
+	struct arm_pmu *pmu = (struct arm_pmu *)info;
+	u32 i, ctrs = pmu->num_events;
+
+	/* PMRESRx_EL0 regs are unknown at reset, except for the EN field */
+	for (i = 0; i <= QC_MAX_RESR; i++)
+		falkor_write_pmresr(i, 0);
+
+	/* PMXEVCNTCRx_EL0 regs are unknown at reset */
+	for (i = 0; i <= ctrs; i++) {
+		write_sysreg(i, pmselr_el0);
+		isb();
+		write_sysreg_s(0, pmxevcntcr_el0);
+	}
+
+	/* Let the original op handle the rest */
+	def_ops->reset(info);
 }
 
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(pcc,   "config1:0");
+PMU_FORMAT_ATTR(mbe,   "config1:1");
+PMU_FORMAT_ATTR(reg,   "config:12-15");
+PMU_FORMAT_ATTR(code,  "config:4-11");
+PMU_FORMAT_ATTR(group, "config:0-3");
 
-static struct attribute *pmu_formats[] = {
+static struct attribute *falkor_pmu_formats[] = {
+	&format_attr_pcc.attr,
 	&format_attr_event.attr,
+	&format_attr_mbe.attr,
+	&format_attr_reg.attr,
+	&format_attr_code.attr,
+	&format_attr_group.attr,
+	NULL,
+};
+
+static struct attribute *saphira_pmu_formats[] = {
 	&format_attr_pcc.attr,
+	&format_attr_event.attr,
 	NULL,
 };
 
 static struct attribute_group pmu_format_attr_group = {
 	.name = "format",
-	.attrs = pmu_formats,
 };
 
 static inline bool pcc_supported(struct device *dev)
@@ -376,12 +633,21 @@ static int qcom_pmu_init(struct arm_pmu *pmu, struct device *dev)
 
 static int qcom_falkor_pmu_init(struct arm_pmu *pmu, struct device *dev)
 {
-	if (pcc_supported(dev))
+	int result;
+
+	if (pcc_supported(dev)) {
+		pmu_format_attr_group.attrs = falkor_pmu_formats;
 		pcc_ops = &falkor_pcc_ops;
-	else
-		return -ENODEV;
+	} else {
+		pmu_format_attr_group.attrs = &falkor_pmu_formats[1];
+	}
 
-	return qcom_pmu_init(pmu, dev);
+	mbe_ops = &falkor_mbe_ops;
+
+	result = qcom_pmu_init(pmu, dev);
+	pmu->reset = qcom_arm_pmu_falkor_reset;
+
+	return result;
 }
 
 static int qcom_saphira_pmu_init(struct arm_pmu *pmu, struct device *dev)
@@ -391,6 +657,8 @@ static int qcom_saphira_pmu_init(struct arm_pmu *pmu, struct device *dev)
 	else
 		return -ENODEV;
 
+	pmu_format_attr_group.attrs = saphira_pmu_formats;
+
 	return qcom_pmu_init(pmu, dev);
 }
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

