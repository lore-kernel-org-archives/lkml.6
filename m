Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BE79CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F5D208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F5D208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965855AbeFONbE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:31:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46813 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936211AbeFONbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:31:01 -0400
Received: by mail-lf0-f68.google.com with SMTP id j13-v6so14638401lfb.13;
        Fri, 15 Jun 2018 06:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+39OShcRVRInEPwcb8kvvTYr3lIX/3+aIIj+sYNrwQ=;
        b=XGjyIgeYI6/IdNK4hn3aP7r5AT0d7nSPtWoZlw2+w5EtaI+1N2Nr65AqH+rhaPdqsW
         7eUmuxmS9gonBgpLXGMow3HhVmAbSTctkiOPhfR4pZQiqpej2F8EQwKulhcvnSkXUJi2
         gx/+UKR3M9/j17ORnSh8MjM16qrqGJH8bEcgYWFFBV3dFwFd5iBwhsZTBqA9uCcKKFsq
         QM3YDXn3Yb786amVQfaUj7Uc540SgYZpxB43yPbbYvC1XT5sZjzJCeN9JOyeWQT7WX4o
         XjZYhCNHHCtgZ7UaEzeH75fTfr27Mdru0rXimxAaPfr2LJl7QTofOIxMTBH1zauQnvcb
         yCmQ==
X-Gm-Message-State: APt69E1Pz5wAzTy8ER4LiSiVa2GHVl632kSeGbVX6/39Aed//irYMtnN
        oMiK3/cnxHqOAZVBEd8rjRA=
X-Google-Smtp-Source: ADUXVKK/JLpvVmdSXigm5sh01Y6RAWrKnAdpBUAvDySdbimhE+I+VDrzhw7mwnMkGsWFDxYLMBhlEQ==
X-Received: by 2002:a2e:cf:: with SMTP id e76-v6mr1364958lji.82.1529069459368;
        Fri, 15 Jun 2018 06:30:59 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id o9-v6sm1519761lfk.2.2018.06.15.06.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 06:30:58 -0700 (PDT)
Date:   Fri, 15 Jun 2018 16:30:51 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v6 3/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <69915265bbff5c729bcd4ffd4ffdba8d24582068.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support BD71837 gateable 32768 Hz clock.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/Kconfig       |   6 ++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-bd71837.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/clk/clk-bd71837.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 41492e980ef4..065421a9eb22 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -279,6 +279,12 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD71837
+	tristate "Clock driver for ROHM BD71837 PMIC MFD"
+	depends on MFD_BD71837
+	help
+	  This driver supports ROHM BD71837 PMIC clock.
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index de6d06ac790b..8393c4af7d5a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,6 +21,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BD71837)	+= clk-bd71837.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-bd71837.c b/drivers/clk/clk-bd71837.c
new file mode 100644
index 000000000000..8b9aae33eade
--- /dev/null
+++ b/drivers/clk/clk-bd71837.c
@@ -0,0 +1,145 @@
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
+#include <linux/mfd/bd71837.h>
+#include <linux/clk-provider.h>
+
+struct bd71837_clk {
+	struct clk_hw hw;
+	u8 reg;
+	u8 mask;
+	unsigned long rate;
+	struct platform_device *pdev;
+	struct bd71837 *mfd;
+};
+
+static int bd71837_clk_set(struct clk_hw *hw, int status)
+{
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	return bd71837_update_bits(c->mfd, c->reg, c->mask, status);
+}
+
+static void bd71837_clk_disable(struct clk_hw *hw)
+{
+	int rv;
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
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
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	enabled = c->mask;
+	enabled &= bd71837_reg_read(c->mfd, c->reg);
+
+	return enabled;
+}
+static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	return c->rate;
+}
+
+static struct clk_ops bd71837_clk_ops = {
+	.prepare = &bd71837_clk_enable,
+	.unprepare = &bd71837_clk_disable,
+	.is_prepared = &bd71837_clk_is_enabled,
+};
+
+static int bd71837_clk_probe(struct platform_device *pdev)
+{
+	struct bd71837_clk *c;
+	int rval = -ENOMEM;
+	const char *parent_clk;
+	struct device *parent = pdev->dev.parent;
+	struct bd71837 *mfd = dev_get_drvdata(parent);
+	struct clk_init_data init = {
+		.name = "bd71837-32k-out",
+		.ops = &bd71837_clk_ops,
+	};
+
+	c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
+		return -ENOMEM;
+
+	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
+
+	init.parent_names = &parent_clk;
+	if (parent_clk) {
+		init.num_parents = 1;
+	} else {
+		/* If parent is not given from DT we assume the typical
+		 * use-case with 32.768 KHz oscillator for RTC (Maybe we
+		 * should just error out here and require parent?)
+		 */
+		c->rate = BD71837_CLK_RATE;
+		bd71837_clk_ops.recalc_rate = &bd71837_clk_recalc_rate;
+		dev_warn(&pdev->dev, "No parent clk found - assuming 32,768 KHz\n");
+	}
+
+	c->reg = BD71837_REG_OUT32K;
+	c->mask = BD71837_OUT32K_EN;
+	c->mfd = mfd;
+	c->pdev = pdev;
+	c->hw.init = &init;
+
+	of_property_read_string_index(parent->of_node,
+					      "clock-output-names", 0,
+					      &init.name);
+
+	rval = devm_clk_hw_register(&pdev->dev, &c->hw);
+	if (!rval) {
+		if (parent->of_node) {
+			rval = of_clk_add_hw_provider(parent->of_node,
+					     of_clk_hw_simple_get,
+					     &c->hw);
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
+static int bd71837_clk_remove(struct platform_device *pdev)
+{
+	if (pdev->dev.parent->of_node)
+		of_clk_del_provider(pdev->dev.parent->of_node);
+	return 0;
+}
+
+static struct platform_driver bd71837_clk = {
+	.driver = {
+		.name = "bd71837-clk",
+	},
+	.probe = bd71837_clk_probe,
+	.remove = bd71837_clk_remove,
+};
+
+module_platform_driver(bd71837_clk);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3

