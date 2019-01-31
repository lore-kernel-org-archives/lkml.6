Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B653BC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FC0218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuVrh7s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfAaKSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:18:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42297 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAaKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:18:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so1259875pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dpD6GILspJKb9dq2YCSAXaXUKmCuEOy+ng3uCFVpso=;
        b=LuVrh7s/d6yu1NaqBoU6BTrqkYZOd8PUvcMNFAepC11K86OFB9QaxehMC06BqTReU9
         BsfM3sXp20eXIm0hDbAK+3kPTQsDj4+PfxuX1WmDh/ld695i0TPeUeZucC2vBc8KKLBG
         YRgCqkrenpwkrOmn0uTGVsukIjOCwBWV3g7SHeJjYSHYE2pjs6QDoLb6BPZpwZEOpleY
         qhrKtwuOtxQcCZec8Fz952/uWnufLBV50u7kyfYbIOq228RIF6JMG0L6ocYMw67QTR8W
         c2k0R3cOBmFAfwGHEE2MNoq1Lid7tbHE7en+RHFXjdSQ+WUXPwA+2evF2D+wwvSYsbkB
         6myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dpD6GILspJKb9dq2YCSAXaXUKmCuEOy+ng3uCFVpso=;
        b=RC1DYYAb51hm66PiMwULNko4dh7Kgpje9Ehy3KP5wGOCxCfQxOu6yZbfZCzcsMCdWX
         VstCNv4cGMScnPPRaLFW9tjJN14NzC3BLUcWklScTywy9pg+xf8kmvsAWhgCODC6qUkq
         crFIPTE+Gg3tdxAZCHTzyBVuZP1xbLJAcQAvSbukJS9ZEjY89avBKB9ImzJY70ahkjWf
         JJvGsKiS8rXdFtVgEbgdcCyTdkSYRzVatitqvEkOhP4j/KVaXCbbEfDbEoSWNo6D57bM
         FFLDF+ILGDX0KDVmb172JvuDU9eqiLxwQy3chebUhav6xHEglbj22XWxQ5pe03YJdeys
         uNrA==
X-Gm-Message-State: AJcUukcZlQTqyPKBM4H6VKyzjrxOfIw86W3uVUVb9CCO3gku45Q+0x0b
        Ic1nqkVirWQFUbg1wkvcqhQ=
X-Google-Smtp-Source: ALg8bN6YBffs+ct3R23fBNNivDQ7X9zEQQM1t+py+kPFhPN/hNEV5OVn+CndWD16S6zPyMhkkARxCw==
X-Received: by 2002:a62:7a8b:: with SMTP id v133mr34854438pfc.159.1548929884530;
        Thu, 31 Jan 2019 02:18:04 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id p67sm5944830pfg.44.2019.01.31.02.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 02:18:03 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, joro@8bytes.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com
Subject: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date:   Thu, 31 Jan 2019 18:17:32 +0800
Message-Id: <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

On the bare metal, enabling X2APIC mode requires interrupt remapping
function which helps to deliver irq to cpu with 32-bit APIC ID.
Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
MSI protocol already supports to deliver interrupt to the CPU whose
virtual processor index is more than 255. IO-APIC interrupt still has
8-bit APIC ID limitation.

This patch is to add Hyper-V stub IOMMU driver in order to enable
X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
interrupt remapping capability when X2APIC mode is available. Otherwise,
it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 drivers/iommu/Kconfig         |   7 ++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/hyperv-iommu.c  | 189 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c |   3 +
 drivers/iommu/irq_remapping.h |   1 +
 5 files changed, 201 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 45d7021..5c397c0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -437,4 +437,11 @@ config QCOM_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
 
