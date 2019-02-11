Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168E9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B872075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aDFkKTos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfBKM1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32978 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBKM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so132716wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0z1of7/QDsVE2JoIw+5LkRJ/UT4aPISepSTadwOIBI=;
        b=aDFkKTos36Yj1Q9CCN/VXzS3DkEPUBw4L1FoeuiVK8XoYDW3NOGc4wv9j5uaV7aEt9
         k7IF3ZKqfROpD1TQV52TE/a5o/0pA05HYN9ORNldS8DLwUcfDySG0nAcmLJSr96G+NIh
         AuoKtXqYV3eNwIn4kVgoDHqpr1NDqdkRw9OuGNySA1aaWuhtJzk+hS5jOhh1XEIeMtGn
         +YNY3CcOzW65q1Q1Q9s6BgiKLMgJ3YAMjW0s21UgML68cNQX1bjLzr96d7op1Zwc07lG
         HCab0y8CUvj5csT7K342HAuP9U78FfG3zP8aH2aqnaGysqTexxq1kJpsLtpbb3RfPDYY
         /a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0z1of7/QDsVE2JoIw+5LkRJ/UT4aPISepSTadwOIBI=;
        b=f5YUePtY/wIonASOHXJaM88UTSy3cQo6YxwVzBMsLmmN5z1JwFK21kFd/Pk0WDC7Sh
         Pb/wQLWNAOCbhxbg0VI39aFeGCv33TzDZLb0VcrQ0l7pw+J8hrFPPrxFKQQxNOE8VerL
         zDPjRXCD47twXypyQ5s6PFaJuDC3Hbo7rDHnGs9i2PeG/zA2wP+WKStcr8mvjWC0SFeb
         rDycVm3UMSdNcixPZQZHmMDJua91uFlhZ0cdDP83uX8v4bTwAO/4EOsGoAqA/pAQgjkI
         htW4IrBl+ebtZJ9JsI4L+0Xtzyye7O0H5BGAWIcx7BZgLQXlhI6ZLkJhasRs38Lz/Xej
         KbQw==
X-Gm-Message-State: AHQUAuZ7RFBTu84yWJBk8UTejmr9IF4zGbzQlweYoiYW4GevCGE41Dfn
        y2eoLXEeCl4YDlSrQR9EgUCeZQ==
X-Google-Smtp-Source: AHgI3IaApUEbOFcgjTPzYoUIP3GfDVRU8VCyhuBuOupwW35tQlUy9VoCfWSVLcjsWQiv/2wFLcvlqg==
X-Received: by 2002:adf:8447:: with SMTP id 65mr2423339wrf.328.1549888013362;
        Mon, 11 Feb 2019 04:26:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 33/33] ARM: davinci: remove intc related fields from davinci_soc_info
Date:   Mon, 11 Feb 2019 13:26:06 +0100
Message-Id: <20190211122606.8662-34-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The fields related to the two davinci interrupt controllers are no
longer used. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c               |  98 ------------------
 arch/arm/mach-davinci/da850.c               | 108 --------------------
 arch/arm/mach-davinci/dm355.c               |   3 -
 arch/arm/mach-davinci/dm365.c               |   3 -
 arch/arm/mach-davinci/dm644x.c              |   3 -
 arch/arm/mach-davinci/dm646x.c              |   3 -
 arch/arm/mach-davinci/include/mach/common.h |   3 -
 7 files changed, 221 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 7ce0b5f1200d..63511f638ce4 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -624,101 +624,6 @@ const short da830_eqep1_pins[] __initconst = {
 	-1
 };
 
