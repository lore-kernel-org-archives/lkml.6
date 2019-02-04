Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7709C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A92087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x+pp6MIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfBDRSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38484 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfBDRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so751425wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QQiAs+GwtXLiRAyXQoDEByDgHzILnQFl2C2ImYmup8=;
        b=x+pp6MIoAL733H4+s5auK+qho1hBoGOgwVKdOPzNin1jsO9ap2j0OOMDpExVyeXUoj
         HtTGDQc/mS9k1nFdXx17/HxLYElkTg/7RbVZOceyHYiB1RP0yV0Ch0QBg3poMH4KyYps
         2XHrnZ7LHZOuJpu8oXv3bvhdOTbVj/SxtyD0bA2eReRnBBxLJ2XhPGbREaoagtyL7oW2
         viks2isY/s4Fx8vXdfasiXwHoHgam72nQcaaVSN4tC3DtZZIAm+Yb5Ji9aCqqU7h8WbK
         FLTbIX4w5w2QC80jN9HLk9v48mHpdpE2LvQGVdHVlAAZkRB6m3s0KxboxNCWc9TN0Dht
         1L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QQiAs+GwtXLiRAyXQoDEByDgHzILnQFl2C2ImYmup8=;
        b=Wfqyz9a2ueumQ/EWdN/c8lNBMQHI+RKTAlL7ldSarQ+yxnsQIn9S3L3wQLPGJICt3F
         1vy+bjSHvxq23ttzH4Ikvrhc2OG0qIxs7wnGD7Rcr8c5el17sCw+QYqzUXZxLGaL+7wd
         x2lAKR/MMlVuaGCb+O9xwYncf3pxGsn+mUXr96Mzfhlq9uIpKUBKQIID7ZALhUDHDjVW
         iJQIT+QsrNrg858j81KoZwhqKUoaahTVdyYuEeoAj/X1Ll2w7vVExLHzCHFURrQ3Zc5f
         FKJdg5c5nXgxKFcColoHenjJ/1jhq241PeuD/ACV26+xnQ7+5T+2optWbwgoXj+Smoj/
         /6Ig==
X-Gm-Message-State: AHQUAuZY4XKs/oa4D7VUQG9fPVfU6tIOaZLO3b1o90rUdguyzCh1GJF0
        vwSIuXlBlmzESREJt4+ibr49IA==
X-Google-Smtp-Source: AHgI3IZKeGGk/b3KwzQYlUcQ6/fFMWN/K9fESM2sOAusU3cO8ryn0yJuFPgyqNopLeEcBuB+kZTPVA==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr288794wmj.129.1549300693974;
        Mon, 04 Feb 2019 09:18:13 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:13 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 06/12] ARM: davinci: da830: switch to using the clocksource driver
Date:   Mon,  4 Feb 2019 18:17:51 +0100
Message-Id: <20190204171757.32073-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/da830.c | 49 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 9a4b749cbb6b..eb2d92a6ee18 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,8 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "mux.h"
 
@@ -769,32 +770,25 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_0,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = {
+		.start		= DA8XX_TIMER64P0_BASE,
+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
 	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_1,
+	.irq = {
+		{
+			.start	= IRQ_DA830_T12CMPINT0_0,
+			.end	= IRQ_DA830_T12CMPINT0_0,
+			.flags	= IORESOURCE_IRQ,
+		},
+		{
+			.start	= IRQ_DA8XX_TINT12_0,
+			.end	= IRQ_DA8XX_TINT12_0,
+			.flags	= IORESOURCE_IRQ,
+		},
 	},
-};
-
-/*
- * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
- * T0_TOP: Timer 0, top			: Used by DSP
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
- */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+	.cmp_off		= DA830_CMP12_0,
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -810,7 +804,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da830_default_priorities,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -826,6 +819,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -839,7 +833,8 @@ void __init da830_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.20.1

