Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E639C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD30A218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U1+qrDL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfAaNkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37733 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbfAaNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so3343132wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=We2WlkoJ1lTjORWt1TBXuNoYiOgoaziyvmKKctGjQOg=;
        b=U1+qrDL1hKiJD95zrgp5kctoBSKJnzQuxYzATy98FMDtxrBxDlEsIZIqpNSB3Yito8
         /D4waT9v8hZEJVT0WC9RjTc4VowuB1m8+sU0HRbvwcdB+gBZCB6lE/OymwsJhZ//u5Bl
         umdcnRW3cqr3EfVX4OZrpNvxFslPNEl2i0AFXtLiXuk3AizJIEXDVGY8i+haR5qJSBbx
         V190OHH8rKABE7AS2eHoLHhIlNpjJiEty2xfaVIhecPKSUK2Cpkiks82YNRDivm5lzw/
         zP9hyAEDHeGk1A+L7aO3HruX9kxpsveLQUdy4E5rLMZDo5+uMeLUHEzWXHyyQy9QhQ1H
         Mgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=We2WlkoJ1lTjORWt1TBXuNoYiOgoaziyvmKKctGjQOg=;
        b=NhvKH/fIg3ML0egcA7e/7hOoiwscg7MRN7UsQs9MAeR7KdDms7WridGrnqg/rXYVTO
         qzqjzm5jXwRgY6bn/y7cDs2vH10GlvDvcsQ3/otEBaKQcW6QjDck7Z/jdQoRnku4wcwb
         jsrl4ln1wxTxJ1H78fR8SjnZgu4giA+L2n1EJ0AOn11uZSFVM8WO8DpUaLrrBwA4aLcC
         g3kIkYEprLHnZXo0PsitsRXh5DiWEP4+rkLyPztz5Y36ZxpIInNX6Wh5rROtnpEXwnsD
         XjxujUGiKRdJIFHi5Bvge/BwRmYqO+4tkpdskwY/ChgJh8Sh1ptJ3pCPSc9iI+CmOaNU
         SLOA==
X-Gm-Message-State: AHQUAuYeIkvpOe26zSn2wr19fzQ325nMPVdGLl2FWAN1G2Zd6qFjnWrS
        aOyJW8Bxe0xPNByOhitGkb4I9w==
X-Google-Smtp-Source: AHgI3IaJaNxLdLCLlO5UsDg7/jCPCCJbBa5eq5GrkHIjm+VHASnM8QiRabB7OiyD6WPN8apUEF7Juw==
X-Received: by 2002:adf:8421:: with SMTP id 30mr178924wrf.153.1548942019070;
        Thu, 31 Jan 2019 05:40:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 32/35] ARM: davinci: remove intc related fields from davinci_soc_info
Date:   Thu, 31 Jan 2019 14:39:25 +0100
Message-Id: <20190131133928.17985-33-brgl@bgdev.pl>
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

These are no longer used. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c               | 19 -------------------
 arch/arm/mach-davinci/da850.c               | 20 --------------------
 arch/arm/mach-davinci/dm355.c               |  3 ---
 arch/arm/mach-davinci/dm365.c               |  3 ---
 arch/arm/mach-davinci/dm644x.c              |  3 ---
 arch/arm/mach-davinci/dm646x.c              |  3 ---
 arch/arm/mach-davinci/include/mach/common.h |  3 ---
 7 files changed, 54 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index bdbd66ffd2ea..9cf9b090efeb 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -624,22 +624,6 @@ const short da830_eqep1_pins[] __initconst = {
 	-1
 };
 
-/* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da830_cp_intc_prios[] = {
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-};
-
 static struct map_desc da830_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -728,9 +712,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da830_cp_intc_prios,
-	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index fe370e85aeb1..b9ebdcde68eb 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -299,23 +299,6 @@ const short da850_vpif_display_pins[] __initconst = {
 	-1
 };
 
-/* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da850_cp_intc_prios[] = {
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7,
-};
-
 static struct map_desc da850_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -651,9 +634,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da850_cp_intc_prios,
-	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a0bfb3602136..5573f53b47f9 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -651,9 +651,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm355_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index eab575873255..6d9bf292f4c6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -666,9 +666,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm365_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index beb97101c881..2f181b4149c1 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -591,9 +591,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm644x_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 70505c92d5fb..4ce2c8c6b945 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -531,9 +531,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm646x_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 9e06974c85bb..2b986d32049f 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -53,9 +53,6 @@ struct davinci_soc_info {
 	u32				pinmux_base;
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
-	u32				intc_base;
-	u8				*intc_irq_prios;
-	unsigned long			intc_irq_num;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1

