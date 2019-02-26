Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC94217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Yg55H5xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfBZMIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:08:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55737 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfBZMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so2140882wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mq3iJZVLpItIL4L4rsuKEvbRZu3sCHkA9qXDRFfgXBE=;
        b=Yg55H5xx5YhjgY3MfNPO+LrSNNTTZe9spRoCWEuDDgCXcmCYPjbT0h3VGDjtat+iUG
         4A5Cvw/bHkYhRHtER3sjJpxQZBZGZrFgIjjRhxx+r8Os+mUHvI4iH9WZ/A9xjCJaCv9d
         8RG5z75917QcFe46Dbq8tvLKck2y9tt55AyErLSt8bb37h20e7xlSgf2DT+8z7Fl2hHs
         86TiFkZhWOIHtmjL8YKjU1YJK1W1AK4CoYiEpTuBFBYhLbGwXLr/QYf1uZutP+pbzOkc
         fQp2jaQEdM/c81XSixW/0KxOb64dsefGr41o7STJc88syVwtBPX1wLy5zSbRe1q64whr
         0kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mq3iJZVLpItIL4L4rsuKEvbRZu3sCHkA9qXDRFfgXBE=;
        b=elkapsuGBU+hLujZe+n5/BdfZ8cxj7riyPjPlPl0/ZAxzWuVOebJ9x256LlpPRbAZH
         Tp2ob5ahnC3H4FivT7zTGer0IVD9FFx/m5oh0IxuQwgJ9hR+/+p4fgbM8fA+11467afE
         +2ayIVKjNQGwoUqjjXeeZYrfuMFuTpb1zcMWQqY64Ric6ZG0syDsIV6T6vK0rf3Jf3gz
         Dl1XxWg1aqTgj2B2wJQR7lqviwftZBdNC+3U+G5LnR74edYJh0ZLQ+yKt9dNkCB1acT3
         6TdM8MZ4sL97xhjChp3cLg/nZxqOKG5AcKSoV7mwA1c4ZDvN9E7TEb/M6qdA5PomFmCq
         eNuQ==
X-Gm-Message-State: AHQUAub1MXy3uq8NJWO7GuDaoKLARlksciNqCYMQQ1I/0EQjkIJ+dTsC
        MbDC2uWBHb/DvlZrBIvxbi7xP2jYOKM=
X-Google-Smtp-Source: AHgI3IZUcWsjuYo/IPBUeCdntXwza4VrBzjGns5krnzXtz/df3rr37lXiqUAPUaw/1vNsd0omCJ7iA==
X-Received: by 2002:a1c:a98b:: with SMTP id s133mr2291528wme.129.1551182856266;
        Tue, 26 Feb 2019 04:07:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 05/11] ARM: davinci: da830: switch to using the clocksource driver
Date:   Tue, 26 Feb 2019 13:06:27 +0100
Message-Id: <20190226120633.18200-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the da830
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 36 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index d242ce06f7e5..1dd4c7273bd7 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,8 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -675,32 +676,18 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_1),
-	},
-};
-
 /*
  * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
  * T0_TOP: Timer 0, top			: Used by DSP
  * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
  */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+	},
+	.cmp_off = DA830_CMP12_0,
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -712,7 +699,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -742,6 +728,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -755,7 +742,8 @@ void __init da830_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.20.1

