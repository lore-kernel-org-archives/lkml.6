Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8960C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F42087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nafIKDY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfBDRSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37658 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbfBDRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so751308wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePcYMiqf1jmPY58s/nmJfIEQ3ktJRw9TAoJLNQ425DE=;
        b=nafIKDY8pCEVmUC98rmOxBpM/YpyKHHfGP9xeNo+EyYdsy38YVOlGhFo8FYS0wCrZM
         sLPBVwTE6RjP29WcO7EjMdeICeedB1hb/wZA7aB5ChbNwW070SeFf8nAy9Zz/mVaO0/d
         2u7feGxz2AdcZkcIPdlDWWKcYu781PhELfWPfYWwDrk0K8R9uOBT6MNBdCjHP33LLhwM
         crlWZwnsQaK3D5mZE65/c7AwG8pJLftA1DgIikdxORG08YXU3SfhJEslVrgwdqsaamsQ
         6L99tPpoB3SRd55wC2dkS+CWJNhHP9F1uOWG2Lve874ZWVYgq4QPhizr971ksjbQ2bNc
         lzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePcYMiqf1jmPY58s/nmJfIEQ3ktJRw9TAoJLNQ425DE=;
        b=O4hEhglgQhgdtYCE4C32m/vxiYGW1RzqvDkI+EX1+FdbWPliguI3bh4oMJOeqvDKDq
         pN2y8ZWRBJdRUZySNwQC52aHBKrRFyofbfGZxGtpTg6QfTGizRhuxBsKhBWckFz1qUsI
         MGE7XErBT9IefULfpwywq59JJycycIIoCebmbYzwazx4tDu820pIwz9O+GlIxesSY/pJ
         kBJxbgV7qdffNzvT0FmpHSc7truVr7bhssZw9UGmBTS23FWfDAyX1/TZnL6l+4eP/qJM
         qB5GqWvbC9rclFDip9H/OTNTtkBDaXKSkwmY4Zg5/gj72DI2aDQcBJ9OYXOxVTEINKtZ
         dr5w==
X-Gm-Message-State: AHQUAuZC2WcjdhGOW8d8DWEFrodxSKxB/5SP6RZ9BT2wZqoIcAY0pHGG
        /4g+R/sDDJtrIF5i/I0qCc+RDQ==
X-Google-Smtp-Source: AHgI3Ib5QYB3nXGgHQVS/4uC3KoNV1vNd32LlwiCQomKz0AD+XT5L07NnNv2x2frRwV/HF3q8TBTUg==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr331650wme.84.1549300697431;
        Mon, 04 Feb 2019 09:18:17 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/12] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Mon,  4 Feb 2019 18:17:54 +0100
Message-Id: <20190204171757.32073-10-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm365.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 68bd78dac293..fa83dec162e6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -34,7 +34,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -658,10 +659,24 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static struct davinci_timer_info dm365_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm365_timer_cfg = {
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
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
@@ -725,7 +740,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm365_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -773,6 +787,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -791,7 +806,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.20.1

