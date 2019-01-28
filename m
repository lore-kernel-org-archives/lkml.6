Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2919C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F2E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoSBOKeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfA1Hrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:47:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40935 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:47:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so12249616oie.7;
        Sun, 27 Jan 2019 23:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPu5eoYGF27BXVIL35WdAMFcm8kmepYjnefqlWA0ywA=;
        b=CoSBOKeVxZqymxqTiQ6xVuS1UNAiPc1VNld+/we8dio8HVi7mPdJEpMU1N7KKtqRC9
         Sfrv45nWKl3X1bmX6v2BVYWTo7MDyL4Hnl038x9LiKQVCmpo+J0qMPgqqewR49AiYQ6o
         8HaDfl8Gyf2/GVp07nlF8390FCkfKgIp1YXHQaiH7wMV44qpGsR6bRz7QUhOh0a7LcXJ
         d3xriY4Lau6JiZTLLLcJYHfFqlZauOBJ/vq+f1T1ZcQjLJv4Yylf/9jbvC/Q1dNqr+ig
         70AQwwMUv2RZ9uIlXHTW5VHRIxi0of5ne1k8hC+YW6vJC+lv8QHS/1xEoSGN3I6EUMKh
         CJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPu5eoYGF27BXVIL35WdAMFcm8kmepYjnefqlWA0ywA=;
        b=JZlqJ8aZrFwbegcK+SDGP29WiDUvx2iUd4uk0dm4LWFnlSFG6nbcATF8c1AHQntTRC
         4L3rdBHxsJGXqBbXSo7aLp+XIF4vNxjjBfFKT2c5h8qf6j1NkLAp89B7+YgN2D3hVnJ4
         mm2jG8YuBpyQEO7tzieHahfHvbAOSMdP2tqL4M8WR8YeK9LKJRwJb4u19268KLJyHF2w
         OpHpXL7PXkcH8h3XVxMOL9gd42Uk+XHK7WdofkOcaTpEWSc+eY3y2tplAGSt+WvTYwON
         AgJqanuJSIYyQpO7cKa/N5AhI9z6vWdK/zGj+Lc7wfT0wKKz3kSCObvYBRKj21LlFfJx
         DDEw==
X-Gm-Message-State: AJcUukcFX6jqYkYX4uLlBIXmjeHuWC/z+DYRxgqfkq8iRSyNTYGcVHsm
        13TvLSgjqRzwtoahQRT6hjW2XRwVvle4jGy2CTA=
X-Google-Smtp-Source: AHgI3IbaBlypREDZqktCs2BQYOZrWarD+0IJ7+ph0xlODTkboLI9iCKbBsCcm4fLmU7Dp0KkPcds0kY27iZgpVNbgV0=
X-Received: by 2002:a54:460a:: with SMTP id p10mr5094728oip.27.1548661666152;
 Sun, 27 Jan 2019 23:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20190125100451.15011-1-ricardo@ribalda.com> <20190126182114.15ac673c@archlinux>
 <CA+U=DsqX-FOYYdS5NGrqfVySsf4NnnDKYxN8hXO6P_3OgUmiWQ@mail.gmail.com> <CAPybu_2pFHbwaJMQxso17My+UoCtAyVVSZBabVE4xsp0HLV7UA@mail.gmail.com>
