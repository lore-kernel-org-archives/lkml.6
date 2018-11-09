Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A293C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E720818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkFjX+yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212E720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKJCUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:20:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39835 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeKJCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:20:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id n11-v6so1160440pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qApp59rpB9CRPxo17xYVxbBT1RT+9Ts5jG6ly+csZM8=;
        b=YkFjX+ySXAK/qo/dnX+jGM5iS/7TluJ1/M0PF0lEfxmyMS2N/q2aPapXVbn6raIrDV
         iR+N66KAG3aG1CKbjwbjWG4rA4iTkdsWMb5NwvoBWKr0QWrNc556MNi1DdKNJVewo+Wd
         lMGixXOyo25WW5Fz2iRyfH13n3NmzjaTZx7Q5jsWpYvVKOUIysUSArHs14Ju4CJAXBtw
         5zBHlP97INDOoeNahVIEP+6yJlzb/Lv6Sp1TSkv+xVxx6T0A72FuilYjW4UVfNBnpAgM
         7l4MhsIcaMrX7v2+QMagBPXb+gAjB/ZflY+rZtLYUUhXWI8ktgBn5xVlmlIEmdt3GW3m
         vojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qApp59rpB9CRPxo17xYVxbBT1RT+9Ts5jG6ly+csZM8=;
        b=enJ9/feoTRFvoSkJqCX9nA9jNiGxS4IMI9d6JwTCFO1LkPz4NqrGyimC8yB7cb7bAk
         EneafwzqQQr05cyhiE0NPt3NJgciZ1Aq/2HyqE7/EqhXEx/cYddRh9H9KVEKVTKLtfDv
         TxMHrm1lLto/dBnEEEZ6yd2Le96pUwhDSQl645L2nr/elHakB/ZDMPMZOUfSMNdhLXUX
         ud30uf1umeBSI2X67CSBylX0CbEdrMGrwKp4CBZCt3B79U/EkjY5zMzXNHfmg3nHZclW
         JqcOpagQvzLYyFZOamWL/CRZO/fRj6yfxd9njBNYHXPIVdE6fEFAitrNxQlRK6ffsU/m
         g2Gg==
X-Gm-Message-State: AGRZ1gJrIC+bScfSTz7HPXvPNMYbYc8EUFevK4B/z8LXgGMc/kaknKa2
        /5jJwcyYR0oi33HPSq06OjhTaY8+30iURQ==
X-Google-Smtp-Source: AJdET5dKEpVoUXVfiVdZBRRtJGSYvNDf2FDwqbRcLyvTW5o0P27tYlWF88RUarE4gIxcSJEzG940cQ==
X-Received: by 2002:a63:6883:: with SMTP id d125-v6mr8013130pgc.451.1541781540422;
        Fri, 09 Nov 2018 08:39:00 -0800 (PST)
Received: from localhost.localdomain ([49.77.227.233])
        by smtp.gmail.com with ESMTPSA id c87-v6sm14347159pfe.93.2018.11.09.08.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 08:38:59 -0800 (PST)
From:   Dou Liyang <douliyangs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        Dou Liyang <douliyangs@gmail.com>
Subject: [RFC PATCH v2] gen/irq: Change the way to differentiate between managed and unmanaged interrupts by bitmap
Date:   Sat, 10 Nov 2018 00:38:49 +0800
Message-Id: <20181109163849.21699-1-douliyangs@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Kashyap and Sumit reported, in MSI/-x subsystem, the pre/post vectors
may be used to some extra reply queues for performance. the best way to
map the pre/post vectors is map them to unmanaged interrupts.

But, current Linux can't do that, because the way which we use to
differentiate between managed and unmanaged interrupts is affinity mask.
If the affinity mask is present, the interrupt will be mark as managed.
According to the pre- and post- vectors' affinity masks are set when kernel
boots up, they are always managed interrupts as other MSI(-X) vectors.
In other words, Linux can't both seting the affinity mask and the managed flag.

