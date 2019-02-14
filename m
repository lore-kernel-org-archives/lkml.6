Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CCCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E32222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0syLwA+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502017AbfBNOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:55:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40566 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439500AbfBNOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so6778934wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1EQNjSyfpUGzBvEAYsI2d5nLa3DxeE3XVawtvrOQTM=;
        b=0syLwA+jJf0mTJGghIFZH5DkcoY1JDL2xIhPuG9VQzyC20K/tvlmlq081q3kpPuWBA
         N2hftqIYq3RaoP8gYaNJR8LNod+AnFzGBNC2X4dENUc/r+2gLlyuNjEII60uijCGs/zC
         EJZq4RCOvoMtIa7K7Exu0f3ekVnzFhYHMIWFaA3R7L8VBy55hquq2/jFlWJGpiDnB2oZ
         1HVBFLL8j8HjAuI8G+MZt8RSlXkzD4XbdvsH8KHNZ4yf+X2SLyq516A9hLsjvo23MNbF
         L+u+hl80iHxzt0NzigxGOiD6pDKSUiwAMlGaWEa1Kkw0wStdRDomh4NJ/RxopTztDJ1T
         A6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1EQNjSyfpUGzBvEAYsI2d5nLa3DxeE3XVawtvrOQTM=;
        b=dUSmiceEA8QEv9MwEx3HXOYFMwBFcMrMdbWeuAy4AVtjfAJFhgfrUCxEAU7REOWsy5
         RyDSc/9kGuXOlPojkaM+YIpDzAzhS34CZIz/yoPTCJHU+rL3S/T622K66jA86SS3G6R6
         q+q3G9uzIPgiUbq6mO5W0EIWsOLvKs4TH1tgUXKs2yaszUhPUntp3WJoDP7K4VSLw0mo
         Oto6fng2pJMrdwdWIBfx3VL4q0f00ljeUJYO7fU118zANLvTxDwdZ6cnxgVU7CoRghio
         u1EjyfggWNdgLFlWZvuBlmvKg1S8ndf0/NV55mJ2Dpi1QADdz2qk47vfUiaEh2DRuHpM
         lqYw==
X-Gm-Message-State: AHQUAuaCuxn3mlULnFUfduAQjzNVPKJMdEu2kXkGIaYV0CcaQMDVaO0k
        Ju164lKbwbBZ3+Q6R5SGIuKSww==
X-Google-Smtp-Source: AHgI3IaA/GOSOrbqH7zsa1s3Mi8wQe6po2d9pYcufTekXaS4SWPy8uxkigBpQzy/DA7HfeC9NKnunA==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr3221241wro.144.1550155971209;
        Thu, 14 Feb 2019 06:52:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:50 -0800 (PST)
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
Subject: [PATCH v4 07/37] ARM: davinci: wrap HW interrupt numbers with a macro
Date:   Thu, 14 Feb 2019 15:52:01 +0100
Message-Id: <20190214145231.8750-8-brgl@bgdev.pl>
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

Once we select SPARSE_IRQ, the interrupt numbers defined in mach/irqs.h
will only signify the hardware interrupt offsets, not the interrupt
numbers seen by linux. Introduce a wrapper macro that translates the
hwirq number to virtual numbers. For now it's just a dummy. Use that
macro when specifying the interrupts in resources for platform devices.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/asp.h                 |   8 +-
 arch/arm/mach-davinci/da830.c               |  12 +-
 arch/arm/mach-davinci/da850.c               |  28 ++--
 arch/arm/mach-davinci/devices-da8xx.c       | 146 ++++++++++----------
 arch/arm/mach-davinci/devices.c             |  31 +++--
 arch/arm/mach-davinci/dm355.c               |  56 ++++----
 arch/arm/mach-davinci/dm365.c               |  80 +++++------
 arch/arm/mach-davinci/dm644x.c              |  46 +++---
 arch/arm/mach-davinci/dm646x.c              |  60 ++++----
 arch/arm/mach-davinci/include/mach/common.h |   3 +
 arch/arm/mach-davinci/irq.c                 |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |   6 +-
 arch/arm/mach-davinci/usb.c                 |   7 +-
 13 files changed, 246 insertions(+), 239 deletions(-)

diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
index 495aa6907cbc..d0ecd1d0f084 100644
--- a/arch/arm/mach-davinci/asp.h
+++ b/arch/arm/mach-davinci/asp.h
@@ -49,9 +49,9 @@
 #define DAVINCI_DA830_DMA_MCASP2_AXEVT	5
 
 /* Interrupts */
-#define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
-#define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
-#define DAVINCI_ASP1_RX_INT	IRQ_MBRINT
-#define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
+#define DAVINCI_ASP0_RX_INT	DAVINCI_INTC_IRQ(IRQ_MBRINT)
+#define DAVINCI_ASP0_TX_INT	DAVINCI_INTC_IRQ(IRQ_MBXINT)
+#define DAVINCI_ASP1_RX_INT	DAVINCI_INTC_IRQ(IRQ_MBRINT)
+#define DAVINCI_ASP1_TX_INT	DAVINCI_INTC_IRQ(IRQ_MBXINT)
 
 #endif /* __ASM_ARCH_DAVINCI_ASP_H */
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 9e18b245266b..aa8da725a325 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -772,17 +772,17 @@ int __init da830_register_gpio(void)
 static struct davinci_timer_instance da830_timer_instance[2] = {
 	{
 		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
 		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_0,
+		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0),
 	},
 	{
 		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
 		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_1,
+		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_1),
 	},
 };
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e823b89e2b7a..d22b19833326 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -439,23 +439,23 @@ static struct davinci_id da850_ids[] = {
 static struct davinci_timer_instance da850_timer_instance[4] = {
 	{
 		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
 	},
 	{
 		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
 	},
 	{
 		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_2,
-		.top_irq	= IRQ_DA850_TINT34_2,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_2),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_2),
 	},
 	{
 		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_3,
-		.top_irq	= IRQ_DA850_TINT34_3,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_3),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_3),
 	},
 };
 
