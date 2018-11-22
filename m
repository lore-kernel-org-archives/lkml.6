Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F77FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309B8206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UErKX1bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309B8206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbeKWDts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:49:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38637 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeKWDts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:49:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so9498006plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VX7QHFAOCrCD1nBdRXQOeK4YOdx1qQiZskFq14Q/6bE=;
        b=UErKX1bI2n65+BOiIyFyLkZuYxQOsgwNaR5BZlFqpcNuhRDLgwknLYCm8j0qoG6t9K
         bfq2XIOgvc/I+5XRhaxHjuraXzGT4/MccuiWUFK2uOtvUKiTGqrrARiN/+BWbEciOzPS
         FqhQLJzpYZV0dsMtVzdn5CbgxD81B1C27Ody2YhJGlrdd58+3QdSIwuQs1ZXvP0TqE9O
         fELRS2BE+FHvPeZBVsYAktG+ho9gjrAhLWxZCon7cWqUt2LDHhukAYxUUcgJmY+V/zNw
         PNAhu16oz/QQKv5ERi+HtA3SG/xiDMx9c1RAzolA6sFiKEBH7Ykp0i4qtH+JAP0kwzMI
         Oq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VX7QHFAOCrCD1nBdRXQOeK4YOdx1qQiZskFq14Q/6bE=;
        b=rArfdLJTkiIbzqkCCFXnSysSJ77hZCEPxsC7A4b9w+ta3wrXneiwMhVJWihNkpvFBB
         RzCqu0WUk3qov6PfTl03pYaXI6YR+zxCk34RHQoKJbBgEAfYMGBXN/9uJniQRcIilrJN
         CyvjsnyO1yZOlwKrAgQZ/IJVhcfx6RGko+eRZRH+b3uP6kn+RR606a9jmwNjlAq4Vjun
         bQQEP7EnGs2jLem7yzf9cXtlu2mzNVJNSSCpPlBvo3Ht8t7sul77oVG8gWb/Gnd5kgmd
         tVtXW6Ln1nil5n4ya4c9vLuwwBkHPgVNvw4EMaKHBBTYrvPkpYNLGTPUyPKvhbMZnsJM
         +jrw==
X-Gm-Message-State: AA+aEWZQutIrd15nHTByODnrMQViEqs8nBvGR+WdcEo5jVL2cYVg1joi
        ZQ1VNrydh251xFCnMn24dTE=
X-Google-Smtp-Source: AFSGD/X/2o3TtstZDl9o4mJwo9CJIuftsbYc4sLSiGDu4maNXPf8arjFYYQrV+oR++p6IfN2sNLInA==
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr11974993pld.53.1542906571708;
        Thu, 22 Nov 2018 09:09:31 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id s2sm32520130pfa.167.2018.11.22.09.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 09:09:31 -0800 (PST)
Date:   Thu, 22 Nov 2018 22:39:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <2200db633d8e723b881ef355527afaef0d5ccf24.1542898267.git.nishadkamdar@gmail.com>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542898267.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated
old non-descriptor interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
 - Move comment to the same line as to what it applies to.
---
 drivers/staging/greybus/arche-platform.c | 119 ++++++++---------------
 1 file changed, 41 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 4c36e88766e7..a5cea79d8e32 100644
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
@@ -45,14 +44,14 @@ enum svc_wakedetect_state {
 
 struct arche_platform_drvdata {
 	/* Control GPIO signals to and from AP <=> SVC */
-	int svc_reset_gpio;
+	struct gpio_desc *svc_reset;
+	struct gpio_desc *svc_sysboot;
 	bool is_reset_act_hi;
-	int svc_sysboot_gpio;
-	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
+	struct gpio_desc *wake_detect; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
 
 	enum arche_platform_state state;
 
-	int svc_refclk_req;
+	struct gpio_desc *svc_refclk_req;
 	struct clk *svc_ref_clk;
 
 	struct pinctrl *pinctrl;
@@ -85,9 +84,9 @@ static void arche_platform_set_wake_detect_state(
 	arche_pdata->wake_detect_state = state;
 }
 
-static inline void svc_reset_onoff(unsigned int gpio, bool onoff)
+static inline void svc_reset_onoff(struct gpio_desc *gpio, bool onoff)
 {
-	gpio_set_value(gpio, onoff);
+	gpiod_set_value(gpio, onoff);
 }
 
 static int apb_cold_boot(struct device *dev, void *data)
@@ -116,7 +115,6 @@ static int apb_poweroff(struct device *dev, void *data)
 static void arche_platform_wd_irq_en(struct arche_platform_drvdata *arche_pdata)
 {
 	/* Enable interrupt here, to read event back from SVC */
-	gpio_direction_input(arche_pdata->wake_detect_gpio);
 	enable_irq(arche_pdata->wake_detect_irq);
 }
 
@@ -160,7 +158,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 
 	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
 
-	if (gpio_get_value(arche_pdata->wake_detect_gpio)) {
+	if (gpiod_get_value(arche_pdata->wake_detect)) {
 		/* wake/detect rising */
 
 		/*
@@ -224,10 +222,10 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 
 	dev_info(arche_pdata->dev, "Booting from cold boot state\n");
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			arche_pdata->is_reset_act_hi);
 
-	gpio_set_value(arche_pdata->svc_sysboot_gpio, 0);
+	gpiod_set_value(arche_pdata->svc_sysboot, 0);
 	usleep_range(100, 200);
 
 	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
@@ -238,7 +236,7 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 	}
 
 	/* bring SVC out of reset */
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			!arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_ACTIVE);
@@ -259,10 +257,10 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 
 	dev_info(arche_pdata->dev, "Switching to FW flashing state\n");
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			arche_pdata->is_reset_act_hi);
 
-	gpio_set_value(arche_pdata->svc_sysboot_gpio, 1);
+	gpiod_set_value(arche_pdata->svc_sysboot, 1);
 
 	usleep_range(100, 200);
 
@@ -273,7 +271,7 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 		return ret;
 	}
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			!arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_FW_FLASHING);
@@ -305,7 +303,7 @@ arche_platform_poweroff_seq(struct arche_platform_drvdata *arche_pdata)
 	clk_disable_unprepare(arche_pdata->svc_ref_clk);
 
 	/* As part of exit, put APB back in reset state */
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
+	svc_reset_onoff(arche_pdata->svc_reset,
 			arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
@@ -435,6 +433,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
+	unsigned int flags;
 
 	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
 				   GFP_KERNEL);
@@ -444,61 +443,33 @@ static int arche_platform_probe(struct platform_device *pdev)
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
 
@@ -515,19 +486,11 @@ static int arche_platform_probe(struct platform_device *pdev)
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
 
@@ -538,7 +501,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	spin_lock_init(&arche_pdata->wake_lock);
 	mutex_init(&arche_pdata->platform_state_mutex);
 	arche_pdata->wake_detect_irq =
-		gpio_to_irq(arche_pdata->wake_detect_gpio);
+		gpiod_to_irq(arche_pdata->wake_detect);
 
 	ret = devm_request_threaded_irq(dev, arche_pdata->wake_detect_irq,
 					arche_platform_wd_irq,
-- 
2.17.1

