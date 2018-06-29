Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39586C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5E027BD6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5E027BD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935048AbeF2IWE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:22:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39897 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934450AbeF2IV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:21:59 -0400
Received: by mail-lf0-f68.google.com with SMTP id q6-v6so6174679lfh.6;
        Fri, 29 Jun 2018 01:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RjPWSCwpMMKga+sewudU2pZQveWwDoIgj8/aFy4YnVI=;
        b=YDqoTC3Xs8QYWWDfdDDdcI78juTxHh9V4EE7S85tyWcN+Jx0o1Psx/60hv/TQWC01d
         vv7z2ttODlBemlCNYZF0i+CRyTmggpNweh4tOFHWg0vkz2fpcAi5PdbsF1z3L8JxV5/M
         C/gaAHKE4FoLmkTJY4Q//8s785vNYBPIUUa+C6t+ytIpH3YogcqzV64a+Iwc3686Qs6Z
         FSGJWTyROxNRL36tsTbROg/eTSM+P47kycUu4IQIzwqmb/sC0D8qE0InG8+GVX5/RKhA
         8XsIEsM1bhXKLSiDL+rCjM+ZLSyr8cfXzWvAkdmgM5Fo1h6Uwh8xJ7JIjomPdhi6Q4Af
         2Whw==
X-Gm-Message-State: APt69E3LlPmTl6g3zkxQNTHjXR2RzeHL0FWtDYwNGBd+lO9IULPV0QRC
        6PrareaxUslicPQqXRL8VIs=
X-Google-Smtp-Source: AAOMgpf8louzWBHzctaxLnHte1Df3EBPvKSJ4hzYY2xB3OmMRZ8SAFqTwJbBkuv/jfQWdv/wKvAaXw==
X-Received: by 2002:a19:e4c1:: with SMTP id x62-v6mr9554449lfi.76.1530260517173;
        Fri, 29 Jun 2018 01:21:57 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y67-v6sm1443318lje.74.2018.06.29.01.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 01:21:56 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:21:44 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v8 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <18a04e42debb2a23aec855cac3bcf3d6ab6c55fd.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71837 PMIC MFD driver providing interrupts and support
for three subsystems:
- clk
- Regulators
- input/power-key

fix too long lines

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/mfd/Kconfig         |  13 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/bd71837.c       | 220 +++++++++++++++++++++++++
 include/linux/mfd/bd71837.h | 391 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 625 insertions(+)
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 include/linux/mfd/bd71837.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..d01a279f5e4a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1787,6 +1787,19 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_BD71837
+	tristate "BD71837 Power Management chip"
+	depends on I2C=y
+	depends on OF
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  Select this option to get support for the ROHM BD71837
+	  Power Management chips. BD71837 is designed to power processors like
+	  NXP i.MX8. It contains 8 BUCK outputs and 7 LDOs, voltage monitoring
+	  and emergency shut down as well as 32,768KHz clock output.
+
 config MFD_STM32_LPTIMER
 	tristate "Support for STM32 Low-Power Timer"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20dba18d..09dc9eb3782c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -227,4 +227,5 @@ obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
 obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
+obj-$(CONFIG_MFD_BD71837)	+= bd71837.o
 
