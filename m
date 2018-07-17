Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE63ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C120647
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSouMoJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C120647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGQXuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:50:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39456 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGQXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:50:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so2412589lji.6;
        Tue, 17 Jul 2018 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxJYpWidCfKa9iYVekeWO6dAh9gWrR/YyGHbbCX1psE=;
        b=QSouMoJ0fwCnnqNWTVH8yd3iJe6MGFsb5IdKbOnw/5eUTbh9p4qWM8nCLanrrGmqld
         s7tvqhpPNch90Z9V7SZJUU4LcF5UqLdNn6Ea+CpxKSzY9BWBZgwHWGZljeutg+6+O1sB
         3qy2Q7ac0VHg51HnCQjeQd0KAfD9wEteynDec/4CqXR/uK8SYbpdPoyYWc5eDwc5L8Ij
         vvMnV10YYgGmVrh1UolmAo8E6y0G1O0Pg6AwhoHSMjqxSaPxOAG5QixEDbnAEQAqEP9H
         Fqy2mL7qLtkVfxtl0ZI05r2zypqlSjV5+WRTuHBBTDJOIN5G/DusGibSLll6h7PpoYrZ
         9mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxJYpWidCfKa9iYVekeWO6dAh9gWrR/YyGHbbCX1psE=;
        b=YBVG4PEvSjftRjYlj0vHv1DFeumVnJdH97hzoee6GItiaSvX/uGZOgbl0/QjpcV1Vo
         OHYstJSKElxqgAq+ckfYIzy6kQiiiBDfWE2rsrvbDx19rJVBOkGo5fh/ySV2Ayl7sclg
         fBJXHNJ2iJMAR8SCyWmpmP6aNhsMdVViOaHFsYzkcEPLTcGWNZDUogkg934h4q4+ZsBQ
         FAb0/4XGcxgtWbtkVDKMg9vw1X+sJEjma+AjwsgaLx3HORPEMDfLMFkQ4RUaFxj6MYQq
         +9DlUDV448RnUpVn0sPhj5xsBJV9ia72I0+VEglcbTRwhCTqkYXfBwp9qdZGOkbF4IHy
         36Tg==
X-Gm-Message-State: AOUpUlGz9RNafSEdL4F3QQm90C+Q1G3bUJ9MwsCfjC5sn6b2hdmzKVZz
        FVFWNGagml1jhnTLHbds9hk=
X-Google-Smtp-Source: AAOMgpfpRbQVTAxkk+8MxMp5mbBaWh7aJhRee/Ubtb0OfGpX9uZazXx/ALbAkpId+Yvq1ObEPq0lGw==
X-Received: by 2002:a2e:998e:: with SMTP id w14-v6mr1434604lji.7.1531869306199;
        Tue, 17 Jul 2018 16:15:06 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id n24-v6sm350827ljc.7.2018.07.17.16.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 16:15:05 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 1/3 v2] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
Date:   Wed, 18 Jul 2018 01:14:46 +0200
Message-Id: <20180717231448.14958-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717231448.14958-1-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-1-jmkrzyszt@gmail.com>
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
Changelog:
v2: Remove problematic error code conversion no longer needed if used
    on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
    devices back to init_machine") already in linux-omap and commit
    8853daf3b4ac ("gpiolib: Defer on non-DT find_chip_by_name()
    failure") already in linux-next

Dependency on commit 8853daf3b4ac ("gpiolib: Defer on non-DT
find_chip_by_name() failure") is not critical for clean build or run, it
only prevents from unexpected future changes to driver initialization
order durin device_initall.

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

