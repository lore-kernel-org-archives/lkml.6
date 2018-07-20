Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CEAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB71A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mw7tWl5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB71A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbeGTQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:15:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbeGTQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:15:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id t13-v6so2261326wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8DkA5i11ty12x5YlIUfAc512h2Xpa0Q8ESkN1MFWaQ=;
        b=mw7tWl5vvUf82tIMoecQlH0KLX7rb1eOM3KtBicJJznO76iacvGFdXymj4vP3nSNCz
         DlLlbZ7O7L0EFJmV5HCWjqRzyrtSk2QA8Cvng0SL9sJ726fBbZM/PGoRjeDayzFt47Wn
         PwqfRayQoBkZX29StgpXKFZyLs5rNbkw+XJj/KoIiDAaM97p0EirZWkFG+gIwHo5H1vj
         BqeceAsEsWrHvlTl+yIUCmS8Mju8ezZtmCR51zwYMzH7eHcgMrqNWBMJvfUC15D79xX1
         gzXQaOxxlllx1cyfDisvlKCT5dRji275XKjgrmXv1sXpUCBaUUv1Sbbj3LnQO1cJa87V
         2RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8DkA5i11ty12x5YlIUfAc512h2Xpa0Q8ESkN1MFWaQ=;
        b=kPmMHl7Dp2yVdpI9WymglaiP8SbYCYBCM0GivjX8vIRzMizCis8r6hOxO5zgDobriQ
         NYgLP2b33i6iSKn9EStI/w93hE25zYflgjNtaggMkAKKTHcGxB1uVGX7NlD/r5nfTCng
         V9HDNnvGQLIqPDeJdSYzTUENd8aUDR2Vz+lBK1ip6YI96xSVsV26uYIS9S1RtoMInaBH
         tsXT7YiSxONhRsNb4zV+GLmaFRhxBz6IeOKX8eEGEm5UG4CdATTyjnT5nglOGzP0GfX6
         +0jYppNW7vqin++Z8THo+WD7pv3AX/qMRWaf5PBl97rMj6YKFpTSgglcFGs7TroaXRVY
         6JeQ==
X-Gm-Message-State: AOUpUlFcDUmPx19lGTBdIVZN51eGjNu2mBlgay84/9RWE33juCT+8jDg
        i0F3X52a8vYl2fYHTWz/2x0t1g==
X-Google-Smtp-Source: AAOMgpepjUD/MaUr+rPgZdMKuBUWBEmyU3eydhRLvipCM1G+vxl44nzHoAh5Gf5PhrXV/HaXtYDJsw==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr1776367wrd.67.1532100398687;
        Fri, 20 Jul 2018 08:26:38 -0700 (PDT)
Received: from boomer.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id j3-v6sm2910051wrt.70.2018.07.20.08.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:26:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] reset: meson: add meson audio arb driver
Date:   Fri, 20 Jul 2018 17:26:33 +0200
Message-Id: <20180720152633.6227-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720152633.6227-1-jbrunet@baylibre.com>
References: <20180720152633.6227-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Audio ARB is a simple device which enables or
disables the access of Audio FIFOs to DDR on AXG based SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/Kconfig                 |   7 ++
 drivers/reset/Makefile                |   1 +
 drivers/reset/reset-meson-audio-arb.c | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/reset/reset-meson-audio-arb.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c0b292be1b72..782dc59b3855 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -73,6 +73,13 @@ config RESET_MESON
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
 
