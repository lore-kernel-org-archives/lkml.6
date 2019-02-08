Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F31C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F472146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="esF5UN99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfBHRhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36906 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfBHRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so4271559wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSsrz2G02KfSWFioH0HpLG7LPLBDOMGfLy9Hu4/jNlI=;
        b=esF5UN991/2OiLPkIUU5K43O3+ChQ9AEKuaUjv1LzmDoxxnHyExIUu3BNH5kx6Ts80
         YViu9SOrTg13gb39UnDSkAKimDjECx5vQM+hu+mjCQQwqD52mRe2fvujCyIKV/BmgkgC
         2s6e2JhmkWMSWuuXC8h1L/gtAJQih+99W1E2E+YkmBIUl98qnquvcmOIOUapVXvBh3Fc
         a/3sr1P5pZGu/Oe+jbCd8YtU1kwZGdFJQXL7DOr92FM948P+DjpLLqD5h/86KETOZAsM
         jr9j3KNZsKpC3R1l3BCwbeu7bR6o0OeRu1KVUCsNs92pq7SPuTI0r4L0b1s/fI/fe5T9
         HTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSsrz2G02KfSWFioH0HpLG7LPLBDOMGfLy9Hu4/jNlI=;
        b=LN53iEhegP7wSbsyBhrwve2Uhd9U3OIEOjjKmiq1SkdmGTG/PJxscE2w5zkpsZkDVy
         m+h/a0CLCo+wpI4wLadQKbPF12euddR8KI43ZjZ6n6Sdc8P8OUwb0n5sLRsERigG2H1D
         BfjV47mLAQZ9XxeoauyY4ucsZGxKPIOGSuJfCVrqtB7dc5AUD7ARo26rbgSeqPz90sUm
         tbM5g7yKjZVxvZ/9alcJdjUAQRf7R/4yckaTnJ2MQ3v/6u2gqjxM2FRkSDEQIHOkcC6o
         88uQbiV14oK2/Ol5gBYYqiRCK61Wm+0RyIu083j0l8wv5fz/XqewtufMS8TMKHXYhqJF
         SScg==
X-Gm-Message-State: AHQUAuYU+0gSBHJrPKYAHxjkIsdUFtd+cJ6V7imKRviok9j8HpZnnAVe
        d7Xq+EV7+Mv+f6yVlmhz1f0eYg==
X-Google-Smtp-Source: AHgI3Ibja6nLgjXa7zAwpKqJhkIwi/eQzesgdYVs13zCLuY1VqYTvdLfjHsWh8FBG8tQ/MmHCJyTyg==
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr16453220wrs.192.1549647326800;
        Fri, 08 Feb 2019 09:35:26 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 17/33] ARM: davinci: aintc: move timer-specific irq_set_handler() out of irq.c
Date:   Fri,  8 Feb 2019 18:34:42 +0100
Message-Id: <20190208173458.4801-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
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

