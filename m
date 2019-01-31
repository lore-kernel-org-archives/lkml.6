Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C92085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tN93PNXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfAaNkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387884AbfAaNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so3389527wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JE167iruojMcj//oSVyp9MKJElJ70DgO5ByMSFKSYQ=;
        b=tN93PNXp/QTYofd973QlJFrFsCGVCi50IMz2JMdsPvg7W7sHwry1FdIY8eb1MFhNIw
         D7ZDj9xxdXB2u2g0WjxGa1L789+ARc3vGGletCc8KCmV0a5HKVvTOtd0/rkAuAFliOd+
         nUZoKTivjyOcWgw4xLMUU3hp4/ra2zX0Ypa0Fhp/+itf8BZV0MmvSzna6ZfS4jCKPqp7
         37k+sGg6yUNFSuukhcAzud8Z2SXH2rZKqDvtCoOujEScF9VXVWkpv7+LyNJr8d5+Mses
         /I/jfwhbxtAWh3wOFx1TY4EJdRmTRe0+LKkK69maoDZqR/Hz6gV+AKcyynBcFQ6gRXcR
         Lo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JE167iruojMcj//oSVyp9MKJElJ70DgO5ByMSFKSYQ=;
        b=d34/exv2ptaM2MsyZJpp6qRri5W024OEleVA7u4cvSDmOXY4slm447rWg3i8a2/FWp
         ZmhSNKaKoDCCRGQ0e/U8DUdNaX9oR9t4/5dHAj+q+1rnkyx1vpWyzPJHM/1KIU7m9a0O
         CYwncb+LpOEHVpqR2WKWh8cK7IOVHHz/yUZ78JFE1veL2Pbrdk6Eubi5WkLW9LZDCdSv
         jALM7QPw7X3oLkV6DtJRc4NMvtUmv4rLMfJVVeXYMieZ2AuT4ENJZ1xoj4wdZv6YuVKv
         tdVJJscLwDZsOQRbHiH+WZH/KFLjK3ShlH1Uj18VDIVyLJ2jKv0TB5dH+x8uM8vHdpiz
         aWuA==
X-Gm-Message-State: AJcUukdCW3ahun+TmGvt1ZkUo8iNYMItfVctaPIhVrFgEuEn9DEwd3tb
        AoZdjAubbLbG7fCyzKSFLGj9OA==
X-Google-Smtp-Source: ALg8bN6h0pHK8LZrFqLpj2J1uz/uVQcicyBSnw8UYz9QgsehumDKmCnIAfIEOp/yRWUqLFFORU37Ow==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr33052861wre.41.1548942021598;
        Thu, 31 Jan 2019 05:40:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 34/35] ARM: davinci: stop using defines from mach/irqs.h
Date:   Thu, 31 Jan 2019 14:39:27 +0100
Message-Id: <20190131133928.17985-35-brgl@bgdev.pl>
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

As the second step in preparation for mach/irqs.h removal - replace
all constants defined there with the DAVINCI_INTC_IRQ() macro which
takes the NR_IRQS offset into account.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/asp.h           |   8 +-
 arch/arm/mach-davinci/da830.c         |  12 +--
 arch/arm/mach-davinci/da850.c         |  28 ++---
 arch/arm/mach-davinci/devices-da8xx.c | 146 +++++++++++++-------------
 arch/arm/mach-davinci/devices.c       |  30 +++---
 arch/arm/mach-davinci/dm355.c         |  56 +++++-----
 arch/arm/mach-davinci/dm365.c         |  80 +++++++-------
 arch/arm/mach-davinci/dm644x.c        |  48 ++++-----
 arch/arm/mach-davinci/dm646x.c        |  62 +++++------
 arch/arm/mach-davinci/usb-da8xx.c     |   6 +-
 arch/arm/mach-davinci/usb.c           |   6 +-
 11 files changed, 241 insertions(+), 241 deletions(-)

diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
index 495aa6907cbc..17013e27152e 100644
--- a/arch/arm/mach-davinci/asp.h
+++ b/arch/arm/mach-davinci/asp.h
@@ -49,9 +49,9 @@
 #define DAVINCI_DA830_DMA_MCASP2_AXEVT	5
 
 /* Interrupts */
