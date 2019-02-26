Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1695C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7D8217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FGm3u9DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfBZMIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:08:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37499 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfBZMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so2006388wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VE2IVgiudVj0ad0e2GVjY3m8TiyaIXTiBa0oo3vwdL0=;
        b=FGm3u9DCsaI/NPz58hR4bTrFZT8EG73EVZNTqUyHb4ICRME92KfhoXJxtrAp0lvuV4
         qOfiOYdYKGFHduQfUdLXbG/y8q0JSJH9HoqZMLa9meTpxVp8ekxGLXxYB+8BA9a7IYYo
         iueYICu+CnKy233T2N4Qw8joDDnmd/PeMXpfabT8jvmJq8dt1PxrVAdNJ4xZBO/T71rk
         WN/LqyV2eglnDSWE2Lsk9XX1es+HKt851KXqnbiqE9lB8mj2k8X08pEoPypzJ6Ls/iUv
         3GzW3wqvS4wQlUR1IeTxUbX6hOxR71mTMPnw9z7QoEawI2ugeEAr8oqyt594OBrKCoJ+
         PYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VE2IVgiudVj0ad0e2GVjY3m8TiyaIXTiBa0oo3vwdL0=;
        b=oa7pG5hkJAjSP2QN9FPiHaqg6tXB637V/uD5i6OrPYjxtaacoojfkcV+qSnTXY73zq
         CLRS7m9ViP+EF8I6P3hAGYZeno2jL6bLj55kXG5noFg6rUhvcLPi1kIwd+UF4J3wAezq
         JT1dnlRANkBcCxA64lOT7WGUI7QIMhhPDTo8VC1/sFUhFek6S0bx+gnkLuleOfuMhY1i
         GpGpI2u4PJzPHlXt4+id7Mqbtxgxg9DGaWWFKWqA2M9pLTylG1rbaDRqnzbO9wi40R7X
         k1C5DUb67zuah+qrmYixmVjMdPT7c8jFW2aTL6yIRnwWl1hdxhNrQOUVjIUdjWSIJoui
         R96Q==
X-Gm-Message-State: AHQUAua42gkTh5Gz9l4p5k6YPQ9t8QMnpi1C5ua8aNSkHqwzKHWYSN3T
        cnKTmfmHYNUQRNGDCxXbDSfTJQ==
X-Google-Smtp-Source: AHgI3IbKMBOtb+y4PCJ0kZslqk2FwUYMcPtUFcglJEru0xSUvzn+T+R+LByZ4XHw7ei/qDrGg3HB1A==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr2434851wmj.152.1551182858798;
        Tue, 26 Feb 2019 04:07:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 07/11] ARM: davinci: dm355: switch to using the clocksource driver
Date:   Tue, 26 Feb 2019 13:06:29 +0100
Message-Id: <20190226120633.18200-8-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm355
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 57c5a660758e..c51a574c1b4c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -29,7 +29,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -624,10 +625,12 @@ static struct davinci_id dm355_ids[] = {
  * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
  * T1_TOP: Timer 1, top   :  <unused>
  */
-static struct davinci_timer_info dm355_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm355_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
@@ -705,7 +708,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
@@ -732,6 +734,7 @@ void __init dm355_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
 
@@ -747,7 +750,8 @@ void __init dm355_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.20.1

