Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89371C65C16
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4226B20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYPxZMOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfARUTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:19:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43487 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfARUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:19:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id z18so8772377qkj.10;
        Fri, 18 Jan 2019 12:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCTcUIA2eg9rekWKl1AkKrLwPNlRI1McPWwryVLof64=;
        b=lYPxZMOkMNCpI7rlynEnq9zTFL7CKNahGHpOn7AnjmNaavmSDkp6GqcNfVAYze5ZD7
         rZzYTYCdlGJdTW1wHvyileEUGLbvOi9eYXNF8afn9KQehyH94xiv6XqS8/8400MMIOY0
         xexl0T25KHBg1CBOB9x/FWGp3EqWRS/4bsiH/IVY/P2+uhu25recm/V/Nz0mUYyfyF7u
         2lovHT+8vDFUfObHAiYotOon6tvGpKUU2s1GToltOkZ12sFO4809XFqM4QOG20zMAMuS
         9QfiH+OHQ9eqCtfnvPJ/WaDR26yiv4VpwaMe/tdUShKNmScAh+5dHzE8weJmfUaQTL4h
         U2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCTcUIA2eg9rekWKl1AkKrLwPNlRI1McPWwryVLof64=;
        b=U/Onb3gX2luS0PmpUqsFYJ4gBrTAemfqrMPrrnRStYpmX/Zmgj31+gomTUQWw4oyoZ
         FIROfV0JFGjEe02HVFBoaOmSQnedeGAg96jJgy2yfN3Qq2bYEbWHiUrkPektxDBepZDs
         lp7DRkvHg/c366rTWiciuY8KsLQod/sdFNWU/6g7rtGOvQ5qHsDhex/XK3ReT+SbKuwJ
         SwN2VtV8LuEADFrrVx28emANV/9bigimcN2p7EnZiiDWBGGozAvEtF/g5y+1T+eOPj5o
         VYQwac6qmE7q1q28KNuR6vs8BrD7YYUTkFv/3w8cTvWHoR6Omx9KR/3zGAlvuiZR6CSV
         +a4Q==
X-Gm-Message-State: AJcUukc9S0BDH1Utviay8laHTSjySmjKQJj9x+SVOi8T0jOMDIUWp0mR
        1eFrvOD87B/NOmRT/+Mwj8w=
X-Google-Smtp-Source: ALg8bN6unSvsNlGtmqavX5b2uiM3XQ6ogirKDSV0IH+Dq4csaDYjXZOmnaG0NdfZMWJfCvqDioXi7g==
X-Received: by 2002:a37:4eca:: with SMTP id c193mr16287830qkb.37.1547842785889;
        Fri, 18 Jan 2019 12:19:45 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p8sm61581835qtk.70.2019.01.18.12.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 12:19:45 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Fri, 18 Jan 2019 18:19:40 -0200
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>,
        StefanSerban.Popa@analog.com, alexandru.Ardelean@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, Michael.Hennerich@analog.com,
        Renato Geh <renatogeh@gmail.com>, giuliano.belinassi@gmail.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <20190118201820.mlwxeso2odpecdsf@renatolg>
References: <cover.1543428366.git.giuliano.belinassi@usp.br>
 <231cbc909b892a0ebe172460d34e9eeb9cfa3003.1543428366.git.giuliano.belinassi@usp.br>
 <1543490289.11186.22.camel@analog.com>
 <CAEFO=4AQe0B0inmE=w2T+xaFkKgPwnHLP7XkT30TjFV_AEKGbg@mail.gmail.com>
 <20181201172341.4c353eae@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20181201172341.4c353eae@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the (extremely) late reply.

Comments inline.

Renato

