Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61004C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317A52229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UIMRCs2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502023AbfBNO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:56:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439486AbfBNOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so5704087wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
        b=UIMRCs2wrCW8fHpmWrbh8J2YNd4PN6gVHcAXkiPWvANvdFg0yw5kKUVm3XM/vONEa+
         6zpI3/5TRU6sCVpv/ihTO/bWllQYv7dszXPpzb9aSfye3NUe9qv4F7lkVaLZG+Z+nZPS
         F4zVNnUjgLaszlC84ZPoSBSGpVKtCEUTa+54LRig9iBNYsCduzLJ50z/E3Id8dwlZYtG
         jcc/FSRg20NKxuLS5v3tqM6vycTlRMZEVtCkzTKJcBrDRiHLhs8Do4MTCv5bniae32xF
         AuL7zH2ktLVk5tec6+U9qM8xES5Z6qFVNPeX0yQM1qhNYXcyuM+TWkdkaRiuGMGlvaC5
         wetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
        b=NkmCd8YDJPU3nea0vCo6L2IUy/u4Tc3lq/yOdw5NoLOk6FtpnQ/kZ+oV8Pmc1HhRZM
         X/VtC7y3ielh4RQp+A44TREpvvAc5B5mOlqEdrVBzsUq8xS3rFv4MXCVmB2lH00EO9BC
         /xCmxH/lre7e1WAp2qKHgHgrxsantK3Q4V7xfl3IVBztBNzeQfLMUJgScKh5iUYurqKJ
         CHEnJUbxV/FPJStdabqrF4DIn2c2+NLVMKhZMOamOydgTeeRzE5H2/xrcdcrfOv1eLE1
         7aTcho6FotaDTMtUP3j0C9oYySvTyZ3WsmQ8BBD2Jpn4D14E8GTMZkqZbrhmIwCPGe6e
         z7sw==
X-Gm-Message-State: AHQUAuaNNO3q2Ji9BuCzRVvBCVzrBWSZfV/nw3ry82LGYCmstU6ZpRvY
        7jKRE1kWbwZ9UW/ZOUsEppWFrg==
X-Google-Smtp-Source: AHgI3IZLGLCe7po9IM8woAYyOn0/6rK3FUyEPly+FSXLQD+0m36qIDZML02akqI/VqRtLhpsiBmiqg==
X-Received: by 2002:a05:6000:1110:: with SMTP id z16mr3266178wrw.28.1550155969928;
        Thu, 14 Feb 2019 06:52:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:49 -0800 (PST)
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
Subject: [PATCH v4 06/37] ARM: davinci: pull davinci_intc_base into the respective intc drivers
Date:   Thu, 14 Feb 2019 15:52:00 +0100
Message-Id: <20190214145231.8750-7-brgl@bgdev.pl>
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

davinci_intc_base is defined globally in common.c. Define separate
local variables for the aintc and cp-intc drivers and remove the
global one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/common.c              | 2 --
 arch/arm/mach-davinci/cp_intc.c             | 2 ++
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 arch/arm/mach-davinci/irq.c                 | 1 +
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index a87e158a709b..2850ae02aaa4 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -23,8 +23,6 @@
 struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
 
-void __iomem *davinci_intc_base;
-
 void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
 {
 	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 19874f5ef542..4e293cde20fb 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -26,6 +26,8 @@
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
 
+static void __iomem *davinci_intc_base;
+
 static inline unsigned int cp_intc_read(unsigned offset)
 {
 	return __raw_readl(davinci_intc_base + offset);
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 34e48de92dcc..3d45b73b9a64 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -20,7 +20,6 @@
 void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
-extern void __iomem *davinci_intc_base;
 
 struct davinci_timer_instance {
 	u32		base;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2e3426ebfd97..b27b90dc269c 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -43,6 +43,7 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static void __iomem *davinci_intc_base;
 static struct irq_domain *davinci_irq_domain;
 
 static inline void davinci_irq_writel(unsigned long value, int offset)
-- 
2.20.1

