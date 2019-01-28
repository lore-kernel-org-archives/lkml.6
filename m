Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0931EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfA1Hvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:51:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37216 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfA1Hvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:51:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so13350199ljd.4;
        Sun, 27 Jan 2019 23:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbhHZZ0d6sVDbXbyE/OR5OCU1WWVnpEG6d81tbPbvRk=;
        b=d3hLSUtn8Zn0hm+5UOdOklMnaC9wYYK8nWfcXXEDFyhqmzld6S1DtfysWDv//lbX6y
         WHNA2HT6QnSD299WOq/6jJyzAKlDlnzQHk0u8Qs0E03e3kfCP8RvSJO8Vk3ZtMSnab32
         cyKyqJIZEBqEVP3Z8KXORaqceyOHoqf4/ruxyG7V6HzmugEwBfxrNNjXff18cA2tD8UV
         wR7Lk1fJuSdfUYsB+qhBwQLBsqLyljD8pNmWOhQuvtxcYkSkPxBR09qiHqQFr9FZFBAc
         US6O1Nc0TfYhO1iucXXRfdUV2Xlv2GTsoFow/PLNomu3zmNil62CzYdchQUtagQvUSMK
         QNXQ==
X-Gm-Message-State: AJcUuken22xlu+sHW3cxZVkctkDQIAUV9UIZV2gKPKV2KwGjZe/Ho9Ct
        MqXfxAUVLeGha0b6VDWuMHnQ0O6lavwEjh/hWh9dcQ==
X-Google-Smtp-Source: ALg8bN7DI5zJQTIvDKqFnxjiFaf1xv0IAs72nFqoAPqAj6zIibLwcDURGprn5pfVCWNtWTG3OcoR6VA4syqvAqw2oOk=
X-Received: by 2002:a2e:9747:: with SMTP id f7-v6mr11160213ljj.70.1548661888515;
 Sun, 27 Jan 2019 23:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20190125100451.15011-1-ricardo@ribalda.com> <20190126182114.15ac673c@archlinux>
 <CA+U=DsqX-FOYYdS5NGrqfVySsf4NnnDKYxN8hXO6P_3OgUmiWQ@mail.gmail.com>
 <CAPybu_2pFHbwaJMQxso17My+UoCtAyVVSZBabVE4xsp0HLV7UA@mail.gmail.com> <CA+U=DsprCm6GpPSROAN9dC5De4=ivhY9m_75Kn-h=jWpw-5JfA@mail.gmail.com>
In-Reply-To: <CA+U=DsprCm6GpPSROAN9dC5De4=ivhY9m_75Kn-h=jWpw-5JfA@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Mon, 28 Jan 2019 08:51:12 +0100
Message-ID: <CAPybu_37GaRJko4K8gX64j1D_hd86yARAFD9409MVL5twc9Hmw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7476: Add support for ADS786X ADCs
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Alexandru

