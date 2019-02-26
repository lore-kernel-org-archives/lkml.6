Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CF221852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bFCjH8/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfBZMHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfBZMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so13637967wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgtIZySSgfZ+/sbHqf6H3YX/qq8lGhPHEAZWv6CiHLI=;
        b=bFCjH8/G2/Y9gTTpN78bBfX80XNlNONWAheGl4EzNSi2CewFeCN3HMBG53/EZB9Ids
         IOctgcHOANWHFiPIH163gCETHcJuMLDIsvFAFolRhAfCFxNFSUOHU1Tf7zn3xvwR2PWm
         pkiQ4CIjV3x+6i/T6BhhWlT/HL67YR/HlHQ36FXIDPhaYJziYaXTeRXxL6+Hq6AIEvo6
         WbFfqSYFPsKFGC4WOlod3wk1/94NI6qSv8ekW+tnkTJ8JYC6K4bTW7JZW909oc8EWvSX
         AiSUhepIsDCFE8hFHXXXsp1gZQkk9JjNpl6Ua3R68z1QcaQRmYOo5nmD6i1MPUvP2e/O
         wB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgtIZySSgfZ+/sbHqf6H3YX/qq8lGhPHEAZWv6CiHLI=;
        b=nn5IQZre/nEpjHhHOeD1f2as7Q8SSE1BG/cfmvTzKUaBAdV8jT8pe21r963uyzVAlm
         AuRhv6E5MJoBubmy49Xl29f5qVQU48GJIki2uhvv/G0lm+lXT1l+PMHHFPUQ9+OJ92oY
         BDPHiODL/mKGOEOzlIhULnlmjSmL+efJ277lVrO5BKu7YY41njhMfzDc/mCtakr2w28t
         RNHY9flzWqBsREJewjz/NviUljBGZrNSEdL5YDYIsV11tKH9qc4AOpOec5fGaCH7HEIy
         CG+T715pqZv+71aSdBFjy49WwThAwcEwmzi23dhVwJbmgBq676BkaKHTbnn63AsTsCg6
         mb2A==
X-Gm-Message-State: AHQUAuYR8+jqACHilBNWcM3a7BlcyPjdmQMGXwMv9+W0NX2zgrCRZfUK
        CQQWH8ssqpfw1koB9iNXAflRDw==
X-Google-Smtp-Source: AHgI3IYTyeIxj1hlOuHawesccQBHZBDIC9FzYUcs32pZ6/e262nL7awl/UxSMmLbeSPYHeMTWH9fxA==
X-Received: by 2002:a5d:6592:: with SMTP id q18mr11442293wru.230.1551182854871;
        Tue, 26 Feb 2019 04:07:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 04/11] ARM: davinci: da850: switch to using the clocksource driver
Date:   Tue, 26 Feb 2019 13:06:26 +0100
Message-Id: <20190226120633.18200-5-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the da850
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 41 ++++++++++-------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 72d64d39d42a..5ce58ae0d764 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -34,7 +34,8 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/pm.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -332,38 +333,17 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-static struct davinci_timer_instance da850_timer_instance[4] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-	},
-	{
-		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_2),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_2),
-	},
-	{
-		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_3),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_3),
-	},
-};
-
 /*
  * T0_BOT: Timer 0, bottom		: Used for clock_event
  * T0_TOP: Timer 0, top			: Used for clocksource
  * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
  */
-static struct davinci_timer_info da850_timer_info = {
-	.timers		= da850_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg da850_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0)),
+	},
 };
 
 #ifdef CONFIG_CPU_FREQ
@@ -634,7 +614,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
@@ -671,6 +650,7 @@ void __init da850_init_time(void)
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
 
@@ -685,7 +665,8 @@ void __init da850_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da850_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da850_pll1_resources[] = {
-- 
2.20.1

