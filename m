Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06470C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B944D21B1C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406306AbfBNWFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:05:22 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbfBNWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:05:18 -0500
Received: from orion.localdomain ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUrM-1hCLUC2kCo-00rZfQ; Thu, 14 Feb 2019 23:05:10 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
Date:   Thu, 14 Feb 2019 23:04:57 +0100
Message-Id: <1550181897-2596-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550181897-2596-1-git-send-email-info@metux.net>
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <1550181897-2596-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:BUEoMG+S8FgSPfPC/M8LX9r6D2NC4ysqCZqPFzTfvlGqn2sBNfx
 SscWmd/AFKpwVtio5VeFsaaGXrSxeG3z+BC+T0GXvKncGlDTuninSNg/Rs57xzbDwg5O/zy
 mp8ChoKTSEu3s31nI2mFqeXa19J8zG2H5eh5nDXwo0TcoLOxSFsVgBDnTYzIPNmJunr9Ori
 cK/Oq9m6FeDWmv3ypqCrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wWjIaPYpngM=:8xhcyu/a09xmV2DBnHriOY
 9896LOXUqrWp/9x1BhtZLM4DjTdUgDFbaRp+5HVgb+FDpQRufpYVWn0DXn9e1WU67uez5Ho0F
 tax0glA+nYRdB7xn9AEkJ50EYssBocDrSK2EhIJU2uWydtjnD0n+1gxZeXnfMMHIFZbtauOs3
 gA9VK0y87WFSpLKxlHRn+bfDDqJ6wllyAjOsBQg25vSMwsp3oWp20jxqSh0Xa2mu2sps638vf
 6xq1q2jvLOWkR04+exNie5JVCxezqQscTMyhv8BLg/4Nrev3AvmLIUKwqd2QvQi0FCB1x9nHH
 osm5UHehILRvk0+0bAwHuNk8LThC8h64ev6twM1z8q6dkMsqx3zNQDqbQX0Z/ai/EJwvf5Obm
 4hNI8RhLXaZpKyaj4b1RhJxtD5O1LpBcoYhu1z49qlBgIOVErJ+GobUrHrQaP7NYGN6vEXSQy
 Qd/BpIiVhg7I4Rg9VDdrBSMQDBDYxSz3pqy1SkMAQBYCLHVxoYMHfjrLqd7M6256ilGWOlWzy
 iM9vrSwLvDy+0inbOtr+YQyPsTX6o6yTvlUI0LMI4kmUWUMThToo/2prvpiy0VNpA/kqsc0IW
 eDQH6FB838uLRIYTbnfGMy1odD/tDcCMSlJNBHxm2Y02X+51FAezswBj0nAWepxzYS+g81scl
 skDDWtBfVM34eZN+gLc+Mr0+h9eyJOC9UTPtV6x9SW/H6urHXF7n7ZpdjG54aJ6xOfZWNAeVk
 hR6vlgBe0CzuK37kQZx2Dd+TY1slNQ8v6vYV7Q==
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