So, decouple the managed flag from the affinity mask, add a new bitmap to
differentiate between managed and unmanaged interrupts.

Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Sumit Saxena <sumit.saxena@broadcom.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dou Liyang <douliyangs@gmail.com>
---
Changelog:
  - Add a bitmap for marking if an interrupt is managed or not.
  the size of bitmap is runtime allocation.

  - Need more tests, Just test this patch in QEmu.

  - v1: https://lkml.org/lkml/2018/9/13/366

 arch/sparc/kernel/irq_64.c      |  2 +-
 arch/x86/kernel/apic/io_apic.c  |  4 ++--
 drivers/base/platform-msi.c     |  2 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c |  2 +-
 drivers/irqchip/irq-gic-v4.c    |  2 +-
 drivers/pci/msi.c               | 12 ++++++++----
 include/linux/interrupt.h       |  5 +++--
 include/linux/irq.h             |  4 ++--
 include/linux/irqdomain.h       |  6 +++---
 include/linux/msi.h             |  3 ++-
 kernel/irq/affinity.c           | 27 +++++++++++++++++++++++----
 kernel/irq/devres.c             | 13 +++++++++++--
 kernel/irq/ipi.c                |  4 ++--
 kernel/irq/irqdesc.c            | 15 ++++++++++-----
 kernel/irq/irqdomain.c          | 15 ++++++++-------
 kernel/irq/msi.c                |  7 +++++--
 16 files changed, 83 insertions(+), 40 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 713670e6d13d..1ce85779b2bb 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -242,7 +242,7 @@ unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino)
 {
 	int irq;
 
-	irq = __irq_alloc_descs(-1, 1, 1, numa_node_id(), NULL, NULL);
+	irq = __irq_alloc_descs(-1, 1, 1, numa_node_id(), NULL, NULL, NULL);
 	if (irq <= 0)
 		goto out;
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2953bbf05c08..2e7c8b77874a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -982,7 +982,7 @@ static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
 
 	return __irq_domain_alloc_irqs(domain, irq, 1,
 				       ioapic_alloc_attr_node(info),
-				       info, legacy, NULL);
+				       info, legacy, NULL, NULL);
 }
 
 /*
@@ -1017,7 +1017,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
 		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true,
-					      NULL);
+					      NULL, NULL);
 		if (irq >= 0) {
 			irq_data = irq_domain_get_irq_data(domain, irq);
 			data = irq_data->chip_data;
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index f39a920496fb..c5d319d92eb1 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -134,7 +134,7 @@ static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
 	}
 
 	for (i = 0; i < nvec; i++) {
-		desc = alloc_msi_entry(dev, 1, NULL);
+		desc = alloc_msi_entry(dev, 1, NULL, 0);
 		if (!desc)
 			break;
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8b9c66d7c4ff..92e6266e10d2 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -214,7 +214,7 @@ static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
 	struct msi_desc *msi_desc;
 
 	for (i = 0; i < irq_count; i++) {
-		msi_desc = alloc_msi_entry(dev, 1, NULL);
+		msi_desc = alloc_msi_entry(dev, 1, NULL, 0);
 		if (!msi_desc) {
 			dev_err(dev, "Failed to allocate msi entry\n");
 			error = -ENOMEM;
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index dba9d67cb9c1..17b459e283a1 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -119,7 +119,7 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 
 	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
 					       NUMA_NO_NODE, vm,
-					       false, NULL);
+					       false, NULL, NULL);
 	if (vpe_base_irq <= 0)
 		goto err;
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed50a245..577bc262c4c0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -535,15 +535,16 @@ static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
 {
 	struct cpumask *masks = NULL;
+	unsigned long managed = 0;
 	struct msi_desc *entry;
 	u16 control;
 
 	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
+		masks = irq_create_affinity_masks(nvec, affd, &managed);
 
 
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(&dev->dev, nvec, masks);
+	entry = alloc_msi_entry(&dev->dev, nvec, masks, managed);
 	if (!entry)
 		goto out;
 
@@ -673,14 +674,17 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      const struct irq_affinity *affd)
 {
 	struct cpumask *curmsk, *masks = NULL;
+	DECLARE_BITMAP(managed, nvec);
 	struct msi_desc *entry;
 	int ret, i;
 
+	memset(managed, 0, sizeof(managed));
 	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
+		masks = irq_create_affinity_masks(nvec, affd, managed);
 
 	for (i = 0, curmsk = masks; i < nvec; i++) {
-		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
+		unsigned long m = test_bit(i, managed) ? 1 : 0;
+		entry = alloc_msi_entry(&dev->dev, 1, curmsk, m);
 		if (!entry) {
 			if (!i)
 				iounmap(base);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1d6711c28271..c8d7976226ba 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -299,7 +299,8 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
-struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+struct cpumask
+*irq_create_affinity_masks(int nvec, const struct irq_affinity *affd, unsigned long *managed);
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
@@ -334,7 +335,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 }
 
 static inline struct cpumask *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
+irq_create_affinity_masks(int nvec, const struct irq_affinity *affd, unsigned long *managed)
 {
 	return NULL;
 }
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c9bffda04a45..4ea14bb41070 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -834,7 +834,7 @@ struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		      struct module *owner, const struct cpumask *affinity);
+		      struct module *owner, const struct cpumask *affinity, unsigned long *managed);
 
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
@@ -842,7 +842,7 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 
 /* use macros to avoid needing export.h for THIS_MODULE */
 #define irq_alloc_descs(irq, from, cnt, node)	\
