Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08D620449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DyAVdg3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfBLKju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51844 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfBLKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2369491wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0z1of7/QDsVE2JoIw+5LkRJ/UT4aPISepSTadwOIBI=;
        b=DyAVdg3sZ3zoHD86AiPZkD9umOD7B4HXK2c/W0StFuuaYCQ+i+mWMmd/UYdUlL2Xcy
         wW6I5I4jRAryGJFsr6HRYFoUhdmEUyKkBtPcU9B+unlMsfNQcj1+Pcn+aJR9Mx5iyTme
         IQxMolYrFmwxSAsDE7Tn6cpvDVFpr4WI8RhRHvJTiAwMq0b14ltosL2fq1pVJPnG/f/6
         Aq26R5TUXAU2yLVfUkxaMT/xDy/4QPhUHvtnoiBtPibmwFY9lIirBm10RsdjTEPQFMIC
         VWPypQc6/h8ONGI+ONtB+oBIzxka3ZHl68PG1v9wzoKqggq3yR1mQhyirePRqCqA22aY
         hFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0z1of7/QDsVE2JoIw+5LkRJ/UT4aPISepSTadwOIBI=;
        b=iAfuuhYS8ideICiBAF2AGI8C2yo7uF2HA03wJWbke09n6yrzvoeak21CZ+eJZm4XT0
         bZ0vanD2Jlq6HvkcSvecBfQaa4dTJfMeB+zHZJdgZqsFnL+6603sc76meABwI/57nZXE
         Dj8KFrTeIphbG4kRrS863WQg5ocei1Fva3A6xJ/c57hJWY1b9xi34fold34gspP2poAf
         w1rVXXRXJne3Fiq08uhm6dFvgvhrsTwn/niin6U/rSM9DvkHZ+xBs+gOzh8d02akXGMg
         ye0c4cbYSIzs5VnfWcOMRKVYZrAiljcvPCR6UOsVRwxBKN1xYJsDILZA5mmorzwZ9xw7
         6Zcw==
X-Gm-Message-State: AHQUAuY083jjUb8ApbflEwg2ylQNjkCYXC8wPyIaYnpBBwgjRET4GGfq
        UjH0row7YSkX2YuKwDhMvohNig==
X-Google-Smtp-Source: AHgI3IZXRf4bukYGv8rPnRePcO46RIPV0pOvBd5EIAbd7CYEYiaawUiQOuteWDUe2g0xRZLzGhm1vA==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr2344711wma.60.1549967979517;
        Tue, 12 Feb 2019 02:39:39 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 37/37] ARM: davinci: remove intc related fields from davinci_soc_info
Date:   Tue, 12 Feb 2019 11:38:35 +0100
Message-Id: <20190212103835.7768-38-brgl@bgdev.pl>
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