@@ -658,8 +658,8 @@ static struct platform_device da850_vpif_dev = {
 
 static struct resource da850_vpif_display_resource[] = {
 	{
-		.start = IRQ_DA850_VPIFINT,
-		.end   = IRQ_DA850_VPIFINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -677,13 +677,13 @@ static struct platform_device da850_vpif_display_dev = {
 
 static struct resource da850_vpif_capture_resource[] = {
 	{
-		.start = IRQ_DA850_VPIFINT,
-		.end   = IRQ_DA850_VPIFINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
 		.flags = IORESOURCE_IRQ,
 	},
 	{
-		.start = IRQ_DA850_VPIFINT,
-		.end   = IRQ_DA850_VPIFINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index cf78da5ab054..298165095d31 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -64,7 +64,7 @@ void __iomem *da8xx_syscfg1_base;
 static struct plat_serial8250_port da8xx_serial0_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART0_BASE,
-		.irq		= IRQ_DA8XX_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_DA8XX_UARTINT0),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -77,7 +77,7 @@ static struct plat_serial8250_port da8xx_serial0_pdata[] = {
 static struct plat_serial8250_port da8xx_serial1_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART1_BASE,
-		.irq		= IRQ_DA8XX_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_DA8XX_UARTINT1),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -90,7 +90,7 @@ static struct plat_serial8250_port da8xx_serial1_pdata[] = {
 static struct plat_serial8250_port da8xx_serial2_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART2_BASE,
-		.irq		= IRQ_DA8XX_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_DA8XX_UARTINT2),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -171,12 +171,12 @@ static struct resource da8xx_edma0_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_DA8XX_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_CCINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_DA8XX_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_CCERRINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -196,12 +196,12 @@ static struct resource da850_edma1_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_DA850_CCINT1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_CCINT1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_DA850_CCERRINT1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_CCERRINT1),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -306,8 +306,8 @@ static struct resource da8xx_i2c_resources0[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_I2CINT0,
-		.end	= IRQ_DA8XX_I2CINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -326,8 +326,8 @@ static struct resource da8xx_i2c_resources1[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_I2CINT1,
-		.end	= IRQ_DA8XX_I2CINT1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT1),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -382,23 +382,23 @@ static struct resource da8xx_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_RX_THRESH_PULSE,
-		.end	= IRQ_DA8XX_C0_RX_THRESH_PULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_THRESH_PULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_THRESH_PULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_RX_PULSE,
-		.end	= IRQ_DA8XX_C0_RX_PULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_PULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_PULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_TX_PULSE,
-		.end	= IRQ_DA8XX_C0_TX_PULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_TX_PULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_TX_PULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_MISC_PULSE,
-		.end	= IRQ_DA8XX_C0_MISC_PULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_MISC_PULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_MISC_PULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -470,7 +470,7 @@ static struct resource da830_mcasp1_resources[] = {
 	},
 	{
 		.name	= "common",
-		.start	= IRQ_DA8XX_MCASPINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MCASPINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -505,7 +505,7 @@ static struct resource da830_mcasp2_resources[] = {
 	},
 	{
 		.name	= "common",
-		.start	= IRQ_DA8XX_MCASPINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MCASPINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -540,7 +540,7 @@ static struct resource da850_mcasp_resources[] = {
 	},
 	{
 		.name	= "common",
-		.start	= IRQ_DA8XX_MCASPINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MCASPINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -588,43 +588,43 @@ static struct resource da8xx_pruss_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT0,
-		.end	= IRQ_DA8XX_EVTOUT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT1,
-		.end	= IRQ_DA8XX_EVTOUT1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT2,
-		.end	= IRQ_DA8XX_EVTOUT2,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT2),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT2),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT3,
-		.end	= IRQ_DA8XX_EVTOUT3,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT3),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT3),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT4,
-		.end	= IRQ_DA8XX_EVTOUT4,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT4),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT4),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT5,
-		.end	= IRQ_DA8XX_EVTOUT5,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT5),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT5),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT6,
-		.end	= IRQ_DA8XX_EVTOUT6,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT6),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT6),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT7,
-		.end	= IRQ_DA8XX_EVTOUT7,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT7),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT7),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -674,8 +674,8 @@ static struct resource da8xx_lcdc_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = { /* interrupt */
-		.start  = IRQ_DA8XX_LCDINT,
-		.end    = IRQ_DA8XX_LCDINT,
+		.start  = DAVINCI_INTC_IRQ(IRQ_DA8XX_LCDINT),
+		.end    = DAVINCI_INTC_IRQ(IRQ_DA8XX_LCDINT),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -700,48 +700,48 @@ static struct resource da8xx_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{ /* interrupt */
-		.start	= IRQ_DA8XX_GPIO0,
-		.end	= IRQ_DA8XX_GPIO0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO1,
-		.end	= IRQ_DA8XX_GPIO1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO2,
-		.end	= IRQ_DA8XX_GPIO2,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO2),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO2),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO3,
-		.end	= IRQ_DA8XX_GPIO3,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO3),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO3),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO4,
-		.end	= IRQ_DA8XX_GPIO4,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO4),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO4),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO5,
-		.end	= IRQ_DA8XX_GPIO5,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO5),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO5),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO6,
-		.end	= IRQ_DA8XX_GPIO6,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO6),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO6),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO7,
-		.end	= IRQ_DA8XX_GPIO7,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO7),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO7),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO8,
-		.end	= IRQ_DA8XX_GPIO8,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO8),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO8),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -766,8 +766,8 @@ static struct resource da8xx_mmcsd0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{		/* interrupt */
-		.start	= IRQ_DA8XX_MMCSDINT0,
-		.end	= IRQ_DA8XX_MMCSDINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MMCSDINT0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MMCSDINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -793,8 +793,8 @@ static struct resource da850_mmcsd1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{		/* interrupt */
-		.start	= IRQ_DA850_MMCSDINT0_1,
-		.end	= IRQ_DA850_MMCSDINT0_1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_MMCSDINT0_1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA850_MMCSDINT0_1),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -845,8 +845,8 @@ static struct resource da8xx_rproc_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{ /* dsp irq */
-		.start		= IRQ_DA8XX_CHIPINT0,
-		.end		= IRQ_DA8XX_CHIPINT0,
+		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_CHIPINT0),
+		.end		= DAVINCI_INTC_IRQ(IRQ_DA8XX_CHIPINT0),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -936,13 +936,13 @@ static struct resource da8xx_rtc_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{ /* timer irq */
-		.start		= IRQ_DA8XX_RTC,
-		.end		= IRQ_DA8XX_RTC,
+		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
+		.end		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
 		.flags		= IORESOURCE_IRQ,
 	},
 	{ /* alarm irq */
-		.start		= IRQ_DA8XX_RTC,
-		.end		= IRQ_DA8XX_RTC,
+		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
+		.end		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -1009,8 +1009,8 @@ static struct resource da8xx_spi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_DA8XX_SPINT0,
-		.end	= IRQ_DA8XX_SPINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -1022,8 +1022,8 @@ static struct resource da8xx_spi1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_DA8XX_SPINT1,
-		.end	= IRQ_DA8XX_SPINT1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT1),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -1103,7 +1103,7 @@ static struct resource da850_sata_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA850_SATAINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_SATAINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index e8dbbb7479ab..722c463f9b18 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -56,7 +56,7 @@ static struct resource i2c_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= IRQ_I2C,
+		.start		= DAVINCI_INTC_IRQ(IRQ_I2C),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -84,8 +84,8 @@ static struct resource ide_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= IRQ_IDE,
-		.end		= IRQ_IDE,
+		.start		= DAVINCI_INTC_IRQ(IRQ_IDE),
+		.end		= DAVINCI_INTC_IRQ(IRQ_IDE),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -133,11 +133,11 @@ static struct resource mmcsd0_resources[] = {
 	},
 	/* IRQs:  MMC/SD, then SDIO */
 	{
-		.start = IRQ_MMCINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_MMCINT),
 		.flags = IORESOURCE_IRQ,
 	}, {
 		/* different on dm355 */
-		.start = IRQ_SDIOINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_SDIOINT),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -163,10 +163,10 @@ static struct resource mmcsd1_resources[] = {
 	},
 	/* IRQs:  MMC/SD, then SDIO */
 	{
-		.start = IRQ_DM355_MMCINT1,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM355_MMCINT1),
 		.flags = IORESOURCE_IRQ,
 	}, {
-		.start = IRQ_DM355_SDIOINT1,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM355_SDIOINT1),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -219,7 +219,8 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
 			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
 							SZ_4K - 1;
