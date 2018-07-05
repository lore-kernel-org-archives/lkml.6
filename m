Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4945DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED33240E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nubuC2S5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oA/3wN1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED33240E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeGEUYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:24:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754249AbeGEUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:24:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B991A60B3B; Thu,  5 Jul 2018 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822244;
        bh=OBHgcJFOv9Bk28E1jaGgOK2JWySXSYTAWmdAIGT38Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nubuC2S5jDjLPtz4s3ToPkl7Frj1KIhd0h/PcyoCNaY8qUno1ZDQseTKklj0yE1rG
         qD0cTeUmS+iEkEJDvc5G2/yWSHkrkgGdgbMWv387zUIkYpao9ZOr2OjT2yIJ1CpB+K
         bX8kPiBShoxtp5iMUNUzdBEuNVKPGJeWWjL3gxe0=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E34F060B3B;
        Thu,  5 Jul 2018 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822243;
        bh=OBHgcJFOv9Bk28E1jaGgOK2JWySXSYTAWmdAIGT38Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oA/3wN1URyb+s/ySGlcUeZTGN4Xrl2h7xqI91vknv+XKRkEcZxl2knQboJ9S75tyE
         jwEbnZTeMnyMdVXuiBIqRH0L/AHr+MtqDfv6Y7gmR6MSVtUYv0T5gkkP3ymVHm54y3
         nVBP5Vb3aFaqNAt7qASyQlLpqFRBRT11bIOB568c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E34F060B3B
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
Subject: [RFC V4 2/4] arm_pmu: acpi: add support for CPU PMU variant detection
Date:   Thu,  5 Jul 2018 16:23:19 -0400
Message-Id: <1530822201-5890-3-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT allows CPU PMU variant detection via the PMU device compatible
property. ACPI does not have an equivalent mechanism so we introduce
a probe table to allow this via a device nested inside the CPU device
in the DSDT:

Device (CPU0)
{
    Name (_HID, "ACPI0007" /* Processor Device */)
    ...
    Device (PMU0)
    {
        Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */

        /*
         * The device might also contain _DSD properties to indicate other
         * IMPLEMENTATION DEFINED PMU features.
         */
        Name (_DSD, Package ()
        {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                ...
            }
        })
    }
}

With this in place we can declare the variant:

    ACPI_DECLARE_PMU_VARIANT(qcom_falkor, "QCOM8150", falkor_pmu_init);

The init function is called after the default PMU initialization and is
passed a pointer to the arm_pmu structure and a pointer to the PMU device.
The init function can then override arm_pmu callbacks and attributes and
query more properties from the PMU device.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/perf/arm_pmu_acpi.c       | 27 +++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/acpi.h              | 11 +++++++++++
 include/linux/perf/arm_pmu.h      |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f19751..6b0ca71 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -220,6 +220,26 @@ static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Check if the given child device of the CPU device matches a PMU variant
+ * device declared with ACPI_DECLARE_PMU_VARIANT, if so, pass the arm_pmu
+ * structure and the matching device for further initialization.
+ */
+static int arm_pmu_variant_init(struct device *dev, void *data)
+{
+	extern struct acpi_device_id ACPI_PROBE_TABLE(pmu);
+	unsigned int cpu = *((unsigned int *)data);
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(&ACPI_PROBE_TABLE(pmu), dev);
+	if (id) {
+		armpmu_acpi_init_fn fn = (armpmu_acpi_init_fn)id->driver_data;
+
+		return fn(per_cpu(probed_pmus, cpu), dev);
+	}
+	return 0;
+}
+
 int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 {
 	int pmu_idx = 0;
@@ -240,6 +260,7 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct arm_pmu *pmu = per_cpu(probed_pmus, cpu);
+		struct device *dev = get_cpu_device(cpu);
 		char *base_name;
 
 		if (!pmu || pmu->name)
@@ -254,6 +275,10 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 			return ret;
 		}
 
+		ret = device_for_each_child(dev, &cpu, arm_pmu_variant_init);
+		if (ret == -ENODEV)
+			pr_warn("Failed PMU re-init, fallback to plain PMUv3");
+
 		base_name = pmu->name;
 		pmu->name = kasprintf(GFP_KERNEL, "%s_%d", base_name, pmu_idx++);
 		if (!pmu->name) {
@@ -290,3 +315,5 @@ static int arm_pmu_acpi_init(void)
 	return ret;
 }
 subsys_initcall(arm_pmu_acpi_init)
+
+ACPI_DECLARE_PMU_SENTINEL();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ec0411..03d1673 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -609,6 +609,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
+	ACPI_PROBE_TABLE(pmu)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e54f409..99c6698 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1158,6 +1158,17 @@ struct acpi_probe_entry {
 					  (&ACPI_PROBE_TABLE_END(t) -	\
 					   &ACPI_PROBE_TABLE(t)));	\
 	})
+
+#define ACPI_DECLARE_PMU_VARIANT(name, hid, init_fn)			\
+	static const struct acpi_device_id __acpi_probe_##name		\
+		__used __section(__pmu_acpi_probe_table)		\
+		= { .id = hid, .driver_data = (kernel_ulong_t)init_fn }
+
+#define ACPI_DECLARE_PMU_SENTINEL()					\
+	static const struct acpi_device_id __acpi_probe_sentinel	\
+		__used __section(__pmu_acpi_probe_table_end)		\
+		= { .id = "", .driver_data = 0 }
+
 #else
 static inline int acpi_dev_get_property(struct acpi_device *adev,
 					const char *name, acpi_object_type type,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index ad54444..b02ac52 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -123,6 +123,7 @@ int armpmu_map_event(struct perf_event *event,
 		     u32 raw_event_mask);
 
 typedef int (*armpmu_init_fn)(struct arm_pmu *);
+typedef int (*armpmu_acpi_init_fn)(struct arm_pmu *, struct device *);
 
 struct pmu_probe_info {
 	unsigned int cpuid;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

