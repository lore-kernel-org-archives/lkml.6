Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45823C4151A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1264B2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N60yUjql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfBDRSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35654 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbfBDRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so712642wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpMztC/tOJf5+QsMCzCmhQH4ifnfU5iOLhYPcU1sS/k=;
        b=N60yUjql8P/xPeQ2RX4uC+GxwRGxv+y9VAoPlTJb5gqqjxqvTZmKwwVJUs4dR/vh8Y
         vh08NvqKe1z4AumUksN0QVbUwtoVaUr/OoSieFpVBo6YFULEMcdXZ+9Xa0nd+4yk3h3f
         OK2S8UCRywsigEttgXjxwxqv95N1AvFEHP70H+AYTPakIlLZiQdTPk/HfceAuylX9/iw
         p2q7lxEsnXa9mxJ02GebC6FrxPd/Ih3yJD2vfuN1tlOE6N9aVU9EA3/DgvhWE+ZCoCZj
         Jlxo7kjmqM85fk7Nls6nEKYiKZN57YAZBMrSauoTDGVC8SB7lloPNDxESKpryuwc7Yc9
         Zv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpMztC/tOJf5+QsMCzCmhQH4ifnfU5iOLhYPcU1sS/k=;
        b=KN7m34BUSzy9nkA3CfhGlTouJBgbHYEAYUtPMTNPZP9p8JdjULzlfY+3sr58izqWO0
         hF9aZ+9y3hEF0AlMRrADQ4w2ev7q88KnHokc+80OmZeXUMDzTfdXgj6vG13FHWlvVQDj
         roq5KoITU9wiMvjIJNTPALvanDnXudB0tU0ejP2tvPwvR/Vao0+2c+/Q1bKTrnxwyo3j
         DmwkVfq7nCMlsokBebaYtDl6ngC+5RW1kQ55plfgCa3BaPOGhei6ckJ3ibtPHPuHpCIZ
         9VEVIAjzUz8nn2P243iq5iSob8zwnRLIEb/irXLIdOMI52dtYiAr4Rl9sPHH5nFUCGeS
         uguA==
X-Gm-Message-State: AHQUAuZuX0Zkny6SBs8qWpwLlds5Ve/xjPOiGeEMJX5ZJl6MfE5AyX9W
        Jez98ypfwnHkOkTR/3zsFMOGcw==
X-Google-Smtp-Source: AHgI3IaEujR7yHemQo982hkrrZo+rex7RFBzwzAFZhCaaOtpbF+cCER7nfB9KzSpiOWboFneEbOa0w==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr396470wru.50.1549300696294;
        Mon, 04 Feb 2019 09:18:16 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/12] ARM: davinci: dm355: switch to using the clocksource driver
Date:   Mon,  4 Feb 2019 18:17:53 +0100
Message-Id: <20190204171757.32073-9-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm355.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 2a523fa7c716..287cddaec67c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -29,7 +29,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -617,16 +618,24 @@ static struct davinci_id dm355_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm355_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm355_timer_cfg = {
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
 
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
@@ -708,7 +717,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm355_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
@@ -735,6 +743,7 @@ void __init dm355_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
 
@@ -750,7 +759,8 @@ void __init dm355_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.20.1

