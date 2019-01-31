Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA7C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66102085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="isRcx9mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbfAaNkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37692 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbfAaNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so3341817wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVtjfjJdrfrUAxYWIg2RkYAV3AoagHAUWgDBm80EJqQ=;
        b=isRcx9mW+RI31av6Dcbwmiw+5pBDfRY828eYpRmdcfhI5YbEcusJ7sfAhK8Wy0De1O
         xYgIWwi7+iwOI0Zs5pwhFCys0QSqIHrkl72ohszExQQ3tObbCE76zlremfTzVsl0BB77
         8npAmi5DrDEQuFeqJpuiVU1kgsPb1+aUoMbTJ90y+4m+jVRcSyXxUQGKv8HUp9bJmKfg
         AtelJll4scRpriPZ2Ms14WmPs3fGSojNsXbM7OFL0Hi3uVkfiNJnm5Ut6jPhDzkr41gV
         /8AtFLRaPh8DJoyLSP+HvIxkvSYPF3epPPMlYF9yHWV7Y/0MRQoHRPD0KnLQSp6vwE/X
         oxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVtjfjJdrfrUAxYWIg2RkYAV3AoagHAUWgDBm80EJqQ=;
        b=GVVq9Z1dSRECaqNQ+IGh50r9ioqPnbxGNXWfSfFZsTapFN7KufDzwBhcdIeCh8JhNZ
         ENqdJWgsroYOYA7DEz++gJ0rQEOrXxgBYXa3MKWFQHuy82eb6V1pS148HdF/Rwkf4kiX
         Fh9FgHqqBvcx/AfXrr3lAYI5N+tx54k6DKyWdRAqqhcaRHT5YjT/KNXYaauDJVTZbedf
         RtqBEhIQrTM07YHx+hUQNW3AFiYbu2xqv57CkE2VPrUapVha2g9UUzTVGsYz/LjfGEJ1
         pr/cAtEJ0RjIvAmKcSZIAqgsatvX8c542dqP1S7M5h0Tu7cpPKvZKHXBxRT3cOwlTCB6
         jpMQ==
X-Gm-Message-State: AJcUukdGYzROrOcWuPnQ7W2liS1flbeFHklq8VC4WVK3AWukGQSGhql7
        KpCXreOFDeioYtksjIQEHDarAw==
X-Google-Smtp-Source: ALg8bN4WeQvFMwbH2f3ATmmTso+nUUilBM8hLSwpZJ39/4Z3kMtfSSrLXcZQFheaQ8iXZFn3XoCTuw==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr35273924wrw.123.1548942000881;
        Thu, 31 Jan 2019 05:40:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 16/35] ARM: davinci: aintc: move timer-specific irq_set_handler() out of irq.c
Date:   Thu, 31 Jan 2019 14:39:09 +0100
Message-Id: <20190131133928.17985-17-brgl@bgdev.pl>
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

I've been unable to figure out exactly why, but it seems that the
IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
level irq, not edge like all others.

This timer is used by the dsp on dm64* boards only.

Let's move the handler setup out of the aintc driver where it's lived
since the beginning and into the dm64* SoC-specific files where it
belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 4 ++++
 arch/arm/mach-davinci/dm646x.c | 4 ++++
 arch/arm/mach-davinci/irq.c    | 1 -
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 24ad7a09aa15..beb97101c881 100644
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
@@ -616,6 +617,9 @@ void __init dm644x_init_time(void)
 	void __iomem *pll1, *psc;
 	struct clk *clk;
 
+	/* Needed by the dsp. */
+	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
 	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index ab02cc93813a..70505c92d5fb 100644
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
@@ -599,6 +600,9 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	void __iomem *pll1, *psc;
 	struct clk *clk;
 
+	/* Needed by the dsp. */
+	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
 
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index d67f443a471d..2e114ad83adc 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -142,6 +142,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
 				       irq_base + irq_off, 32);
 
-	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1

