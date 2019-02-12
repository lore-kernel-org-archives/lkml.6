Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C7820842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S4C4qqX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfBLKjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51777 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfBLKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2367494wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFEuPIAYCl6EbjbrccYCcGMZiBtCezVGoUrs4BzFX18=;
        b=S4C4qqX5Q85LoNVWY0NA34mwGMsAa9wGNeCG2+LIn86dA6XJteQggd9PdVsbLa0adj
         L8w5a7ciuGPBLPr+tZiNQgUUevfvR2M29ZT4EZifO/IhLV5g1er9ZQMTfqvb1WIuUE3U
         S2HGC3Gf7CUojAVrXlzhFCJCdRfEZBMQvIusXzdi01HbsxjUh3NyMl/ir7fpBgDi6+bu
         w5NoJgbp/bcBtbrkXtGslq/MzJGwPCXC5EXuJ7X0xc6R8JDcdJ5Yr9Lf/DYgb1oUWVpC
         M4dE7wmbVTmaq5PoH2Y+bQciK24u/F2tr+ewuGcb7COLc6q12m7QTxV/zGarbOInCrsL
         cbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFEuPIAYCl6EbjbrccYCcGMZiBtCezVGoUrs4BzFX18=;
        b=jQ5PcErHYiWNzjNp5KzKc8gQIdUWTvk3KGgdXG7QPJPOhn2JbIFeN34thK+SltmSkE
         uUQCrefD7bFSrxmS80sRVMF1O/7tOGQMbGmQINir4B2weppXmfrL7MVBnH5T/Oy18PcQ
         NK2J2bIWeimm924WzhuM3oVXZaPt6hFk/omwyiJs+RxSpa7nkpmo6OdYraaovIv7S4he
         telEuKlvDWoKJAZSATOkgWEAwoXcbqASq1e3UeTeC7rZ/ab2zA081qmdve4PpA06vfRs
         JpstWBBSkfcCC1i8tytSPB4bhnEi1J+zGz+gWSLvkaZH2v1m17iGJ2oZTafZVSQ+HvBm
         Eyhg==
X-Gm-Message-State: AHQUAuY7pEUoW79xTkTvoKf5EKwujJdgWuhD4oKOXpnzuE6Pxo4oJgce
        +qVUZRR/ljS0n1+hBY6Pit8xuA==
X-Google-Smtp-Source: AHgI3IYQg5u/6a1ncUw9J1itMwXhKHf3KJqquHZqfuYSX6nPI9w+U5sqM6EIYz6NwpgK4MKw2t3XxA==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr2367936wme.16.1549967950926;
        Tue, 12 Feb 2019 02:39:10 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 12/37] ARM: davinci: aintc: use a common prefix for symbols in the driver
Date:   Tue, 12 Feb 2019 11:38:10 +0100
Message-Id: <20190212103835.7768-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In preparation for moving the driver to drivers/irqchip do some
cleanup: use a common prefix for all symbols.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm355.c               |   2 +-
 arch/arm/mach-davinci/dm365.c               |   2 +-
 arch/arm/mach-davinci/dm644x.c              |   2 +-
 arch/arm/mach-davinci/dm646x.c              |   2 +-
 arch/arm/mach-davinci/include/mach/common.h |   2 +-
 arch/arm/mach-davinci/irq.c                 | 107 ++++++++++----------
 6 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 6c65699cb074..e2b680e9944b 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -794,7 +794,7 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm355_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e1c223c6031f..76507dcbcb3a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1053,7 +1053,7 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm365_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm365_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2b18c134ee15..27c73bc54069 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -730,7 +730,7 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm644x_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 void __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 75a9f80317ca..98fc5e3815b9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -691,7 +691,7 @@ void __init dm646x_register_clocks(void)
 
 void __init dm646x_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 1ceed0345988..8c9c011f96f6 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -24,7 +24,7 @@
 
 void davinci_timer_init(struct clk *clk);
 
-extern void davinci_irq_init(void);
+extern void davinci_aintc_init(void);
 
 struct davinci_timer_instance {
 	u32		base;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index eadbb9d75415..2eb3d9b9f65f 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -19,39 +19,39 @@
 
 #include "irqs.h"
 
-#define FIQ_REG0_OFFSET		0x0000
-#define FIQ_REG1_OFFSET		0x0004
-#define IRQ_REG0_OFFSET		0x0008
-#define IRQ_REG1_OFFSET		0x000C
-#define IRQ_IRQENTRY_OFFSET	0x0014
-#define IRQ_ENT_REG0_OFFSET	0x0018
-#define IRQ_ENT_REG1_OFFSET	0x001C
-#define IRQ_INCTL_REG_OFFSET	0x0020
-#define IRQ_EABASE_REG_OFFSET	0x0024
-#define IRQ_INTPRI0_REG_OFFSET	0x0030
-#define IRQ_INTPRI7_REG_OFFSET	0x004C
-
-static void __iomem *davinci_intc_base;
-static struct irq_domain *davinci_irq_domain;
-
-static inline void davinci_irq_writel(unsigned long value, int offset)
+#define DAVINCI_AINTC_FIQ_REG0		0x0000
+#define DAVINCI_AINTC_FIQ_REG1		0x0004
+#define DAVINCI_AINTC_IRQ_REG0		0x0008
+#define DAVINCI_AINTC_IRQ_REG1		0x000C
+#define DAVINCI_AINTC_IRQ_IRQENTRY	0x0014
+#define DAVINCI_AINTC_IRQ_ENT_REG0	0x0018
+#define DAVINCI_AINTC_IRQ_ENT_REG1	0x001C
+#define DAVINCI_AINTC_IRQ_INCTL_REG	0x0020
+#define DAVINCI_AINTC_IRQ_EABASE_REG	0x0024
+#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x0030
+#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x004C
+
+static void __iomem *davinci_aintc_base;
+static struct irq_domain *davinci_aintc_irq_domain;
+
+static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_intc_base + offset);
+	__raw_writel(value, davinci_aintc_base + offset);
 }
 
