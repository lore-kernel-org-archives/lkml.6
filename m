Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1C6RGw/eG1uBUQAAmS7hNA
	; Sat, 09 Jun 2018 14:03:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 678DE607BB; Sat,  9 Jun 2018 14:03:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhnWWQnG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 950F9608BA;
	Sat,  9 Jun 2018 14:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 950F9608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeFIODD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:03:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43530 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeFIOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:02:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so24166368lfn.10;
        Sat, 09 Jun 2018 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vK4z529eQgjlfX/v4pgs6FSNrghjntEr72J0iDzPGms=;
        b=FhnWWQnGoqq/Cf4wJR+SslOmv4vfdb/Y6LgwUHIEzrH+YaObjcON2IgAHikCO6ChTQ
         lAWh1G+TcYjw2Xh0h7KX6pBesQVLcrBB1Z/80uOaX1d8YNuA4HKLClZt10enlVBvZbQU
         DatZtdJ7KaZr434BQOn8CWt3Y3XpYIHxOSATCmHx3WmpSNhgAgEG8QjZB/jPdLaMx1Nu
         WfgIaKRK5f5QjCngt39l+sea5FxA/F32gSKZUdtlgKPTx1SL/F71t6KjwQQUMYZF1Iu9
         +r4ycodTfRPVlpxDZsPej8MRZBpyjJx63a5qIW8uUl9lbLdBBK5PsEL4zy/U9Uxm6rL/
         RdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vK4z529eQgjlfX/v4pgs6FSNrghjntEr72J0iDzPGms=;
        b=TkA3DdtBuyA76P+FeLrghLcZPHBEhm73CUi1LHqLiyMX4WNceKpAYUsbyodXwxtL/u
         3c+qMFzKgq0IOGSEEACAIAfHhdJlvJ9JjjijTbsvb7NyL1dgI61V99IK1m7/q3RUU7ls
         RKdSl8SKrwR1dx7AnE6jKYpyjXG5fsDTLwyaNvghByeqt2qc7F5KM8BlBSkb4s2hLrfl
         UZYA3nzZ8ZAasnl8mHyUygwFlWiLrAcKmKOd6rOzatAG4JQBQ8R+pRh/XrObWYh7zU6W
         Z8Sk8XV2VXFd+gVi+wdrTEBsLiQoeTotWV6O/mm9CV7WIzlWf9+a9BJD1fGBuHXQVWdU
         3SyA==
X-Gm-Message-State: APt69E2oaf1nmdDGoiobUYt6IyG3DIHS2l5uRnx/BnaWVQzciiQn1B8z
        Gwk2WAMhAgXn0gNRTqzOPN8=
X-Google-Smtp-Source: ADUXVKLqyvyfQ3kXRdQP3O3KmnifeFYN87VRiPmKwyRLdOQ3FDj+Pqxb7NLwFTNZdP0byATnaiF6hA==
X-Received: by 2002:a2e:29cf:: with SMTP id p76-v6mr7624565ljp.12.1528552974782;
        Sat, 09 Jun 2018 07:02:54 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:02:54 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 04/10] Input: ams_delta_serio: Replace power GPIO with regulator
Date: Sat,  9 Jun 2018 16:02:18 +0200
Message-Id: <20180609140224.32606-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the driver so it no longer requests and manipulates the
"keybrd_pwr" GPIO pin but a "vcc" regulator supply instead.

For this to work with Amstrad Delta, define a regulator over the
"keybrd_pwr" GPIO pin with the "vcc" supply for ams-delta-serio device
and register it from the board file.  Both assign an absulute GPIO
number to the soon depreciated .gpio member of the regulator config
structure, and also build and register a GPIO lookup table so it is
ready for use by the regulator driver as soon as its upcoming update
is applied.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 63 +++++++++++++++++++++++++++++++++--
 drivers/input/serio/ams_delta_serio.c | 27 ++++++++++-----
 2 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2119d2d3ba84..706eb2f9301d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -509,6 +509,46 @@ static struct platform_device ams_delta_serio_device = {
 	.id		= PLATFORM_DEVID_NONE,
 };
 
