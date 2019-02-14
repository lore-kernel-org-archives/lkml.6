Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD20AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72223222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WCqt289v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439628AbfBNOxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439607AbfBNOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so6766366wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
        b=WCqt289vntMaYK/SbvFLq1fKsEQMpUUjpUy3BzE+v/juGwHDOrHwETRGEolSTOj4Qo
         EY1OqPJADv6zW6e0fvCkR5ry03j9INNNgTPc5aeorQ4LYfHVim7j5QajT7Fj5zT2WYZJ
         /tK9Fi05PUv+mT8evsUKhx3575682wbp2i4RdTHrTow8WB3chZMSMfhxEugoCHWisEAD
         f3HNdH31eeWuJAfBYYrakbGN5pQbsoDaIPoK1pBjhamCmE3LoDi5GebkxO6FJ3SYfikn
         I63ohH575g7q9E8TYnktffhevVAw8+5Dd1YoFSzF2R6wSrStQc7JN8j4LMwltP2YZaBs
         bL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
        b=DCGUA+PGPHeBpgOZkSE2QH0MIAo6pLOkrGl29KooQKm4uQesA/VB9MLUQiqMCUOm2J
         4q+9zWk0WU64enMZfeH1u7HbGS2nmZ0JzgbETRVn0u/69zoR2j8L5a1ukr73yLMkH5ov
         XpO3IN81ZPgNcJP5GZkasAq7O0j1TN42KyhT9ck48dlqCQhBfgUXMTbF2WakV5vVUxZH
         Vkh6G8GCH8SSGIdYCKwO4MsnCvbA1LQsaxbSvhXzEB7H2+s0F3nTskdIlQglNknVoQlK
         KACj9yN9ps3I/ZQ0UjD1MylUV4XBXhwkwWIXvanK27uAgwDfourDmekkFipu4e7CiRlW
         NDfA==
X-Gm-Message-State: AHQUAuYAsfKAGLknYxb0nj/umB/q0INZtAtwWjWPUfYYRrsRtkZpddQM
        /p9KjVRZsooTt8VEsWyjLOLkhoklmRU=
X-Google-Smtp-Source: AHgI3IZDE4s1RGz96BlZENl2MUCfAmBa572BTWb0wbYHqGTNNM/Pg0w17Le0UwFN+NxEL8Ds6hqaOg==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr3266409wrn.45.1550155989375;
        Thu, 14 Feb 2019 06:53:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 22/37] irqchip: davinci-aintc: move the driver to drivers/irqchip
Date:   Thu, 14 Feb 2019 15:52:16 +0100
Message-Id: <20190214145231.8750-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
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

