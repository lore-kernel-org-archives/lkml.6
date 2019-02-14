Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59184C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DF72229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Wk26VFRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439545AbfBNOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439522AbfBNOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so6753124wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFEuPIAYCl6EbjbrccYCcGMZiBtCezVGoUrs4BzFX18=;
        b=Wk26VFREhgJp/SmVMjL+6mIgCrM+HTDfEZP9wSBHdoKQuYNf6fppnDeHdNhFWmhaLi
         8Z66BbehZ4p7bHi0Bf2Dj/VMnhv4ZVNs8vpynJkevAjwTxqbDmlq4B5tk0X6prHIufLf
         wWfZrxkEmadHCNm1SlRpvOMD/ZXwJrfhSEUAwTS1Z7KAmVOTEqV00gaPQueqaKECX6DR
         vLbJj26cvKBdMXJUPrHTv0MjwCSi9nYUnvDb330vZbV2wRc3BoHLextHO9A9+qr7RvXK
         OxSQ/UxFvYev8nYdwl2PNndPW1kJMcbWsTk+yP9D7DsXqCxQ1VMHYmdTDOYN18+l+JHh
         8jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFEuPIAYCl6EbjbrccYCcGMZiBtCezVGoUrs4BzFX18=;
        b=gQJDCTQk5hfgtkBUx8yjSp8TzUFgj8zzsoCBv8ejj9R3azdc1bB3w1dJNCKuowtWAY
         LJYRGL6r4ZBG0n9mLit1JdMiboCAnmFQnvJK6ahSrJg94auvTrS0ErbW74kJBe6KYnVk
         gwcI+UlZ1euQOVBQMMbXAdpScchGJh6FUcA1ofj1snN/5Gfq1nNQR9DfO5RpH9mw9OaP
         TI6o4CxXroKh99+bJFw2tKAVpN95DH/zP7LcWORk3WXIbtmU4kg1hEIrgGKUeW569Lei
         qGZuPCNPAJf/CZbl64yyjIq5dNFZk62kybyDexnSgYsvzX1C9b2EXV08DQKQT7U/QeMB
         mCEQ==
X-Gm-Message-State: AHQUAuYDTDAVY5uWb5gkuuPnxW7XpcWxPvn0vBbGkhl4sNeCQY6CArxj
        qd/sFLTWsRQd70+Fc3XVLKJWGw==
X-Google-Smtp-Source: AHgI3IZcdlE3XUNARM9DPzdYEbOCpKZQIVsIx6tzjhGv5mHaI+5gk1pTdQaqFZO3HKIm3Z06opiIPw==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr3297634wrx.203.1550155977533;
        Thu, 14 Feb 2019 06:52:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 12/37] ARM: davinci: aintc: use a common prefix for symbols in the driver
Date:   Thu, 14 Feb 2019 15:52:06 +0100
Message-Id: <20190214145231.8750-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
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

