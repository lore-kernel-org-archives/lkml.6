Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AEE23F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ck581qmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AEE23F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeGFObe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:31:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45880 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932908AbeGFOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:31:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id u7-v6so4409655wrn.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8w14N2fJyXXpDVsbu5ufgDBgPxgrsziRvwfn3mGkMo4=;
        b=Ck581qmjtw4WtDzGmGZm6vnwJQsykGga6KZbGvLAndHgop/3LpRSGW6wZ9Dv0bIvDI
         mJsH6F1+4SlSq1mVzMZq9NP+hhtMseV230+6ZJfyGg361oX7XbZfyFLTg2THK2z2MoRs
         IuGygEdize3PgROc25HuXGr6sYZP56iH5Ftjl0qSroaXrqEVU4B0lni4xWpdtN91Zue+
         CuIlhQC+xeoj8ZikKrEoub2s6VCcm0sovirgz3nGRuT2qtiPbN0BOcpE6IZpHx3tB+QA
         UZZp4FdN5Qr2Fcu6SagnSZNVi6X3SQmWq7z4G5H45ohElifYglacU2xsFXr7h40G4PeG
         +Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8w14N2fJyXXpDVsbu5ufgDBgPxgrsziRvwfn3mGkMo4=;
        b=i4cZVBLwCKOMXf5tMEC4VEd2U/TpdvZJu8SMYwUnVS7pOuaDuee6u0XfuhicmzyE0d
         CYCQNAEtqw7whDqJU+LHS8cv+lScgzrNmYdXHQxvU3beA8pGWPtIV784X1HSEBiP7zg/
         OWEgzOLpynu5MR+80NVzIkzJBM0cWCft4oVSrM2BcVDaUAt+ZH3rHS9dX2iwJmLjt0cU
         TzSX2UrQUH0t2FSKI9wtz/GD0FeWuQsLEEleL9iSE/0R3TtonlPwzmhcX4UwQMZegRaM
         oQg87g2sI1opWboOZZFnCdYtWMI0vUDVuomQUqSyq2PJvJ1LKixtYmIxyVhVggsC/Anm
         cYjw==
X-Gm-Message-State: APt69E0CpQYNEMOMf5xrTtP9W3typN5EwlIu+zDcGVZHiqEJKlX965YS
        S4Xc1kChZcUn/7vDMqTq4KmKP+V6
X-Google-Smtp-Source: AAOMgpeCU55EhfnMNRzbfeNjyNJDBN2Vz2qF2xpxpnfuzJb0efP0CcMIXCqJGt5rXAu2580/JpBx4g==
X-Received: by 2002:adf:9aeb:: with SMTP id a98-v6mr7363696wrc.110.1530887489483;
        Fri, 06 Jul 2018 07:31:29 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b190-v6sm14358709wma.24.2018.07.06.07.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:31:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] reset: meson: add meson audio arb driver
Date:   Fri,  6 Jul 2018 16:31:22 +0200
Message-Id: <20180706143122.7612-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706143122.7612-1-jbrunet@baylibre.com>
References: <20180706143122.7612-1-jbrunet@baylibre.com>
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
index c0b292be1b72..c62c915167c4 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -73,6 +73,13 @@ config RESET_MESON
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
 
+config RESET_MESON_AUDIO_ARB
+	tristate "Meson Audio Memory Arbitror Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This enables the reset driver for Audio Memory Arbitror of
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
index 000000000000..c3eec178972e
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
+MODULE_DESCRIPTION("Amlogic A113 Audio Memory Arbitror");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.4

