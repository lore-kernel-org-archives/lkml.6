Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DE720449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SAMKq/hS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfBLKlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:41:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44909 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfBLKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id v16so2056854wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YW/+k9BvoNkqcFFu2Jlt+OYGUXl4uq4KzMp9XtY9tko=;
        b=SAMKq/hSpan8l7XX2bCvj0DZyFuvIOmDR0IzHKmx+nGiDqONLy0HUB2tZLdAcgpHQx
         NV0q7iX4BefA4GcIZlufRwSEwfkaGBGAQeCNu5EIWQVkyDbpgA7PuYqeMHbN1ELcC0/w
         w90noVSzPidcHvFeQoQLzIkdwOK0LQcnwDBK3zpkEcl9RYwx2vTtdLMy/avUv9dKR+5w
         sMJFB8rPxkPwOJHjwpEhvw5bii0AIXOmmWt5QUUHXSvdzQcq48yhkOXNFtqPUuhAkK4o
         fxQbnJo3nOAsGff59ZUHWYtq/bO/1y1S8xLAiO4hRaiJMNJUDjM4bafQwsEvmxQVV7bs
         ymOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YW/+k9BvoNkqcFFu2Jlt+OYGUXl4uq4KzMp9XtY9tko=;
        b=mly3wjTYLZgM23uPtTFa7KCvIN+mtnk9lPq7MO4HPMgcumoC4RBJxLvMr2TZ8ZhKKV
         zOpgSaudciNEu+1l4YIjSHDwIC9JSoqswmZxShR7dXePz0qb+ILUFLa/pEAuj59U+mv+
         yIZMV7gT1wtaIKRV2G5+XbtnLW6cAmsWrRkjzpuEcfib8XWgYwG1PSmDML5PmICTjaQ8
         7VNb9nMrCsSSMEoVJDSLZhqUR9GFI5esfzF/6OR5ZRj96NuwkTw2Nq5UT35Htyw+uKtk
         MdUO94/WE0gixb+Gv11tKx+2snb4/hUp34Ol+dvZN5CwnIGvc4NFlVIxLDemXzQG+CEL
         Fe/Q==
X-Gm-Message-State: AHQUAuYyHphDDSRdGtNRtfKxgjxsVhBSP0R7IHIMjlfUK2D9RcduNwRn
        CH9gSS2z8umj69y3mTH45EOA7Q==
X-Google-Smtp-Source: AHgI3IYNqqBh/dJ4wlNKKUJ/oUzmhU79BVRca01lENmGXc8MjLwWEO6E5I/P6Cd++k7OOJqKUNIM6Q==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr2509256wrr.285.1549967956961;
        Tue, 12 Feb 2019 02:39:16 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 17/37] ARM: davinci: aintc: use the new config structure
Date:   Tue, 12 Feb 2019 11:38:15 +0100
Message-Id: <20190212103835.7768-18-brgl@bgdev.pl>
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
index 509be44eda22..1b2eeddfabd1 100644
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
 	int ret, irq_base;
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
 	if (WARN_ON(ret))
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

