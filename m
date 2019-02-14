Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A64222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1a8MxIk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501957AbfBNOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:54:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39182 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439590AbfBNOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so5705250wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
        b=1a8MxIk7mzrEZuGEL8O4slwTer4ZVWRwPyAzAyUhE0CsWaAfIqsgulUDDWm9qZ9a6S
         dGGvkJkCFh3xFZgm0lzFH9t9N6v+WBrOpeAQJXMV5AEmkL3yl6sh3RiQO4D/fZuB82R2
         SQuEl3lLMzDGJApN52XUhF/4OYSAEDAZkEg/VUbwxloO76YbdNlGqA+yFOtRQ02JMIOU
         i9glJleOfdoR67JYMlZS+aWkRXDyojtBAKYo1VIQ+72C2qq/4G4TvPBuFZByKHJrOVud
         RZ+9JPgWUHTTHR2NJ1PTSOGO0BNJGNSRFPdHHwuOcb8znbxIrOvHcX1wUuTIrjCgF0sa
         w45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
        b=DkxVEy9paKaeuBO54gJtXJQ+HyPC5LO7DrmEDjVQAv4j7LxfPXuIJktcXh0tnBzg7K
         h7V2AENBV2o9lBZB++Tz8APapM7SYuCiHSxcb2BND2uVO9+R6V5uuP0B14d/drk8185m
         MRvcj9uUvbTdc3ZoAIE89fVs4XW61PTEAoAoSId8fFeDQFqnrL2A2RmZyoXWSXp71cEJ
         ZKkPZAJYGFbBXBV4R20mAybZdnY9gwTTpPSfgkhxYGsBFPLAIN3oluAaUY6ct2/mhSN2
         zN1yvQc9sT6dB/D9I8aB70MZ6pWki+kjfdVFy0d2cAXWVZOm+wfqTSqTfpxNgDRmb8Ie
         8edw==
X-Gm-Message-State: AHQUAuaBdzgpxr0WYTrHiq82ZiWgt47w2n89d6YoRh3LSwLyYBjIfY1E
        uD4SIZHckqVfdzAbZZb/mRzSjw==
X-Google-Smtp-Source: AHgI3IYlwv+S6KMpy90axf4Pnr1NPwXKpzfHdRCsbHE2F6qdY0zNpTPnXr4i416rFfcjcUJre+/CPA==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr3130403wrj.0.1550155991656;
        Thu, 14 Feb 2019 06:53:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:11 -0800 (PST)
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
Subject: [PATCH v4 24/37] ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
Date:   Thu, 14 Feb 2019 15:52:18 +0100
Message-Id: <20190214145231.8750-25-brgl@bgdev.pl>
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

We're going to extend the cp_intc_init() function with a config
structure so we can drop the intc-related fields from davinci_soc_info.

Once we do it, we won't be able to use this routine directly as the
init_irq callback. Wrap the calls in additional helpers that don't
take parameters and can be assigned to init_irq.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c     | 2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 +-
 arch/arm/mach-davinci/da830.c               | 5 +++++
 arch/arm/mach-davinci/da850.c               | 5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  | 2 ++
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index f81c92b9cf07..1ae7dcb8f59d 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -694,7 +694,7 @@ static void __init da830_evm_map_io(void)
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da830_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da830_init_irq,
 	.init_time	= da830_init_time,
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1cc49e7bf128..8022ca8ac4ef 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1522,7 +1522,7 @@ static void __init da850_evm_map_io(void)
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da850_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index eb6a9465f229..815f155eb349 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -623,7 +623,7 @@ static void __init mityomapl138_map_io(void)
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
 	.map_io		= mityomapl138_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 7f852722ff08..673d890c2e3e 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -461,7 +461,7 @@ static void __init omapl138_hawk_map_io(void)
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
 	.map_io		= omapl138_hawk_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ca903c9105e4..5cfd30c57429 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -821,6 +821,11 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+void __init da830_init_irq(void)
+{
+	cp_intc_init();
+}
+
 void __init da830_init_time(void)
 {
 	void __iomem *pll;
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 486d53481636..6df6994c0f26 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -759,6 +759,11 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+void __init da850_init_irq(void)
+{
+	cp_intc_init();
+}
+
 void __init da850_init_time(void)
 {
 	void __iomem *pll0;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ab4a57f433f4..1618b30661a9 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -88,10 +88,12 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_init(void);
+void da830_init_irq(void);
 void da830_init_time(void);
 void da830_register_clocks(void);
 
 void da850_init(void);
+void da850_init_irq(void);
 void da850_init_time(void);
 void da850_register_clocks(void);
 
-- 
2.20.1