-#define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
-#define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
-#define DAVINCI_ASP1_RX_INT	IRQ_MBRINT
-#define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
+#define DAVINCI_ASP0_RX_INT	DAVINCI_INTC_IRQ(25)
+#define DAVINCI_ASP0_TX_INT	DAVINCI_INTC_IRQ(24)
+#define DAVINCI_ASP1_RX_INT	DAVINCI_INTC_IRQ(25)
+#define DAVINCI_ASP1_TX_INT	DAVINCI_INTC_IRQ(24)
 
 #endif /* __ASM_ARCH_DAVINCI_ASP_H */
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 74cbab153e59..a8407c1d1a68 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -678,17 +678,17 @@ int __init da830_register_gpio(void)
 static struct davinci_timer_instance da830_timer_instance[2] = {
 	{
 		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
+		.bottom_irq	= DAVINCI_INTC_IRQ(21),
+		.top_irq	= DAVINCI_INTC_IRQ(22),
 		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_0,
+		.cmp_irq	= DAVINCI_INTC_IRQ(74),
 	},
 	{
 		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
+		.bottom_irq	= DAVINCI_INTC_IRQ(23),
+		.top_irq	= DAVINCI_INTC_IRQ(24),
 		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_1,
+		.cmp_irq	= DAVINCI_INTC_IRQ(82),
 	},
 };
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 644f4eec8d5c..84b30c70ddf1 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -335,23 +335,23 @@ static struct davinci_id da850_ids[] = {
 static struct davinci_timer_instance da850_timer_instance[4] = {
 	{
 		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
+		.bottom_irq	= DAVINCI_INTC_IRQ(21),
+		.top_irq	= DAVINCI_INTC_IRQ(22),
 	},
 	{
 		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
+		.bottom_irq	= DAVINCI_INTC_IRQ(23),
+		.top_irq	= DAVINCI_INTC_IRQ(24),
 	},
 	{
 		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_2,
-		.top_irq	= IRQ_DA850_TINT34_2,
+		.bottom_irq	= DAVINCI_INTC_IRQ(68),
+		.top_irq	= DAVINCI_INTC_IRQ(68),
 	},
 	{
 		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_3,
-		.top_irq	= IRQ_DA850_TINT34_3,
+		.bottom_irq	= DAVINCI_INTC_IRQ(96),
+		.top_irq	= DAVINCI_INTC_IRQ(96),
 	},
 };
 
@@ -554,8 +554,8 @@ static struct platform_device da850_vpif_dev = {
 
 static struct resource da850_vpif_display_resource[] = {
 	{
-		.start = IRQ_DA850_VPIFINT,
-		.end   = IRQ_DA850_VPIFINT,
+		.start = DAVINCI_INTC_IRQ(92),
+		.end   = DAVINCI_INTC_IRQ(92),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -573,13 +573,13 @@ static struct platform_device da850_vpif_display_dev = {
 
 static struct resource da850_vpif_capture_resource[] = {
 	{
-		.start = IRQ_DA850_VPIFINT,
-		.end   = IRQ_DA850_VPIFINT,
+		.start = DAVINCI_INTC_IRQ(92),
+		.end   = DAVINCI_INTC_IRQ(92),
 		.flags = IORESOURCE_IRQ,
 	},
 	{
-		.start = IRQ_DA850_VPIFINT,
-		.end   = IRQ_DA850_VPIFINT,
+		.start = DAVINCI_INTC_IRQ(92),
+		.end   = DAVINCI_INTC_IRQ(92),
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 65edd2aa9db5..fda6d35c415c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -65,7 +65,7 @@ void __iomem *da8xx_syscfg1_base;
 static struct plat_serial8250_port da8xx_serial0_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART0_BASE,
-		.irq		= IRQ_DA8XX_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(25),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -78,7 +78,7 @@ static struct plat_serial8250_port da8xx_serial0_pdata[] = {
 static struct plat_serial8250_port da8xx_serial1_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART1_BASE,
-		.irq		= IRQ_DA8XX_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(53),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -91,7 +91,7 @@ static struct plat_serial8250_port da8xx_serial1_pdata[] = {
 static struct plat_serial8250_port da8xx_serial2_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART2_BASE,
-		.irq		= IRQ_DA8XX_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(61),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -172,12 +172,12 @@ static struct resource da8xx_edma0_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_DA8XX_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(11),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_DA8XX_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(12),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -197,12 +197,12 @@ static struct resource da850_edma1_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_DA850_CCINT1,
+		.start	= DAVINCI_INTC_IRQ(93),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_DA850_CCERRINT1,
+		.start	= DAVINCI_INTC_IRQ(94),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -307,8 +307,8 @@ static struct resource da8xx_i2c_resources0[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_I2CINT0,
-		.end	= IRQ_DA8XX_I2CINT0,
+		.start	= DAVINCI_INTC_IRQ(15),
+		.end	= DAVINCI_INTC_IRQ(15),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -327,8 +327,8 @@ static struct resource da8xx_i2c_resources1[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_I2CINT1,
-		.end	= IRQ_DA8XX_I2CINT1,
+		.start	= DAVINCI_INTC_IRQ(51),
+		.end	= DAVINCI_INTC_IRQ(51),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -383,23 +383,23 @@ static struct resource da8xx_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_RX_THRESH_PULSE,
-		.end	= IRQ_DA8XX_C0_RX_THRESH_PULSE,
+		.start	= DAVINCI_INTC_IRQ(33),
+		.end	= DAVINCI_INTC_IRQ(33),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_RX_PULSE,
-		.end	= IRQ_DA8XX_C0_RX_PULSE,
+		.start	= DAVINCI_INTC_IRQ(34),
+		.end	= DAVINCI_INTC_IRQ(34),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_TX_PULSE,
-		.end	= IRQ_DA8XX_C0_TX_PULSE,
+		.start	= DAVINCI_INTC_IRQ(35),
+		.end	= DAVINCI_INTC_IRQ(35),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_C0_MISC_PULSE,
-		.end	= IRQ_DA8XX_C0_MISC_PULSE,
+		.start	= DAVINCI_INTC_IRQ(36),
+		.end	= DAVINCI_INTC_IRQ(36),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -471,7 +471,7 @@ static struct resource da830_mcasp1_resources[] = {
 	},
 	{
 		.name	= "common",
-		.start	= IRQ_DA8XX_MCASPINT,
+		.start	= DAVINCI_INTC_IRQ(54),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -506,7 +506,7 @@ static struct resource da830_mcasp2_resources[] = {
 	},
 	{
 		.name	= "common",
-		.start	= IRQ_DA8XX_MCASPINT,
+		.start	= DAVINCI_INTC_IRQ(54),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -541,7 +541,7 @@ static struct resource da850_mcasp_resources[] = {
 	},
 	{
 		.name	= "common",
-		.start	= IRQ_DA8XX_MCASPINT,
+		.start	= DAVINCI_INTC_IRQ(54),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -589,43 +589,43 @@ static struct resource da8xx_pruss_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT0,
-		.end	= IRQ_DA8XX_EVTOUT0,
+		.start	= DAVINCI_INTC_IRQ(3),
+		.end	= DAVINCI_INTC_IRQ(3),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT1,
-		.end	= IRQ_DA8XX_EVTOUT1,
+		.start	= DAVINCI_INTC_IRQ(4),
+		.end	= DAVINCI_INTC_IRQ(4),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT2,
-		.end	= IRQ_DA8XX_EVTOUT2,
+		.start	= DAVINCI_INTC_IRQ(5),
+		.end	= DAVINCI_INTC_IRQ(5),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT3,
-		.end	= IRQ_DA8XX_EVTOUT3,
+		.start	= DAVINCI_INTC_IRQ(6),
+		.end	= DAVINCI_INTC_IRQ(6),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT4,
-		.end	= IRQ_DA8XX_EVTOUT4,
+		.start	= DAVINCI_INTC_IRQ(7),
+		.end	= DAVINCI_INTC_IRQ(7),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT5,
-		.end	= IRQ_DA8XX_EVTOUT5,
+		.start	= DAVINCI_INTC_IRQ(8),
+		.end	= DAVINCI_INTC_IRQ(8),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT6,
-		.end	= IRQ_DA8XX_EVTOUT6,
+		.start	= DAVINCI_INTC_IRQ(9),
+		.end	= DAVINCI_INTC_IRQ(9),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_EVTOUT7,
-		.end	= IRQ_DA8XX_EVTOUT7,
+		.start	= DAVINCI_INTC_IRQ(10),
+		.end	= DAVINCI_INTC_IRQ(10),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -675,8 +675,8 @@ static struct resource da8xx_lcdc_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = { /* interrupt */
-		.start  = IRQ_DA8XX_LCDINT,
-		.end    = IRQ_DA8XX_LCDINT,
+		.start  = DAVINCI_INTC_IRQ(52),
+		.end    = DAVINCI_INTC_IRQ(52),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -701,48 +701,48 @@ static struct resource da8xx_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{ /* interrupt */
-		.start	= IRQ_DA8XX_GPIO0,
-		.end	= IRQ_DA8XX_GPIO0,
+		.start	= DAVINCI_INTC_IRQ(42),
+		.end	= DAVINCI_INTC_IRQ(42),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO1,
-		.end	= IRQ_DA8XX_GPIO1,
+		.start	= DAVINCI_INTC_IRQ(43),
+		.end	= DAVINCI_INTC_IRQ(43),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO2,
-		.end	= IRQ_DA8XX_GPIO2,
+		.start	= DAVINCI_INTC_IRQ(44),
+		.end	= DAVINCI_INTC_IRQ(44),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO3,
-		.end	= IRQ_DA8XX_GPIO3,
+		.start	= DAVINCI_INTC_IRQ(45),
+		.end	= DAVINCI_INTC_IRQ(45),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO4,
-		.end	= IRQ_DA8XX_GPIO4,
+		.start	= DAVINCI_INTC_IRQ(46),
+		.end	= DAVINCI_INTC_IRQ(46),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO5,
-		.end	= IRQ_DA8XX_GPIO5,
+		.start	= DAVINCI_INTC_IRQ(47),
+		.end	= DAVINCI_INTC_IRQ(47),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO6,
-		.end	= IRQ_DA8XX_GPIO6,
+		.start	= DAVINCI_INTC_IRQ(48),
+		.end	= DAVINCI_INTC_IRQ(48),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO7,
-		.end	= IRQ_DA8XX_GPIO7,
+		.start	= DAVINCI_INTC_IRQ(49),
+		.end	= DAVINCI_INTC_IRQ(49),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DA8XX_GPIO8,
-		.end	= IRQ_DA8XX_GPIO8,
+		.start	= DAVINCI_INTC_IRQ(50),
+		.end	= DAVINCI_INTC_IRQ(50),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -767,8 +767,8 @@ static struct resource da8xx_mmcsd0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{		/* interrupt */
-		.start	= IRQ_DA8XX_MMCSDINT0,
-		.end	= IRQ_DA8XX_MMCSDINT0,
+		.start	= DAVINCI_INTC_IRQ(16),
+		.end	= DAVINCI_INTC_IRQ(16),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -794,8 +794,8 @@ static struct resource da850_mmcsd1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{		/* interrupt */
-		.start	= IRQ_DA850_MMCSDINT0_1,
-		.end	= IRQ_DA850_MMCSDINT0_1,
+		.start	= DAVINCI_INTC_IRQ(72),
+		.end	= DAVINCI_INTC_IRQ(72),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -846,8 +846,8 @@ static struct resource da8xx_rproc_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{ /* dsp irq */
-		.start		= IRQ_DA8XX_CHIPINT0,
-		.end		= IRQ_DA8XX_CHIPINT0,
+		.start		= DAVINCI_INTC_IRQ(28),
+		.end		= DAVINCI_INTC_IRQ(28),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -937,13 +937,13 @@ static struct resource da8xx_rtc_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{ /* timer irq */
-		.start		= IRQ_DA8XX_RTC,
-		.end		= IRQ_DA8XX_RTC,
+		.start		= DAVINCI_INTC_IRQ(19),
+		.end		= DAVINCI_INTC_IRQ(19),
 		.flags		= IORESOURCE_IRQ,
 	},
 	{ /* alarm irq */
-		.start		= IRQ_DA8XX_RTC,
-		.end		= IRQ_DA8XX_RTC,
+		.start		= DAVINCI_INTC_IRQ(19),
+		.end		= DAVINCI_INTC_IRQ(19),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -1010,8 +1010,8 @@ static struct resource da8xx_spi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_DA8XX_SPINT0,
-		.end	= IRQ_DA8XX_SPINT0,
+		.start	= DAVINCI_INTC_IRQ(20),
+		.end	= DAVINCI_INTC_IRQ(20),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -1023,8 +1023,8 @@ static struct resource da8xx_spi1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_DA8XX_SPINT1,
-		.end	= IRQ_DA8XX_SPINT1,
+		.start	= DAVINCI_INTC_IRQ(56),
+		.end	= DAVINCI_INTC_IRQ(56),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -1104,7 +1104,7 @@ static struct resource da850_sata_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DA850_SATAINT,
+		.start	= DAVINCI_INTC_IRQ(67),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index e8dbbb7479ab..b8e5c5998872 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -56,7 +56,7 @@ static struct resource i2c_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= IRQ_I2C,
+		.start		= DAVINCI_INTC_IRQ(39),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -84,8 +84,8 @@ static struct resource ide_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= IRQ_IDE,
-		.end		= IRQ_IDE,
+		.start		= DAVINCI_INTC_IRQ(22),
+		.end		= DAVINCI_INTC_IRQ(22),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -110,7 +110,7 @@ void __init davinci_init_ide(void)
 		davinci_cfg_reg(DM644X_ATAEN);
 		davinci_cfg_reg(DM644X_HDIREN);
 	} else if (cpu_is_davinci_dm646x()) {
-		/* IRQ_DM646X_IDE is the same as IRQ_IDE */
+		/* DAVINCI_INTC_IRQ(22) is the same as DAVINCI_INTC_IRQ(22) */
 		davinci_cfg_reg(DM646X_ATAEN);
 	} else {
 		WARN_ON(1);
@@ -133,11 +133,11 @@ static struct resource mmcsd0_resources[] = {
 	},
 	/* IRQs:  MMC/SD, then SDIO */
 	{
-		.start = IRQ_MMCINT,
+		.start = DAVINCI_INTC_IRQ(26),
 		.flags = IORESOURCE_IRQ,
 	}, {
 		/* different on dm355 */
-		.start = IRQ_SDIOINT,
+		.start = DAVINCI_INTC_IRQ(27),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -163,10 +163,10 @@ static struct resource mmcsd1_resources[] = {
 	},
 	/* IRQs:  MMC/SD, then SDIO */
 	{
-		.start = IRQ_DM355_MMCINT1,
+		.start = DAVINCI_INTC_IRQ(27),
 		.flags = IORESOURCE_IRQ,
 	}, {
-		.start = IRQ_DM355_SDIOINT1,
+		.start = DAVINCI_INTC_IRQ(31),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -219,7 +219,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
 			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
 							SZ_4K - 1;
-			mmcsd1_resources[2].start = IRQ_DM365_SDIOINT1;
+			mmcsd1_resources[2].start = DAVINCI_INTC_IRQ(31);
 			davinci_mmcsd1_device.name = "da830-mmc";
 		} else
 			break;
@@ -230,7 +230,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 		if (cpu_is_davinci_dm355()) {
 			mmcsd0_resources[0].start = DM355_MMCSD0_BASE;
 			mmcsd0_resources[0].end = DM355_MMCSD0_BASE + SZ_4K - 1;
-			mmcsd0_resources[2].start = IRQ_DM355_SDIOINT0;
+			mmcsd0_resources[2].start = DAVINCI_INTC_IRQ(23);
 
 			/* expose all 6 MMC0 signals:  CLK, CMD, DATA[0..3] */
 			davinci_cfg_reg(DM355_MMCSD0);
@@ -241,7 +241,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd0_resources[0].start = DM365_MMCSD0_BASE;
 			mmcsd0_resources[0].end = DM365_MMCSD0_BASE +
 							SZ_4K - 1;
-			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT0;
+			mmcsd0_resources[2].start = DAVINCI_INTC_IRQ(23);
 			davinci_mmcsd0_device.name = "da830-mmc";
 		} else if (cpu_is_davinci_dm644x()) {
 			/* REVISIT: should this be in board-init code? */
@@ -313,13 +313,13 @@ int davinci_gpio_register(struct resource *res, int size, void *pdata)
 struct davinci_timer_instance davinci_timer_instance[2] = {
 	{
 		.base		= DAVINCI_TIMER0_BASE,
-		.bottom_irq	= IRQ_TINT0_TINT12,
-		.top_irq	= IRQ_TINT0_TINT34,
+		.bottom_irq	= DAVINCI_INTC_IRQ(32),
+		.top_irq	= DAVINCI_INTC_IRQ(33),
 	},
 	{
 		.base		= DAVINCI_TIMER1_BASE,
-		.bottom_irq	= IRQ_TINT1_TINT12,
-		.top_irq	= IRQ_TINT1_TINT34,
+		.bottom_irq	= DAVINCI_INTC_IRQ(34),
+		.top_irq	= DAVINCI_INTC_IRQ(35),
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5573f53b47f9..8d53d0c0a4a2 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -54,7 +54,7 @@ static struct resource dm355_spi0_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_DM355_SPINT0_0,
+		.start = DAVINCI_INTC_IRQ(42),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -220,12 +220,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(16),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(17),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using (or muxing) TC*_ERR */
@@ -305,13 +305,13 @@ static struct platform_device dm355_vpss_device = {
 
 static struct resource vpfe_resources[] = {
 	{
-		.start          = IRQ_VDINT0,
-		.end            = IRQ_VDINT0,
+		.start          = DAVINCI_INTC_IRQ(0),
+		.end            = DAVINCI_INTC_IRQ(0),
 		.flags          = IORESOURCE_IRQ,
 	},
 	{
-		.start          = IRQ_VDINT1,
-		.end            = IRQ_VDINT1,
+		.start          = DAVINCI_INTC_IRQ(1),
+		.end            = DAVINCI_INTC_IRQ(1),
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -369,8 +369,8 @@ static struct platform_device dm355_osd_dev = {
 
 static struct resource dm355_venc_resources[] = {
 	{
-		.start	= IRQ_VENCINT,
-		.end	= IRQ_VENCINT,
+		.start	= DAVINCI_INTC_IRQ(8),
+		.end	= DAVINCI_INTC_IRQ(8),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
@@ -389,8 +389,8 @@ static struct resource dm355_venc_resources[] = {
 
 static struct resource dm355_v4l2_disp_resources[] = {
 	{
-		.start	= IRQ_VENCINT,
-		.end	= IRQ_VENCINT,
+		.start	= DAVINCI_INTC_IRQ(8),
+		.end	= DAVINCI_INTC_IRQ(8),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
@@ -494,38 +494,38 @@ static struct resource dm355_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_DM355_GPIOBNK0,
-		.end	= IRQ_DM355_GPIOBNK0,
+		.start	= DAVINCI_INTC_IRQ(54),
+		.end	= DAVINCI_INTC_IRQ(54),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK1,
-		.end	= IRQ_DM355_GPIOBNK1,
+		.start	= DAVINCI_INTC_IRQ(55),
+		.end	= DAVINCI_INTC_IRQ(55),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK2,
-		.end	= IRQ_DM355_GPIOBNK2,
+		.start	= DAVINCI_INTC_IRQ(56),
+		.end	= DAVINCI_INTC_IRQ(56),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK3,
-		.end	= IRQ_DM355_GPIOBNK3,
+		.start	= DAVINCI_INTC_IRQ(57),
+		.end	= DAVINCI_INTC_IRQ(57),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK4,
-		.end	= IRQ_DM355_GPIOBNK4,
+		.start	= DAVINCI_INTC_IRQ(58),
+		.end	= DAVINCI_INTC_IRQ(58),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK5,
-		.end	= IRQ_DM355_GPIOBNK5,
+		.start	= DAVINCI_INTC_IRQ(59),
+		.end	= DAVINCI_INTC_IRQ(59),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM355_GPIOBNK6,
-		.end	= IRQ_DM355_GPIOBNK6,
+		.start	= DAVINCI_INTC_IRQ(60),
+		.end	= DAVINCI_INTC_IRQ(60),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -579,7 +579,7 @@ static struct davinci_timer_info dm355_timer_info = {
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(40),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -592,7 +592,7 @@ static struct plat_serial8250_port dm355_serial0_platform_data[] = {
 static struct plat_serial8250_port dm355_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(41),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -605,7 +605,7 @@ static struct plat_serial8250_port dm355_serial1_platform_data[] = {
 static struct plat_serial8250_port dm355_serial2_platform_data[] = {
 	{
 		.mapbase	= DM355_UART2_BASE,
-		.irq		= IRQ_DM355_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(14),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6d9bf292f4c6..00d90cf81e7f 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -225,7 +225,7 @@ static struct resource dm365_spi0_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_DM365_SPIINT0_0,
+		.start = DAVINCI_INTC_IRQ(42),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -267,43 +267,43 @@ static struct resource dm365_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_DM365_GPIO0,
-		.end	= IRQ_DM365_GPIO0,
+		.start	= DAVINCI_INTC_IRQ(44),
+		.end	= DAVINCI_INTC_IRQ(44),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO1,
-		.end	= IRQ_DM365_GPIO1,
+		.start	= DAVINCI_INTC_IRQ(45),
+		.end	= DAVINCI_INTC_IRQ(45),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO2,
-		.end	= IRQ_DM365_GPIO2,
+		.start	= DAVINCI_INTC_IRQ(46),
+		.end	= DAVINCI_INTC_IRQ(46),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO3,
-		.end	= IRQ_DM365_GPIO3,
+		.start	= DAVINCI_INTC_IRQ(47),
+		.end	= DAVINCI_INTC_IRQ(47),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO4,
-		.end	= IRQ_DM365_GPIO4,
+		.start	= DAVINCI_INTC_IRQ(48),
+		.end	= DAVINCI_INTC_IRQ(48),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO5,
-		.end	= IRQ_DM365_GPIO5,
+		.start	= DAVINCI_INTC_IRQ(49),
+		.end	= DAVINCI_INTC_IRQ(49),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO6,
-		.end	= IRQ_DM365_GPIO6,
+		.start	= DAVINCI_INTC_IRQ(50),
+		.end	= DAVINCI_INTC_IRQ(50),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_GPIO7,
-		.end	= IRQ_DM365_GPIO7,
+		.start	= DAVINCI_INTC_IRQ(51),
+		.end	= DAVINCI_INTC_IRQ(51),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -337,23 +337,23 @@ static struct resource dm365_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_RXTHRESH,
-		.end	= IRQ_DM365_EMAC_RXTHRESH,
+		.start	= DAVINCI_INTC_IRQ(52),
+		.end	= DAVINCI_INTC_IRQ(52),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_RXPULSE,
-		.end	= IRQ_DM365_EMAC_RXPULSE,
+		.start	= DAVINCI_INTC_IRQ(53),
+		.end	= DAVINCI_INTC_IRQ(53),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_TXPULSE,
-		.end	= IRQ_DM365_EMAC_TXPULSE,
+		.start	= DAVINCI_INTC_IRQ(54),
+		.end	= DAVINCI_INTC_IRQ(54),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM365_EMAC_MISCPULSE,
-		.end	= IRQ_DM365_EMAC_MISCPULSE,
+		.start	= DAVINCI_INTC_IRQ(55),
+		.end	= DAVINCI_INTC_IRQ(55),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -463,12 +463,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(16),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(17),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using TC*_ERR */
@@ -542,7 +542,7 @@ static struct resource dm365_rtc_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_DM365_RTCINT,
+		.start = DAVINCI_INTC_IRQ(29),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -572,8 +572,8 @@ static struct resource dm365_ks_resources[] = {
 	},
 	{
 		/* interrupt */
-		.start = IRQ_DM365_KEYINT,
-		.end = IRQ_DM365_KEYINT,
+		.start = DAVINCI_INTC_IRQ(60),
+		.end = DAVINCI_INTC_IRQ(60),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -614,7 +614,7 @@ static struct davinci_timer_info dm365_timer_info = {
 static struct plat_serial8250_port dm365_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(40),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -627,7 +627,7 @@ static struct plat_serial8250_port dm365_serial0_platform_data[] = {
 static struct plat_serial8250_port dm365_serial1_platform_data[] = {
 	{
 		.mapbase	= DM365_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(41),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -763,13 +763,13 @@ static struct platform_device dm365_vpss_device = {
 
 static struct resource vpfe_resources[] = {
 	{
-		.start          = IRQ_VDINT0,
-		.end            = IRQ_VDINT0,
+		.start          = DAVINCI_INTC_IRQ(0),
+		.end            = DAVINCI_INTC_IRQ(0),
 		.flags          = IORESOURCE_IRQ,
 	},
 	{
-		.start          = IRQ_VDINT1,
-		.end            = IRQ_VDINT1,
+		.start          = DAVINCI_INTC_IRQ(1),
+		.end            = DAVINCI_INTC_IRQ(1),
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -850,8 +850,8 @@ static struct platform_device dm365_osd_dev = {
 
 static struct resource dm365_venc_resources[] = {
 	{
-		.start = IRQ_VENCINT,
-		.end   = IRQ_VENCINT,
+		.start = DAVINCI_INTC_IRQ(8),
+		.end   = DAVINCI_INTC_IRQ(8),
 		.flags = IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
@@ -870,8 +870,8 @@ static struct resource dm365_venc_resources[] = {
 
 static struct resource dm365_v4l2_disp_resources[] = {
 	{
-		.start = IRQ_VENCINT,
-		.end   = IRQ_VENCINT,
+		.start = DAVINCI_INTC_IRQ(8),
+		.end   = DAVINCI_INTC_IRQ(8),
 		.flags = IORESOURCE_IRQ,
 	},
 	/* venc registers io space */
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2f181b4149c1..a17ae9d66c53 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -61,8 +61,8 @@ static struct resource dm644x_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start = IRQ_EMACINT,
-		.end   = IRQ_EMACINT,
+		.start = DAVINCI_INTC_IRQ(13),
+		.end   = DAVINCI_INTC_IRQ(13),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -206,12 +206,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(16),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(17),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using TC*_ERR */
@@ -276,13 +276,13 @@ static struct platform_device dm644x_vpss_device = {
 
 static struct resource dm644x_vpfe_resources[] = {
 	{
-		.start          = IRQ_VDINT0,
-		.end            = IRQ_VDINT0,
+		.start          = DAVINCI_INTC_IRQ(0),
+		.end            = DAVINCI_INTC_IRQ(0),
 		.flags          = IORESOURCE_IRQ,
 	},
 	{
-		.start          = IRQ_VDINT1,
-		.end            = IRQ_VDINT1,
+		.start          = DAVINCI_INTC_IRQ(1),
+		.end            = DAVINCI_INTC_IRQ(1),
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -388,8 +388,8 @@ static int dm644x_venc_setup_clock(enum vpbe_enc_timings_type type,
 
 static struct resource dm644x_v4l2_disp_resources[] = {
 	{
-		.start	= IRQ_VENCINT,
-		.end	= IRQ_VENCINT,
+		.start	= DAVINCI_INTC_IRQ(8),
+		.end	= DAVINCI_INTC_IRQ(8),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -437,28 +437,28 @@ static struct resource dm644_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_GPIOBNK0,
-		.end	= IRQ_GPIOBNK0,
+		.start	= DAVINCI_INTC_IRQ(56),
+		.end	= DAVINCI_INTC_IRQ(56),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK1,
-		.end	= IRQ_GPIOBNK1,
+		.start	= DAVINCI_INTC_IRQ(57),
+		.end	= DAVINCI_INTC_IRQ(57),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK2,
-		.end	= IRQ_GPIOBNK2,
+		.start	= DAVINCI_INTC_IRQ(58),
+		.end	= DAVINCI_INTC_IRQ(58),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK3,
-		.end	= IRQ_GPIOBNK3,
+		.start	= DAVINCI_INTC_IRQ(59),
+		.end	= DAVINCI_INTC_IRQ(59),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_GPIOBNK4,
-		.end	= IRQ_GPIOBNK4,
+		.start	= DAVINCI_INTC_IRQ(60),
+		.end	= DAVINCI_INTC_IRQ(60),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -519,7 +519,7 @@ static struct davinci_timer_info dm644x_timer_info = {
 static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(40),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -532,7 +532,7 @@ static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
 static struct plat_serial8250_port dm644x_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(41),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -545,7 +545,7 @@ static struct plat_serial8250_port dm644x_serial1_platform_data[] = {
 static struct plat_serial8250_port dm644x_serial2_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART2_BASE,
-		.irq		= IRQ_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(42),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
@@ -615,7 +615,7 @@ void __init dm644x_init_time(void)
 	struct clk *clk;
 
 	/* Needed by the dsp. */
-	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+	irq_set_handler(DAVINCI_INTC_IRQ(35), handle_level_irq);
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 4ce2c8c6b945..f5506216321e 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -64,23 +64,23 @@ static struct resource dm646x_emac_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IRQ_DM646X_EMACRXTHINT,
-		.end	= IRQ_DM646X_EMACRXTHINT,
+		.start	= DAVINCI_INTC_IRQ(24),
+		.end	= DAVINCI_INTC_IRQ(24),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_EMACRXINT,
-		.end	= IRQ_DM646X_EMACRXINT,
+		.start	= DAVINCI_INTC_IRQ(25),
+		.end	= DAVINCI_INTC_IRQ(25),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_EMACTXINT,
-		.end	= IRQ_DM646X_EMACTXINT,
+		.start	= DAVINCI_INTC_IRQ(26),
+		.end	= DAVINCI_INTC_IRQ(26),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_EMACMISCINT,
-		.end	= IRQ_DM646X_EMACMISCINT,
+		.start	= DAVINCI_INTC_IRQ(27),
+		.end	= DAVINCI_INTC_IRQ(27),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -219,12 +219,12 @@ static struct resource edma_resources[] = {
 	},
 	{
 		.name	= "edma3_ccint",
-		.start	= IRQ_CCINT0,
+		.start	= DAVINCI_INTC_IRQ(16),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "edma3_ccerrint",
-		.start	= IRQ_CCERRINT,
+		.start	= DAVINCI_INTC_IRQ(17),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* not using TC*_ERR */
@@ -261,12 +261,12 @@ static struct resource dm646x_mcasp0_resources[] = {
 	},
 	{
 		.name	= "tx",
-		.start	= IRQ_DM646X_MCASP0TXINT,
+		.start	= DAVINCI_INTC_IRQ(28),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= "rx",
-		.start	= IRQ_DM646X_MCASP0RXINT,
+		.start	= DAVINCI_INTC_IRQ(29),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -287,7 +287,7 @@ static struct resource dm646x_mcasp1_resources[] = {
 	},
 	{
 		.name	= "tx",
-		.start	= IRQ_DM646X_MCASP1TXINT,
+		.start	= DAVINCI_INTC_IRQ(30),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -334,13 +334,13 @@ static struct platform_device vpif_dev = {
 
 static struct resource vpif_display_resource[] = {
 	{
-		.start = IRQ_DM646X_VP_VERTINT2,
-		.end   = IRQ_DM646X_VP_VERTINT2,
+		.start = DAVINCI_INTC_IRQ(2),
+		.end   = DAVINCI_INTC_IRQ(2),
 		.flags = IORESOURCE_IRQ,
 	},
 	{
-		.start = IRQ_DM646X_VP_VERTINT3,
-		.end   = IRQ_DM646X_VP_VERTINT3,
+		.start = DAVINCI_INTC_IRQ(3),
+		.end   = DAVINCI_INTC_IRQ(3),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -358,13 +358,13 @@ static struct platform_device vpif_display_dev = {
 
 static struct resource vpif_capture_resource[] = {
 	{
-		.start = IRQ_DM646X_VP_VERTINT0,
-		.end   = IRQ_DM646X_VP_VERTINT0,
+		.start = DAVINCI_INTC_IRQ(0),
+		.end   = DAVINCI_INTC_IRQ(0),
 		.flags = IORESOURCE_IRQ,
 	},
 	{
-		.start = IRQ_DM646X_VP_VERTINT1,
-		.end   = IRQ_DM646X_VP_VERTINT1,
+		.start = DAVINCI_INTC_IRQ(1),
+		.end   = DAVINCI_INTC_IRQ(1),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -387,18 +387,18 @@ static struct resource dm646x_gpio_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* interrupt */
-		.start	= IRQ_DM646X_GPIOBNK0,
-		.end	= IRQ_DM646X_GPIOBNK0,
+		.start	= DAVINCI_INTC_IRQ(56),
+		.end	= DAVINCI_INTC_IRQ(56),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_GPIOBNK1,
-		.end	= IRQ_DM646X_GPIOBNK1,
+		.start	= DAVINCI_INTC_IRQ(57),
+		.end	= DAVINCI_INTC_IRQ(57),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
-		.start	= IRQ_DM646X_GPIOBNK2,
-		.end	= IRQ_DM646X_GPIOBNK2,
+		.start	= DAVINCI_INTC_IRQ(58),
+		.end	= DAVINCI_INTC_IRQ(58),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -459,7 +459,7 @@ static struct davinci_timer_info dm646x_timer_info = {
 static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
-		.irq		= IRQ_UARTINT0,
+		.irq		= DAVINCI_INTC_IRQ(40),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
@@ -472,7 +472,7 @@ static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
 static struct plat_serial8250_port dm646x_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
-		.irq		= IRQ_UARTINT1,
+		.irq		= DAVINCI_INTC_IRQ(41),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
@@ -485,7 +485,7 @@ static struct plat_serial8250_port dm646x_serial1_platform_data[] = {
 static struct plat_serial8250_port dm646x_serial2_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART2_BASE,
-		.irq		= IRQ_DM646X_UARTINT2,
+		.irq		= DAVINCI_INTC_IRQ(42),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
@@ -598,7 +598,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	struct clk *clk;
 
 	/* Needed by the dsp. */
-	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+	irq_set_handler(DAVINCI_INTC_IRQ(35), handle_level_irq);
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index c17ce66a3d95..fdfe03669d9f 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -70,7 +70,7 @@ static struct resource da8xx_usb20_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= IRQ_DA8XX_USB_INT,
+		.start		= DAVINCI_INTC_IRQ(58),
 		.flags		= IORESOURCE_IRQ,
 		.name		= "mc",
 	},
@@ -105,8 +105,8 @@ static struct resource da8xx_usb11_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_DA8XX_IRQN,
-		.end	= IRQ_DA8XX_IRQN,
+		.start	= DAVINCI_INTC_IRQ(59),
+		.end	= DAVINCI_INTC_IRQ(59),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 31ed7aa47227..feb300670f43 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -38,7 +38,7 @@ static struct resource usb_resources[] = {
 		.flags          = IORESOURCE_MEM,
 	},
 	{
-		.start          = IRQ_USBINT,
+		.start          = DAVINCI_INTC_IRQ(12),
 		.flags          = IORESOURCE_IRQ,
 		.name		= "mc"
 	},
@@ -70,8 +70,8 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
 
 	if (cpu_is_davinci_dm646x()) {
 		/* Override the defaults as DM6467 uses different IRQs. */
-		usb_dev.resource[1].start = IRQ_DM646X_USBINT;
-		usb_dev.resource[2].start = IRQ_DM646X_USBDMAINT;
+		usb_dev.resource[1].start = DAVINCI_INTC_IRQ(13);
+		usb_dev.resource[2].start = DAVINCI_INTC_IRQ(14);
 	} else	/* other devices don't have dedicated CPPI IRQ */
 		usb_dev.num_resources = 2;
 
-- 
2.20.1

