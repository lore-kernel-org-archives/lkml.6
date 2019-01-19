Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9E1C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6B2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547914292;
	bh=beoyD2np1LOeoWzjbEJfcR0pDjb6maenTOC3uimLMmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K2lHEKkldV/tU/vNVah9oXR5nwFQg1X+simZ1Z4idF9w4NEva/urSdPYvvFUO6hOR
	 rDY3PcKOTXx7hnPpk26YH451RB/EBw9hUItjJaRGbP8rhFuBh86+r2jrRUjCCMNpYs
	 Boe6LAgpvqQF/1f4LZHd7oZGqAWlCmVpXVL2b1Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfASQLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbfASQLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:11:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05437205C9;
        Sat, 19 Jan 2019 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547914288;
        bh=beoyD2np1LOeoWzjbEJfcR0pDjb6maenTOC3uimLMmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o6TMy4mkSvYZ4GtVACd8+yEY5rq6nDxmdSOveFl26kF16/f3n503Rm1+c3NF0P7v3
         vfttUjA5szUmGXJMx6p+AgiBVpRmki+jM3sy64MHbRW9jBmiTFNpTSqzmhRy0I28qH
         zufmbyH1Sh1FiJ0m9dIof82zLxBWV8RaXIog9mPo=
Date:   Sat, 19 Jan 2019 16:11:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>,
        StefanSerban.Popa@analog.com, alexandru.Ardelean@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, Michael.Hennerich@analog.com,
        giuliano.belinassi@gmail.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] staging: iio: ad7780: Add gain & filter gpio
 support
