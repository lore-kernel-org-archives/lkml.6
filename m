Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EFEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE21C217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GpCVxFiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfBHRh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36900 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfBHRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4271422wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8EpdU+NTm/X4LPjHfsGwt/Q2G9WVDhSfKVsB9gEBqM=;
        b=GpCVxFiMaTsv7giLo9bZrCVsIwJxNe3O3mt/A1+tWtoVu+2xBI8FkwkWb2MV7VEHdp
         mWHZb6rK5+AHMGyNqED8sN0DBFqXdx1T72sXVmcFxY+/BscPy/PRY+OtYXDu9RMxJ7x1
         ZnWIN7UOAiqiAewG0Ou4H+00sw1EjZlLj9PBRT4fzp6AWbeDl4vTAkBcJ3GQi5pjGiql
         BFgmCvISCifcCBhY7Ee7rnVtnYyb0rVQJtUqRd2Xqm5IVYybLJAtAVgcRFAsOTHzK+7k
         K2RID6vTlhwsY2hDoiOIxb4h8K7kWrmGzR6Z3Xdx3X0eeQyhJas2HFhLB7NVtEjbwLFd
         BtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8EpdU+NTm/X4LPjHfsGwt/Q2G9WVDhSfKVsB9gEBqM=;
        b=Cq7eZVvbcLbKCdqO7xxiVjtwRSDUpRiFEqRxdvNrKPL9twsZXazKI4cZsN51MnubQ2
         RpOrSbrTzT36G0x7taowkhtSgZQjEHRwqlS7h4iJI7W6HB3oH2HviUGQQWyPN4GSVra1
         N8mjm1PFTKuYdFm56n59tzhyAVMMfY4xDXfTu8xs6mS7S7COX25NtjDKc1CAYAXlUoIz
         d+/T6iNW5jCQqY1WUXK6HILzQ4FanXrB4P8Oo4yE8YmkQHLCDGAZNMq+fIj/bbx4LKn/
         8DPyBN6br6yakidHQKPzAyfdNF0CrN5/Z6WkhkBB8pEW2Chz0ybWIl/9E2UDJESpUi8u
         BQTw==
X-Gm-Message-State: AHQUAuaq+82J4gyE5rRYqhb4eYN7CSDRCUdX0iRQGZwx+5rQF4MWr061
        a7wV5wgH0xyMYI1B5cZrToX9Qw==
X-Google-Smtp-Source: AHgI3IYgfgZ7qw6JXPv4Z0BBl8MEGBYOI9yhoAyNUh7V86StOVJ5/aGn1NqXK587lAGRKaPG607zow==
X-Received: by 2002:a5d:5289:: with SMTP id c9mr15816618wrv.11.1549647325667;
        Fri, 08 Feb 2019 09:35:25 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:24 -0800 (PST)
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
Subject: [PATCH v2 16/33] ARM: davinci: aintc: use the new config structure
Date:   Fri,  8 Feb 2019 18:34:41 +0100
Message-Id: <20190208173458.4801-17-brgl@bgdev.pl>
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

