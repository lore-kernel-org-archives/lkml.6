Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08D121B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlBWMHBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439964AbfBNUbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:31:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42385 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfBNUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:31:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so4411441qkb.9;
        Thu, 14 Feb 2019 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bqRqvhNVTyYdaD0ztfqRsZelS21WOJy0OwQDzRnSrBw=;
        b=jlBWMHBNeyqvNJBNx78mcjPIKvOdefAz5j1+NQgU/Rj/gYAEi/d4SAu9m0z94T192J
         HfPz/h415W0EUmomSNF/cZ6eY13Ez6JjK7fV54c7GpcBrZdYFa3RikSJKx6NUK4f+PbC
         beKm2gZvE0SBnAX/v5aSREMOiiIVnRx5fiBD11eOc6alf3n4Lk6W+0acdRArwzbB8evY
         ++5UtGUkECUusgMUyAYnrJNZsrQkRPjAxSnUfFLglHiEEhMHQuD8ymlgtktyJT9QSs44
         98RD61LuNm5x8ShtMgHtz0IK5clYk0vPXMQsc2NEL+fnzr5QJio4jWeLOmkEOcGnbYhJ
         GTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqRqvhNVTyYdaD0ztfqRsZelS21WOJy0OwQDzRnSrBw=;
        b=nxbipzm0Gwadkb+akOKwA7iit/N4/TutMRCW2ZtZ/BzlZbLiiptvYiawQ9d3GIFi3y
         2MAx9LzUjQ7RcmrYPchyQWMiL53hXCosKntRp7L4RP0Zti1/RbjjYOxNVnapvtqLAaDf
         VXcyB5Su5x4pHg9fjTgku8nAQXPc+osip5D5/tHRk33DxL7hgv0T0tI/VFCSM2sriL+6
         d0gay9BsdkFWIOYNlP6g3IPvjyrodoAQVJgACqQcbKQqyMlMZ0qlFX0bVH7NXoNBpKaA
         EMCYVvxU5IsEoCu6yiCgLOHLQJdJMSR/aCfwRQFsjq4LNqoygNGUXMQZ9uexzLFarAGi
         vpSg==
X-Gm-Message-State: AHQUAuZO9zrjz6+5VZ2Zqvr8itJYzwDvyjUr7QErSrHU/Cg+KMPP/qcN
        xfvYd709+ixRdr+992IpTuc=
X-Google-Smtp-Source: AHgI3IbXHfc7F+Ao4TzxvrW9PFaAkS5YcWSejRRfepDO/fK2pWna1JD+c5AZ3qwZLaMhoTdO4vArlw==
X-Received: by 2002:a37:7602:: with SMTP id r2mr4366347qkc.97.1550176278426;
        Thu, 14 Feb 2019 12:31:18 -0800 (PST)
Received: from renatolg ([191.180.128.219])
        by smtp.gmail.com with ESMTPSA id r24sm2330923qtr.2.2019.02.14.12.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:31:17 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Thu, 14 Feb 2019 18:31:12 -0200
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, giuliano.belinassi@usp.br,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 1/4] staging: iio: ad7780: add gain & filter gpio
 support
Message-ID: <20190214203110.wxdhdnpicfll2ms3@renatolg>
References: <cover.1549385784.git.renatogeh@gmail.com>
 <786543cbd8d60776083bcaca66f83502f23f561b.1549385784.git.renatogeh@gmail.com>
 <20190209162506.0e790885@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190209162506.0e790885@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for the review. Comments inline.

Renato

On 02/09, Jonathan Cameron wrote:
>On Tue, 5 Feb 2019 15:13:00 -0200
>Renato Lui Geh <renatogeh@gmail.com> wrote:
>
>> Previously, the AD7780 driver only supported gpio for the 'powerdown'
>> pin. This commit adds suppport for the 'gain' and 'filter' pin.
>>
>> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
>> Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
>> Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
>Comments inline.
>
>> ---
>> Changes in v3:
>> 	- Renamed ad7780_chip_info's filter to odr
>> 	- Renamed ad778x_filter to ad778x_odr_avail
>> 	- Changed vref variable from unsigned int to unsigned long long to
>> 	  avoid overflow
>> 	- Removed unnecessary AD_SD_CHANNEL macro
>>
>>  drivers/staging/iio/adc/ad7780.c | 95 ++++++++++++++++++++++++++++++--
>>  1 file changed, 89 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
>> index c4a85789c2db..6e4357800d31 100644
>> --- a/drivers/staging/iio/adc/ad7780.c
>> +++ b/drivers/staging/iio/adc/ad7780.c
>> @@ -39,6 +39,15 @@
>>  #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
>>  #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
>>
>> +#define AD7780_GAIN_GPIO	0
>> +#define AD7780_FILTER_GPIO	1
>What are these for?

