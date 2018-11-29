Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80694C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F32081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="d9IHjwih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251F32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeK3AIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:08:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44035 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeK3AIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:08:17 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so1494027oig.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 05:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TRE0XbA+esqrNr022qj/Xn9ZNvg2QjrOaEqJxkNLvM=;
        b=d9IHjwihnNrxX9SHNpaqm20H47Gp5L5wFqc7rXGvqmGWpllu8w+thz0ntZhUY0FN8C
         Sf6auzc6zw5jPqbPNEO0vt6mvcfRMLrvvIlNF9YLe59Qbl2Gu0wE4+jS55ybsj0CtUwG
         BvPXqcgZ8fgmnMgRxqM6XOpjraP4L1uoSiRZSqL71npT5X08T2t4y3pxPC/CrV/ddPEj
         rp6K9j/q2igWvSLNM5u/eBdUxOg9s2ht3WDgM3M+Zitx0rklgRlRbhWAopRx4/G/L/+/
         v2WVI4lR7NdHZ3fF5fyRp/vxksH+FSN+28eJcgnA9VKEAiW5WUMz97gPGvu/6YoK1okh
         99AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TRE0XbA+esqrNr022qj/Xn9ZNvg2QjrOaEqJxkNLvM=;
        b=nMqUXE6iNSzh+YueFVi0JhNHtzo5V9T3T1hLHSot8KfMOXuahclBBPx1Kxbh3VJM7g
         kOHYGRVIixw8XAS53hBHD+g9q/+uUIgKfV88c9s1LeoflPJz3eKHDx7wqun95So3o5zf
         xap+pIosq/Lm/JdZqwswiB+pZyVhfh2JjyXVexDw/8KCBf7Kes5E8GaQgr2LPtjdRBIM
         vJiESkKXl/k6kP4zAsu6fPoIyy9y+H+31GO5PYRf6GkuXfz2/m1YuKqrWPrqR6r730dU
         OoDipT4+etA9D90U5By8orYJG4g2Pqfiv3l2PuG9o40MacApudCpgoRSI7AOkul52WO1
         JtRA==
X-Gm-Message-State: AA+aEWaiQkenYi49R7Bdy1IuZlrAarJP821h9TiSJK7+h/TGyDyos407
        x+auPM1geqx8WyGY8oBu8t9OagdX5F3KmW+H9y/KFA==
X-Google-Smtp-Source: AFSGD/U2eOxh/ZCLNABCLLFCi9/+cMXVJwoDxaWlTcAbNcFIwoe9Mu4go/YGdE+/TPivAHDtkEhgCX7Uqo7twXSN9bk=
X-Received: by 2002:aca:32d7:: with SMTP id y206mr735529oiy.151.1543496578355;
 Thu, 29 Nov 2018 05:02:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543428366.git.giuliano.belinassi@usp.br>
 <231cbc909b892a0ebe172460d34e9eeb9cfa3003.1543428366.git.giuliano.belinassi@usp.br>
 <1543490289.11186.22.camel@analog.com>
In-Reply-To: <1543490289.11186.22.camel@analog.com>
From:   Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Date:   Thu, 29 Nov 2018 11:02:46 -0200
Message-ID: <CAEFO=4AQe0B0inmE=w2T+xaFkKgPwnHLP7XkT30TjFV_AEKGbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio: ad7780: Add gain & filter gpio support
To:     StefanSerban.Popa@analog.com
Cc:     alexandru.Ardelean@analog.com, lars@metafoo.de, knaack.h@gmx.de,
        jic23@kernel.org, Michael.Hennerich@analog.com,
        Renato Geh <renatogeh@gmail.com>, giuliano.belinassi@gmail.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Nov 29, 2018 at 9:18 AM Popa, Stefan Serban
