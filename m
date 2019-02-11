Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D1D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Zu/d29D9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfBKM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:28:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55485 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBKM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so17359819wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9dKzUN0x8BEK+hLj1N43VcW29DmtNXABd9m5s3FHFI=;
        b=Zu/d29D9K/whPeaDtG8jhSrK4d4H8Y5x9wqugVMAxg8dRhT9zXS4ezv5WHYDQ+OWiC
         3Y9dQVoCIaD0EtCzgvz45EqqEaimCbcz+wrcm6ziwfbploDfZtrii0uw4A30h2iSioL7
         TXgXYzVcCKRSnlBx4hd1ZcH8O2FhN7kleRFJgJSDrmY4i8fw1VXeXu5SD6O/OY1cAMUg
         f93DWzWfmzyPf5tQSfKCWGSCW8fzppoepdE5DOAm4feMngAjQHh854mD9yVxL9Y22YHp
         9kpY6XyhvfNe58OMK+s/iopmYbxAZA+bqC6kzX9/x3fr7iG1Ef4AT7MUwLcGnGDrn4ui
         SN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9dKzUN0x8BEK+hLj1N43VcW29DmtNXABd9m5s3FHFI=;
        b=q2FbtJcDGlLr2uhOFrck5IfGdPWaa1zr1rz/74y2pXEp9ZR8ZzyrT3k1/vRaQABw+y
         VsVzEcGdqo4a0+a6hK8wxhtTvwa8sofTZmGNnoUcvOS+ydaHXPzVmtACCXZabplJiyQ4
         8pzUNeGBGGWq1b0jQCi2f1ULk9KUJI6I3adX5w1aNRNiP725fHFvSb+fTrjmD9IlzfNV
         9LHY2x72MPPWAX8KgLKgmTYrpW7Uz4MjZE5/gD7MHXDgxTz+bINsidnayhPZwPc7m4qE
         0hzRpJTvHfW9tm5V8nyeeuOHn6rNcQDXdC2LXi3PLhnghNGxsjnpLtzMLk9xHf2LpiQi
         MzYg==
X-Gm-Message-State: AHQUAubkV2GTja7pIsgREO2ppOCvvMvW19wPd74FE0iFEjuwSNr7AJNt
        otrhtataGgHkzSedm0LN7D3wew==
X-Google-Smtp-Source: AHgI3IZ+NuezHYxfHAMpgdnH0zToF+u0lqqAaIornHqW6wpRYBQ6T071owbyaOWqK7tAhVRWiISQlg==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr8558071wmj.63.1549887985934;
        Mon, 11 Feb 2019 04:26:25 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 10/33] ARM: davinci: aintc: wrap davinci_irq_init() with a helper
Date:   Mon, 11 Feb 2019 13:25:43 +0100
Message-Id: <20190211122606.8662-11-brgl@bgdev.pl>
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

