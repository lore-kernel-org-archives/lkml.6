Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C87C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98DA2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AOTfbBMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfBHRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50430 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfBHRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id z5so4364145wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
        b=AOTfbBMtd23OZerUaD0B95Pp5TGB3kuH28oxVZjTikJdkKcIiiyvbmWes6cOim9gOC
         lGXWdDyQS3OlvMPiVAgws09x3h1STpy9SC0Bth1NJa4DqFkJxGhkZrDYmgOQ306oxQUg
         4TDHvshpLZigRehC8osZ1yDw96I9FEEIwMMQasgI/2XsPEi4aCvroyKCXF/P8pcWbvP/
         7vRLv96EJF2mcTX9iriYQCjQv8pF7kaIbHPLk06H6yHc7nkhSjkz0t8xq9bPuGUKocR8
         dVzdY/w2Ufw+8aHjBgC3gL8J7+9ORhgPMBrnKXeWJSStE1YnNHoYGxtpX3/iD1YX5dKX
         4/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
        b=CeT7/GPyzmOiyCKk5/17isaBdg8jvUtRmpeDV7sz8JsUWr8O0c0dMWnpdj+1gdXF3B
         slDGeVkKeDsdr37cdbKXfzPTuTj71SKTvJ7dqUW8nu+rGy42mG5uPdBb44U1GJYyRUvk
         c1Ve62vjh6rYpDl5ukcf2Glnmf325B1re9MJC5006q/AzVGbJ4HbBXCkH0fS6YH4/V07
         J3r0jzFX5LnF5SCgI1HF/wvKGV0eaWkeLRjvUOQc7j46VS71OPEHmSVBHZkgzABwbuYU
         iYM1XWL6mc/d7utT2wGcqdOv0aKwhMDRTRCR4KJxVkg0z6r+MN17bk8xBldFuF1m/ecp
         147Q==
X-Gm-Message-State: AHQUAubVq1MqMN3Ldj5ddcJujynsA8sTEl8p1aS6E+8ZQIb3NWozPjc/
        Ro6k4UW/2fTrcx+gRvr9Fx4L6w==
X-Google-Smtp-Source: AHgI3IZxcXqeoiwZnw6PdcCGq8zPSe28nDYpFBXgG8ubOglJV098dnQ1hr8jx7sG6Zy4cHQto2RADw==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr18123788wrf.206.1549647320827;
        Fri, 08 Feb 2019 09:35:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:20 -0800 (PST)
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
Subject: [PATCH v2 12/33] ARM: davinci: aintc: drop the 00 prefix from register offsets
Date:   Fri,  8 Feb 2019 18:34:37 +0100
Message-Id: <20190208173458.4801-13-brgl@bgdev.pl>
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

Since no offset goes past 0xff - let's drop the 00 prefix for better
readability. While we're at it: convert all hex numbers to lower-case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 145fda7e5a35..148c23728bdb 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -19,17 +19,17 @@
 
 #include "irqs.h"
 
-#define DAVINCI_AINTC_FIQ_REG0		0x0000
-#define DAVINCI_AINTC_FIQ_REG1		0x0004
-#define DAVINCI_AINTC_IRQ_REG0		0x0008
-#define DAVINCI_AINTC_IRQ_REG1		0x000C
-#define DAVINCI_AINTC_IRQ_IRQENTRY	0x0014
-#define DAVINCI_AINTC_IRQ_ENT_REG0	0x0018
-#define DAVINCI_AINTC_IRQ_ENT_REG1	0x001C
-#define DAVINCI_AINTC_IRQ_INCTL_REG	0x0020
-#define DAVINCI_AINTC_IRQ_EABASE_REG	0x0024
-#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x0030
-#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x004C
+#define DAVINCI_AINTC_FIQ_REG0		0x00
+#define DAVINCI_AINTC_FIQ_REG1		0x04
+#define DAVINCI_AINTC_IRQ_REG0		0x08
+#define DAVINCI_AINTC_IRQ_REG1		0x0c
+#define DAVINCI_AINTC_IRQ_IRQENTRY	0x14
+#define DAVINCI_AINTC_IRQ_ENT_REG0	0x18
+#define DAVINCI_AINTC_IRQ_ENT_REG1	0x1c
+#define DAVINCI_AINTC_IRQ_INCTL_REG	0x20
+#define DAVINCI_AINTC_IRQ_EABASE_REG	0x24
+#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x30
+#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x4c
 
 static void __iomem *davinci_aintc_base;
 static struct irq_domain *davinci_aintc_irq_domain;
-- 
2.20.1

