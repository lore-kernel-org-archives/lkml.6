Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3FCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689F02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwaCbqOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfBAOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:55:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45650 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfBAOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:55:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so7706985qtr.12;
        Fri, 01 Feb 2019 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E8OkaIYYGElosKSNreE4ERGbr/gu+fVYmNoW53K9pUY=;
        b=FwaCbqOYwdlSQuoWDRlHwlST2DxXwpINrLdO+j51FQIjko5v4PA9r0tiazdQm58GzV
         1YBezPgxbLOoTnwux7w5gRd1ie189bS8vY9w7HOPEjrLhkY0bNgdDmlk38ZsOr2X2pyp
         0qSp+bJnsP8ZhETQfpoo6I/etnhUNBnMzksZCYcg5BlaOgIUvl+NB/hJQyuA4mejUf9U
         7up/Wgw9CDKLKe/bLIDu1+eab7Nhx1j926s29m8/UnYPe49Uj5HMAaJtMPTEK6jAX9gX
         rwEC0C6AhWyX8S4nvpvPyE99OVQs5z1lmWhdGTdgAVx4AeCuv+845P7/EZ4bcKa3jj+C
         jGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E8OkaIYYGElosKSNreE4ERGbr/gu+fVYmNoW53K9pUY=;
        b=lMhz3d/k0Irv0/FBe08ECf8wFJXMaDT7LiDmccvAIKop5WibCs23xQ0AvY4+rgV4co
         Rq9B8OGWlcFyi1XhGKQeI42kuIiJedyf6ru3tpBqli0rP09l7OJhIgxdLHRnDrRA0drR
         Hn+qcOvOMylOD6CzuncCpsZfNFocTV3WY2xQH2pTSdBGAHDG/qZwQOg6YIwuQYC+jRop
         w0WBvgwzsgT/+rdXw8TjQCtrVrElPhKyZqgeYGz3mrpDGmwaa5dbOHQYwm4qwtMkOta2
         BrxYQiXucCNh1shrM+3hUuEPUe776wcGCMDQGzBCYGJnFrInt+IdrSyn3N5p8wMjy5qI
         GjYA==
X-Gm-Message-State: AJcUukdjrQNfJcd4+UAcwcm3PricRJMCtSbO9mQGFPCpaHGEkeQsY8Vn
        fwFFSOLiGlbcks7M1Je9ESQ=
X-Google-Smtp-Source: ALg8bN6b6Uj/8SKnu+805nsKPkkZQw3cZDidDNgTuHhNeus+Cg74XImos8wdiCz3GiiTTSedjzZ77w==
X-Received: by 2002:ac8:72c1:: with SMTP id o1mr38838817qtp.220.1549032906806;
        Fri, 01 Feb 2019 06:55:06 -0800 (PST)
Received: from renatolg ([191.180.138.5])
        by smtp.gmail.com with ESMTPSA id r56sm8617908qtj.30.2019.02.01.06.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:55:06 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Fri, 1 Feb 2019 12:55:00 -0200
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: add gain & filter gpio
 support
Message-ID: <20190201145459.ukfzo6s4rvg4c5ri@renatolg>
References: <20190127203044.yytctplecwey4an4@renatolg>
 <1548850985.9460.23.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548850985.9460.23.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30, Popa, Stefan Serban wrote:
>On Du, 2019-01-27 at 18:30 -0200, Renato Lui Geh wrote:
>> Previously, the AD7780 driver only supported gpio for the 'powerdown'
>> pin. This commit adds suppport for the 'gain' and 'filter' pin.
>>
>> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
>> Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
>> Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
>> ---
>> Changes in v2:
>>         - Filter reading changed to mHz
>>         - Storing filter, gain and voltage to chip_info
>
>Hi,

Hi Stefan,

Thanks for the review. Comments inline.

Renato
>
>Comments inline.
>
>Regards,
>Stefan
>
>>
>>  drivers/staging/iio/adc/ad7780.c       | 103 ++++++++++++++++++++++---
>>  include/linux/iio/adc/ad_sigma_delta.h |   5 ++
>>  2 files changed, 99 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7780.c
>> b/drivers/staging/iio/adc/ad7780.c
>> index c4a85789c2db..82394e31b168 100644
>> --- a/drivers/staging/iio/adc/ad7780.c
>> +++ b/drivers/staging/iio/adc/ad7780.c
>> @@ -39,6 +39,15 @@
>>  #define AD7170_PATTERN         (AD7780_PAT0 | AD7170_PAT2)
>>  #define AD7170_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
>>
>> +#define AD7780_GAIN_GPIO       0
>> +#define AD7780_FILTER_GPIO     1
>> +
>> +#define AD7780_GAIN_MIDPOINT   64
>> +#define AD7780_FILTER_MIDPOINT 13350
>> +
>> +static const unsigned int ad778x_gain[2]    = { 1, 128 };
>> +static const unsigned int ad778x_filter[2]  = { 10000, 16700 };
>I would name this array ad778x_odr_avail or something like that.

