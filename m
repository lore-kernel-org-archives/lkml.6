Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C95206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFQy2hpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C95206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeK2FSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:18:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38734 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:18:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so26919777qtl.5;
        Wed, 28 Nov 2018 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iP89O5yt8cPK3Ietczi17UITaQMICxETiZ1FFCX7LK4=;
        b=mFQy2hpk1BwpKhVnSVD0ZRV2/kKz4U/lxtD1dpIyAmGI3HeZ3jmFxB8QauGEDhNlpZ
         PggN+ejiBId02wwSNC2He+568sk/40WB4aMZlXgn/w56DdK9jbHns/q04FOamo5RBe9P
         LzkR3xixdPRXnctjrVRkVlBNOSGSp1qxT98EQOp2/L1g4kl2SfWyzzaE8+rIJsHZigPM
         7ar0ijxmOwaLiF0MwVRtRylTdEpNgmHR5ht6SAN1MwzaUBkIZXKbO0bwPpwoIpPLhMHo
         SjE3bp9321rJB02FVwkNMcsN2Dn7+lDg41k+/KbKO1f1PcecME9hEMUvKp+mj9ruL4RK
         NabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iP89O5yt8cPK3Ietczi17UITaQMICxETiZ1FFCX7LK4=;
        b=iK9Bf6MSrTy4vwOYHXmOrxjPhW9v9sHON7FvBxPETb+pEvbNDtC/za5et1fgJ8hW4c
         b5DnXx9GTwNMrRVOy6kTx+M4HamMGiGsM6NwnIrmGtFXGGxTmvHqPg+IZcO8fRR0zNgi
         2etJU4cM1hDOhJ6YfW1LOgpzhlbE5l91ScRjztwP5ZQdcc/XTfkzIQXRQTIBnev4XXpC
         /ZDaz/Hp16MYaYVKP086S8x2UaoTBawLnfS+rGlyFZfR6GF7O93vFJQQqkmW3zH5OMz2
         iUkaomsGov3Qj2kd/3sDKrZIhTCGem473eaLS6eoWrv1dOid39yAK9glOynhnMoQ1/mI
         KAfg==
X-Gm-Message-State: AGRZ1gLD9/JaewalPSAJKDXfuKqKtbx5ikVz1MjBsCgn+ArYGF78sQey
        K1YBviOXILmz7Q0So7utpmA=
X-Google-Smtp-Source: AJdET5dlTKURXYkorNoNwt3tQbHpK3Eh78GXcdP6AY9K8CotL0//w+w2VBPr5hULsuuNY1OtvruURw==
X-Received: by 2002:ac8:3518:: with SMTP id y24mr36002794qtb.241.1543428965393;
        Wed, 28 Nov 2018 10:16:05 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id k185sm3613156qkd.62.2018.11.28.10.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 10:16:04 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 28 Nov 2018 16:15:59 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/2] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <231cbc909b892a0ebe172460d34e9eeb9cfa3003.1543428366.git.giuliano.belinassi@usp.br>
References: <cover.1543428366.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543428366.git.giuliano.belinassi@usp.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the AD7780 driver only supported gpio for the 'powerdown'
pin. This commit adds suppport for the 'gain' and 'filter' pin.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v2:
    - Now this patch is part of the patchset that aims to remove ad7780
out of staging. https://marc.info/?l=linux-iio&m=154282349808890&w=2
    - Also, now it reads voltage and filter values from the userspace
instead of gpio pin states.

 drivers/staging/iio/adc/ad7780.c       | 78 ++++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  5 ++
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..05979a79fda3 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -39,6 +39,12 @@
 #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
 #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
 
+#define AD7780_GAIN_GPIO	0
+#define AD7780_FILTER_GPIO	1
+
+#define AD7780_GAIN_MIDPOINT	64
+#define AD7780_FILTER_MIDPOINT	13350
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -50,6 +56,8 @@ struct ad7780_state {
 	const struct ad7780_chip_info	*chip_info;
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
+	struct gpio_desc		*gain_gpio;
+	struct gpio_desc		*filter_gpio;
 	unsigned int	gain;
 
 	struct ad_sigma_delta sd;
@@ -115,18 +123,65 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7780_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+	const struct ad7780_chip_info *chip_info = st->chip_info;
+	int uvref, gain;
+	unsigned int full_scale;
+
+	if (!chip_info->is_ad778x)
+		return 0;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val != 0)
+			return -EINVAL;
+
+		uvref = regulator_get_voltage(st->reg);
+
+		if (uvref < 0)
+			return uvref;
+
+		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
+		gain = DIV_ROUND_CLOSEST(uvref, full_scale);
+		gain = DIV_ROUND_CLOSEST(gain, val2);
+
+		gpiod_set_value(st->gain_gpio, gain < AD7780_GAIN_MIDPOINT ? 0 : 1);
+	break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0)
+			return -EINVAL;
+
+		gpiod_set_value(st->filter_gpio, val < AD7780_FILTER_MIDPOINT ? 0 : 1);
+	break;
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
@@ -141,18 +196,20 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
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
@@ -173,6 +230,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 
 static const struct iio_info ad7780_info = {
 	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
 };
 
 static int ad7780_probe(struct spi_device *spi)
@@ -222,6 +280,18 @@ static int ad7780_probe(struct spi_device *spi)
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