-/* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da830_default_priorities[DA830_N_CP_INTC_IRQ] = {
-	[IRQ_DA8XX_COMMTX]		= 7,
-	[IRQ_DA8XX_COMMRX]		= 7,
-	[IRQ_DA8XX_NINT]		= 7,
-	[IRQ_DA8XX_EVTOUT0]		= 7,
-	[IRQ_DA8XX_EVTOUT1]		= 7,
-	[IRQ_DA8XX_EVTOUT2]		= 7,
-	[IRQ_DA8XX_EVTOUT3]		= 7,
-	[IRQ_DA8XX_EVTOUT4]		= 7,
-	[IRQ_DA8XX_EVTOUT5]		= 7,
-	[IRQ_DA8XX_EVTOUT6]		= 7,
-	[IRQ_DA8XX_EVTOUT7]		= 7,
-	[IRQ_DA8XX_CCINT0]		= 7,
-	[IRQ_DA8XX_CCERRINT]		= 7,
-	[IRQ_DA8XX_TCERRINT0]		= 7,
-	[IRQ_DA8XX_AEMIFINT]		= 7,
-	[IRQ_DA8XX_I2CINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT1]		= 7,
-	[IRQ_DA8XX_ALLINT0]		= 7,
-	[IRQ_DA8XX_RTC]			= 7,
-	[IRQ_DA8XX_SPINT0]		= 7,
-	[IRQ_DA8XX_TINT12_0]		= 7,
-	[IRQ_DA8XX_TINT34_0]		= 7,
-	[IRQ_DA8XX_TINT12_1]		= 7,
-	[IRQ_DA8XX_TINT34_1]		= 7,
-	[IRQ_DA8XX_UARTINT0]		= 7,
-	[IRQ_DA8XX_KEYMGRINT]		= 7,
-	[IRQ_DA830_MPUERR]		= 7,
-	[IRQ_DA8XX_CHIPINT0]		= 7,
-	[IRQ_DA8XX_CHIPINT1]		= 7,
-	[IRQ_DA8XX_CHIPINT2]		= 7,
-	[IRQ_DA8XX_CHIPINT3]		= 7,
-	[IRQ_DA8XX_TCERRINT1]		= 7,
-	[IRQ_DA8XX_C0_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C0_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_MEMERR]		= 7,
-	[IRQ_DA8XX_GPIO0]		= 7,
-	[IRQ_DA8XX_GPIO1]		= 7,
-	[IRQ_DA8XX_GPIO2]		= 7,
-	[IRQ_DA8XX_GPIO3]		= 7,
-	[IRQ_DA8XX_GPIO4]		= 7,
-	[IRQ_DA8XX_GPIO5]		= 7,
-	[IRQ_DA8XX_GPIO6]		= 7,
-	[IRQ_DA8XX_GPIO7]		= 7,
-	[IRQ_DA8XX_GPIO8]		= 7,
-	[IRQ_DA8XX_I2CINT1]		= 7,
-	[IRQ_DA8XX_LCDINT]		= 7,
-	[IRQ_DA8XX_UARTINT1]		= 7,
-	[IRQ_DA8XX_MCASPINT]		= 7,
-	[IRQ_DA8XX_ALLINT1]		= 7,
-	[IRQ_DA8XX_SPINT1]		= 7,
-	[IRQ_DA8XX_UHPI_INT1]		= 7,
-	[IRQ_DA8XX_USB_INT]		= 7,
-	[IRQ_DA8XX_IRQN]		= 7,
-	[IRQ_DA8XX_RWAKEUP]		= 7,
-	[IRQ_DA8XX_UARTINT2]		= 7,
-	[IRQ_DA8XX_DFTSSINT]		= 7,
-	[IRQ_DA8XX_EHRPWM0]		= 7,
-	[IRQ_DA8XX_EHRPWM0TZ]		= 7,
-	[IRQ_DA8XX_EHRPWM1]		= 7,
-	[IRQ_DA8XX_EHRPWM1TZ]		= 7,
-	[IRQ_DA830_EHRPWM2]		= 7,
-	[IRQ_DA830_EHRPWM2TZ]		= 7,
-	[IRQ_DA8XX_ECAP0]		= 7,
-	[IRQ_DA8XX_ECAP1]		= 7,
-	[IRQ_DA8XX_ECAP2]		= 7,
-	[IRQ_DA830_EQEP0]		= 7,
-	[IRQ_DA830_EQEP1]		= 7,
-	[IRQ_DA830_T12CMPINT0_0]	= 7,
-	[IRQ_DA830_T12CMPINT1_0]	= 7,
-	[IRQ_DA830_T12CMPINT2_0]	= 7,
-	[IRQ_DA830_T12CMPINT3_0]	= 7,
-	[IRQ_DA830_T12CMPINT4_0]	= 7,
-	[IRQ_DA830_T12CMPINT5_0]	= 7,
-	[IRQ_DA830_T12CMPINT6_0]	= 7,
-	[IRQ_DA830_T12CMPINT7_0]	= 7,
-	[IRQ_DA830_T12CMPINT0_1]	= 7,
-	[IRQ_DA830_T12CMPINT1_1]	= 7,
-	[IRQ_DA830_T12CMPINT2_1]	= 7,
-	[IRQ_DA830_T12CMPINT3_1]	= 7,
-	[IRQ_DA830_T12CMPINT4_1]	= 7,
-	[IRQ_DA830_T12CMPINT5_1]	= 7,
-	[IRQ_DA830_T12CMPINT6_1]	= 7,
-	[IRQ_DA830_T12CMPINT7_1]	= 7,
-	[IRQ_DA8XX_ARMCLKSTOPREQ]	= 7,
-};
-
 static struct map_desc da830_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -807,9 +712,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da830_default_priorities,
-	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 62a00fa94696..8a50956a9181 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -299,111 +299,6 @@ const short da850_vpif_display_pins[] __initconst = {
 	-1
 };
 
-/* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da850_default_priorities[DA850_N_CP_INTC_IRQ] = {
-	[IRQ_DA8XX_COMMTX]		= 7,
-	[IRQ_DA8XX_COMMRX]		= 7,
-	[IRQ_DA8XX_NINT]		= 7,
-	[IRQ_DA8XX_EVTOUT0]		= 7,
-	[IRQ_DA8XX_EVTOUT1]		= 7,
-	[IRQ_DA8XX_EVTOUT2]		= 7,
-	[IRQ_DA8XX_EVTOUT3]		= 7,
-	[IRQ_DA8XX_EVTOUT4]		= 7,
-	[IRQ_DA8XX_EVTOUT5]		= 7,
-	[IRQ_DA8XX_EVTOUT6]		= 7,
-	[IRQ_DA8XX_EVTOUT7]		= 7,
-	[IRQ_DA8XX_CCINT0]		= 7,
-	[IRQ_DA8XX_CCERRINT]		= 7,
-	[IRQ_DA8XX_TCERRINT0]		= 7,
-	[IRQ_DA8XX_AEMIFINT]		= 7,
-	[IRQ_DA8XX_I2CINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT0]		= 7,
-	[IRQ_DA8XX_MMCSDINT1]		= 7,
-	[IRQ_DA8XX_ALLINT0]		= 7,
-	[IRQ_DA8XX_RTC]			= 7,
-	[IRQ_DA8XX_SPINT0]		= 7,
-	[IRQ_DA8XX_TINT12_0]		= 7,
-	[IRQ_DA8XX_TINT34_0]		= 7,
-	[IRQ_DA8XX_TINT12_1]		= 7,
-	[IRQ_DA8XX_TINT34_1]		= 7,
-	[IRQ_DA8XX_UARTINT0]		= 7,
-	[IRQ_DA8XX_KEYMGRINT]		= 7,
-	[IRQ_DA850_MPUADDRERR0]		= 7,
-	[IRQ_DA8XX_CHIPINT0]		= 7,
-	[IRQ_DA8XX_CHIPINT1]		= 7,
-	[IRQ_DA8XX_CHIPINT2]		= 7,
-	[IRQ_DA8XX_CHIPINT3]		= 7,
-	[IRQ_DA8XX_TCERRINT1]		= 7,
-	[IRQ_DA8XX_C0_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C0_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C0_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_THRESH_PULSE]	= 7,
-	[IRQ_DA8XX_C1_RX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_TX_PULSE]		= 7,
-	[IRQ_DA8XX_C1_MISC_PULSE]	= 7,
-	[IRQ_DA8XX_MEMERR]		= 7,
-	[IRQ_DA8XX_GPIO0]		= 7,
-	[IRQ_DA8XX_GPIO1]		= 7,
-	[IRQ_DA8XX_GPIO2]		= 7,
-	[IRQ_DA8XX_GPIO3]		= 7,
-	[IRQ_DA8XX_GPIO4]		= 7,
-	[IRQ_DA8XX_GPIO5]		= 7,
-	[IRQ_DA8XX_GPIO6]		= 7,
-	[IRQ_DA8XX_GPIO7]		= 7,
-	[IRQ_DA8XX_GPIO8]		= 7,
-	[IRQ_DA8XX_I2CINT1]		= 7,
-	[IRQ_DA8XX_LCDINT]		= 7,
-	[IRQ_DA8XX_UARTINT1]		= 7,
-	[IRQ_DA8XX_MCASPINT]		= 7,
-	[IRQ_DA8XX_ALLINT1]		= 7,
-	[IRQ_DA8XX_SPINT1]		= 7,
-	[IRQ_DA8XX_UHPI_INT1]		= 7,
-	[IRQ_DA8XX_USB_INT]		= 7,
-	[IRQ_DA8XX_IRQN]		= 7,
-	[IRQ_DA8XX_RWAKEUP]		= 7,
-	[IRQ_DA8XX_UARTINT2]		= 7,
-	[IRQ_DA8XX_DFTSSINT]		= 7,
-	[IRQ_DA8XX_EHRPWM0]		= 7,
-	[IRQ_DA8XX_EHRPWM0TZ]		= 7,
-	[IRQ_DA8XX_EHRPWM1]		= 7,
-	[IRQ_DA8XX_EHRPWM1TZ]		= 7,
-	[IRQ_DA850_SATAINT]		= 7,
-	[IRQ_DA850_TINTALL_2]		= 7,
-	[IRQ_DA8XX_ECAP0]		= 7,
-	[IRQ_DA8XX_ECAP1]		= 7,
-	[IRQ_DA8XX_ECAP2]		= 7,
-	[IRQ_DA850_MMCSDINT0_1]		= 7,
-	[IRQ_DA850_MMCSDINT1_1]		= 7,
-	[IRQ_DA850_T12CMPINT0_2]	= 7,
-	[IRQ_DA850_T12CMPINT1_2]	= 7,
-	[IRQ_DA850_T12CMPINT2_2]	= 7,
-	[IRQ_DA850_T12CMPINT3_2]	= 7,
-	[IRQ_DA850_T12CMPINT4_2]	= 7,
-	[IRQ_DA850_T12CMPINT5_2]	= 7,
-	[IRQ_DA850_T12CMPINT6_2]	= 7,
-	[IRQ_DA850_T12CMPINT7_2]	= 7,
-	[IRQ_DA850_T12CMPINT0_3]	= 7,
-	[IRQ_DA850_T12CMPINT1_3]	= 7,
-	[IRQ_DA850_T12CMPINT2_3]	= 7,
-	[IRQ_DA850_T12CMPINT3_3]	= 7,
-	[IRQ_DA850_T12CMPINT4_3]	= 7,
-	[IRQ_DA850_T12CMPINT5_3]	= 7,
-	[IRQ_DA850_T12CMPINT6_3]	= 7,
-	[IRQ_DA850_T12CMPINT7_3]	= 7,
-	[IRQ_DA850_RPIINT]		= 7,
-	[IRQ_DA850_VPIFINT]		= 7,
-	[IRQ_DA850_CCINT1]		= 7,
-	[IRQ_DA850_CCERRINT1]		= 7,
-	[IRQ_DA850_TCERRINT2]		= 7,
-	[IRQ_DA850_TINTALL_3]		= 7,
-	[IRQ_DA850_MCBSP0RINT]		= 7,
-	[IRQ_DA850_MCBSP0XINT]		= 7,
-	[IRQ_DA850_MCBSP1RINT]		= 7,
-	[IRQ_DA850_MCBSP1XINT]		= 7,
-	[IRQ_DA8XX_ARMCLKSTOPREQ]	= 7,
-};
-
 static struct map_desc da850_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -739,9 +634,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da850_default_priorities,
-	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a732f2ea1d9a..2352bcd359b4 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -706,9 +706,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm355_default_priorities,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 79afde34cfbb..b86cab92a8de 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -723,9 +723,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm365_default_priorities,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 007d979d2d64..51b67bca634e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -647,9 +647,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios 	= dm644x_default_priorities,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a643d78ad644..9638b327f638 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -587,9 +587,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm646x_default_priorities,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 14e0e1c40611..9526e5da0d33 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -58,9 +58,6 @@ struct davinci_soc_info {
 	u32				pinmux_base;
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
-	u32				intc_base;
-	u8				*intc_irq_prios;
-	unsigned long			intc_irq_num;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1

