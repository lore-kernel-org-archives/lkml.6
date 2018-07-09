Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2683C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775CA208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr+0z/Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775CA208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933328AbeGITPp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:15:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37308 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932947AbeGITPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:15:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so4588870ljk.4;
        Mon, 09 Jul 2018 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sp8+JgRqVeeyk0l+qgAF2+oLpc7masrcAxzI19Bzw1w=;
        b=lr+0z/Tg3lijS6R/MSnhwlL08wFZRi7f4yMTCpOMad/h4SGIXMkn64wN2F66r1pa4l
         KIJjP6iSTQx156JlUYNbGZzSCfMijoNFuM3t9hBeNByI0B6ZSnkPc2TNgWmGndcanFwZ
         UG3hq8bSPN8yqL8U2kXyscCfpPbTsIIIjaEvecabvA001UnAYxrL4uvAegCXW1Er9F+O
         LHgPGjy/knxq4+Ak+JCEngTYfz+Cu4Eh5IxTtaIrgZSFXXhuhOQS1joCEieovfwBcR4C
         zBXc4hk0vAsN8r3frb3NdWWMGDAkvspvp/oghe/kgCAifJxirY2HKhAdiMHi1T5clvzp
         M5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sp8+JgRqVeeyk0l+qgAF2+oLpc7masrcAxzI19Bzw1w=;
        b=sdZ1WwPC6Y7+xRUDR1UUXe3miJSyNcOZjWEASkb9umd259P8lkrM8uQZ3mQJA2UK6o
         QgQmXvyTmmYkNUF3qq0bFG4U1zQtb2jlTgdgDzicX2vHGOzO29f1mMGLSJhEsKXIAx2A
         i1CBNgU1PCq1iohIHXTVNapK18MguzJVtLHxhTyADaP8VyFEQ1qZKq0qF6JSoGOqk4Xl
         rXJrTA2iE7KihlN7Dpzcy5fPUdHvn+Hv5xU5eDpzbTkb/VUcwSw//1MkIeTuwVJ5BUhB
         4+oAZrQWuiwFEFPjHm2BMb/JhLHKO0DZng2jOmq/Dg418OjUfoYjpNdin0+Zu1gjO7sP
         xeKg==
X-Gm-Message-State: APt69E2WJ+SfO4Kyi0nePDVmQ8Ubcca2xrSFPS5NcbKaYcK+2JUJlVie
        NDuJ2cWY36kPIaOUSbcyQ30=
X-Google-Smtp-Source: AAOMgpeWvacUUPEzCRkQdxNVR69CfcQ7E+qiLFG1yjjVWKB4g7GyY5mvtka+l6CGal8QH9IGkezvEA==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr12702444ljc.29.1531163741722;
        Mon, 09 Jul 2018 12:15:41 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id j64-v6sm3549258lfe.56.2018.07.09.12.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 12:15:40 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
Date:   Mon,  9 Jul 2018 21:16:01 +0200
Message-Id: <20180709191601.18681-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180518210954.29044-4-jmkrzyszt@gmail.com>
References: <20180518210954.29044-4-jmkrzyszt@gmail.com>
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

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: Remove problematic error code conversion, no longer needed if used
    on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
    devices back to init_machine") already in linux-next and commit
    8853daf3b4ac ("gpiolib: Defer on non-DT find_chip_by_name()
    failure") just applied to linux-gpio/devel.

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

