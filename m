Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1EAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0121904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGRON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:14:13 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:46479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:14:13 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhUDj-1hNZI83qr5-00edGg; Thu, 07 Feb 2019 18:14:03 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, platform-driver-x86@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org
Subject: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
Date:   Thu,  7 Feb 2019 18:13:59 +0100
Message-Id: <1549559639-9447-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549559639-9447-1-git-send-email-info@metux.net>
References: <1549559639-9447-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:chp6BNjdmpP0zuddh30DVFEOv+AxTlniLB03nIpxx1/fpMaIc05
 JGo+07lnXY0K9s96qKTbZ+PLzElxM8LMmvf3VmnetNpWxEkTmhZspM5g86nJg0te1p3Vm16
 ztVH0WAX5amQBA4VFF67DJCxyDBt0YZuvMJyDR2BiHkcWYS/S1SLYnICpBVwyWUOhOUyBW8
 fLJ162Jkf0eSM/kqNpsXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sixnHSG06TU=:rv6tshJYqaHKjQ0iUAn4rh
 Nbyn8HlUXMidhRzNfbsO7EYDTewKxJHIvwST5kgfl2cayE9rNC42/SbsUxlDY8pB9JWZp8JKN
 YoG3LS4qdkIQGYdT8iXaRqLGmd8Sw50elY3DUd0/p8vRsn+oHscOCpkVe7pF+vH2AG2vtAiDl
 /9aEf6QXw0vY1LgC/IMPqbv3vjUv+81gkfjyVVF7oUGk8yyjrgT1DFy9waWSOLCUX4N9LGSNH
 yjbOdEOHWIVvffA7hysiz4zw5nzXZb9UblgeRB4MX3EG/50CJ6r/EoXcwyUs2No/T5QyaDGn1
 Dk/xpJ+8E0G6Nvu1082z++t+dv6uuulD48jbrPT5dF4mM/4k8Fvb4UQawzwD4snoRLMIHUbup
 TdCQhjjrIbP93lE8K9vnFR/8ShYB9+vCrnquR8UJ7VQL/IQc/3dDijJL+hjThj4CovLV9W/sn
 EABwvX22m4yxASdpa9fZycESO3YZ7A5qxx3yzaxh9VBkYnx4P5rF3v+CxjIgv9+LSoCkdJs2y
 +EcFlL/rXWeCxIUMF90XvrTRNqmMWNUi3kZU/V7MQCFvyGLQ8kLCyDjB/FqMhCmLS9yJmdVFs
 3JcMCA5yttuy4vstQueulcnCXLYIQ/55t/dLimbASB+JSiKqwx2Ob1vU+XbaQk2PepbunrmeO
 ma6aDfEuuUCbWBfdtrBLuf8nSwch36AaNw1cSXCYHujMj1wuTbOhZaQ1zeQrVWjNE0u3UxxMD
 5BiQR7fqY2iZyfaowAPWne/ub0GHEgB8YFCITA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for PCengines APUv2 board that supports GPIOs via AMD PCH
and attached LEDs and keys.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS                            |   5 +
 drivers/platform/x86/Kconfig           |   9 ++
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/pcengines-apuv2.c | 263 +++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 drivers/platform/x86/pcengines-apuv2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a693f39..2bdc975 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11515,6 +11515,11 @@ F:	lib/parman.c
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
index b5e9db8..e424643 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1303,6 +1303,15 @@ config HUAWEI_WMI
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
 
