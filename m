Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FC9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707C520867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTFGzaFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707C520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeKYWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:14:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35871 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:14:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so4850357pgm.3;
        Sun, 25 Nov 2018 03:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nwfMhrOFoCLRdJ2gF2RPDC00oQ9a06MU5Aupz66xdc=;
        b=GTFGzaFcglSMXtQcSyouTewxgAB+byZpI6Z1PuQh751An4pd7JwQFiK1c892sVHmKY
         kGySASmx23WyszUjfhNO9T0UEzVV02HMu77aOnyu65FBaoNLheLWmczjZVobnIdR7IfE
         xlEhCEwbwWas+BrVqjYToPo3HgX/fFWqBzWJsz0tSl67WJ/vmDlEWkeB++g6+3xEg5Kd
         Oh+rRNKe0YmyNd3tdCWfCnPjl4mMZPZP6U/iBCFuSDwn8BTMgl809/1vkRWWKxrHj3bg
         oEI8rYN67WXDGFx/GA0baSkaw6uIxP0wKT8NmMy1ElJGsbGiL6Pd5khwAXUxsWIVqY16
         lpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nwfMhrOFoCLRdJ2gF2RPDC00oQ9a06MU5Aupz66xdc=;
        b=hHFTpiFspc+iJ6KPFPRNnfYdLqQu+lCjpbYSWu3BDUW3GcOcStYVCg2+KXbdwkadNA
         RJtCgcDzyLCZQDgUGcjfgXBLcyC8tMOqk78UjSXkZ0c87GDDq0VstL+0ZNfYiijQwD6P
         GYTXKu0zglWsx5JRqYk4VXMuKrB42/KInM+xW2mAeIvSLz11Pk2nUIUp1q0lJaSCL4Yc
         xXTcDSem80tzapYOctpUVMGP+8+rXtmRb+vPhMApOT0rE733waVp85PVgem2FaJP0f37
         3RlO6X+DtgyFKesSeBgRkphl5CTEKOKJLM6Hn/zbM8aXj9ymK7OmGKz2aK8JfblswjN0
         PtwA==
X-Gm-Message-State: AA+aEWYIyMD7z0D3fhqOohi67RyFMTWPLouuLvsEtI6kNySl/oHaYAz4
        39bP8S3fh+XVuRApJHXWyt8=
X-Google-Smtp-Source: AFSGD/X8O5p6DJ1S5N6a9aWCJQJYarwaGEjC1k3fNZlipD6XRB+rq0e8J7sPMcaBC6wqWcRF0BgUYw==
X-Received: by 2002:a63:1412:: with SMTP id u18mr20374851pgl.247.1543145012487;
        Sun, 25 Nov 2018 03:23:32 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id x3sm47046179pgk.18.2018.11.25.03.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:23:31 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:53:26 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 01/26] Staging: fbtft: fbtft-core: Switch to the gpio
 descriptor interface
Message-ID: <59606a4af6426cd9fa2c10b363156b568525b63e.1543142440.git.nishadkamdar@gmail.com>
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

This switches the fbtft-core to use GPIO descriptors
rather than numerical gpios: Utilize the GPIO library's
intrinsic handling of OF GPIOs and polarity.
If the line is flagged active low, gpiolib will deal with
this.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 127 ++++++++++++-----------------
 drivers/staging/fbtft/fbtft.h      |  22 ++---
 2 files changed, 61 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index a2df02d97a8e..75ee16074126 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
@@ -24,7 +24,6 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <video/mipi_display.h>
 
 #include "fbtft.h"
