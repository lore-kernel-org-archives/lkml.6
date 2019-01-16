Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0004206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly8+9+ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfAPRbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:31:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47010 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfAPRbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:31:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so3306093ply.13;
        Wed, 16 Jan 2019 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4LLzXlg3UaVDc+zcq57zNOixD8+IZ5TRHX3mYfB23Mg=;
        b=Ly8+9+icXgiYg2JXIlMQPIoPHT+pDGwSkW09da0n+BFa1JJWxFxSXVyjdlsMprFNga
         ANF9KUFogXaI4T+F85cPiLDR9Asr/M9rUqshdHURXHcq55vDRKomYxT6ecIvtMnevj5t
         Jc6c+XMM5rOjq9y9bwj/XbZ64hjXbUMPBoatNL3q7dwDSUBv178rR9ZnwhocpF77kw7P
         /o+t/F7kSrUX91CXimNfK5UrLmyBq+SezSdjVMtkWKzfEFUs3YHwXaLa4tk25rOHFaq5
         w1MO7Xb2H6E7I2aP0lj1MpOFL4q71njDmCe+nKR5uS7BnOovUuykBowFTfm6J6yj/R0F
         Ah9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4LLzXlg3UaVDc+zcq57zNOixD8+IZ5TRHX3mYfB23Mg=;
        b=D3EZ9YaX7y0FZpwx9p+lcrGwYIrSh0WM/I5vuAEP+rryazU2fN977LIcnXD/AXB5Sw
         e4Xhm8AVxzOL24ISFgcxFlwoaXQjNuoc7QIX7Ouv8wkG04nxRTl9ExeCBdBbN8sPsCvH
         jTJStTbiRBy/fAD0uarAsby0P1hiI3Xpuydk1fiqoFH1qHRoWXMdcvdsJHnVyYfrcDmy
         WMgYNwmBK25pLxQujYzb57O6xOwxv7j62Gu52HgHrTRu++6EWiiV/ymX7WpEJ3nliMne
         hAKetJwpVBpqzmHBjYgQA72lp2jSgMLTsfP+hkIU5t1SmCqeJ5xfoB0LEkbp5SsSSAhT
         l3yA==
X-Gm-Message-State: AJcUukdJEU/zMaEReepEamhOubspuHFHexVQkNNO3CXou2dQgPyUhlIy
        /a6PdKnZc7NWKhSMegOXXbc=
X-Google-Smtp-Source: ALg8bN5HjQ6LRqJob0/xWSQNlJSwtAYMeoLXCcRFh4BR/NcnNhs8xnz8r8qr0pSC4lGm54KJPA7W9A==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr11041038plz.75.1547659860957;
        Wed, 16 Jan 2019 09:31:00 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id h185sm9170605pfg.143.2019.01.16.09.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:31:00 -0800 (PST)
Date:   Wed, 16 Jan 2019 23:00:50 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>,
        linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Siegel <felix.siegel@stud.uni-hannover.de>,
        Matthias Wolf <der_wolf_@web.de>, linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Radek =?utf-8?Q?Dost=C3=A1l?= <radek.dostal@streamunlimited.com>,
        Renato Soma <renatoys08@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Tim Cofala <cofala@stud.uni-hannover.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3] Staging: fbtft: Switch to the gpio descriptor interface
Message-ID: <20190116173045.GA30656@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the fbtft driver to use GPIO descriptors
rather than numerical gpios:

Utilize the GPIO library's intrinsic handling of OF GPIOs
and polarity. If the line is flagged active low, gpiolib
will deal with this.

Remove gpios from platform device structure. Neither assign
statically numbers to gpios in platform device nor allow
gpios to be parsed as module parameters.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v3:
 - Correct the changelog position.
Changes in v2:
 - Merge all patches in a single patch. This is because the
   first patch changes par->gpio from an int to a pointer
   so all the checks have to be updated in the same patch.
   Otherwie it breaks 'git bisect'.
