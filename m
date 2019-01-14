Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287E420656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467320;
	bh=Bbltba+1q+XJihey6tUCesGgpzOwP00QIY4Bt1AriM0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=v32P4qRwGutDcaQSeJrp/OmnkDx4wW1Zr/Ya0RZnmHZCoYoJUnrDzSGOQdZVUSu8B
	 p2DTABnNgJjadVtyd4/g7sBX9TXtmOvEXnCn6TFvCYEf5g94p9UmUZdbILid6+d92j
	 2xrVIj+APsW2RF0P8f/atLO+UwB/PBH8HlE97jc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfANMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfANMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zAUnEncPZP6Z3T0a5RhsLVK8EbjoCNeIBnv0Z5PULe0=; b=i+MiUlbm4ve2
        BreS8Umz5ACV6d3urYZ0u9uvyrbFpP1EJDKx8Abkku77wl7HmQiK6nq64z6hOgC2BpIL1Yrdl3j8a
        z4Bjk0vN7csSLwE7wSO4YglR1MDoQDWHub6Vn9hTCo2nWXuKJ6pPzfdwMQACKtmM02jpvDldXrZpr
        9khvs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vk-0004tN-7V; Mon, 14 Jan 2019 12:01:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DB7CB1127AD1; Mon, 14 Jan 2019 12:01:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: fixed/gpio: Pull inversion/OD into gpiolib" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120123.DB7CB1127AD1@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fixed/gpio: Pull inversion/OD into gpiolib

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b966ebb86bae4046bc8ce0ecc9efd6df42e3d260 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Jan 2019 17:27:43 +0100
Subject: [PATCH] regulator: fixed/gpio: Pull inversion/OD into gpiolib

This pushes the handling of inversion semantics and open drain
settings to the GPIO descriptor and gpiolib. All affected board
files are also augmented.

This is especially nice since we don't have to have any
confusing flags passed around to the left and right littering
the fixed and GPIO regulator drivers and the regulator core.
It is all just very straight-forward: the core asks the GPIO
line to be asserted or deasserted and gpiolib deals with the
rest depending on how the platform is configured: if the line
is active low, it deals with that, if the line is open drain,
it deals with that too.

