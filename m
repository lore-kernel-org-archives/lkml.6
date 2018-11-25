Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F8FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718B120865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQoytVQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718B120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKYWbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:31:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46921 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:31:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so5189467pfe.13;
        Sun, 25 Nov 2018 03:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDx48WDQAtM879ncxIKqIL3sB0F2WqIZq1EoJ0ThXrs=;
        b=LQoytVQnsa0YyfzJ6znUwKI9U9fX5etlp3KIUKdOX83wNeUbyO8wE1y2Pe2Gu6dbtX
         8+Qox+ar9pL77y1As2wDXBdpBWmqG6pL/scq5dnEhwgnL0GDUEtb9K6TF5ELCpcVyO8X
         uQKloRwX+QxKF74Yn+UQN2B4WEW/sT5SH4uSFIWgRrXCGhks3Yyc1p9I2xBH0owgkAqj
         zqIuSfT+jMPa/XyOPp6KW7kQxAy6dwG4rHSQR/N6iPcCykBxCRAu6bjZxEcv97DNLByG
         djyBEkgCMud5QhJPqvzl1e0JbltW6MS3IVqv9NXugvf/cIQiLljq2Ku2/IbwTFkQ5PdX
         +sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDx48WDQAtM879ncxIKqIL3sB0F2WqIZq1EoJ0ThXrs=;
        b=Ix0SUllUXlTameapKb4cYubp6ixsxeMhyinvorFBwGi6z1IO6ert1LaQDS7IwXz7B7
         wMMGBQMVeoqWEeQWoXnR8T5mVSUOmDUwkoIviVAPSBOISZnSK7QbMNlddMwXzX5wKu9s
         3dh139HhDGU+Wm8BL72E/T5WycLCKa8V6ZA6lowUrJJkI8pTvD/vfJNhYGNTdg2kQ6pu
         +ZvQUWEUEL2q0Av5abDR7ARbw0F+1SyZ6iUww3kLVIy+JutGNRG1FEOdtuTRgxlKKyYV
         kliWVDfTD9V1AQjt4l+OnWMODIsf+qUxSJWu9Nmn6CDxeFBIFDxZINrhhD7S2Le1BAM0
         d0Qg==
X-Gm-Message-State: AA+aEWa3YwJE07VPkByHhT9GpOGSD7Ytt6A7sSL7ENyucmw76N8QzFxI
        6U6p0N+LxpjKi63jmoqKFM0=
X-Google-Smtp-Source: AFSGD/X4v1CvlqvMalO1Q/zBK71/IJNKc8dizJ8rIsufwn5QaVsPybm/xAa6LvXpi9aCEJ5Npuwl2Q==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr20976394pgg.398.1543146030897;
        Sun, 25 Nov 2018 03:40:30 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id f64sm140775803pfh.0.2018.11.25.03.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:40:30 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:10:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 21/26] Staging: fbtft: fb_agm1264k-fl: Switch to the gpio
 descriptor interface
Message-ID: <0cb80f07d535f9344497960c6efa6a90ce26359a.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_agm1264k-fl.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 52 +++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

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
 
-- 
2.17.1

