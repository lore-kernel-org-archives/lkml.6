Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A50C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8505B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GmmIYKW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfAaNkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46825 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbfAaNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so3273732wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWONQ0qDcjtWSVIE/aRPokZRcj03z4Fg2op1S0b4qHw=;
        b=GmmIYKW3MAumQE+72QsgF0tJKdBlOWHVr34C79/ksplAzKYhZkYIc/BAWRaXnzkkJW
         u6euD58pKS/if/V6c3c7tCW8X4fQ+UUt29PanoKAWiR/y0BtzxJfw2ktnqd3vf9fnqDO
         OPwdRBCJEs0uNw0L5WTBW7w8ggfXAjlVK0K1XhSvObEbN/RkBQQ6PVLp2UX2jjeC5pJ0
         wcASwB/seMrwate0MpR/EAH/d4G1M/+FvLvFOKTAZ67J6EWYnVcmddheu7sJdAM2NGgR
         SHUaXfOSgYj0PbCCyd8ATMOXJkKZkYrkbMV76YvL6S2b2e4Ruak+vaqpNFCP6QeoH6mq
         bIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWONQ0qDcjtWSVIE/aRPokZRcj03z4Fg2op1S0b4qHw=;
        b=XFeYF2inxtA63x9ytpO1xN8NwzkVajnKQ1Iw3qfMocezQKXW8Q9+hi12Ox+5Z6xhgi
         cF6+Isgd7NIGwHnQtdh02CMTw9KHB1e9O/FgWMqeTY1jnXeR9LOAY1qqzhzmRZ1k7Chr
         MHb2/DPB8bd75a/mRfodLBuebL0SyjGZHd8CiED3t58GMKNk4lEamCkoLTRwSowLPi5T
         2jEIQJ5R/zMzZGRjz5esf0EdA8spjW3xX8Ef5XNBa6Pnl/B9XAGe1rOUQ+caUM1vem9B
         /Fvce1d81YZphM3e/22TjzrhPIQJs8Hpi2OejlHSDdz1gjXJUnlTAsyyGZ9Vt4OjUeja
         dbNg==
X-Gm-Message-State: AJcUukcNT23BoD5APyk0Dx0MU88Xbeps3RSbvD3Y5Kg4ZSO45G6TYrKz
        LgTqN/kA2bzT1rNjJ+ilrsiyWg==
X-Google-Smtp-Source: ALg8bN4TxDbT9YUI7DpVszT3Xns3HHytpb5YdBwY6cQQtOuTu7vF/AYS9Tfjezqq1rAkvLXz8B+c1Q==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr33107803wrv.308.1548941995065;
        Thu, 31 Jan 2019 05:39:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/35] ARM: davinci: aintc: use a common prefix for symbols in the driver
Date:   Thu, 31 Jan 2019 14:39:04 +0100
Message-Id: <20190131133928.17985-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
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
---
 arch/arm/mach-davinci/dm355.c               |  2 +-
 arch/arm/mach-davinci/dm365.c               |  2 +-
 arch/arm/mach-davinci/dm644x.c              |  2 +-
 arch/arm/mach-davinci/dm646x.c              |  2 +-
 arch/arm/mach-davinci/include/mach/common.h |  2 +-
 arch/arm/mach-davinci/irq.c                 | 98 ++++++++++-----------
 6 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 2795b5ee0069..cf574956ce1d 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -740,7 +740,7 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm355_init_irqs(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 3222873ff9c6..e63153a6ae41 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -997,7 +997,7 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm365_init_irqs(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm365_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index cfc6e2d481d7..0904baa1d008 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -674,7 +674,7 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm644x_init_irqs(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 void __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 5cb087f68efe..27831d6fc5a5 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -635,7 +635,7 @@ void __init dm646x_register_clocks(void)
 
 void __init dm646x_init_irqs(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 3d45b73b9a64..9cf3a36a802a 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -19,7 +19,7 @@
 
 void davinci_timer_init(struct clk *clk);
 
-extern void davinci_irq_init(void);
+extern void davinci_aintc_init(void);
 
 struct davinci_timer_instance {
 	u32		base;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index b908b4903b9a..c43aee686b78 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,39 +18,39 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
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
-	return __raw_readl(davinci_intc_base + offset);
+	return __raw_readl(davinci_aintc_base + offset);
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
 
@@ -59,84 +59,84 @@ davinci_irq_setup_gc(void __iomem *base,
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
 	int rv, irq_base;
 
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
+	for (i = DAVINCI_AINTC_IRQ_INTPRI0_REG; i <= DAVINCI_AINTC_IRQ_INTPRI7_REG; i += 4) {
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
 
-	rv = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+	rv = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
 					    "AINTC", handle_edge_irq,
 					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
 	if (WARN_ON(rv))
 		return;
 
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
+		davinci_aintc_setup_gc(davinci_aintc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
-	set_handle_irq(davinci_handle_irq);
+	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1

