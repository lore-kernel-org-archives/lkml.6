Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D56BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE632177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bR3HvUbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfAKRWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55440 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388906AbfAKRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so3099497wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKz95RPwvt2A/xPxVUtkplb+bX/m8U+Ej4ZHCejgW/g=;
        b=bR3HvUbw1A9FSWsGkazEtBy0Z/4OV/WnUOmskjXcGhacgJPbOXAzo+lxNsrDFmU8px
         sOf60AWKlYUTfwbZ37YkbObGUXXg2IPOkO5PgXjZaZLfuKC8FWNGa91F2nDbPJponva0
         ptcADkszquHBZCOGlDZlHh4ih/I6DGmDC93fYv9Y9T4+HVn7OS/i1VjjfuuERhycpZrs
         3A1FaD8KW8W9j4yZKH3E8xWAhZKBEspRGTfV97+I1H9VkgZ7R+UzAjqqHKkDUwOT6s8l
         gO1znEOQGpZbPb4xxUbPPlG3oK4AKA2kIwwEM4a+VU2J+nsYyWoWPFWaBRwNWqjcMEDe
         z16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKz95RPwvt2A/xPxVUtkplb+bX/m8U+Ej4ZHCejgW/g=;
        b=jsKglXzHeCIeeer1k3FmDtGqy7zl2wVo5Ct8zAM5f9Mb4r0BdOLp6oIqRgpRcNQEMB
         gnUuQ2syv+E3kUOKsNmqzc2aioWhPWzHclQD1Zrd+Mpshd1wMlzbqdt/GUvlnN+y3kKT
         j8XRCFVUNkJVAi3fxerpUdEESpF6TMKTJnyIO7YwfrlapnYH42sH57wgpjAxQoQ1mSEZ
         m1q0ppmo0S+mJr809vZ74lUa9kKFAWaZcGRM3Y4FWj65FCtHv/jMWqMvgLTDtgRB2UYr
         RMl8h6aq32SbTIkGwTZzxUPE6mSjoEdH+l3fmlS2YY07kuBfn/knuzMq6aVBswnuM+IH
         O7Ow==
X-Gm-Message-State: AJcUukfvnv8h4JZ6oud+opAIA27MJtEwBVrNGgrmxiMYa64KOF7uGo01
        huK/15FOwnRpttAwKIBTDxckkzhWcTAgkQ==
X-Google-Smtp-Source: ALg8bN5YHnef8R1zm0Hvr114J04J+D9r9t7XMpRiqcgwILuZ6dplkgz147VYMi7k29o6nyK9G4go4A==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3206561wmc.116.1547227322452;
        Fri, 11 Jan 2019 09:22:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/17] ARM: davinci: da850: switch to using the clocksource driver
Date:   Fri, 11 Jan 2019 18:21:27 +0100
Message-Id: <20190111172134.30147-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the platform
to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 56 ++++++++++++++---------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9ff377f26c4b..e5b855103193 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -34,7 +34,8 @@
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 #include <mach/pm.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "mux.h"
 
@@ -436,38 +437,24 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-static struct davinci_timer_instance da850_timer_instance[4] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
-	},
-	{
-		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_2,
-		.top_irq	= IRQ_DA850_TINT34_2,
-	},
-	{
-		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_3,
-		.top_irq	= IRQ_DA850_TINT34_3,
+static const struct davinci_timer_cfg da850_timer_cfg = {
+	.reg = {
+		.start		= DA8XX_TIMER64P0_BASE,
+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
 	},
-};
-
-/*
- * T0_BOT: Timer 0, bottom		: Used for clock_event
- * T0_TOP: Timer 0, top			: Used for clocksource
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
- */
-static struct davinci_timer_info da850_timer_info = {
-	.timers		= da850_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+	.irq = {
+		{
+			.start	= IRQ_DA8XX_TINT12_0,
+			.end	= IRQ_DA8XX_TINT12_0,
+			.flags	= IORESOURCE_IRQ,
+		},
+		{
+			.start	= IRQ_DA8XX_TINT34_0,
+			.end	= IRQ_DA8XX_TINT34_0,
+			.flags	= IORESOURCE_IRQ,
+		}
+	}
 };
 
 #ifdef CONFIG_CPU_FREQ
@@ -742,7 +729,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da850_default_priorities,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
-	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
@@ -765,6 +751,7 @@ void __init da850_init_time(void)
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
 
@@ -776,7 +763,8 @@ void __init da850_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da850_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da850_pll1_resources[] = {
-- 
2.19.1