-			mmcsd1_resources[2].start = IRQ_DM365_SDIOINT1;
+			mmcsd1_resources[2].start = DAVINCI_INTC_IRQ(
+							IRQ_DM365_SDIOINT1);
 			davinci_mmcsd1_device.name = "da830-mmc";
 		} else
 			break;
@@ -230,7 +231,8 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 		if (cpu_is_davinci_dm355()) {
 			mmcsd0_resources[0].start = DM355_MMCSD0_BASE;
 			mmcsd0_resources[0].end = DM355_MMCSD0_BASE + SZ_4K - 1;
-			mmcsd0_resources[2].start = IRQ_DM355_SDIOINT0;
+			mmcsd0_resources[2].start = DAVINCI_INTC_IRQ(
+							IRQ_DM355_SDIOINT0);
 
 			/* expose all 6 MMC0 signals:  CLK, CMD, DATA[0..3] */
 			davinci_cfg_reg(DM355_MMCSD0);
@@ -241,7 +243,8 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd0_resources[0].start = DM365_MMCSD0_BASE;
 			mmcsd0_resources[0].end = DM365_MMCSD0_BASE +
 							SZ_4K - 1;
-			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT0;
+			mmcsd0_resources[2].start = DAVINCI_INTC_IRQ(
+							IRQ_DM365_SDIOINT0);
 			davinci_mmcsd0_device.name = "da830-mmc";
 		} else if (cpu_is_davinci_dm644x()) {
 			/* REVISIT: should this be in board-init code? */
@@ -313,13 +316,13 @@ int davinci_gpio_register(struct resource *res, int size, void *pdata)
 struct davinci_timer_instance davinci_timer_instance[2] = {
 	{
 		.base		= DAVINCI_TIMER0_BASE,
-		.bottom_irq	= IRQ_TINT0_TINT12,
-		.top_irq	= IRQ_TINT0_TINT34,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34),
 	},
 	{
 		.base		= DAVINCI_TIMER1_BASE,
-		.bottom_irq	= IRQ_TINT1_TINT12,
-		.top_irq	= IRQ_TINT1_TINT34,
+		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_TINT1_TINT12),
+		.top_irq	= DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34),
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 03ce5df28d87..cb725244fa13 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -53,7 +53,7 @@ static struct resource dm355_spi0_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_DM355_SPINT0_0,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM355_SPINT0_0),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -273,12 +273,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCERRINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using (or muxing) TC*_ERR */
@@ -358,13 +358,13 @@ static struct platform_device dm355_vpss_device = {
 
 static struct resource vpfe_resources[] = {
 	{
-		.start          = IRQ_VDINT0,
-		.end            = IRQ_VDINT0,
+		.start          = DAVINCI_INTC_IRQ(IRQ_VDINT0),
+		.end            = DAVINCI_INTC_IRQ(IRQ_VDINT0),
 		.flags          = IORESOURCE_IRQ,
 	},
 	{
-		.start          = IRQ_VDINT1,
-		.end            = IRQ_VDINT1,
+		.start          = DAVINCI_INTC_IRQ(IRQ_VDINT1),
+		.end            = DAVINCI_INTC_IRQ(IRQ_VDINT1),
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -422,8 +422,8 @@ static struct platform_device dm355_osd_dev = {
 
 static struct resource dm355_venc_resources[] = {
 	{
-		.start	= IRQ_VENCINT,
-		.end	= IRQ_VENCINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_VENCINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_VENCINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
@@ -442,8 +442,8 @@ static struct resource dm355_venc_resources[] = {
 
 static struct resource dm355_v4l2_disp_resources[] = {
 	{
-		.start	= IRQ_VENCINT,
-		.end	= IRQ_VENCINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_VENCINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_VENCINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
@@ -547,38 +547,38 @@ static struct resource dm355_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_DM355_GPIOBNK0,
-		.end	= IRQ_DM355_GPIOBNK0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK1,
-		.end	= IRQ_DM355_GPIOBNK1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK2,
-		.end	= IRQ_DM355_GPIOBNK2,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK2),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK2),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK3,
-		.end	= IRQ_DM355_GPIOBNK3,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK3),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK3),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK4,
-		.end	= IRQ_DM355_GPIOBNK4,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK4),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK4),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK5,
-		.end	= IRQ_DM355_GPIOBNK5,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK5),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK5),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK6,
-		.end	= IRQ_DM355_GPIOBNK6,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK6),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM355_GPIOBNK6),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -632,7 +632,7 @@ static struct davinci_timer_info dm355_timer_info = {
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT0),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -645,7 +645,7 @@ static struct plat_serial8250_port dm355_serial0_platform_data[] = {
 static struct plat_serial8250_port dm355_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT1),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -658,7 +658,7 @@ static struct plat_serial8250_port dm355_serial1_platform_data[] = {
 static struct plat_serial8250_port dm355_serial2_platform_data[] = {
 	{
 		.mapbase	= DM355_UART2_BASE,
-		.irq		= IRQ_DM355_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_DM355_UARTINT2),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 3e034f0478d2..ae1b53ea956a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -224,7 +224,7 @@ static struct resource dm365_spi0_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_DM365_SPIINT0_0,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM365_SPIINT0_0),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -266,43 +266,43 @@ static struct resource dm365_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_DM365_GPIO0,
-		.end	= IRQ_DM365_GPIO0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO1,
-		.end	= IRQ_DM365_GPIO1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO2,
-		.end	= IRQ_DM365_GPIO2,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO2),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO2),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO3,
-		.end	= IRQ_DM365_GPIO3,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO3),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO3),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO4,
-		.end	= IRQ_DM365_GPIO4,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO4),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO4),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO5,
-		.end	= IRQ_DM365_GPIO5,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO5),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO5),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO6,
-		.end	= IRQ_DM365_GPIO6,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO6),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO6),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO7,
-		.end	= IRQ_DM365_GPIO7,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO7),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_GPIO7),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -336,23 +336,23 @@ static struct resource dm365_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_RXTHRESH,
-		.end	= IRQ_DM365_EMAC_RXTHRESH,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_RXTHRESH),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_RXTHRESH),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_RXPULSE,
-		.end	= IRQ_DM365_EMAC_RXPULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_RXPULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_RXPULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_TXPULSE,
-		.end	= IRQ_DM365_EMAC_TXPULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_TXPULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_TXPULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_MISCPULSE,
-		.end	= IRQ_DM365_EMAC_MISCPULSE,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_MISCPULSE),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM365_EMAC_MISCPULSE),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -518,12 +518,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCERRINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using TC*_ERR */
@@ -597,7 +597,7 @@ static struct resource dm365_rtc_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_DM365_RTCINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM365_RTCINT),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -627,8 +627,8 @@ static struct resource dm365_ks_resources[] = {
 	},
 	{
 		/* interrupt */
-		.start = IRQ_DM365_KEYINT,
-		.end = IRQ_DM365_KEYINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM365_KEYINT),
+		.end = DAVINCI_INTC_IRQ(IRQ_DM365_KEYINT),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -669,7 +669,7 @@ static struct davinci_timer_info dm365_timer_info = {
 static struct plat_serial8250_port dm365_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT0),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -682,7 +682,7 @@ static struct plat_serial8250_port dm365_serial0_platform_data[] = {
 static struct plat_serial8250_port dm365_serial1_platform_data[] = {
 	{
 		.mapbase	= DM365_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT1),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -821,13 +821,13 @@ static struct platform_device dm365_vpss_device = {
 
 static struct resource vpfe_resources[] = {
 	{
-		.start          = IRQ_VDINT0,
-		.end            = IRQ_VDINT0,
+		.start          = DAVINCI_INTC_IRQ(IRQ_VDINT0),
+		.end            = DAVINCI_INTC_IRQ(IRQ_VDINT0),
 		.flags          = IORESOURCE_IRQ,
 	},
 	{
-		.start          = IRQ_VDINT1,
-		.end            = IRQ_VDINT1,
+		.start          = DAVINCI_INTC_IRQ(IRQ_VDINT1),
+		.end            = DAVINCI_INTC_IRQ(IRQ_VDINT1),
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -908,8 +908,8 @@ static struct platform_device dm365_osd_dev = {
 
 static struct resource dm365_venc_resources[] = {
 	{
-		.start = IRQ_VENCINT,
-		.end   = IRQ_VENCINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_VENCINT),
+		.end   = DAVINCI_INTC_IRQ(IRQ_VENCINT),
 		.flags = IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
@@ -928,8 +928,8 @@ static struct resource dm365_venc_resources[] = {
 
 static struct resource dm365_v4l2_disp_resources[] = {
 	{
-		.start = IRQ_VENCINT,
-		.end   = IRQ_VENCINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_VENCINT),
+		.end   = DAVINCI_INTC_IRQ(IRQ_VENCINT),
 		.flags = IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 66bab4782c62..5ccb49196a71 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -59,8 +59,8 @@ static struct resource dm644x_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_EMACINT,
-		.end   = IRQ_EMACINT,
+		.start = DAVINCI_INTC_IRQ(IRQ_EMACINT),
+		.end   = DAVINCI_INTC_IRQ(IRQ_EMACINT),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -260,12 +260,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCERRINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using TC*_ERR */
@@ -330,13 +330,13 @@ static struct platform_device dm644x_vpss_device = {
 
 static struct resource dm644x_vpfe_resources[] = {
 	{
-		.start          = IRQ_VDINT0,
-		.end            = IRQ_VDINT0,
+		.start          = DAVINCI_INTC_IRQ(IRQ_VDINT0),
+		.end            = DAVINCI_INTC_IRQ(IRQ_VDINT0),
 		.flags          = IORESOURCE_IRQ,
 	},
 	{
-		.start          = IRQ_VDINT1,
-		.end            = IRQ_VDINT1,
+		.start          = DAVINCI_INTC_IRQ(IRQ_VDINT1),
+		.end            = DAVINCI_INTC_IRQ(IRQ_VDINT1),
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -442,8 +442,8 @@ static int dm644x_venc_setup_clock(enum vpbe_enc_timings_type type,
 
 static struct resource dm644x_v4l2_disp_resources[] = {
 	{
-		.start	= IRQ_VENCINT,
-		.end	= IRQ_VENCINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_VENCINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_VENCINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -491,28 +491,28 @@ static struct resource dm644_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_GPIOBNK0,
-		.end	= IRQ_GPIOBNK0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK1,
-		.end	= IRQ_GPIOBNK1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK2,
-		.end	= IRQ_GPIOBNK2,
+		.start	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK2),
+		.end	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK2),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK3,
-		.end	= IRQ_GPIOBNK3,
+		.start	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK3),
+		.end	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK3),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK4,
-		.end	= IRQ_GPIOBNK4,
+		.start	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK4),
+		.end	= DAVINCI_INTC_IRQ(IRQ_GPIOBNK4),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -573,7 +573,7 @@ static struct davinci_timer_info dm644x_timer_info = {
 static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT0),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -586,7 +586,7 @@ static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
 static struct plat_serial8250_port dm644x_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT1),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -599,7 +599,7 @@ static struct plat_serial8250_port dm644x_serial1_platform_data[] = {
 static struct plat_serial8250_port dm644x_serial2_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART2_BASE,
-		.irq		= IRQ_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT2),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 45efa715a2c1..2b55625e8fb5 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -62,23 +62,23 @@ static struct resource dm646x_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DM646X_EMACRXTHINT,
-		.end	= IRQ_DM646X_EMACRXTHINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACRXTHINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACRXTHINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_EMACRXINT,
-		.end	= IRQ_DM646X_EMACRXINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACRXINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACRXINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_EMACTXINT,
-		.end	= IRQ_DM646X_EMACTXINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACTXINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACTXINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_EMACMISCINT,
-		.end	= IRQ_DM646X_EMACMISCINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACMISCINT),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_EMACMISCINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -273,12 +273,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCINT0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_CCERRINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using TC*_ERR */
@@ -315,12 +315,12 @@ static struct resource dm646x_mcasp0_resources[] = {
 	},
 	{
 		.name	= "tx",
-		.start	= IRQ_DM646X_MCASP0TXINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_MCASP0TXINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "rx",
-		.start	= IRQ_DM646X_MCASP0RXINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_MCASP0RXINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -341,7 +341,7 @@ static struct resource dm646x_mcasp1_resources[] = {
 	},
 	{
 		.name	= "tx",
-		.start	= IRQ_DM646X_MCASP1TXINT,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_MCASP1TXINT),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -388,13 +388,13 @@ static struct platform_device vpif_dev = {
 
 static struct resource vpif_display_resource[] = {
 	{
-		.start = IRQ_DM646X_VP_VERTINT2,
-		.end   = IRQ_DM646X_VP_VERTINT2,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT2),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT2),
 		.flags = IORESOURCE_IRQ,
 	},
 	{
-		.start = IRQ_DM646X_VP_VERTINT3,
-		.end   = IRQ_DM646X_VP_VERTINT3,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT3),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT3),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -412,13 +412,13 @@ static struct platform_device vpif_display_dev = {
 
 static struct resource vpif_capture_resource[] = {
 	{
-		.start = IRQ_DM646X_VP_VERTINT0,
-		.end   = IRQ_DM646X_VP_VERTINT0,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT0),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT0),
 		.flags = IORESOURCE_IRQ,
 	},
 	{
-		.start = IRQ_DM646X_VP_VERTINT1,
-		.end   = IRQ_DM646X_VP_VERTINT1,
+		.start = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT1),
+		.end   = DAVINCI_INTC_IRQ(IRQ_DM646X_VP_VERTINT1),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -441,18 +441,18 @@ static struct resource dm646x_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_DM646X_GPIOBNK0,
-		.end	= IRQ_DM646X_GPIOBNK0,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_GPIOBNK0),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_GPIOBNK0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_GPIOBNK1,
-		.end	= IRQ_DM646X_GPIOBNK1,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_GPIOBNK1),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_GPIOBNK1),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_GPIOBNK2,
-		.end	= IRQ_DM646X_GPIOBNK2,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DM646X_GPIOBNK2),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DM646X_GPIOBNK2),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -513,7 +513,7 @@ static struct davinci_timer_info dm646x_timer_info = {
 static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT0),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
@@ -526,7 +526,7 @@ static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
 static struct plat_serial8250_port dm646x_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_UARTINT1),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
@@ -539,7 +539,7 @@ static struct plat_serial8250_port dm646x_serial1_platform_data[] = {
 static struct plat_serial8250_port dm646x_serial2_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART2_BASE,
-		.irq		= IRQ_DM646X_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(IRQ_DM646X_UARTINT2),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 3d45b73b9a64..d840023eaaac 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -17,6 +17,9 @@
 #include <linux/types.h>
 #include <linux/reboot.h>
 
+#define DAVINCI_INTC_START		0
+#define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
+
 void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index b27b90dc269c..80bf99c8fa55 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -154,6 +154,6 @@ void __init davinci_irq_init(void)
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
 		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
-	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
 	set_handle_irq(davinci_handle_irq);
 }
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index c17ce66a3d95..2de5a04ffc24 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -70,7 +70,7 @@ static struct resource da8xx_usb20_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= IRQ_DA8XX_USB_INT,
+		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_USB_INT),
 		.flags		= IORESOURCE_IRQ,
 		.name		= "mc",
 	},
