Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF9CC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A82A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MqZ0OHeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfBHRfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38590 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfBHRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so4295578wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d84vosy0hzSE9kDbqRdSCRCT4mvEWw1x9RCjfQ9bpew=;
        b=MqZ0OHeQEmLHujZDVcJd3/KHMDFODs3nrF6nz+/Kk3D0dnkd3EFKelIhfUWHwgoSgA
         Aj25BFHUhgj6uCUcT1szz2M46+y04GukSx+6Qw45AMNPxW6Bra15QNlUshmxmPBQaWy7
         wEk34O8BhTmhTmB4JLqZ2ECR602ZuKt7r+bvry+gqdAlc8j1YuwdnX2fFjkMZ29pChLN
         tAeJfjT0BTM0Uq8r9QRndjR557d/Tias9PSY8RV7NC/ZiMBhxICLPy/6pIxqlheJtymu
         Cw1XCnh++GCmE+TtosNsdK2l4pwu1s/6/aHTE+Hu8DphX74JIPypsTZO1rqgNh0Kvlgv
         ZuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d84vosy0hzSE9kDbqRdSCRCT4mvEWw1x9RCjfQ9bpew=;
        b=jBeYrJ4OYMWH60xWkiiWkrSpFM3rOIVKLvcVbXl3HGCF9gjuFs+GV0KcvKC+bd04+q
         U88yUgeCjlbdKFRgjqRlhuu2E6j6UZXBW1J2TVYBP+kZH9axOlvulMQK+LsE+B8YqW+G
         rhPJ5JXTnlNjfIcn9/To2BueLIOrZRPdoBChueEvVVn+IGekYK83GBHKED7V6iGUROQj
         jSahDPW++Qi5GOETXc5FTJP/avkipdWpBc3KHQZf7fAMpRcoKG10nd61ile14gaErfL0
         vn+NphLBSCwYIYVDqp1v6gwMHDbgC+Q3hNk7xEF8jTKPOcqQSlvIyfQ9kBBQLgj6jKU9
         ml6w==
X-Gm-Message-State: AHQUAuZLsqHuotI5imJXaW9i/GErg1JIM6HDXt7EdrL1YT+5tjRspSr9
        QwxYrdU1JKEQRVT3zSz8FXFpmw==
X-Google-Smtp-Source: AHgI3IZwFrE0FjkgL+F1KuER6uO308U2gwKoyhRHvgUGIdAzlsb3oMCimJrh7Ax/jaej38n++QWv4w==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr18213780wrr.223.1549647311613;
        Fri, 08 Feb 2019 09:35:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:10 -0800 (PST)
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
Subject: [PATCH v2 05/33] ARM: davinci: pull davinci_intc_base into the respective intc drivers
Date:   Fri,  8 Feb 2019 18:34:30 +0100
Message-Id: <20190208173458.4801-6-brgl@bgdev.pl>
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

