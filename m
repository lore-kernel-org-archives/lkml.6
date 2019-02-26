Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4984E217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gY1xvfRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfBZMHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50497 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfBZMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so2148350wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3KP+rIw+f33h04TS2sogBibwgW1Uf1B9wKJUk0AkUo=;
        b=gY1xvfRwCDtTJJPgaFVZKL6QXSpLCZTvti6w6zoFVCNEjD2QU8a6uqMnjlmq2/Hnc0
         RCXIvMxbjb8njnRf2EL/9NUZX8vc0FfgsSuDmJ+QRxJFqCeiLj+ZEc1Z24KjTD4FGlaG
         oxsiBy3r//dukxRhNVPmIH+8XtThUZ2pDqPcsgpIfb0/lSA1TnCtI7fpSg7Fh00/2n8C
         tDMpkzxHmKHtAhqVVzRa6pCzwH6DXxjXI+xWswkPgmLAUj7hsYzPBS4ujukAlpk7cwfG
         0oNXTzoQYsoPo1itrjFc3Eq0BqZMBRkZtLUTrPTJyuIvz8jpIHCuYUX6b1HBM8a5r9BA
         1zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3KP+rIw+f33h04TS2sogBibwgW1Uf1B9wKJUk0AkUo=;
        b=UVKuAiSTASHQKDWTjs+oQsoPXSjRmfARL8do+87UwjECCaQyB+u9bmnP+VqBBSAka2
         WoQaCcDWO4pt52UqQ73jYr1L7+i6ME2n7d9kh8aWZmAcvznYJSqOcFzYLnqsJtSOWuwc
         29ltHR1X81sq7Ik4zjSciUvIrKK3HEi9zfUT4Jwxy8KUWerOf9LcVDMdpYPb2HJFlXIL
         vjEwk8WYFbC6IiUh8twr2yrva5KGpBJ3KkI69nRwkjJDjr13YVAOzEsHhyEdcSkRPQwe
         o8zPYLHHv5AZAMvs5ITKroAAW35lfIkV4chgR8GrepcmRmMoSKP9c6BzoR0bB/ugy0T9
         nOqw==
X-Gm-Message-State: AHQUAub0UDG9SokmMnHAg5CABUNSyxyptiEzr9l9xXnduFgXS6kgJyQj
        vLk7ufbiLUUYrWA/4qnl80O05Q==
X-Google-Smtp-Source: AHgI3Ib4G6cQlEeSrlfHOBAAuNqCZFuCdO0W+0gFn11G04G480ZW5k/bXaV9DF6jXBZ89MaNTquGTQ==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr2299669wmb.95.1551182861432;
        Tue, 26 Feb 2019 04:07:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 09/11] ARM: davinci: dm644x: switch to using the clocksource driver
Date:   Tue, 26 Feb 2019 13:06:31 +0100
Message-Id: <20190226120633.18200-10-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm644x
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2b0e921aa755..f5f40a2a5110 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -26,7 +26,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -559,16 +560,12 @@ static struct davinci_id dm644x_ids[] = {
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
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
@@ -646,7 +643,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
-	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
@@ -668,6 +664,7 @@ void __init dm644x_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
@@ -683,7 +680,8 @@ void __init dm644x_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.20.1

