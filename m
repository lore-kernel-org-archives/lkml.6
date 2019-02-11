Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E14AC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9432075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YVyxgKDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBKM2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:28:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52507 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfBKM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so17485722wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSsrz2G02KfSWFioH0HpLG7LPLBDOMGfLy9Hu4/jNlI=;
        b=YVyxgKDku4pOuv5x0iSdo9blBgvFcAkZBq/8clZtlnq0GnolY9lQQkBxPuMYZ3tO83
         kVB6rLO+IumfcfA+pE/LHHXwRQHe3N14iLQQVfEQKIovjmr0XV90tYwbJHzeqOz4VWhk
         qeSdSOucO3WSIN/dNnqUh2vaAAUks94qHtRfEJt4goDP6tcC/S1AhtudJ2zmqN0vgu3V
         BySpDANYQtatLNdzSBLJrZz+S5u2URgcif4Pp+AMIcMcezH8e6gZCjncFya7ViJPrZD8
         eMFrSmuHXqCp2A+Mfkdd2MJ0Im/e9PQfxaeOI9ZC2jM1OFTxqnievCAPH86XgUDV90MD
         K9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSsrz2G02KfSWFioH0HpLG7LPLBDOMGfLy9Hu4/jNlI=;
        b=OBOTrxooa864ZPc0AUqlGg2JZ2L5Ma5Ikyv8m9fDy3xyOgzZLuEBM0MRUfZpJ9fgoI
         CIsfmOyH/XBniYVoPVxvU+rmwbXXGKIGBRPYFb77mrFp1c+rvlGDkUk9YbbHZDNPN+/6
         d/nVx75j5jGJb3P0LNeQzJUWf4SqesQlDZ9c6FAJSFy4RlI27z0GTKz9PX6OjExWjPKe
         P3YEu+GtBL+5zGsP7cEMb01EumABkqPc58h3yRTNJR8FwYTI3WAJQUJC/WlhrjTECXXn
         nP7Kr0iI78HRSC+XkNI9MHR3GSWlSNyDa40bPj0bO22dpRIuwtNbWFOqchSUGMTUuDsi
         s4bA==
X-Gm-Message-State: AHQUAuZqyfM5tTcAb2p8+Q4GlZ/7Jq+Bd2t0La+Pr0G6lrX5/s6aRrQE
        VAnCuoi5fWPc+B1co99Db8TnBA==
X-Google-Smtp-Source: AHgI3IZkvzKlJatfCe8R3gyxkVLnX16n1tZtTLl1shVjlLpTu1MIksbdelkDfDQnOV8hJs28ZQtsQg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr8854673wmh.86.1549887994484;
        Mon, 11 Feb 2019 04:26:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 17/33] ARM: davinci: aintc: move timer-specific irq_set_handler() out of irq.c
Date:   Mon, 11 Feb 2019 13:25:50 +0100
Message-Id: <20190211122606.8662-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I've been unable to figure out exactly why, but it seems that the
IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
level irq, not edge like all others.

Let's move the handler setup out of the aintc driver where it's lived
since the beginning and into the dm* SoC-specific files where it
belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c  | 8 ++++++++
 arch/arm/mach-davinci/dm365.c  | 8 ++++++++
 arch/arm/mach-davinci/dm644x.c | 8 ++++++++
 arch/arm/mach-davinci/dm646x.c | 8 ++++++++
 arch/arm/mach-davinci/irq.c    | 3 ---
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index c7cd765114af..a732f2ea1d9a 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -744,6 +745,13 @@ void __init dm355_init_time(void)
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm355_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index bde3c3b94cc9..79afde34cfbb 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -785,6 +786,13 @@ void __init dm365_init_time(void)
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm365_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 6d3498058283..007d979d2d64 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -14,6 +14,7 @@
 #include <linux/clkdev.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -680,6 +681,13 @@ void __init dm644x_init_time(void)
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm644x_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a0a8b336c1a4..a643d78ad644 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -664,6 +665,13 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm646x_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index f5578abfc0aa..0f469c59acfb 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,8 +18,6 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include "irqs.h"
-
 #define DAVINCI_AINTC_FIQ_REG0		0x00
 #define DAVINCI_AINTC_FIQ_REG1		0x04
 #define DAVINCI_AINTC_IRQ_REG0		0x08
@@ -146,6 +144,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
 				       irq_base + irq_off, 32);
 
-	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1