---
 drivers/staging/fbtft/fb_agm1264k-fl.c |  52 ++--
 drivers/staging/fbtft/fb_bd663474.c    |   6 +-
 drivers/staging/fbtft/fb_ili9163.c     |   6 +-
 drivers/staging/fbtft/fb_ili9320.c     |   2 +-
 drivers/staging/fbtft/fb_ili9325.c     |   6 +-
 drivers/staging/fbtft/fb_ili9340.c     |   2 +-
 drivers/staging/fbtft/fb_pcd8544.c     |   4 +-
 drivers/staging/fbtft/fb_ra8875.c      |   4 +-
 drivers/staging/fbtft/fb_s6d1121.c     |   6 +-
 drivers/staging/fbtft/fb_sh1106.c      |   2 +-
 drivers/staging/fbtft/fb_ssd1289.c     |   6 +-
 drivers/staging/fbtft/fb_ssd1305.c     |   4 +-
 drivers/staging/fbtft/fb_ssd1306.c     |   4 +-
 drivers/staging/fbtft/fb_ssd1325.c     |   6 +-
 drivers/staging/fbtft/fb_ssd1331.c     |  10 +-
 drivers/staging/fbtft/fb_ssd1351.c     |   2 +-
 drivers/staging/fbtft/fb_tls8204.c     |   6 +-
 drivers/staging/fbtft/fb_uc1611.c      |   4 +-
 drivers/staging/fbtft/fb_uc1701.c      |   6 +-
 drivers/staging/fbtft/fb_upd161704.c   |   6 +-
 drivers/staging/fbtft/fb_watterott.c   |   4 +-
 drivers/staging/fbtft/fbtft-bus.c      |   6 +-
 drivers/staging/fbtft/fbtft-core.c     | 173 +++----------
 drivers/staging/fbtft/fbtft-io.c       |  26 +-
 drivers/staging/fbtft/fbtft.h          |  21 +-
 drivers/staging/fbtft/fbtft_device.c   | 344 +------------------------
 drivers/staging/fbtft/flexfb.c         |  12 +-
 27 files changed, 143 insertions(+), 587 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index f6f30f5bf15a..8f27bd8da17d 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 