@@ -38,8 +37,8 @@ int fbtft_write_buf_dc(struct fbtft_par *par, void *buf, size_t len, int dc)
 {
 	int ret;
 
-	if (gpio_is_valid(par->gpio.dc))
-		gpio_set_value(par->gpio.dc, dc);
+	if (par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, dc);
 
 	ret = par->fbtftops.write(par, buf, len);
 	if (ret < 0)
@@ -72,7 +71,7 @@ void fbtft_dbg_hex(const struct device *dev, int groupsize,
 EXPORT_SYMBOL(fbtft_dbg_hex);
 
 static unsigned long fbtft_request_gpios_match(struct fbtft_par *par,
-					       const struct fbtft_gpio *gpio)
+					       struct fbtft_gpio *gpio)
 {
 	int ret;
 	unsigned int val;
@@ -82,34 +81,34 @@ static unsigned long fbtft_request_gpios_match(struct fbtft_par *par,
 
 	if (strcasecmp(gpio->name, "reset") == 0) {
 		par->gpio.reset = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	} else if (strcasecmp(gpio->name, "dc") == 0) {
 		par->gpio.dc = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	} else if (strcasecmp(gpio->name, "cs") == 0) {
 		par->gpio.cs = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	} else if (strcasecmp(gpio->name, "wr") == 0) {
 		par->gpio.wr = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	} else if (strcasecmp(gpio->name, "rd") == 0) {
 		par->gpio.rd = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	} else if (strcasecmp(gpio->name, "latch") == 0) {
 		par->gpio.latch = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	} else if (gpio->name[0] == 'd' && gpio->name[1] == 'b') {
 		ret = kstrtouint(&gpio->name[2], 10, &val);
 		if (ret == 0 && val < 16) {
 			par->gpio.db[val] = gpio->gpio;
-			return GPIOF_OUT_INIT_LOW;
+			return GPIOD_OUT_LOW;
 		}
 	} else if (strcasecmp(gpio->name, "led") == 0) {
 		par->gpio.led[0] = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	} else if (strcasecmp(gpio->name, "led_") == 0) {
 		par->gpio.led[0] = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	}
 
 	return FBTFT_GPIO_NO_MATCH;
@@ -118,7 +117,8 @@ static unsigned long fbtft_request_gpios_match(struct fbtft_par *par,
 static int fbtft_request_gpios(struct fbtft_par *par)
 {
 	struct fbtft_platform_data *pdata = par->pdata;
-	const struct fbtft_gpio *gpio;
+	struct device *dev = par->info->device;
+	struct fbtft_gpio *gpio;
 	unsigned long flags;
 	int ret;
 
@@ -136,19 +136,19 @@ static int fbtft_request_gpios(struct fbtft_par *par)
 		if (flags == FBTFT_GPIO_NO_MATCH)
 			flags = fbtft_request_gpios_match(par, gpio);
 		if (flags != FBTFT_GPIO_NO_MATCH) {
-			ret = devm_gpio_request_one(par->info->device,
-					      gpio->gpio, flags,
-					      par->info->device->driver->name);
-			if (ret < 0) {
-				dev_err(par->info->device,
-					"%s: gpio_request_one('%s'=%d) failed with %d\n",
-					__func__, gpio->name,
-					gpio->gpio, ret);
+			gpio->gpio = devm_gpiod_get(dev,
+						    dev->driver->name, flags);
+			if (IS_ERR(gpio->gpio)) {
+				ret = PTR_ERR(gpio->gpio);
+				dev_err(dev,
+					"%s: Failed to request %s GPIO:%d\n",
+					__func__, gpio->name, ret);
 				return ret;
+
 			}
 			fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par,
-				      "%s: '%s' = GPIO%d\n",
-				      __func__, gpio->name, gpio->gpio);
+				      "%s: '%s' GPIO\n",
+				      __func__, gpio->name);
 		}
 		gpio++;
 	}
@@ -158,7 +158,8 @@ static int fbtft_request_gpios(struct fbtft_par *par)
 
 #ifdef CONFIG_OF
 static int fbtft_request_one_gpio(struct fbtft_par *par,
-				  const char *name, int index, int *gpiop)
+				  const char *name, int index,
+				  struct gpio_desc **gpiop)
 {
 	struct device *dev = par->info->device;
 	struct device_node *node = dev->of_node;
@@ -166,32 +167,17 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 	enum of_gpio_flags of_flags;
 
 	if (of_find_property(node, name, NULL)) {
-		gpio = of_get_named_gpio_flags(node, name, index, &of_flags);
-		if (gpio == -ENOENT)
-			return 0;
-		if (gpio == -EPROBE_DEFER)
-			return gpio;
-		if (gpio < 0) {
-			dev_err(dev,
-				"failed to get '%s' from DT\n", name);
-			return gpio;
-		}
-
-		/* active low translates to initially low */
-		flags = (of_flags & OF_GPIO_ACTIVE_LOW) ? GPIOF_OUT_INIT_LOW :
-							GPIOF_OUT_INIT_HIGH;
-		ret = devm_gpio_request_one(dev, gpio, flags,
-					    dev->driver->name);
-		if (ret) {
+		*gpiop = devm_gpiod_get_index(dev, dev->driver->name, index,
+					      GPIOD_OUT_HIGH);
+		if (IS_ERR(*gpiop)) {
+			ret = PTR_ERR(*gpiop);
 			dev_err(dev,
-				"gpio_request_one('%s'=%d) failed with %d\n",
-				name, gpio, ret);
+				"Failed to request %s GPIO:%d\n", name, ret);
 			return ret;
+
 		}
-		if (gpiop)
-			*gpiop = gpio;
-		fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' = GPIO%d\n",
-			      __func__, name, gpio);
+		fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
+			      __func__, name);
 	}
 
 	return ret;
@@ -254,9 +240,9 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
 
 	if ((bd->props.power == FB_BLANK_UNBLANK) &&
 	    (bd->props.fb_blank == FB_BLANK_UNBLANK))
-		gpio_set_value(par->gpio.led[0], polarity);
+		gpiod_set_value(par->gpio.led[0], polarity);
 	else
-		gpio_set_value(par->gpio.led[0], !polarity);
+		gpiod_set_value(par->gpio.led[0], !polarity);
 
 	return 0;
 }
@@ -286,7 +272,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	struct backlight_device *bd;
 	struct backlight_properties bl_props = { 0, };
 
