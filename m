Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D423BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2A7214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp1Pq0IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2A7214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbeKVEkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:40:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45830 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeKVEkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:40:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so4814616qtr.12;
        Wed, 21 Nov 2018 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jCGPeT4nSIx5YEdLMXCLT7U8HgFLSDA8lE2Af7qAeXQ=;
        b=Jp1Pq0IWFqeLoayyeTbBuh81N8z15q6TFgG/ZToT77uc44lvr+2CTpALjhkidJs079
         Dx/CcdqD0c75NkfdMZBoSn/qHmHQr2seoQMD0YDWpiS+JqfZOgvGol1SM5vHzJSkrSTN
         MAI3xvvpzcOiuxWhe3CuGVOAe4X0Zmx+TX4pKS2xtqH5SpVgNe7A2yECbZrwLILoRYcr
         iR/iEGcZ8RkS3KMLp9pleCkj/GUfEMFJZOtRZ3EpxChWCvEIBTpvw2EW8fAoXR7gyUAw
         wV4PzH0oXvJ6xPvqYN+nxx2v23Q8FqKSGjHnE0jOptR22NyGa8m6E3DK9ZJYeBJA33Tf
         Vqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jCGPeT4nSIx5YEdLMXCLT7U8HgFLSDA8lE2Af7qAeXQ=;
        b=LF6nwwPS+S8IXkMwWtkiAVIk9Zu14L5BP/2f0Xv9JiHAfZxYpbpn9QfBcGSHNkTKxk
         yfg3IPBkQ2VLmbm9cvL1H9zmTLrsxeAUmzgew21C9HKW81jqJ8NlI94d2qYYxlxG11tL
         qn//isroh7oOwUfdLNkGIA/3mDLxHpB4aeMF5wY2FmhCIZpOzOGnLSpciIjEwnC3KQ8Y
         ZHNB6jO64a4gp/Qt8dvio4hf9ht+skChzi06yg3EVKT5SNPolWu7mMuL1ZVZ9BPtgOeS
         DcG52GO1TeG3g6bPKOdiAq91bsT2Q6YWmsTyEDsXh73P8E74DRtSFyhxLZZc0kj2BezG
         xyHw==
X-Gm-Message-State: AA+aEWaNACqb0VPAPrOTTTvuyx7RUk4sWati6YCPTNVKBkDc+E8au+bQ
        hcYFulbOMRlQ3/52irkF1DA=
X-Google-Smtp-Source: AFSGD/V70Q3Ao1wqqVo5PkbrKxNT9f+DH/xZ/rYHt/YzCu1WA1LVw7i+OSo82fbEG9lyjQAIqM5O6g==
X-Received: by 2002:ac8:48c1:: with SMTP id l1mr2640265qtr.71.1542823492004;
        Wed, 21 Nov 2018 10:04:52 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o49sm26987800qtf.60.2018.11.21.10.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 10:04:51 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 21 Nov 2018 16:04:43 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the AD7780 driver only supported gpio for the 'powerdown'
pin. This commit adds suppport for the 'gain' and 'filter' pin.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c       | 61 ++++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  5 +++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..69794f06dbcd 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -39,6 +39,9 @@
 #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
 #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
 
+#define AD7780_GAIN_GPIO	0
+#define AD7780_FILTER_GPIO	1
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -50,6 +53,8 @@ struct ad7780_state {
 	const struct ad7780_chip_info	*chip_info;
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
+	struct gpio_desc		*gain_gpio;
+	struct gpio_desc		*filter_gpio;
 	unsigned int	gain;
 
 	struct ad_sigma_delta sd;
@@ -115,18 +120,51 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7780_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+
+	if (m != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if (st->chip_info->is_ad778x) {
+		switch(val) {
+		case AD7780_GAIN_GPIO:
+			gpiod_set_value(st->gain_gpio, val2);
+		break;
+		case AD7780_FILTER_GPIO:
+			gpiod_set_value(st->filter_gpio, val2);
+		break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 				     unsigned int raw_sample)
 {
 	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
 	const struct ad7780_chip_info *chip_info = st->chip_info;
+	int val;
 
 	if ((raw_sample & AD7780_ERR) ||
 	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
 		return -EIO;
 
 	if (chip_info->is_ad778x) {
-		if (raw_sample & AD7780_GAIN)
+		val = raw_sample & AD7780_GAIN;
+
+		if (val != gpiod_get_value(st->gain_gpio))
+			return -EIO;
+
+		if (val)
 			st->gain = 1;
 		else
 			st->gain = 128;
@@ -141,18 +179,20 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 	.has_registers = false,
 };
 
-#define AD7780_CHANNEL(bits, wordsize) \
+#define AD7170_CHANNEL(bits, wordsize) \
 	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
+#define AD7780_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-		.channel = AD7780_CHANNEL(12, 24),
+		.channel = AD7170_CHANNEL(12, 24),
 		.pattern = AD7170_PATTERN,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
-		.channel = AD7780_CHANNEL(16, 24),
+		.channel = AD7170_CHANNEL(16, 24),
 		.pattern = AD7170_PATTERN,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
@@ -173,6 +213,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 
 static const struct iio_info ad7780_info = {
 	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
 };
 
 static int ad7780_probe(struct spi_device *spi)
@@ -222,6 +263,18 @@ static int ad7780_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	}
 
+	if (st->chip_info->is_ad778x) {
+		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
+							"gain",
+							GPIOD_OUT_HIGH);
+		if (IS_ERR(st->gain_gpio)) {
+			ret = PTR_ERR(st->gain_gpio);
+			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
+				ret);
+			goto error_disable_reg;
+		}
+	}
+
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
 		goto error_disable_reg;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 730ead1a46df..6cadab6fd5fd 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -173,6 +173,11 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
 
+#define AD_SD_CHANNEL_GAIN_FILTER(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, BIT(IIO_CHAN_INFO_RAW))
+
 #define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
 	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_TEMP, \
-- 
2.19.1

