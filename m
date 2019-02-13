Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21080C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD48F222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394662AbfBMU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:57:49 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389499AbfBMU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:57:47 -0500
Received: from orion.localdomain ([77.7.10.70]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpTpc-1hPqBy0jCW-00pxUV; Wed, 13 Feb 2019 21:57:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, andy@infradead.org,
        dvhart@infradead.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
Date:   Wed, 13 Feb 2019 21:57:28 +0100
Message-Id: <1550091448-28578-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550091448-28578-1-git-send-email-info@metux.net>
References: <1550091448-28578-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:KcqktqNrRhOAV+LAl+TSi5K9Rf2fFUNmjMgIUTyUjPIjhHY/TXC
 GRHFMsEwFll7g4eoCVp8ILnoztD3dv/7nsuvXrvBpuQ1A4vv4XYYT52WGdzAIv3GY8tFPNQ
 Hyq+L8WeGvU94j4tYNO+5G8PZbXEnhbORrUEk4CJXam6RerP9TwnB8dnQLZZj9TNAAY/CGu
 YxKbiixBOzivpwTfJdUPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kNBvWHRg4Eo=:pdjbQ8ZYCIkKoJ/OOnXvZ0
 moa9GwAxdmIQyrkUJnqht4h/CVh1HQNhfiLxiLzLCJm4/UVhbVwVGasvDCjv9V65aiCHrmiok
 P99U8TP7FIwrFq0Ip7RC1O0wgL2q/PnvLhI7RBtoejiqUXCqSirchn27v4/NZC+HqsRfwWGPU
 1Rk055KSMJpwMzI3s3S6F7IBFa5Pv5T/2vssf+vytdz57kwY1YComf4xEoJPRTtu90gE5zcvA
 8Vp22WCcmAXe2E0EvPENwRbCKwTr9jl9sSwpz6pY5iOzmCGxSgzvuVy4j5UoG7wIH0LG3NPUg
 2Pp0dDD3EJeZz3WFG2d+i2Z5auPeK6iX+I0bhJmcd7Cdxw+bULXmgfjhNn6tVIE9pYHUh8sMf
 6aCaGtNuTXIeluMggPECWnxtYRd1pWo0XirwWoGIhd9s57SqZIWjoST7pWCIARvB8IZrlzR8+
 4XzM+bHrPoUBNuGTQ6S0ZkQPQEEZ6rvLPMfa9+C6OuELyBaM1Fh48GKWWCeRMlHSeM9xKVuZr
 dxiYe5oc3KrJHQ5ZShoB9MHuXC3nDnvyJqYM5rBHTB4KD6UJuTJ+VqE6sfV2KReoY8YI+IgFo
 gGVS0OMiPJd3lHvzrQn1g5RrQ4lKOesSsNzUSQ/Z3j0VXYN9GoGSnOxRkXyVMsA0iVs11HOTG
 yow11zsJSl5hRvWZyQo5LGZoBnD3qONlFWIUg5jGr3WOHEwtRkmzLC845IVyah+z2XqseNdO4
 yRqQvm9JMB9uBBPsYvOlDVNfV0NoUUpOv32AsA==
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

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS                            |   5 +
 drivers/platform/x86/Kconfig           |  13 ++
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/pcengines-apuv2.c | 259 +++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+)
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
index b5e9db8..10e78ad 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1303,6 +1303,19 @@ config HUAWEI_WMI
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
 
+config PCENGINES_APU2
+	tristate "PC Engines APUv2/3 front button and LEDs driver"
+	select GPIO_AMD_FCH
+	select KEYBOARD_GPIO
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
index 0000000..a8e8b0f
--- /dev/null
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -0,0 +1,259 @@
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
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/init.h>
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
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED1, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED2, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3, NULL, 2, GPIO_ACTIVE_LOW),
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
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_MODESW, NULL, 0, GPIO_ACTIVE_LOW),
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
+	const char* name,
+	const void *pdata,
+	size_t sz)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_resndata(
+		NULL,			/* parent */
+		name,			/* name */
+		PLATFORM_DEVID_NONE,	/* id */
+		NULL,			/* res */
+		0,			/* res_num */
+		pdata,			/* platform_data */
+		sz);
+
+	if (IS_ERR(pdev))
+		pr_err(KBUILD_MODNAME ": failed registering %s: %ld\n", name, PTR_ERR(pdev));
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
+
+	if (!id) {
+		pr_err(KBUILD_MODNAME ": failed to detect apu board via dmi\n");
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
+	pr_info(KBUILD_MODNAME ": initialized: gpio, leds, keys\n");
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

