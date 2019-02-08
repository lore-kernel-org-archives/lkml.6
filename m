Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10994C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B31217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XPD7Ztjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfBHRiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:38:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfBHRfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so7334182wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9dKzUN0x8BEK+hLj1N43VcW29DmtNXABd9m5s3FHFI=;
        b=XPD7Ztjoa+uPvpbszqzAfueHkPDWjljRpbAYvdGzG1jQAFDbGV0zt2hteVk4G67NCe
         LOxLx1GZRsfMNrKErRhInM+FroKi8/EEdFuaFsBr+OeQfzxpNoWRcRYilQ/yTI7818M5
         iilG9zjNdTMkVeDLviVfJgXyaHkK3QQtvrKOElcPiBMBB6LkYgWWEhbZRk7RSpLDRKBw
         I0tiIl0BTCMergQH3owYHTAca2aFrz0WLUeNGwgjE8bOrc8lYxsM88RU6Lfi72qE8MTg
         YRykDuY/gP+ledlkhchaZmJPipJ9p5K5Vk1YJLAzfz7Ia9rpCZCmV5Jt1ymKvcIKW5zJ
         Z8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9dKzUN0x8BEK+hLj1N43VcW29DmtNXABd9m5s3FHFI=;
        b=KhKOnW2B1k3XBqs5s/OD8Yva6xEnIDpbwEVj1dkuZRZSkuEz0bt4s7GqNHkIcnAFNF
         EeYyOWo5OpBh6Y2kvGPEdcNBbDaoPNrUnEcncXiDAXFcyYXMNGSG2BVRiOm2DG/W0ybi
         iJnSR0wvvMeAxlpQM4bT/44Y2jlEUmDBoCaj+j8vq0nZ2I0af83o3r3S/Y7333qcK9Ek
         zRL2nloHETGgPYbni2deBOMZV3LFN0H4oj9KVOHo6yl4cQ2G1WWa4N/YMn6efxV4e7vF
         QKHaCjYLN2it3zeMzST6yQ85hiS7n1goT8Z6jSg/rfnCpazgQpBnpJnXbLMJEk/S8AiW
         ksBQ==
X-Gm-Message-State: AHQUAuZqWmDfmCXEmmeZU3ZLfjc8zFFuLjAvcSJu8HOk5LCo0u7Uoh/m
        eQ3FOhxab8+jrgqFX1+tlzJBlw==
X-Google-Smtp-Source: AHgI3IYWPfBl3+USQY1+qhXiRibTIP1ZLqLX3m/jyueEWSMTslVqHuFKfj7x4edfm+WnhGFCCa1bOg==
X-Received: by 2002:adf:9083:: with SMTP id i3mr17309253wri.124.1549647318306;
        Fri, 08 Feb 2019 09:35:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:17 -0800 (PST)
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
Subject: [PATCH v2 10/33] ARM: davinci: aintc: wrap davinci_irq_init() with a helper
Date:   Fri,  8 Feb 2019 18:34:35 +0100
Message-Id: <20190208173458.4801-11-brgl@bgdev.pl>
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

We're going to extend the davinci_irq_init() function with a config
structure so we can drop the intc-related fields from davinci_soc_info.

Once we do it, we won't be able to use this routine directly as the
init_irq callback. Wrap the calls in additional helpers that don't
take parameters and can be assigned to init_irq.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    | 4 ++--
 arch/arm/mach-davinci/board-neuros-osd2.c   | 2 +-
 arch/arm/mach-davinci/board-sffsdr.c        | 2 +-
 arch/arm/mach-davinci/davinci.h             | 4 ++++
 arch/arm/mach-davinci/dm355.c               | 5 +++++
 arch/arm/mach-davinci/dm365.c               | 5 +++++
 arch/arm/mach-davinci/dm644x.c              | 5 +++++
 arch/arm/mach-davinci/dm646x.c              | 5 +++++
 12 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f7fa960c23e3..64d81fc86f14 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -438,7 +438,7 @@ static __init void dm355_evm_init(void)
 MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.atag_offset  = 0x100,
 	.map_io	      = dm355_evm_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm355_init_irq,
 	.init_time	= dm355_init_time,
 	.init_machine = dm355_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 0fdf1d03eb11..b9e9950dd300 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -273,7 +273,7 @@ static __init void dm355_leopard_init(void)
 MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.atag_offset  = 0x100,
 	.map_io	      = dm355_leopard_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm355_init_irq,
 	.init_time	= dm355_init_time,
 	.init_machine = dm355_leopard_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e3b0b701e395..8a53e4c7944d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -834,7 +834,7 @@ static __init void dm365_evm_init(void)
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.atag_offset	= 0x100,
 	.map_io		= dm365_evm_map_io,
