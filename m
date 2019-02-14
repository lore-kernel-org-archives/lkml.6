Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A978C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC802229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HKivHK6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502035AbfBNO4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:56:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33791 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439459AbfBNOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so6836692wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pspZEiFx1OxalovNGuxdYbLMS6GVItzFF36iRMFdcj4=;
        b=HKivHK6KTbHinU7AnTo6me92j8tDqpInkG5K2dPlc3/YmY89tWBu+N2Dswod53Bxau
         ztNbv8TpaWSnKw3NP2mmEKldxp0iUphI4d+eVB668tRV9MS6wEV83hvkn2t9S9nmjism
         pEeim6A2Q3qMBqRzhA7WVsGm+hdi4i0rReCWHya+M4D9SfRrdaM22MY2MZHbYE8rQCq6
         q95+BQqXtWpKYScPji3soT74TQurnKWsRd5SCU0uQPR+Mi5tNZy3wAgtJ8rlB2Yy3rmG
         gaVrvtarFFpd7TJ6/gf23DsFoSlKhveZAbsln7Fb50XvIoOuGq4tKB/LXK9dUxzk8R+n
         bFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pspZEiFx1OxalovNGuxdYbLMS6GVItzFF36iRMFdcj4=;
        b=qbcdy9SXndnJYWk34rhVxETgUCqqWOOTLRxdZc+4Gkz7BpAudani66aUH+jA8E61tt
         fKg/PSIIyDLDepgxNsa+h0LGe1NlGFHuj2igbUjH3MD0bwSYilqnjcuFcbqgK5LK9rVD
         6xaAU8uSfbSbXujtN41uglkYJdTbs2WLtRjposWOSILeqjNe+rAyf0VQjwEsHl+9apyo
         jHhbpgcxnTWRRkR+gFwLUUU2Y7GTbmb5o+UB6I9NQa/Abo7b1dscOsQMsbLxZLingrPM
         Ov8/7oVHViHu1KqBShJ/y7vOWN8js0Pv1r3XSr6R/w35cuhZsHbbWBpUIqjg6KhfAUpo
         2ysA==
X-Gm-Message-State: AHQUAub5F8kqrt2Vy0svjs2UHOAczbklqEv7H8CankEkTHqQCHUBWoSw
        bOXEdTU2rHLKAwGvvZUXmxVJcg==
X-Google-Smtp-Source: AHgI3IbfHLMHCu9LsXq3ibLccMbRlfN5BlyP3wC9ElCDoGzIxrq4rheK5hhgwbGxwo/3XbXKjR5T4A==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr3237035wrn.298.1550155968615;
        Thu, 14 Feb 2019 06:52:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 05/37] ARM: davinci: remove davinci_intc_type
Date:   Thu, 14 Feb 2019 15:51:59 +0100
Message-Id: <20190214145231.8750-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now use the generic ARM irq handler on davinci. There are no more
users that check davinci_intc_type. Remove the variable and all its
references.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/common.c              | 1 -
 arch/arm/mach-davinci/cp_intc.c             | 1 -
 arch/arm/mach-davinci/da830.c               | 1 -
 arch/arm/mach-davinci/da850.c               | 1 -
 arch/arm/mach-davinci/dm355.c               | 1 -
 arch/arm/mach-davinci/dm365.c               | 1 -
 arch/arm/mach-davinci/dm644x.c              | 1 -
 arch/arm/mach-davinci/dm646x.c              | 1 -
 arch/arm/mach-davinci/include/mach/common.h | 2 --
 arch/arm/mach-davinci/include/mach/irqs.h   | 3 ---
 arch/arm/mach-davinci/irq.c                 | 1 -
 11 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index e1d0f0d841ff..a87e158a709b 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -24,7 +24,6 @@ struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
 
 void __iomem *davinci_intc_base;
-int davinci_intc_type;
 
 void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
 {
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4a372add8cf9..19874f5ef542 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -146,7 +146,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
-	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
 	if (node) {
 		davinci_intc_base = of_iomap(node, 0);
 		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2cc9fe4c3a91..9e18b245266b 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -807,7 +807,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
 	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da830_default_priorities,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..e823b89e2b7a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -739,7 +739,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
 	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da850_default_priorities,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4c6e0bef4509..03ce5df28d87 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -705,7 +705,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm355_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 01fb2b0c82de..3e034f0478d2 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -722,7 +722,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm365_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 38f92b7d413e..66bab4782c62 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -646,7 +646,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios 	= dm644x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7dc54b2a610f..45efa715a2c1 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -586,7 +586,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm646x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 944afd57ee38..34e48de92dcc 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -21,7 +21,6 @@ void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
 extern void __iomem *davinci_intc_base;
-extern int davinci_intc_type;
 
 struct davinci_timer_instance {
 	u32		base;
@@ -58,7 +57,6 @@ struct davinci_soc_info {
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
 	u32				intc_base;
-	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
 	struct davinci_timer_info	*timer_info;
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index edb2ca62321a..03c446635301 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -30,9 +30,6 @@
 /* Base address */
 #define DAVINCI_ARM_INTC_BASE 0x01C48000
 
-#define DAVINCI_INTC_TYPE_AINTC		0
-#define DAVINCI_INTC_TYPE_CP_INTC	1
-
 /* Interrupt lines */
 #define IRQ_VDINT0       0
 #define IRQ_VDINT1       1
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 363ca6d76cb0..2e3426ebfd97 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -99,7 +99,6 @@ void __init davinci_irq_init(void)
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
 	int ret, irq_base;
 
-	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
 	if (WARN_ON(!davinci_intc_base))
 		return;
-- 
2.20.1

