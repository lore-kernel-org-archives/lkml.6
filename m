Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273F20989
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iykUcICm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8273F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKKPcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 10:32:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35064 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeKKPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 10:32:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so2601852pgu.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TBOctfYOpPlIzLqNi4gt6PqmTVhT/HwRQN+0tcQEQKI=;
        b=iykUcICm/lx65ZYz3eMGViQxdbaEpDYzApoll0qYtTB7vOXO7RyCNMwto8VCBXDGDj
         TciqJjnCcVGgmneXT3rslxxx0AaMXZWeiz9aLCiqCeSR6FeRMmknJIl+0r34mY5ONrlx
         GpqGKDPcY8ywHuZFWeupXq5/nglN4ZcZmgMSz66NUrAjnhNpXz+6wpmAftW6YSfSfTGY
         e2gVMCk9Idr+MdBIor7E84c9liePYxUluZ/m3F86X92BHeYYCGrUEFUJGbAGlXeuZ9kS
         KYpgjpJIGXxKHqMnpB+MNkHtoLQi8zE8mRYN+iLy5kc+lJuiKYns6pPMDCXtUzgdwsvE
         QqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TBOctfYOpPlIzLqNi4gt6PqmTVhT/HwRQN+0tcQEQKI=;
        b=ov52wvuHEqIW4yt+mJj8kjBh/qNN50mrsU+ISQttZBZsCFaJvu/vn0F659ubhch0Yu
         mYl+s2sET9oJMGbMLrX81cHOfc3mcsb9k4NqYZFtZhQEfGueZ+Ky9rMS0OSaa8ZGXDK6
         wghnWizHYChrfgnkhCsTSfgOyvsksf8aW6eqEIa8GnzuPGYSDQBqYERJirBz3uyRNpNv
         oMo9yJ62r8tbIPAUTPl4qcfZmmLT4TWVGseFR9EUh+9EIkqzFCELbYVnAxNYMNnR7hNI
         cB3TL986pZ3S8Bv5ecX4zVerBsFG4N98GeWZqCGWmTWHnhrhONhyrePV6dnQZox1LN81
         GqNg==
X-Gm-Message-State: AGRZ1gLUKn7osrOKpvYfoojan7mcqZuXm1vsR2BkgK7pIXBQdewRfZP8
        mF8QhhuIsovKlDRfVdh8fuo=
X-Google-Smtp-Source: AJdET5eS4j5SejoIcuJJmDDny/aZP1czd9iCfaworikZD7CT2G41I99WgpiPTbhtoEVbZDBTyYk/6w==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr13528547pgi.301.1541915067350;
        Sat, 10 Nov 2018 21:44:27 -0800 (PST)
Received: from nishad ([106.193.161.4])
        by smtp.gmail.com with ESMTPSA id s184sm13941023pgc.38.2018.11.10.21.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 21:44:26 -0800 (PST)
Date:   Sun, 11 Nov 2018 11:14:14 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: arche-apb-ctrl.c: Switch to the gpio
 descriptor interface
