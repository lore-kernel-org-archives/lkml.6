Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA745C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3F2218D4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LuCTvUzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfBHRfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36641 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfBHRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so4296815wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzfnSpoOYGpWQS3GaWXG/pkuAlPtf22jbVg1mWp1L8g=;
        b=LuCTvUzS6w/2mhntELOWGsCig1miVW4lqteobqYKp6Lk5ad5ahc9e8W8RpAN+b+pfi
         0LZwXyEYBMTpTZmxzyJb2g/4OwXI/S89ZJn35n1c3KSGWmcHn0K13+5XpTtYHg8eKqxL
         nokvHN0m8g++35OANK/alzgl4EPdz4jTOdWrxQldSQDNsnIn3M3pllYxxwqUsOmIJ5Tk
         r3BEe4+1oM+gd9anXVPCbF8hJKBfFYU3BRPBM0N/iFWLV0NVe6g+evUu5vCX78zMAdNi
         Wc3rSBKAA0buovgFZx7nLGUlFhUfnORkJZYrYxzKc6tDpb2BuyNkqn/v4UcX9fZDE97G
         i17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzfnSpoOYGpWQS3GaWXG/pkuAlPtf22jbVg1mWp1L8g=;
        b=tp2xX9QQIB+AgfIyj5sEam3YwSQ//p9G/bgt9CxhPW1UILRpbYCf5muPaN1XkmiAg7
         LmWFBlPU1/UKvCqE4RGcdaqxgDbxBFsNxvn24pGMzr/uztW8Vg8KDxENeugOnqkXrXHA
         OvKWN0icEBDmKw/m3gSVzmsvcwZ9ikQf0OMvkElU99EoQEidOF5qYfQEzMi4OXhVdgVH
         bIHGG2qvJVSg/VlyQCKMv0d+wBmE1vqDlHw2UO/roCx0Bp54XhAL4e1xTnhAQ2VwrKEk
         BLx5curcU+OqdcWyAFdgBx+j7YxHhRKxHYEIYZzfdZRb8Whm4TdZuKK/07Q3dBo7iCNE
         oNDw==
X-Gm-Message-State: AHQUAubi8IESORHLZcwIobf70CdG889Hko5mNrewgBcc+L+rPP7Gsped
        BADN/sKQj9mrqsZqS1CxCysEQQ==
X-Google-Smtp-Source: AHgI3IbCCsgTKvv9ki7O+nUk/7I7PCvoUs08ucVZRle20uz5KlvxNriaUri6YtLEDeOg1/R5IFpG/Q==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr3735937wmc.78.1549647337385;
        Fri, 08 Feb 2019 09:35:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:36 -0800 (PST)
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
Subject: [PATCH v2 26/33] ARM: davinci: cp-intc: use the new-style config structure
Date:   Fri,  8 Feb 2019 18:34:51 +0100
Message-Id: <20190208173458.4801-27-brgl@bgdev.pl>
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

Modify the cp-intc driver to take all its configuration from the new
config structure. Stop referencing davinci_soc_info in any way.
Move the declaration for davinci_cp_intc_init() to
irq-davinci-cp-intc.h and make it take the new config structure as
parameter. Convert all users to the new version.

Also: since the two da8xx SoCs default all irq priorities to 7, just
drop the priority configuration at all and hardcode the channels to 7.

It will simplify the driver code and make our lives easier when it
comes to device-tree support.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 93 +++++++++------------
 arch/arm/mach-davinci/da830.c               |  2 +-
 arch/arm/mach-davinci/da850.c               |  2 +-
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 include/linux/irqchip/irq-davinci-cp-intc.h |  2 +
 5 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index dcd43b067a6a..faf3d74d3719 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -20,7 +21,6 @@
 #include <linux/of_irq.h>
 
 #include <asm/exception.h>
-#include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
 #define DAVINCI_CP_INTC_HOST_CTRL		0x0c
@@ -158,22 +158,15 @@ static const struct irq_domain_ops davinci_cp_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static int __init davinci_cp_intc_of_init(struct device_node *node,
-					  struct device_node *parent)
+static int __init
+davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
+			struct device_node *node)
 {
-	u32 num_irq		= davinci_soc_info.intc_irq_num;
-	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	unsigned num_reg	= BITS_TO_LONGS(num_irq);
-	int i, irq_base;
-
-	if (node) {
-		davinci_cp_intc_base = of_iomap(node, 0);
-		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
-			pr_warn("unable to get intc-size, default to %d\n",
-				num_irq);
-	} else {
-		davinci_cp_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
-	}
+	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
+	int offset, irq_base;
+
+	davinci_cp_intc_base = ioremap(config->reg.start,
+				       resource_size(&config->reg));
 	if (WARN_ON(!davinci_cp_intc_base))
 		return -EINVAL;
 
@@ -183,51 +176,29 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_ENABLE(0));
 
 	/* Disable system interrupts */
