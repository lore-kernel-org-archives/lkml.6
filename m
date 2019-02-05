Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD5AC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CF420818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxzFG/mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfBERNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:13:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46700 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBERNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:13:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so2490712qkf.13;
        Tue, 05 Feb 2019 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aQd3C5xCPpWRDiZ/M0ZBxtyqHjtchjaQtFbs62Zunek=;
        b=PxzFG/mklzS2hbm4u4aSJaDbmwffQB90kR0QqJXTuZev5Klb8Tsh0ViDZHPSD8xS69
         BkIRn/Jqu4eK8gk38EAjVPFbaJdLJJSB6oL+e1A8hHermOG4AsXsmOBp68UxPJWwANA0
         xTT036x3DjHW4ZG4qfNnlx0vcheEM7JEzxDo8O7t2zkVBJ/6eb2F6ZBhB82mS8Qez4pD
         q8BgaboGMaWBNTox+3enXzdWN6o6EVSIH/zrBkwZnLV3ELpI0bFkxCvmKItY6BH7vfAd
         hqparb/+2A3wfSnjC8mBTCXON4+H8qZVSj+gcAnRxJyAa5VyJ8YcNiFrDnNX23K1flCh
         RRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQd3C5xCPpWRDiZ/M0ZBxtyqHjtchjaQtFbs62Zunek=;
        b=JqTGXVKsS18pCPqQZQ7DaJSO848CHnrgHIzetuONU0na1y0JNjd2T+n0Z1yQgCNA7s
         CYj8h5NJZ56t1VPJt+EYdyHF9VT0bKBpGgbSbLhHai4MiP+RgDc3JVGVDRmVWC56tpoC
         N3ljXwlkPl8cw4L8Xp0bn1/+Ahv4oxcENN4eWck3GI9YOzpBeMUDgB317kOXj/3ctcwz
         P/gijNz3qdVQEzabKgtLWHRpPH0DOABXdVPK1f5VHmvNCUJfPQNu9/fAnXDtFfUchWne
         AcjdF3IsDAkaPS++m1/zyEp3MnmVDWZqxHZ6CqI+QJWxnoQvGYdXItSRzickURo6XUHF
         N05A==
X-Gm-Message-State: AHQUAuYC52jM44pL4BTBDt1GQSw3U9TWgJDCJvj4L14qLW1ZBDBIUFD8
        0JrwC343xCaV7LSkqThKdyw=
X-Google-Smtp-Source: AHgI3IaXT0GkBrFrFSgXrFK0KdaZXJfSKSm7ZWQmxAin/PrtK/o85nHmYWEqSn12P4g6BGVoErbGvQ==
X-Received: by 2002:ae9:c215:: with SMTP id j21mr1998296qkg.97.1549386786576;
        Tue, 05 Feb 2019 09:13:06 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v30sm5846963qtk.13.2019.02.05.09.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:13:06 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:13:00 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 1/4] staging: iio: ad7780: add gain & filter gpio support
Message-ID: <786543cbd8d60776083bcaca66f83502f23f561b.1549385784.git.renatogeh@gmail.com>
References: <cover.1549385784.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1549385784.git.renatogeh@gmail.com>
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
Changes in v3:
	- Renamed ad7780_chip_info's filter to odr
	- Renamed ad778x_filter to ad778x_odr_avail
	- Changed vref variable from unsigned int to unsigned long long to
	  avoid overflow
	- Removed unnecessary AD_SD_CHANNEL macro

 drivers/staging/iio/adc/ad7780.c | 95 ++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..6e4357800d31 100644
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
+static const unsigned int ad778x_gain[2]      = { 1, 128 };
+static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
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
+	unsigned int			odr;
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
+		*val = st->odr;
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
+	unsigned long long vref;
+	unsigned int full_scale, gain;
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
+		st->odr = ad778x_odr_avail[val];
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
+		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
 	}
 
 	return 0;
@@ -173,6 +232,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 
 static const struct iio_info ad7780_info = {
 	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
 };
 
 static int ad7780_probe(struct spi_device *spi)
@@ -222,6 +282,29 @@ static int ad7780_probe(struct spi_device *spi)
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
-- 
2.20.1