-static inline unsigned long davinci_irq_readl(int offset)
+static inline unsigned long davinci_aintc_readl(int offset)
 {
-	return readl_relaxed(davinci_intc_base + offset);
+	return readl_relaxed(davinci_aintc_base + offset);
 }
 
 static __init void
-davinci_irq_setup_gc(void __iomem *base,
-		     unsigned int irq_start, unsigned int num)
+davinci_aintc_setup_gc(void __iomem *base,
+		       unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_get_domain_generic_chip(davinci_irq_domain, irq_start);
+	gc = irq_get_domain_generic_chip(davinci_aintc_irq_domain, irq_start);
 	gc->reg_base = base;
 	gc->irq_base = irq_start;
 
@@ -60,16 +60,16 @@ davinci_irq_setup_gc(void __iomem *base,
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 
-	ct->regs.ack = IRQ_REG0_OFFSET;
-	ct->regs.mask = IRQ_ENT_REG0_OFFSET;
+	ct->regs.ack = DAVINCI_AINTC_IRQ_REG0;
+	ct->regs.mask = DAVINCI_AINTC_IRQ_ENT_REG0;
 	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
 static asmlinkage void __exception_irq_entry
-davinci_handle_irq(struct pt_regs *regs)
+davinci_aintc_handle_irq(struct pt_regs *regs)
 {
-	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
+	int irqnr = davinci_aintc_readl(DAVINCI_AINTC_IRQ_IRQENTRY);
 
 	/*
 	 * Use the formula for entry vector index generation from section
@@ -78,70 +78,73 @@ davinci_handle_irq(struct pt_regs *regs)
 	irqnr >>= 2;
 	irqnr -= 1;
 
-	handle_domain_irq(davinci_irq_domain, irqnr, regs);
+	handle_domain_irq(davinci_aintc_irq_domain, irqnr, regs);
 }
 
 /* ARM Interrupt Controller Initialization */
-void __init davinci_irq_init(void)
+void __init davinci_aintc_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
 	int ret, irq_base;
 
-	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
-	if (WARN_ON(!davinci_intc_base))
+	davinci_aintc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
+	if (WARN_ON(!davinci_aintc_base))
 		return;
 
 	/* Clear all interrupt requests */
-	davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, FIQ_REG1_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG1_OFFSET);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG1);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
 
 	/* Disable all interrupts */
-	davinci_irq_writel(0x0, IRQ_ENT_REG0_OFFSET);
-	davinci_irq_writel(0x0, IRQ_ENT_REG1_OFFSET);
+	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_ENT_REG0);
+	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_ENT_REG1);
 
 	/* Interrupts disabled immediately, IRQ entry reflects all */
-	davinci_irq_writel(0x0, IRQ_INCTL_REG_OFFSET);
+	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_INCTL_REG);
 
 	/* we don't use the hardware vector table, just its entry addresses */
-	davinci_irq_writel(0, IRQ_EABASE_REG_OFFSET);
+	davinci_aintc_writel(0, DAVINCI_AINTC_IRQ_EABASE_REG);
 
 	/* Clear all interrupt requests */
-	davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, FIQ_REG1_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG1_OFFSET);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG1);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
 
-	for (i = IRQ_INTPRI0_REG_OFFSET; i <= IRQ_INTPRI7_REG_OFFSET; i += 4) {
+	for (i = DAVINCI_AINTC_IRQ_INTPRI0_REG;
+	     i <= DAVINCI_AINTC_IRQ_INTPRI7_REG; i += 4) {
 		u32		pri;
 
 		for (j = 0, pri = 0; j < 32; j += 4, davinci_def_priorities++)
 			pri |= (*davinci_def_priorities & 0x07) << j;
-		davinci_irq_writel(pri, i);
+		davinci_aintc_writel(pri, i);
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
 	if (WARN_ON(irq_base < 0))
 		return;
 
-	davinci_irq_domain = irq_domain_add_legacy(NULL,
+	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
 					davinci_soc_info.intc_irq_num,
 					irq_base, 0, &irq_domain_simple_ops,
 					NULL);
-	if (WARN_ON(!davinci_irq_domain))
+	if (WARN_ON(!davinci_aintc_irq_domain))
 		return;
 
-	ret = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
-					    "AINTC", handle_edge_irq,
-					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
+	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
+					     "AINTC", handle_edge_irq,
+					     IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
 	if (WARN_ON(ret))
 		return;
 
-	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
+	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num;
+	     i += 32, j += 0x04)
+		davinci_aintc_setup_gc(davinci_aintc_base + j,
+				       irq_base + i, 32);
 
 	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
-	set_handle_irq(davinci_handle_irq);
+	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1