Sure
>We should also consider adding the option to read the available
>sampling frequencies from user space, but let's leave this for another
>commit.

Do you mean returning 10 and 16.7 Hz?

Should this be done before sending the driver to the main tree, or is it
ok to do something like that after it has left staging?
>
>> +
>>  struct ad7780_chip_info {
>>         struct iio_chan_spec    channel;
>>         unsigned int            pattern_mask;
>> @@ -50,7 +59,11 @@ struct ad7780_state {
>>         const struct ad7780_chip_info   *chip_info;
>>         struct regulator                *reg;
>>         struct gpio_desc                *powerdown_gpio;
>> -       unsigned int    gain;
>> +       struct gpio_desc                *gain_gpio;
>> +       struct gpio_desc                *filter_gpio;
>> +       unsigned int                    gain;
>> +       unsigned int                    filter;
>
>Also, this could be renamed as odr.
>
>> +       unsigned int                    int_vref_mv;
>>
>>         struct ad_sigma_delta sd;
>>  };
>> @@ -104,17 +117,65 @@ static int ad7780_read_raw(struct iio_dev
>> *indio_dev,
>>                 voltage_uv = regulator_get_voltage(st->reg);
>>                 if (voltage_uv < 0)
>>                         return voltage_uv;
>> -               *val = (voltage_uv / 1000) * st->gain;
>> +               voltage_uv /= 1000;
>> +               *val = voltage_uv * st->gain;
>>                 *val2 = chan->scan_type.realbits - 1;
>> +               st->int_vref_mv = voltage_uv;
>>                 return IIO_VAL_FRACTIONAL_LOG2;
>>         case IIO_CHAN_INFO_OFFSET:
>>                 *val = -(1 << (chan->scan_type.realbits - 1));
>>                 return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_SAMP_FREQ:
>> +               *val = st->filter;
>> +               return IIO_VAL_INT;
>>         }
>>
>>         return -EINVAL;
>>  }
>>
>> +static int ad7780_write_raw(struct iio_dev *indio_dev,
>> +                           struct iio_chan_spec const *chan,
>> +                           int val,
>> +                           int val2,
>> +                           long m)
>> +{
>> +       struct ad7780_state *st = iio_priv(indio_dev);
>> +       const struct ad7780_chip_info *chip_info = st->chip_info;
>> +       int vref, gain;
>> +       unsigned int full_scale;
>> +
>> +       if (!chip_info->is_ad778x)
>> +               return 0;
>> +
>> +       switch (m) {
>> +       case IIO_CHAN_INFO_SCALE:
>> +               if (val != 0)
>> +                       return -EINVAL;
>> +
>> +               vref = st->int_vref_mv * 1000000LL;
>
>From the datasheet, the VREF is ±5 V, therefore your vref variable will
>overflow. You probably need unsigned long long.

You're right, I'll fix this in v3.
>
>> +               full_scale = 1 << (chip_info->channel.scane_type.realbis
>> - 1);
>> +               gain = DIV_ROUND_CLOSEST(vref, full_scale);
>> +               gain = DIV_ROUND_CLOSEST(gain, val2);
>> +               st->gain = gain;
>> +               if (gain < AD7780_GAIN_MIDPOINT)
>> +                       gain = 0;
>> +               else
>> +                       gain = 1;
>> +               gpiod_set_value(st->gain_gpio, gain);
>> +       break;
>> +       case IIO_CHAN_INFO_SAMP_FREQ:
>> +               if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
>> +                       val = 0;
>> +               else
>> +                       val = 1;
>> +               st->filter = ad778x_filter[val];
>> +               gpiod_set_value(st->filter_gpio, val);
>> +       break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>>                                      unsigned int raw_sample)
>>  {
>> @@ -126,10 +187,8 @@ static int ad7780_postprocess_sample(struct
>> ad_sigma_delta *sigma_delta,
>>                 return -EIO;
>>
>>         if (chip_info->is_ad778x) {
>> -               if (raw_sample & AD7780_GAIN)
>> -                       st->gain = 1;
>> -               else
>> -                       st->gain = 128;
>> +               st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
>> +               st->filter = ad778x_filter[raw_sample & AD7780_FILTER];
>>         }
>>
>>         return 0;
>> @@ -141,18 +200,20 @@ static const struct ad_sigma_delta_info
>> ad7780_sigma_delta_info = {
>>         .has_registers = false,
>>  };
>>
>> -#define AD7780_CHANNEL(bits, wordsize) \
>> +#define AD7170_CHANNEL(bits, wordsize) \
>>         AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
>> +#define AD7780_CHANNEL(bits, wordsize) \
>> +       AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
>>
>>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>>         [ID_AD7170] = {
>> -               .channel = AD7780_CHANNEL(12, 24),
>> +               .channel = AD7170_CHANNEL(12, 24),
>>                 .pattern = AD7170_PATTERN,
>>                 .pattern_mask = AD7170_PATTERN_MASK,
>>                 .is_ad778x = false,
>>         },
>>         [ID_AD7171] = {
>> -               .channel = AD7780_CHANNEL(16, 24),
>> +               .channel = AD7170_CHANNEL(16, 24),
>>                 .pattern = AD7170_PATTERN,
>>                 .pattern_mask = AD7170_PATTERN_MASK,
>>                 .is_ad778x = false,
>> @@ -173,6 +234,7 @@ static const struct ad7780_chip_info
>> ad7780_chip_info_tbl[] = {
>>
>>  static const struct iio_info ad7780_info = {
>>         .read_raw = ad7780_read_raw,
>> +       .write_raw = ad7780_write_raw,
>>  };
>>
>>  static int ad7780_probe(struct spi_device *spi)
>> @@ -222,6 +284,29 @@ static int ad7780_probe(struct spi_device *spi)
>>                 goto error_disable_reg;
>>         }
>>
>> +       if (st->chip_info->is_ad778x) {
>> +               st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
>> +                                                       "gain",
>> +                                                       GPIOD_OUT_HIGH);
>> +               if (IS_ERR(st->gain_gpio)) {
>> +                       ret = PTR_ERR(st->gain_gpio);
>> +                       dev_err(&spi->dev, "Failed to request gain GPIO:
>> %d\n",
>> +                               ret);
>> +                       goto error_disable_reg;
>> +               }
>> +
>> +               st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
>> +                                                         "filter",
>> +                                                         GPIOD_OUT_HIGH)
>> ;
>> +               if (IS_ERR(st->filter_gpio)) {
>> +                       ret = PTR_ERR(st->filter_gpio);
>> +                       dev_err(&spi->dev,
>> +                               "Failed to request filter GPIO: %d\n",
>> +                               ret);
>> +                       goto error_disable_reg;
>> +               }
>> +       }
>> +
>>         ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>>         if (ret)
>>                 goto error_disable_reg;
>> diff --git a/include/linux/iio/adc/ad_sigma_delta.h
>> b/include/linux/iio/adc/ad_sigma_delta.h
>> index 7e84351fa2c0..c01da869de83 100644
>> --- a/include/linux/iio/adc/ad_sigma_delta.h
>> +++ b/include/linux/iio/adc/ad_sigma_delta.h
>> @@ -176,6 +176,11 @@ int ad_sd_validate_trigger(struct iio_dev
>> *indio_dev, struct iio_trigger *trig);
>>         __AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
>>                 _storagebits, _shift, NULL, IIO_VOLTAGE, 0)
>>
>> +#define AD_SD_CHANNEL_GAIN_FILTER(_si, _channel, _address, _bits, \
>> +       _storagebits, _shift) \
>> +       __AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
>> +               _storagebits, _shift, NULL, IIO_VOLTAGE,
>> BIT(IIO_CHAN_INFO_RAW))
>> +
>
>Do you need to define a new macro?

Oh yeah, that macro is useless. I'll remove this block. That was
definitely an oversight. We thought we had to create a new macro for
adding support for gain and filter GPIOs (which this macro definitely
doesn't, as it is identical to the default one) on the driver's channel,
but reading other drivers it seems you don't actually need to? Is this
right?
>
>>  #define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
>>         __AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
>>                 _storagebits, _shift, NULL, IIO_TEMP, \
>> --
>> 2.20.1
>>
