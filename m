Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBFDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A46208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVL04gfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfANO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:57:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46639 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfANO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:57:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so9542022pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nBSbeqspcnpftsuD8Vu/GTGkUrHKQAz6+SfrWHinhc=;
        b=rVL04gfNObly9R2H+OR4OKRBUzD8S+Oxw13yvhLHfcPqqpNDNtNsZUTD8Zsjv/fELb
         jusd0R5q+QEMsxGq3tdmUrVEt15fu+539VK4kD1K3Rj2ZAjo/wcsNU6+5CekNgZtEUlm
         9ut8AS7lo27aep1F1SWwSnyg5DyOrUjeN66YdB3X+YryU6tyGM9Fk5e/Qa9de0GRo/Ss
         ukIn+LbE0iYqHUJM4RMRZw8iekhrZ/g92z6CKvBCo+kmecu/KDk0zYU1NynJd1oJDMd1
         uQr6082egcxzrQFTZ72+rwMr9/2GI/agwnkQkr7AR1TxJ8FWqVYLx9M+0HZ9KKlnSamm
         W++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nBSbeqspcnpftsuD8Vu/GTGkUrHKQAz6+SfrWHinhc=;
        b=QOIvuIODOW9Gk4dT4JRUL7PPfivop2FSVYXf3fPun2nnRsy6ImsZPjnOMo3AVjnZgY
         mGAXepyKkMjM66YXETm4HgChSWziUxQJRygKuerH1sOkgWX7gQPy2QVPntaPNKf8idw8
         ptA532YezuT9gu7+MscKUxuZBkrmUKe98FUJyzKRRNz3JwQ4l/YOA18ybWSWLM2ZZLFu
         04HkUl/vzRxOAJgki7JuwY6IrwWu9nyferRkEXqGpqAqqtjiQjNlXzi3MTv3rvQWXP6I
         s2Geas9bU72OrdM9sQZOY+ylGJAgMwSxn6nRIKUxnU3nF3pW0FySqln2gtz4+7dYvMsN
         8iqg==
X-Gm-Message-State: AJcUukd4gS9XIh2XHaysrEA/wKEC2YesSwhkvZ38yY05mj+68IKoxtC3
        8MqaMEUaEk8BESM6s8dCryY=
X-Google-Smtp-Source: ALg8bN4ulztbiH4Y2iEPgulap5Uheo0gdjOJLkM3RcEMpHpPHOf8GYfR9iMwKS+h3doPer8vCZYDww==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr23262996pgk.147.1547477857954;
        Mon, 14 Jan 2019 06:57:37 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id m198sm1164565pga.10.2019.01.14.06.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 06:57:37 -0800 (PST)
Date:   Mon, 14 Jan 2019 20:27:31 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v7 2/3] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <9f0c1e15579e9c882a92e71ed0a8adbdd06c1fa9.1547476997.git.nishadkamdar@gmail.com>
References: <cover.1547476997.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547476997.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface while continuing to ignore gpio flags from device tree in
functions "deassert_reset()" and "assert_reset()" for now.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v7:
 - No change.
Changes in v6:
 - Remove some unnecessary line breaks.
Changes in v5:
 - Change the commit message.
 - Restore the names of the gpio device-tree properties without
   the "-gpio" suffix.
Changes in v4:
 - Use gpiod_set_raw_value() for deassert_reset() and
   assert_reset() as gpiod_set_value() will change the
   sematics of these calls by taking any gpio flags
   into account.
 - Remove some unnecesssary line breaks.
 - Restore 'spi_en' gpio check in fw_flashing_seq()
   as it is currently optional.
Changes in v3:
 - Add this patch in a patchset.
Changes in v2:
 - Resolved compilation errors.
---
 drivers/staging/greybus/arche-apb-ctrl.c | 152 +++++++++--------------
 1 file changed, 61 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index be5ffed90bcf..bbf3ba744fc4 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -8,9 +8,8 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