+static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
+	/*
+	 * Initialize supply .dev_name with NULL.  It will be replaced
+	 * with serio dev_name() as soon as the serio device is registered.
+	 */
+	REGULATOR_SUPPLY("vcc", NULL),
+};
+
+static struct regulator_init_data keybrd_pwr_initdata = {
+	.constraints		= {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(keybrd_pwr_consumers),
+	.consumer_supplies	= keybrd_pwr_consumers,
+};
+
+static struct fixed_voltage_config keybrd_pwr_config = {
+	.supply_name		= "keybrd_pwr",
+	.microvolts		= 5000000,
+	.gpio			= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
+	.enable_high		= 1,
+	.init_data		= &keybrd_pwr_initdata,
+};
+
+static struct platform_device keybrd_pwr_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= PLATFORM_DEVID_AUTO,
+	.dev	= {
+		.platform_data	= &keybrd_pwr_config,
+	},
+};
+
+static struct gpiod_lookup_table keybrd_pwr_gpio_table = {
+	.table = {
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR, NULL,
+			    GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&latch1_gpio_device,
 	&latch2_gpio_device,
@@ -526,6 +566,7 @@ static struct platform_device *late_devices[] __initdata = {
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_audio_gpio_table,
+	&keybrd_pwr_gpio_table,
 };
 
 static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
@@ -566,12 +607,30 @@ static void __init ams_delta_init(void)
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 	/*
-	 * As soon as devices have been registered, assign their dev_names
-	 * to respective GPIO lookup tables before they are added.
+	 * As soon as regulator consumers have been registered, assign their
+	 * dev_names to consumer supply entries of respective regulators.
+	 */
+	keybrd_pwr_consumers[0].dev_name =
+			dev_name(&ams_delta_serio_device.dev);
+
+	/*
+	 * Once consumer supply entries are populated with dev_names,
+	 * register regulator devices.  At this stage only the keyboard
+	 * power regulator has its consumer supply table fully populated.
+	 */
+	platform_device_register(&keybrd_pwr_device);
+
+	/*
+	 * As soon as GPIO consumers have been registered, assign
+	 * their dev_names to respective GPIO lookup tables.
 	 */
 	ams_delta_audio_gpio_table.dev_id =
 			dev_name(&ams_delta_audio_device.dev);
+	keybrd_pwr_gpio_table.dev_id = dev_name(&keybrd_pwr_device.dev);
 
+	/*
+	 * Once GPIO lookup tables are populated with dev_names, register them.
+	 */
 	gpiod_add_lookup_tables(ams_delta_gpio_tables,
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 551a4fa73fe4..d48beab1d00d 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -39,6 +40,7 @@ MODULE_LICENSE("GPL");
 
 struct ams_delta_serio {
 	struct serio *serio;
+	struct regulator *vcc;
 };
 
 static int check_data(struct serio *serio, int data)
@@ -94,16 +96,18 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 
 static int ams_delta_serio_open(struct serio *serio)
 {
-	/* enable keyboard */
-	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 1);
+	struct ams_delta_serio *priv = serio->port_data;
 
-	return 0;
+	/* enable keyboard */
+	return regulator_enable(priv->vcc);
 }
 
 static void ams_delta_serio_close(struct serio *serio)
 {
+	struct ams_delta_serio *priv = serio->port_data;
+
 	/* disable keyboard */
-	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 0);
+	regulator_disable(priv->vcc);
 }
 
 static const struct gpio ams_delta_gpios[] __initconst_or_module = {
@@ -117,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 		.flags	= GPIOF_DIR_IN,
 		.label	= "serio-clock",
 	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-power",
-	},
 	{
 		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
 		.flags	= GPIOF_OUT_INIT_LOW,
@@ -146,6 +145,16 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 		goto serio;
 	}
 
+	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(priv->vcc)) {
+		err = PTR_ERR(priv->vcc);
+		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
+		/* Fail softly if the regulator is not available yet */
+		if (err == -ENODEV)
+			err = -EPROBE_DEFER;
+		goto gpio;
+	}
+
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
 			DRIVER_NAME, priv);
-- 
2.16.1
