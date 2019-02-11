Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FBF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ChzDAc/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfBKM1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35678 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfBKM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so134098wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
        b=ChzDAc/nPzQ1itzXH8bi+m2nz+pQr+ANDOkVbdJzNc7verHaAZiMnVY1ACJSn9B+EB
         0eG1sXID3RmweoMqRSaA6WetZJGgdQCspz5gUmaA0NrrQZgS8KhV8r5fE2LkjyzL/E1A
         u1JQqwYVKRdctP1tUETQuGaaHbDKFKR06Wji/NFUhpvKB5hBClhtQx13udz2nfL5QN6F
         i/a8Ua+1BDAJyHV0I9EKJsNovC9NC23iQw1/rLE/bTgRDRcVqLR58YOm/MeTyy9Co+Ia
         RCx+LKzzgRVtVyhRFwMwqXXediW4BCRsP3jeO9TKdkbzIhXZKdohjY6oc2+gQvrZb8DL
         jg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
        b=pD1Ywz+DqKJHyIK3W1Lyk+awPQYi8HfKtRl64OJezwt17Oh2fXr3QYs6PDHsR/C3E+
         IWFysnzbpGz4hnWJFYP+0jwr6LtPZVrUBSEPItO2eYtkFOWH/NyvJV0yPueVMFVBafLa
         t0QYjotPBHNdHtaR8bTDCoZ/lQreYJvlWz0Krn4/FxgbCHZKwTJE8M48k+/hT0J78mrd
         BY7Rq7lENgShpnwqhkH8gF5lIKEs6N+RxeLOjNVdTid8pNtsXRO90afme5wXEGEmt5Ms
         2XG9XSAw37j7M/LHkheauL1LVmw7V6ZbEfd5nMOnUNdBgIOi3Zq5s0hw1A+de/luIBqV
         uPZA==
X-Gm-Message-State: AHQUAua8YVsC8o1twTfgQf0XUimT6GFBSbkKToMQD2oTrJiJoi6j8aQY
        NZS4u/36s6RJIR91USKA899eHA==
X-Google-Smtp-Source: AHgI3IYhvsmFc5p/2tuDLQwk9Olw42LLTml9psi0oQ82E7mg48NLA9SQ+agB+U+msqGAabTiH8HDkA==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr28496782wrw.304.1549888001474;
        Mon, 11 Feb 2019 04:26:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 23/33] ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
Date:   Mon, 11 Feb 2019 13:25:56 +0100
Message-Id: <20190211122606.8662-24-brgl@bgdev.pl>
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

