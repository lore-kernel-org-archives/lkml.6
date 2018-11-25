Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD58C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F1D2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6DyWwli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F1D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeKYWSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:18:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41874 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:18:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so12512142plm.8;
        Sun, 25 Nov 2018 03:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QTX5F1P72hjQd1AFqlGIAwaMVuW69avsjASbM/JcCUI=;
        b=e6DyWwlixZPSA9qzk/AF+ursJ6/BR4kLzUBwNIo1Kin671y8bietM4KUkl9WCr12de
         ZURw68WUHNDEMqZCOPKwRTPB1xOQo4YKKUlCTPuZhLSdh7hDvzy+fVvJp7n+xQma/ifA
         DaMd2Y65Y2veGqdaglIXvlaAM5X0OfSIk2RjlM1qclFfkMIc5bR6WfTWCQWaDOm8PiYX
         o40v/bQwJg7j8aJHoISP4bPWHX7pXMOOZWwKaH1PXKqFEkxls8gP/nhoi/IEdbGZbo8Q
         81tPIln94lO/jZuliivUK/0EAsGQeHF5fYC0EYbcQ3AfT4V4L6+Inp0fJRVk0VM9dmNu
         NKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTX5F1P72hjQd1AFqlGIAwaMVuW69avsjASbM/JcCUI=;
        b=VMZeGXWj9Oq5IY0CDVdApMmu17Lj8BuqD/iPS9S71/Ux0FEBlRbJerj3kKx2McWJ1J
         UTMJIt4kdN/jFz064IqTyxVDIRDfG5NvaWV78vU66prNafVH0e+jT4/Qr5fikR1kqD9t
         Vs/p4mTzKzc60UAvl13p8rRPwd9dFuXvNZNGz4tfxyEg45Ai9y22S4EFo9ahVktru/lN
         /nQUNlm8TkU6bJKU62kDX3KmO6XwSPfaVr4fuT5ldtW8PO5zdnYeZ8emsVKau0ZIDiQ8
         t3CS3biqsaG4Yv15wPRjbEQrRXXt8cymCEon0PQG6LueM3vUngGUEW09tecmbdF9KrFi
         sdHw==
X-Gm-Message-State: AA+aEWbWTFKZ8NLPk9uJ9tLGuFfe19fEyCGsazSZfQupLF1hq5fnfQWh
        oab4rxlxfCKXYTFskGsHxJk7MqEizTsN5Q==
X-Google-Smtp-Source: AFSGD/WPLODuDnyh/BcfHOpIByXup4dC15tSJPn+K9zvcoeoQkVHF9UGjPirGB4DD53KErB2RXdkow==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr22716027plb.266.1543145241629;
        Sun, 25 Nov 2018 03:27:21 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id m20sm63565243pgb.56.2018.11.25.03.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:27:21 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:57:15 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 05/26] Staging: fbtft: fbtft-device: Switch to the gpio
 descriptor interface
Message-ID: <b61d9bcd73502f33bd5e9121caa1865311fd9b6f.1543142440.git.nishadkamdar@gmail.com>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the fbtft-device.c to use GPIO descriptors
rather than numerical gpios: Remove gpios from platform
device structure. Neither assign statically numbers to gpios
in platform device nor allow gpios to be parsed as module
parameters.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c   |  87 -------
 drivers/staging/fbtft/fbtft.h        |   1 -
 drivers/staging/fbtft/fbtft_device.c | 344 +--------------------------
 3 files changed, 8 insertions(+), 424 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 75ee16074126..904ba7470abf 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -70,92 +70,6 @@ void fbtft_dbg_hex(const struct device *dev, int groupsize,
 }
 EXPORT_SYMBOL(fbtft_dbg_hex);
 