On 12/01, Jonathan Cameron wrote:
>On Thu, 29 Nov 2018 11:02:46 -0200
>Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br> wrote:
>
>> Hi
>
>A few follow ups from me having read the result in patch 2.
>
>Jonathan
>>
>> On Thu, Nov 29, 2018 at 9:18 AM Popa, Stefan Serban
>> <StefanSerban.Popa@analog.com> wrote:
>> >
>> > On Mi, 2018-11-28 at 16:15 -0200, Giuliano Belinassi wrote:
>> > > Previously, the AD7780 driver only supported gpio for the 'powerdown'
>> > > pin. This commit adds suppport for the 'gain' and 'filter' pin.
>> > >
>> > > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
>> > > ---
>> > > Changes in v2:
>> > >     - Now this patch is part of the patchset that aims to remove ad7780
>> > > out of staging. https://marc.info/?l=linux-iio&m=154282349808890&w=2
>> > >     - Also, now it reads voltage and filter values from the userspace
>> > > instead of gpio pin states.
>> >
>> > Hello,
>> > Please see bellow.
>> >
>> > >
>> > >  drivers/staging/iio/adc/ad7780.c       | 78 ++++++++++++++++++++++++--
>> > >  include/linux/iio/adc/ad_sigma_delta.h |  5 ++
>> > >  2 files changed, 79 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/drivers/staging/iio/adc/ad7780.c
>> > > b/drivers/staging/iio/adc/ad7780.c
>> > > index c4a85789c2db..05979a79fda3 100644
>> > > --- a/drivers/staging/iio/adc/ad7780.c
>> > > +++ b/drivers/staging/iio/adc/ad7780.c
>> > > @@ -39,6 +39,12 @@
>> > >  #define AD7170_PATTERN               (AD7780_PAT0 | AD7170_PAT2)
>> > >  #define AD7170_PATTERN_MASK  (AD7780_PAT0 | AD7780_PAT1 |
>> > > AD7170_PAT2)
>> > >
>> > > +#define AD7780_GAIN_GPIO     0
>> > > +#define AD7780_FILTER_GPIO   1
>> > > +
>> > > +#define AD7780_GAIN_MIDPOINT 64
>> > > +#define AD7780_FILTER_MIDPOINT       13350
>> > > +
>> > >  struct ad7780_chip_info {
>> > >       struct iio_chan_spec    channel;
>> > >       unsigned int            pattern_mask;
>> > > @@ -50,6 +56,8 @@ struct ad7780_state {
>> > >       const struct ad7780_chip_info   *chip_info;
>> > >       struct regulator                *reg;
>> > >       struct gpio_desc                *powerdown_gpio;
>> > > +     struct gpio_desc                *gain_gpio;
>> > > +     struct gpio_desc                *filter_gpio;
>> > >       unsigned int    gain;
>> > >
>> > >       struct ad_sigma_delta sd;
>> > > @@ -115,18 +123,65 @@ static int ad7780_read_raw(struct iio_dev
>> > > *indio_dev,
>> > >       return -EINVAL;
>> > >  }
>> > >
>> > > +static int ad7780_write_raw(struct iio_dev *indio_dev,
>> > > +                         struct iio_chan_spec const *chan,
>> > > +                         int val,
>> > > +                         int val2,
>> > > +                         long m)
>> > > +{
>> > > +     struct ad7780_state *st = iio_priv(indio_dev);
>> > > +     const struct ad7780_chip_info *chip_info = st->chip_info;
>> > > +     int uvref, gain;
>> > > +     unsigned int full_scale;
>> > > +
>> > > +     if (!chip_info->is_ad778x)
>> > > +             return 0;
>> > > +
>> > > +     switch (m) {
>> > > +     case IIO_CHAN_INFO_SCALE:
>> > > +             if (val != 0)
>> > > +                     return -EINVAL;
>> > > +
>> > > +             uvref = regulator_get_voltage(st->reg);
>> >
>> > regulator_get_voltage() has already been called in the probe function and
>> > the result is stored in st->int_vref_mv.
>>
>> This was removed in commit  9eae69ddbc4717a0bd702eddac76c7848773bf71
>> because the value was not being updated. But I agree if the vref
>> voltage is not going to change at all after the initialization, then
>> this value should be kept in memory.

Why wouldn't the vref voltage not change after initialization? Shouldn't
we keep reading and updating this in read_raw?
>>
>> > My suggestion would be to use a local vref variable declared as unsigned
>> > int. It is my fault that I haven't explained correctly in the previous
>> > email, but you need to multiply vref_mv with 1000000LL in order to get the
>> > right precision: vref = st->int_vref_mv * 1000000LL. Afterwards you will be
>> > able to perform the divisions.

Shouldn't we read vref inside read_raw in order to get up-to-date
readings on voltage values? Or should we keep reading from a cached
value?
>>
>> Thanks for this info! :-)
>> Shouldn't we store this in uV (microVolts)? This will yield a more
>> accurate result after the multiplication.
>>
>> > > +
>> > > +             if (uvref < 0)
>> > > +                     return uvref;
>> > > +
>> > > +             full_scale = 1 << (chip_info->channel.scan_type.realbits
>> > > - 1);
>> > > +             gain = DIV_ROUND_CLOSEST(uvref, full_scale);
>> > > +             gain = DIV_ROUND_CLOSEST(gain, val2);
>> > > +
>> > > +             gpiod_set_value(st->gain_gpio, gain <
>> > > AD7780_GAIN_MIDPOINT ? 0 : 1);
>> >
>> > Once the gain is set, you can store it in st->gain variable.
>>
>> Yes, we forgot it.
>>
>> >
>> > > +     case IIO_CHAN_INFO_SAMP_FREQ:
>> > > +             if (val2 != 0)
>> > > +                     return -EINVAL;
>comment I raised in patch 2 about the odd preciseness of insisting
>no decimal places, but matching any value based on a threshold on the
>whole number part.

I see. I thought the filter input was in mHz. So should I compare
1000*val with AD7780_FILTER_MIDPOINT?
>
>I'd also expect to see read_raw support for this.
>
>> > > +
>> > > +             gpiod_set_value(st->filter_gpio, val <
>> > > AD7780_FILTER_MIDPOINT ? 0 : 1);
>> >
>> > This is probably fine, although I am not a big fan of the ternary operator.
>> > A simple if else statement would do. However, I don't feel strongly about
>> > it, so feel free to disagree.
>> >
>> > > +     break;
>> > > +     }
>> > > +
>> > > +     return 0;
>> > > +}
>> > > +
>> > >  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>> > >                                    unsigned int raw_sample)
>> > >  {
>> > >       struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
>> > >       const struct ad7780_chip_info *chip_info = st->chip_info;
>> > > +     int val;
>> > >
>> > >       if ((raw_sample & AD7780_ERR) ||
>> > >           ((raw_sample & chip_info->pattern_mask) != chip_info-
>> > > >pattern))
>> > >               return -EIO;
>> > >
>> > >       if (chip_info->is_ad778x) {
>> > > -             if (raw_sample & AD7780_GAIN)
>> > > +             val = raw_sample & AD7780_GAIN;
>> > > +
>> > > +             if (val != gpiod_get_value(st->gain_gpio))
>> > > +                     return -EIO;
>> >
>> > It is not obvious to me what is the point of this check. Maybe you can add
>> > a comment?

If I'm not mistaken, we had agreed earlier to remove this altogether, as
having a redundancy check could potentially slow down reading.
>>
>> It seems to be a redundancy check. It is getting the 32-bits
>> raw_output, getting the bit that represents the GAIN value and
>> checking if the pin is set accordingly (see Figure 22 of datasheet,
>> page 13). Is this correct? If yes we add a comment explaining this.
>>
>> >
>> > > +
>> > > +             if (val)
>> > >                       st->gain = 1;
>> > >               else
>> > >                       st->gain = 128;
>> >
>> > Do we still need this? I am not convinced.
>> No, I don't think so. Thanks for pointing this out :-)
>>
>> >
>> > > @@ -141,18 +196,20 @@ static const struct ad_sigma_delta_info
>> > > ad7780_sigma_delta_info = {
>> > >       .has_registers = false,
>> > >  };
>> > >
>> > > -#define AD7780_CHANNEL(bits, wordsize) \
>> > > +#define AD7170_CHANNEL(bits, wordsize) \
>> > >       AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
>> > > +#define AD7780_CHANNEL(bits, wordsize) \
>> > > +     AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
>> > >
>> > >  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>> > >       [ID_AD7170] = {
>> > > -             .channel = AD7780_CHANNEL(12, 24),
>> > > +             .channel = AD7170_CHANNEL(12, 24),
>> > >               .pattern = AD7170_PATTERN,
>> > >               .pattern_mask = AD7170_PATTERN_MASK,
>> > >               .is_ad778x = false,
>> > >       },
>> > >       [ID_AD7171] = {
>> > > -             .channel = AD7780_CHANNEL(16, 24),
>> > > +             .channel = AD7170_CHANNEL(16, 24),
>> > >               .pattern = AD7170_PATTERN,
>> > >               .pattern_mask = AD7170_PATTERN_MASK,
>> > >               .is_ad778x = false,
>> > > @@ -173,6 +230,7 @@ static const struct ad7780_chip_info
>> > > ad7780_chip_info_tbl[] = {
>> > >
>> > >  static const struct iio_info ad7780_info = {
>> > >       .read_raw = ad7780_read_raw,
>> > > +     .write_raw = ad7780_write_raw,
>> > >  };
>> > >
>> > >  static int ad7780_probe(struct spi_device *spi)
>> > > @@ -222,6 +280,18 @@ static int ad7780_probe(struct spi_device *spi)
>> > >               goto error_disable_reg;
>> > >       }
>> > >
>> > > +     if (st->chip_info->is_ad778x) {
>> > > +             st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
>> > > +                                                     "gain",
>> > > +                                                     GPIOD_OUT_HIGH);
>> > > +             if (IS_ERR(st->gain_gpio)) {
>> >
>> > if the GPIO is optional, then we should continue in case of -ENODEV.
>> >
>> > Shouldn't we have a devm_gpiod_get_optional() call also for filter_gpio?
>I had to check this one...
>
> * This is equivalent to gpiod_get(), except that when no GPIO was assigned to
> * the requested function it will return NULL. This is convenient for drivers
> * that need to handle optional GPIOs.
>
>So nope, it shouldn't return -ENODEV;  unlike the clock equivalent which
>IIRC does...
>
>> >
>> > > +                     ret = PTR_ERR(st->gain_gpio);
>> > > +                     dev_err(&spi->dev, "Failed to request gain GPIO:
>> > > %d\n",
>> > > +                             ret);
>> > > +                     goto error_disable_reg;
>> > > +             }
>> > > +     }
>> > > +
>> > >       ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>> > >       if (ret)
>> > >               goto error_disable_reg;
>> > > diff --git a/include/linux/iio/adc/ad_sigma_delta.h
>> > > b/include/linux/iio/adc/ad_sigma_delta.h
>> > > index 730ead1a46df..6cadab6fd5fd 100644
>> > > --- a/include/linux/iio/adc/ad_sigma_delta.h
>> > > +++ b/include/linux/iio/adc/ad_sigma_delta.h
>> > > @@ -173,6 +173,11 @@ int ad_sd_validate_trigger(struct iio_dev
>> > > *indio_dev, struct iio_trigger *trig);
>> > >       __AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
>> > >               _storagebits, _shift, NULL, IIO_VOLTAGE, 0)
>> > >
>> > > +#define AD_SD_CHANNEL_GAIN_FILTER(_si, _channel, _address, _bits, \
>> > > +     _storagebits, _shift) \
>> > > +     __AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
>> > > +             _storagebits, _shift, NULL, IIO_VOLTAGE,
>> > > BIT(IIO_CHAN_INFO_RAW))
>> > > +
>> > >  #define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
>> > >       __AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
>> > >               _storagebits, _shift, NULL, IIO_TEMP, \
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
>> > To post to this group, send email to kernel-usp@googlegroups.com.
>> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/1543490289.11186.22.camel%40analog.com.
>> > For more options, visit https://groups.google.com/d/optout.
>
