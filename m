Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA5FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC52D20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neoxY/Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC52D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeKAA6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:58:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45654 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbeKAA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:58:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id v5-v6so2919016pfm.12;
        Wed, 31 Oct 2018 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yd/3lgKv3aScnwEWBYitvGxVTTRqGZdya6lty2Vfx+M=;
        b=neoxY/Q7uLWJ2nP89tRAWXzvi1lLtbTiq6nsOuTXX5IZbgrDU3pWs9EsagFQGxk+a8
         pEFGE2c3aYW0QSzScC70sH0bKywKLhlomp9GHuSwq4UIkDqhoyfNV76K3ekTFRIKW8L+
         ZNYZkp/wmO0ykSG+SW6ERG3A6p9Q5fpGnxFX2f4iv5rjoEZsPbhrdapUusBoI4rbp+0F
         y2Nx7tHlMnJweT1OBoU6hAfz/Xq2FMA/9qVYMUk2FhEJ/qxewy4uIRE4tLVyM0TU5tc9
         4nQpluyBXLdNPRB6jQYcXflXX73jAa6S55Fq5xLPPXlcSSJtG28GNdCg3CjlfUmm0Acx
         z9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yd/3lgKv3aScnwEWBYitvGxVTTRqGZdya6lty2Vfx+M=;
        b=WYNysb9w0KSyIT59mdtPP+RtfuNv0J/UtuAYVVEP5FADUPL8jGq0x7VAOvxDBKoHq5
         v7/cYb8OmBaN88wVF3u+SodzB/AH8emh0M9sqqIlKiWpHVZ/ZSvrK4V9tBdwARMIoHkQ
         FCPZzryYurufKt2CeX6F2sbvz5dCPEO7Nmb5ztCQtvdkgP14QeUMx8ImEARk4X2cIrPh
         +5n33nq7c0VSrp3S23PBuO2FfhzRgmjYWOZcVBppDwwAqYRHf3wlsmrlp73Frg9lZ6OG
         LPMWoUXMfiVRgXBKFhu5aPuBfS3ptSgjhuHSNpF6bKHAiUAstOzYWqK2vQ1j1z/PgFxV
         ieHg==
X-Gm-Message-State: AGRZ1gIxPLVfvgQwe/FWnZcZ1M4zIDzSELvaO8e5EdooHoHl/0cw7ehb
        wWPt+Bcq4xGBYJkXBGRyqjc=
X-Google-Smtp-Source: AJdET5cIm2TOpZACYo20CQ8CTDWKqLejriT6E8GE3Rr6fSXahDqxA0MouXvG8Lh22hXTVFR201tVJQ==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr3723044pge.391.1541001600807;
        Wed, 31 Oct 2018 09:00:00 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id v1-v6sm11995206pfn.94.2018.10.31.08.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 09:00:00 -0700 (PDT)
Date:   Wed, 31 Oct 2018 21:29:53 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] staging: iio: ad2s1210: Drop the gpioin flag.
Message-ID: <28e4acb0161ad59832150ae67be83a648684eb73.1541000375.git.nishadkamdar@gmail.com>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541000375.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop gpioin flag which decides how the GPIOs
are controlled as the GPIOs must be outputs
for the host as per the datasheet.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 45 ++++---------------------
 drivers/staging/iio/resolver/ad2s1210.h | 17 ----------
 2 files changed, 6 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 82ac9847f6f4..d3e7d5aad2c8 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -80,15 +80,7 @@ struct ad2s1210_gpio {
 	unsigned long flags;
 };
 
-static const struct ad2s1210_gpio gpios_in[] = {
-	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_IN },
-	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_IN },
-	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_IN },
-	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_IN },
-	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_IN },
-};
-
-static const struct ad2s1210_gpio gpios_out[] = {
+static const struct ad2s1210_gpio gpios[] = {
 	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_OUT_LOW },
 	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_OUT_LOW },
 	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_OUT_LOW },
@@ -99,7 +91,6 @@ static const struct ad2s1210_gpio gpios_out[] = {
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
 struct ad2s1210_state {
-	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
@@ -180,14 +171,6 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, fcw);
 }
 
-static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
-{
-	int resolution = (gpiod_get_value(st->gpios[AD2S1210_RES0]) << 1) |
-			  gpiod_get_value(st->gpios[AD2S1210_RES1]);
-
-	return ad2s1210_resolution_value[resolution];
-}
-
 static const int ad2s1210_res_pins[4][2] = {
 	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
 };
@@ -333,13 +316,7 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 	}
 	st->resolution
 		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
-	if (st->pdata->gpioin) {
-		data = ad2s1210_read_resolution_pin(st);
-		if (data != st->resolution)
-			dev_warn(dev, "ad2s1210: resolution settings not match\n");
-	} else {
-		ad2s1210_set_resolution_pin(st);
-	}
+	ad2s1210_set_resolution_pin(st);
 	ret = len;
 	st->hysteresis = !!(data & AD2S1210_ENABLE_HYSTERESIS);
 
@@ -395,13 +372,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 	}
 	st->resolution
 		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
-	if (st->pdata->gpioin) {
-		data = ad2s1210_read_resolution_pin(st);
-		if (data != st->resolution)
-			dev_warn(dev, "ad2s1210: resolution settings not match\n");
-	} else {
-		ad2s1210_set_resolution_pin(st);
-	}
+	ad2s1210_set_resolution_pin(st);
 	ret = len;
 error_ret:
 	mutex_unlock(&st->lock);
@@ -622,10 +593,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	if (st->pdata->gpioin)
-		st->resolution = ad2s1210_read_resolution_pin(st);
-	else
-		ad2s1210_set_resolution_pin(st);
+	ad2s1210_set_resolution_pin(st);
 
 	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
 	if (ret < 0)
@@ -660,11 +628,11 @@ static const struct iio_info ad2s1210_info = {
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
-	struct ad2s1210_gpio *pin = st->pdata->gpioin ? &gpios_in[0] : &gpios_out[0];
+	struct ad2s1210_gpio *pin = &gpios[0];
 	struct spi_device *spi = st->sdev;
 	int i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(gpios_in); i++) {
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
 		st->gpios[i] = devm_gpiod_get(&spi->dev, pin[i].name,
 					      pin[i].flags);
 		if (IS_ERR(st->gpios[i])) {
@@ -692,7 +660,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	st->pdata = spi->dev.platform_data;
 	ret = ad2s1210_setup_gpios(st);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index 63d479b20a6c..e69de29bb2d1 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -1,17 +0,0 @@
-/*
- * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
- * AD2S1210
- *
- * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef _AD2S1210_H
-#define _AD2S1210_H
-
-struct ad2s1210_platform_data {
-	bool			gpioin;
-};
-#endif /* _AD2S1210_H */
-- 
2.17.1

