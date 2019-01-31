Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C7BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ECF2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UicjhTZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbfAaNmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:42:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53204 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbfAaNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so2539052wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rn7F9pCY08KLVBMiHrxRjQBYdDwuoIM3SNqvllQs3A=;
        b=UicjhTZQKQ7e8FOSUt2UsVFIKtVSnFQmtUXdQeWHFNGloJYSOix08nTwtf1V4q/cuD
         bSmqvZQSqINQ6VNbP+P5HxXxdgMzwGaZbvtp235ZppluJu+rTdJ643MnFdj7f2fpheBA
         ppeAk9OdZV3SzTx+9vmdjxhxdd/NtY0uf1pzZcBjLMyFJWa4jjY1/0gyN01SMkKKWVF2
         vFE+uQ95clLuyxLThRTDPN30QoxCEj84d+4CLMqEDj7aAmFDa0FSd7An8JGLORIPIJJO
         uAcs7rl1nYG5ayxKev2RA/SYnmC5RARP3nhQPLTrmmyT7xsvgcL3QjmzJS+tfR2OqQmW
         KhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rn7F9pCY08KLVBMiHrxRjQBYdDwuoIM3SNqvllQs3A=;
        b=gelcic190wgoK6eujibOnsccYr/VfbCSFQkxy5qg1FJX/gFQAr6z6X+obgcDDnyFZu
         +mk0PDTzt7koubfbtjR9/vvXMg9pArZn58M0pD9zh0mU1yPzpBu/Quj7fkj+/wcgDUVq
         L60bw3gfhclsJW3fRHTWVD4gBGWCuvCF+3133R+mnU5h2dGHJ6/tVu1Ec3XM/kq/Wh4s
         S8GA8jptt9FLJWgX4pcQwekzdzGb/y/ny/dDx2FDBeeAr8YCyF50IlGHbQB+XPtfOIm8
         Ltzw4WMydXRUm67ZIZQ1xYyGeWVkLtkoYFWhTXHVE4dHCHC7BCGlTBYQTGsak3mdObtB
         xJmQ==
X-Gm-Message-State: AJcUukesPTnMhb56Tk59znGYtJdILURxjG4EPhlNOCFUV71Sf00y+Fcs
        3xlsmArwxTtSZu6/TZ7cQwAl6w==
X-Google-Smtp-Source: ALg8bN5S0JmSebeUDEKeCIkJWBUwlRk8H2i1oriIrL2Ey19QgKxfo2Lwm87+Vgq23EBYLaORl83Cxw==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr29674415wmd.38.1548941984305;
        Thu, 31 Jan 2019 05:39:44 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/35] ARM: davinci: remove davinci_intc_type
Date:   Thu, 31 Jan 2019 14:38:56 +0100
Message-Id: <20190131133928.17985-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
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
index b9aec3c48a6a..fef39d5988d9 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -131,7 +131,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
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
index 3bbbef78d9ac..3658235c8ee7 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -95,7 +95,6 @@ void __init davinci_irq_init(void)
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
 
-	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
 	if (WARN_ON(!davinci_intc_base))
 		return;
-- 
2.20.1

