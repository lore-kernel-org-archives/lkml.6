Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D722C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623AE2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Xkq3W8Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfBHRhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35521 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfBHRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so4333780wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
        b=Xkq3W8Q9pXfyA6CBh6NgFCOiju+Lg2KvS8yVHVtcNTSkQWgtVMVPM0hG8FOsREf6Oc
         B6gJBQcnXUilX1HgmPvxW9eXlYcNWWfZBNsEHYYyV5tHoLroxmiMNtbfC1nlEohxZEtV
         Z13uDA0toC5sJqMHEjgsH5sH2bgRnBtMr5L0naxQMuo+GrHzuX+8PlCCG5W1gXUUOynh
         tIztQksQ639lDOyG9abNtUpmqOX/+7KWlzXtdkTJLeGOoqB8kJOQrJKHv+PmMM9X0Eo3
         Dxa/NbFQ2sFi63trm4OeM8lsRcA8rdnayMt4oPsBLgsRDdIuyZ/npr5C1D4ufbqgsRes
         DgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
        b=lKM2p2/ZKaCMgVcYSOahiMVDiYtpQiWk7ODjqK2gih5nWjSNJC43h7avRI3hbDfSyN
         iqUaHsTYf7VJVK78egYN207c+seRMlo8tBkEClmPa3b7U8HIWIQkEL/6TM2RwwDyb0/d
         3n/FWsnCcjQ5GckB75O/sFpJ38q+y+Rhm+JD6HKycikrjJwVn+exHDRwcWHvC+1Yfx0t
         q3Lv1E5r86cMcxU2PdpzdKF9D5YqMZHUZU+WudkCiGfcVT9afkpKmjfg2XOdcpCE754x
         OHUT6sZ0aSdr9PkdaQYx6zuFIX+13R05aaJ2tF1fgI0Am8t6wv9YwVTcsRYFxAPuFDZO
         TY2g==
X-Gm-Message-State: AHQUAuaAy+WwRoO8OWm/vx+SrTMT0GPHc+INB9J8XGdPKc9jaSJMQ5Ne
        63fdSCzAcifZX1Nsy3sW1kzaJgeoZs4=
X-Google-Smtp-Source: AHgI3IZgaaiQ+SWAtXMz9puYxDoz8Q1Z/AKMBHHROs2B58dlWyOaaes3Py9a6JTB/vISHA6ATpcpfw==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr13086606wmo.150.1549647324441;
        Fri, 08 Feb 2019 09:35:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:23 -0800 (PST)
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
Subject: [PATCH v2 15/33] ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
Date:   Fri,  8 Feb 2019 18:34:40 +0100
Message-Id: <20190208173458.4801-16-brgl@bgdev.pl>
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