@@ -105,8 +105,8 @@ static struct resource da8xx_usb11_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_DA8XX_IRQN,
-		.end	= IRQ_DA8XX_IRQN,
+		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_IRQN),
+		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_IRQN),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 31ed7aa47227..9d4a58a3113a 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -38,7 +38,7 @@ static struct resource usb_resources[] = {
 		.flags          = IORESOURCE_MEM,
 	},
 	{
-		.start          = IRQ_USBINT,
+		.start          = DAVINCI_INTC_IRQ(IRQ_USBINT),
 		.flags          = IORESOURCE_IRQ,
 		.name		= "mc"
 	},
@@ -70,8 +70,9 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
 
 	if (cpu_is_davinci_dm646x()) {
 		/* Override the defaults as DM6467 uses different IRQs. */
-		usb_dev.resource[1].start = IRQ_DM646X_USBINT;
-		usb_dev.resource[2].start = IRQ_DM646X_USBDMAINT;
+		usb_dev.resource[1].start = DAVINCI_INTC_IRQ(IRQ_DM646X_USBINT);
+		usb_dev.resource[2].start = DAVINCI_INTC_IRQ(
+							IRQ_DM646X_USBDMAINT);
 	} else	/* other devices don't have dedicated CPPI IRQ */
 		usb_dev.num_resources = 2;
 
-- 
2.20.1

