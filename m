Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4020D20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSTrDzaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4020D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeKAA5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:57:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38642 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeKAA5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:57:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so7828985pfi.5;
        Wed, 31 Oct 2018 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2w9Mcpjm7MYB5Rop0fmMMmUwu5zTLpOe3lPx2S6vcfU=;
        b=KSTrDzaaRgCJv3I5gePJ41GHeWAsPzM6ALuCEm0TNTbbhIA+F3j6uTUVyJn8H3y2gU
         IuUYOJq2n5BmHbO/pPuwqxlXGUhGnT/HpYwmWIjo5r4V7tVvJvIXFl2wOLFkuS2TYvmI
         mFKi98u6Tl2k/zKbWlm8MJwOKriVBTXY2TY0SMEuP2sh2bT4sD40mkKUzjEx94cxOiME
         ieOtINq0u4QJETc47eWT3Fycvd8UTXfhTEYDPAB+68DLWO1bTGH5HaQ1RdTa8Pup9DRN
         7PsxRyEQqGfFawsqLAr+wfYn2dp+KYZxhIDksMaHXAsu+aYSa6bV5XJ1VI3WxW6rH0a8
         t1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2w9Mcpjm7MYB5Rop0fmMMmUwu5zTLpOe3lPx2S6vcfU=;
        b=uQmaR+EWOQTMZGN0XmQYGbabMtQCiMK1+Vv3waLTyHSxX+T6aUNzTqPtsFzCxIsg+d
         VIgRcMr5uJANyh0Xql9WD6+nbbvV/FgUyuXY5wCUO/zSL/sJSqrQYQxtQrXT7ij3CJUm
         Q7NfuzrEowSOsX+4+vgR1wCtwNZdU992Psx0P15MDP1KVWCvmg+qGNtMqELl3+vKGtvq
         28UO8Q5xqEzKdpqTBOJPVkc0uTXf6h9KvvDLVKIQuiT4eZ1u0rh0wfVVedylCX0E27RA
         Kp/f5KoE76ML9nvfaVsShYU0gqgz5LmcJb4m982gQ902U8ouhOp1jt7AxqaMsl2CQNv2
         dy+A==
X-Gm-Message-State: AGRZ1gJSWj3mksfcqDNOZgXP1fmgahpQmfKyXxRwiP8S5qEMVPwWQWxZ
        GqKiryBqPbRXJb2KzoQLDIw=
X-Google-Smtp-Source: AJdET5ekj3ZuRUsPLA4RPeGB0TdlIh0H2bDwnMF5ewlV/cgcmNI/K6e0e1NQkiv63QFcoCxUriuNmg==
X-Received: by 2002:a63:1848:: with SMTP id 8mr3645014pgy.81.1541001539893;
        Wed, 31 Oct 2018 08:58:59 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k72-v6sm60536001pfj.63.2018.10.31.08.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:58:59 -0700 (PDT)
Date:   Wed, 31 Oct 2018 21:28:52 +0530
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
Subject: [PATCH v7 1/3] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <1626698317a8f0b1caf5596374088f6d5b6141c9.1541000375.git.nishadkamdar@gmail.com>
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

Use the gpiod interface instead of the deprecated old non-descriptor
interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 106 ++++++++++++++----------
 drivers/staging/iio/resolver/ad2s1210.h |   3 -
 2 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..82ac9847f6f4 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -67,12 +67,42 @@ enum ad2s1210_mode {
 	MOD_RESERVED,
 };
 