On Mon, Jan 28, 2019 at 8:47 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Jan 28, 2019 at 9:43 AM Ricardo Ribalda Delgado
> <ricardo@ribalda.com> wrote:
> >
> > HI Alexandru
> >
> > On Mon, Jan 28, 2019 at 8:38 AM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:
> > >
> > > On Sat, Jan 26, 2019 at 8:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > >
> > > > On Fri, 25 Jan 2019 11:04:51 +0100
> > > > Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:
> > > >
> > > > > Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> > > > > ADC.
> > > > >
> > >
> > > I don't want this reply be offensive or anything.
> > > But since I've seen this precedence, I do have to ask if these driver
> > > changes were tested on at least one of the TI chips/eval-boards.
> > >
> > > Ideally, before adding new drivers it would be nice to make sure that
> > > they were run on actual HW.
> > > Good code-review can get us only so far.
> > >
> > > We could ask someone who has any of these chips to test.
> > > Or maybe some eval boards from TI could be obtained to test these changes.
> > >
> > > Overall changes seem good [I haven't taken a close look], but HW
> > > testing is king.
> > >
> >
> > I have access to ADS7868 (the 8 bit version) which has been connected
> > in "loopback" to the ti-dac7612 (also new driver). I can run any test
> > that you need or even give you or someone access (privately) to the
> > board via vpn
> > or something like that.
> >
> > Would that work for you?
>
> No, that's fine :)
> Thank you for the answer.
> And apologies [again] if this was a bit too forward/harsh from my side.
>
Absolutely no worries! it wasn't. When I use a driver from kernel.org
I expect it
to have the maximum quality and work on real hardware. This is how we get there.

Best regards!

> Thanks
> Alex
>
> >
> > Best regards!
> >
> > > Thanks
> > > Alex
> > >
> > > > > Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > > > > ---
> > > > > v2: I have missnamed the devices
> > > > >  drivers/iio/adc/Kconfig  |  3 ++-
> > > > >  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
> > > > >  2 files changed, 22 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > > index f9354e5ee65c..d86900fc2634 100644
> > > > > --- a/drivers/iio/adc/Kconfig
> > > > > +++ b/drivers/iio/adc/Kconfig
> > > > > @@ -64,7 +64,8 @@ config AD7476
> > > > >       help
> > > > >         Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> > > > >         AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> > > > > -       AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> > > > > +       AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> > > > > +       to digital converters (ADC).
> > > >
> > > > As commented in the earlier thread (after you sent this!), please make sure
> > > > the help text makes it clear that these aren't all Analog devices parts.
> > > >
> > > > Likely to cause confusion otherwise.
> > > >
> > > > Good to see you didn't spin another driver but instead tracked down that
> > > > this one would work well!
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >
> > > > >
> > > > >         To compile this driver as a module, choose M here: the
> > > > >         module will be called ad7476.
> > > > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > > > index 0549686b9ef8..76747488044b 100644
> > > > > --- a/drivers/iio/adc/ad7476.c
> > > > > +++ b/drivers/iio/adc/ad7476.c
> > > > > @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
> > > > >       ID_ADC081S,
> > > > >       ID_ADC101S,
> > > > >       ID_ADC121S,
> > > > > +     ID_ADS7866,
> > > > > +     ID_ADS7867,
> > > > > +     ID_ADS7868,
> > > > >  };
> > > > >
> > > > >  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> > > > > @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> > > > >  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> > > > >               BIT(IIO_CHAN_INFO_RAW))
> > > > >  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > > > > +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> > > > > +             BIT(IIO_CHAN_INFO_RAW))
> > > > >
> > > > >  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> > > > >       [ID_AD7091R] = {
> > > > > @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> > > > >               .channel[0] = ADC081S_CHAN(12),
> > > > >               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > >       },
> > > > > +     [ID_ADS7866] = {
> > > > > +             .channel[0] = ADS786X_CHAN(12),
> > > > > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > +     },
> > > > > +     [ID_ADS7867] = {
> > > > > +             .channel[0] = ADS786X_CHAN(10),
> > > > > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > +     },
> > > > > +     [ID_ADS7868] = {
> > > > > +             .channel[0] = ADS786X_CHAN(8),
> > > > > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > +     },
> > > > >  };
> > > > >
> > > > >  static const struct iio_info ad7476_info = {
> > > > > @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
> > > > >       {"adc081s", ID_ADC081S},
> > > > >       {"adc101s", ID_ADC101S},
> > > > >       {"adc121s", ID_ADC121S},
> > > > > +     {"ads7866", ID_ADS7866},
> > > > > +     {"ads7867", ID_ADS7867},
> > > > > +     {"ads7868", ID_ADS7868},
> > > > >       {}
> > > > >  };
> > > > >  MODULE_DEVICE_TABLE(spi, ad7476_id);
> > > >
> >
> >
> >
> > --
> > Ricardo Ribalda



-- 
Ricardo Ribalda