-	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL)
+	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL, NULL)
 
 #define irq_alloc_desc(node)			\
 	irq_alloc_descs(-1, 0, 1, node)
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 068aa46f0d55..baf3612bc853 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -266,7 +266,7 @@ extern bool irq_domain_check_msi_remap(void);
 extern void irq_set_default_host(struct irq_domain *host);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node,
-				  const struct cpumask *affinity);
+				  const struct cpumask *affinity, unsigned long *managed);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
@@ -449,7 +449,7 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc, const struct cpumask *affinity);
+				   bool realloc, const struct cpumask *affinity, unsigned long *managed);
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
@@ -458,7 +458,7 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
 	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
-				       NULL);
+				       NULL, NULL);
 }
 
 extern int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0e9c50052ff3..ae3e97d6338c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,7 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct cpumask			*affinity;
+	unsigned long 			managed;
 
 	union {
 		/* PCI MSI/X specific data */
@@ -136,7 +137,7 @@ static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 #endif /* CONFIG_PCI_MSI */
 
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct cpumask *affinity);
+				 const struct cpumask *affinity, unsigned long managed);
 void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..b72f6efed7a3 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -170,11 +170,13 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
  * @affd:	Description of the affinity requirements
+ * @managed:	Bitmap to differentiate between managed and unmanaged interrupts
  *
  * Returns the masks pointer or NULL if allocation failed.
  */
 struct cpumask *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd,
+						unsigned long *managed)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
@@ -204,7 +206,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
+		cpumask_copy(masks + curvec, cpu_possible_mask);
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
@@ -231,13 +233,30 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 					     nmsk, masks);
 	put_online_cpus();
 
+	/*
+	 * Mark the managed interrupts in managed bitmap, we will not mark
+	 * the pre_vectors at beginning of the MSI(-X) vector space and the
+	 * post_vectors at end of the MSI(-X) vector space
+	 */
+	if (managed) {
+		for (curvec = 0; curvec < usedvecs; curvec++)
+			set_bit(curvec + affd->pre_vectors, managed);
+	}
+
 	/* Fill out vectors at the end that don't need affinity */
 	if (usedvecs >= affvecs)
 		curvec = affd->pre_vectors + affvecs;
-	else
+	else {
 		curvec = affd->pre_vectors + usedvecs;
+		for (; curvec < affd->pre_vectors + affvecs; curvec++) {
+			if (managed)
+				set_bit(curvec, managed);
+			cpumask_copy(masks + curvec, irq_default_affinity);
+		}
+	}
+
 	for (; curvec < nvecs; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
+		cpumask_copy(masks + curvec, cpu_possible_mask);
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 6a682c229e10..e183c5af143a 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -181,14 +181,23 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
 			   const struct cpumask *affinity)
 {
+	const struct cpumask *mask = NULL;
+	DECLARE_BITMAP(managed,cnt);
 	struct irq_desc_devres *dr;
-	int base;
+	int base, i;
 
 	dr = devres_alloc(devm_irq_desc_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
 		return -ENOMEM;
 
-	base = __irq_alloc_descs(irq, from, cnt, node, owner, affinity);
+	if (affinity) {
+		for (i = 0, mask = affinity; i < cnt; i++, mask++) {
+			if (!cpumask_empty(mask))
+				set_bit(i, managed);
+		}
+	}
+
+	base = __irq_alloc_descs(irq, from, cnt, node, owner, affinity, managed);
 	if (base < 0) {
 		devres_free(dr);
 		return base;
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 8b778e37dc6d..d56b7e45c140 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -75,14 +75,14 @@ int irq_reserve_ipi(struct irq_domain *domain,
 		}
 	}
 
-	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE, NULL);
+	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE, NULL, NULL);
 	if (virq <= 0) {
 		pr_warn("Can't reserve IPI, failed to alloc descs\n");
 		return -ENOMEM;
 	}
 
 	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
