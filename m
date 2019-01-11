Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7D020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MXc5ELZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfAKRW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41250 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389026AbfAKRWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so15982553wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xONpeqOZllu4lUrmjTAaVSXxrn2MUyb6d2vzr8hXNI4=;
        b=MXc5ELZhvYYlr2tqznZ2MXg3jugFD12iMsi4b+wou+JPyWns8XxQzyDQuSODLpqrfj
         9uPI67Dil0VkwPmDr52be1ru6yiYKAkrbD9PQFtIXdJ/0hLcbQ6TbJpK5naYp6PRuq2J
         aRnt44TEHTdwYBjweX1Xfo9Kaev5BB365S6oxHKF+8Kwf/zD04mi4+nyslc5fNn8Ee0h
         T39y/DH4emHPOmLgF4BlHxN2pqK+BxIDSz4F7YfVTvQOQ6tMg+M7tDVey3Wc3UiyGxPc
         H5u8qsYPce/yDQPsHVvX7bvEV6095HVTSMpWu5Cly3Bc1G3y/1W0L5y8Xzpj8kIKquPn
         2jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xONpeqOZllu4lUrmjTAaVSXxrn2MUyb6d2vzr8hXNI4=;
        b=puuQwPFRPb8P70vfDqZgt9lANByZtKQdTlgt2ZMcuxO6k2zhFtjUZ0kw4qncp4pNd4
         b+qzO/4Uorh/MlIJtSFJnSjc42f8VcaGQ4L09Fts5JSiK2R/5+gdc+zvblGzgFAycJpH
         X5+77lT00YyVo2S1ggYFOZ/p30n2+yxmj40J0sR1te7QwU7B2FJBRqCnxeCiR6Apza3b
         owYhtAqfCxfXeDkkhy757PZ//HKKfpIxH7g+ou/W7Yo82EJ2jkJC7ZTZKrsjZ/Ucb66n
         AXXldu9r915jHmouNahbJsh6oIlNj38niMpWfoZztDq3hQqUHgIwMhw55mmMBeP/HgwY
         r8/Q==
X-Gm-Message-State: AJcUukc6pY3MW6NkxT1gppqflllX23F10/MFmI4jETj2517n9S3QZAJi
        dJ2jQNyXQ+yxZbsH3w5WqstyAB5eZ5PCEA==
X-Google-Smtp-Source: ALg8bN7Ubi/V2Kzm4Hg5H3ZW87JrSek0YbUnwMrl3V93xTA254vXrWQLBfOyR3Z7Yd/IKK8I/txzxA==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr13870231wrg.325.1547227328725;
        Fri, 11 Jan 2019 09:22:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 15/17] ARM: davinci: dm644x: switch to using the clocksource driver
Date:   Fri, 11 Jan 2019 18:21:32 +0100
Message-Id: <20190111172134.30147-16-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm644x.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 85d69ac1bd70..adbcdefadee8 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -26,7 +26,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -558,16 +559,24 @@ static struct davinci_id dm644x_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm644x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm644x_timer_cfg = {
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
 
 static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
@@ -649,7 +658,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios 	= dm644x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
@@ -671,6 +679,7 @@ void __init dm644x_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
@@ -683,7 +692,8 @@ void __init dm644x_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.19.1

