Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B3CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D4420818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXe39P8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfBKOVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33853 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfBKOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:20:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so5391752plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q4aWZgMD5VGKsgz8xC0bY1+qrbZ/LtBKEzeolnm21YI=;
        b=KXe39P8cbzSemdo4lWGOEVy7i2w+IucBx8zLJgFLssKG97a1/1cXqh54ynqls9kU4P
         6Vl3EcvNn5Y5L11pMriLvsoiLtt6X3u/1WOsAZ3gW6kjj/8YzJ9GizoPFaBFRxuC61Au
         Ly6PnFZG1I0hv2pM6PexbwpV41155bS5W25sxg/AMdyhVP9V7hjIXWnuxw6375alB6tM
         kkRDs9AWEzaG0keZbOeHpNAILXGmS2iY6ATaBIJwfpTJLK/efU4qyEVG3OngVbtSlCEE
         3oSGnjDoT/8Gs5mJIp53NoLH65nmoEC1dTysRYljGZFBZ2fDdWK8Kqmrbflan5kC/iIY
         /NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q4aWZgMD5VGKsgz8xC0bY1+qrbZ/LtBKEzeolnm21YI=;
        b=e+0BpZdie3qVkE572P7vdCd9rZ+B4i4fB20b9eJ/uqpHogH4zUpxf+J1k8U/X6gYvM
         Iu+Ag7o9Wj/y2MaAv+VQ4P6ifT4L1aXjmRXCeplCCAd1AOTaL6Wud1hIEWSV0UHJ+obi
         PBPw1HFSsH1uARu9yt8mKjTKGxBwD8cpOm/KLE6xkVit8O5ZcXmFEb6MV1Xh+J4nN+fX
         kzb+NjCaV9mPwxnUxtDCmcCxr6Agm2/+R3128s1AoJwiEm7nSWnCjfjZ/aCPy7+J9SnO
         4RcIdGZF0+cxX8B2q3PKvQO4L0UBJdgR2ll0+DTu7+20XkcTPUhOKhlGJi6rrsG0R5tr
         E6MQ==
X-Gm-Message-State: AHQUAuaBaDurSIAnUuETGru306DfMgZ6xfLBk21DjJL5sjDfWIwO5XuK
        LkE40dGczpi5b9QHpkYEs8I=
X-Google-Smtp-Source: AHgI3IaBkVs3c3VJpGAcVqWv3iM3x+OaKXsEJ/qTHZeEyawv27XIzslNlI3xfbZy4mALkEglrUPW7g==
X-Received: by 2002:a17:902:b01:: with SMTP id 1mr38270427plq.331.1549894857087;
        Mon, 11 Feb 2019 06:20:57 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e2sm20551664pga.92.2019.02.11.06.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 06:20:56 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, joro@8bytes.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com,
        sashal@kernel.org, dan.carpenter@oracle.com
Subject: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date:   Mon, 11 Feb 2019 22:20:23 +0800
Message-Id: <1549894824-26623-3-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
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

Define 24 IO-APIC remapping entries because Hyper-V only expose one
single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v3:
       - Make Hyper-V IOMMU as Hyper-V default driver
       - Fix hypervisor_is_type() input parameter
       - Check possible cpu numbers during scan 0~255 cpu's apic id.

Change since v2:
       - Improve comment about why save IO-APIC entry in the irq chip data.
       - Some code improvement.
       - Improve statement in the IOMMU Kconfig.

Change since v1:
      - Remove unused pr_fmt
      - Make ioapic_ir_domain as static variable
      - Remove unused variables cfg and entry in the hyperv_irq_remapping_alloc()
      - Fix comments
---
 drivers/iommu/Kconfig         |   9 ++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/hyperv-iommu.c  | 194 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c |   3 +
 drivers/iommu/irq_remapping.h |   1 +
 5 files changed, 208 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 45d7021..6f07f3b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -437,4 +437,13 @@ config QCOM_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
 
+config HYPERV_IOMMU
+	bool "Hyper-V x2APIC IRQ Handling"
+	depends on HYPERV
+	select IOMMU_API
+	default HYPERV
+	help
+	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
+	  guests to run with x2APIC mode enabled.
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
index 0000000..c61240e0
--- /dev/null
+++ b/drivers/iommu/hyperv-iommu.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V stub IOMMU driver.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
+ */
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
+#ifdef CONFIG_IRQ_REMAP
+
+/*
+ * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
+ * Redirection Table. Hyper-V exposes one single IO-APIC and so define
+ * 24 IO APIC remmapping entries.
+ */
+#define IOAPIC_REMAPPING_ENTRY 24
+
+static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
+static struct irq_domain *ioapic_ir_domain;
+
+static int hyperv_ir_set_affinity(struct irq_data *data,
+		const struct cpumask *mask, bool force)
+{
+	struct irq_data *parent = data->parent_data;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	struct IO_APIC_route_entry *entry;
+	int ret;
+
+	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
+	if (!cpumask_subset(mask, &ioapic_max_cpumask))
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
+	struct irq_data *irq_data;
+	struct irq_desc *desc;
+	int ret = 0;
+
+	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
+		return -EINVAL;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	irq_data = irq_domain_get_irq_data(domain, virq);
+	if (!irq_data) {
+		irq_domain_free_irqs_common(domain, virq, nr_irqs);
+		return -EINVAL;
+	}
+
+	irq_data->chip = &hyperv_ir_chip;
+
+	/*
+	 * If there is interrupt remapping function of IOMMU, setting irq
+	 * affinity only needs to change IRTE of IOMMU. But Hyper-V doesn't
+	 * support interrupt remapping function, setting irq affinity of IO-APIC
+	 * interrupts still needs to change IO-APIC registers. But ioapic_
+	 * configure_entry() will ignore value of cfg->vector and cfg->
+	 * dest_apicid when IO-APIC's parent irq domain is not the vector
+	 * domain.(See ioapic_configure_entry()) In order to setting vector
+	 * and dest_apicid to IO-APIC register, IO-APIC entry pointer is saved
+	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
+	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
+	 */
+	irq_data->chip_data = info->ioapic_entry;
+
+	/*
+	 * Hypver-V IO APIC irq affinity should be in the scope of
+	 * ioapic_max_cpumask because no irq remapping support.
+	 */
+	desc = irq_data_to_desc(irq_data);
+	cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);
+
+	return 0;
+}
+
+static void hyperv_irq_remapping_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static int hyperv_irq_remapping_activate(struct irq_domain *domain,
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
+	.activate = hyperv_irq_remapping_activate,
+};
+
+static int __init hyperv_prepare_irq_remapping(void)
+{
+	struct fwnode_handle *fn;
+	int i;
+
+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
+	    !x2apic_supported())
+		return -ENODEV;
+
+	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
+	if (!fn)
+		return -ENOMEM;
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
+	 * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
+	 * in the MADT table on Hyper-v are sorted monotonic increasingly.
+	 * APIC ID reflects cpu topology. There maybe some APIC ID
+	 * gaps when cpu number in a socket is not power of two. Prepare
+	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
+	 * into ioapic_max_cpumask if its APIC ID is less than 256.
+	 */
+	for (i = min_t(unsigned int, num_possible_cpus(), 255); i >= 0; i--)
+		if (cpu_physical_id(i) < 256)
+			cpumask_set_cpu(i, &ioapic_max_cpumask);
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
+
+#endif
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

