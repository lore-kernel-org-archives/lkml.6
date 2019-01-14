Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4652CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71D820656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="yRV50L0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfANUx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:53:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfANUx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:53:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so1021505wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=bpHZtiybhef4LZXEWmBHsrKk6PMAlSa7wsd7XEjONWo=;
        b=yRV50L0ue5v1uVFnpxSz2AdRsIrGj+EWuo4mrcVgbSkwPl4M+J1cAZPqsjpyHJgmpd
         n8i9SW/VanEQFR6Gsb6OG2a6B4fqlDq52Ilbalp8ADFS1PqtgnBdxq881RJyZFfqZ1DN
         6R1RM9IX9dGUpJJTw1GDA3EQ6qPlM9NZn2R1+3rFYhbb5gUeRhqEqMRHR/KJgME2j8wU
         vqfrCDdAqndjdaO7y/9Uefa3/4bsWw5rmlWa8IepGb/AtLZHKcm/BAxpWnnlE+HtMeIP
         YD/vluWo9uxwiF0iaAYU5PxmzsGC8/Se0viSfxCQwDdgeDRjtbo5p08XyCnBrRf5gcvg
         Fiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=bpHZtiybhef4LZXEWmBHsrKk6PMAlSa7wsd7XEjONWo=;
        b=LrAXKJK5wtST47hPAd9Nd0Ccf0WT9iOPgv2hOZAfU5770i4xDJsyNmNVFS5mNSDere
         TD3i0vA4vuvRauYVOCRToJRAWGDrK4BiDxB1rrMZM6ontx5/BITLlem7h7sUF9IUe2zY
         2gJvFzmMFKH0uGP7UtM1/So+uUQiAhUkUMdF8Yfm4MvNhMMLoiQSd96R2Gr0o3FTABwf
         TXWS3J8pzr8Et5mLdkgC9wU4MGFM/LVOP1vadPE0WMNTWujY6WAf87UamUyBcyeaWojq
         kipZyF2FzlAewQOz30AOQFbHtIYxBBNGn6YMW5D+E+PXsGuVxk4a/is2ekEphbpbmOjz
         Zuhw==
X-Gm-Message-State: AJcUukc8IXxcpSqxD5uhxQCneJ4FpJneogTHj72XV95Ko8g5Uj02rFr4
        Xqmo02Gctsbvre7ohBpa1KqJUQ==
X-Google-Smtp-Source: ALg8bN5SuL1kWDOQPhlAQYQz4BV+//RzerE4lS0/kitc1u5D5ByFgfgfdCCXGpPQmFLYlqzZEnZe1g==
X-Received: by 2002:a1c:16c5:: with SMTP id 188mr714778wmw.69.1547499232499;
        Mon, 14 Jan 2019 12:53:52 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 198sm45715233wmt.36.2019.01.14.12.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:53:51 -0800 (PST)
Message-ID: <5c3cf6df.1c69fb81.2b9ce.99d4@mx.google.com>
Date:   Mon, 14 Jan 2019 12:53:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: broonie-regulator
X-Kernelci-Branch: for-next
X-Kernelci-Kernel: v5.0-rc2-20-g61b67608c6b9
Subject: broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9
 on r8a7796-m3ulcb
To:     Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9 on r8a=
7796-m3ulcb

Summary:
  Start:      61b67608c6b9 Merge branch 'regulator-5.1' into regulator-next
  Details:    https://kernelci.org/boot/id/5c3caf0159b514eca66eddf0
  Plain log:  https://storage.kernelci.org//broonie-regulator/for-next/v5.0=
-rc2-20-g61b67608c6b9/arm64/defconfig/lab-baylibre/boot-r8a7796-m3ulcb.txt
  HTML log:   https://storage.kernelci.org//broonie-regulator/for-next/v5.0=
