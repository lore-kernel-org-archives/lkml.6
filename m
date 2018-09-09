Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2AFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173B02064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avzo7uE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173B02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeIJHbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:31:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45443 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeIJHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:31:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so16131129lff.12;
        Sun, 09 Sep 2018 19:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XoqN39JitX7xZtkRTukcI6J9+V8DE/e1EcuIx9Flh4Y=;
        b=avzo7uE1j7gj2PvtAGafXmxdWetQfTv9sHM9tsuLYh61cMk+fMFuSX2ZDWCYArw/Im
         RLvTeMEgLC0i15v5ZBTlT8yMfF13qaC436YECuAjbe0eIgYbHBkEaJq0CYt1cD9tpLik
         zhH+Kwt/7bo85TbefIwj5Z563fA9n8ly/PPPpH1zqg4+hN8QAMnEmIUq94IxF05lg078
         /RrQATfxSHLZCOc0Zm246zuVAlqrvMZ4mt7s9rpAkJW3aNlNY+kl+lAWSUkl9KMoXsya
         6w86nh5UTTJjlqS1nrL/Rq5gkljM5OHn7M4Z26YyVMbxvcnA0+2Y0iVZtz3n9aJS5LSR
         L2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XoqN39JitX7xZtkRTukcI6J9+V8DE/e1EcuIx9Flh4Y=;
        b=nso+gayoE6tx34fKlBbK1ynuHjzWSIpQ3oZi61EAiRQ6TEPQzBKGh7lywZXU3s9v+Q
         Vs50unPFnwrdZlZCNre3YgOvrLwMGxYqkQymnt5Fi8kLbM/2Z9KYOConpnEk0G8KxCAN
         T4FFM3WXLU7F/Xl2xfu905UaIpdEMU6v9OX5RM/MpeFA76zU3z9xw59gwWY4lrI5KwYa
         oOwKSu+4JJpNIf1IQE0jLyGbMgL1Qt+BnPAX9fbBEBSiAU4Nng9pdASzjoWc8qfXt7Fl
         JRBnfKXLXp/LzyfkLmZIcrZM4u7lrCYx4siutqD7SUVITqkhyDAmsLMakp3AsPeVw4DF
         b3rA==
X-Gm-Message-State: APzg51B4O640nAveG5birsWSQG/E3v1kSrKRyDTZoS/ywUMxwt3cT8wC
        mhBdqatUjZQ1aDkSaJSrGD9Mhp8oTSc=
X-Google-Smtp-Source: ANB0VdZX7F/9IXakAPtwqtyN/6uJXfTZwSPuNxfykEwjhFd4V4g+uS8le0u5DcWySOcx86nOrOGdhg==
X-Received: by 2002:a19:944d:: with SMTP id w74-v6mr10386025lfd.10.1536533707266;
        Sun, 09 Sep 2018 15:55:07 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2401574ljg.12.2018.09.09.15.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 15:55:06 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
Date:   Mon, 10 Sep 2018 00:56:03 +0200
Message-Id: <20180909225605.16463-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909225605.16463-1-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as Amstrad Delta board - the only user of this driver - provides
GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
use the table to locate required GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
to the driver probe function so device initialization can be deferred
instead of aborted if a GPIO pin is not yet available.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/video/fbdev/omap/lcd_ams_delta.c | 55 +++++++++++++-------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index e8c748a0dfe2..cddbd00cbf9f 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -24,11 +24,10 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <mach/board-ams-delta.h>
 
 #include "omapfb.h"
 
@@ -41,6 +40,8 @@
 /* LCD class device section */
 
 static int ams_delta_lcd;
+static struct gpio_desc *gpiod_vblen;
+static struct gpio_desc *gpiod_ndisp;
 
 static int ams_delta_lcd_set_power(struct lcd_device *dev, int power)
 {
@@ -99,41 +100,17 @@ static struct lcd_ops ams_delta_lcd_ops = {
 
 /* omapfb panel section */
 
-static const struct gpio _gpios[] = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_LCD_VBLEN,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "lcd_vblen",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_LCD_NDISP,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "lcd_ndisp",
-	},
-};
-
-static int ams_delta_panel_init(struct lcd_panel *panel,
-		struct omapfb_device *fbdev)
-{
-	return gpio_request_array(_gpios, ARRAY_SIZE(_gpios));
-}
-
-static void ams_delta_panel_cleanup(struct lcd_panel *panel)
-{
-	gpio_free_array(_gpios, ARRAY_SIZE(_gpios));
-}
-
 static int ams_delta_panel_enable(struct lcd_panel *panel)
 {
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 1);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 1);
+	gpiod_set_value(gpiod_ndisp, 1);
+	gpiod_set_value(gpiod_vblen, 1);
 	return 0;
 }
 
 static void ams_delta_panel_disable(struct lcd_panel *panel)
 {
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 0);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 0);
+	gpiod_set_value(gpiod_vblen, 0);
+	gpiod_set_value(gpiod_ndisp, 0);
 }
 
 static struct lcd_panel ams_delta_panel = {
@@ -154,8 +131,6 @@ static struct lcd_panel ams_delta_panel = {
 	.pcd		= 0,
 	.acb		= 37,
 
-	.init		= ams_delta_panel_init,
-	.cleanup	= ams_delta_panel_cleanup,
 	.enable		= ams_delta_panel_enable,
 	.disable	= ams_delta_panel_disable,
 };
@@ -166,9 +141,23 @@ static struct lcd_panel ams_delta_panel = {
 static int ams_delta_panel_probe(struct platform_device *pdev)
 {
 	struct lcd_device *lcd_device = NULL;
-#ifdef CONFIG_LCD_CLASS_DEVICE
 	int ret;
 
+	gpiod_vblen = devm_gpiod_get(&pdev->dev, "vblen", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_vblen)) {
+		ret = PTR_ERR(gpiod_vblen);
+		dev_err(&pdev->dev, "VBLEN GPIO request failed (%d)\n", ret);
+		return ret;
+	}
+
+	gpiod_ndisp = devm_gpiod_get(&pdev->dev, "ndisp", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ndisp)) {
+		ret = PTR_ERR(gpiod_ndisp);
+		dev_err(&pdev->dev, "NDISP GPIO request failed (%d)\n", ret);
+		return ret;
+	}
+
+#ifdef CONFIG_LCD_CLASS_DEVICE
 	lcd_device = lcd_device_register("omapfb", &pdev->dev, NULL,
 						&ams_delta_lcd_ops);
 
-- 
2.16.4