Sorry about that. That's leftover from a previous attempt.
>
>> +
>> +#define AD7780_GAIN_MIDPOINT	64
>> +#define AD7780_FILTER_MIDPOINT	13350
>> +
>> +static const unsigned int ad778x_gain[2]      = { 1, 128 };
>> +static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
>> +
>>  struct ad7780_chip_info {
>>  	struct iio_chan_spec	channel;
>>  	unsigned int		pattern_mask;
>> @@ -50,7 +59,11 @@ struct ad7780_state {
>>  	const struct ad7780_chip_info	*chip_info;
>>  	struct regulator		*reg;
>>  	struct gpio_desc		*powerdown_gpio;
>> -	unsigned int	gain;
>> +	struct gpio_desc		*gain_gpio;
>> +	struct gpio_desc		*filter_gpio;
>> +	unsigned int			gain;
>> +	unsigned int			odr;
>> +	unsigned int			int_vref_mv;
>>
>>  	struct ad_sigma_delta sd;
>>  };
>> @@ -104,17 +117,65 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>>  		voltage_uv = regulator_get_voltage(st->reg);
>>  		if (voltage_uv < 0)
>>  			return voltage_uv;
>> -		*val = (voltage_uv / 1000) * st->gain;
>> +		voltage_uv /= 1000;
>> +		*val = voltage_uv * st->gain;
>>  		*val2 = chan->scan_type.realbits - 1;
>> +		st->int_vref_mv = voltage_uv;
>>  		return IIO_VAL_FRACTIONAL_LOG2;
>>  	case IIO_CHAN_INFO_OFFSET:
>>  		*val = -(1 << (chan->scan_type.realbits - 1));
>>  		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = st->odr;
>> +		return IIO_VAL_INT;
>>  	}
>>
>>  	return -EINVAL;
>>  }
>>
>> +static int ad7780_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val,
>> +			    int val2,
>> +			    long m)
>> +{
>> +	struct ad7780_state *st = iio_priv(indio_dev);
>> +	const struct ad7780_chip_info *chip_info = st->chip_info;
>> +	unsigned long long vref;
>> +	unsigned int full_scale, gain;
>> +
>> +	if (!chip_info->is_ad778x)
>> +		return 0;
>> +
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (val != 0)
>> +			return -EINVAL;
>> +
>> +		vref = st->int_vref_mv * 1000000LL;
>> +		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
>> +		gain = DIV_ROUND_CLOSEST(vref, full_scale);
>> +		gain = DIV_ROUND_CLOSEST(gain, val2);
>> +		st->gain = gain;
>> +		if (gain < AD7780_GAIN_MIDPOINT)
>> +			gain = 0;
>> +		else
>> +			gain = 1;
>> +		gpiod_set_value(st->gain_gpio, gain);
>> +	break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
>> +			val = 0;
>> +		else
>> +			val = 1;
>> +		st->odr = ad778x_odr_avail[val];
>> +		gpiod_set_value(st->filter_gpio, val);
>> +	break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>>  				     unsigned int raw_sample)
>>  {
>> @@ -126,10 +187,8 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>>  		return -EIO;
>>
>>  	if (chip_info->is_ad778x) {
>> -		if (raw_sample & AD7780_GAIN)
>> -			st->gain = 1;
>> -		else
>> -			st->gain = 128;
>> +		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
>> +		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
>>  	}
>>
>>  	return 0;
>> @@ -173,6 +232,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>>
>>  static const struct iio_info ad7780_info = {
>>  	.read_raw = ad7780_read_raw,
>> +	.write_raw = ad7780_write_raw,
>>  };
>>
>>  static int ad7780_probe(struct spi_device *spi)
>> @@ -222,6 +282,29 @@ static int ad7780_probe(struct spi_device *spi)
>>  		goto error_disable_reg;
>>  	}
>>
>> +	if (st->chip_info->is_ad778x) {
>> +		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
>> +							"gain",
>
>These are not particularly standard names (basically not "reset"),
>so they should be vendor prefixed, so that people know to go
>look at the device specific binding.

I see. Should they be something like "adi,gain" and "adi,filter"? Am I
correct to assume that I'll have to somehow mention these in the
dt-binding?
>
>> +							GPIOD_OUT_HIGH);
>> +		if (IS_ERR(st->gain_gpio)) {
>> +			ret = PTR_ERR(st->gain_gpio);
>> +			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
>> +				ret);
>> +			goto error_disable_reg;
>> +		}
>> +
>> +		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
>> +							  "filter",
>> +							  GPIOD_OUT_HIGH);
>> +		if (IS_ERR(st->filter_gpio)) {
>> +			ret = PTR_ERR(st->filter_gpio);
>> +			dev_err(&spi->dev,
>> +				"Failed to request filter GPIO: %d\n",
>> +				ret);
>> +			goto error_disable_reg;
>> +		}
>> +	}
>> +
>>  	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>>  	if (ret)
>>  		goto error_disable_reg;
>
