Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0496C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9CB21934
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Str2ioU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfBLKjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36597 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbfBLKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so2469564wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
        b=Str2ioU3Zh9gjsHXjAh2cJusyAD5gNbOVzB/6DpqGjC8/sifLVx0LYSHkpMQcXetxS
         IzPC7xOawxM+gOfGMncjGW9A5tBNz/gKFg8PBjuLm515yTuNu14WT5zRkW2Le38aRHYb
         VDeLKCE7upuKYcBxLWteauoKft6Q7DcF8gokPXCZlRutffnZTSLNCIPIt6kw7ZbQmJdE
         x7oLft2qhARq21y1G30+1o+KN0b3V7Gw9WBxSymC4AjGAxOuBLWyo3YPYeBZqbH/sut8
         FTyJjLjI4S2vHluIz7wMUQEMqcKJd2St52y3hYN16jXxxNpkwe4WJF2kMVIcMmwZlWQP
         yc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
        b=W9ssyfQeGIPbWDBZ2dZhNXxMD50lS14fYIHUAoZuhOlnrdRjbCsjKN7sa1/B8vq5zM
         Ay072uMFeJO/+X/WMRgRqksxlBFv+z3J98UIHhACGQmM7XD6ogw5OC29UWhXdATGC4wI
         mIXvikQpZUyetVTjN5qdDRhGreYzzv2WAI2OeN9ju6jv6rBfbG/ZfM2i15654j7X7K+z
         yO+sj1N0ySZXeZ6SDBSpCxIx8FdlxUD9lZS/k4flYpAagMQRGmWX0zoN2Pxs6wY+7pFE
         s7/okM0GmX1zKdsDkOClc6ZvwBKz0/Q+qN5ualWNoyQALIdWvla08ugLyR84TmVKdof2
         5jLg==
X-Gm-Message-State: AHQUAuZRPDw1YTT7Oymq2gTh4Z2CYGaADILamOcQ1X/HbF1qSPYacCjh
        yfSXuE+b/peYWAPeG7HPiDRMaKlp0mM=
X-Google-Smtp-Source: AHgI3Ibbbh/j49LejheZMR9ph96wZJUoYnBGVuhNa6CghozVfo8qNDRo/ykEXqF73l0qeHFSvMXczg==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr2237744wmb.136.1549967943292;
        Tue, 12 Feb 2019 02:39:03 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 06/37] ARM: davinci: pull davinci_intc_base into the respective intc drivers
Date:   Tue, 12 Feb 2019 11:38:04 +0100
Message-Id: <20190212103835.7768-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
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

