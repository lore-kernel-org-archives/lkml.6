Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27FBC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2962133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPfaiqiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfA0Ua4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:30:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39131 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0Ua4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:30:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so16225126qtj.6;
        Sun, 27 Jan 2019 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Wyzn18E8EViVwbKozTu5GGL8ZVrWP1UuCuVsuTRtWv0=;
        b=aPfaiqiIg3TfjJETn2zIUKrM+olaKIzkRjGw3DXAbrZnWGlSpMqDRTs3VK4NTdwA8j
         pzVZniNL/Dud28IOpfxq4titbtFzYDp+dA5fshPgWrEsJQiOhlsjThE1k7CynWqEFzff
         QmQXo/MroC54qhKeA2YzwBKmmZq3rNSukKTP3Zvi7G4aPxbxPvXVuh00Fq4BR2QIxQnn
         fxA43QAPVqAsKvTcEumWA0+93RdQiTjnJUFpqnr1ZXdQ5kBCjnjnxlzl1u4La1xHIz0M
         ZPdK9y5QwvDLYFRBSQtX4suYH3KGcdDkX2qS03Cys/gqz8xnoD0cnQyQhXk/2n/+rZoR
         OCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Wyzn18E8EViVwbKozTu5GGL8ZVrWP1UuCuVsuTRtWv0=;
        b=UmupQoW2owtCeZJqfGlRjySjL+VN9j8YwKCY8Z+RPmP2VIvhG9hpMab8bbYsZfsoLs
         J/U77rUJCnmUaOya2W40VJrzW92ikkFjTtbeX54bLc93TC31ZxUZe8f/Clai99h9TwVZ
         HLkTs4L71jy4s6CarA0iY1BVkSMuedSQLLM6yznKbrlrqtZJjkKhV6bbYyBZgiV+0RqB
         UwKnfYMoM+BXzabKb7Y5GqI9F1vwJXNTBablhKEWK0v74xcQmoSe4i0Q1J3d4lYe5Srh
         zf9kcFWzsYUY3/Y10WkTwV3kwpcD0wsJqRI5mnTUnt3YaOtDZCW+DM1ZhVXJ/kogG/jp
         wn9Q==
X-Gm-Message-State: AJcUukeUy++QdGnoqKq+C22mBAv52O8cDlSCXX6e0QH25Vp1T9uZvUsh
        DZXK1gSNNe//nM0eZm657Kg=
X-Google-Smtp-Source: ALg8bN4XOo9763SfAgsxXL8SGVwauj66wy9Jf7CiGplOOHKkr84fwWXBBB3SBAAvxf3xQQt46JT6sQ==
X-Received: by 2002:ac8:4284:: with SMTP id o4mr18921306qtl.389.1548621054860;
        Sun, 27 Jan 2019 12:30:54 -0800 (PST)
Received: from renatolg ([186.220.19.121])
        by smtp.gmail.com with ESMTPSA id u50sm101564821qta.23.2019.01.27.12.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 12:30:54 -0800 (PST)
Date:   Sun, 27 Jan 2019 18:30:47 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/2] staging: iio: ad7780: add gain & filter gpio support
Message-ID: <20190127203044.yytctplecwey4an4@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the AD7780 driver only supported gpio for the 'powerdown'
pin. This commit adds suppport for the 'gain' and 'filter' pin.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v2:
	- Filter reading changed to mHz
	- Storing filter, gain and voltage to chip_info

 drivers/staging/iio/adc/ad7780.c       | 103 ++++++++++++++++++++++---
 include/linux/iio/adc/ad_sigma_delta.h |   5 ++
 2 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..82394e31b168 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -39,6 +39,15 @@
 #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
 #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
 
+#define AD7780_GAIN_GPIO	0
+#define AD7780_FILTER_GPIO	1
+
+#define AD7780_GAIN_MIDPOINT	64
+#define AD7780_FILTER_MIDPOINT	13350
+
+static const unsigned int ad778x_gain[2]    = { 1, 128 };
+static const unsigned int ad778x_filter[2]  = { 10000, 16700 };
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -50,7 +59,11 @@ struct ad7780_state {
 	const struct ad7780_chip_info	*chip_info;
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
-	unsigned int	gain;
+	struct gpio_desc		*gain_gpio;
+	struct gpio_desc		*filter_gpio;
+	unsigned int			gain;
+	unsigned int			filter;
+	unsigned int			int_vref_mv;
 
 	struct ad_sigma_delta sd;
 };
@@ -104,17 +117,65 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 		voltage_uv = regulator_get_voltage(st->reg);
 		if (voltage_uv < 0)
 			return voltage_uv;
-		*val = (voltage_uv / 1000) * st->gain;
+		voltage_uv /= 1000;
+		*val = voltage_uv * st->gain;
 		*val2 = chan->scan_type.realbits - 1;
+		st->int_vref_mv = voltage_uv;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->filter;
+		return IIO_VAL_INT;
 	}
 
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
+	int vref, gain;
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
+		vref = st->int_vref_mv * 1000000LL;
+		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
+		gain = DIV_ROUND_CLOSEST(vref, full_scale);
+		gain = DIV_ROUND_CLOSEST(gain, val2);
+		st->gain = gain;
+		if (gain < AD7780_GAIN_MIDPOINT)
+			gain = 0;
+		else
+			gain = 1;
+		gpiod_set_value(st->gain_gpio, gain);
+	break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
+			val = 0;
+		else
+			val = 1;
+		st->filter = ad778x_filter[val];
+		gpiod_set_value(st->filter_gpio, val);
+	break;
+	}
+
+	return 0;
+}
+
 static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 				     unsigned int raw_sample)
 {
@@ -126,10 +187,8 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 		return -EIO;
 
 	if (chip_info->is_ad778x) {
-		if (raw_sample & AD7780_GAIN)
-			st->gain = 1;
-		else
-			st->gain = 128;
+		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
+		st->filter = ad778x_filter[raw_sample & AD7780_FILTER];
 	}
 
 	return 0;
@@ -141,18 +200,20 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
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
@@ -173,6 +234,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 
 static const struct iio_info ad7780_info = {
 	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
 };
 
 static int ad7780_probe(struct spi_device *spi)
@@ -222,6 +284,29 @@ static int ad7780_probe(struct spi_device *spi)
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
+
+		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
+							  "filter",
+							  GPIOD_OUT_HIGH);
+		if (IS_ERR(st->filter_gpio)) {
+			ret = PTR_ERR(st->filter_gpio);
+			dev_err(&spi->dev,
+				"Failed to request filter GPIO: %d\n",
+				ret);
+			goto error_disable_reg;
+		}
+	}
+
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
 		goto error_disable_reg;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7e84351fa2c0..c01da869de83 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -176,6 +176,11 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
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
2.20.1

