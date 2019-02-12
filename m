Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18276C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBDC20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="noXiFlsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfBLKje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37972 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfBLKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so2093912wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
        b=noXiFlsk0XM0GY5v/0rDPEojjLKffV7SGApQvAinYkj3OpmJ7sOBaQPClXyLGgYtI5
         qHq8lZfUozJXp1jOqVPr5JTX0c6p0oQ3YyERVoJnSEiS0qUXbsyZFfk9FIqbqHMLRS0q
         Ih3Z8bM99U+8hzPpvn4k6SuTmkDEpuzBlmPvTf1gmyPfRTMvVhBqmD48MLQuHfCTcagK
         CNB0QO2fJQSM3uHp5Wvoy6yYAUy9Pa/YuAwNDmHwf6RblNWHnnVTJ8MMcC+vOqQwi9yl
         Hce1auYFASgCJwDsm7laNgafeuaDThHP99MK8xrU+MrSSRSN8XNF8Ma/X+7y9hzyzieg
         xxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
        b=JrHXj3X/V/9DVybF6RjeFX56MxnDlJCWS10D7YRqyslJSEvl+thzQL7mC+iYvAZPTO
         +snhnp5iqp3g1xTxJoExVYyjmIDFcwWqZuECPbbne5YBHlvvqnLPFYIUxoQg/2Fqbz7w
         m0FRRGCnsGBMs9+Un+jbvol3YOzMiytL2sEmYIVWS+yPc61gmoDwmx+6MhBQwNjM7HnR
         TbVMGsBFInM+7r+6uSnSCCfMhnPdl26TZH0Z0ll1rASLL6E0akIUt7iO9DkR03Ryxghj
         q9tudrbuK33bk3Dx1gUB9+LeQlXts/JlmwtwdZDI3bmAlgfjn8BEdCMKeILdhF3n/rv+
         pHaA==
X-Gm-Message-State: AHQUAuZer3L5ZkMULWjeBChbZENw/GndB23MjfweYDKPBoAVB7Rjc0IH
        SpNbkIt+y6vPpi/n3lrZncAinA==
X-Google-Smtp-Source: AHgI3IYPI7+zQsrk1SPIERBtzaaT7PFiVqZZUtGXZ8wyhlL8nCMLOfT++q6zRqxuTYoR4Fpz4X/geA==
X-Received: by 2002:adf:d845:: with SMTP id k5mr2336065wrl.145.1549967967094;
        Tue, 12 Feb 2019 02:39:27 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 26/37] ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
Date:   Tue, 12 Feb 2019 11:38:24 +0100
Message-Id: <20190212103835.7768-27-brgl@bgdev.pl>
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

Add the new-style config structures for da8xx SoCs. They will be used
once we make the cp-intc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 10 ++++++++++
 arch/arm/mach-davinci/da850.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 5cfd30c57429..38af72be1a85 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
@@ -821,6 +822,15 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+static const struct davinci_cp_intc_config da830_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA830_N_CP_INTC_IRQ,
+};
+
 void __init da830_init_irq(void)
 {
 	cp_intc_init();
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6df6994c0f26..9a3ce68c0de4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/clk-davinci-pll.h>
@@ -759,6 +760,15 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+static const struct davinci_cp_intc_config da850_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA850_N_CP_INTC_IRQ,
+};
+
 void __init da850_init_irq(void)
 {
 	cp_intc_init();
-- 
2.20.1

