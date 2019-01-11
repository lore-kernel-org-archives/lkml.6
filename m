Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83BC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B4820872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zOAjB/wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbfAKRWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33339 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389028AbfAKRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so16097631wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGCXdQbXQo6tBzBdWymV0+bJ83eVX08S8XI886KP7NQ=;
        b=zOAjB/wBMRgd7EDZtd47dht0yzVZBvQL9/GNV9wdO8oZFySafi2AHyLNcRC1aztdGA
         gG99aUituxdWmo0XA/VZ/KFJ87UL2PQfAXNA4s5WBBe6gH6kYFTK+cEEbOK4alCR/niA
         yOrsLtn9DXmGvHvtWOj5+J11pKhSujg2lXnt/KLTaiO7KQv+RPpzjiclOzR98kZhXaHt
         80JDC4KugKB9J6ftTIUo5kucvmHN+G6cY3BwWUDuuWFvMCaFdrg+LSNPcSUhRsaKwrmI
         Po6PdHYxOlvtdXow69UE1cBI1+/hM0caYqxrw4EPN6VdwhIYuPRGQJTHuqvEkZYcoOpr
         vkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGCXdQbXQo6tBzBdWymV0+bJ83eVX08S8XI886KP7NQ=;
        b=NJISWKsb4e550vIHhOeJiMbZg511aykLVKYwej0aezTVPIbWRhHF0palZFRgZ1EWg/
         VZJtxf+WYFndBih/zXiJCKdZMnnKF3oYXK7Vviw7BammKNmcKgNfFeB+ToZAEZnzPXfH
         q7q+47iMgkHRtl7IHabfox70mDgzFRTqmwTKADV0dEWZ0tqslK8iAjyxXlwTxgivhNnu
         JekAjGRCOGl+oWdB3JOxEGEG4wRa6PK7/jthA/x573n6liio/YCnJQdCcAqNQ/Zf6j3Y
         b17MFGClJuBuNSUbqYLyB+G04E+hsmIdm38AtJ+0KPWgtwnyAuF0MeRVQ69uRiwYi/tj
         ghwQ==
X-Gm-Message-State: AJcUuke/x/ABcwXmC/E49LgGeWwZH6VU/n9NyiRMEkpGsVoiZZ4P8NNP
        VuwsK2zkTnbnT2G3tv9gwRGsig==
X-Google-Smtp-Source: ALg8bN4gtkI8QXFfIK0wr9LWfM3C/9/3Xy01+BZz8ZntqCPIkASRP0gdkz8suSUkugkgNfwOROssuQ==
X-Received: by 2002:adf:f149:: with SMTP id y9mr15412531wro.284.1547227329955;
        Fri, 11 Jan 2019 09:22:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 16/17] ARM: davinci: dm646x: switch to using the clocksource driver
Date:   Fri, 11 Jan 2019 18:21:33 +0100
Message-Id: <20190111172134.30147-17-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm646x.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 018315fa9aa9..b3412920da0a 100644
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
@@ -667,7 +676,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.19.1