-static unsigned long fbtft_request_gpios_match(struct fbtft_par *par,
-					       struct fbtft_gpio *gpio)
-{
-	int ret;
-	unsigned int val;
-
-	fbtft_par_dbg(DEBUG_REQUEST_GPIOS_MATCH, par, "%s('%s')\n",
-		      __func__, gpio->name);
-
-	if (strcasecmp(gpio->name, "reset") == 0) {
-		par->gpio.reset = gpio->gpio;
-		return GPIOD_OUT_HIGH;
-	} else if (strcasecmp(gpio->name, "dc") == 0) {
-		par->gpio.dc = gpio->gpio;
-		return GPIOD_OUT_LOW;
-	} else if (strcasecmp(gpio->name, "cs") == 0) {
-		par->gpio.cs = gpio->gpio;
-		return GPIOD_OUT_HIGH;
-	} else if (strcasecmp(gpio->name, "wr") == 0) {
-		par->gpio.wr = gpio->gpio;
-		return GPIOD_OUT_HIGH;
-	} else if (strcasecmp(gpio->name, "rd") == 0) {
-		par->gpio.rd = gpio->gpio;
-		return GPIOD_OUT_HIGH;
-	} else if (strcasecmp(gpio->name, "latch") == 0) {
-		par->gpio.latch = gpio->gpio;
-		return GPIOD_OUT_LOW;
-	} else if (gpio->name[0] == 'd' && gpio->name[1] == 'b') {
-		ret = kstrtouint(&gpio->name[2], 10, &val);
-		if (ret == 0 && val < 16) {
-			par->gpio.db[val] = gpio->gpio;
-			return GPIOD_OUT_LOW;
-		}
-	} else if (strcasecmp(gpio->name, "led") == 0) {
-		par->gpio.led[0] = gpio->gpio;
-		return GPIOD_OUT_LOW;
-	} else if (strcasecmp(gpio->name, "led_") == 0) {
-		par->gpio.led[0] = gpio->gpio;
-		return GPIOD_OUT_HIGH;
-	}
-
-	return FBTFT_GPIO_NO_MATCH;
-}
-
-static int fbtft_request_gpios(struct fbtft_par *par)
-{
-	struct fbtft_platform_data *pdata = par->pdata;
-	struct device *dev = par->info->device;
-	struct fbtft_gpio *gpio;
-	unsigned long flags;
-	int ret;
-
-	if (!(pdata && pdata->gpios))
-		return 0;
-
-	gpio = pdata->gpios;
-	while (gpio->name[0]) {
-		flags = FBTFT_GPIO_NO_MATCH;
-		/* if driver provides match function, try it first,
-		 * if no match use our own
-		 */
-		if (par->fbtftops.request_gpios_match)
-			flags = par->fbtftops.request_gpios_match(par, gpio);
-		if (flags == FBTFT_GPIO_NO_MATCH)
-			flags = fbtft_request_gpios_match(par, gpio);
-		if (flags != FBTFT_GPIO_NO_MATCH) {
-			gpio->gpio = devm_gpiod_get(dev,
-						    dev->driver->name, flags);
-			if (IS_ERR(gpio->gpio)) {
-				ret = PTR_ERR(gpio->gpio);
-				dev_err(dev,
-					"%s: Failed to request %s GPIO:%d\n",
-					__func__, gpio->name, ret);
-				return ret;
-
-			}
-			fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par,
-				      "%s: '%s' GPIO\n",
-				      __func__, gpio->name);
-		}
-		gpio++;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static int fbtft_request_one_gpio(struct fbtft_par *par,
 				  const char *name, int index,
@@ -836,7 +750,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	par->fbtftops.reset = fbtft_reset;
 	par->fbtftops.mkdirty = fbtft_mkdirty;
 	par->fbtftops.update_display = fbtft_update_display;
-	par->fbtftops.request_gpios = fbtft_request_gpios;
 	if (display->backlight)
 		par->fbtftops.register_backlight = fbtft_register_backlight;
 
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index a9eed11c29b0..7fdd3b0851ef 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -134,7 +134,6 @@ struct fbtft_display {
  */
 struct fbtft_platform_data {
 	struct fbtft_display display;
-	struct fbtft_gpio *gpios;
 	unsigned int rotate;
 	bool bgr;
 	unsigned int fps;
diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 50e97da993e7..1917712cda90 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <video/mipi_display.h>
 
@@ -45,11 +45,6 @@ static int mode = -1;
 module_param(mode, int, 0000);
 MODULE_PARM_DESC(mode, "SPI mode (override device default)");
 
-static char *gpios;
-module_param(gpios, charp, 0000);
-MODULE_PARM_DESC(gpios,
-		 "List of gpios. Comma separated with the form: reset:23,dc:24 (when overriding the default, all gpios must be specified)");
-
 static unsigned int fps;
 module_param(fps, uint, 0000);
 MODULE_PARM_DESC(fps, "Frames per second (override driver default)");
@@ -101,7 +96,7 @@ MODULE_PARM_DESC(debug,
 static unsigned int verbose = 3;
 module_param(verbose, uint, 0000);
 MODULE_PARM_DESC(verbose,
-		 "0 silent, >0 show gpios, >1 show devices, >2 show devices before (default=3)");
+		 "0 silent, >1 show devices, >2 show devices before (default=3)");
 
 struct fbtft_device_display {
 	char *name;
@@ -279,12 +274,6 @@ static struct fbtft_device_display displays[] = {
 					.buswidth = 8,
 					.backlight = 1,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 				.gamma = ADAFRUIT18_GAMMA,
 			}
 		}
@@ -302,12 +291,6 @@ static struct fbtft_device_display displays[] = {
 					    adafruit18_green_tab_set_addr_win,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 				.gamma = ADAFRUIT18_GAMMA,
 			}
 		}
@@ -323,11 +306,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "led", 23 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -342,12 +320,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -362,12 +334,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -380,11 +346,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -399,12 +360,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 					.init_sequence = cberry28_init_sequence,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 22 },
-					{ "led", 18 },
-					{},
-				},
 				.gamma = CBERRY28_GAMMA,
 			}
 		}