<StefanSerban.Popa@analog.com> wrote:
>
> On Mi, 2018-11-28 at 16:15 -0200, Giuliano Belinassi wrote:
> > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> > pin. This commit adds suppport for the 'gain' and 'filter' pin.
> >
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > ---
> > Changes in v2:
> >     - Now this patch is part of the patchset that aims to remove ad7780
> > out of staging. https://marc.info/?l=linux-iio&m=154282349808890&w=2
> >     - Also, now it reads voltage and filter values from the userspace
> > instead of gpio pin states.
>
> Hello,
> Please see bellow.
>
> >
> >  drivers/staging/iio/adc/ad7780.c       | 78 ++++++++++++++++++++++++--
> >  include/linux/iio/adc/ad_sigma_delta.h |  5 ++
> >  2 files changed, 79 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index c4a85789c2db..05979a79fda3 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -39,6 +39,12 @@
> >  #define AD7170_PATTERN               (AD7780_PAT0 | AD7170_PAT2)
> >  #define AD7170_PATTERN_MASK  (AD7780_PAT0 | AD7780_PAT1 |
> > AD7170_PAT2)
> >
> > +#define AD7780_GAIN_GPIO     0
> > +#define AD7780_FILTER_GPIO   1
> > +
> > +#define AD7780_GAIN_MIDPOINT 64
> > +#define AD7780_FILTER_MIDPOINT       13350
> > +
> >  struct ad7780_chip_info {
> >       struct iio_chan_spec    channel;
> >       unsigned int            pattern_mask;
> > @@ -50,6 +56,8 @@ struct ad7780_state {
> >       const struct ad7780_chip_info   *chip_info;
> >       struct regulator                *reg;
> >       struct gpio_desc                *powerdown_gpio;
> > +     struct gpio_desc                *gain_gpio;
> > +     struct gpio_desc                *filter_gpio;
> >       unsigned int    gain;
> >
> >       struct ad_sigma_delta sd;
> > @@ -115,18 +123,65 @@ static int ad7780_read_raw(struct iio_dev
> > *indio_dev,
> >       return -EINVAL;
> >  }
> >
> > +static int ad7780_write_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int val,
> > +                         int val2,
> > +                         long m)
> > +{
> > +     struct ad7780_state *st = iio_priv(indio_dev);
> > +     const struct ad7780_chip_info *chip_info = st->chip_info;
> > +     int uvref, gain;
> > +     unsigned int full_scale;
> > +
> > +     if (!chip_info->is_ad778x)
> > +             return 0;
> > +
> > +     switch (m) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             if (val != 0)
> > +                     return -EINVAL;
> > +
> > +             uvref = regulator_get_voltage(st->reg);
>
> regulator_get_voltage() has already been called in the probe function and
> the result is stored in st->int_vref_mv.

This was removed in commit  9eae69ddbc4717a0bd702eddac76c7848773bf71
because the value was not being updated. But I agree if the vref
voltage is not going to change at all after the initialization, then
this value should be kept in memory.

> My suggestion would be to use a local vref variable declared as unsigned
> int. It is my fault that I haven't explained correctly in the previous
> email, but you need to multiply vref_mv with 1000000LL in order to get the
> right precision: vref = st->int_vref_mv * 1000000LL. Afterwards you will be
> able to perform the divisions.

Thanks for this info! :-)
Shouldn't we store this in uV (microVolts)? This will yield a more
accurate result after the multiplication.

> > +
> > +             if (uvref < 0)
> > +                     return uvref;
> > +
> > +             full_scale = 1 << (chip_info->channel.scan_type.realbits
> > - 1);
> > +             gain = DIV_ROUND_CLOSEST(uvref, full_scale);
> > +             gain = DIV_ROUND_CLOSEST(gain, val2);
> > +
> > +             gpiod_set_value(st->gain_gpio, gain <
> > AD7780_GAIN_MIDPOINT ? 0 : 1);
>
> Once the gain is set, you can store it in st->gain variable.

Yes, we forgot it.

>
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             if (val2 != 0)
> > +                     return -EINVAL;
> > +
> > +             gpiod_set_value(st->filter_gpio, val <
> > AD7780_FILTER_MIDPOINT ? 0 : 1);
>
> This is probably fine, although I am not a big fan of the ternary operator.
> A simple if else statement would do. However, I don't feel strongly about
> it, so feel free to disagree.
>
> > +     break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> >                                    unsigned int raw_sample)
> >  {
> >       struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
> >       const struct ad7780_chip_info *chip_info = st->chip_info;
> > +     int val;
> >
> >       if ((raw_sample & AD7780_ERR) ||
> >           ((raw_sample & chip_info->pattern_mask) != chip_info-
> > >pattern))
> >               return -EIO;
> >
> >       if (chip_info->is_ad778x) {
> > -             if (raw_sample & AD7780_GAIN)
> > +             val = raw_sample & AD7780_GAIN;
> > +
> > +             if (val != gpiod_get_value(st->gain_gpio))
> > +                     return -EIO;
>
> It is not obvious to me what is the point of this check. Maybe you can add
> a comment?

It seems to be a redundancy check. It is getting the 32-bits
raw_output, getting the bit that represents the GAIN value and
checking if the pin is set accordingly (see Figure 22 of datasheet,
page 13). Is this correct? If yes we add a comment explaining this.

>
> > +
> > +             if (val)
> >                       st->gain = 1;
> >               else
> >                       st->gain = 128;
>
> Do we still need this? I am not convinced.
No, I don't think so. Thanks for pointing this out :-)

>
> > @@ -141,18 +196,20 @@ static const struct ad_sigma_delta_info
> > ad7780_sigma_delta_info = {
> >       .has_registers = false,
> >  };
> >
> > -#define AD7780_CHANNEL(bits, wordsize) \
> > +#define AD7170_CHANNEL(bits, wordsize) \
> >       AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
> > +#define AD7780_CHANNEL(bits, wordsize) \
> > +     AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
> >
> >  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> >       [ID_AD7170] = {
> > -             .channel = AD7780_CHANNEL(12, 24),
> > +             .channel = AD7170_CHANNEL(12, 24),
> >               .pattern = AD7170_PATTERN,
> >               .pattern_mask = AD7170_PATTERN_MASK,
> >               .is_ad778x = false,
> >       },
> >       [ID_AD7171] = {
> > -             .channel = AD7780_CHANNEL(16, 24),
> > +             .channel = AD7170_CHANNEL(16, 24),
> >               .pattern = AD7170_PATTERN,
> >               .pattern_mask = AD7170_PATTERN_MASK,
> >               .is_ad778x = false,
> > @@ -173,6 +230,7 @@ static const struct ad7780_chip_info
> > ad7780_chip_info_tbl[] = {
> >
> >  static const struct iio_info ad7780_info = {
> >       .read_raw = ad7780_read_raw,
> > +     .write_raw = ad7780_write_raw,
> >  };
> >
> >  static int ad7780_probe(struct spi_device *spi)
> > @@ -222,6 +280,18 @@ static int ad7780_probe(struct spi_device *spi)
> >               goto error_disable_reg;
> >       }
> >
> > +     if (st->chip_info->is_ad778x) {
> > +             st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
> > +                                                     "gain",
> > +                                                     GPIOD_OUT_HIGH);
> > +             if (IS_ERR(st->gain_gpio)) {
>
> if the GPIO is optional, then we should continue in case of -ENODEV.
>
> Shouldn't we have a devm_gpiod_get_optional() call also for filter_gpio?
>
> > +                     ret = PTR_ERR(st->gain_gpio);
> > +                     dev_err(&spi->dev, "Failed to request gain GPIO:
> > %d\n",
> > +                             ret);
> > +                     goto error_disable_reg;
> > +             }
> > +     }
> > +
> >       ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> >       if (ret)
> >               goto error_disable_reg;
> > diff --git a/include/linux/iio/adc/ad_sigma_delta.h
> > b/include/linux/iio/adc/ad_sigma_delta.h
> > index 730ead1a46df..6cadab6fd5fd 100644
> > --- a/include/linux/iio/adc/ad_sigma_delta.h
> > +++ b/include/linux/iio/adc/ad_sigma_delta.h
> > @@ -173,6 +173,11 @@ int ad_sd_validate_trigger(struct iio_dev
> > *indio_dev, struct iio_trigger *trig);
> >       __AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> >               _storagebits, _shift, NULL, IIO_VOLTAGE, 0)
> >
> > +#define AD_SD_CHANNEL_GAIN_FILTER(_si, _channel, _address, _bits, \
> > +     _storagebits, _shift) \
> > +     __AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> > +             _storagebits, _shift, NULL, IIO_VOLTAGE,
> > BIT(IIO_CHAN_INFO_RAW))
> > +
> >  #define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
> >       __AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
> >               _storagebits, _shift, NULL, IIO_TEMP, \
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/1543490289.11186.22.camel%40analog.com.
> For more options, visit https://groups.google.com/d/optout.
