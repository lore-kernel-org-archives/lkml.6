Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yPuMGireG1uIUgAAmS7hNA
	; Sat, 09 Jun 2018 14:03:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F791608B8; Sat,  9 Jun 2018 14:03:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKuuwicw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89473601D2;
	Sat,  9 Jun 2018 14:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89473601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeFIODR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:03:17 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43552 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeFIODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:03:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so24167046lfn.10;
        Sat, 09 Jun 2018 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mTpXdNg/kUL1h8CCG7+VyS+Bu4yjZEBcFSavjJKK+0c=;
        b=FKuuwicwaGtulq4r5rrdZdnJK4XSOWmSw2M9kkGDrXnLFgFtrq2gzstvZabi9GgW3E
         J0OZb/co9L5Q4HPfyjPH/ob5as1dMMmKWYCKYckOzCqcwnpmbe/jBsdQY7nyQ6aRcvAK
         zq1ZEv4qAfPjkWy1EpH9ET98KkLayuvWR8H2UiTIebPupBHo+ZS95Fq2ZoL94wPV8EnZ
         cQGoG+6PafpzL9zeTAb3dA09eMyxJg7YD2aHOGeIIvYflFuRzRx+7P49NwZ623NDAlEf
         jWO+fv3m4MWcFU57Gse05Y5/L5DQ/EGiSglCZy5z4NGDNruSzO1AwQKt+Fjz1wfTv/5m
         XMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTpXdNg/kUL1h8CCG7+VyS+Bu4yjZEBcFSavjJKK+0c=;
        b=LJA8XxegID/ijEfX1EF8LrWw/a0ZxAQTiFqqSeX3l73x8CuDq0uVJ5KNGlSHNUymJP
         qxz4bXS/Mqn1eRr7FEeLL8QUXdr+iteRi1QmbGEc4SOZXXbLGygjJx2RNQ3ARcLm1rQ2
         bJPSiTlEQsfJkP5ijZW4uvthDgPRSckf6f3fCz6I2JT3VY+dutsDxK8qPEg4XJM3e27Y
         THbBbiagUqgCL+VIqtbEawnu+HsZxiTTv9+7nFVa3yiT6k1qSEWHtI1v3OHnthKftbrG
         XKWAcwSHBDZy0xdaF/6IlrOalz7cNUy+NvmYYtTnm0/bXYYv2o3XoyCyYm5y6T451VDr
         Kbog==
X-Gm-Message-State: APt69E3uVv6NmBHqcCVIkqejloGlbjNwqWosX3hQO8cDBVGyZtZXipeM
        sutA7p75q9zwGqiALmGUWoY=
X-Google-Smtp-Source: ADUXVKIqD6pRO7+XqYUbxDb9uZdb/r5IZyGQQWWBGrOTUroA2mPmxE6blPz7KVG4ursBBZo2iav9oA==
X-Received: by 2002:a2e:55cf:: with SMTP id g76-v6mr4711105lje.4.1528552990652;
        Sat, 09 Jun 2018 07:03:10 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:03:10 -0700 (PDT)
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
Subject: [PATCH 07/10] ARM: OMAP1: ams-delta FIQ: Keep serio input GPIOs requested
Date: Sat,  9 Jun 2018 16:02:21 +0200
Message-Id: <20180609140224.32606-7-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From the very beginning, input GPIO pins of ams-delta serio port have
been used by FIQ handler, not serio driver.

Don't request those pins from the ams-delta-serio driver any longer,
instead keep them requested and initialized by the FIQ initialization
routine which already requests them and releases while identifying GPIO
IRQs.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq.c   | 42 ++++++++++++++++++++++++++++++-----
 drivers/input/serio/ams_delta_serio.c | 30 ++-----------------------
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 1d54a6177f14..5a6c59ac9b5f 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -45,6 +45,11 @@ static struct irq_chip *irq_chip;
 static struct irq_data *irq_data[16];
 static unsigned int irq_counter[16];
 