@@ -420,9 +375,6 @@ static struct fbtft_device_display displays[] = {
 					.buswidth = 8,
 					.backlight = FBTFT_ONBOARD_BACKLIGHT,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			},
 			}
 		}
@@ -437,11 +389,6 @@ static struct fbtft_device_display displays[] = {
 					.buswidth = 8,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 13 },
-					{ "dc", 6 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -458,11 +405,6 @@ static struct fbtft_device_display displays[] = {
 					.height = 272,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -479,11 +421,6 @@ static struct fbtft_device_display displays[] = {
 					.height = 480,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -496,10 +433,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -512,9 +445,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 9,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			}
 		}
 	}, {
@@ -523,13 +453,6 @@ static struct fbtft_device_display displays[] = {
 			.modalias = "flexfb",
 			.max_speed_hz = 32000000,
 			.mode = SPI_MODE_0,
-			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
-			}
 		}
 	}, {
 		.name = "flexpfb",
@@ -538,24 +461,6 @@ static struct fbtft_device_display displays[] = {
 			.id = 0,
 			.dev = {
 			.release = fbtft_device_pdev_release,
-			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 17 },
-					{ "dc", 1 },
-					{ "wr", 0 },
-					{ "cs", 21 },
-					{ "db00", 9 },
-					{ "db01", 11 },
-					{ "db02", 18 },
-					{ "db03", 23 },
-					{ "db04", 24 },
-					{ "db05", 25 },
-					{ "db06", 8 },
-					{ "db07", 7 },
-					{ "led", 4 },
-					{},
-				},
-			},
 			}
 		}
 	}, {
@@ -570,11 +475,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = FBTFT_ONBOARD_BACKLIGHT,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 24 },
-					{ "dc", 25 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -588,12 +488,6 @@ static struct fbtft_device_display displays[] = {
 					.buswidth = 8,
 					.backlight = 1,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 23 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -609,11 +503,6 @@ static struct fbtft_device_display displays[] = {
 				},
 				.startbyte = 0x70,
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -631,11 +520,6 @@ static struct fbtft_device_display displays[] = {
 				.startbyte = 0x70,
 				.bgr = true,
 				.fps = 50,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "led", 18 },
-					{},
-				},
 				.gamma = HY28B_GAMMA,
 			}
 		}
