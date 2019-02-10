Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93245C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B108214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549789745;
	bh=Hbty9BRINsw9dNLNEhfm21u3yhhPoC6b0leIrI51ifo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Rz6FGKjs94KsQ1lIMsi6yYF2Sp46NRgwZ202EULbOBrsTl95lgagPzy2xrpNpxAXz
	 3SLOZ1besLi6n5exKFcy9GIB47Fo43MsztwcZwWu0VnhH3HkGTl2RsvbPd6gOhkE9Y
	 1XulRC+OoWnewlKcBAWG/m6gyVgdy8LXUw639ZKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfBJJJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:09:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJJJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:09:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so11123349wmt.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 01:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6jCu9FeDhzdlUe0dhQvCbArprQDmKGhqJfTAirgSnxM=;
        b=YvQGIC/qPEHBWu8YLdIQSgqJIJA2l5X3QB89qpMSVF+pi0YJgdgClhHjQwJR6wpi5G
         rnjA+G0AWdHtvCGcSrQHh5LVyM+hMeFkqL/SpirYRtvVtYSj3qn7FPvz2b+H5pwZpSqM
         MX6qp67CbYFnnAlaR+22tXhbyVN3ad8nakJCxeUV786YD2yAC51GTDBtG3ChcZpFdDv8
         vMCO/mWlXe7381/dkHrtf1NQD5TIAy2wzH3SIq6cEU7UVB2E08hXoidhUaJjO/2n2XDq
         pQHGu03AqSi59OHBWt7yztqkQAE9/a0x/EGJ20IbPZCq5zd/331flP6IRGOTLuwSlRKV
         CUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6jCu9FeDhzdlUe0dhQvCbArprQDmKGhqJfTAirgSnxM=;
        b=ADvNDfRXcJkADfXQtQ06zHRck9djyeHWjgFa8CsELS4fDIgzydwn1Um02ZIePBi5jT
         ZJU3mB0BUxku0LqdDBeuiNBCcIVFPqadnBXjXtz00TqMdS/9WBja9oRjC/WaxY3HVtWQ
         ntvRORS/gn0Iv+BK+HP6U2pMV9bkngz/eO+2D6bdkGngfOgXT8pf9GiDB+Hipv80bUEa
         j3p99ouDNnC6Y0GOMay0iq5Y8aPBPiGEwkwRH2NdQOjR6BVzNE+1yMsS/hEWPgcTzcVt
         lAvpGRY8gPswMKEQ9ckqhsDINkyI2cAFZdVa+wdV2k8SUH5TyZEzuGqLPSUdn+aH5YWX
         WgMA==
X-Gm-Message-State: AHQUAuY5YjbhdQ3fxJYt565vuxihLkVm/zdvUtImvcvxcZlFDvK6NBz8
        qxhMuFj61nJ/ctgGvrAY/HY=
X-Google-Smtp-Source: AHgI3IZotvkbALpc5k1buZkJLrFCFi7Hj7ODoDNEhBNHhckBofzudfckXlA2EHpyvQ/pS0FOqFTJBg==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr6267042wrj.292.1549789740643;
        Sun, 10 Feb 2019 01:09:00 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x10sm4082254wrn.29.2019.02.10.01.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 01:08:59 -0800 (PST)
Date:   Sun, 10 Feb 2019 10:08:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <20190210090857.GA35003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

   # HEAD: 8087f407364d50d5c3ac8e39365548351e2859f2 Merge tag 'irqchip-5.0-3' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

irqchip driver fixes: most of them are race fixes for ARM GIC (General 
Interrupt Controller) variants, but also a fix for the ARM MMP (Marvell 
PXA168 et al) irqchip affecting OLPC keyboards.

 Thanks,

	Ingo

------------------>
Heyi Guo (1):
      irqchip/gic-v4: Fix occasional VLPI drop

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Marc Zyngier (2):
      irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID
      irqchip/gic-v3-its: Gracefully fail on LPI exhaustion

Zenghui Yu (1):
      irqchip/gic-v3-its: Fix ITT_entry_size accessor


 drivers/irqchip/irq-gic-v3-its.c   | 101 +++++++++++++++++++++++++++++--------
 drivers/irqchip/irq-mmp.c          |   6 ++-
 include/linux/irqchip/arm-gic-v3.h |   2 +-
 3 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7f2a45445b00..c3aba3fc818d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -97,9 +97,14 @@ struct its_device;
  * The ITS structure - contains most of the infrastructure, with the
  * top-level MSI domain, the command queue, the collections, and the
  * list of devices writing to it.