+static const char *pin_name[16] __initconst = {
+	[AMS_DELTA_GPIO_PIN_KEYBRD_DATA]	= "keybrd_data",
+	[AMS_DELTA_GPIO_PIN_KEYBRD_CLK]		= "keybrd_clk",
+};
+
 static irqreturn_t deferred_fiq(int irq, void *dev_id)
 {
 	struct irq_data *d;
@@ -80,7 +85,7 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 
 void __init ams_delta_init_fiq(struct gpio_chip *chip)
 {
-	struct gpio_desc *gpiod;
+	struct gpio_desc *gpiod, *data = NULL, *clk = NULL;
 	void *fiqhandler_start;
 	unsigned int fiqhandler_length;
 	struct pt_regs FIQ_regs;
@@ -96,7 +101,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(irq_data); i++) {
-		gpiod = gpiochip_request_own_desc(chip, i, NULL);
+		gpiod = gpiochip_request_own_desc(chip, i, pin_name[i]);
 		if (IS_ERR(gpiod)) {
 			pr_err("%s: failed to get GPIO pin %d (%ld)\n",
 			       __func__, i, PTR_ERR(gpiod));
@@ -105,8 +110,27 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 		/* Store irq_data location for IRQ handler use */
 		irq_data[i] = irq_get_irq_data(gpiod_to_irq(gpiod));
 
-		gpiochip_free_own_desc(gpiod);
+		/*
+		 * FIQ handler takes full control over serio data and clk GPIO
+		 * pins.  Initiaize them and keep requested so nobody can
+		 * interfere.  Fail if any of those two couldn't be requested.
+		 */
+		switch (i) {
+		case AMS_DELTA_GPIO_PIN_KEYBRD_DATA:
+			data = gpiod;
+			gpiod_direction_input(data);
+			break;
+		case AMS_DELTA_GPIO_PIN_KEYBRD_CLK:
+			clk = gpiod;
+			gpiod_direction_input(clk);
+			break;
+		default:
+			gpiochip_free_own_desc(gpiod);
+			break;
+		}
 	}
+	if (!data || !clk)
+		goto out_gpio;
 
 	fiqhandler_start = &qwerty_fiqin_start;
 	fiqhandler_length = &qwerty_fiqin_end - &qwerty_fiqin_start;
@@ -117,7 +141,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	if (retval) {
 		pr_err("ams_delta_init_fiq(): couldn't claim FIQ, ret=%d\n",
 				retval);
-		return;
+		goto out_gpio;
 	}
 
 	retval = request_irq(INT_DEFERRED_FIQ, deferred_fiq,
@@ -125,7 +149,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	if (retval < 0) {
 		pr_err("Failed to get deferred_fiq IRQ, ret=%d\n", retval);
 		release_fiq(&fh);
-		return;
+		goto out_gpio;
 	}
 	/*
 	 * Since no set_type() method is provided by OMAP irq chip,
@@ -175,4 +199,12 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	offset = IRQ_ILR0_REG_OFFSET + (INT_GPIO_BANK1 - NR_IRQS_LEGACY) * 0x4;
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
+
+	return;
+
+out_gpio:
+	if (data)
+		gpiochip_free_own_desc(data);
+	if (clk)
+		gpiochip_free_own_desc(clk);
 }
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 0b4d5a952ecb..a83d8b3cd838 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -110,19 +110,6 @@ static void ams_delta_serio_close(struct serio *serio)
 	regulator_disable(priv->vcc);
 }
 
-static const struct gpio ams_delta_gpios[] __initconst_or_module = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
-		.flags	= GPIOF_DIR_IN,
-		.label	= "serio-data",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
-		.flags	= GPIOF_DIR_IN,
-		.label	= "serio-clock",
-	},
-};
-
 static int ams_delta_serio_init(struct platform_device *pdev)
 {
 	struct ams_delta_serio *priv;
@@ -133,13 +120,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	err = gpio_request_array(ams_delta_gpios,
-				ARRAY_SIZE(ams_delta_gpios));
-	if (err) {
-		dev_err(&pdev->dev, "Couldn't request gpio pins\n");
-		goto serio;
-	}
-
 	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	if (IS_ERR(priv->vcc)) {
 		err = PTR_ERR(priv->vcc);
@@ -147,7 +127,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 		/* Fail softly if the regulator is not available yet */
 		if (err == -ENODEV)
 			err = -EPROBE_DEFER;
-		goto gpio;
+		return err;
 	}
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
@@ -155,7 +135,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 			DRIVER_NAME, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
-		goto gpio;
+		return err;
 	}
 	/*
 	 * Since GPIO register handling for keyboard clock pin is performed
@@ -191,10 +171,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 
 irq:
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
-gpio:
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
-serio:
 	return err;
 }
 
@@ -204,8 +180,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
 
 	serio_unregister_port(priv->serio);
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
 
 	return 0;
 }
-- 
2.16.1
