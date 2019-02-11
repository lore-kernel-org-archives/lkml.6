Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D787C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4324A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sjLvAsJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfBKM1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39510 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfBKM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so4481924wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
        b=sjLvAsJudbkXVSzQ8CPz7SCsSgXURENM83m3sNg6hjlmzreJbbrvEt01lfcI/MV4b+
         9J/TRakS9+ln5YkIAyydO5URpbAs4in7RFLafAWSw/jOFc6WhTKx2fyyOXzVCK/QIpoC
         zwx5C/Tk+DbN0KVnwdS9vKJu0jc+YYOXDLSldKN25vz2T9TkX8AKf96RbgeQ5WuNH8+r
         gdEi9hLMQmvxywJH1w5ln/Nb82MdhCfIljAUjnfM/dZ3yRv2uvtr3EjTzGg8Po/USY8d
         zKVZHwqEcGoR/v7/9Re1PYMg47T/VPYnjhJqV7vJrHHxmheUhyOq59jWQWU1cMUki0aH
         35dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
        b=YVnPjGIQpSBJlUNGyjo4Xs+T2Y6LjvCLmUOAl7lF63+i9BfALtqKTXcZFIn33FDjU1
         m7QlyTbqqmYklHBj8o8ZRru/PyDAKUGqzTCoGZ3IDW5NXvfhRt78M3I/LYTYHKm1xlyT
         BQ23X1xz2f6a70pEXi7baC4iV4jWYo2gUI2xglHKxqiJvaKNlfqK7WwpOe41kfwbWpEN
         tYByW48+ZOhJcEIUHyOsVWHIzdyr7exhrBKbv5wl3CvCj/2Te9eDOHNiqLvZFqqHm5qj
         sdOkwyZ+5KJ6FpBvJpAFFM+xeRL3mr+vWf9dgPCiZbqdJFlcoxWAq1uyPEcI15YlkY8h
         sUpg==
X-Gm-Message-State: AHQUAuYE3gNl8O470GfJ6h3qx5sDAcf8gZdl7VCfKeNlwCr6lFl4R929
        XQpBfvv2/aZgEV0FQ3O4WGivfg==
X-Google-Smtp-Source: AHgI3IZG2L2nMr9fmd1GTt4GdmMENgvYt+Qdh4SBSE0YB8U2kBjXpEba6LQse1mA04KDmHg43s4drA==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr25665384wru.127.1549887999048;
        Mon, 11 Feb 2019 04:26:39 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 21/33] ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
Date:   Mon, 11 Feb 2019 13:25:54 +0100
Message-Id: <20190211122606.8662-22-brgl@bgdev.pl>
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