-	.init_irq	= davinci_irq_init,
+	.init_irq	= dm365_init_irq,
 	.init_time	= dm365_init_time,
 	.init_machine	= dm365_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index a6bc48c9ecd9..e7a6e2d1fcd9 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -891,7 +891,7 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	/* Maintainer: MontaVista Software <source@mvista.com> */
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_evm_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm644x_init_irq,
 	.init_time	= dm644x_init_time,
 	.init_machine = davinci_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 26c123f35350..21d92d3c10ec 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -864,7 +864,7 @@ static __init void evm_init(void)
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm646x_init_irq,
 	.init_time	= dm646x_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
@@ -874,7 +874,7 @@ MACHINE_END
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm646x_init_irq,
 	.init_time	= dm6467t_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index efdaa27241c5..ce99f782811a 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -231,7 +231,7 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	/* Maintainer: Neuros Technologies <neuros@groups.google.com> */
 	.atag_offset	= 0x100,
 	.map_io		 = davinci_ntosd2_map_io,
-	.init_irq	= davinci_irq_init,
+	.init_irq	= dm644x_init_irq,
 	.init_time	= dm644x_init_time,
 	.init_machine = davinci_ntosd2_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 792bb84d5011..91f594f96189 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -153,7 +153,7 @@ static __init void davinci_sffsdr_init(void)
 MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_sffsdr_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm644x_init_irq,
 	.init_time	= dm644x_init_time,
 	.init_machine = davinci_sffsdr_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index db4c95ef4d5c..56c1835c42e5 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -88,6 +88,7 @@ int davinci_init_wdt(void);
 /* DM355 function declarations */
 void dm355_init(void);
 void dm355_init_time(void);
+void dm355_init_irq(void);
 void dm355_register_clocks(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
@@ -97,6 +98,7 @@ int dm355_gpio_register(void);
 
 /* DM365 function declarations */
 void dm365_init(void);
+void dm365_init_irq(void);
 void dm365_init_time(void);
 void dm365_register_clocks(void);
 void dm365_init_asp(void);
@@ -110,6 +112,7 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_init(void);
+void dm644x_init_irq(void);
 void dm644x_init_devices(void);
 void dm644x_init_time(void);
 void dm644x_register_clocks(void);
@@ -119,6 +122,7 @@ int dm644x_gpio_register(void);
 
 /* DM646x function declarations */
 void dm646x_init(void);
+void dm646x_init_irq(void);
 void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
 void dm646x_register_clocks(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index b27ea4fc1d51..6c65699cb074 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -792,6 +792,11 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+void __init dm355_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 static int __init dm355_init_devices(void)
 {
 	struct platform_device *edma_pdev;
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index d9c6ab9215a6..e1c223c6031f 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1051,6 +1051,11 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+void __init dm365_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 static int __init dm365_init_devices(void)
 {
 	struct platform_device *edma_pdev;
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b2748c82b747..2b18c134ee15 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -728,6 +728,11 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+void __init dm644x_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 void __init dm644x_init_devices(void)
 {
 	struct platform_device *edma_pdev;
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index cf210741dfe5..75a9f80317ca 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -689,6 +689,11 @@ void __init dm646x_register_clocks(void)
 	platform_device_register(&dm646x_pll2_device);
 }
 
+void __init dm646x_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 static int __init dm646x_init_devices(void)
 {
 	int ret = 0;
-- 
2.20.1