+config HYPERV_IOMMU
+	bool "Hyper-V stub IOMMU support"
+	depends on HYPERV
+	help
+	    Hyper-V stub IOMMU driver provides capability to run
+	    Linux guest with X2APIC mode enabled.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index a158a68..8c71a15 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
+obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
new file mode 100644
index 0000000..a64b747
--- /dev/null
+++ b/drivers/iommu/hyperv-iommu.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt)     "HYPERV-IR: " fmt
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+
+#include <asm/hw_irq.h>
+#include <asm/io_apic.h>
+#include <asm/irq_remapping.h>
+#include <asm/hypervisor.h>
+
+#include "irq_remapping.h"
+
+/*
+ * According IO-APIC spec, IO APIC has a 24-entry Interrupt
+ * Redirection Table.
+ */
+#define IOAPIC_REMAPPING_ENTRY 24
+
+static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
+struct irq_domain *ioapic_ir_domain;
+
+static int hyperv_ir_set_affinity(struct irq_data *data,
+		const struct cpumask *mask, bool force)
+{
+	struct irq_data *parent = data->parent_data;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	struct IO_APIC_route_entry *entry;
+	cpumask_t cpumask;
+	int ret;
+
+	cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
+
+	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
+	if (!cpumask_empty(&cpumask))
+		return -EINVAL;
+
+	ret = parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
+		return ret;
+
+	entry = data->chip_data;
+	entry->dest = cfg->dest_apicid;
+	entry->vector = cfg->vector;
+	send_cleanup_vector(cfg);
+
+	return 0;
+}
+
+static struct irq_chip hyperv_ir_chip = {
+	.name			= "HYPERV-IR",
+	.irq_ack		= apic_ack_irq,
+	.irq_set_affinity	= hyperv_ir_set_affinity,
+};
+
+static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs,
+				     void *arg)
+{
+	struct irq_alloc_info *info = arg;
+	struct IO_APIC_route_entry *entry;
+	struct irq_data *irq_data;
+	struct irq_desc *desc;
+	struct irq_cfg *cfg;
+	int ret = 0;
+
+	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
+		return -EINVAL;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		goto fail;
+
+	irq_data = irq_domain_get_irq_data(domain, virq);
+	cfg = irqd_cfg(irq_data);
+	if (!irq_data || !cfg) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	irq_data->chip = &hyperv_ir_chip;
+
+	/*
+	 * Save IOAPIC entry pointer here in order to set vector and
+	 * and dest_apicid in the hyperv_irq_remappng_activate()
+	 * and hyperv_ir_set_affinity(). IOAPIC driver ignores
+	 * cfg->dest_apicid and cfg->vector when irq remapping
+	 * mode is enabled. Detail see ioapic_configure_entry().
+	 */
+	irq_data->chip_data = entry = info->ioapic_entry;
+
+	/*
+	 * Hypver-V IO APIC irq affinity should be in the scope of
+	 * ioapic_max_cpumask because no irq remapping support.
+	 */
+	desc = irq_data_to_desc(irq_data);
+	cpumask_and(desc->irq_common_data.affinity,
+			desc->irq_common_data.affinity,
+			&ioapic_max_cpumask);
+
+ fail:
+	return ret;
+}
+
+static void hyperv_irq_remapping_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static int hyperv_irq_remappng_activate(struct irq_domain *domain,
+			  struct irq_data *irq_data, bool reserve)
+{
+	struct irq_cfg *cfg = irqd_cfg(irq_data);
+	struct IO_APIC_route_entry *entry = irq_data->chip_data;
+
+	entry->dest = cfg->dest_apicid;
+	entry->vector = cfg->vector;
+
+	return 0;
+}
+
+static struct irq_domain_ops hyperv_ir_domain_ops = {
+	.alloc = hyperv_irq_remapping_alloc,
+	.free = hyperv_irq_remapping_free,
+	.activate = hyperv_irq_remappng_activate,
+};
+
+static int __init hyperv_prepare_irq_remapping(void)
+{
+	struct fwnode_handle *fn;
+	u32 apic_id;
+	int i;
+
+	if (x86_hyper_type != X86_HYPER_MS_HYPERV ||
+	    !x2apic_supported())
+		return -ENODEV;
+
+	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
+	if (!fn)
+		return -EFAULT;
+
+	ioapic_ir_domain =
+		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
+				0, IOAPIC_REMAPPING_ENTRY, fn,
+				&hyperv_ir_domain_ops, NULL);
+
+	irq_domain_free_fwnode(fn);
+
+	/*
+	 * Hyper-V doesn't provide irq remapping function for
+	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
+	 * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
+	 * and set cpu into ioapic_max_cpumask if its APIC ID is less
+	 * than 255.
+	 */
+	for (i = 0; i < 256; i++) {
+		apic_id = cpu_physical_id(i);
+		if (apic_id > 255)
+			continue;
+
+		cpumask_set_cpu(i, &ioapic_max_cpumask);
+	}
+
+	return 0;
+}
+
+static int __init hyperv_enable_irq_remapping(void)
+{
+	return IRQ_REMAP_X2APIC_MODE;
+}
+
+static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
+{
+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
+		return ioapic_ir_domain;
+	else
+		return NULL;
+}
+
+struct irq_remap_ops hyperv_irq_remap_ops = {
+	.prepare		= hyperv_prepare_irq_remapping,
+	.enable			= hyperv_enable_irq_remapping,
+	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
+};
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index b94ebd4..81cf290 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
 	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
 		 amd_iommu_irq_ops.prepare() == 0)
 		remap_ops = &amd_iommu_irq_ops;
+	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
+		 hyperv_irq_remap_ops.prepare() == 0)
+		remap_ops = &hyperv_irq_remap_ops;
 	else
 		return -ENOSYS;
 
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 0afef6e..f8609e9 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -64,6 +64,7 @@ struct irq_remap_ops {
 
 extern struct irq_remap_ops intel_irq_remap_ops;
 extern struct irq_remap_ops amd_iommu_irq_ops;
+extern struct irq_remap_ops hyperv_irq_remap_ops;
 
 #else  /* CONFIG_IRQ_REMAP */
 
-- 
2.7.4