@@ -652,12 +536,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 22 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -673,22 +551,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = false,
-				.gpios = (const struct fbtft_gpio []) {
-					/* Wiring for LCD adapter kit */
-					{ "reset", 7 },
-					{ "dc", 0 },	/* rev 2: 2 */
-					{ "wr", 1 },	/* rev 2: 3 */
-					{ "cs", 8 },
-					{ "db00", 17 },
-					{ "db01", 18 },
-					{ "db02", 21 }, /* rev 2: 27 */
-					{ "db03", 22 },
-					{ "db04", 23 },
-					{ "db05", 24 },
-					{ "db06", 25 },
-					{ "db07", 4 },
-					{}
-				},
 			},
 			}
 		}
@@ -705,9 +567,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			},
 			}
 		}
@@ -723,11 +582,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -743,12 +597,6 @@ static struct fbtft_device_display displays[] = {
 				},
 				.startbyte = 0x70,
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -763,11 +611,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -777,10 +620,6 @@ static struct fbtft_device_display displays[] = {
 			.max_speed_hz = 4000000,
 			.mode = SPI_MODE_3,
 			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -793,12 +632,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 23 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -811,12 +644,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 23 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -831,9 +658,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			}
 		}
 	}, {
@@ -849,12 +673,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 22 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -871,10 +689,6 @@ static struct fbtft_device_display displays[] = {
 					.init_sequence = pitft_init_sequence,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "dc", 25 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -888,11 +702,6 @@ static struct fbtft_device_display displays[] = {
 					.buswidth = 8,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 24 },
-					{ "dc", 25 },
-					{},
-				},
 				.gamma = PIOLED_GAMMA
 			}
 		}
@@ -908,12 +717,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 23 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -928,12 +731,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 23 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -946,11 +743,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -968,9 +760,6 @@ static struct fbtft_device_display displays[] = {
 					.fbtftops.write = write_gpio16_wr_slow,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			},
 		},
 		}
@@ -988,9 +777,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			},
 		},
 		}
@@ -1010,9 +796,6 @@ static struct fbtft_device_display displays[] = {
 						fbtft_write_gpio16_wr_latched,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			},
 		},
 		}
@@ -1028,11 +811,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1044,9 +822,6 @@ static struct fbtft_device_display displays[] = {
 			.chip_select = 0,
 			.mode = SPI_MODE_0,
 			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			}
 		}
 	}, {
@@ -1059,11 +834,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 24 },
-					{ "dc", 25 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1078,12 +848,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1098,12 +862,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 25 },
-					{ "dc", 24 },
-					{ "led", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1118,12 +876,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 15 },
-					{ "dc", 25 },
-					{ "led_", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1138,12 +890,6 @@ static struct fbtft_device_display displays[] = {
 					.backlight = 1,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 15 },
-					{ "dc", 25 },
-					{ "led_", 18 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1156,11 +902,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 24 },
-					{ "dc", 25 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1177,11 +918,6 @@ static struct fbtft_device_display displays[] = {
 						waveshare32b_init_sequence,
 				},
 				.bgr = true,
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 27 },
-					{ "dc", 22 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1194,11 +930,6 @@ static struct fbtft_device_display displays[] = {
 				.display = {
 					.buswidth = 8,
 				},
-				.gpios = (const struct fbtft_gpio []) {
-					{ "reset", 24 },
-					{ "dc", 25 },
-					{},
-				},
 			}
 		}
 	}, {
@@ -1211,9 +942,6 @@ static struct fbtft_device_display displays[] = {
 			.max_speed_hz = 0,
 			.mode = SPI_MODE_0,
 			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{},
-				},
 			}
 		},
 		.pdev = &(struct platform_device) {
@@ -1222,9 +950,6 @@ static struct fbtft_device_display displays[] = {
 			.dev = {
 				.release = fbtft_device_pdev_release,
 				.platform_data = &(struct fbtft_platform_data) {
-					.gpios = (const struct fbtft_gpio []) {
-						{},
-					},
 				},
 			},
 		},
@@ -1246,30 +971,30 @@ static int write_gpio16_wr_slow(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u16 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpio_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 0);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data == prev_data) {
-			gpio_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
 		} else {
 			for (i = 0; i < 16; i++) {
 				if ((data & 1) != (prev_data & 1))
-					gpio_set_value(par->gpio.db[i],
-						       data & 1);
+					gpiod_set_value(par->gpio.db[i],
+							data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
 		}
 #else
 		for (i = 0; i < 16; i++) {
-			gpio_set_value(par->gpio.db[i], data & 1);
+			gpiod_set_value(par->gpio.db[i], data & 1);
 			data >>= 1;
 		}
 #endif
 
 		/* Pullup /WR */
-		gpio_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 1);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u16 *)buf;
@@ -1289,9 +1014,6 @@ static void adafruit18_green_tab_set_addr_win(struct fbtft_par *par,
 	write_reg(par, 0x2C);
 }
 
