Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69C72082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69C72082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeH3QRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:17:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40203 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeH3QRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:17:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so7004208lfi.7;
        Thu, 30 Aug 2018 05:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4KPi67myzeQ1FvF6NBuES+SArwvrUD1LTCBlE+pLLQ=;
        b=UlvgJbg6uP+43sQAru9ceV88pqdaT0kcDFja5kacuZazlQf5CBmJyXYvGmtjzJ903q
         v/+oGJoiF56qI94DvgOkQrGC52UC9iZ9KThkGljeBZflQRQn7Pu7LbCMW/LnI7wj7R7q
         Cd2pEGyKMULS7w3W5Hv0BNEgede6YwBzDagEdKAifFpbn4KzZoqQfkUhha5d+voBwJ/D
         BgwDoG/7iNXvq7QlS8P8GuzLIJF5jHwEj1ynC9pvcvw62IvOODrIZK95sRABrYrIy1ZV
         cv87HJS1/iXrYR35zAjIsTamD+ec9YWi/8Jv9mGoPoOG9bTXl5Xd0uXF5xPSwGN8qyWI
         JxMA==
X-Gm-Message-State: APzg51B6lu/NDi5arSbqi5SCkcncBsZIABc3uqs6bRnnhT0zSL5UWE1W
        rYhU0DBqsl3WLUlzPnRnMXpkW+CNOwQ=
X-Google-Smtp-Source: ANB0VdZjBhrOjmNhq0/6cN/thlOtfv1z79VJJ7SYto4VTIiOsiPKk0c6eC2BNXmHsrG8pGgA4whDDw==
X-Received: by 2002:a19:a2c1:: with SMTP id l184-v6mr4101751lfe.129.1535631345764;
        Thu, 30 Aug 2018 05:15:45 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r22-v6sm1219224ljh.22.2018.08.30.05.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 05:15:45 -0700 (PDT)
Date:   Thu, 30 Aug 2018 15:15:32 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        linux@armlinux.org.uk, andrew.smirnov@gmail.com, robh@kernel.org,
        sre@kernel.org, linux@roeck-us.net, sjhuang@iluvatar.ai,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 2/2] clk: bd718x7: Initial support for ROHM bd71837/bd71847
 PMIC clock
Message-ID: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
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
 drivers/clk/Kconfig       |   6 +++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-bd718x7.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/clk/clk-bd718x7.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 292056bbb30e..b2aee8fa4445 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -283,6 +283,12 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD718XX
+	tristate "Clock driver for ROHM BD71837 PMIC MFD"
+	depends on MFD_ROHM_BD718XX
+	help
+	  This driver supports ROHM BD71837 PMIC clock.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a84c5573cabe..886dce9f9bec 100644
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