@@ -24,12 +23,12 @@ static void apb_bootret_deassert(struct device *dev);
 
 struct arche_apb_ctrl_drvdata {
 	/* Control GPIO signals to and from AP <=> AP Bridges */
-	int resetn_gpio;
-	int boot_ret_gpio;
-	int pwroff_gpio;
-	int wake_in_gpio;
-	int wake_out_gpio;
-	int pwrdn_gpio;
+	struct gpio_desc *resetn;
+	struct gpio_desc *boot_ret;
+	struct gpio_desc *pwroff;
+	struct gpio_desc *wake_in;
+	struct gpio_desc *wake_out;
+	struct gpio_desc *pwrdn;
 
 	enum arche_platform_state state;
 	bool init_disabled;
@@ -37,28 +36,28 @@ struct arche_apb_ctrl_drvdata {
 	struct regulator *vcore;
 	struct regulator *vio;
 
-	int clk_en_gpio;
+	struct gpio_desc *clk_en;
 	struct clk *clk;
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pin_default;
 
 	/* V2: SPI Bus control  */
-	int spi_en_gpio;
+	struct gpio_desc *spi_en;
 	bool spi_en_polarity_high;
 };
 
 /*
  * Note that these low level api's are active high
  */
-static inline void deassert_reset(unsigned int gpio)
+static inline void deassert_reset(struct gpio_desc *gpio)
 {
-	gpio_set_value(gpio, 1);
+	gpiod_set_raw_value(gpio, 1);
 }
 
-static inline void assert_reset(unsigned int gpio)
+static inline void assert_reset(struct gpio_desc *gpio)
 {
-	gpio_set_value(gpio, 0);
+	gpiod_set_raw_value(gpio, 0);
 }
 
 /*
@@ -75,11 +74,10 @@ static int coldboot_seq(struct platform_device *pdev)
 		return 0;
 
 	/* Hold APB in reset state */
-	assert_reset(apb->resetn_gpio);
+	assert_reset(apb->resetn);
 
-	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
-	    gpio_is_valid(apb->spi_en_gpio))
-		devm_gpio_free(dev, apb->spi_en_gpio);
+	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING && apb->spi_en)
+		devm_gpiod_put(dev, apb->spi_en);
 
 	/* Enable power to APB */
 	if (!IS_ERR(apb->vcore)) {
@@ -101,13 +99,13 @@ static int coldboot_seq(struct platform_device *pdev)
 	apb_bootret_deassert(dev);
 
 	/* On DB3 clock was not mandatory */
-	if (gpio_is_valid(apb->clk_en_gpio))
-		gpio_set_value(apb->clk_en_gpio, 1);
+	if (apb->clk_en)
+		gpiod_set_value(apb->clk_en, 1);
 
 	usleep_range(100, 200);
 
 	/* deassert reset to APB : Active-low signal */
-	deassert_reset(apb->resetn_gpio);
+	deassert_reset(apb->resetn);
 
 	apb->state = ARCHE_PLATFORM_STATE_ACTIVE;
 
@@ -136,25 +134,25 @@ static int fw_flashing_seq(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (gpio_is_valid(apb->spi_en_gpio)) {
+	if (apb->spi_en) {
 		unsigned long flags;
 
 		if (apb->spi_en_polarity_high)
-			flags = GPIOF_OUT_INIT_HIGH;
+			flags = GPIOD_OUT_HIGH;
 		else
-			flags = GPIOF_OUT_INIT_LOW;
+			flags = GPIOD_OUT_LOW;
 
-		ret = devm_gpio_request_one(dev, apb->spi_en_gpio,
-					    flags, "apb_spi_en");
-		if (ret) {
-			dev_err(dev, "Failed requesting SPI bus en gpio %d\n",
-				apb->spi_en_gpio);
+		apb->spi_en = devm_gpiod_get(dev, "spi-en", flags);
+		if (IS_ERR(apb->spi_en)) {
+			ret = PTR_ERR(apb->spi_en);
+			dev_err(dev, "Failed requesting SPI bus en GPIO: %d\n",
+				ret);
 			return ret;
 		}
 	}
 
 	/* for flashing device should be in reset state */
-	assert_reset(apb->resetn_gpio);
+	assert_reset(apb->resetn);
 	apb->state = ARCHE_PLATFORM_STATE_FW_FLASHING;
 
 	return 0;
@@ -176,9 +174,8 @@ static int standby_boot_seq(struct platform_device *pdev)
 	    apb->state == ARCHE_PLATFORM_STATE_OFF)
 		return 0;
 
-	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
-	    gpio_is_valid(apb->spi_en_gpio))
-		devm_gpio_free(dev, apb->spi_en_gpio);
+	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING && apb->spi_en)
+		devm_gpiod_put(dev, apb->spi_en);
 
 	/*
 	 * As per WDM spec, do nothing
@@ -201,13 +198,12 @@ static void poweroff_seq(struct platform_device *pdev)
 	if (apb->init_disabled || apb->state == ARCHE_PLATFORM_STATE_OFF)
 		return;
 
-	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
-	    gpio_is_valid(apb->spi_en_gpio))
-		devm_gpio_free(dev, apb->spi_en_gpio);
+	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING && apb->spi_en)
+		devm_gpiod_put(dev, apb->spi_en);
 
 	/* disable the clock */
-	if (gpio_is_valid(apb->clk_en_gpio))
-		gpio_set_value(apb->clk_en_gpio, 0);
+	if (apb->clk_en)
+		gpiod_set_value(apb->clk_en, 0);
 
 	if (!IS_ERR(apb->vcore) && regulator_is_enabled(apb->vcore) > 0)
 		regulator_disable(apb->vcore);
@@ -216,7 +212,7 @@ static void poweroff_seq(struct platform_device *pdev)
 		regulator_disable(apb->vio);
 
 	/* As part of exit, put APB back in reset state */
-	assert_reset(apb->resetn_gpio);
+	assert_reset(apb->resetn);
 	apb->state = ARCHE_PLATFORM_STATE_OFF;
 
 	/* TODO: May have to send an event to SVC about this exit */
@@ -226,7 +222,7 @@ static void apb_bootret_deassert(struct device *dev)
 {
 	struct arche_apb_ctrl_drvdata *apb = dev_get_drvdata(dev);
 
-	gpio_set_value(apb->boot_ret_gpio, 0);
+	gpiod_set_value(apb->boot_ret, 0);
 }
 
 int apb_ctrl_coldboot(struct device *dev)
@@ -322,66 +318,44 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
 				     struct arche_apb_ctrl_drvdata *apb)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	int ret;
 