+ *
+ * dev_alloc_lock has to be taken for device allocations, while the
+ * spinlock must be taken to parse data structures such as the device
+ * list.
  */
 struct its_node {
 	raw_spinlock_t		lock;
+	struct mutex		dev_alloc_lock;
 	struct list_head	entry;
 	void __iomem		*base;
 	phys_addr_t		phys_base;
@@ -156,6 +161,7 @@ struct its_device {
 	void			*itt;
 	u32			nr_ites;
 	u32			device_id;
+	bool			shared;
 };
 
 static struct {
@@ -1580,6 +1586,9 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 		nr_irqs /= 2;
 	} while (nr_irqs > 0);
 
+	if (!nr_irqs)
+		err = -ENOSPC;
+
 	if (err)
 		goto out;
 
@@ -2059,6 +2068,29 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+{
+	u32 count = 1000000;	/* 1s! */
+	bool clean;
+	u64 val;
+
+	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+	val &= ~GICR_VPENDBASER_Valid;
+	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	do {
+		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		clean = !(val & GICR_VPENDBASER_Dirty);
+		if (!clean) {
+			count--;
+			cpu_relax();
+			udelay(1);
+		}
+	} while (!clean && count);
+
+	return val;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
@@ -2144,6 +2176,30 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+	if (gic_rdists->has_vlpis) {
+		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+
+		/*
+		 * It's possible for CPU to receive VLPIs before it is
+		 * sheduled as a vPE, especially for the first CPU, and the
+		 * VLPI with INTID larger than 2^(IDbits+1) will be considered
+		 * as out of range and dropped by GIC.
+		 * So we initialize IDbits to known value to avoid VLPI drop.
+		 */
+		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
+		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
+			smp_processor_id(), val);
+		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+
+		/*
+		 * Also clear Valid bit of GICR_VPENDBASER, in case some
+		 * ancient programming gets left in and has possibility of
+		 * corrupting memory.
+		 */
+		val = its_clear_vpend_valid(vlpi_base);
+		WARN_ON(val & GICR_VPENDBASER_Dirty);
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
@@ -2422,6 +2478,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	struct its_device *its_dev;
 	struct msi_domain_info *msi_info;
 	u32 dev_id;
+	int err = 0;
 
 	/*
 	 * We ignore "dev" entierely, and rely on the dev_id that has
@@ -2444,6 +2501,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&its->dev_alloc_lock);
 	its_dev = its_find_device(its, dev_id);
 	if (its_dev) {
 		/*
@@ -2451,18 +2509,22 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
+		its_dev->shared = true;
 		pr_debug("Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
 	its_dev = its_create_device(its, dev_id, nvec, true);
-	if (!its_dev)
-		return -ENOMEM;
+	if (!its_dev) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
+	mutex_unlock(&its->dev_alloc_lock);
 	info->scratchpad[0].ptr = its_dev;
-	return 0;
+	return err;
 }
 
 static struct msi_domain_ops its_msi_domain_ops = {
@@ -2566,6 +2628,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_node *its = its_dev->its;
 	int i;
 
 	for (i = 0; i < nr_irqs; i++) {
@@ -2580,8 +2643,14 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		irq_domain_reset_irq_data(data);
 	}
 
-	/* If all interrupts have been freed, start mopping the floor */
-	if (bitmap_empty(its_dev->event_map.lpi_map,
+	mutex_lock(&its->dev_alloc_lock);
+
+	/*
+	 * If all interrupts have been freed, start mopping the
+	 * floor. This is conditionned on the device not being shared.
+	 */
+	if (!its_dev->shared &&
+	    bitmap_empty(its_dev->event_map.lpi_map,
 			 its_dev->event_map.nr_lpis)) {
 		its_lpi_free(its_dev->event_map.lpi_map,
 			     its_dev->event_map.lpi_base,
@@ -2593,6 +2662,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		its_free_device(its_dev);
 	}
 
+	mutex_unlock(&its->dev_alloc_lock);
+
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
@@ -2755,26 +2826,11 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 static void its_vpe_deschedule(struct its_vpe *vpe)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
-	u32 count = 1000000;	/* 1s! */
-	bool clean;
 	u64 val;
 
-	/* We're being scheduled out */
-	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-	val &= ~GICR_VPENDBASER_Valid;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
-
-	do {
-		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-		clean = !(val & GICR_VPENDBASER_Dirty);
-		if (!clean) {
-			count--;
-			cpu_relax();
-			udelay(1);
-		}
-	} while (!clean && count);
+	val = its_clear_vpend_valid(vlpi_base);
 
-	if (unlikely(!clean && !count)) {
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
 		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
 		vpe->idai = false;
 		vpe->pending_last = true;
@@ -3517,6 +3573,7 @@ static int __init its_probe_one(struct resource *res,
 	}
 
 	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
 	INIT_LIST_HEAD(&its->entry);
 	INIT_LIST_HEAD(&its->its_device_list);
 	typer = gic_read_typer(its_base + GITS_TYPER);
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25f32e1d7764..3496b61a312a 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -34,6 +34,9 @@
 #define SEL_INT_PENDING		(1 << 6)
 #define SEL_INT_NUM_MASK	0x3f
 
+#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
+#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
+
 struct icu_chip_data {
 	int			nr_irqs;
 	unsigned int		virq_base;
@@ -190,7 +193,8 @@ static const struct mmp_intc_conf mmp_conf = {
 static const struct mmp_intc_conf mmp2_conf = {
 	.conf_enable	= 0x20,
 	.conf_disable	= 0x0,
-	.conf_mask	= 0x7f,
+	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
 
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 071b4cbdf010..c848a7cc502e 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -319,7 +319,7 @@
 #define GITS_TYPER_PLPIS		(1UL << 0)
 #define GITS_TYPER_VLPIS		(1UL << 1)
 #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
-#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
