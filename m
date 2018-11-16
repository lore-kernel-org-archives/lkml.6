Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9572087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX3Sp4Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9572087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbeKQBaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:30:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43478 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeKQBaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:30:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so11303001plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rjy3Q29CGAvT9RwPhAHp+YHLS5zai+6HpMPpunRuZjA=;
        b=JX3Sp4CzyQ9C3W6ZINrBHXVJL8hXBsNmB3Jk0tCTPoRkGwQ0Tn9VZtz82v4RnyYnf8
         DP6DiO700OATGVMWWHZ22+AFfhMMrpJaBZyc2WvYm58EAYn693tbKIewADKgIO9lJi14
         5ODCgBZsINmxw7WgEIU/S7s24aiWd6iZh10JzyVtWjc75nvWCt9aAruBsOOM6Xe7WusT
         iW1nnLV2FZtJ9P9tirAoqr8r2UkMVLwf306T0tPNS1Yjf6V6QM75R9wt9hgSK8X969uD
         GB+jyj+pY3wSz+IT7GOt5SHzWNobCK+kTb6lbBJWkij1737Hx0OV0X+L6teQXlpKQVIu
         l3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rjy3Q29CGAvT9RwPhAHp+YHLS5zai+6HpMPpunRuZjA=;
        b=BYQb91EGSAb1Qln7beeXTGQcT6pSpMUshDP3LlClXINAivbRToQs4VhAW3L2tz7WFo
         tXNEGxCghQnIBZe9boOhBsJLhdWtvXVphfCJGH/l+qBTkH9IVqB7rbOhwDGgJ66sZM3p
         9RXNAHuezv94/TfDjKOMtPEfXNUGRttbU3nPTrQUbEkIyAzNI0iO6sflDgaRM93N7Ua1
         ikpEowGDk8VJDlCKNmAn64R4X96Ho60cCoQLA8RVqdnlY0y+sJcU65ESlS5uCz2iYDDy
         R9pzRKNxsi5ZJpvmnrkcq7G4bY13t82Sd5GjlwdU91D9E88fR0CTG8vuHY5vYQfssySy
         6Mzg==
X-Gm-Message-State: AGRZ1gJEtVirVmUZMLA3WBUN3JEdOnrj6tBssbe0GJ8+upM8+lYIq4jt
        6dtoNKgG6miS90pB56s1mV7LRc+qQJHso4bL
X-Google-Smtp-Source: AJdET5ejJXDlgYopIHSEBXVAskl0tol3Aa26eS9ysCkZvXCZEETTZCmkr1lYEtTyNCoJqQsOihzzlw==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9-v6mr11452034plo.183.1542381471676;
        Fri, 16 Nov 2018 07:17:51 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g5sm27851319pgu.57.2018.11.16.07.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:17:51 -0800 (PST)
Date:   Fri, 16 Nov 2018 20:47:44 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <20181116151740.GA12250@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated
old non-descriptor interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 120 ++++++++---------------
 1 file changed, 42 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 4c36e88766e7..a826a1835628 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -8,10 +8,9 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -45,14 +44,15 @@ enum svc_wakedetect_state {
 
 struct arche_platform_drvdata {
 	/* Control GPIO signals to and from AP <=> SVC */
-	int svc_reset_gpio;
+	struct gpio_desc *svc_reset;
+	struct gpio_desc *svc_sysboot;
 	bool is_reset_act_hi;
-	int svc_sysboot_gpio;
-	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
+	struct gpio_desc *wake_detect;
+	/* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
 
 	enum arche_platform_state state;
 
-	int svc_refclk_req;
+	struct gpio_desc *svc_refclk_req;
 	struct clk *svc_ref_clk;
 
 	struct pinctrl *pinctrl;
@@ -85,9 +85,9 @@ static void arche_platform_set_wake_detect_state(
 	arche_pdata->wake_detect_state = state;
 }
 
-static inline void svc_reset_onoff(unsigned int gpio, bool onoff)
+static inline void svc_reset_onoff(struct gpio_desc *gpio, bool onoff)
 {
-	gpio_set_value(gpio, onoff);
+	gpiod_set_value(gpio, onoff);
 }
 
 static int apb_cold_boot(struct device *dev, void *data)
@@ -116,7 +116,6 @@ static int apb_poweroff(struct device *dev, void *data)
 static void arche_platform_wd_irq_en(struct arche_platform_drvdata *arche_pdata)
 {
 	/* Enable interrupt here, to read event back from SVC */
-	gpio_direction_input(arche_pdata->wake_detect_gpio);
 	enable_irq(arche_pdata->wake_detect_irq);
 }
 
@@ -160,7 +159,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 
 	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
 
-	if (gpio_get_value(arche_pdata->wake_detect_gpio)) {
+	if (gpiod_get_value(arche_pdata->wake_detect)) {
 		/* wake/detect rising */
 
 		/*
@@ -224,10 +223,10 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 
 	dev_info(arche_pdata->dev, "Booting from cold boot state\n");
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			arche_pdata->is_reset_act_hi);
 
-	gpio_set_value(arche_pdata->svc_sysboot_gpio, 0);
+	gpiod_set_value(arche_pdata->svc_sysboot, 0);
 	usleep_range(100, 200);
 
 	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
@@ -238,7 +237,7 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 	}
 
 	/* bring SVC out of reset */
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			!arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_ACTIVE);
@@ -259,10 +258,10 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 
 	dev_info(arche_pdata->dev, "Switching to FW flashing state\n");
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			arche_pdata->is_reset_act_hi);
 
-	gpio_set_value(arche_pdata->svc_sysboot_gpio, 1);
+	gpiod_set_value(arche_pdata->svc_sysboot, 1);
 
 	usleep_range(100, 200);
 
@@ -273,7 +272,7 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 		return ret;
 	}
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			!arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_FW_FLASHING);
@@ -305,7 +304,7 @@ arche_platform_poweroff_seq(struct arche_platform_drvdata *arche_pdata)
 	clk_disable_unprepare(arche_pdata->svc_ref_clk);
 
 	/* As part of exit, put APB back in reset state */
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
@@ -435,6 +434,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
+	unsigned int flags;
 
 	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
 				   GFP_KERNEL);
