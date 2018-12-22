Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DD7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B034219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rho7A4F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392342AbeLVQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:56:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40004 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbeLVQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:56:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so4033197pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qL2jEx/LSxJ8wEnr1hT8Lz39PGS/nM6GagE3hQLkSkw=;
        b=Rho7A4F+3eN0Blr5Il0GwIj4zsHQz/OVoX9WV7Sak1FBomEJp1bpnAsm7K5O7GHKaN
         HOTbuOi/HkwczD8mqMDBgPmra+vn8pYBwgw4rx+ULdjr81EBxVxkfUJRuy2xzjIkoAVh
         nY76kHsAflbR0AOIQZWbJc5T8n6qao5H9/iu3yjxWAFyvI6+NI19W3DPjClPZFbBdf55
         U4mgvOVswfLGC10GCiDDlmU4HHhHKMv9NQpgDyfbmnRi1mgnE1witJF9PtuGjk/nEOdt
         hvQGkyLjA6rCQI1IdgI3kacywF9k7nXJ5ZkPTjWHxtCg6rirosopIcVVQr99u0EzTkS3
         PTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qL2jEx/LSxJ8wEnr1hT8Lz39PGS/nM6GagE3hQLkSkw=;
        b=eu3AG4/lRWgVSdiXJMftXxr3wEZaLmdC84zUjnsjnnKm4gCgGJRWhfQDv+GtcPbP4i
         WOXGmW3n4Omo7rjHIAujV0uz0OfMP34t3mWs9Xo0gP+sie6s5J+xTin7Z6o0TUJ+JAx6
         TmBFKWqKU835RqE5QVisR35BRedAl56NjJAIvnI1ygQCqkIhBOR4tJ6hjIMXeBaw0bTi
         4+mbGqRzIy8mf0zYGSUIvckgbHwsiFUPo2ksnhWJXp5bvGpJi7hS/jeyb9Ssz/ZIUiX8
         qCAFswVWJduCINqYqBJTghQXm5vP0dMA6FcD6yf3ckpUuJgV6KUloG8JGpkNG3rTOIMD
         04Ww==
X-Gm-Message-State: AA+aEWYpvI8yaSCwuviSCUo8t/ksXy7B2VSm+SZ/iEe+4Ti9OO4Zkj4r
        DP3BCWVY+3fKx3psnA36sOpHrhc3uLU=
X-Google-Smtp-Source: AFSGD/VFLNucoqdPwwIx2xIeG2BjIyT5TTPLqRL03grqx98Xt8BcE8oKV39Bul022a34jjJNhKqpxA==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr6889006pfe.148.1545490337202;
        Sat, 22 Dec 2018 06:52:17 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id f64sm77511194pfh.0.2018.12.22.06.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:52:16 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:22:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v4 3/4] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <54ba56b6b071ba48ca06713a108ccfb542c5d2e5.1545488665.git.nishadkamdar@gmail.com>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
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
 drivers/staging/greybus/arche-apb-ctrl.c | 154 ++++++++++-------------
 1 file changed, 63 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index be5ffed90bcf..57eecd0dd0a6 100644
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
+		apb->spi_en = devm_gpiod_get(dev, "gb,spi-en-gpio", flags);
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
@@ -322,66 +318,46 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
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
+	if (IS_ERR(apb->pwrdn)) {
+		ret = PTR_ERR(apb->pwrdn);
+		dev_warn(dev, "Failed requesting power down GPIO: %d\n", ret);
+		return ret;
+	}
 
 	/* Regulators are optional, as we may have fixed supply coming in */
 	apb->vcore = devm_regulator_get(dev, "vcore");
@@ -404,12 +380,8 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
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

