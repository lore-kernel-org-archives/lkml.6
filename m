Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07461C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D0219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPjfooST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392313AbeLVQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:55:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46626 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbeLVQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:55:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so3884175ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=khYaJXK66JJX6X9bQcWehD59/y6doDlGUTkiFU4hy3A=;
        b=TPjfooSTxfIwDC6vVbm+EEjTuEBFaYrD+qZxmvm3wXRmOhkB6Hwsknj8+Xdvl9vWCF
         Ce+W4YDQTnVJgLFiiR0OmUxJDuerIGKrDPSuG1yoGookXGCOh3wBWI7Lkg9UmeVRwIih
         xG+sAykMm3OjxCgPSP2xZG5MwRSlLXpGMlfCVipxHmV9LXNWU5kglCfwWyZfTXleGM2C
         HOdH+FSrj/hTVGD6DHkPIk4QFQQ9psqs+ArgyG5e9yilXoOTIFe/qbyTtlu6oUMEP5nY
         uD0HHfTankt2VrwSR/WbgxLbEbdYwN4M0rGdiuffe/9Ru/PqiOhyHDTwwJbY8KjxID5+
         uI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=khYaJXK66JJX6X9bQcWehD59/y6doDlGUTkiFU4hy3A=;
        b=CHxGprQlXNIX0fhq68rNAnvQHxgRAbRr9TGvBJF//3gW0lLdv75k4tZnWyQN3HfHvW
         FWvxG+a+drICYKaxUBtG6K3IPU8KbDACFVUsb6J/9ON4E74Kv1W/wOl9/IzhXl8c+5Cx
         cSdJf676iC+uXoOD53Gd2c+lpbAJ75RgYxUUw0gotNXA+8vBY565BPzpNcZSPglpmC7d
         TonefbpzaxzTMUv41Y3A4Z0xWBejb22C8O5Gn49VDBTg9MnKRS8tYLdWJPTuzdIRcayR
         x9f4hQtF7HENLXNqlzCw93XnyVlHc+LIWvsqV5DXXG2fifQcXZXIvkiimEKILPzlfg/e
         Xdfw==
X-Gm-Message-State: AJcUuke+mDNWkzXX2iXA8izNSZM4xKRQyjXZtwDTDwW3vYZke2m6g0M3
        vIcxSwV8vUT3NELUEyrrGxmNFkTS5Z0=
X-Google-Smtp-Source: ALg8bN4K6ZKVAFRMU3aT5rJbsKn9nHJM2oxbdA0DXxUl86q0G1W5kYMsOpQdCv479OwBEdBuxNQsfw==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr6828699plm.212.1545490390132;
        Sat, 22 Dec 2018 06:53:10 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id 5sm43585773pfz.149.2018.12.22.06.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:53:09 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:23:02 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v4 4/4] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <fa242dd022340b8cd8fa6bab9138a718980b3871.1545488665.git.nishadkamdar@gmail.com>
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

Use the gpiod interface instead of the deprecated
old non-descriptor interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v4:
 - Move 'gpio_desc *svc_sysboot' below the reset flag
   as it is more logical to have reset flag below
   reset gpio.
 - Remove a few unnecessary line breaks.
Changes in v3:
 - Add this patch to a patchset.
Changes in v2:
 - Move comment to the same line as to what it applies to.
---
 drivers/staging/greybus/arche-platform.c | 124 ++++++++---------------
 1 file changed, 41 insertions(+), 83 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 4c36e88766e7..b4b101ba96df 100644
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
 	bool is_reset_act_hi;
-	int svc_sysboot_gpio;
-	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
+	struct gpio_desc *svc_sysboot;
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
@@ -224,10 +222,9 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 
 	dev_info(arche_pdata->dev, "Booting from cold boot state\n");
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
-			arche_pdata->is_reset_act_hi);
+	svc_reset_onoff(arche_pdata->svc_reset, arche_pdata->is_reset_act_hi);
 
-	gpio_set_value(arche_pdata->svc_sysboot_gpio, 0);
+	gpiod_set_value(arche_pdata->svc_sysboot, 0);
 	usleep_range(100, 200);
 
 	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
@@ -238,8 +235,7 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 	}
 
 	/* bring SVC out of reset */
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
-			!arche_pdata->is_reset_act_hi);
+	svc_reset_onoff(arche_pdata->svc_reset, !arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_ACTIVE);
 
@@ -259,10 +255,9 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 
 	dev_info(arche_pdata->dev, "Switching to FW flashing state\n");
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
-			arche_pdata->is_reset_act_hi);
+	svc_reset_onoff(arche_pdata->svc_reset, arche_pdata->is_reset_act_hi);
 
-	gpio_set_value(arche_pdata->svc_sysboot_gpio, 1);
+	gpiod_set_value(arche_pdata->svc_sysboot, 1);
 
 	usleep_range(100, 200);
 
@@ -273,8 +268,7 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 		return ret;
 	}
 
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
-			!arche_pdata->is_reset_act_hi);
+	svc_reset_onoff(arche_pdata->svc_reset,	!arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_FW_FLASHING);
 
@@ -305,8 +299,7 @@ arche_platform_poweroff_seq(struct arche_platform_drvdata *arche_pdata)
 	clk_disable_unprepare(arche_pdata->svc_ref_clk);
 
 	/* As part of exit, put APB back in reset state */
-	svc_reset_onoff(arche_pdata->svc_reset_gpio,
-			arche_pdata->is_reset_act_hi);
+	svc_reset_onoff(arche_pdata->svc_reset,	arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
 }
@@ -435,6 +428,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
+	unsigned int flags;
 
 	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
 				   GFP_KERNEL);
@@ -444,61 +438,33 @@ static int arche_platform_probe(struct platform_device *pdev)
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
 
@@ -515,19 +481,11 @@ static int arche_platform_probe(struct platform_device *pdev)
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
 
@@ -538,7 +496,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	spin_lock_init(&arche_pdata->wake_lock);
 	mutex_init(&arche_pdata->platform_state_mutex);
 	arche_pdata->wake_detect_irq =
-		gpio_to_irq(arche_pdata->wake_detect_gpio);
+		gpiod_to_irq(arche_pdata->wake_detect);
 
 	ret = devm_request_threaded_irq(dev, arche_pdata->wake_detect_irq,
 					arche_platform_wd_irq,
-- 
2.17.1

