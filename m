Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E1C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8695B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e5Au1lXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbfAaNkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55459 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbfAaNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so2511200wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9qT/L4DhuaGAJ7qBZnKhfl1j2KQKPFuYoKVi0aeXEM=;
        b=e5Au1lXKcMGVzf2HCIvrba3ow8dKukNk0vS7q8EPeRZlOXYibXPRR8GyJFQ70Gu6lM
         lu/NLS2Fu2isd5eDGxxIyLAHxqO/06hjPzC78tZf8A4OhalyXNOPaLnWfuELdvZ8pTn+
         /R6HMy75h18WyYUVqV7C6u1ZoXJNZqbEf/NFFb4io7pQn+yYSkHnGUi++ehdoD70/omb
         32R2h+3EMsC+ShUL5/8rq6jGjgIYmuxmR4DXUP3k31KNL87D9eLOZe95K06TIHkfNcFT
         nFlg6l42ORyroswzDycKVr++DEE1bX12Z2TWrjN8A1+DJFT7wvxeDP+jdjlANCnhCQmT
         uaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9qT/L4DhuaGAJ7qBZnKhfl1j2KQKPFuYoKVi0aeXEM=;
        b=jMU46Xfa09Z1rPez6i6cSTJQhqU/ox6Gs4UK9VAXe1fNdNlWDGeevRnWmco5WABVA1
         +WklmFP+p3FyaI5cBEPzMFt5DSQw9l5pqXM/AGT9+cqhFadzxN856zYzeYzO5NnQdr6T
         aGVjqSc3W65U+XZH/Mgvcvenn3wJEeZL8GrdqbIAk19so5OEDQwJwiurTemeBYGc8Q1q
         fW6x58PNCukvodWSwXSn4XwHjNCZsrYHGX0HtYBM1e/OCK2C2om82eT3pimOTNKzTGRz
         58abs+kjiiR5fLJM6cwcokF0HM7h+acaGQfpNfkU2E3A26zv5lsUWm+DBk5e8m1//DaL
         PaTA==
X-Gm-Message-State: AJcUukf2pgo+o5o1tql1+QLSasMqJhrycALdPYCk8hR1x+fO9jmzBy4o
        jBd6BxNI3s5xfEe7wZHy0Ef4ow==
X-Google-Smtp-Source: ALg8bN5ugTtKbDvNIkD3NnnntM+dInMSRDxKmxkYXU3KGu0I7hpyCIDQ+W242HUk2m4I14x0y1G/qg==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr27851527wmj.91.1548942017998;
        Thu, 31 Jan 2019 05:40:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 31/35] irqchip: davinci-cp-intc: move the driver to drivers/irqchip
Date:   Thu, 31 Jan 2019 14:39:24 +0100
Message-Id: <20190131133928.17985-32-brgl@bgdev.pl>
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

The cp-intc driver has now been cleaned up. Move it to drivers/irqchip
where it belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

