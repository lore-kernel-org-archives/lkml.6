Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C766C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDF5218D4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ja9na4hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfBHRfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfBHRfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4365795wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
        b=ja9na4hrLEqf9BBxb/Q9vUHn/2UfLMGIKrO7JzHcjidT09Pfh9ijqDaONj/GVXC+1a
         hTtNneIjRAS7ny//G5SuO0IJtqWvF/mf3OJJS4xxPsei5wvxrFoG5FNyofibvANSDm9h
         W5aHT1q3JPfGn1/QJTDYVnZVafGvyFO+6q3tKrK2vrRVE1GW9tegckzN7HXSKmAJlAa8
         LcmsQghFxpmxIXYUvUa7+dIiqwA/dZeJf16xK8rVcxMFn2x1FSvzz8/Z1wrEYfQODcix
         7+6bNgqZxxGvhi0RgkYjoHSJ8PyJUCtkBliFMtMnooYPA32N+Q+qNpJrKgfvVU2J1/ma
         NZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
        b=F+Bbh1G2hpN7VVfZlf8p8Pvu5M6QqNotX3FhFO/ZTWBQ9xuU7/m7g70Ex5Zwovkt/5
         3Mqgz7xbej4daQDV8Lk4rnuTl01DRpSB3ixIxcrlh0IKYeSz+CCTQVN8t09m/O+34nLB
         Gg47JiOeqeeRtzT6KXEatfkdKX/c9Jusxu1pHWrUvVaDm9lkfuMEs9QxxzdW6DPfyZCe
         lYYo8exapY/X0P5Z1KU+1vmR/SkvVcz0T2JJmV2lMwTNAmKlLlTRiZdlMtExTabWiuF6
         lQ/5aaO17R/ngEZsEEPsdjvZ/TX42slz2m3y2yEOl0/YE9y9GvsnfowaHSTPJIXcWZE7
         /1lA==
X-Gm-Message-State: AHQUAuZYWoE/LxHk9hMr4vPWXiiOOeV/BEHd8C2/4Etx7ZzRumqfkBHH
        v5hODPhxuV8zjN93PQQdt5B6it5YTms=
X-Google-Smtp-Source: AHgI3Ib3yncqWWgyKhWwLZiEz6ncoiEG+asIv/V1QMhrMiQpKuHcepgxBmftoO0YU130KesJVfaLVw==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr12419558wmf.8.1549647329227;
        Fri, 08 Feb 2019 09:35:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:28 -0800 (PST)
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
Subject: [PATCH v2 19/33] irqchip: davinci-aintc: move the driver to drivers/irqchip
Date:   Fri,  8 Feb 2019 18:34:44 +0100
Message-Id: <20190208173458.4801-20-brgl@bgdev.pl>
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

The aintc driver has now been cleaned up. Move it to drivers/irqchip
where it belongs. There's no device-tree support for any dm* board so
there's no IRQCHIP_OF_DECLARE() - there's only the exported init
function called from machine code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/Kconfig                         | 11 ++++-------
 arch/arm/mach-davinci/Makefile                        |  1 -
 drivers/irqchip/Kconfig                               |  5 +++++
 drivers/irqchip/Makefile                              |  1 +
 .../irq.c => drivers/irqchip/irq-davinci-aintc.c      |  0
 5 files changed, 10 insertions(+), 8 deletions(-)
 rename arch/arm/mach-davinci/irq.c => drivers/irqchip/irq-davinci-aintc.c (100%)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index da8a039d65f9..71a4d875dd39 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if ARCH_DAVINCI
 
-config AINTC
-	bool
-
 config CP_INTC
 	bool
 	select IRQ_DOMAIN
@@ -17,17 +14,17 @@ comment "DaVinci Core Type"
 
 config ARCH_DAVINCI_DM644x
 	bool "DaVinci 644x based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DM355
 	bool "DaVinci 355 based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DM646x
 	bool "DaVinci 646x based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DA830
@@ -49,7 +46,7 @@ config ARCH_DAVINCI_DA8XX
 
 config ARCH_DAVINCI_DM365
 	bool "DaVinci 365 based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 comment "DaVinci Board Type"
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 93d271b4d84b..983865a99616 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
 
-obj-$(CONFIG_AINTC)			+= irq.o
 obj-$(CONFIG_CP_INTC)			+= cp_intc.o
 
 # Board specific
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e60779078..ea0eb82bf1d2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -129,6 +129,11 @@ config BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config DAVINCI_AINTC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c93713d24b86..623e0ec5f9d0 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
diff --git a/arch/arm/mach-davinci/irq.c b/drivers/irqchip/irq-davinci-aintc.c
similarity index 100%
rename from arch/arm/mach-davinci/irq.c
rename to drivers/irqchip/irq-davinci-aintc.c
-- 
2.20.1

