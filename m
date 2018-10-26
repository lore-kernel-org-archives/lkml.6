Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA62C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3FD20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9qQ6Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3FD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJZWBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:01:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46121 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:01:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so530990pfb.13;
        Fri, 26 Oct 2018 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mWejzS4tfiPSW0zer83uPgJ1SMZ4PMy9yb4StfnxnfA=;
        b=UG9qQ6KuKE+MKrSfTM5A5Y+gi2TjFXXCG1o+4mvR2xvxRgKJ2m50CyX/vji8qSOFgk
         UR6Pbi3SzdkKWhNf7gX4w8YGRmYuWTzZELbDs5nh9wa5k/x23MzeKXLdZ+LpF9wzlJSy
         kLFLnmIvoPMpUH062+DR/E5opSA2ruVcC10WF9x7119rg655Nzn0uCBkYvYVaFqzPDq5
         b9GDQZuWsWZx2HyReOW20Pc34J1AZ1dbZV5a60XGq5cfX2Fu6+J4mqsY78s3i3KZSH72
         Do9l2KJ45LQmNXpmhmvzz/uMPyC/4dnSU89/VbNw2aHRM8wXcl0S8Vwp2nSELp1vI9xf
         2qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mWejzS4tfiPSW0zer83uPgJ1SMZ4PMy9yb4StfnxnfA=;
        b=oeh2bEgbGvs3Kqgqn6sbFC1i0tXeuwz5VHFD/xpq80XICK8cLOnEpEfIbEgQeXCg9X
         50/Z97znAfDgNEAzkw1tJ+48OMNUnBZLyKKMtB+Gh9xGjB6K6y6J1kwZ5kDwWVMGJm2C
         a/wgsAX0lflSDH4YlUkokcTd8ruMIcbrAz0ZWaTA9oKwsEj4gTMy5PMFajp85eNw3V2k
         5L1i2gDIBHoNblmRJStlDV4puCQRQtPRfU5SRjyQi2sIfBLNDLrPZYg5b+gcBGnfLKrq
         2ahVzieILm4uKMeLEc4RAyBxMvzl+YnEvlmNOavJ6tVi2Sx+ZLM760zh8ek93jdKkm61
         EKBA==
X-Gm-Message-State: AGRZ1gIA+1hKT1BGY3s9Ymx9vRbVyoh4ocfPH8reXcDtWSVQm1wyBItX
        RDpdk9a4XJqpXeiwA/V8OTM=
X-Google-Smtp-Source: AJdET5fkCs3DlFiYt8QEh8SdFv0m015aat4PQmXDqzWJINLRUh4lhW13N0dr83sQ4QqQsVcl1sYJjg==
X-Received: by 2002:a63:5b4a:: with SMTP id l10-v6mr3543778pgm.50.1540560283137;
        Fri, 26 Oct 2018 06:24:43 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id u62-v6sm22080274pfu.69.2018.10.26.06.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 06:24:42 -0700 (PDT)
Date:   Fri, 26 Oct 2018 18:54:36 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <1ca4163a58ce1f7e43f83f94e8b718841a02723a.1540489369.git.nishadkamdar@gmail.com>
References: <cover.1540489369.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540489369.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.
---
 drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
 drivers/staging/iio/resolver/ad2s1210.h |  3 -
 2 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..93c3c70ce62e 100644
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
@@ -69,10 +69,21 @@ enum ad2s1210_mode {
 
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
+struct ad2s1210_gpio {
+	struct gpio_desc **ptr;
+	const char *name;
+	unsigned long flags;
+};
+
 struct ad2s1210_state {
 	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
 	struct spi_device *sdev;
+	struct gpio_desc *sample;
+	struct gpio_desc *a0;
+	struct gpio_desc *a1;
+	struct gpio_desc *res0;
+	struct gpio_desc *res1;
 	unsigned int fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
@@ -91,8 +102,8 @@ static const int ad2s1210_mode_vals[4][2] = {
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
 				     struct ad2s1210_state *st)
 {
-	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
-	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
+	gpiod_set_value(st->a0, ad2s1210_mode_vals[mode][0]);
+	gpiod_set_value(st->a1, ad2s1210_mode_vals[mode][1]);
 	st->mode = mode;
 }
 
@@ -152,8 +163,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 
 static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 {
-	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
-			  gpio_get_value(st->pdata->res[1]);
+	int resolution = (gpiod_get_value(st->res0) << 1) |
+			  gpiod_get_value(st->res1);
 
 	return ad2s1210_resolution_value[resolution];
 }
@@ -164,10 +175,10 @@ static const int ad2s1210_res_pins[4][2] = {
 
 static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
 {
-	gpio_set_value(st->pdata->res[0],
-		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
-	gpio_set_value(st->pdata->res[1],
-		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
+	gpiod_set_value(st->res0,
+			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
+	gpiod_set_value(st->res1,
+			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
 }
 
 static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
@@ -401,15 +412,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
+	gpiod_set_value(st->sample, 0);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->sample, 1);
 	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
 	if (ret < 0)
 		goto error_ret;
-	gpio_set_value(st->pdata->sample, 0);
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->sample, 0);
+	gpiod_set_value(st->sample, 1);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -466,7 +477,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	s16 vel;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
+	gpiod_set_value(st->sample, 0);
 	/* delay (6 * tck + 20) nano seconds */
 	udelay(1);
 
@@ -512,7 +523,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	}
 
 error_ret:
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->sample, 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
 	mutex_unlock(&st->lock);
@@ -630,30 +641,32 @@ static const struct iio_info ad2s1210_info = {
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
-	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
-	struct gpio ad2s1210_gpios[] = {
-		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
-		{ st->pdata->a[0], flags, "a0" },
-		{ st->pdata->a[1], flags, "a1" },
-		{ st->pdata->res[0], flags, "res0" },
-		{ st->pdata->res[0], flags, "res1" },
+	int ret, i;
+	struct spi_device *spi = st->sdev;
+	struct ad2s1210_gpio *pin;
+	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
+
+	struct ad2s1210_gpio gpios[] = {
+		{ .ptr = &st->sample, .name = "sample", .flags = GPIOD_IN },
+		{ .ptr = &st->a0, .name = "a0", .flags = flags },
+		{ .ptr = &st->a1, .name = "a1", .flags = flags },
+		{ .ptr = &st->res0, .name = "res0", .flags = flags },
+		{ .ptr = &st->res1, .name = "res1", .flags = flags },
 	};
 
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
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		pin = &gpios[i];
+		*pin->ptr = devm_gpiod_get(&spi->dev, pin->name, pin->flags);
+		if (IS_ERR(*pin->ptr)) {
+			ret = PTR_ERR(*pin->ptr);
+			dev_err(&spi->dev,
+				"ad2s1210: failed to request %s GPIO: %d\n",
+				pin->name, ret);
+			return ret;
+		}
+	}
 
-	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
+	return 0;
 }
 
 static int ad2s1210_probe(struct spi_device *spi)
@@ -692,7 +705,7 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_gpios;
+		return ret;
 
 	st->fclkin = spi->max_speed_hz;
 	spi->mode = SPI_MODE_3;
@@ -700,10 +713,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	ad2s1210_initial(st);
 
 	return 0;
-
-error_free_gpios:
-	ad2s1210_free_gpios(st);
-	return ret;
 }
 
 static int ad2s1210_remove(struct spi_device *spi)
@@ -711,7 +720,6 @@ static int ad2s1210_remove(struct spi_device *spi)
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

