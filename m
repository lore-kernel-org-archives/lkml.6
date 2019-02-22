Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD8DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BCB2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfBVJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:54:40 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfBVJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:54:37 -0500
Received: from orion.localdomain ([77.7.125.227]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZTyi-1gZRqt1ZrS-00WWZw; Fri, 22 Feb 2019 10:54:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, dvhart@infradead.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
Date:   Fri, 22 Feb 2019 10:54:16 +0100
Message-Id: <1550829256-8831-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550829256-8831-1-git-send-email-info@metux.net>
References: <1550181897-2596-1-git-send-email-info@metux.net>
 <1550829256-8831-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:dgzFHC8Zs5d74FoGh1wTQp0uQpGqdS078Wo5zQQzU1sUfnP0jGC
 RNuFmZD3IcIiwEHjLvWCdosiOQIPTz97lwaDdMdMe+FPQlUgSQbkI6Ml5E5WPlZap72/gPg
 q/LC3CiUZRMrrUu51HlweMCp0MD7ZObpV4sC9Oa5x7nIMTz+ke3DCRyVZDbjwJGSIf86xwS
 zQvtxSEJrIX7nww2GGcFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y5L92DNN2yA=:uip4I83a4wwCokYuQ4PEJH
 SoOXjSmfQH2aLBSM51bi1K/2IG2LPS55+djIzAKVXlwY6gmw0hx4gSgwbvg1XyIFVzERdNk53
 b9XzailnL1kNzBiXft7QeqlM/wH1nbr0arZvN/NIv6sHxLTSHo17YACS2+17SKpnNITdtNuWo
 9KcqH301HIL4YFCosc7n3Qt4Cnb0sLCTU6xwgs8EUURwE9way5HS6mgk8MnNX1sDUVoUwiLDc
 UhevEQjRbZAZGhK/sGmgvIcHt0XMlOvDFgN22dKToq+kjTt6/q1mF2f/YtGarDbgfdQFbUZwG
 qoUOZ/OQkt+H6M44Muo7dQaBs4+V16j0/Rv/xalOqtYIHIeIrUgJYXUaY1DFlB8NrXp7SNzr9
 cXqJbiH9/iiljZm/v3CNncv+ImLj0nTIhIgxqkn/a2MK4taBk+eM67M1API8NdmxnzLN+m+tv
 g3NX0ap9zZYLq0eAs97gk0dsvDjA/J2/oOoMJmYdCvzQ3HnQYQQ01YOntBX99xtK9tune3+Zl
 pQIlpGXFRrz/Q2se2S311mJsBzXQvNT/kFzrimjXepN+FTHorxennSCfhjEkH5ixNpFeJVq6h
 b9cFWs5Ou9jgMC0x6rIJOSdYcz2kNwI3S0Uos1IhdW1LjXyg3n0CcQKwVLuBo6e1gL1vLuoyL
 vC2ltMMy+MTgikmON3E9l04yHlFyzBYEOOXE0Z7YT6+ZeS5tW8fd0u3gbaN/5o4t+O+nLKaUW
 mlsgPqV1YfjOSZK3EQfDffj/R9i6kCvJQFS9Rw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for PCengines APUv2 board's front LEDs and Button,
which are attached to AMD PCH GPIOs. Due to lack of dedicated
ACPI entry, detecting the board via DMI.

Cc: linux-gpio@vger.kernel.org
Cc: linus.walleij@linaro.org
Cc: bgolaszewski@baylibre.com
Cc: dvhart@infradead.org
Cc: andy@infradead.org
Cc: platform-driver-x86@vger.kernel.org

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS                            |   5 +
 drivers/platform/x86/Kconfig           |  12 ++
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/pcengines-apuv2.c | 261 +++++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/platform/x86/pcengines-apuv2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d286e7d..d39e029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11522,6 +11522,11 @@ F:	lib/parman.c
 F:	lib/test_parman.c
 F:	include/linux/parman.h
 
+PC ENGINES APU BOARD DRIVER
+M:	Enrico Weigelt, metux IT consult <info@metux.net>
+S:	Maintained
+F:	drivers/platform/x86/pcengines-apuv2.c
+
 PC87360 HARDWARE MONITORING DRIVER
 M:	Jim Cromie <jim.cromie@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b5e9db8..851ea92 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1303,6 +1303,18 @@ config HUAWEI_WMI
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
 
+config PCENGINES_APU2
+	tristate "PC Engines APUv2/3 front button and LEDs driver"
+	select GPIO_AMD_FCH
+	select KEYBOARD_GPIO_POLLED
+	select LEDS_GPIO
+	help
+	  This driver provides support for the front button and LEDs on
+	  PC Engines APUv2/APUv3 board.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pcengines-apuv2.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ce8da26..86cb766 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -96,3 +96,4 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)	+= intel_atomisp2_pm.o
+obj-$(CONFIG_PCENGINES_APU2)	+= pcengines-apuv2.o
diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
new file mode 100644
index 0000000..dcb084f
--- /dev/null
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * PC-Engines APUv2/APUv3 board platform driver
+ * for gpio buttons and LEDs
+ *
+ * Copyright (C) 2018 metux IT consult
+ * Author: Enrico Weigelt <info@metux.net>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
+#include <linux/input.h>
+#include <linux/platform_data/gpio/gpio-amd-fch.h>
+
+/*
+ * NOTE: this driver only supports APUv2/3 - not APUv1, as this one
+ * has completely different register layouts
+ */
+
+/* register mappings */
+#define APU2_GPIO_REG_LED1		AMD_FCH_GPIO_REG_GPIO57
+#define APU2_GPIO_REG_LED2		AMD_FCH_GPIO_REG_GPIO58
+#define APU2_GPIO_REG_LED3		AMD_FCH_GPIO_REG_GPIO59_DEVSLP1
+#define APU2_GPIO_REG_MODESW		AMD_FCH_GPIO_REG_GPIO32_GE1
+#define APU2_GPIO_REG_SIMSWAP		AMD_FCH_GPIO_REG_GPIO33_GE2
+
+/* order in which the gpio lines are defined in the register list */
+#define APU2_GPIO_LINE_LED1		0
+#define APU2_GPIO_LINE_LED2		1
+#define APU2_GPIO_LINE_LED3		2
+#define APU2_GPIO_LINE_MODESW		3
+#define APU2_GPIO_LINE_SIMSWAP		4
+
+/* gpio device */
+
+static int apu2_gpio_regs[] = {
+	[APU2_GPIO_LINE_LED1]		= APU2_GPIO_REG_LED1,
+	[APU2_GPIO_LINE_LED2]		= APU2_GPIO_REG_LED2,
+	[APU2_GPIO_LINE_LED3]		= APU2_GPIO_REG_LED3,
+	[APU2_GPIO_LINE_MODESW]		= APU2_GPIO_REG_MODESW,
+	[APU2_GPIO_LINE_SIMSWAP]	= APU2_GPIO_REG_SIMSWAP,
+};
+
+static const char * const apu2_gpio_names[] = {
+	[APU2_GPIO_LINE_LED1]		= "front-led1",
+	[APU2_GPIO_LINE_LED2]		= "front-led2",
+	[APU2_GPIO_LINE_LED3]		= "front-led3",
+	[APU2_GPIO_LINE_MODESW]		= "front-button",
+	[APU2_GPIO_LINE_SIMSWAP]	= "simswap",
+};
+
+static const struct amd_fch_gpio_pdata board_apu2 = {
+	.gpio_num	= ARRAY_SIZE(apu2_gpio_regs),
+	.gpio_reg	= apu2_gpio_regs,
+	.gpio_names	= apu2_gpio_names,
+};
+
+/* gpio leds device */
+
+static const struct gpio_led apu2_leds[] = {
+	{ .name = "apu:green:1" },
+	{ .name = "apu:green:2" },
+	{ .name = "apu:green:3" }
+};
+
+static const struct gpio_led_platform_data apu2_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(apu2_leds),
+	.leds		= apu2_leds,
+};
+
+struct gpiod_lookup_table gpios_led_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED1,
+				NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED2,
+				NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
+				NULL, 2, GPIO_ACTIVE_LOW),
+	}
+};
+
+/* gpio keyboard device */
+
+static struct gpio_keys_button apu2_keys_buttons[] = {
+	{
+		.code			= KEY_SETUP,
+		.active_low		= 1,
+		.desc			= "front button",
+		.type			= EV_KEY,
+		.debounce_interval	= 10,
+		.value			= 1,
+	},
+};
+
+static const struct gpio_keys_platform_data apu2_keys_pdata = {
+	.buttons	= apu2_keys_buttons,
+	.nbuttons	= ARRAY_SIZE(apu2_keys_buttons),
+	.poll_interval	= 100,
+	.rep		= 0,
+	.name		= "apu2-keys",
+};
+
+struct gpiod_lookup_table gpios_key_table = {
+	.dev_id = "gpio-keys-polled",
+	.table = {
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_MODESW,
+				NULL, 0, GPIO_ACTIVE_LOW),
+	}
+};
+
+/* board setup */
+
+/* note: matching works on string prefix, so "apu2" must come before "apu" */
+static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
+
+	/* APU2 w/ legacy bios < 4.0.8 */
+	{
+		.ident		= "apu2",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU2")
+		},
+		.driver_data	= (void *)&board_apu2,
+	},
+	/* APU2 w/ legacy bios >= 4.0.8 */
+	{
+		.ident		= "apu2",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu2")
+		},
+		.driver_data	= (void *)&board_apu2,
+	},
+	/* APU2 w/ maainline bios */
+	{
+		.ident		= "apu2",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
+		},
+		.driver_data	= (void *)&board_apu2,
+	},
+
+	/* APU3 w/ legacy bios < 4.0.8 */
+	{
+		.ident		= "apu3",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU3")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	/* APU3 w/ legacy bios >= 4.0.8 */
+	{
+		.ident       = "apu3",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu3")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	/* APU3 w/ mainline bios */
+	{
+		.ident       = "apu3",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	{}
+};
+
+static struct platform_device *apu_gpio_pdev;
+static struct platform_device *apu_leds_pdev;
+static struct platform_device *apu_keys_pdev;
+
+static struct platform_device * __init apu_create_pdev(
+	const char *name,
+	const void *pdata,
+	size_t sz)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_resndata(NULL,
+		name,
+		PLATFORM_DEVID_NONE,
+		NULL,
+		0,
+		pdata,
+		sz);
+
+	if (IS_ERR(pdev))
+		pr_err("failed registering %s: %ld\n", name, PTR_ERR(pdev));
+
+	return pdev;
+}
+
+static int __init apu_board_init(void)
+{
+	int rc;
+	const struct dmi_system_id *id;
+
+	id = dmi_first_match(apu_gpio_dmi_table);
+	if (!id) {
+		pr_err("failed to detect apu board via dmi\n");
+		return -ENODEV;
+	}
+
+	gpiod_add_lookup_table(&gpios_led_table);
+	gpiod_add_lookup_table(&gpios_key_table);
+
+	apu_gpio_pdev = apu_create_pdev(
+		AMD_FCH_GPIO_DRIVER_NAME,
+		id->driver_data,
+		sizeof(struct amd_fch_gpio_pdata));
+
+	apu_leds_pdev = apu_create_pdev(
+		"leds-gpio",
+		&apu2_leds_pdata,
+		sizeof(apu2_leds_pdata));
+
+	apu_keys_pdev = apu_create_pdev(
+		"gpio-keys-polled",
+		&apu2_keys_pdata,
+		sizeof(apu2_keys_pdata));
+
+	return 0;
+}
+
+static void __exit apu_board_exit(void)
+{
+	gpiod_remove_lookup_table(&gpios_led_table);
+	gpiod_remove_lookup_table(&gpios_key_table);
+
+	platform_device_unregister(apu_keys_pdev);
+	platform_device_unregister(apu_leds_pdev);
+	platform_device_unregister(apu_gpio_pdev);
+}
+
+module_init(apu_board_init);
+module_exit(apu_board_exit);
+
+MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
+MODULE_DESCRIPTION("PC Engines APUv2/APUv3 board GPIO/LED/keys driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(dmi, apu_gpio_dmi_table);
+MODULE_ALIAS("platform:pcengines-apuv2");
+MODULE_SOFTDEP("pre: platform:" AMD_FCH_GPIO_DRIVER_NAME);
+MODULE_SOFTDEP("pre: platform:leds-gpio");
+MODULE_SOFTDEP("pre: platform:gpio_keys_polled");
-- 
1.9.1

