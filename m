Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547A4C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266A2217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ua6OseXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1Hi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:38:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40574 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:38:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so13823091oth.7;
        Sun, 27 Jan 2019 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Errk/noVidFq0T/VUNKHB0y3+X5FT0TjGA7Gu69Qw3c=;
        b=ua6OseXp2E1gpnUBmrj2U4P1gk2O2scsk1LkfdI4pB63lpdLJh8LaspLtGb+nhiNUS
         oaEjaC7Huwdh6iGl0HqcJASumvMDkIuV+XFyiSDD42cK/NsEZEIsqKo7B+/HwoVL9IoR
         mUjmJEUrEdhBwTtdc/wwFnXC7QEz5Q4572zK3ztJcnNRcf/OfKvZbE0bHJ+QWqK//e/a
         rudbfcJRlTTWf1c+ceta3wd0TTutmSZE82dnO/JJu3gjzd8+FZb/bKVwy1p7rVTSB70G
         YGdmKquqbF3+/hC84jvZBYpkjoor+vUqXCHPdtXud4t9MpzCgwDPbjwtop6h4KCdnqR/
         XzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Errk/noVidFq0T/VUNKHB0y3+X5FT0TjGA7Gu69Qw3c=;
        b=TSB0CM5RSPGxFb4M4NJh40Ml3e8CKpyL44XJLX7tLQyy9826cGinHZJrGPSIwJFvAC
         3lVBHpBqqw9lYqcB45NDaG7au43T+BHGtSSMPGsrq2K3YdPQHS+qBI+g8p/Ttq6ZLHQI
         ME8CQv0OMFUu5pZR8zawnNqI/FRmEvaoXQmSD/7bPvVVKna7494B8dMRZbVurC01uNQE
         Mq8el/+HzqolHG9k9YdyCBpApqi4J4zmh+uQyVu6vswOID/3cf5Gr43mPJaU443aJOKI
         pqvgcwO/rX9F8xIdvBvB4l6ita0PzHDNUe8InIffK+FbiWnCLK15W/VKJfcM0AiqAEKw
         Ep5Q==
X-Gm-Message-State: AJcUukdAW0KnmTSQgTasqZV7wE8PJ44jOVY/xcckEabaHH5Poo5Wp+Ah
        hNKqTIp8ndV7K5L/h5EwEE8zCnkx9xqA0cbA+x0=
X-Google-Smtp-Source: ALg8bN7fLl2R4HKWDSDgXh7AE4n9FM+F8wewjwPL3EUK4WyX4U7x0sL8u0XGOEixcSgeDeTe3QY3bBUvM5GbJTZriy4=
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr15969872otf.66.1548661105583;
 Sun, 27 Jan 2019 23:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20190125100451.15011-1-ricardo@ribalda.com> <20190126182114.15ac673c@archlinux>
In-Reply-To: <20190126182114.15ac673c@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 28 Jan 2019 09:38:13 +0200
Message-ID: <CA+U=DsqX-FOYYdS5NGrqfVySsf4NnnDKYxN8hXO6P_3OgUmiWQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7476: Add support for ADS786X ADCs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 8:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 25 Jan 2019 11:04:51 +0100
> Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:
>
> > Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> > ADC.
> >

I don't want this reply be offensive or anything.
But since I've seen this precedence, I do have to ask if these driver
changes were tested on at least one of the TI chips/eval-boards.

Ideally, before adding new drivers it would be nice to make sure that
they were run on actual HW.
Good code-review can get us only so far.

We could ask someone who has any of these chips to test.
Or maybe some eval boards from TI could be obtained to test these changes.

Overall changes seem good [I haven't taken a close look], but HW
testing is king.

Thanks
Alex

> > Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > ---
> > v2: I have missnamed the devices
> >  drivers/iio/adc/Kconfig  |  3 ++-
> >  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index f9354e5ee65c..d86900fc2634 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -64,7 +64,8 @@ config AD7476
> >       help
> >         Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> >         AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> > -       AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> > +       AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> > +       to digital converters (ADC).
>
> As commented in the earlier thread (after you sent this!), please make sure
> the help text makes it clear that these aren't all Analog devices parts.
>
> Likely to cause confusion otherwise.
>
> Good to see you didn't spin another driver but instead tracked down that
> this one would work well!
>
> Thanks,
>
> Jonathan
>
> >
> >         To compile this driver as a module, choose M here: the
> >         module will be called ad7476.
> > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > index 0549686b9ef8..76747488044b 100644
> > --- a/drivers/iio/adc/ad7476.c
> > +++ b/drivers/iio/adc/ad7476.c
> > @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
> >       ID_ADC081S,
> >       ID_ADC101S,
> >       ID_ADC121S,
> > +     ID_ADS7866,
> > +     ID_ADS7867,
> > +     ID_ADS7868,
> >  };
> >
> >  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> > @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> >  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> >               BIT(IIO_CHAN_INFO_RAW))
> >  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> > +             BIT(IIO_CHAN_INFO_RAW))
> >
> >  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> >       [ID_AD7091R] = {
> > @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> >               .channel[0] = ADC081S_CHAN(12),
> >               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> >       },
> > +     [ID_ADS7866] = {
> > +             .channel[0] = ADS786X_CHAN(12),
> > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > +     },
> > +     [ID_ADS7867] = {
> > +             .channel[0] = ADS786X_CHAN(10),
> > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > +     },
> > +     [ID_ADS7868] = {
> > +             .channel[0] = ADS786X_CHAN(8),
> > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > +     },
> >  };
> >
> >  static const struct iio_info ad7476_info = {
> > @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
> >       {"adc081s", ID_ADC081S},
> >       {"adc101s", ID_ADC101S},
> >       {"adc121s", ID_ADC121S},
> > +     {"ads7866", ID_ADS7866},
> > +     {"ads7867", ID_ADS7867},
> > +     {"ads7868", ID_ADS7868},
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7476_id);
>
