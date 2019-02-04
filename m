Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E1C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52BC2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xB7T4utP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfBDRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42016 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbfBDRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so660140wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7f+IdClyq4iN+qevcxOTQ2pG6vC1lbkrjwR3WneXQM=;
        b=xB7T4utPO7HO4AgQ2QdEsSXWbt1pEVNOw4Cb/Dlp/6rNyrvRCtD0V0wt4ZSX00TIl4
         /yWD//aJMI1ccXMla8gTXTKUvQMGgWxbCn7NjYXtvRZUD/MGWDd0qWH3INPCo5e9JE9J
         5BrgzHYv+FWHfrycPNc6BJHPDAjONAvFcHHJTH6RrWU60FVampGZQKxcQ1x4BsR/Byqd
         YOBZxGNdMe8rZobnmVvTJdVc/qgZM6oI0xaX65gWIcSU35tJdQtfZNmZVuHMWEbchaV8
         2QupV1OU9fpu9e0itO3ZZr2H5xc1cmEh65bAuWfb9Eeui+7UnAy2pFVqZEo4x1GNoBCz
         sQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7f+IdClyq4iN+qevcxOTQ2pG6vC1lbkrjwR3WneXQM=;
        b=I4wvRHGAkSjFih8vGH25stRsJskTVh6RacorlUhHbvrF1qR99Mbk6t8i3xkG1Rfnla
         OqG562iaIzXZ9ku6ZDNGMEC4QSR+5sbki0CkpjQ873R/YH8bDarNMMYRDlKoFBnBeMgQ
         P1SOiA2JCaS8/dt/IgeTfPSuiA8g7LdN88oNCWyO33hEsjq5ep9YTFMuNtn7FUotwGT6
         e68WzdzayQdNGeHslem2jNS9+jSoAH4tDs97YaKLnETqvcc2SSr0dqD/kI/tij5rJtsQ
         +IggebW2410reNcPVlzu0iTGKFHJM/KqN10cb9Z2FoARireMdJGVacqWBhLjvPl7vDh4
         dobA==
X-Gm-Message-State: AHQUAuZhg+LNNoyM+c6SR5PeGMMjG+UA0wd20cOAuoHJO/hQJmuUm4Rp
        reSL1SMZ4bMREDKX575uaSwPcg==
X-Google-Smtp-Source: AHgI3IY5wRBd5q6xsZy6JU1b+L92KVhmLgZ8tQ/PhuvwVTPnJfV3QVd4pZz9wBrb/na5tLfkSO1H8Q==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr340181wrs.53.1549300699783;
        Mon, 04 Feb 2019 09:18:19 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:19 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 11/12] ARM: davinci: dm646x: switch to using the clocksource driver
Date:   Mon,  4 Feb 2019 18:17:56 +0100
Message-Id: <20190204171757.32073-12-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm646x.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 73a0f0226017..5058be123dbe 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -27,7 +27,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -498,16 +499,24 @@ static struct davinci_id dm646x_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm646x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm646x_timer_cfg = {
+	.reg = {
+		.start		= DAVINCI_TIMER0_BASE,
+		.end		= DAVINCI_TIMER0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.irq = {
+		{
+			.start	= IRQ_TINT0_TINT12,
+			.end	= IRQ_TINT0_TINT12,
+			.flags	= IORESOURCE_IRQ,
+		},
+		{
+			.start	= IRQ_TINT0_TINT34,
+			.end	= IRQ_TINT0_TINT34,
+			.flags	= IORESOURCE_IRQ,
+		}
+	}
 };
 
 static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
@@ -589,7 +598,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm646x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
@@ -654,6 +662,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
@@ -670,7 +679,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.20.1