-/* used if gpios parameter is present */
-static struct fbtft_gpio fbtft_device_param_gpios[MAX_GPIOS + 1] = { };
-
 static void fbtft_device_pdev_release(struct device *dev)
 {
 /* Needed to silence this message:
@@ -1382,11 +1104,8 @@ static int __init fbtft_device_init(void)
 {
 	struct spi_board_info *spi = NULL;
 	struct fbtft_platform_data *pdata;
-	const struct fbtft_gpio *gpio = NULL;
-	char *p_gpio, *p_name, *p_num;
 	bool found = false;
 	int i = 0;
-	long val;
 	int ret = 0;
 
 	if (!name) {
@@ -1404,38 +1123,6 @@ static int __init fbtft_device_init(void)
 		return -EINVAL;
 	}
 
-	/* parse module parameter: gpios */
-	while ((p_gpio = strsep(&gpios, ","))) {
-		if (!strchr(p_gpio, ':')) {
-			pr_err("error: missing ':' in gpios parameter: %s\n",
-			       p_gpio);
-			return -EINVAL;
-		}
-		p_num = p_gpio;
-		p_name = strsep(&p_num, ":");
-		if (!p_name || !p_num) {
-			pr_err("something bad happened parsing gpios parameter: %s\n",
-			       p_gpio);
-			return -EINVAL;
-		}
-		ret = kstrtol(p_num, 10, &val);
-		if (ret) {
-			pr_err("could not parse number in gpios parameter: %s:%s\n",
-			       p_name, p_num);
-			return -EINVAL;
-		}
-		strncpy(fbtft_device_param_gpios[i].name, p_name,
-			FBTFT_GPIO_NAME_SIZE - 1);
-		fbtft_device_param_gpios[i++].gpio = (int)val;
-		if (i == MAX_GPIOS) {
-			pr_err("gpios parameter: exceeded max array size: %d\n",
-			       MAX_GPIOS);
-			return -EINVAL;
-		}
-	}
-	if (fbtft_device_param_gpios[0].name[0])
-		gpio = fbtft_device_param_gpios;
-
 	if (verbose > 2) {
 		pr_spi_devices(); /* print list of registered SPI devices */
 		pr_p_devices(); /* print list of 'fb' platform devices */
@@ -1516,8 +1203,6 @@ static int __init fbtft_device_init(void)
 				pdata->txbuflen = txbuflen;
 			if (init_num)
 				pdata->display.init_sequence = init;
-			if (gpio)
-				pdata->gpios = gpio;
 			if (custom) {
 				pdata->display.width = width;
 				pdata->display.height = height;
@@ -1549,19 +1234,6 @@ static int __init fbtft_device_init(void)
 		return -EINVAL;
 	}
 
-	if (verbose && pdata && pdata->gpios) {
-		gpio = pdata->gpios;
-		pr_info("GPIOS used by '%s':\n", name);
-		found = false;
-		while (verbose && gpio->name[0]) {
-			pr_info("'%s' = GPIO%d\n", gpio->name, gpio->gpio);
-			gpio++;
-			found = true;
-		}
-		if (!found)
-			pr_info("(none)\n");
-	}
-
 	if (spi_device && (verbose > 1))
 		pr_spi_devices();
 	if (p_device && (verbose > 1))
-- 
2.17.1

