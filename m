Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B224E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SXI6KFH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfBKM0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32926 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfBKM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so130861wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d84vosy0hzSE9kDbqRdSCRCT4mvEWw1x9RCjfQ9bpew=;
        b=SXI6KFH/twIrzqjmE7k/SrAQKeGX46c+TAbRieThkTE5FgLtRAcdArt6yoOKsL+XbK
         L+6DOt5wfwZiOnDZd7RCZygXXNv7B8eC1HqVuM4HU3Om6+yaj3Xf4AGBns6eDakzmUpC
         7VfySyu0nkZvDMJh8nu1KYtEG8/t55pp3kwvzWX4WbSGAJ0I6yCrWvZLQdGfWOA7o/WL
         ivSeuijqvh238EWa9Jnx6GnEc3sJgCXImwxZv13ml/trtY3aP6HAxbSStSv/VjfVZGFo
         jVvK/hkrMcvoQn8gfbNIiFuHomOTofoHjzwOIEqd0FkV/2PxupDQg5JA/10EnXirAcvd
         bXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d84vosy0hzSE9kDbqRdSCRCT4mvEWw1x9RCjfQ9bpew=;
        b=Bzej46dvoZlPUhZNQRSgg37AH/blP0pLUy1/TK9MjM4+zvV38q57japVlSb//rVqT2
         9+/xkuneLsRjUICURauV2oaW79yLH+2YxBy9zdftj+VcDlWbG8RTMqW8YdC1CPgOFuTa
         BOv8c7OWtesRl6Eud9a/hrV1MoJkeaUnTfMnun6LLdh03NDfwQIwWse9qZsJkKw3MAGO
         wxE6VSM6Yo4uTJysRrp1TrGEqkYchHOF7R8n0pGL5cJRObfB7L9FFzHMdW9gGVilI1f7
         MGSFUlZLh0JcFDJAHyLQdum6eGnJ6K1KDkjU5dqg1UjlSqyf5zrLqHE50yZCbSUVYcWL
         2Hug==
X-Gm-Message-State: AHQUAuawqb//cTl+9TbNhy1t73bv5u1dqHCjYK+kw4+mNGnQ9njUUj3g
        mbvY2tiiOyYXur+kWU+GTGiJYw==
X-Google-Smtp-Source: AHgI3IZv0+aj5jt6+lgppUcuQTLdUhV/8UqD0EBRknE0NAr6RlWZyg33cx5DBwF/ifwwScNW6bO0Og==
X-Received: by 2002:adf:f848:: with SMTP id d8mr29154975wrq.178.1549887979554;
        Mon, 11 Feb 2019 04:26:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 05/33] ARM: davinci: pull davinci_intc_base into the respective intc drivers
Date:   Mon, 11 Feb 2019 13:25:38 +0100
Message-Id: <20190211122606.8662-6-brgl@bgdev.pl>
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
index 2494d9b36966..19f17ef04381 100644
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