+enum ad2s1210_gpios {
+	AD2S1210_SAMPLE,
+	AD2S1210_A0,
+	AD2S1210_A1,
+	AD2S1210_RES0,
+	AD2S1210_RES1,
+};
+
+struct ad2s1210_gpio {
+	const char *name;
+	unsigned long flags;
+};
+
+static const struct ad2s1210_gpio gpios_in[] = {
+	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_IN },
+	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_IN },
+	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_IN },
+	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_IN },
+	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_IN },
+};
+
+static const struct ad2s1210_gpio gpios_out[] = {
+	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_OUT_LOW },
+	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_OUT_LOW },
+	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_OUT_LOW },
+	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_OUT_LOW },
+	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_OUT_LOW },
+};
+
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
 struct ad2s1210_state {
 	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
 	struct spi_device *sdev;
+	struct gpio_desc *gpios[5];
 	unsigned int fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
@@ -91,8 +121,8 @@ static const int ad2s1210_mode_vals[4][2] = {
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
 				     struct ad2s1210_state *st)
 {
-	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
-	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
+	gpiod_set_value(st->gpios[AD2S1210_A0], ad2s1210_mode_vals[mode][0]);
+	gpiod_set_value(st->gpios[AD2S1210_A1], ad2s1210_mode_vals[mode][1]);
 	st->mode = mode;
 }
 
@@ -152,8 +182,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 
 static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 {
-	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
-			  gpio_get_value(st->pdata->res[1]);
+	int resolution = (gpiod_get_value(st->gpios[AD2S1210_RES0]) << 1) |
+			  gpiod_get_value(st->gpios[AD2S1210_RES1]);
 
 	return ad2s1210_resolution_value[resolution];
 }
@@ -164,10 +194,10 @@ static const int ad2s1210_res_pins[4][2] = {
 
 static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
 {
-	gpio_set_value(st->pdata->res[0],
-		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
-	gpio_set_value(st->pdata->res[1],
-		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
+	gpiod_set_value(st->gpios[AD2S1210_RES0],
+			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
+	gpiod_set_value(st->gpios[AD2S1210_RES1],
+			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
 }
 
 static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
@@ -401,15 +431,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
+	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
 	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
 	if (ret < 0)
 		goto error_ret;
-	gpio_set_value(st->pdata->sample, 0);
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
+	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -466,7 +496,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	s16 vel;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
+	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
 	/* delay (6 * tck + 20) nano seconds */
 	udelay(1);
 
@@ -512,7 +542,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	}
 
 error_ret:
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
 	mutex_unlock(&st->lock);
@@ -630,30 +660,23 @@ static const struct iio_info ad2s1210_info = {
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
-	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
-	struct gpio ad2s1210_gpios[] = {
-		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
-		{ st->pdata->a[0], flags, "a0" },
-		{ st->pdata->a[1], flags, "a1" },
-		{ st->pdata->res[0], flags, "res0" },
-		{ st->pdata->res[0], flags, "res1" },
-	};
-
-	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
-}
-
-static void ad2s1210_free_gpios(struct ad2s1210_state *st)
-{
-	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
-	struct gpio ad2s1210_gpios[] = {
-		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
-		{ st->pdata->a[0], flags, "a0" },
-		{ st->pdata->a[1], flags, "a1" },
-		{ st->pdata->res[0], flags, "res0" },
-		{ st->pdata->res[0], flags, "res1" },
-	};
+	struct ad2s1210_gpio *pin = st->pdata->gpioin ? &gpios_in[0] : &gpios_out[0];
+	struct spi_device *spi = st->sdev;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(gpios_in); i++) {
+		st->gpios[i] = devm_gpiod_get(&spi->dev, pin[i].name,
+					      pin[i].flags);
+		if (IS_ERR(st->gpios[i])) {
+			ret = PTR_ERR(st->gpios[i]);
+			dev_err(&spi->dev,
+				"ad2s1210: failed to request %s GPIO: %d\n",
+				pin[i].name, ret);
+			return ret;
+		}
+	}
 
-	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
+	return 0;
 }
 
 static int ad2s1210_probe(struct spi_device *spi)
@@ -692,7 +715,7 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_gpios;
+		return ret;
 
 	st->fclkin = spi->max_speed_hz;
 	spi->mode = SPI_MODE_3;
@@ -700,10 +723,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	ad2s1210_initial(st);
 
 	return 0;
-
-error_free_gpios:
-	ad2s1210_free_gpios(st);
-	return ret;
 }
 
 static int ad2s1210_remove(struct spi_device *spi)
@@ -711,7 +730,6 @@ static int ad2s1210_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
-	ad2s1210_free_gpios(iio_priv(indio_dev));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index e9b2147701fc..63d479b20a6c 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -12,9 +12,6 @@
 #define _AD2S1210_H
 
 struct ad2s1210_platform_data {
-	unsigned int		sample;
-	unsigned int		a[2];
-	unsigned int		res[2];
 	bool			gpioin;
 };
 #endif /* _AD2S1210_H */
-- 
2.17.1