@@ -444,61 +444,33 @@ static int arche_platform_probe(struct platform_device *pdev)
 	/* setup svc reset gpio */
 	arche_pdata->is_reset_act_hi = of_property_read_bool(np,
 							     "svc,reset-active-high");
-	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
-							"svc,reset-gpio",
-							0);
-	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
-		dev_err(dev, "failed to get reset-gpio\n");
-		return arche_pdata->svc_reset_gpio;
-	}
-	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
-	if (ret) {
-		dev_err(dev, "failed to request svc-reset gpio:%d\n", ret);
-		return ret;
-	}
-	ret = gpio_direction_output(arche_pdata->svc_reset_gpio,
-				    arche_pdata->is_reset_act_hi);
-	if (ret) {
-		dev_err(dev, "failed to set svc-reset gpio dir:%d\n", ret);
+	if (arche_pdata->is_reset_act_hi)
+		flags = GPIOD_OUT_HIGH;
+	else
+		flags = GPIOD_OUT_LOW;
+
+	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset-gpio", flags);
+	if (IS_ERR(arche_pdata->svc_reset)) {
+		ret = PTR_ERR(arche_pdata->svc_reset);
+		dev_err(dev, "failed to request svc-reset GPIO:%d\n", ret);
 		return ret;
 	}
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
 
-	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
-							  "svc,sysboot-gpio",
-							  0);
-	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
-		dev_err(dev, "failed to get sysboot gpio\n");
-		return arche_pdata->svc_sysboot_gpio;
-	}
-	ret = devm_gpio_request(dev, arche_pdata->svc_sysboot_gpio, "sysboot0");
-	if (ret) {
-		dev_err(dev, "failed to request sysboot0 gpio:%d\n", ret);
-		return ret;
-	}
-	ret = gpio_direction_output(arche_pdata->svc_sysboot_gpio, 0);
-	if (ret) {
-		dev_err(dev, "failed to set svc-reset gpio dir:%d\n", ret);
+	arche_pdata->svc_sysboot = devm_gpiod_get(dev, "svc,sysboot-gpio",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(arche_pdata->svc_sysboot)) {
+		ret = PTR_ERR(arche_pdata->svc_sysboot);
+		dev_err(dev, "failed to request sysboot0 GPIO: %d\n", ret);
 		return ret;
 	}
 
 	/* setup the clock request gpio first */
-	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
-							"svc,refclk-req-gpio",
-							0);
-	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
-		dev_err(dev, "failed to get svc clock-req gpio\n");
-		return arche_pdata->svc_refclk_req;
-	}
-	ret = devm_gpio_request(dev, arche_pdata->svc_refclk_req,
-				"svc-clk-req");
-	if (ret) {
-		dev_err(dev, "failed to request svc-clk-req gpio: %d\n", ret);
-		return ret;
-	}
-	ret = gpio_direction_input(arche_pdata->svc_refclk_req);
-	if (ret) {
-		dev_err(dev, "failed to set svc-clk-req gpio dir :%d\n", ret);
+	arche_pdata->svc_refclk_req = devm_gpiod_get(dev, "svc,refclk-req-gpio",
+						     GPIOD_IN);
+	if (IS_ERR(arche_pdata->svc_refclk_req)) {
+		ret = PTR_ERR(arche_pdata->svc_refclk_req);
+		dev_err(dev, "failed to request svc-clk-req GPIO: %d\n", ret);
 		return ret;
 	}
 
@@ -515,19 +487,11 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->num_apbs = of_get_child_count(np);
 	dev_dbg(dev, "Number of APB's available - %d\n", arche_pdata->num_apbs);
 
-	arche_pdata->wake_detect_gpio = of_get_named_gpio(np,
-							  "svc,wake-detect-gpio",
-							  0);
-	if (arche_pdata->wake_detect_gpio < 0) {
-		dev_err(dev, "failed to get wake detect gpio\n");
-		return arche_pdata->wake_detect_gpio;
-	}
-
-	ret = devm_gpio_request(dev, arche_pdata->wake_detect_gpio,
-				"wake detect");
-	if (ret) {
-		dev_err(dev, "Failed requesting wake_detect gpio %d\n",
-			arche_pdata->wake_detect_gpio);
+	arche_pdata->wake_detect = devm_gpiod_get(dev, "svc,wake-detect-gpio",
+						  GPIOD_IN);
+	if (IS_ERR(arche_pdata->wake_detect)) {
+		ret = PTR_ERR(arche_pdata->wake_detect);
+		dev_err(dev, "Failed requesting wake_detect GPIO %d\n", ret);
 		return ret;
 	}
 
@@ -538,7 +502,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	spin_lock_init(&arche_pdata->wake_lock);
 	mutex_init(&arche_pdata->platform_state_mutex);
 	arche_pdata->wake_detect_irq =
-		gpio_to_irq(arche_pdata->wake_detect_gpio);
+		gpiod_to_irq(arche_pdata->wake_detect);
 
 	ret = devm_request_threaded_irq(dev, arche_pdata->wake_detect_irq,
 					arche_platform_wd_irq,
-- 
2.17.1

