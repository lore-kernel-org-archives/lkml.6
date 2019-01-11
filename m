Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1134220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TegxTHJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbfAKRWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbfAKRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so16020104wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfk3et7otLUxOjDItpbWy429zVa4HyUJDtZ/8CbR6Hc=;
        b=TegxTHJJI1X+1ffw9Ii0XYA3eoFOA4jPpjkQqX8Dx62H8alN7PomzfVaNMj/nZOJb6
         7yG/Nsco2tNE5UShk+929HPiIJ66AcS54hdYEk3eWFVZC2DtjIZWhkMlIJUTMCi0SDva
         OS1RJWntdvhyn277ihGVezT2c0epLzw6KjQMQMBD4q058CyCn7GhRZZiUT7ZqadYgWfW
         mk+DFDs6a269kM9HIcNa27XExT5hrs3NmPI/CzpiRXlJhnQUHYUmAA5DfeUeJ/k8uhtA
         HHZFGg1SUuh1mIlGiL79F4CbPt99CTWrjSw1r12Ry/LFiJA77pHpOBPW+TmiVDxcVfs9
         LYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfk3et7otLUxOjDItpbWy429zVa4HyUJDtZ/8CbR6Hc=;
        b=IOlHmbHeMEkXUSwQVP7LbYsxNd/rKYWBgtRLs6QU+soffH6tr+ezAM7Xa9VAGXCrkf
         gjhWjZ9NVUGcUwMJeUvFTmfoZ6yZqkDlxCS+fUJnWsdx+mxKHrPtiqamucpIcfPjJDQM
         iWQVWCkiG+/lOMOOmYrh/rgroC2BAfWxe9aKYoDG/KoSzgUEUJXTskXkItUVqQb5pI1c
         9D4U66GHZ8XhWymIa3drSmct8sDLBP6jaPATxtq4u7lxfqSkklNfLxuVZHi9nQcwMkVK
         pa8JbiMQCg3Hea8Oe/dl1QZVy2/KHXkbFwK+Lk6X+CfyAZw1S4cOkVNieX8AO0nVj/6O
         Sh4Q==
X-Gm-Message-State: AJcUuke1CNOYqtzNuIxK9p+AuBIIWSpmvHLBeJjh/fb0/O0Mnyx8DFDp
        9wNsidWgQigS1h0uqv2vp+t6eQ==
X-Google-Smtp-Source: ALg8bN7ldJGoTP7K8GnOoSfkJScx5WGi/6liRkczax7q8ZHiAlb1NeBhfS0UyuGP05DMy3DwgmHk5w==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr14250045wrv.288.1547227326340;
        Fri, 11 Jan 2019 09:22:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 13/17] ARM: davinci: dm355: switch to using the clocksource driver
Date:   Fri, 11 Jan 2019 18:21:30 +0100
Message-Id: <20190111172134.30147-14-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm355.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 07ad9d6c9cae..2fd1186ceef6 100644
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
 
@@ -747,7 +756,8 @@ void __init dm355_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.19.1

