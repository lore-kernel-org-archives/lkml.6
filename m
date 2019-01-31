Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2856C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8452085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KZZFIKFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfAaNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37668 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbfAaNkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so2587604wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiBWtlRU9Lv1TNlAe7u938RwMGut2xvtFe1CB/XYr9Q=;
        b=KZZFIKFEnSpOLEmJzYc0d52J4r/ZzyuTbfMa1Kcz2exMYS8V9pyI9UEBEZfvBFJYzJ
         4m9+9afl487V6Re4yxadzf1qPs8x6gR/5o+CznxMRj97t7yDvitgjQWEU8SBFSaSGrhS
         kGVGDfZX/fVl1iJ6VJtMVV2s9vlwOWvX+Ufa6Ks8DZXCzIOevECzL5VyshoAyZ4QU1of
         D2Q4/Dt/so9Db6r3jd92EuIMuKHGVokkW2/hUl8KSHyh5z/TkeBZEIHZtIohgG/afSc2
         Yx75FP8jQYj2R6t1PzIkzykCwHpcAX8+Ak7BJxzYtVMX8VMiw6dNaeZ0OQQXkyk25hU4
         d9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiBWtlRU9Lv1TNlAe7u938RwMGut2xvtFe1CB/XYr9Q=;
        b=orlufCui6lKnLefOuggZnCwP7CMXzV0ur7AZxkPhqNVDg4uqOAZh4iuiKj5dkXe5ff
         QH+6KJoO4Easck9mEeZNSE24lHGGcYs0xmiytJ9cFaWP9o0jm9/nuWVJGUZgP/NOHI5J
         GJZpWdRf+smwEzxThgn8Ka3As3wR8dEyEVJLrkYDB3aKgnRxJIzXQn9ZvWxAAnqqgIEn
         Op/1e8pyQWz0Qxsp2cyoLb9vDbQaSlBjz6zwrYy1W8Fdiw7+jKtnDzASeQLAUAwf+E2h
         DZ0EK3qXkSijtFNVYIw4BzvrdaIi/znjihat2lyJ6krHEu/qgjjyfiYNKRXePRK8mSoy
         yJbw==
X-Gm-Message-State: AHQUAuaAMFy6N1++Xym9MZZI7n5FZPyPzsSbvCYyJJ8TddrpTgbs/4Ci
        4uWTKPEq7hgmRY3uyjr02KLLL7azu/M=
X-Google-Smtp-Source: AHgI3IaeU4wPRnVdskTvnoa4D5Bwf2OoIri7AYedrJchwcgCmtIN2YFR8d/+LqFdp8FRIUQRkSQMKA==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr3830698wmf.46.1548942007705;
        Thu, 31 Jan 2019 05:40:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 22/35] ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
Date:   Thu, 31 Jan 2019 14:39:15 +0100
Message-Id: <20190131133928.17985-23-brgl@bgdev.pl>
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
once we make the cp-intc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 10 ++++++++++
 arch/arm/mach-davinci/da850.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 8b9220badef5..6d3da4364f7a 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
@@ -742,6 +743,15 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+static const struct davinci_cp_intc_config da830_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA830_N_CP_INTC_IRQ,
+};
+
 void __init da830_init_irqs(void)
 {
 	cp_intc_init();
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9f48e1ac61fb..5e7f2c962abf 100644
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
@@ -671,6 +672,15 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+static const struct davinci_cp_intc_config da850_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA850_N_CP_INTC_IRQ,
+};
+
 void __init da850_init_irqs(void)
 {
 	cp_intc_init();
-- 
2.20.1

