Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C95C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF7B2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="o6PhnZun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfBHRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56032 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbfBHRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so4323412wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2oKCm2aHyIkLmsWfLt1xuMZ3si46gMPXE7rlXDV4Gg=;
        b=o6PhnZungxBl1FHWb+8WwNsDkJDXfkICZjZtgPmXQm/Zn9kgKjsopyBPsSJcPQXCBq
         6l1skgJzlRFtC9/6b/P47gLlxrnsH/csAYVW6DIZvRqmmAtlL5RhgXiKMdSG0HvxDQ3J
         W9FBPhHEtmkSEPrFX0T/fy0DRtIc5MBG1iRNq7EUA0OkAiGkJcYDo96n2hHeo6gWCXed
         YU87zAssNGzamz2NhKgPGaULwsfTGJGvbBZXP5Oe47j6sqeKdWBt/19y/y5rAWVddIlO
         n1d95uPyfKLIEoN+U45If9HSqUPsNpjJYwc272tReyug5Itohv2gFJ6n/hmC/O4a+Mtl
         xNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2oKCm2aHyIkLmsWfLt1xuMZ3si46gMPXE7rlXDV4Gg=;
        b=QjWhiSfP//A140Ql4Bj3Wj36fDQi3ZiIGn/asmZKmzoL+h3mPTyQqwgPojKrZolbiJ
         NqwM3j1Ej+Vv9jk0RAHHcPD9eEtPN0DSp3jscMNyXvGtTOoDP6NCp3ksyd3wATdfCTsN
         MieuLkqMnD7EFbwNR61UuL9k/afzqxBin8AAi79+useKFLo3bfSeny9+n4VcqEhZhvvb
         oO4hY3T76VVGLBjO9SVwkRymqe1e5BbOQcYgefXMV/7tyXxe+2I2P/pLQviIeuvq8S6e
         88YMNXhFiHsQD57+mqY6Mp2OzqkUdwcmuHYz41irivjfZrZNqUiVNuKTnCo1isfI/Ns9
         rdfQ==
X-Gm-Message-State: AHQUAuZvegGAcHVuaAGesepTv7WkhoJMtd2iy5hASjiSSnFYyLwbkoWR
        ExyNOEMMUfyStoWOUk0yUDD4og==
X-Google-Smtp-Source: AHgI3IatjZg4b0SSZmF0nwmCk5wLo+FpN6T0UdaHP7JlJFCzz077RBt1+NSq82ChDezEKwDZuI785A==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2802502wmb.148.1549647344390;
        Fri, 08 Feb 2019 09:35:44 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:43 -0800 (PST)
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
Subject: [PATCH v2 32/33] irqchip: davinci-cp-intc: move the driver to drivers/irqchip
Date:   Fri,  8 Feb 2019 18:34:57 +0100
Message-Id: <20190208173458.4801-33-brgl@bgdev.pl>
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

The cp-intc driver has now been cleaned up. Move it to drivers/irqchip
where it belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/Kconfig                             | 8 ++------
 arch/arm/mach-davinci/Makefile                            | 2 --
 drivers/irqchip/Kconfig                                   | 5 +++++
 drivers/irqchip/Makefile                                  | 1 +
 .../cp_intc.c => drivers/irqchip/irq-davinci-cp-intc.c    | 0
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/arm/mach-davinci/cp_intc.c => drivers/irqchip/irq-davinci-cp-intc.c (100%)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 71a4d875dd39..5a59cebc7d0a 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if ARCH_DAVINCI
 
-config CP_INTC
-	bool
-	select IRQ_DOMAIN
-
 config ARCH_DAVINCI_DMx
 	bool
 
@@ -33,13 +29,13 @@ config ARCH_DAVINCI_DA830
 	select ARCH_DAVINCI_DA8XX
 	# needed on silicon revs 1.0, 1.1:
 	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
-	select CP_INTC
+	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
 	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
-	select CP_INTC
+	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA8XX
 	bool
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 983865a99616..f76a8482784f 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -18,8 +18,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
 
-obj-$(CONFIG_CP_INTC)			+= cp_intc.o
-
 # Board specific
 obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
 obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ea0eb82bf1d2..48fc5024c073 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -134,6 +134,11 @@ config DAVINCI_AINTC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config DAVINCI_CP_INTC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 623e0ec5f9d0..e6cd0c98eff2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
+obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
diff --git a/arch/arm/mach-davinci/cp_intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
similarity index 100%
rename from arch/arm/mach-davinci/cp_intc.c
rename to drivers/irqchip/irq-davinci-cp-intc.c
-- 
2.20.1