-rc2-20-g61b67608c6b9/arm64/defconfig/lab-baylibre/boot-r8a7796-m3ulcb.html
  Result:     fe665efe6554 regulator: gpio: Convert to use descriptors

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       broonie-regulator
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/broonie/regula=
tor.git
  Branch:     for-next
  Target:     r8a7796-m3ulcb
  CPU arch:   arm64
  Lab:        lab-baylibre
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit fe665efe6554eb80ff301ba9765d497f5f24abb6
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Jan 7 17:27:42 2019 +0100

    regulator: gpio: Convert to use descriptors
    =

    This converts the GPIO regulator driver to use decriptors only.
    =

    We have to let go of the array gpio handling: the fetched descriptors
    are handled individually anyway, and the array retrieveal function
    does not make it possible to retrieve each GPIO descriptor with
    unique flags. Instead get them one by one.
    =

    We request the "enable" GPIO separately as before, and make sure
    that this line is requested as nonexclusive since enable lines can
    be shared and the regulator core expects this.
    =

    Most users of the GPIO regulator are using device tree.
    =

    There are two boards in the kernel using the gpio regulator from a
    non-devicetree path: PXA hx4700 and magician. Make sure to switch
    these over to use descriptors as well.
    =

    Cc: Philipp Zabel <p.zabel@pengutronix.de> # Magician
    Cc: Petr Cvek <petr.cvek@tul.cz> # Magician
    Cc: Robert Jarzmik <robert.jarzmik@free.fr> # PXA
    Cc: Paul Parsons <lost.distance@yahoo.com> # hx4700
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b79b757fdd41..51d38d5e776a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -702,9 +703,7 @@ static struct regulator_init_data bq24022_init_data =3D=
 {
 	.consumer_supplies      =3D bq24022_consumers,
 };
 =