-	if (par->gpio.led[0] == -1) {
+	if (!par->gpio.led[0]) {
 		fbtft_par_dbg(DEBUG_BACKLIGHT, par,
 			      "%s(): led pin not set, exiting.\n", __func__);
 		return;
@@ -295,7 +281,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	bl_props.type = BACKLIGHT_RAW;
 	/* Assume backlight is off, get polarity from current state of pin */
 	bl_props.power = FB_BLANK_POWERDOWN;
-	if (!gpio_get_value(par->gpio.led[0]))
+	if (!gpiod_get_value(par->gpio.led[0]))
 		par->polarity = true;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
@@ -333,12 +319,12 @@ static void fbtft_set_addr_win(struct fbtft_par *par, int xs, int ys, int xe,
 
 static void fbtft_reset(struct fbtft_par *par)
 {
-	if (par->gpio.reset == -1)
+	if (!par->gpio.reset)
 		return;
 	fbtft_par_dbg(DEBUG_RESET, par, "%s()\n", __func__);
-	gpio_set_value_cansleep(par->gpio.reset, 0);
+	gpiod_set_value_cansleep(par->gpio.reset, 0);
 	usleep_range(20, 40);
-	gpio_set_value_cansleep(par->gpio.reset, 1);
+	gpiod_set_value_cansleep(par->gpio.reset, 1);
 	msleep(120);
 }
 
@@ -663,7 +649,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	int txbuflen = display->txbuflen;
 	unsigned int bpp = display->bpp;
 	unsigned int fps = display->fps;
-	int vmem_size, i;
+	int vmem_size;
 	const s16 *init_sequence = display->init_sequence;
 	char *gamma = display->gamma;
 	u32 *gamma_curves = NULL;
@@ -841,19 +827,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 		par->txbuf.len = txbuflen;
 	}
 
-	/* Initialize gpios to disabled */
-	par->gpio.reset = -1;
-	par->gpio.dc = -1;
-	par->gpio.rd = -1;
-	par->gpio.wr = -1;
-	par->gpio.cs = -1;
-	par->gpio.latch = -1;
-	for (i = 0; i < 16; i++) {
-		par->gpio.db[i] = -1;
-		par->gpio.led[i] = -1;
-		par->gpio.aux[i] = -1;
-	}
-
 	/* default fbtft operations */
 	par->fbtftops.write = fbtft_write_spi;
 	par->fbtftops.read = fbtft_read_spi;
@@ -1035,8 +1008,8 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
 		return -EINVAL;
 
 	par->fbtftops.reset(par);
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	while (p) {
 		if (val & FBTFT_OF_INIT_CMD) {
@@ -1126,8 +1099,8 @@ int fbtft_init_display(struct fbtft_par *par)
 	}
 
 	par->fbtftops.reset(par);
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	i = 0;
 	while (i < FBTFT_MAX_INIT_SEQUENCE) {
@@ -1227,7 +1200,7 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
 	if (pdata->display.buswidth != 9 &&  par->startbyte == 0 &&
-	    par->gpio.dc < 0) {
+	    !par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -1236,12 +1209,12 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	if (!par->pdev)
 		return 0;
 
-	if (par->gpio.wr < 0) {
+	if (!par->gpio.wr) {
 		dev_err(par->info->device, "Missing 'wr' gpio. Aborting.\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < pdata->display.buswidth; i++) {
-		if (par->gpio.db[i] < 0) {
+		if (!par->gpio.db[i]) {
 			dev_err(par->info->device,
 				"Missing 'db%02d' gpio. Aborting.\n", i);
 			return -EINVAL;
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index ac427baa464a..a9eed11c29b0 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -27,7 +27,7 @@
  */
 struct fbtft_gpio {
 	char name[FBTFT_GPIO_NAME_SIZE];
-	unsigned int gpio;
+	struct gpio_desc *gpio;
 };
 
 struct fbtft_par;
@@ -134,7 +134,7 @@ struct fbtft_display {
  */
 struct fbtft_platform_data {
 	struct fbtft_display display;
-	const struct fbtft_gpio *gpios;
+	struct fbtft_gpio *gpios;
 	unsigned int rotate;
 	bool bgr;
 	unsigned int fps;
@@ -207,15 +207,15 @@ struct fbtft_par {
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
 	struct {
-		int reset;
-		int dc;
-		int rd;
-		int wr;
-		int latch;
-		int cs;
-		int db[16];
-		int led[16];
-		int aux[16];
+		struct gpio_desc *reset;
+		struct gpio_desc *dc;
+		struct gpio_desc *rd;
+		struct gpio_desc *wr;
+		struct gpio_desc *latch;
+		struct gpio_desc *cs;
+		struct gpio_desc *db[16];
+		struct gpio_desc *led[16];
+		struct gpio_desc *aux[16];
 	} gpio;
 	const s16 *init_sequence;
 	struct {
-- 
2.17.1