In-Reply-To: <CAPybu_2pFHbwaJMQxso17My+UoCtAyVVSZBabVE4xsp0HLV7UA@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 28 Jan 2019 09:47:34 +0200
Message-ID: <CA+U=DsprCm6GpPSROAN9dC5De4=ivhY9m_75Kn-h=jWpw-5JfA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7476: Add support for ADS786X ADCs
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 9:43 AM Ricardo Ribalda Delgado
<ricardo@ribalda.com> wrote:
>
> HI Alexandru
>
> On Mon, Jan 28, 2019 at 8:38 AM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> >
> > On Sat, Jan 26, 2019 at 8:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Fri, 25 Jan 2019 11:04:51 +0100
> > > Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:
> > >
> > > > Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> > > > ADC.
> > > >
> >
> > I don't want this reply be offensive or anything.
> > But since I've seen this precedence, I do have to ask if these driver
> > changes were tested on at least one of the TI chips/eval-boards.
> >
> > Ideally, before adding new drivers it would be nice to make sure that
> > they were run on actual HW.
> > Good code-review can get us only so far.
> >
> > We could ask someone who has any of these chips to test.
> > Or maybe some eval boards from TI could be obtained to test these changes.
> >
> > Overall changes seem good [I haven't taken a close look], but HW
> > testing is king.
> >
>
> I have access to ADS7868 (the 8 bit version) which has been connected
> in "loopback" to the ti-dac7612 (also new driver). I can run any test
> that you need or even give you or someone access (privately) to the
> board via vpn
> or something like that.
>
> Would that work for you?

No, that's fine :)
Thank you for the answer.
And apologies [again] if this was a bit too forward/harsh from my side.

Thanks
Alex

>
> Best regards!
>
> > Thanks
> > Alex
> >
> > > > Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
> > > >
> > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > > > ---
> > > > v2: I have missnamed the devices
> > > >  drivers/iio/adc/Kconfig  |  3 ++-
> > > >  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
> > > >  2 files changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > index f9354e5ee65c..d86900fc2634 100644
> > > > --- a/drivers/iio/adc/Kconfig
> > > > +++ b/drivers/iio/adc/Kconfig
> > > > @@ -64,7 +64,8 @@ config AD7476
> > > >       help
> > > >         Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> > > >         AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> > > > -       AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> > > > +       AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> > > > +       to digital converters (ADC).
> > >
> > > As commented in the earlier thread (after you sent this!), please make sure
> > > the help text makes it clear that these aren't all Analog devices parts.
> > >
> > > Likely to cause confusion otherwise.
> > >
> > > Good to see you didn't spin another driver but instead tracked down that
> > > this one would work well!
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > >
> > > >         To compile this driver as a module, choose M here: the
> > > >         module will be called ad7476.
> > > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > > index 0549686b9ef8..76747488044b 100644
> > > > --- a/drivers/iio/adc/ad7476.c
> > > > +++ b/drivers/iio/adc/ad7476.c
> > > > @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
> > > >       ID_ADC081S,
> > > >       ID_ADC101S,
> > > >       ID_ADC121S,
> > > > +     ID_ADS7866,
> > > > +     ID_ADS7867,
> > > > +     ID_ADS7868,
> > > >  };
> > > >
> > > >  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> > > > @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> > > >  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> > > >               BIT(IIO_CHAN_INFO_RAW))
> > > >  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > > > +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> > > > +             BIT(IIO_CHAN_INFO_RAW))
> > > >
> > > >  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> > > >       [ID_AD7091R] = {
> > > > @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> > > >               .channel[0] = ADC081S_CHAN(12),
> > > >               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > >       },
> > > > +     [ID_ADS7866] = {
> > > > +             .channel[0] = ADS786X_CHAN(12),
> > > > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > +     },
> > > > +     [ID_ADS7867] = {
> > > > +             .channel[0] = ADS786X_CHAN(10),
> > > > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > +     },
> > > > +     [ID_ADS7868] = {
> > > > +             .channel[0] = ADS786X_CHAN(8),
> > > > +             .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > +     },
> > > >  };
> > > >
> > > >  static const struct iio_info ad7476_info = {
> > > > @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
> > > >       {"adc081s", ID_ADC081S},
> > > >       {"adc101s", ID_ADC101S},
> > > >       {"adc121s", ID_ADC121S},
> > > > +     {"ads7866", ID_ADS7866},
> > > > +     {"ads7867", ID_ADS7867},
> > > > +     {"ads7868", ID_ADS7868},
> > > >       {}
> > > >  };
> > > >  MODULE_DEVICE_TABLE(spi, ad7476_id);
> > >
>
>
>
> --
> Ricardo Ribalda