Cc: Alexander Shiyan <shc_work@mail.ru> # i.MX boards user
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> # MMP2 maintainer
Cc: Aaro Koskinen <aaro.koskinen@iki.fi> # OMAP1 maintainer
Cc: Tony Lindgren <tony@atomide.com> # OMAP1,2,3 maintainer
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com> # EM-X270 maintainer
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # EZX maintainer
Cc: Philipp Zabel <philipp.zabel@gmail.com> # Magician maintainer
Cc: Petr Cvek <petr.cvek@tul.cz> # Magician
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # PXA
Cc: Paul Parsons <lost.distance@yahoo.com> # hx4700
Cc: Daniel Mack <zonque@gmail.com> # Raumfeld maintainer
Cc: Marc Zyngier <marc.zyngier@arm.com> # Zeus maintainer
Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO maintainer
Cc: Russell King <rmk+kernel@armlinux.org.uk> # SA1100
Tested-by: Janusz Krzysztofik <jmkrzyszt@gmail.com> #OMAP1 Amstrad Delta
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-imx/mach-mx21ads.c              |  1 -
 arch/arm/mach-imx/mach-mx27ads.c              |  2 +-
 arch/arm/mach-mmp/brownstone.c                |  1 -
 arch/arm/mach-omap1/board-ams-delta.c         |  2 --
 arch/arm/mach-omap2/pdata-quirks.c            |  1 -
 arch/arm/mach-pxa/em-x270.c                   |  1 -
 arch/arm/mach-pxa/ezx.c                       |  3 +-
 arch/arm/mach-pxa/raumfeld.c                  |  1 -
 arch/arm/mach-pxa/zeus.c                      |  3 +-
 arch/arm/mach-sa1100/assabet.c                |  1 -
 arch/sh/boards/mach-ecovec24/setup.c          |  2 --
 .../intel-mid/device_libs/platform_bcm43xx.c  |  1 -
 drivers/regulator/core.c                      |  8 ++---
 drivers/regulator/da9055-regulator.c          |  1 -
 drivers/regulator/fixed.c                     | 35 +++++--------------
 include/linux/regulator/fixed.h               | 10 ------
 include/linux/regulator/gpio-regulator.h      |  6 ----
 17 files changed, 13 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 2e1e540f2e5a..d278fb672d40 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -205,7 +205,6 @@ static struct regulator_init_data mx21ads_lcd_regulator_init_data = {
 static struct fixed_voltage_config mx21ads_lcd_regulator_pdata = {
 	.supply_name	= "LCD",
 	.microvolts	= 3300000,
-	.enable_high	= 1,
 	.init_data	= &mx21ads_lcd_regulator_init_data,
 };
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index f5e04047ed13..6dd7f57c332f 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -237,7 +237,7 @@ static struct fixed_voltage_config mx27ads_lcd_regulator_pdata = {
 static struct gpiod_lookup_table mx27ads_lcd_regulator_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.0", /* Let's hope ID 0 is what we get */
 	.table = {
-		GPIO_LOOKUP("LCD", 0, NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("LCD", 0, NULL, GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index a04e249c654b..d2560fb1e835 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -149,7 +149,6 @@ static struct regulator_init_data brownstone_v_5vp_data = {
 static struct fixed_voltage_config brownstone_v_5vp = {
 	.supply_name		= "v_5vp",
 	.microvolts		= 5000000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 1,
 	.init_data		= &brownstone_v_5vp_data,
 };
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c4c0a8ea11e4..be30c3c061b4 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -267,7 +267,6 @@ static struct fixed_voltage_config modem_nreset_config = {
 	.supply_name		= "modem_nreset",
 	.microvolts		= 3300000,
 	.startup_delay		= 25000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 1,
 	.init_data		= &modem_nreset_data,
 };
@@ -533,7 +532,6 @@ static struct regulator_init_data keybrd_pwr_initdata = {
 static struct fixed_voltage_config keybrd_pwr_config = {
 	.supply_name		= "keybrd_pwr",
 	.microvolts		= 5000000,
-	.enable_high		= 1,
 	.init_data		= &keybrd_pwr_initdata,
 };
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 8a5b6ed4ec36..a2ecc5e69abb 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -330,7 +330,6 @@ static struct fixed_voltage_config pandora_vwlan = {
 	.supply_name		= "vwlan",
 	.microvolts		= 1800000, /* 1.8V */
 	.startup_delay		= 50000, /* 50ms */
-	.enable_high		= 1,
 	.init_data		= &pandora_vmmc3,
 };
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 32c1edeb3f14..5ba7bb7f7d51 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -976,7 +976,6 @@ static struct fixed_voltage_config camera_dummy_config = {
 	.supply_name		= "camera_vdd",
 	.input_supply		= "vcc cam",
 	.microvolts		= 2800000,
-	.enable_high		= 0,
 	.init_data		= &camera_dummy_initdata,
 };
 
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 565965e9acc7..5e110e70ce5a 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -714,7 +714,6 @@ static struct regulator_init_data camera_regulator_initdata = {
 static struct fixed_voltage_config camera_regulator_config = {
 	.supply_name		= "camera_vdd",
 	.microvolts		= 2800000,
-	.enable_high		= 0,
 	.init_data		= &camera_regulator_initdata,
 };
 
@@ -730,7 +729,7 @@ static struct gpiod_lookup_table camera_supply_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.1",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", GPIO50_nCAM_EN,
-			    NULL, GPIO_ACTIVE_HIGH),
+			    NULL, GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index e1db072756f2..e13bfc9b01d2 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -883,7 +883,6 @@ static struct regulator_init_data audio_va_initdata = {
 static struct fixed_voltage_config audio_va_config = {
 	.supply_name		= "audio_va",
 	.microvolts		= 5000000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 0,
 	.init_data		= &audio_va_initdata,
 };
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index c411f79d4cb5..ebd654302387 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -426,7 +426,7 @@ static struct gpiod_lookup_table can_regulator_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.0",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", ZEUS_CAN_SHDN_GPIO,
-			    NULL, GPIO_ACTIVE_HIGH),
+			    NULL, GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -547,7 +547,6 @@ static struct regulator_init_data zeus_ohci_regulator_data = {
 static struct fixed_voltage_config zeus_ohci_regulator_config = {
 	.supply_name		= "vbus2",
 	.microvolts		= 5000000, /* 5.0V */
-	.enable_high		= 1,
 	.startup_delay		= 0,
 	.init_data		= &zeus_ohci_regulator_data,
 };
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index dfa42496ec27..d09c3f236186 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -469,7 +469,6 @@ static struct regulator_consumer_supply assabet_cf_vcc_consumers[] = {
 static struct fixed_voltage_config assabet_cf_vcc_pdata __initdata = {
 	.supply_name = "cf-power",
 	.microvolts = 3300000,
-	.enable_high = 1,
 };
 
 static struct gpiod_lookup_table assabet_cf_vcc_gpio_table = {
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 22b4106b8084..5495efa07335 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -630,7 +630,6 @@ static struct regulator_init_data cn12_power_init_data = {
 static struct fixed_voltage_config cn12_power_info = {
 	.supply_name = "CN12 SD/MMC Vdd",
 	.microvolts = 3300000,
-	.enable_high = 1,
 	.init_data = &cn12_power_init_data,
 };
 
@@ -671,7 +670,6 @@ static struct regulator_init_data sdhi0_power_init_data = {
 static struct fixed_voltage_config sdhi0_power_info = {
 	.supply_name = "CN11 SD/MMC Vdd",
 	.microvolts = 3300000,
-	.enable_high = 1,
 	.init_data = &sdhi0_power_init_data,
 };
 
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
index 96f438d4b026..1421d5330b2c 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
@@ -44,7 +44,6 @@ static struct fixed_voltage_config bcm43xx_vmmc = {
 	 */
 	.microvolts		= 2000000,		/* 1.8V */
 	.startup_delay		= 250 * 1000,		/* 250ms */
-	.enable_high		= 1,			/* active high */
 	.enabled_at_boot	= 0,			/* disabled at boot */
 	.init_data		= &bcm43xx_vmmc_data,
 };
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 430a73dea487..1778c5d1b2d0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -82,7 +82,6 @@ struct regulator_enable_gpio {
 	struct gpio_desc *gpiod;
 	u32 enable_count;	/* a number of enabled shared GPIO */
 	u32 request_count;	/* a number of requested shared GPIO */
-	unsigned int ena_gpio_invert:1;
 };
 
 /*
@@ -2268,7 +2267,6 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 	}
 
 	pin->gpiod = gpiod;
-	pin->ena_gpio_invert = config->ena_gpio_invert;
 	list_add(&pin->list, &regulator_ena_gpio_list);
 
 update_ena_gpio_to_rdev:
@@ -2319,8 +2317,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	if (enable) {
 		/* Enable GPIO at initial use */
 		if (pin->enable_count == 0)
-			gpiod_set_value_cansleep(pin->gpiod,
-						 !pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod, 1);
 
 		pin->enable_count++;
 	} else {
@@ -2331,8 +2328,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 
 		/* Disable GPIO if not used */
 		if (pin->enable_count <= 1) {
-			gpiod_set_value_cansleep(pin->gpiod,
-						 pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod, 0);
 			pin->enable_count = 0;
 		}
 	}
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 588c3d2445cf..417cafe2aba0 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -457,7 +457,6 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 		int gpio_mux = pdata->gpio_ren[id];
 
 		config->ena_gpiod = pdata->ena_gpiods[id];
-		config->ena_gpio_invert = 1;
 
 		/*
 		 * GPI pin is muxed with regulator to control the
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 9abdb9130766..b5afc9db2c61 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -79,15 +79,6 @@ of_get_fixed_voltage_config(struct device *dev,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	/*
-	 * FIXME: we pulled active low/high and open drain handling into
-	 * gpiolib so it will be handled there. Delete this in the second
-	 * step when we also remove the custom inversion handling for all
-	 * legacy boardfiles.
-	 */
-	config->enable_high = 1;
-	config->gpio_is_open_drain = 0;
-
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
 
@@ -151,24 +142,14 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->desc.fixed_uV = config->microvolts;
 
-	cfg.ena_gpio_invert = !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			gflags = GPIOD_OUT_HIGH;
-		else
-			gflags = GPIOD_OUT_LOW;
-	} else {
-		if (config->enable_high)
-			gflags = GPIOD_OUT_LOW;
-		else
-			gflags = GPIOD_OUT_HIGH;
-	}
-	if (config->gpio_is_open_drain) {
-		if (gflags == GPIOD_OUT_HIGH)
-			gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-		else
-			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	}
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags = GPIOD_OUT_HIGH;
+	else
+		gflags = GPIOD_OUT_LOW;
 
 	/*
 	 * Some fixed regulators share the enable line between two
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index 1a4340ed8e2b..f10140da7145 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -25,14 +25,6 @@ struct regulator_init_data;
  * @input_supply:	Name of the input regulator supply
  * @microvolts:		Output voltage of regulator
  * @startup_delay:	Start-up time in microseconds
- * @gpio_is_open_drain: Gpio pin is open drain or normal type.
- *			If it is open drain type then HIGH will be set
- *			through PULL-UP with setting gpio as input
- *			and low will be set as gpio-output with driven
- *			to low. For non-open-drain case, the gpio will
- *			will be in output and drive to low/high accordingly.
- * @enable_high:	Polarity of enable GPIO
- *			1 = Active high, 0 = Active low
  * @enabled_at_boot:	Whether regulator has been enabled at
  * 			boot or not. 1 = Yes, 0 = No
  * 			This is used to keep the regulator at
@@ -48,8 +40,6 @@ struct fixed_voltage_config {
 	const char *input_supply;
 	int microvolts;
 	unsigned startup_delay;
-	unsigned gpio_is_open_drain:1;
-	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	struct regulator_init_data *init_data;
 };
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index 49c407afb944..11cd6375215d 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -46,10 +46,6 @@ struct gpio_regulator_state {
 /**
  * struct gpio_regulator_config - config structure
  * @supply_name:	Name of the regulator supply
- * @enable_gpio:	GPIO to use for enable control
- *			set to -EINVAL if not used
- * @enable_high:	Polarity of enable GPIO
- *			1 = Active high, 0 = Active low
  * @enabled_at_boot:	Whether regulator has been enabled at
  *			boot or not. 1 = Yes, 0 = No
  *			This is used to keep the regulator at
@@ -71,8 +67,6 @@ struct gpio_regulator_state {
 struct gpio_regulator_config {
 	const char *supply_name;
 
-	int enable_gpio;
-	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-- 
2.20.1