+config RESET_MESON_AUDIO_ARB
+	tristate "Meson Audio Memory Arbiter Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This enables the reset driver for Audio Memory Arbiter of
+	  Amlogic's A113 based SoCs
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index c1261dcfe9ad..aca2240b48aa 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
new file mode 100644
index 000000000000..91751617b37a
--- /dev/null
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+
+struct meson_audio_arb_data {
+	struct reset_controller_dev rstc;
+	void __iomem *regs;
+	struct clk *clk;
+	const unsigned int *reset_bits;
+	spinlock_t lock;
+};
+
+#define ARB_GENERAL_BIT	31
+
+static const unsigned int axg_audio_arb_reset_bits[] = {
+	[AXG_ARB_TODDR_A]	= 0,
+	[AXG_ARB_TODDR_B]	= 1,
+	[AXG_ARB_TODDR_C]	= 2,
+	[AXG_ARB_FRDDR_A]	= 4,
+	[AXG_ARB_FRDDR_B]	= 5,
+	[AXG_ARB_FRDDR_C]	= 6,
+};
+
+static int meson_audio_arb_update(struct reset_controller_dev *rcdev,
+				  unsigned long id, bool assert)
+{
+	u32 val;
+	struct meson_audio_arb_data *arb =
+		container_of(rcdev, struct meson_audio_arb_data, rstc);
+
+	spin_lock(&arb->lock);
+	val = readl(arb->regs);
+
+	if (assert)
+		val &= ~BIT(arb->reset_bits[id]);
+	else
+		val |= BIT(arb->reset_bits[id]);
+
+	writel(val, arb->regs);
+	spin_unlock(&arb->lock);
+
+	return 0;
+}
+
+static int meson_audio_arb_status(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	u32 val;
+	struct meson_audio_arb_data *arb =
+		container_of(rcdev, struct meson_audio_arb_data, rstc);
+
+	val = readl(arb->regs);
+
+	return !(val & BIT(arb->reset_bits[id]));
+}
+
+static int meson_audio_arb_assert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	return meson_audio_arb_update(rcdev, id, true);
+}
+
+static int meson_audio_arb_deassert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	return meson_audio_arb_update(rcdev, id, false);
+}
+
+static const struct reset_control_ops meson_audio_arb_rstc_ops = {
+	.assert = meson_audio_arb_assert,
+	.deassert = meson_audio_arb_deassert,
+	.status = meson_audio_arb_status,
+};
+
+static const struct of_device_id meson_audio_arb_of_match[] = {
+	{ .compatible = "amlogic,meson-axg-audio-arb", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, meson_audio_arb_of_match);
+
+static int meson_audio_arb_remove(struct platform_device *pdev)
+{
+	struct meson_audio_arb_data *arb = platform_get_drvdata(pdev);
+
+	/* Disable all access */
+	spin_lock(&arb->lock);
+	writel(0, arb->regs);
+	spin_unlock(&arb->lock);
+
+	clk_disable_unprepare(arb->clk);
+
+	return 0;
+}
+
+static int meson_audio_arb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct meson_audio_arb_data *arb;
+	struct resource *res;
+	int ret;
+
+	arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
+	if (!arb)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, arb);
+
+	arb->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(arb->clk)) {
+		if (PTR_ERR(arb->clk) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(arb->clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	arb->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(arb->regs))
+		return PTR_ERR(arb->regs);
+
+	spin_lock_init(&arb->lock);
+	arb->reset_bits = axg_audio_arb_reset_bits;
+	arb->rstc.nr_resets = ARRAY_SIZE(axg_audio_arb_reset_bits);
+	arb->rstc.ops = &meson_audio_arb_rstc_ops;
+	arb->rstc.of_node = dev->of_node;
+
+	/*
+	 * Enable general :
+	 * In the initial state, all memory interfaces are disabled
+	 * and the general bit is on
+	 */
+	ret = clk_prepare_enable(arb->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable arb clock\n");
+		return ret;
+	}
+	writel(BIT(ARB_GENERAL_BIT), arb->regs);
+
+	/* Register reset controller */
+	ret = devm_reset_controller_register(dev, &arb->rstc);
+	if (ret) {
+		dev_err(dev, "failed to register arb reset controller\n");
+		meson_audio_arb_remove(pdev);
+	}
+
+	return ret;
+}
+
+static struct platform_driver meson_audio_arb_pdrv = {
+	.probe = meson_audio_arb_probe,
+	.remove = meson_audio_arb_remove,
+	.driver = {
+		.name = "meson-audio-arb-reset",
+		.of_match_table = meson_audio_arb_of_match,
+	},
+};
+module_platform_driver(meson_audio_arb_pdrv);
+
+MODULE_DESCRIPTION("Amlogic A113 Audio Memory Arbiter");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.4

