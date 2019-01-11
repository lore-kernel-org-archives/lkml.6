Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lqIK8IKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbfAKRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389011AbfAKRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so15991092wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uDRh+zfzHIczZUkwUu8zWkfC3Ym8OxzyS3iE5hQDh0=;
        b=lqIK8IKEc/qe+wnZ/U5o2f3zXE8BjI42VkuuKyTUkrN0Oq5RwKeqQiErfurC7yp6Id
         XuW2as02N7M3q34vFDl5FtHkQER1jAkXXcnvkCfTLJkmml412cxmFqwFB/jgLtAjotmY
         AYjNpANfTwNfNIFgxTdgshbpx8MDkIPyspNnIXc8ZOytHc1Bh8N7rbgAV61/3quR9we6
         MJA4lkdu6c3OWVSEmFSY20f0IbCiVJyPwaNLqNRBJlSoiEP3EhmuTHzfA6R3+hTJ/Iuq
         zZfC1qRlULIsI+YPdZ/O+w/OBO4LgtDbPzy6uieNXOzhfEmgCX57So3uK1tQ4n+Ou/We
         bkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uDRh+zfzHIczZUkwUu8zWkfC3Ym8OxzyS3iE5hQDh0=;
        b=fi/Iyk5Z6HpIMUg1KRG1Qn3Vn8Mn69xqWGmFZsd7dZhtmNbVrwK7quQollQhxDaM6s
         4qpcdBfNEQyG41p/sbqKUXKFuuvD7HfIM9XT8eY0LwX+02nGKdGVI+L4UMIQPkRTu3DH
         9GZ+mOVeLpv5TuY/Jo7ACYPIDxq7nIJdb1uaaMxAwvMIfuKlql69O1FLxPt3KJ7aztLz
         idi3dJSCQ9wqkoJ4JP6IOfZmsdAhqFxuF50qkaQTNSpLEDKzUh8vivIKUGLiPt05M/6D
         y1tJcBdEuzf7gYzNuFmHH0kKhUqvvYEar1Xh7RcoUj0bR48gM+TtUGWF1IlBZVmJGmWJ
         Kp8A==
X-Gm-Message-State: AJcUukeP2wpz7BP2egeacqzTSkNWS4N2Bwy8z4DGhSNXyACFVj3h7/Pl
        WRW7AfFtvq1YNaVgiiiT1jraSSWcnL6RBA==
X-Google-Smtp-Source: ALg8bN61524V+BNotDYTCh1j/dBf3aS0mwzUaWax/dfKlCzaQ1M5ahcNhRYrC9JW1oeJhFD7T5E4TA==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr14201248wrp.111.1547227327498;
        Fri, 11 Jan 2019 09:22:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 14/17] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Fri, 11 Jan 2019 18:21:31 +0100
Message-Id: <20190111172134.30147-15-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm365.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 842b7e706ba1..ff7754ce2bbe 100644
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
 
@@ -788,7 +803,8 @@ void __init dm365_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.19.1