@@ -79,14 +79,14 @@ static int init_display(struct fbtft_par *par)
 
 static void reset(struct fbtft_par *par)
 {
-	if (par->gpio.reset == -1)
+	if (!par->gpio.reset)
 		return;
 
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
-	gpio_set_value(par->gpio.reset, 0);
+	gpiod_set_value(par->gpio.reset, 0);
 	udelay(20);
-	gpio_set_value(par->gpio.reset, 1);
+	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
 
@@ -98,30 +98,30 @@ static int verify_gpios(struct fbtft_par *par)
 	dev_dbg(par->info->device,
 		"%s()\n", __func__);
 
-	if (par->EPIN < 0) {
+	if (!par->EPIN) {
 		dev_err(par->info->device,
 			"Missing info about 'wr' (aka E) gpio. Aborting.\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < 8; ++i) {
-		if (par->gpio.db[i] < 0) {
+		if (!par->gpio.db[i]) {
 			dev_err(par->info->device,
 				"Missing info about 'db[%i]' gpio. Aborting.\n",
 				i);
 			return -EINVAL;
 		}
 	}
-	if (par->CS0 < 0) {
+	if (!par->CS0) {
 		dev_err(par->info->device,
 			"Missing info about 'cs0' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->CS1 < 0) {
+	if (!par->CS1) {
 		dev_err(par->info->device,
 			"Missing info about 'cs1' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->RW < 0) {
+	if (!par->RW) {
 		dev_err(par->info->device,
 			"Missing info about 'rw' gpio. Aborting.\n");
 		return -EINVAL;
@@ -139,22 +139,22 @@ request_gpios_match(struct fbtft_par *par, const struct fbtft_gpio *gpio)
 	if (strcasecmp(gpio->name, "wr") == 0) {
 		/* left ks0108 E pin */
 		par->EPIN = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	} else if (strcasecmp(gpio->name, "cs0") == 0) {
 		/* left ks0108 controller pin */
 		par->CS0 = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	} else if (strcasecmp(gpio->name, "cs1") == 0) {
 		/* right ks0108 controller pin */
 		par->CS1 = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	}
 
 	/* if write (rw = 0) e(1->0) perform write */
 	/* if read (rw = 1) e(0->1) set data on D0-7*/
 	else if (strcasecmp(gpio->name, "rw") == 0) {
 		par->RW = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	}
 
 	return FBTFT_GPIO_NO_MATCH;
@@ -194,15 +194,15 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	/* select chip */
 	if (*buf) {
 		/* cs1 */
-		gpio_set_value(par->CS0, 1);
-		gpio_set_value(par->CS1, 0);
+		gpiod_set_value(par->CS0, 1);
+		gpiod_set_value(par->CS1, 0);
 	} else {
 		/* cs0 */
-		gpio_set_value(par->CS0, 0);
-		gpio_set_value(par->CS1, 1);
+		gpiod_set_value(par->CS0, 0);
+		gpiod_set_value(par->CS1, 1);
 	}
 
-	gpio_set_value(par->RS, 0); /* RS->0 (command mode) */
+	gpiod_set_value(par->RS, 0); /* RS->0 (command mode) */
 	len--;
 
 	if (len) {
@@ -364,7 +364,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			write_reg(par, 0x00, (0x17 << 3) | (u8)y);
 
 			/* write bitmap */
-			gpio_set_value(par->RS, 1); /* RS->1 (data mode) */
+			gpiod_set_value(par->RS, 1); /* RS->1 (data mode) */
 			ret = par->fbtftops.write(par, buf, len);
 			if (ret < 0)
 				dev_err(par->info->device,
@@ -387,7 +387,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			write_reg(par, 0x01, (0x17 << 3) | (u8)y);
 
 			/* write bitmap */
-			gpio_set_value(par->RS, 1); /* RS->1 (data mode) */
+			gpiod_set_value(par->RS, 1); /* RS->1 (data mode) */
 			par->fbtftops.write(par, buf, len);
 			if (ret < 0)
 				dev_err(par->info->device,
@@ -397,8 +397,8 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 	kfree(convert_buf);
 
-	gpio_set_value(par->CS0, 1);
-	gpio_set_value(par->CS1, 1);
+	gpiod_set_value(par->CS0, 1);
+	gpiod_set_value(par->CS1, 1);
 
 	return ret;
 }
@@ -408,7 +408,7 @@ static int write(struct fbtft_par *par, void *buf, size_t len)
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
 			  "%s(len=%d): ", __func__, len);
 
-	gpio_set_value(par->RW, 0); /* set write mode */
+	gpiod_set_value(par->RW, 0); /* set write mode */
 
 	while (len--) {
 		u8 i, data;
@@ -417,12 +417,12 @@ static int write(struct fbtft_par *par, void *buf, size_t len)
 
 		/* set data bus */
 		for (i = 0; i < 8; ++i)
-			gpio_set_value(par->gpio.db[i], data & (1 << i));
+			gpiod_set_value(par->gpio.db[i], data & (1 << i));
 		/* set E */
-		gpio_set_value(par->EPIN, 1);
+		gpiod_set_value(par->EPIN, 1);
 		udelay(5);
 		/* unset E - write */
-		gpio_set_value(par->EPIN, 0);
+		gpiod_set_value(par->EPIN, 0);
 		udelay(1);
 	}
 
diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb_bd663474.c
index a58c514f4721..b6c6d66e4eb1 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -24,8 +24,8 @@
 
 static int init_display(struct fbtft_par *par)
 {
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	par->fbtftops.reset(par);
 
diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_ili9163.c
index 86e140244aab..d609a2b67db9 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <video/mipi_display.h>
 
@@ -77,8 +77,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	write_reg(par, MIPI_DCS_SOFT_RESET); /* software reset */
 	mdelay(500);
diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 740c0acbecd8..ea6e001288ce 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_ili9325.c
index 2cf75f2e03e2..b090e7ab6fdd 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -85,8 +85,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	bt &= 0x07;
 	vc &= 0x07;
diff --git a/drivers/staging/fbtft/fb_ili9340.c b/drivers/staging/fbtft/fb_ili9340.c
index 430f21e50f4d..415183c7054a 100644
--- a/drivers/staging/fbtft/fb_ili9340.c
+++ b/drivers/staging/fbtft/fb_ili9340.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <video/mipi_display.h>
 
diff --git a/drivers/staging/fbtft/fb_pcd8544.c b/drivers/staging/fbtft/fb_pcd8544.c
index 32172f8f79f0..ad49973ad594 100644
--- a/drivers/staging/fbtft/fb_pcd8544.c
+++ b/drivers/staging/fbtft/fb_pcd8544.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -119,7 +119,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf, 6 * 84);
 	if (ret < 0)
 		dev_err(par->info->device, "write failed and returned: %d\n",
diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 5d3b76ca74d8..70b37fc7fb66 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -39,7 +39,7 @@ static int write_spi(struct fbtft_par *par, void *buf, size_t len)
 
 static int init_display(struct fbtft_par *par)
 {
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 
 	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 		      "%s()\n", __func__);
diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index aa716f33420a..b3d0701880fe 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -29,8 +29,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	/* Initialization sequence from Lib_UTFT */
 
diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 00096f8d249a..6f7249493ea3 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index c9b18b3ba4ab..bbf75f795234 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include "fbtft.h"
 
@@ -28,8 +28,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	write_reg(par, 0x00, 0x0001);
 	write_reg(par, 0x03, 0xA8A4);
diff --git a/drivers/staging/fbtft/fb_ssd1305.c b/drivers/staging/fbtft/fb_ssd1305.c
index 3515888d94c9..020fe48fed0b 100644
--- a/drivers/staging/fbtft/fb_ssd1305.c
+++ b/drivers/staging/fbtft/fb_ssd1305.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -168,7 +168,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf,
 				  par->info->var.xres * par->info->var.yres /
 				  8);
diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index 50172ddd94ae..d7c5e2e0eee9 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -190,7 +190,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf, xres * yres / 8);
 	if (ret < 0)
 		dev_err(par->info->device, "write failed and returned: %d\n",
diff --git a/drivers/staging/fbtft/fb_ssd1325.c b/drivers/staging/fbtft/fb_ssd1325.c
index f974f7fc4d79..8a3140d41d8b 100644
--- a/drivers/staging/fbtft/fb_ssd1325.c
+++ b/drivers/staging/fbtft/fb_ssd1325.c
@@ -6,7 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -35,7 +35,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	gpio_set_value(par->gpio.cs, 0);
+	gpiod_set_value(par->gpio.cs, 0);
 
 	write_reg(par, 0xb3);
 	write_reg(par, 0xf0);
@@ -155,7 +155,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		}
 	}
 
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 
 	/* Write data */
 	ret = par->fbtftops.write(par, par->txbuf.buf,
diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index 0b614c84822e..9f54fe28d511 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -80,8 +80,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	va_start(args, len);
 
 	*buf = (u8)va_arg(args, unsigned int);
-	if (par->gpio.dc != -1)
-		gpio_set_value(par->gpio.dc, 0);
+	if (!par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 0);
 	ret = par->fbtftops.write(par, par->buf, sizeof(u8));
 	if (ret < 0) {
 		va_end(args);
@@ -103,8 +103,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 			return;
 		}
 	}
-	if (par->gpio.dc != -1)
-		gpio_set_value(par->gpio.dc, 1);
+	if (!par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 1);
 	va_end(args);
 }
 
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 3da091b4d297..a8980d9f7557 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
diff --git a/drivers/staging/fbtft/fb_tls8204.c b/drivers/staging/fbtft/fb_tls8204.c
index 277b6ed9c725..bec6dd0ffb01 100644
--- a/drivers/staging/fbtft/fb_tls8204.c
+++ b/drivers/staging/fbtft/fb_tls8204.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -94,7 +94,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		/* The display is 102x68 but the LCD is 84x48.
 		 * Set the write pointer at the start of each row.
 		 */
-		gpio_set_value(par->gpio.dc, 0);
+		gpiod_set_value(par->gpio.dc, 0);
 		write_reg(par, 0x80 | 0);
 		write_reg(par, 0x40 | y);
 
@@ -109,7 +109,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			*buf++ = ch;
 		}
 		/* Write the row */
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 		ret = par->fbtftops.write(par, par->txbuf.buf, WIDTH);
 		if (ret < 0) {
 			dev_err(par->info->device,
diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb_uc1611.c
index dfaf8bc70f73..65681d0fe200 100644
--- a/drivers/staging/fbtft/fb_uc1611.c
+++ b/drivers/staging/fbtft/fb_uc1611.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -251,7 +251,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			}
 			break;
 		}
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 
 		/* Write data */
 		ret = par->fbtftops.write(par, par->txbuf.buf, len / 2);
diff --git a/drivers/staging/fbtft/fb_uc1701.c b/drivers/staging/fbtft/fb_uc1701.c
index 0a3531d6eb39..e4ccc73868a7 100644
--- a/drivers/staging/fbtft/fb_uc1701.c
+++ b/drivers/staging/fbtft/fb_uc1701.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -136,9 +136,9 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		write_reg(par, LCD_PAGE_ADDRESS | (u8)y);
 		write_reg(par, 0x00);
 		write_reg(par, LCD_COL_ADDRESS);
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 		ret = par->fbtftops.write(par, par->txbuf.buf, WIDTH);
-		gpio_set_value(par->gpio.dc, 0);
+		gpiod_set_value(par->gpio.dc, 0);
 	}
 
 	if (ret < 0)
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index acc425fdf34e..564a38e34440 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -26,8 +26,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	/* Initialization sequence from Lib_UTFT */
 
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index e77178157f1b..0a5206d28da4 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -213,7 +213,7 @@ static int set_var(struct fbtft_par *par)
 
 static int verify_gpios(struct fbtft_par *par)
 {
-	if (par->gpio.reset < 0) {
+	if (!par->gpio.reset) {
 		dev_err(par->info->device, "Missing 'reset' gpio. Aborting.\n");
 		return -EINVAL;
 	}
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 8ce1ff9b6c2a..2ea814d0dca5 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
 
@@ -135,8 +135,8 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
-	if (par->gpio.dc != -1)
-		gpio_set_value(par->gpio.dc, 1);
+	if (!par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 1);
 
 	/* non buffered write */
 	if (!par->txbuf.buf)
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index a2df02d97a8e..de3f431abc15 100644
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
@@ -71,127 +70,27 @@ void fbtft_dbg_hex(const struct device *dev, int groupsize,
 }
 EXPORT_SYMBOL(fbtft_dbg_hex);
 
-static unsigned long fbtft_request_gpios_match(struct fbtft_par *par,
-					       const struct fbtft_gpio *gpio)
-{
-	int ret;
-	unsigned int val;
-
-	fbtft_par_dbg(DEBUG_REQUEST_GPIOS_MATCH, par, "%s('%s')\n",
-		      __func__, gpio->name);
-
-	if (strcasecmp(gpio->name, "reset") == 0) {
-		par->gpio.reset = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
-	} else if (strcasecmp(gpio->name, "dc") == 0) {
-		par->gpio.dc = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
-	} else if (strcasecmp(gpio->name, "cs") == 0) {
-		par->gpio.cs = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
-	} else if (strcasecmp(gpio->name, "wr") == 0) {
-		par->gpio.wr = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
-	} else if (strcasecmp(gpio->name, "rd") == 0) {
-		par->gpio.rd = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
-	} else if (strcasecmp(gpio->name, "latch") == 0) {
-		par->gpio.latch = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
-	} else if (gpio->name[0] == 'd' && gpio->name[1] == 'b') {
-		ret = kstrtouint(&gpio->name[2], 10, &val);
-		if (ret == 0 && val < 16) {
-			par->gpio.db[val] = gpio->gpio;
-			return GPIOF_OUT_INIT_LOW;
-		}
-	} else if (strcasecmp(gpio->name, "led") == 0) {
-		par->gpio.led[0] = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
-	} else if (strcasecmp(gpio->name, "led_") == 0) {
-		par->gpio.led[0] = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
-	}
-
-	return FBTFT_GPIO_NO_MATCH;
-}
-
-static int fbtft_request_gpios(struct fbtft_par *par)
-{
-	struct fbtft_platform_data *pdata = par->pdata;
-	const struct fbtft_gpio *gpio;
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
-			ret = devm_gpio_request_one(par->info->device,
-					      gpio->gpio, flags,
-					      par->info->device->driver->name);
-			if (ret < 0) {
-				dev_err(par->info->device,
-					"%s: gpio_request_one('%s'=%d) failed with %d\n",
-					__func__, gpio->name,
-					gpio->gpio, ret);
-				return ret;
-			}
-			fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par,
-				      "%s: '%s' = GPIO%d\n",
-				      __func__, gpio->name, gpio->gpio);
-		}
-		gpio++;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static int fbtft_request_one_gpio(struct fbtft_par *par,
-				  const char *name, int index, int *gpiop)
+				  const char *name, int index,
+				  struct gpio_desc **gpiop)
 {
 	struct device *dev = par->info->device;
 	struct device_node *node = dev->of_node;
-	int gpio, flags, ret = 0;
-	enum of_gpio_flags of_flags;
+	int ret = 0;
 
 	if (of_find_property(node, name, NULL)) {
-		gpio = of_get_named_gpio_flags(node, name, index, &of_flags);
-		if (gpio == -ENOENT)
-			return 0;
-		if (gpio == -EPROBE_DEFER)
-			return gpio;
-		if (gpio < 0) {
+		*gpiop = devm_gpiod_get_index(dev, dev->driver->name, index,
+					      GPIOD_OUT_HIGH);
+		if (IS_ERR(*gpiop)) {
+			ret = PTR_ERR(*gpiop);
 			dev_err(dev,
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
-			dev_err(dev,
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
@@ -254,9 +153,9 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
 
 	if ((bd->props.power == FB_BLANK_UNBLANK) &&
 	    (bd->props.fb_blank == FB_BLANK_UNBLANK))
-		gpio_set_value(par->gpio.led[0], polarity);
+		gpiod_set_value(par->gpio.led[0], polarity);
 	else
-		gpio_set_value(par->gpio.led[0], !polarity);
+		gpiod_set_value(par->gpio.led[0], !polarity);
 
 	return 0;
 }
@@ -286,7 +185,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	struct backlight_device *bd;
 	struct backlight_properties bl_props = { 0, };
 
-	if (par->gpio.led[0] == -1) {
+	if (!par->gpio.led[0]) {
 		fbtft_par_dbg(DEBUG_BACKLIGHT, par,
 			      "%s(): led pin not set, exiting.\n", __func__);
 		return;
@@ -295,7 +194,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	bl_props.type = BACKLIGHT_RAW;
 	/* Assume backlight is off, get polarity from current state of pin */
 	bl_props.power = FB_BLANK_POWERDOWN;
-	if (!gpio_get_value(par->gpio.led[0]))
+	if (!gpiod_get_value(par->gpio.led[0]))
 		par->polarity = true;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
@@ -333,12 +232,12 @@ static void fbtft_set_addr_win(struct fbtft_par *par, int xs, int ys, int xe,
 
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
 
@@ -663,7 +562,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	int txbuflen = display->txbuflen;
 	unsigned int bpp = display->bpp;
 	unsigned int fps = display->fps;
-	int vmem_size, i;
+	int vmem_size;
 	const s16 *init_sequence = display->init_sequence;
 	char *gamma = display->gamma;
 	u32 *gamma_curves = NULL;
@@ -841,19 +740,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
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
@@ -863,7 +749,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	par->fbtftops.reset = fbtft_reset;
 	par->fbtftops.mkdirty = fbtft_mkdirty;
 	par->fbtftops.update_display = fbtft_update_display;
-	par->fbtftops.request_gpios = fbtft_request_gpios;
 	if (display->backlight)
 		par->fbtftops.register_backlight = fbtft_register_backlight;
 
@@ -1035,8 +920,8 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
 		return -EINVAL;
 
 	par->fbtftops.reset(par);
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	while (p) {
 		if (val & FBTFT_OF_INIT_CMD) {
@@ -1126,8 +1011,8 @@ int fbtft_init_display(struct fbtft_par *par)
 	}
 
 	par->fbtftops.reset(par);
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	i = 0;
 	while (i < FBTFT_MAX_INIT_SEQUENCE) {
@@ -1227,7 +1112,7 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
 	if (pdata->display.buswidth != 9 &&  par->startbyte == 0 &&
-	    par->gpio.dc < 0) {
+	    !par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -1236,12 +1121,12 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
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
diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index b5051d3d46a6..38cdad6203ea 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
 
@@ -142,30 +142,30 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u8 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpio_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 0);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data == prev_data) {
-			gpio_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
 		} else {
 			for (i = 0; i < 8; i++) {
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
 		for (i = 0; i < 8; i++) {
-			gpio_set_value(par->gpio.db[i], data & 1);
+			gpiod_set_value(par->gpio.db[i], data & 1);
 			data >>= 1;
 		}
 #endif
 
 		/* Pullup /WR */
-		gpio_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 1);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u8 *)buf;
@@ -192,30 +192,30 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
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
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index ac427baa464a..7fdd3b0851ef 100644
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
@@ -134,7 +134,6 @@ struct fbtft_display {
  */
 struct fbtft_platform_data {
 	struct fbtft_display display;
-	const struct fbtft_gpio *gpios;
 	unsigned int rotate;
 	bool bgr;
 	unsigned int fps;
@@ -207,15 +206,15 @@ struct fbtft_par {
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
diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 046f9d355ecb..5f6cd0816d58 100644
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
diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index 2af474469e7d..c5fa59105a43 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -521,7 +521,7 @@ static int flexfb_verify_gpios_dc(struct fbtft_par *par)
 {
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (par->gpio.dc < 0) {
+	if (!par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -537,22 +537,22 @@ static int flexfb_verify_gpios_db(struct fbtft_par *par)
 
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (par->gpio.dc < 0) {
+	if (!par->gpio.dc) {
 		dev_err(par->info->device, "Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->gpio.wr < 0) {
+	if (!par->gpio.wr) {
 		dev_err(par->info->device, "Missing info about 'wr' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (latched && (par->gpio.latch < 0)) {
+	if (latched && !par->gpio.latch) {
 		dev_err(par->info->device, "Missing info about 'latch' gpio. Aborting.\n");
 		return -EINVAL;
 	}
 	if (latched)
 		num_db = buswidth / 2;
 	for (i = 0; i < num_db; i++) {
-		if (par->gpio.db[i] < 0) {
+		if (!par->gpio.db[i]) {
 			dev_err(par->info->device,
 				"Missing info about 'db%02d' gpio. Aborting.\n",
 				i);
-- 
2.17.1

