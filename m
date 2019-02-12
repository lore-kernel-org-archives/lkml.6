Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF1820449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="n6eSnZEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfBLKjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44906 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfBLKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so2056787wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
        b=n6eSnZENp5CA4dJTiQDUBwm3VA2l29r1aESaNnhRr7Zm9C6qxlg223GgRLvh6zWydb
         a4TWc1UZwaq1ky2AzLJBZUvCbw353k+/hkQc+Dcs1ZJm8048qV66q2vdWvWrwrKjCasi
         8ZJ4p6Nvl4MK+3J1K47N5pgaSz8TbzuB1mI0sweggpwZR2RlZCfFDd7/MWu6OtleK0uP
         pXianIdYG6+nfL9vP2kW6G+wEU4o0yuUU/3b33ckIKVqRYUWCxwEi4JQXkmfk9ZjiYTx
         aPvGW95WA7cgsQzwRXlWYeOZ5u+w7z4d5mmaISaz5sklUiLY+wQk43mbPU1bYM+WAp41
         gDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
        b=kwcIOLZqPHbLnh+Eh95ws5v5jWRMsb9tlsjTEV2xxMV6UZq00neb+nw+tFebed9Uup
         syMROGo2IDYwa6mcojIJCrnb+PKbums7c4xN+x9YGg1iqKKDdW9Fy23RctyBrjGm8Qjt
         LxftgAw/z8EkrPLXvbqgKzo/7NMJTk9y2sRmaL3tU1OKBceynS5jxZh8PYAHU2CERwgF
         YiRha1IwFMGRL/KMCtfjI9O+FrgliMeXWBOB+Ji2uJ+AfuFDGO35AhiwCqZ5pk5oXsqG
         RHXEOE6fupvSxt8XpOHICnbC0CxYw/KYKVRH1Cg/u6i1+HpKkEHZWj5WA3S8IrEFxL09
         9dhA==
X-Gm-Message-State: AHQUAuZ8U+7WvrkZfqI7cV/to+UH5OOzo2cEQgkrQ8LuZBXh572Cyyhh
        XubTS3Hf+l2HVxfZIIaR3GW8Jg==
X-Google-Smtp-Source: AHgI3IYpO2OxLB58OzUo9B1D32+LXXFPNPp08t5/EChNC+BQ7zyhKHPsaGTIRoRkY9Lyr7d02fq6Fw==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr2394414wrg.151.1549967955822;
        Tue, 12 Feb 2019 02:39:15 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 16/37] ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
Date:   Tue, 12 Feb 2019 11:38:14 +0100
Message-Id: <20190212103835.7768-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the new-style config structures for dm* SoCs. They will be used
once we make the aintc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c  | 11 +++++++++++
 arch/arm/mach-davinci/dm365.c  | 11 +++++++++++
 arch/arm/mach-davinci/dm644x.c | 11 +++++++++++
 arch/arm/mach-davinci/dm646x.c | 11 +++++++++++
 4 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index e2b680e9944b..ff79c1a17fae 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/spi-davinci.h>
@@ -792,6 +793,16 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm355_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm355_default_priorities,
+};
+
 void __init dm355_init_irq(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 76507dcbcb3a..44dc3ca94dd3 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/keyscan-davinci.h>
@@ -1051,6 +1052,16 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm365_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm365_default_priorities,
+};
+
 void __init dm365_init_irq(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 27c73bc54069..0b0ecac36486 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -14,6 +14,7 @@
 #include <linux/clkdev.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
@@ -728,6 +729,16 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm644x_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm644x_default_priorities,
+};
+
 void __init dm644x_init_irq(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 98fc5e3815b9..4e871d00e4e9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
@@ -689,6 +690,16 @@ void __init dm646x_register_clocks(void)
 	platform_device_register(&dm646x_pll2_device);
 }
 
+static const struct davinci_aintc_config dm646x_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm646x_default_priorities,
+};
+
 void __init dm646x_init_irq(void)
 {
 	davinci_aintc_init();
-- 
2.20.1