-	apb->resetn_gpio = of_get_named_gpio(np, "reset-gpios", 0);
-	if (apb->resetn_gpio < 0) {
-		dev_err(dev, "failed to get reset gpio\n");
-		return apb->resetn_gpio;
-	}
-	ret = devm_gpio_request_one(dev, apb->resetn_gpio,
-				    GPIOF_OUT_INIT_LOW, "apb-reset");
-	if (ret) {
-		dev_err(dev, "Failed requesting reset gpio %d\n",
-			apb->resetn_gpio);
+	apb->resetn = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(apb->resetn)) {
+		ret = PTR_ERR(apb->resetn);
+		dev_err(dev, "Failed requesting reset GPIO: %d\n", ret);
 		return ret;
 	}
 
-	apb->boot_ret_gpio = of_get_named_gpio(np, "boot-ret-gpios", 0);
-	if (apb->boot_ret_gpio < 0) {
-		dev_err(dev, "failed to get boot retention gpio\n");
-		return apb->boot_ret_gpio;
-	}
-	ret = devm_gpio_request_one(dev, apb->boot_ret_gpio,
-				    GPIOF_OUT_INIT_LOW, "boot retention");
-	if (ret) {
-		dev_err(dev, "Failed requesting bootret gpio %d\n",
-			apb->boot_ret_gpio);
+	apb->boot_ret = devm_gpiod_get(dev, "boot-ret", GPIOD_OUT_LOW);
+	if (IS_ERR(apb->boot_ret)) {
+		ret = PTR_ERR(apb->boot_ret);
+		dev_err(dev, "Failed requesting bootret GPIO: %d\n", ret);
 		return ret;
 	}
 
 	/* It's not mandatory to support power management interface */
-	apb->pwroff_gpio = of_get_named_gpio(np, "pwr-off-gpios", 0);
-	if (apb->pwroff_gpio < 0) {
-		dev_err(dev, "failed to get power off gpio\n");
-		return apb->pwroff_gpio;
-	}
-	ret = devm_gpio_request_one(dev, apb->pwroff_gpio,
-				    GPIOF_IN, "pwroff_n");
-	if (ret) {
-		dev_err(dev, "Failed requesting pwroff_n gpio %d\n",
-			apb->pwroff_gpio);
+	apb->pwroff = devm_gpiod_get_optional(dev, "pwr-off", GPIOD_IN);
+	if (IS_ERR(apb->pwroff)) {
+		ret = PTR_ERR(apb->pwroff);
+		dev_err(dev, "Failed requesting pwroff_n GPIO: %d\n", ret);
 		return ret;
 	}
 
 	/* Do not make clock mandatory as of now (for DB3) */
-	apb->clk_en_gpio = of_get_named_gpio(np, "clock-en-gpio", 0);
-	if (apb->clk_en_gpio < 0) {
-		dev_warn(dev, "failed to get clock en gpio\n");
-	} else if (gpio_is_valid(apb->clk_en_gpio)) {
-		ret = devm_gpio_request_one(dev, apb->clk_en_gpio,
-					    GPIOF_OUT_INIT_LOW, "apb_clk_en");
-		if (ret) {
-			dev_warn(dev, "Failed requesting APB clock en gpio %d\n",
-				 apb->clk_en_gpio);
-			return ret;
-		}
+	apb->clk_en = devm_gpiod_get_optional(dev, "clock-en", GPIOD_OUT_LOW);
+	if (IS_ERR(apb->clk_en)) {
+		ret = PTR_ERR(apb->clk_en);
+		dev_err(dev, "Failed requesting APB clock en GPIO: %d\n", ret);
+		return ret;
 	}
 
-	apb->pwrdn_gpio = of_get_named_gpio(np, "pwr-down-gpios", 0);
-	if (apb->pwrdn_gpio < 0)
-		dev_warn(dev, "failed to get power down gpio\n");
+	apb->pwrdn = devm_gpiod_get(dev, "pwr-down", GPIOD_OUT_LOW);
+	if (IS_ERR(apb->pwrdn)) {
+		ret = PTR_ERR(apb->pwrdn);
+		dev_warn(dev, "Failed requesting power down GPIO: %d\n", ret);
+		return ret;
+	}
 
 	/* Regulators are optional, as we may have fixed supply coming in */
 	apb->vcore = devm_regulator_get(dev, "vcore");
@@ -404,12 +378,8 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
 	}
 
 	/* Only applicable for platform >= V2 */
-	apb->spi_en_gpio = of_get_named_gpio(np, "spi-en-gpio", 0);
-	if (apb->spi_en_gpio >= 0) {
-		if (of_property_read_bool(pdev->dev.of_node,
-					  "spi-en-active-high"))
-			apb->spi_en_polarity_high = true;
-	}
+	if (of_property_read_bool(pdev->dev.of_node, "gb,spi-en-active-high"))
+		apb->spi_en_polarity_high = true;
 
 	return 0;
 }
-- 
2.17.1

