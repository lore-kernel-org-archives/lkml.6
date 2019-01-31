Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5253EC282DB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C762085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eostOMYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfAaNkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbfAaNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so3321052wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XB8DAnrnVgkm1ZLSZXHvJRftRpL7JEyZD/bNFtysJOk=;
        b=eostOMYyaHRaga+KnRffQARNh5CgS6967wxV0VVsFcyCF1lfpNbJ5ilYa7QGZUsRzD
         VIekdUk99tn9omPvZgnU5DnLnv7U7VjYBDw1skPe7ICcaDBg+6Hql2RFnYJRtxTFDn2k
         LgL0cEy8+tqhcAvo2fuWmbgDNlPzpkH3NKv+lh92smT+eNn6ZQdv5PvKaP3isSxqt1IZ
         rHzeIkx0dPIYqbm0ukdRdFO1kcPJ1rQe9tiAlLdFX2a/WTsc11ONOKBtgWCBaOJP9n5B
         cODZJszqH5MQnsCyMECG2eAKBdZywV1drX9xJfl3c05+Wd7HPiIq1ZMCBqe/2rgtDzXv
         pozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XB8DAnrnVgkm1ZLSZXHvJRftRpL7JEyZD/bNFtysJOk=;
        b=jAv2+oX9gzyYwm2b2IvPHxJ3yWhCqZwpnjFqyz7y+O92G7FTkEPb1CRNBo2/Cn8ZSe
         aE8qoObeyx/ySXZ8rSaJMBxVmY2jgd0k5+8Ocv7Lb1YXSsa5shSnLvdqVa6hAac7NGt4
         QR8C4XYsInnl9cwgyuACMsnpWIYMsn1GGOfD2UWTePecP1sGZrU4z77kFcYbHbWRt3VF
         w6r9EK1IVo18KYTTtgwNaf1ljT7MqnXL7RVcl6ANRoBB1HjGlDK/kLeP73hLxDp8UW4V
         aQhIEwgXG4xEh+Pdq8Eezlx8f3xuC5z85ZYpQCViG00yxaW2UVgFda2Yf1btF5C0tKW1
         btUA==
X-Gm-Message-State: AJcUukcefCdlG2mAUVBrQvkGbr+jWcbHfHOl8e10ZEXN46KyU5FVJ0SA
        caY6YCM+SNdd19ic6CSS4wcVpQ==
X-Google-Smtp-Source: ALg8bN6GZcbUijMNLIaisJR8PKK8dAjuebBkv/27WuNbbPa0HijHFl0ZhRJ8Co84cYI1dreXIohiDA==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr35313826wrn.276.1548941998507;
        Thu, 31 Jan 2019 05:39:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 14/35] ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
Date:   Thu, 31 Jan 2019 14:39:07 +0100
Message-Id: <20190131133928.17985-15-brgl@bgdev.pl>
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
index cf574956ce1d..0dcfcbec522a 100644
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
@@ -738,6 +739,16 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm355_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm355_aintc_prios,
+};
+
 void __init dm355_init_irqs(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e63153a6ae41..1878c97e5df5 100644
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
@@ -995,6 +996,16 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm365_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm365_aintc_prios,
+};
+
 void __init dm365_init_irqs(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0904baa1d008..5c48a5e4090b 100644
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
@@ -672,6 +673,16 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm644x_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm644x_aintc_prios,
+};
+
 void __init dm644x_init_irqs(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 27831d6fc5a5..e06ea3b61011 100644
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
@@ -633,6 +634,16 @@ void __init dm646x_register_clocks(void)
 	platform_device_register(&dm646x_pll2_device);
 }
 
+static const struct davinci_aintc_config dm646x_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm646x_aintc_prios,
+};
+
 void __init dm646x_init_irqs(void)
 {
 	davinci_aintc_init();
-- 
2.20.1

