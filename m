Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0537C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798C6224FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKr05Pz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798C6224FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934118AbeFUWmh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:42:37 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33090 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934080AbeFUWme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so6638102lfy.0;
        Thu, 21 Jun 2018 15:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDH7k4P35peqpWle3+Ap9B6t0F4ZBjAKRW1REwjvtYs=;
        b=bKr05Pz1mSUun+FSYmYd+f9Eqd/wR6faWSpsBNQaiuACvPl8SN/9tP1ll4LnXSpjMT
         NBMxMgBQs7ByowGdIKnc9xwnk1uDry7SGbr2+PC8V5NjbMaGTeMfcEpb+q3lwZpnqv2b
         QwtIc9OioqwncY80vUpkyQSsLDTK3HQbwEQshz5I35L3NNATt48WbMxknA94hiwMxTjr
         SzBdCNFA3T9kxRBkOps1vFynok8eWBnImloTVusmKgR4Ui+CXL9RGbQZujmtC7y2IXaA
         PYF/ceNRyjvA1I1Viob7xsHg3bCpy6SdyISNIqcZbwMxGS2PJMfSmzlbQlJ70PNkTq2C
         zlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDH7k4P35peqpWle3+Ap9B6t0F4ZBjAKRW1REwjvtYs=;
        b=DaCHnKMIgUsQrLdgN8Nywdl6BloDz9lTf+R3POqjUQ9h1uEzl/f8xBozdXgCRrPni7
         49hEO7fiwNEQajFHm28KbkcH+BW5aP/nrN+kVE1g440tGzy/6zN0eXfMsoGmWZM0yOIA
         03cAHQfuurZPya+hy7E43dDeMnoPrp0fI/d9yI6iFIh5AtsbUMblFMl7G/RVQfvtk/yl
         e1mSnRu03GEK4F8IUwlHvxvcqftZED2cK//3ECktZfDR5xAZsrK40nhrR6BsuEtl5Hal
         b3IZG9v2bPiT2/9ZOczv722eQjt0oCFnguhzAWk84RGS3i5K23KKYLbXQ7WGY1QuTEDK
         nIog==
X-Gm-Message-State: APt69E1qYFJ1YBcWQZgeLS+9lID6RIhnCD5vRgKb6s2W1J0qGNixaNvJ
        aHl9/Bf6cFxAehgu0R3wCgA=
X-Google-Smtp-Source: ADUXVKKSEmTQ9jCSX03WxQXCGJJ1h7Gafo+FdHhluzorVnNi7JzEJCGOHiM5x1QlnQ1jkXpQF1cLHA==
X-Received: by 2002:a19:ee06:: with SMTP id g6-v6mr17647119lfb.77.1529620952353;
        Thu, 21 Jun 2018 15:42:32 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:31 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 07/10] ARM: OMAP1: ams-delta FIQ: Keep serio input GPIOs requested
Date:   Fri, 22 Jun 2018 00:41:25 +0200
Message-Id: <20180621224128.17623-7-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the very beginning, input GPIO pins of ams-delta serio port have
been used by FIQ handler, not serio driver.

Don't request those pins from the ams-delta-serio driver any longer,
instead keep them requested and initialized by the FIQ initialization
routine which already requests them and releases while identifying GPIO
IRQs.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

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
index b955c6a72e99..7952a29f9540 100644
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
@@ -157,7 +137,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 		 */
 		if (err == -ENODEV)
 			err = -EPROBE_DEFER;
-		goto gpio;
+		return err;
 	}
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
@@ -165,7 +145,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 			DRIVER_NAME, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
-		goto gpio;
+		return err;
 	}
 	/*
 	 * Since GPIO register handling for keyboard clock pin is performed
@@ -201,10 +181,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 
 irq:
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
-gpio:
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
-serio:
 	return err;
 }
 
@@ -214,8 +190,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
 
 	serio_unregister_port(priv->serio);
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
 
 	return 0;
 }
-- 
2.16.4