-	for (i = 0; i < num_reg; i++)
-		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_ENABLE_CLR(i));
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(~0,
+			DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
 
 	/* Set to normal mode, no nesting, no priority hold */
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_CTRL);
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_CTRL);
 
 	/* Clear system interrupt status */
-	for (i = 0; i < num_reg; i++)
-		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_STAT_CLR(i));
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(~0,
+			DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
 
 	/* Enable nIRQ (what about nFIQ?) */
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 
-	/*
-	 * Priority is determined by host channel: lower channel number has
-	 * higher priority i.e. channel 0 has highest priority and channel 31
-	 * had the lowest priority.
-	 */
-	num_reg = (num_irq + 3) >> 2;	/* 4 channels per register */
-	if (irq_prio) {
-		unsigned j, k;
-		u32 val;
-
-		for (k = i = 0; i < num_reg; i++) {
-			for (val = j = 0; j < 4; j++, k++) {
-				val >>= 8;
-				if (k < num_irq)
-					val |= irq_prio[k] << 24;
-			}
-
-			davinci_cp_intc_write(val, DAVINCI_CP_INTC_CHAN_MAP(i));
-		}
-	} else	{
-		/*
-		 * Default everything to channel 15 if priority not specified.
-		 * Note that channel 0-1 are mapped to nFIQ and channels 2-31
-		 * are mapped to nIRQ.
-		 */
-		for (i = 0; i < num_reg; i++)
-			davinci_cp_intc_write(0x0f0f0f0f,
-					      DAVINCI_CP_INTC_CHAN_MAP(i));
-	}
+	/* Default all priorities to channel 7. */
+	num_regs = (config->num_irqs + 3) >> 2;	/* 4 channels per register */
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(0x07070707,
+			DAVINCI_CP_INTC_CHAN_MAP(offset));
 
-	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
+	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
 		irq_base = 0;
@@ -235,7 +206,7 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 
 	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
-					node, num_irq, irq_base, 0,
+					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
@@ -251,9 +222,25 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 	return 0;
 }
 
-void __init davinci_cp_intc_init(void)
+int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
 {
-	davinci_cp_intc_of_init(NULL, NULL);
+	return davinci_cp_intc_do_init(config, NULL);
 }
 
+static int __init davinci_cp_intc_of_init(struct device_node *node,
+					  struct device_node *parent)
+{
+	struct davinci_cp_intc_config config = { };
+	int ret;
+
+	ret = of_address_to_resource(node, 0, &config.reg);
+	if (WARN_ON(ret))
+		return ret;
+
+	ret = of_property_read_u32(node, "ti,intc-size", &config.num_irqs);
+	if (WARN_ON(ret))
+		return ret;
+
+	return davinci_cp_intc_do_init(&config, node);
+}
 IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0eb48ed2d423..7ce0b5f1200d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -833,7 +833,7 @@ static const struct davinci_cp_intc_config da830_cp_intc_config = {
 
 void __init da830_init_irq(void)
 {
-	davinci_cp_intc_init();
+	davinci_cp_intc_init(&da830_cp_intc_config);
 }
 
 void __init da830_init_time(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index fe274ab63fc8..62a00fa94696 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -771,7 +771,7 @@ static const struct davinci_cp_intc_config da850_cp_intc_config = {
 
 void __init da850_init_irq(void)
 {
-	davinci_cp_intc_init();
+	davinci_cp_intc_init(&da850_cp_intc_config);
 }
 
 void __init da850_init_time(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 7ad79171b4b5..14e0e1c40611 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -22,7 +22,6 @@
 #define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
-void davinci_cp_intc_init(void);
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
index 2270a6167b98..8d71ed5b5a61 100644
--- a/include/linux/irqchip/irq-davinci-cp-intc.h
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -20,4 +20,6 @@ struct davinci_cp_intc_config {
 	unsigned int num_irqs;
 };
 
+int davinci_cp_intc_init(const struct davinci_cp_intc_config *config);
+
 #endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.20.1