Modify the aintc driver to take all its configuration from the new
config structure. Stop referencing davinci_soc_info in any way.
Move the declaration for davinci_aintc_init() to irq-davinci-aintc.h
and make it take the new config structure as parameter. Convert all
users to the new version.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm355.c               |  2 +-
 arch/arm/mach-davinci/dm365.c               |  2 +-
 arch/arm/mach-davinci/dm644x.c              |  2 +-
 arch/arm/mach-davinci/dm646x.c              |  2 +-
 arch/arm/mach-davinci/include/mach/common.h |  2 --
 arch/arm/mach-davinci/irq.c                 | 39 +++++++++++----------
 include/linux/irqchip/irq-davinci-aintc.h   |  2 ++
 7 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index ff79c1a17fae..c7cd765114af 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -805,7 +805,7 @@ static const struct davinci_aintc_config dm355_aintc_config = {
 
 void __init dm355_init_irq(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm355_aintc_config);
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 44dc3ca94dd3..bde3c3b94cc9 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1064,7 +1064,7 @@ static const struct davinci_aintc_config dm365_aintc_config = {
 
 void __init dm365_init_irq(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm365_aintc_config);
 }
 
 static int __init dm365_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0b0ecac36486..6d3498058283 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -741,7 +741,7 @@ static const struct davinci_aintc_config dm644x_aintc_config = {
 
 void __init dm644x_init_irq(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm644x_aintc_config);
 }
 
 void __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 4e871d00e4e9..a0a8b336c1a4 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -702,7 +702,7 @@ static const struct davinci_aintc_config dm646x_aintc_config = {
 
 void __init dm646x_init_irq(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm646x_aintc_config);
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 8c9c011f96f6..14e0e1c40611 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -24,8 +24,6 @@
 
 void davinci_timer_init(struct clk *clk);
 
-extern void davinci_aintc_init(void);
-
 struct davinci_timer_instance {
 	u32		base;
 	u32		bottom_irq;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 6a7205a844e1..f5578abfc0aa 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
@@ -82,13 +83,14 @@ davinci_aintc_handle_irq(struct pt_regs *regs)
 }
 
 /* ARM Interrupt Controller Initialization */
-void __init davinci_aintc_init(void)
+void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 {
-	unsigned i, j;
-	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	unsigned int irq_off, reg_off, prio, shift;
 	int rv, irq_base;
+	const u8 *prios;
 
-	davinci_aintc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
+	davinci_aintc_base = ioremap(config->reg.start,
+				     resource_size(&config->reg));
 	if (WARN_ON(!davinci_aintc_base))
 		return;
 
@@ -114,23 +116,21 @@ void __init davinci_aintc_init(void)
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
 
-	for (i = DAVINCI_AINTC_IRQ_INTPRI0_REG;
-	     i <= DAVINCI_AINTC_IRQ_INTPRI7_REG; i += 4) {
-		u32		pri;
-
-		for (j = 0, pri = 0; j < 32; j += 4, davinci_def_priorities++)
-			pri |= (*davinci_def_priorities & 0x07) << j;
-		davinci_aintc_writel(pri, i);
+	prios = config->prios;
+	for (reg_off = DAVINCI_AINTC_IRQ_INTPRI0_REG;
+	     reg_off <= DAVINCI_AINTC_IRQ_INTPRI7_REG; reg_off += 4) {
+		for (shift = 0, prio = 0; shift < 32; shift += 4, prios++)
+			prio |= (*prios & 0x07) << shift;
+		davinci_aintc_writel(prio, reg_off);
 	}
 
-	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
+	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (WARN_ON(irq_base < 0))
 		return;
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
-					davinci_soc_info.intc_irq_num,
-					irq_base, 0, &irq_domain_simple_ops,
-					NULL);
+						config->num_irqs, irq_base, 0,
+						&irq_domain_simple_ops, NULL);
 	if (WARN_ON(!davinci_aintc_irq_domain))
 		return;
 
@@ -140,10 +140,11 @@ void __init davinci_aintc_init(void)
 	if (WARN_ON(rv))
 		return;
 
-	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num;
-	     i += 32, j += 0x04)
-		davinci_aintc_setup_gc(davinci_aintc_base + j,
-				       irq_base + i, 32);
+	for (irq_off = 0, reg_off = 0;
+	     irq_off < config->num_irqs;
+	     irq_off += 32, reg_off += 0x04)
+		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
+				       irq_base + irq_off, 32);
 
 	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
index 2b2ace3c1b22..ea4e087fac98 100644
--- a/include/linux/irqchip/irq-davinci-aintc.h
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -22,4 +22,6 @@ struct davinci_aintc_config {
 	u8 *prios;
 };
 
+void davinci_aintc_init(const struct davinci_aintc_config *config);
+
 #endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.20.1

