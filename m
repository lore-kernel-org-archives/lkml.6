Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055FB2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mvjl8N0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfBZMHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37501 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfBZMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so2006445wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+q3jcIBA8iA3WrvXvXlUfFJ74Yle0NYMm3Gt46HxYFU=;
        b=mvjl8N0+g+hn4opFddnHse8SksgrmWpS/elTMcdYj0HUEIx7AT34boE2axVsukHKxT
         hLyqaDhb3y/1qp6j5WnRzbjC//UUpQrZDg/ilmekFsejf403p8nCQDaiwm0aAxeRh3PK
         DqYAcGdODPF9V3uF4F1ke8wgBKYbyFyNlBMq4QrNBhKz/lGv+HzjQhINA9/+mWEj5wIO
         mmzn2seL55dL20c9PMcQ+2xAbwEIPEXDzkL4aOVW3Nxw2+VOtTUklwjHVwRm3GU0u3+h
         7FlkMpfEAORfQq6sOKYsawMsr/7ltoEmrfRGOqiq2gUk8hbJ0bWBZeUX2Am4xavSCJzw
         pBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+q3jcIBA8iA3WrvXvXlUfFJ74Yle0NYMm3Gt46HxYFU=;
        b=kanC9V8Zf/kk2cGoVyeGBLI/fYBhjPeht58uMUQ6LSKC6Ff1AyEnH6s4i4qleRtJVI
         sNnnvxOr68YTZCi/OMVHoctVrN1ZLhlXPHcskG/o3CxW+6vmtuS8u651urIaRITgF8Li
         lonRfVnPK3oIc+Kzw8g23Fwi0/UA9G4J+zBVhPynbiFtikXF9deXQGCMoyAGDRI1Lynx
         FHTwfjwJKUTkstgCa53jA9r2BZo30Fq+9DOdgiD2fP58KHmlX6Wr9zm3JE3huDHBMn3z
         DtQC5qgI/5vtS8ghd0YYp33DXG2wvgI7xCtK/ONKKHzKvon65HWcXtByv+4FReodvj/s
         rK3g==
X-Gm-Message-State: AHQUAuavUrrhZIkpWmxEaQkEWhKm1SLa1LE9baihzFHQck//IUhgCAL9
        GQ6uEIvsnwCTCwzJnZrX7jeYbQ==
X-Google-Smtp-Source: AHgI3Iaqo7s1CkrlKogYqngAGfKIzByX6AWdQJ48Pw2NviUKDV062rtGRzO7ZFJWv2cA2qCTnRHnrQ==
X-Received: by 2002:a7b:c929:: with SMTP id h9mr2442456wml.106.1551182860031;
        Tue, 26 Feb 2019 04:07:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 08/11] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Tue, 26 Feb 2019 13:06:30 +0100
Message-Id: <20190226120633.18200-9-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm365.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1d82bb630d11..84f5d04abf31 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -34,7 +34,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -659,10 +660,12 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static struct davinci_timer_info dm365_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm365_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
@@ -722,7 +725,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -770,6 +772,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -788,7 +791,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.20.1