-static struct gpio bq24022_gpios[] =3D {
-	{ GPIO96_HX4700_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+static enum gpiod_flags bq24022_gpiod_gflags[] =3D { GPIOD_OUT_LOW };
 =

 static struct gpio_regulator_state bq24022_states[] =3D {
 	{ .value =3D 100000, .gpios =3D (0 << 0) },
@@ -714,12 +713,10 @@ static struct gpio_regulator_state bq24022_states[] =
=3D {
 static struct gpio_regulator_config bq24022_info =3D {
 	.supply_name =3D "bq24022",
 =

-	.enable_gpio =3D GPIO72_HX4700_BQ24022_nCHARGE_EN,
-	.enable_high =3D 0,
 	.enabled_at_boot =3D 0,
 =

-	.gpios =3D bq24022_gpios,
-	.nr_gpios =3D ARRAY_SIZE(bq24022_gpios),
+	.gflags =3D bq24022_gpiod_gflags,
+	.ngpios =3D ARRAY_SIZE(bq24022_gpiod_gflags),
 =

 	.states =3D bq24022_states,
 	.nr_states =3D ARRAY_SIZE(bq24022_states),
@@ -736,6 +733,17 @@ static struct platform_device bq24022 =3D {
 	},
 };
 =

+static struct gpiod_lookup_table bq24022_gpiod_table =3D {
+	.dev_id =3D "gpio-regulator",
+	.table =3D {
+		GPIO_LOOKUP("gpio-pxa", GPIO96_HX4700_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * StrataFlash
  */
@@ -878,6 +886,7 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 =

+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 =

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 08b079653c3f..6538a7c0e504 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -645,9 +645,8 @@ static struct regulator_init_data bq24022_init_data =3D=
 {
 	.consumer_supplies	=3D bq24022_consumers,
 };
 =

-static struct gpio bq24022_gpios[] =3D {
-	{ EGPIO_MAGICIAN_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+
+static enum gpiod_flags bq24022_gpiod_gflags[] =3D { GPIOD_OUT_LOW };
 =

 static struct gpio_regulator_state bq24022_states[] =3D {
 	{ .value =3D 100000, .gpios =3D (0 << 0) },
@@ -657,12 +656,10 @@ static struct gpio_regulator_state bq24022_states[] =
=3D {
 static struct gpio_regulator_config bq24022_info =3D {
 	.supply_name		=3D "bq24022",
 =

-	.enable_gpio		=3D GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-	.enable_high		=3D 0,
 	.enabled_at_boot	=3D 1,
 =

-	.gpios			=3D bq24022_gpios,
-	.nr_gpios		=3D ARRAY_SIZE(bq24022_gpios),
+	.gflags =3D bq24022_gpiod_gflags,
+	.ngpios =3D ARRAY_SIZE(bq24022_gpiod_gflags),
 =

 	.states			=3D bq24022_states,
 	.nr_states		=3D ARRAY_SIZE(bq24022_states),
@@ -679,6 +676,17 @@ static struct platform_device bq24022 =3D {
 	},
 };
 =

+static struct gpiod_lookup_table bq24022_gpiod_table =3D {
+	.dev_id =3D "gpio-regulator",
+	.table =3D {
+		GPIO_LOOKUP("gpio-pxa", EGPIO_MAGICIAN_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * fixed regulator for ads7846
  */
@@ -1027,6 +1035,7 @@ static void __init magician_init(void)
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 =

+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 =

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-re=
gulator.c
index b2f5ec4f658a..0cec163200c8 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -30,16 +30,15 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/gpio-regulator.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 =

 struct gpio_regulator_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
 =

-	struct gpio *gpios;
+	struct gpio_desc **gpiods;
 	int nr_gpios;
 =

 	struct gpio_regulator_state *states;
@@ -82,7 +81,7 @@ static int gpio_regulator_set_voltage(struct regulator_de=
v *dev,
 =

 	for (ptr =3D 0; ptr < data->nr_gpios; ptr++) {
 		state =3D (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state =3D target;
 =

@@ -119,7 +118,7 @@ static int gpio_regulator_set_current_limit(struct regu=
lator_dev *dev,
 =

 	for (ptr =3D 0; ptr < data->nr_gpios; ptr++) {
 		state =3D (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state =3D target;
 =

@@ -138,7 +137,8 @@ of_get_gpio_regulator_config(struct device *dev, struct=
 device_node *np,
 {
 	struct gpio_regulator_config *config;
 	const char *regtype;
-	int proplen, gpio, i;
+	int proplen, i;
+	int ngpios;
 	int ret;
 =

 	config =3D devm_kzalloc(dev,
@@ -153,59 +153,36 @@ of_get_gpio_regulator_config(struct device *dev, stru=
ct device_node *np,
 =

 	config->supply_name =3D config->init_data->constraints.name;
 =

-	if (of_property_read_bool(np, "enable-active-high"))
-		config->enable_high =3D true;
-
 	if (of_property_read_bool(np, "enable-at-boot"))
 		config->enabled_at_boot =3D true;
 =

 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 =

-	config->enable_gpio =3D of_get_named_gpio(np, "enable-gpio", 0);
-	if (config->enable_gpio < 0 && config->enable_gpio !=3D -ENOENT)
-		return ERR_PTR(config->enable_gpio);
-
-	/* Fetch GPIOs. - optional property*/
-	ret =3D of_gpio_count(np);
-	if ((ret < 0) && (ret !=3D -ENOENT))
-		return ERR_PTR(ret);
-
-	if (ret > 0) {
-		config->nr_gpios =3D ret;
-		config->gpios =3D devm_kcalloc(dev,
-					config->nr_gpios, sizeof(struct gpio),
-					GFP_KERNEL);
-		if (!config->gpios)
+	/* Fetch GPIO init levels */
+	ngpios =3D gpiod_count(dev, NULL);
+	if (ngpios > 0) {
+		config->gflags =3D devm_kzalloc(dev,
+					      sizeof(enum gpiod_flags)
+					      * ngpios,
+					      GFP_KERNEL);
+		if (!config->gflags)
 			return ERR_PTR(-ENOMEM);
 =

-		proplen =3D of_property_count_u32_elems(np, "gpios-states");
-		/* optional property */
-		if (proplen < 0)
-			proplen =3D 0;
+		for (i =3D 0; i < ngpios; i++) {
+			u32 val;
 =

-		if (proplen > 0 && proplen !=3D config->nr_gpios) {
-			dev_warn(dev, "gpios <-> gpios-states mismatch\n");
-			proplen =3D 0;
-		}
+			ret =3D of_property_read_u32_index(np, "gpios-states", i,
+							 &val);
 =

-		for (i =3D 0; i < config->nr_gpios; i++) {
-			gpio =3D of_get_named_gpio(np, "gpios", i);
-			if (gpio < 0) {
-				if (gpio !=3D -ENOENT)
-					return ERR_PTR(gpio);
-				break;
-			}
-			config->gpios[i].gpio =3D gpio;
-			config->gpios[i].label =3D config->supply_name;
-			if (proplen > 0) {
-				of_property_read_u32_index(np, "gpios-states",
-							   i, &ret);
-				if (ret)
-					config->gpios[i].flags =3D
-							   GPIOF_OUT_INIT_HIGH;
-			}
+			/* Default to high per specification */
+			if (ret)
+				config->gflags[i] =3D GPIOD_OUT_HIGH;
+			else
+				config->gflags[i] =3D
+					val ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 		}
 	}
+	config->ngpios =3D ngpios;
 =

 	/* Fetch states. */
 	proplen =3D of_property_count_u32_elems(np, "states");
@@ -255,7 +232,8 @@ static int gpio_regulator_probe(struct platform_device =
*pdev)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg =3D { };
-	int ptr, ret, state;
+	enum gpiod_flags gflags;
+	int ptr, ret, state, i;
 =

 	drvdata =3D devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
 			       GFP_KERNEL);
@@ -275,26 +253,17 @@ static int gpio_regulator_probe(struct platform_devic=
e *pdev)
 		return -ENOMEM;
 	}
 =

-	if (config->nr_gpios !=3D 0) {
-		drvdata->gpios =3D kmemdup(config->gpios,
-					 config->nr_gpios * sizeof(struct gpio),
-					 GFP_KERNEL);
-		if (drvdata->gpios =3D=3D NULL) {
-			dev_err(&pdev->dev, "Failed to allocate gpio data\n");
-			ret =3D -ENOMEM;
-			goto err_name;
-		}
-
-		drvdata->nr_gpios =3D config->nr_gpios;
-		ret =3D gpio_request_array(drvdata->gpios, drvdata->nr_gpios);
-		if (ret) {
-			if (ret !=3D -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Could not obtain regulator setting GPIOs: %d\n",
-					ret);
-			goto err_memgpio;
-		}
+	for (i =3D 0; i < config->ngpios; i++) {
+		drvdata->gpiods[i] =3D devm_gpiod_get_index(&pdev->dev,
+							  NULL,
+							  i,
+							  config->gflags[i]);
+		if (IS_ERR(drvdata->gpiods[i]))
+			return PTR_ERR(drvdata->gpiods[i]);
+		/* This is good to know */
+		gpiod_set_consumer_name(drvdata->gpiods[i], drvdata->desc.name);
 	}
+	drvdata->nr_gpios =3D config->ngpios;
 =

 	drvdata->states =3D kmemdup(config->states,
 				  config->nr_states *
@@ -303,7 +272,7 @@ static int gpio_regulator_probe(struct platform_device =
*pdev)
 	if (drvdata->states =3D=3D NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret =3D -ENOMEM;
-		goto err_stategpio;
+		goto err_name;
 	}
 	drvdata->nr_states =3D config->nr_states;
 =

@@ -330,7 +299,7 @@ static int gpio_regulator_probe(struct platform_device =
*pdev)
 	/* build initial state from gpio init data. */
 	state =3D 0;
 	for (ptr =3D 0; ptr < drvdata->nr_gpios; ptr++) {
-		if (config->gpios[ptr].flags & GPIOF_OUT_INIT_HIGH)
+		if (config->gflags[ptr] =3D=3D GPIOD_OUT_HIGH)
 			state |=3D (1 << ptr);
 	}
 	drvdata->state =3D state;
@@ -340,21 +309,19 @@ static int gpio_regulator_probe(struct platform_devic=
e *pdev)
 	cfg.driver_data =3D drvdata;
 	cfg.of_node =3D np;
 =

-	if (gpio_is_valid(config->enable_gpio)) {
-		cfg.ena_gpio =3D config->enable_gpio;
-		cfg.ena_gpio_initialized =3D true;
-	}
-	cfg.ena_gpio_invert =3D !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;
-		else
-			cfg.ena_gpio_flags |=3D GPIOF_OUT_INIT_LOW;
-	} else {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |=3D GPIOF_OUT_INIT_LOW;
-		else
-			cfg.ena_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags =3D GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+	else
+		gflags =3D GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
+	cfg.ena_gpiod =3D gpiod_get_optional(&pdev->dev, "enable", gflags);
+	if (IS_ERR(cfg.ena_gpiod)) {
+		ret =3D PTR_ERR(cfg.ena_gpiod);
+		goto err_memstate;
 	}
 =

 	drvdata->dev =3D regulator_register(&drvdata->desc, &cfg);
@@ -370,10 +337,6 @@ static int gpio_regulator_probe(struct platform_device=
 *pdev)
 =

 err_memstate:
 	kfree(drvdata->states);
-err_stategpio:
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-err_memgpio:
-	kfree(drvdata->gpios);
 err_name:
 	kfree(drvdata->desc.name);
 	return ret;
@@ -384,12 +347,7 @@ static int gpio_regulator_remove(struct platform_devic=
e *pdev)
 	struct gpio_regulator_data *drvdata =3D platform_get_drvdata(pdev);
 =

 	regulator_unregister(drvdata->dev);
-
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-
 	kfree(drvdata->states);
-	kfree(drvdata->gpios);
-
 	kfree(drvdata->desc.name);
 =

 	return 0;
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regul=
ator/gpio-regulator.h
index 19fbd267406d..49c407afb944 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -21,6 +21,8 @@
 #ifndef __REGULATOR_GPIO_H
 #define __REGULATOR_GPIO_H
 =

+#include <linux/gpio/consumer.h>
+
 struct regulator_init_data;
 =

 enum regulator_type;
@@ -53,9 +55,9 @@ struct gpio_regulator_state {
  *			This is used to keep the regulator at
  *			the default state
  * @startup_delay:	Start-up time in microseconds
- * @gpios:		Array containing the gpios needed to control
- *			the setting of the regulator
- * @nr_gpios:		Number of gpios
+ * @gflags:		Array of GPIO configuration flags for initial
+ *			states
+ * @ngpios:		Number of GPIOs and configurations available
  * @states:		Array of gpio_regulator_state entries describing
  *			the gpio state for specific voltages
  * @nr_states:		Number of states available
@@ -74,8 +76,8 @@ struct gpio_regulator_config {
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 =

-	struct gpio *gpios;
-	int nr_gpios;
+	enum gpiod_flags *gflags;
+	int ngpios;
 =

 	struct gpio_regulator_state *states;
 	int nr_states;
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
git bisect good 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8
# bad: [61b67608c6b90e8a2abde5be31bb181f56849927] Merge branch 'regulator-5=
.1' into regulator-next
git bisect bad 61b67608c6b90e8a2abde5be31bb181f56849927
# bad: [fe665efe6554eb80ff301ba9765d497f5f24abb6] regulator: gpio: Convert =
to use descriptors
git bisect bad fe665efe6554eb80ff301ba9765d497f5f24abb6
# good: [08f0b14adc7c4fd5ef7ab2f4b7a62ed1b8216bbb] regulator: hi655x: Remov=
ed unused ctrl_regs field from struct hi655x_regulator
git bisect good 08f0b14adc7c4fd5ef7ab2f4b7a62ed1b8216bbb
# good: [67cc7ca316c4167cc5aca54b7f63a55de356d976] regulator: max14577: Rem=
ove redundant MODULE_ALIAS
git bisect good 67cc7ca316c4167cc5aca54b7f63a55de356d976
# good: [f01a7beb6791f1c419424c1a6958b7d0a289c974] regulator: act8865: Fix =
act8600_sudcdc_voltage_ranges setting
git bisect good f01a7beb6791f1c419424c1a6958b7d0a289c974
# first bad commit: [fe665efe6554eb80ff301ba9765d497f5f24abb6] regulator: g=
pio: Convert to use descriptors
---------------------------------------------------------------------------=
----