Message-ID: <20190119161122.141b0a75@archlinux>
In-Reply-To: <20190118201820.mlwxeso2odpecdsf@renatolg>
References: <cover.1543428366.git.giuliano.belinassi@usp.br>
        <231cbc909b892a0ebe172460d34e9eeb9cfa3003.1543428366.git.giuliano.belinassi@usp.br>
        <1543490289.11186.22.camel@analog.com>
        <CAEFO=4AQe0B0inmE=w2T+xaFkKgPwnHLP7XkT30TjFV_AEKGbg@mail.gmail.com>
        <20181201172341.4c353eae@archlinux>
        <20190118201820.mlwxeso2odpecdsf@renatolg>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 18:19:40 -0200
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Hi,
> 
> Sorry for the (extremely) late reply.
> 
> Comments inline.
> 
> Renato
> 
> On 12/01, Jonathan Cameron wrote:
> >On Thu, 29 Nov 2018 11:02:46 -0200
> >Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br> wrote:
> >  
> >> Hi  
> >
> >A few follow ups from me having read the result in patch 2.
> >
> >Jonathan  
> >>
> >> On Thu, Nov 29, 2018 at 9:18 AM Popa, Stefan Serban
> >> <StefanSerban.Popa@analog.com> wrote:  
> >> >
> >> > On Mi, 2018-11-28 at 16:15 -0200, Giuliano Belinassi wrote:  
> >> > > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> >> > > pin. This commit adds suppport for the 'gain' and 'filter' pin.
> >> > >
> >> > > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> >> > > ---
> >> > > Changes in v2:
> >> > >     - Now this patch is part of the patchset that aims to remove ad7780
> >> > > out of staging. https://marc.info/?l=linux-iio&m=154282349808890&w=2
> >> > >     - Also, now it reads voltage and filter values from the userspace
> >> > > instead of gpio pin states.  
> >> >
> >> > Hello,
> >> > Please see bellow.
> >> >  
> >> > >
> >> > >  drivers/staging/iio/adc/ad7780.c       | 78 ++++++++++++++++++++++++--
> >> > >  include/linux/iio/adc/ad_sigma_delta.h |  5 ++
> >> > >  2 files changed, 79 insertions(+), 4 deletions(-)
> >> > >
> >> > > diff --git a/drivers/staging/iio/adc/ad7780.c
> >> > > b/drivers/staging/iio/adc/ad7780.c
> >> > > index c4a85789c2db..05979a79fda3 100644
> >> > > --- a/drivers/staging/iio/adc/ad7780.c
> >> > > +++ b/drivers/staging/iio/adc/ad7780.c
> >> > > @@ -39,6 +39,12 @@
> >> > >  #define AD7170_PATTERN               (AD7780_PAT0 | AD7170_PAT2)
> >> > >  #define AD7170_PATTERN_MASK  (AD7780_PAT0 | AD7780_PAT1 |
> >> > > AD7170_PAT2)
> >> > >
> >> > > +#define AD7780_GAIN_GPIO     0
> >> > > +#define AD7780_FILTER_GPIO   1
> >> > > +
> >> > > +#define AD7780_GAIN_MIDPOINT 64
> >> > > +#define AD7780_FILTER_MIDPOINT       13350
> >> > > +
> >> > >  struct ad7780_chip_info {
> >> > >       struct iio_chan_spec    channel;
> >> > >       unsigned int            pattern_mask;
> >> > > @@ -50,6 +56,8 @@ struct ad7780_state {
> >> > >       const struct ad7780_chip_info   *chip_info;
> >> > >       struct regulator                *reg;
> >> > >       struct gpio_desc                *powerdown_gpio;
> >> > > +     struct gpio_desc                *gain_gpio;
> >> > > +     struct gpio_desc                *filter_gpio;
> >> > >       unsigned int    gain;
> >> > >
> >> > >       struct ad_sigma_delta sd;
> >> > > @@ -115,18 +123,65 @@ static int ad7780_read_raw(struct iio_dev
> >> > > *indio_dev,
> >> > >       return -EINVAL;
> >> > >  }
> >> > >
> >> > > +static int ad7780_write_raw(struct iio_dev *indio_dev,
> >> > > +                         struct iio_chan_spec const *chan,
> >> > > +                         int val,
> >> > > +                         int val2,
> >> > > +                         long m)
> >> > > +{
> >> > > +     struct ad7780_state *st = iio_priv(indio_dev);
> >> > > +     const struct ad7780_chip_info *chip_info = st->chip_info;
> >> > > +     int uvref, gain;
> >> > > +     unsigned int full_scale;
> >> > > +
> >> > > +     if (!chip_info->is_ad778x)
> >> > > +             return 0;
> >> > > +
> >> > > +     switch (m) {
> >> > > +     case IIO_CHAN_INFO_SCALE:
> >> > > +             if (val != 0)
> >> > > +                     return -EINVAL;
> >> > > +
> >> > > +             uvref = regulator_get_voltage(st->reg);  
> >> >
> >> > regulator_get_voltage() has already been called in the probe function and
> >> > the result is stored in st->int_vref_mv.  
> >>
> >> This was removed in commit  9eae69ddbc4717a0bd702eddac76c7848773bf71
> >> because the value was not being updated. But I agree if the vref
> >> voltage is not going to change at all after the initialization, then
> >> this value should be kept in memory.  
> 
> Why wouldn't the vref voltage not change after initialization? Shouldn't
> we keep reading and updating this in read_raw?

It may well change so bbest to check it.

> >>  
> >> > My suggestion would be to use a local vref variable declared as unsigned
> >> > int. It is my fault that I haven't explained correctly in the previous
> >> > email, but you need to multiply vref_mv with 1000000LL in order to get the
> >> > right precision: vref = st->int_vref_mv * 1000000LL. Afterwards you will be
> >> > able to perform the divisions.  
> 
> Shouldn't we read vref inside read_raw in order to get up-to-date
> readings on voltage values? Or should we keep reading from a cached
> value?

I agree.  We don't want to do it in a fast path as it 'probably' won't
change after the initial boot is done without some deliberate intervention
but fine to read it whenever we are dealing with anything other than
reading the ADC value (so reading the scale or similar).


> >>
> >> Thanks for this info! :-)
> >> Shouldn't we store this in uV (microVolts)? This will yield a more
> >> accurate result after the multiplication.
> >>  
> >> > > +
> >> > > +             if (uvref < 0)
> >> > > +                     return uvref;
> >> > > +
> >> > > +             full_scale = 1 << (chip_info->channel.scan_type.realbits
> >> > > - 1);
> >> > > +             gain = DIV_ROUND_CLOSEST(uvref, full_scale);
> >> > > +             gain = DIV_ROUND_CLOSEST(gain, val2);
> >> > > +
> >> > > +             gpiod_set_value(st->gain_gpio, gain <
> >> > > AD7780_GAIN_MIDPOINT ? 0 : 1);  
> >> >
> >> > Once the gain is set, you can store it in st->gain variable.  
> >>
> >> Yes, we forgot it.
> >>  
> >> >  
> >> > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> >> > > +             if (val2 != 0)
> >> > > +                     return -EINVAL;  
> >comment I raised in patch 2 about the odd preciseness of insisting
> >no decimal places, but matching any value based on a threshold on the
> >whole number part.  
> 
> I see. I thought the filter input was in mHz. So should I compare
> 1000*val with AD7780_FILTER_MIDPOINT?

Not totally sure what I was going on about here..
I think I was just raising that you should use 1000*val + val2/1000 to do
the rounding with the decimal part taken into account.

> >
> >I'd also expect to see read_raw support for this.
> >  
> >> > > +
> >> > > +             gpiod_set_value(st->filter_gpio, val <
> >> > > AD7780_FILTER_MIDPOINT ? 0 : 1);  
> >> >
> >> > This is probably fine, although I am not a big fan of the ternary operator.
> >> > A simple if else statement would do. However, I don't feel strongly about
> >> > it, so feel free to disagree.
> >> >  
> >> > > +     break;
> >> > > +     }
> >> > > +
> >> > > +     return 0;
> >> > > +}
> >> > > +
> >> > >  static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> >> > >                                    unsigned int raw_sample)
> >> > >  {
> >> > >       struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
> >> > >       const struct ad7780_chip_info *chip_info = st->chip_info;
> >> > > +     int val;
> >> > >
> >> > >       if ((raw_sample & AD7780_ERR) ||
> >> > >           ((raw_sample & chip_info->pattern_mask) != chip_info-  
> >> > > >pattern))  
> >> > >               return -EIO;
> >> > >
> >> > >       if (chip_info->is_ad778x) {
> >> > > -             if (raw_sample & AD7780_GAIN)
> >> > > +             val = raw_sample & AD7780_GAIN;
> >> > > +
> >> > > +             if (val != gpiod_get_value(st->gain_gpio))
> >> > > +                     return -EIO;  
> >> >
> >> > It is not obvious to me what is the point of this check. Maybe you can add
> >> > a comment?  
> 
> If I'm not mistaken, we had agreed earlier to remove this altogether, as
> having a redundancy check could potentially slow down reading.

Works for me.

> >>
> >> It seems to be a redundancy check. It is getting the 32-bits
> >> raw_output, getting the bit that represents the GAIN value and
> >> checking if the pin is set accordingly (see Figure 22 of datasheet,
> >> page 13). Is this correct? If yes we add a comment explaining this.
> >>  
> >> >  
...