Message-ID: <20181111054405.GA32548@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 158 ++++++++++-------------
 1 file changed, 65 insertions(+), 93 deletions(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index cc8d6fc831b4..fd19e2394c9c 100644
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
@@ -20,17 +19,16 @@
 #include <linux/spinlock.h>
 #include "arche_platform.h"
 
-
 static void apb_bootret_deassert(struct device *dev);
 
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
@@ -38,28 +36,28 @@ struct arche_apb_ctrl_drvdata {
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
+	gpiod_set_value(gpio, 1);
 }
 
-static inline void assert_reset(unsigned int gpio)
+static inline void assert_reset(struct gpio_desc *gpio)
 {
-	gpio_set_value(gpio, 0);
+	gpiod_set_value(gpio, 0);
 }
 
 /*
@@ -76,11 +74,11 @@ static int coldboot_seq(struct platform_device *pdev)
 		return 0;
 
 	/* Hold APB in reset state */
-	assert_reset(apb->resetn_gpio);
+	assert_reset(apb->resetn);
 
 	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
-	    gpio_is_valid(apb->spi_en_gpio))
-		devm_gpio_free(dev, apb->spi_en_gpio);
+	    apb->spi_en)
+		devm_gpiod_put(dev, apb->spi_en);
 
 	/* Enable power to APB */
 	if (!IS_ERR(apb->vcore)) {
@@ -102,13 +100,13 @@ static int coldboot_seq(struct platform_device *pdev)
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
 
@@ -120,6 +118,7 @@ static int fw_flashing_seq(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct arche_apb_ctrl_drvdata *apb = platform_get_drvdata(pdev);
 	int ret;
+	unsigned long flags;
 
 	if (apb->init_disabled ||
 	    apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING)
@@ -137,25 +136,20 @@ static int fw_flashing_seq(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (gpio_is_valid(apb->spi_en_gpio)) {
-		unsigned long flags;
-
-		if (apb->spi_en_polarity_high)
-			flags = GPIOF_OUT_INIT_HIGH;
-		else
-			flags = GPIOF_OUT_INIT_LOW;
+	if (apb->spi_en_polarity_high)
+		flags = GPIOD_OUT_HIGH;
+	else
+		flags = GPIOD_OUT_LOW;
 
-		ret = devm_gpio_request_one(dev, apb->spi_en_gpio,
-					    flags, "apb_spi_en");
-		if (ret) {
-			dev_err(dev, "Failed requesting SPI bus en gpio %d\n",
-				apb->spi_en_gpio);
-			return ret;
-		}
+	apb->spi_en = devm_gpiod_get(dev, "gb,apb_spi_en", flags);
+	if (IS_ERR(apb->spi_en)) {
+		ret = PTR_ERR(apb->spi_en);
+		dev_err(dev, "Failed requesting SPI bus en GPIO: %d\n", ret);
+		return ret;
 	}
 
 	/* for flashing device should be in reset state */
-	assert_reset(apb->resetn_gpio);
+	assert_reset(apb->resetn);
 	apb->state = ARCHE_PLATFORM_STATE_FW_FLASHING;
 
 	return 0;
@@ -178,8 +172,8 @@ static int standby_boot_seq(struct platform_device *pdev)
 		return 0;
 
 	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
-	    gpio_is_valid(apb->spi_en_gpio))
-		devm_gpio_free(dev, apb->spi_en_gpio);
+	    apb->spi_en)
+		devm_gpiod_put(dev, apb->spi_en);
 
 	/*
 	 * As per WDM spec, do nothing
@@ -203,12 +197,12 @@ static void poweroff_seq(struct platform_device *pdev)
 		return;
 
 	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
-	    gpio_is_valid(apb->spi_en_gpio))
-		devm_gpio_free(dev, apb->spi_en_gpio);
+	    apb->spi_en)
+		devm_gpiod_put(dev, apb->spi_en);
 
 	/* disable the clock */
-	if (gpio_is_valid(apb->clk_en_gpio))
-		gpio_set_value(apb->clk_en_gpio, 0);
+	if (apb->clk_en)
+		gpiod_set_value(apb->clk_en, 0);
 
 	if (!IS_ERR(apb->vcore) && regulator_is_enabled(apb->vcore) > 0)
 		regulator_disable(apb->vcore);
@@ -217,7 +211,7 @@ static void poweroff_seq(struct platform_device *pdev)
 		regulator_disable(apb->vio);
 
 	/* As part of exit, put APB back in reset state */
-	assert_reset(apb->resetn_gpio);
+	assert_reset(apb->resetn);
 	apb->state = ARCHE_PLATFORM_STATE_OFF;
 
 	/* TODO: May have to send an event to SVC about this exit */
@@ -227,7 +221,7 @@ static void apb_bootret_deassert(struct device *dev)
 {
 	struct arche_apb_ctrl_drvdata *apb = dev_get_drvdata(dev);
 
-	gpio_set_value(apb->boot_ret_gpio, 0);
+	gpiod_set_value(apb->boot_ret, 0);
 }
 
 int apb_ctrl_coldboot(struct device *dev)
@@ -326,63 +320,44 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
 	struct device_node *np = dev->of_node;
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
+	apb->resetn = devm_gpiod_get(dev, "gb,reset-gpios", GPIOD_OUT_LOW);
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
+	apb->boot_ret = devm_gpiod_get(dev, "gb,boot-ret-gpios", GPIOD_OUT_LOW);
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
+	apb->pwroff = devm_gpiod_get_optional(dev, "gb,pwr-off-gpios",
+					      GPIOD_IN);
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
+	apb->clk_en = devm_gpiod_get_optional(dev, "gb,clock-en-gpio",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(apb->clk_en)) {
+		ret = PTR_ERR(apb->clk_en);
+		dev_err(dev, "Failed requesting APB clock en GPIO: %d\n", ret);
+		return ret;
 	}
 
-	apb->pwrdn_gpio = of_get_named_gpio(np, "pwr-down-gpios", 0);
-	if (apb->pwrdn_gpio < 0)
-		dev_warn(dev, "failed to get power down gpio\n");
+	apb->pwrdn = devm_gpiod_get(dev, "gb,pwr-down-gpios", GPIOD_OUT_LOW);
+	if (IF_ERR(apb->pwrdn)) {
+		ret = PTR_ERR(apb->pwrdn);
+		dev_warn(dev, "Failed requesting power down GPIO: %d\n", ret);
+		return ret;
+	}
 
 	/* Regulators are optional, as we may have fixed supply coming in */
 	apb->vcore = devm_regulator_get(dev, "vcore");
@@ -405,11 +380,8 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
 	}
 
 	/* Only applicable for platform >= V2 */
-	apb->spi_en_gpio = of_get_named_gpio(np, "spi-en-gpio", 0);
-	if (apb->spi_en_gpio >= 0) {
-		if (of_property_read_bool(pdev->dev.of_node,
-					  "spi-en-active-high"))
-			apb->spi_en_polarity_high = true;
+	if (of_property_read_bool(pdev->dev.of_node, "gb,spi-en-active-high"))
+		apb->spi_en_polarity_high = true;
 	}
 
 	return 0;
-- 
2.17.1