-				       (void *) dest, true, NULL);
+				       (void *) dest, true, NULL, NULL);
 
 	if (virq <= 0) {
 		pr_warn("Can't reserve IPI, failed to alloc hw irqs\n");
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 578d0e5f1b5b..bd26511f0094 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -449,7 +449,7 @@ static void free_desc(unsigned int irq)
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
-		       const struct cpumask *affinity, struct module *owner)
+		       const struct cpumask *affinity, struct module *owner, unsigned long *managed)
 {
 	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
@@ -464,10 +464,14 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		}
 	}
 
-	flags = affinity ? IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN : 0;
 	mask = NULL;
 
 	for (i = 0; i < cnt; i++) {
+		if (managed && test_bit(i, managed))
+			flags = IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN;
+		else
+			flags = 0;
+
 		if (affinity) {
 			node = cpu_to_node(cpumask_first(affinity));
 			mask = affinity;
@@ -700,12 +704,13 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  * @affinity:	Optional pointer to an affinity mask array of size @cnt which
  *		hints where the irq descriptors should be allocated and which
  *		default affinities to use
+ * @managed:	Bitmap to differentiate between managed and unmanaged interrupts
  *
  * Returns the first irq number or error code
  */
 int __ref
 __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner, const struct cpumask *affinity)
+		  struct module *owner, const struct cpumask *affinity, unsigned long *managed)
 {
 	int start, ret;
 
@@ -738,7 +743,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 		if (ret)
 			goto unlock;
 	}
-	ret = alloc_descs(start, cnt, node, affinity, owner);
+	ret = alloc_descs(start, cnt, node, affinity, owner, managed);
 unlock:
 	mutex_unlock(&sparse_irq_lock);
 	return ret;
@@ -755,7 +760,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_alloc_hwirqs(int cnt, int node)
 {
-	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, NULL);
+	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, NULL, NULL);
 
 	if (irq < 0)
 		return 0;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3366d11c3e02..c9f567dafc60 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -658,7 +658,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	}
 
 	/* Allocate a virtual interrupt number */
-	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NULL);
+	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NULL, NULL);
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
@@ -969,22 +969,22 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
-			   int node, const struct cpumask *affinity)
+			   int node, const struct cpumask *affinity, unsigned long *managed)
 {
 	unsigned int hint;
 
 	if (virq >= 0) {
 		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
-					 affinity);
+					 affinity, managed);
 	} else {
 		hint = hwirq % nr_irqs;
 		if (hint == 0)
 			hint++;
 		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
-					 affinity);
+					 affinity, managed);
 		if (virq <= 0 && hint > 1) {
 			virq = __irq_alloc_descs(-1, 1, cnt, node, THIS_MODULE,
-						 affinity);
+						 affinity, managed);
 		}
 	}
 
@@ -1266,6 +1266,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
  * @arg:	domain specific argument
  * @realloc:	IRQ descriptors have already been allocated if true
  * @affinity:	Optional irq affinity mask for multiqueue devices
+ * @managed:	Bitmap to differentiate between managed and unmanaged interrupts
  *
  * Allocate IRQ numbers and initialized all data structures to support
  * hierarchy IRQ domains.
@@ -1281,7 +1282,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
  */
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc, const struct cpumask *affinity)
+			    bool realloc, const struct cpumask *affinity, unsigned long *managed)
 {
 	int i, ret, virq;
 
@@ -1300,7 +1301,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 		virq = irq_base;
 	} else {
 		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
-					      affinity);
+					      affinity, managed);
 		if (virq < 0) {
 			pr_debug("cannot allocate IRQ(base %d, count %d)\n",
 				 irq_base, nr_irqs);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4ca2fd46645d..76820b507e3e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -22,12 +22,14 @@
  * @dev:	Pointer to the device for which this is allocated
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
+ * @managed:	Bitmap to differentiate between managed and unmanaged interrupts
  *
  * If @affinity is not NULL then a an affinity array[@nvec] is allocated
  * and the affinity masks from @affinity are copied.
  */
 struct msi_desc *
-alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
+alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity,
+							unsigned long managed)
 {
 	struct msi_desc *desc;
 
@@ -38,6 +40,7 @@ alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
 	INIT_LIST_HEAD(&desc->list);
 	desc->dev = dev;
 	desc->nvec_used = nvec;
+	desc->managed = managed;
 	if (affinity) {
 		desc->affinity = kmemdup(affinity,
 			nvec * sizeof(*desc->affinity), GFP_KERNEL);
@@ -416,7 +419,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
-					       desc->affinity);
+					       desc->affinity,  &(desc->managed));
 		if (virq < 0) {
 			ret = -ENOSPC;
 			if (ops->handle_error)
-- 
2.17.2