+config PCENGINES_APU2
+	tristate "LEDs and buttons driver forPC Engines APUv2 board"
+	depends on GPIO_AMD_FCH
+	depends on KEYBOARD_GPIO
+	depends on KEYBOARD_GPIO_POLLED
+	depends on LEDS_GPIO
+	---help---
+	  This options adds APUv2 board support for LEDs and keys
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
index 0000000..9bb89d6
--- /dev/null
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -0,0 +1,263 @@
+/*
+ * PC-Engines APUv2 board platform driver for gpio buttons and LEDs
+ *
+ * Copyright (C) 2018 metux IT consult
+ * Author: Enrico Weigelt <info@metux.net>
+ */
+
+// SPDX-License-Identifier: GPL+
+
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/platform_data/x86/amd-fch-gpio-pdata.h>
+
+/* TODO
+   * support apu1 board (different fch, different register layouts
+   * add spinlocks
+*/
+
+#define FCH_ACPI_MMIO_BASE	0xFED80000
+#define FCH_GPIO_OFFSET		0x1500
+#define FCH_GPIO_SIZE		0x300
+
+#define GPIO_BASE		100
+
+#define GPIO_LED1		(GPIO_BASE+0)
+#define GPIO_LED2		(GPIO_BASE+1)
+#define GPIO_LED3		(GPIO_BASE+2)
+#define GPIO_MODESW		(GPIO_BASE+3)
+#define GPIO_SIMSWAP		(GPIO_BASE+4)
+
+struct board_data {
+	const char		*name;
+	struct resource		res;
+	int			gpio_num;
+	int			gpio_base;
+	struct amd_fch_gpio_reg	*gpio_regs;
+};
+
+static const struct gpio_led apu2_leds[] /* __initconst */ = {
+	{ .name = "apu:green:1", .gpio = GPIO_LED1, .active_low = 1, },
+	{ .name = "apu:green:2", .gpio = GPIO_LED2, .active_low = 1, },
+	{ .name = "apu:green:3", .gpio = GPIO_LED3, .active_low = 1, }
+};
+
+static const struct gpio_led_platform_data apu2_leds_pdata /* __initconst */ = {
+	.num_leds	= ARRAY_SIZE(apu2_leds),
+	.leds		= apu2_leds,
+};
+
+static struct amd_fch_gpio_reg apu2_gpio_regs[] = {
+	{ 0x44 }, // GPIO_57 -- LED1
+	{ 0x45 }, // GPIO_58 -- LED2
+	{ 0x46 }, // GPIO_59 -- LED3
+	{ 0x59 }, // GPIO_32 -- LED4 -- GE32 -- #modesw
+	{ 0x5A }, // GPIO_33 -- LED5 -- GE33 -- simswap
+	{ 0x42 }, // GPIO_51 -- LED6
+	{ 0x43 }, // GPIO_55 -- LED7
+	{ 0x47 }, // GPIO_64 -- LED8
+	{ 0x48 }, // GPIO_68 -- LED9
+	{ 0x4C }, // GPIO_70 -- LED10
+};
+
+static struct gpio_keys_button apu2_keys_buttons[] = {
+	{
+		.code			= KEY_A,
+		.gpio			= GPIO_MODESW,
+		.active_low		= 1,
+		.desc			= "modeswitch",
+		.type			= EV_KEY, /* or EV_SW ? */
+		.debounce_interval	= 10,
+		.value			= 1,
+	}
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
+static const struct amd_fch_gpio_pdata board_apu2 = {
+	.res		= DEFINE_RES_MEM_NAMED(FCH_ACPI_MMIO_BASE + FCH_GPIO_OFFSET,
+					       FCH_GPIO_SIZE,
+					       "apu2-gpio-iomem"),
+	.gpio_num	= ARRAY_SIZE(apu2_gpio_regs),
+	.gpio_reg	= apu2_gpio_regs,
+	.gpio_base	= GPIO_BASE,
+};
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
+		.driver_data	= (void*)&board_apu2,
+	},
+	/* APU2 w/ legacy bios >= 4.0.8 */
+	{
+		.ident		= "apu2",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu2")
+		},
+		.driver_data	= (void*)&board_apu2,
+	},
+	/* APU2 w/ maainline bios */
+	{
+		.ident		= "apu2",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
+		},
+		.driver_data	= (void*)&board_apu2,
+	},
+
+	/* APU3 w/ legacy bios < 4.0.8 */
+	{
+		.ident		= "apu3",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU3")
+		},
+		.driver_data = (void*)&board_apu2,
+	},
+	/* APU3 w/ legacy bios >= 4.0.8 */
+	{
+		.ident       = "apu3",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu3")
+		},
+		.driver_data = (void*)&board_apu2,
+	},
+	/* APU3 w/ mainline bios */
+	{
+		.ident       = "apu3",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
+		},
+		.driver_data = (void*)&board_apu2,
+	},
+
+	/* APU1 */
+	/* not supported yet - the register set is pretty different
+	{
+		.ident       = "apu",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "APU")
+		},
+		.driver_data = (void*)&board_apu1,
+	},
+	*/
+	{}
+};
+
+static struct platform_device *apu_gpio_pdev = NULL;
+static struct platform_device *apu_leds_pdev = NULL;
+static struct platform_device *apu_keys_pdev = NULL;
+
+static int __init apu_gpio_init(void)
+{
+	int rc;
+	const struct dmi_system_id *dmi = dmi_first_match(apu_gpio_dmi_table);
+
+	if (!dmi) {
+		pr_err(KBUILD_MODNAME ": failed to detect apu board via dmi\n");
+		return -ENODEV;
+	}
+
+	pr_info(KBUILD_MODNAME ": registering gpio\n");
+	if (IS_ERR(apu_gpio_pdev = platform_device_register_resndata(
+			NULL,					/* parent */
+			AMD_FCH_GPIO_DRIVER_NAME,		/* name */
+			-1,					/* id */
+			NULL,					/* res */
+			0,					/* res_num */
+			dmi->driver_data,			/* platform_data */
+			sizeof(struct amd_fch_gpio_pdata)))) {
+		pr_err(KBUILD_MODNAME ": failed registering gpio device\n");
+		rc = PTR_ERR(apu_gpio_pdev);
+		goto fail;
+	}
+
+	pr_info(KBUILD_MODNAME ": registering leds\n");
+	if (IS_ERR(apu_leds_pdev = platform_device_register_resndata(
+			NULL,					/* parent */
+			"leds-gpio",				/* driver name */
+			-1,					/* id */
+			NULL,					/* res */
+			0,					/* ren_num */
+			&apu2_leds_pdata,			/* platform data */
+			sizeof(apu2_leds_pdata)))) {
+		pr_err(KBUILD_MODNAME ": failed registering leds device\n");
+		rc = PTR_ERR(apu_leds_pdev);
+		goto fail;
+	}
+
+	pr_info(KBUILD_MODNAME ": registering keys\n");
+	if (IS_ERR(apu_keys_pdev = platform_device_register_resndata(
+			NULL,					/* parent */
+			"gpio-keys-polled",			/* driver name */
+			-1,					/* id */
+			NULL,					/* res */
+			0,					/* res_num */
+			&apu2_keys_pdata,			/* platform_data */
+			sizeof(apu2_keys_pdata)))) {
+		pr_err(KBUILD_MODNAME ": failed registering keys device\n");
+		rc = PTR_ERR(apu_keys_pdev);
+		goto fail;
+	}
+
+	pr_info(KBUILD_MODNAME ": initialized: gpio, leds, keys\n");
+	return 0;
+
+fail:
+	if (!IS_ERR(apu_keys_pdev))
+		platform_device_unregister(apu_keys_pdev);
+	if (!IS_ERR(apu_leds_pdev))
+		platform_device_unregister(apu_leds_pdev);
+	if (!IS_ERR(apu_gpio_pdev))
+		platform_device_unregister(apu_gpio_pdev);
+
+	pr_err(KBUILD_MODNAME ": probe FAILED: %d\n", rc);
+	return rc;
+}
+
+static void __exit apu_gpio_exit(void)
+{
+	if (!IS_ERR(apu_keys_pdev))
+		platform_device_unregister(apu_keys_pdev);
+	if (!IS_ERR(apu_leds_pdev))
+		platform_device_unregister(apu_leds_pdev);
+	if (!IS_ERR(apu_gpio_pdev))
+		platform_device_unregister(apu_gpio_pdev);
+}
+
+module_init(apu_gpio_init);
+module_exit(apu_gpio_exit);
+
+MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
+MODULE_DESCRIPTION("PC Engines APUv2 board GPIO/LED/keys driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(dmi, apu_gpio_dmi_table);
+MODULE_ALIAS("platform:apu-board");
+MODULE_SOFTDEP("pre: gpio_amd_fch");
+MODULE_SOFTDEP("pre: gpio_keys");
+MODULE_SOFTDEP("pre: gpio_keys_polled");
-- 
1.9.1

