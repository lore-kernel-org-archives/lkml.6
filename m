Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9465C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8010B2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="n97X88Tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfBDRSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33700 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfBDRSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so728783wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=342TJAIzq0FojxH3IRoD/3JqW+OzNGquMTqCmzTMx4A=;
        b=n97X88Tflc/CoX9kL5MTs8i/rdGUyIHqdkOe0pwaHM+zariLoVmOXGbDphfU0VXWQ5
         u9eXr1rgIzDbvMMITmKuLNxwORgs9gxJ5jg7S/zbvpeSqaAGOyX9leVK4HmjbcslteE0
         gyuNWEdoyEfsr4gb8kB1W0m1LFkcXHhwPqz7BwoTIroMqfSiiISUU86RXDtQT9f1bfe6
         6P8FdftsskBD7a7BUGTSdEUj6X+f2qUqSsCqKmj3MeWqNU6SqDGeu2Vfqab0wDyZHzcl
         Ph2gOlsP3haMY5ABOj9hMUoYJouh9KP4QI/jTfra3kiwyU89Rd1n3cOzoVoCtiYWH2Vs
         oCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=342TJAIzq0FojxH3IRoD/3JqW+OzNGquMTqCmzTMx4A=;
        b=D/ug6wip9srM+xWH5uWFeGN9Qjc14qGUWXk2VP2lC98sqiJZYaJtUYSlODq7XCdZdc
         ZY06aVD4LNzjRDth04hjubWion43diZ9ti0a1i/lik2mYXHcWNKuigY5fFteqmDvGHWw
         7YW+0jBAydxzW6m+4/MVTg6XLPCn6DPanPidXO6uv2j1IQwSowQ6RtCK+1PztlkL+0Em
         GgIEInF5Bsg5g1Pf5WBdphkpyzLSmX9Ky2Afc3UPCBGEWEmZO0SrQEYRMOkbOXfKXLqn
         k9B6gmmsEOnidUl0Y3SdiNc9sbh8IpOyywaOoBKrP3OVEIfyVAuDJ7oAq4ScxGYNFRyY
         nj9Q==
X-Gm-Message-State: AHQUAuZmh/V84E/UQ2yjoz0prjxneTN0OmKRpHXzHVx/ni0T5G5bF0r0
        pzlSuhKrR5W1WbUBkXsB/GvLqg==
X-Google-Smtp-Source: AHgI3IaBumw6uiY+UQaRdb29WB2AOLfUPN+OEK5Mb90krRDXnrAh65h0mJ0AnQ+slltRxGcsNNd0sg==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr324094wrw.127.1549300698523;
        Mon, 04 Feb 2019 09:18:18 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 10/12] ARM: davinci: dm644x: switch to using the clocksource driver
Date:   Mon,  4 Feb 2019 18:17:55 +0100
Message-Id: <20190204171757.32073-11-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm644x.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 070660cfd93a..b80346954977 100644
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
 
@@ -686,7 +695,8 @@ void __init dm644x_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.20.1