diff --git a/drivers/mfd/bd71837.c b/drivers/mfd/bd71837.c
new file mode 100644
index 000000000000..25f2de2a5bb8
--- /dev/null
+++ b/drivers/mfd/bd71837.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) 2018 ROHM Semiconductors
+// bd71837.c -- ROHM BD71837MWV mfd driver
+//
+// Datasheet available from
+// https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
+
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/bd71837.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/gpio_keys.h>
+
+static struct gpio_keys_button btns[] = {
+	{
+		.code = KEY_POWER,
+		.gpio = -1,
+		.type = EV_KEY,
+	}
+};
+
+static struct gpio_keys_platform_data bd718xx_powerkey_data = {
+	.buttons = &btns[0],
+	.nbuttons = ARRAY_SIZE(btns),
+	.name = "bd718xx-pwrkey",
+};
+
+/* bd71837 multi function cells */
+
+static struct mfd_cell bd71837_mfd_cells[] = {
+	{
+		.name = "bd71837-clk",
+	}, {
+		.name = "gpio-keys",
+		.platform_data = &bd718xx_powerkey_data,
+		.pdata_size = sizeof(bd718xx_powerkey_data),
+	}, {
+		.name = "bd71837-pmic",
+	}
+};
+
+static const struct regmap_irq bd71837_irqs[] = {
+	REGMAP_IRQ_REG(BD71837_INT_SWRST, 0, BD71837_INT_SWRST_MASK),
+	REGMAP_IRQ_REG(BD71837_INT_PWRBTN_S, 0, BD71837_INT_PWRBTN_S_MASK),
+	REGMAP_IRQ_REG(BD71837_INT_PWRBTN_L, 0, BD71837_INT_PWRBTN_L_MASK),
+	REGMAP_IRQ_REG(BD71837_INT_PWRBTN, 0, BD71837_INT_PWRBTN_MASK),
+	REGMAP_IRQ_REG(BD71837_INT_WDOG, 0, BD71837_INT_WDOG_MASK),
+	REGMAP_IRQ_REG(BD71837_INT_ON_REQ, 0, BD71837_INT_ON_REQ_MASK),
+	REGMAP_IRQ_REG(BD71837_INT_STBY_REQ, 0, BD71837_INT_STBY_REQ_MASK),
+};
+
+static struct regmap_irq_chip bd71837_irq_chip = {
+	.name = "bd71837-irq",
+	.irqs = bd71837_irqs,
+	.num_irqs = ARRAY_SIZE(bd71837_irqs),
+	.num_regs = 1,
+	.irq_reg_stride = 1,
+	.status_base = BD71837_REG_IRQ,
+	.mask_base = BD71837_REG_MIRQ,
+	.ack_base = BD71837_REG_IRQ,
+	.init_ack_masked = true,
+	.mask_invert = false,
+};
+
+static const struct regmap_range pmic_status_range = {
+	.range_min = BD71837_REG_IRQ,
+	.range_max = BD71837_REG_POW_STATE,
+};
+
+static const struct regmap_access_table volatile_regs = {
+	.yes_ranges = &pmic_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config bd71837_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &volatile_regs,
+	.max_register = BD71837_MAX_REGISTER - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct of_device_id bd71837_of_match[] = {
+	{ .compatible = "rohm,bd71837", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bd71837_of_match);
+
+static int bd71837_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct bd71837 *bd71837;
+	struct bd71837_board *board_info;
+	int ret = -EINVAL;
+
+	board_info = dev_get_platdata(&i2c->dev);
+
+	if (!board_info) {
+		board_info = devm_kzalloc(&i2c->dev, sizeof(*board_info),
+					  GFP_KERNEL);
+		if (!board_info) {
+			ret = -ENOMEM;
+			goto err_out;
+		} else if (i2c->irq) {
+			board_info->gpio_intr = i2c->irq;
+		} else {
+			ret = -ENOENT;
+			goto err_out;
+		}
+	}
+
+	if (!board_info)
+		goto err_out;
+
+	bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
+	if (bd71837 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, bd71837);
+	bd71837->dev = &i2c->dev;
+	bd71837->i2c_client = i2c;
+	bd71837->chip_irq = board_info->gpio_intr;
+
+	bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
+	if (IS_ERR(bd71837->regmap)) {
+		ret = PTR_ERR(bd71837->regmap);
+		dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
+		goto err_out;
+	}
+
+	ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
+	if (ret < 0) {
+		dev_err(bd71837->dev,
+			"%s(): Read BD71837_REG_DEVICE failed!\n", __func__);
+		goto err_out;
+	}
+
+	ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
+				       bd71837->chip_irq, IRQF_ONESHOT, 0,
+				       &bd71837_irq_chip, &bd71837->irq_data);
+	if (ret < 0) {
+		dev_err(bd71837->dev, "Failed to add irq_chip %d\n", ret);
+		goto err_out;
+	}
+
+	ret = regmap_update_bits(bd71837->regmap,
+				 BD71837_REG_PWRONCONFIG0,
+				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
+				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
+	if (ret < 0) {
+		dev_err(bd71837->dev,
+			"Failed to configure button short press timeout %d\n",
+			 ret);
+		goto err_out;
+	}
+	/* According to BD71847 datasheet the HW default for long press
+	 * detection is 10ms. So lets change it to 10 sec so we can actually
+	 * get the short push and allow gracefull shut down
+	 */
+	ret = regmap_update_bits(bd71837->regmap,
+				 BD71837_REG_PWRONCONFIG1,
+				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
+				 BD718XX_PWRBTN_LONG_PRESS_10S);
+	if (ret < 0) {
+		dev_err(bd71837->dev,
+			"Failed to configure button long press timeout %d\n",
+			 ret);
+		goto err_out;
+	}
+	btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
+					  BD71837_INT_PWRBTN_S);
+
+	if (btns[0].irq < 0) {
+		ret = btns[0].irq;
+		goto err_out;
+	}
+
+	ret = devm_mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
+				   bd71837_mfd_cells,
+				   ARRAY_SIZE(bd71837_mfd_cells), NULL, 0,
+				   regmap_irq_get_domain(bd71837->irq_data));
+err_out:
+
+	return ret;
+}
+
+static const struct i2c_device_id bd71837_i2c_id[] = {
+	{ .name = "bd71837", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bd71837_i2c_id);
+
+static struct i2c_driver bd71837_i2c_driver = {
+	.driver = {
+		.name = "bd71837-mfd",
+		.of_match_table = bd71837_of_match,
+	},
+	.probe = bd71837_i2c_probe,
+	.id_table = bd71837_i2c_id,
+};
+
+static int __init bd71837_i2c_init(void)
+{
+	return i2c_add_driver(&bd71837_i2c_driver);
+}
+/* init early so consumer devices can complete system boot */
+subsys_initcall(bd71837_i2c_init);
+
+static void __exit bd71837_i2c_exit(void)
+{
+	i2c_del_driver(&bd71837_i2c_driver);
+}
+module_exit(bd71837_i2c_exit);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD71837 chip multi-function driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/bd71837.h b/include/linux/mfd/bd71837.h
new file mode 100644
index 000000000000..10b0dfe90f27
--- /dev/null
+++ b/include/linux/mfd/bd71837.h
@@ -0,0 +1,391 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2018 ROHM Semiconductors */
+
+/*
+ * ROHM BD71837MWV header file
+ */
+
+#ifndef __LINUX_MFD_BD71837_H__
+#define __LINUX_MFD_BD71837_H__
+
+#include <linux/regmap.h>
+
+enum {
+	BD71837_BUCK1	=	0,
+	BD71837_BUCK2,
+	BD71837_BUCK3,
+	BD71837_BUCK4,
+	BD71837_BUCK5,
+	BD71837_BUCK6,
+	BD71837_BUCK7,
+	BD71837_BUCK8,
+	BD71837_LDO1,
+	BD71837_LDO2,
+	BD71837_LDO3,
+	BD71837_LDO4,
+	BD71837_LDO5,
+	BD71837_LDO6,
+	BD71837_LDO7,
+	BD71837_REGULATOR_CNT,
+};
+
+#define BD71837_BUCK1_VOLTAGE_NUM	0x40
+#define BD71837_BUCK2_VOLTAGE_NUM	0x40
+#define BD71837_BUCK3_VOLTAGE_NUM	0x40
+#define BD71837_BUCK4_VOLTAGE_NUM	0x40
+
+#define BD71837_BUCK5_VOLTAGE_NUM	0x08
+#define BD71837_BUCK6_VOLTAGE_NUM	0x04
+#define BD71837_BUCK7_VOLTAGE_NUM	0x08
+#define BD71837_BUCK8_VOLTAGE_NUM	0x40
+
+#define BD71837_LDO1_VOLTAGE_NUM	0x04
+#define BD71837_LDO2_VOLTAGE_NUM	0x02
+#define BD71837_LDO3_VOLTAGE_NUM	0x10
+#define BD71837_LDO4_VOLTAGE_NUM	0x10
+#define BD71837_LDO5_VOLTAGE_NUM	0x10
+#define BD71837_LDO6_VOLTAGE_NUM	0x10
+#define BD71837_LDO7_VOLTAGE_NUM	0x10
+
+enum {
+	BD71837_REG_REV                = 0x00,
+	BD71837_REG_SWRESET            = 0x01,
+	BD71837_REG_I2C_DEV            = 0x02,
+	BD71837_REG_PWRCTRL0           = 0x03,
+	BD71837_REG_PWRCTRL1           = 0x04,
+	BD71837_REG_BUCK1_CTRL         = 0x05,
+	BD71837_REG_BUCK2_CTRL         = 0x06,
+	BD71837_REG_BUCK3_CTRL         = 0x07,
+	BD71837_REG_BUCK4_CTRL         = 0x08,
+	BD71837_REG_BUCK5_CTRL         = 0x09,
+	BD71837_REG_BUCK6_CTRL         = 0x0A,
+	BD71837_REG_BUCK7_CTRL         = 0x0B,
+	BD71837_REG_BUCK8_CTRL         = 0x0C,
+	BD71837_REG_BUCK1_VOLT_RUN     = 0x0D,
+	BD71837_REG_BUCK1_VOLT_IDLE    = 0x0E,
+	BD71837_REG_BUCK1_VOLT_SUSP    = 0x0F,
+	BD71837_REG_BUCK2_VOLT_RUN     = 0x10,
+	BD71837_REG_BUCK2_VOLT_IDLE    = 0x11,
+	BD71837_REG_BUCK3_VOLT_RUN     = 0x12,
+	BD71837_REG_BUCK4_VOLT_RUN     = 0x13,
+	BD71837_REG_BUCK5_VOLT         = 0x14,
+	BD71837_REG_BUCK6_VOLT         = 0x15,
+	BD71837_REG_BUCK7_VOLT         = 0x16,
+	BD71837_REG_BUCK8_VOLT         = 0x17,
+	BD71837_REG_LDO1_VOLT          = 0x18,
+	BD71837_REG_LDO2_VOLT          = 0x19,
+	BD71837_REG_LDO3_VOLT          = 0x1A,
+	BD71837_REG_LDO4_VOLT          = 0x1B,
+	BD71837_REG_LDO5_VOLT          = 0x1C,
+	BD71837_REG_LDO6_VOLT          = 0x1D,
+	BD71837_REG_LDO7_VOLT          = 0x1E,
+	BD71837_REG_TRANS_COND0        = 0x1F,
+	BD71837_REG_TRANS_COND1        = 0x20,
+	BD71837_REG_VRFAULTEN          = 0x21,
+	BD71837_REG_MVRFLTMASK0        = 0x22,
+	BD71837_REG_MVRFLTMASK1        = 0x23,
+	BD71837_REG_MVRFLTMASK2        = 0x24,
+	BD71837_REG_RCVCFG             = 0x25,
+	BD71837_REG_RCVNUM             = 0x26,
+	BD71837_REG_PWRONCONFIG0       = 0x27,
+	BD71837_REG_PWRONCONFIG1       = 0x28,
+	BD71837_REG_RESETSRC           = 0x29,
+	BD71837_REG_MIRQ               = 0x2A,
+	BD71837_REG_IRQ                = 0x2B,
+	BD71837_REG_IN_MON             = 0x2C,
+	BD71837_REG_POW_STATE          = 0x2D,
+	BD71837_REG_OUT32K             = 0x2E,
+	BD71837_REG_REGLOCK            = 0x2F,
+	BD71837_REG_OTPVER             = 0xFF,
+	BD71837_MAX_REGISTER           = 0x100,
+};
+
+#define REGLOCK_PWRSEQ	0x1
+#define REGLOCK_VREG	0x10
+
+/* Generic BUCK control masks */
+#define BD71837_BUCK_SEL	0x02
+#define BD71837_BUCK_EN		0x01
+#define BD71837_BUCK_RUN_ON	0x04
+
+/* Generic LDO masks */
+#define BD71837_LDO_SEL		0x80
+#define BD71837_LDO_EN		0x40
+
+/* BD71837 BUCK ramp rate CTRL reg bits */
+#define BUCK_RAMPRATE_MASK	0xC0
+#define BUCK_RAMPRATE_10P00MV	0x0
+#define BUCK_RAMPRATE_5P00MV	0x1
+#define BUCK_RAMPRATE_2P50MV	0x2
+#define BUCK_RAMPRATE_1P25MV	0x3
+
+/* BD71837_REG_BUCK1_VOLT_RUN bits */
+#define BUCK1_RUN_MASK		0x3F
+#define BUCK1_RUN_DEFAULT	0x14
+
+/* BD71837_REG_BUCK1_VOLT_SUSP bits */
+#define BUCK1_SUSP_MASK		0x3F
+#define BUCK1_SUSP_DEFAULT	0x14
+
+/* BD71837_REG_BUCK1_VOLT_IDLE bits */
+#define BUCK1_IDLE_MASK		0x3F
+#define BUCK1_IDLE_DEFAULT	0x14
+
+/* BD71837_REG_BUCK2_VOLT_RUN bits */
+#define BUCK2_RUN_MASK		0x3F
+#define BUCK2_RUN_DEFAULT	0x1E
+
+/* BD71837_REG_BUCK2_VOLT_IDLE bits */
+#define BUCK2_IDLE_MASK		0x3F
+#define BUCK2_IDLE_DEFAULT	0x14
+
+/* BD71837_REG_BUCK3_VOLT_RUN bits */
+#define BUCK3_RUN_MASK		0x3F
+#define BUCK3_RUN_DEFAULT	0x1E
+
+/* BD71837_REG_BUCK4_VOLT_RUN bits */
+#define BUCK4_RUN_MASK		0x3F
+#define BUCK4_RUN_DEFAULT	0x1E
+
+/* BD71837_REG_BUCK5_VOLT bits */
+#define BUCK5_MASK		0x07
+#define BUCK5_DEFAULT		0x02
+
+/* BD71837_REG_BUCK6_VOLT bits */
+#define BUCK6_MASK		0x03
+#define BUCK6_DEFAULT		0x03
+
+/* BD71837_REG_BUCK7_VOLT bits */
+#define BUCK7_MASK		0x07
+#define BUCK7_DEFAULT		0x03
+
+/* BD71837_REG_BUCK8_VOLT bits */
+#define BUCK8_MASK		0x3F
+#define BUCK8_DEFAULT		0x1E
+
+/* BD71837_REG_IRQ bits */
+#define IRQ_SWRST		0x40
+#define IRQ_PWRON_S		0x20
+#define IRQ_PWRON_L		0x10
+#define IRQ_PWRON		0x08
+#define IRQ_WDOG		0x04
+#define IRQ_ON_REQ		0x02
+#define IRQ_STBY_REQ		0x01
+
+/* BD71837_REG_OUT32K bits */
+#define BD71837_OUT32K_EN	0x01
+
+/* BD71837 gated clock rate */
+#define BD71837_CLK_RATE 32768
+
+/* BD71837 irqs */
+enum {
+	BD71837_INT_STBY_REQ,
+	BD71837_INT_ON_REQ,
+	BD71837_INT_WDOG,
+	BD71837_INT_PWRBTN,
+	BD71837_INT_PWRBTN_L,
+	BD71837_INT_PWRBTN_S,
+	BD71837_INT_SWRST
+};
+
+/* BD71837 interrupt masks */
+#define BD71837_INT_SWRST_MASK		0x40
+#define BD71837_INT_PWRBTN_S_MASK	0x20
+#define BD71837_INT_PWRBTN_L_MASK	0x10
+#define BD71837_INT_PWRBTN_MASK		0x8
+#define BD71837_INT_WDOG_MASK		0x4
+#define BD71837_INT_ON_REQ_MASK		0x2
+#define BD71837_INT_STBY_REQ_MASK	0x1
+
+/* BD71837_REG_LDO1_VOLT bits */
+#define LDO1_MASK		0x03
+
+/* BD71837_REG_LDO1_VOLT bits */
+#define LDO2_MASK		0x20
+
+/* BD71837_REG_LDO3_VOLT bits */
+#define LDO3_MASK		0x0F
+
+/* BD71837_REG_LDO4_VOLT bits */
+#define LDO4_MASK		0x0F
+
+/* BD71837_REG_LDO5_VOLT bits */
+#define LDO5_MASK		0x0F
+
+/* BD71837_REG_LDO6_VOLT bits */
+#define LDO6_MASK		0x0F
+
+/* BD71837_REG_LDO7_VOLT bits */
+#define LDO7_MASK		0x0F
+
+/* Register write induced reset settings */
+
+/* Even though the bit zero is not SWRESET type we still want to write zero
+ * to it when changing type. Bit zero is 'SWRESET' trigger bit and if we
+ * write 1 to it we will trigger the action. So always write 0 to it when
+ * changning SWRESET action - no matter what we read from it.
+ */
+#define BD71837_SWRESET_TYPE_MASK 7
+#define BD71837_SWRESET_TYPE_DISABLED 0
+#define BD71837_SWRESET_TYPE_COLD 4
+#define BD71837_SWRESET_TYPE_WARM 6
+
+#define BD71837_SWRESET_RESET_MASK 1
+#define BD71837_SWRESET_RESET 1
+
+/* Poweroff state transition conditions */
+
+#define BD718XX_ON_REQ_POWEROFF_MASK 1
+#define BD718XX_SWRESET_POWEROFF_MASK 2
+#define BD718XX_WDOG_POWEROFF_MASK 4
+#define BD718XX_KEY_L_POWEROFF_MASK 8
+
+#define BD718XX_POWOFF_TO_SNVS 0
+#define BD718XX_POWOFF_TO_RDY 0xF
+
+#define BD718XX_POWOFF_TIME_MASK 0xF0
+enum {
+	BD718XX_POWOFF_TIME_5MS = 0,
+	BD718XX_POWOFF_TIME_10MS,
+	BD718XX_POWOFF_TIME_15MS,
+	BD718XX_POWOFF_TIME_20MS,
+	BD718XX_POWOFF_TIME_25MS,
+	BD718XX_POWOFF_TIME_30MS,
+	BD718XX_POWOFF_TIME_35MS,
+	BD718XX_POWOFF_TIME_40MS,
+	BD718XX_POWOFF_TIME_45MS,
+	BD718XX_POWOFF_TIME_50MS,
+	BD718XX_POWOFF_TIME_75MS,
+	BD718XX_POWOFF_TIME_100MS,
+	BD718XX_POWOFF_TIME_250MS,
+	BD718XX_POWOFF_TIME_500MS,
+	BD718XX_POWOFF_TIME_750MS,
+	BD718XX_POWOFF_TIME_1500MS
+};
+
+/* Poweron sequence state transition conditions */
+
+#define BD718XX_RDY_TO_SNVS_MASK 0xF
+#define BD718XX_SNVS_TO_RUN_MASK 0xF0
+
+#define BD718XX_PWR_TRIG_KEY_L 1
+#define BD718XX_PWR_TRIG_KEY_S 2
+#define BD718XX_PWR_TRIG_PMIC_ON 4
+#define BD718XX_PWR_TRIG_VSYS_UVLO 8
+#define BD718XX_RDY_TO_SNVS_SIFT 0
+#define BD718XX_SNVS_TO_RUN_SIFT 4
+
+
+#define BD718XX_PWRBTN_PRESS_DURATION_MASK 0xF
+
+/* Timeout value for detecting short press */
+
+enum {
+	BD718XX_PWRBTN_SHORT_PRESS_10MS = 0,
+	BD718XX_PWRBTN_SHORT_PRESS_500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_1000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_1500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_2000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_2500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_3000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_3500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_4000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_4500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_5000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_5500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_6000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_6500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_7000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_7500MS
+};
+
+/* Timeout value for detecting LONG press */
+
+enum {
+	BD718XX_PWRBTN_LONG_PRESS_10MS = 0,
+	BD718XX_PWRBTN_LONG_PRESS_1S,
+	BD718XX_PWRBTN_LONG_PRESS_2S,
+	BD718XX_PWRBTN_LONG_PRESS_3S,
+	BD718XX_PWRBTN_LONG_PRESS_4S,
+	BD718XX_PWRBTN_LONG_PRESS_5S,
+	BD718XX_PWRBTN_LONG_PRESS_6S,
+	BD718XX_PWRBTN_LONG_PRESS_7S,
+	BD718XX_PWRBTN_LONG_PRESS_8S,
+	BD718XX_PWRBTN_LONG_PRESS_9S,
+	BD718XX_PWRBTN_LONG_PRESS_10S,
+	BD718XX_PWRBTN_LONG_PRESS_11S,
+	BD718XX_PWRBTN_LONG_PRESS_12S,
+	BD718XX_PWRBTN_LONG_PRESS_13S,
+	BD718XX_PWRBTN_LONG_PRESS_14S,
+	BD718XX_PWRBTN_LONG_PRESS_15S
+};
+
+
+
+struct bd71837;
+struct bd71837_pmic;
+struct bd71837_clk;
+struct bd718xx_pwrkey;
+
+/*
+ * Board platform data may be used to initialize regulators.
+ */
+
+struct bd71837_board {
+	struct regulator_init_data *init_data[BD71837_REGULATOR_CNT];
+	int	gpio_intr;
+};
+
+struct bd71837 {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+	struct regmap *regmap;
+	unsigned long int id;
+
+	int chip_irq;
+	struct regmap_irq_chip_data *irq_data;
+
+	struct bd71837_pmic *pmic;
+	struct bd71837_clk *clk;
+	struct bd718xx_pwrkey *pwrkey;
+};
+
+/*
+ * bd71837 sub-driver chip access routines
+ */
+
+static inline int bd71837_reg_read(struct bd71837 *bd71837, u8 reg)
+{
+	int r, val;
+
+	r = regmap_read(bd71837->regmap, reg, &val);
+	if (r < 0)
+		return r;
+	return val;
+}
+
+static inline int bd71837_reg_write(struct bd71837 *bd71837, u8 reg,
+				    unsigned int val)
+{
+	return regmap_write(bd71837->regmap, reg, val);
+}
+
+static inline int bd71837_set_bits(struct bd71837 *bd71837, u8 reg, u8 mask)
+{
+	return regmap_update_bits(bd71837->regmap, reg, mask, mask);
+}
+
+static inline int bd71837_clear_bits(struct bd71837 *bd71837, u8 reg,
+				     u8 mask)
+{
+	return regmap_update_bits(bd71837->regmap, reg, mask, 0);
+}
+
+static inline int bd71837_update_bits(struct bd71837 *bd71837, u8 reg,
+				      u8 mask, u8 val)
+{
+	return regmap_update_bits(bd71837->regmap, reg, mask, val);
+}
+
+#endif /* __LINUX_MFD_BD71837_H__ */
-- 
2.14.3

