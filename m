Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D78C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ADA20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ADA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeLCMYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:24:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40789 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCMYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:24:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so11167169lji.7;
        Mon, 03 Dec 2018 04:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3IcBOcMebSegDE2suDRtzdIfDfjoFDzHLWatOf7pRc=;
        b=CTq94j1WbLbieWHLK0W43UQTjdXwUWodMT02eCF9K4WAH83MkjckaXXzu/ZKP6475I
         MguJ/OQZ/4QgbRVt0YMl2RBKUVH0tDu9I4cdJYTCRMzYaVBe+vCRTDmn/YrU2n6uV9/5
         Trc4KCHwvAYtY3sT7AVROdmTuZVDXmpsUesLigx2HcaKmG4Ldp0qSZy0Ai4CQJOh39Ej
         fsmm3pu0A7WQRy1PWnnN4a+YR9Q9iyEbLVqjfLZ2/bi6nE/FzqoxGNm93P/urU5iaOmt
         niPS/vnjCqJqeqYE1E7DnU4vDmPE1DWYR9A9L3jNgFLbPws7qXsrmmod0jqClcxXHa2d
         CP3A==
X-Gm-Message-State: AA+aEWZFZeaGIrhlMsnqGCh93bRl0N1pTOCdcwAcDuuHGt8mzTM1lBpX
        cgU9SN/+T1/g+mXU+n3fEoU=
X-Google-Smtp-Source: AFSGD/W+ahtDp3KH0WT3OuHcaqjTmG8XYhWE4G4B62ekVjbHPEE1Vbep23gig1Bmq5eHfclZDz4PuQ==
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr9863359ljl.162.1543839837418;
        Mon, 03 Dec 2018 04:23:57 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2477864lje.78.2018.12.03.04.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:23:56 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:23:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, lee.jones@linaro.org,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 9/9] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <3bb96772e26833fe121fd99ea53eca616c2955be.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM bd71837 and bd71847 contain 32768Hz clock gate. Support the clock
using generic clock framework. Note, only bd71837 is tested but bd71847
should be identical what comes to clk parts.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/Kconfig       |   7 +++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-bd718x7.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/clk/clk-bd718x7.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 81cdb4eaca07..2dc12bf75b1b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -283,6 +283,13 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD718XX
+	tristate "Clock driver for ROHM BD718x7 PMIC"
+	depends on MFD_ROHM_BD718XX
+	help
+	  This driver supports ROHM BD71837 and ROHM BD71847
+	  PMICs clock gates.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 72be7a38cff1..a47430b387db 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,6 +21,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BD718XX)	+= clk-bd718x7.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
new file mode 100644
index 000000000000..df5f1068ce8e
--- /dev/null
+++ b/drivers/clk/clk-bd718x7.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd71837.c  -- ROHM BD71837MWV clock driver
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mfd/rohm-bd718x7.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/regmap.h>
+
+struct bd718xx_clk {
+	struct clk_hw hw;
+	u8 reg;
+	u8 mask;
+	struct platform_device *pdev;
+	struct bd718xx *mfd;
+};
+
+static int bd71837_clk_set(struct clk_hw *hw, int status)
+{
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	return regmap_update_bits(c->mfd->regmap, c->reg, c->mask, status);
+}
+
+static void bd71837_clk_disable(struct clk_hw *hw)
+{
+	int rv;
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	rv = bd71837_clk_set(hw, 0);
+	if (rv)
+		dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
+}
+
+static int bd71837_clk_enable(struct clk_hw *hw)
+{
+	return bd71837_clk_set(hw, 1);
+}
+
+static int bd71837_clk_is_enabled(struct clk_hw *hw)
+{
+	int enabled;
+	int rval;
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	rval = regmap_read(c->mfd->regmap, c->reg, &enabled);
+
+	if (rval)
+		return rval;
+
+	return enabled & c->mask;
+}
+
+static const struct clk_ops bd71837_clk_ops = {
+	.prepare = &bd71837_clk_enable,
+	.unprepare = &bd71837_clk_disable,
+	.is_prepared = &bd71837_clk_is_enabled,
+};
+
+static int bd71837_clk_probe(struct platform_device *pdev)
+{
+	struct bd718xx_clk *c;
+	int rval = -ENOMEM;
+	const char *parent_clk;
+	struct device *parent = pdev->dev.parent;
+	struct bd718xx *mfd = dev_get_drvdata(parent);
+	struct clk_init_data init = {
+		.name = "bd718xx-32k-out",
+		.ops = &bd71837_clk_ops,
+	};
+
+	c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	init.num_parents = 1;
+	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
+
+	init.parent_names = &parent_clk;
+	if (!parent_clk) {
+		dev_err(&pdev->dev, "No parent clk found\n");
+		return -EINVAL;
+	}
+
+	c->reg = BD718XX_REG_OUT32K;
+	c->mask = BD718XX_OUT32K_EN;
+	c->mfd = mfd;
+	c->pdev = pdev;
+	c->hw.init = &init;
+
+	of_property_read_string_index(parent->of_node,
+				      "clock-output-names", 0, &init.name);
+
+	rval = devm_clk_hw_register(&pdev->dev, &c->hw);
+	if (!rval) {
+		rval = devm_clk_hw_register_clkdev(&pdev->dev,
+						   &c->hw, init.name, NULL);
+		if (rval)
+			dev_warn(&pdev->dev, "Failed to register clkdev\n");
+		if (parent->of_node) {
+			rval = devm_of_clk_add_parent_hw_provider(&pdev->dev,
+					     of_clk_hw_simple_get, &c->hw);
+			if (rval)
+				dev_err(&pdev->dev,
+					"adding clk provider failed\n");
+		}
+	} else {
+		dev_err(&pdev->dev, "failed to register 32K clk");
+	}
+
+	return rval;
+}
+
+static struct platform_driver bd71837_clk = {
+	.driver = {
+		.name = "bd718xx-clk",
+	},
+	.probe = bd71837_clk_probe,
+};
+
+module_platform_driver(bd71837_clk);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
