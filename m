Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FBC218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAYJ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:58:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45182 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfAYJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:58:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so6477781lfa.12;
        Fri, 25 Jan 2019 01:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYeko+af6F4gO4SAzprh3pA1X3jo+XdCPxCt0jkax4g=;
        b=taHe4dPeLe8G2lRrn4XxM7A0B6WETnZuRtY/UwwX8rfbOWa8htSVYozO9SUlzxBo3D
         MEwKSFER2Ns1NePhlxZSTIvX0DyobmbPgR8myS1OlGMGS/MbdkC91wwsfATKDCmZ4H+z
         ELCbLB9Rs2UMuW1JyzrHidAlVIzUg95roDCqCsuYrS3yu2j9b5Z4kVNsjewLZlVh1pq+
         4eE/ohz5bfO9Y/l2EkYnti6Xl3utUHMn/bc3wI9Gtoa2SzvVtA/nNpzmMUV72XmEBUHS
         5Ng2/TiX6eLujOPYTPne1dqCxWKaCs5GJRcHI8eUlmPPl2pFN2ej+Qbe1rVKTysmyn4w
         z15Q==
X-Gm-Message-State: AJcUukf5kP/cWi/IpeGtZCm2TTq66Xps4gMtVkOYYsQ3kgWlu0TP+qc6
        eijkwiL5N0D8y9F2hjqNkPYJSjJPJ8DxPIpin94=
X-Google-Smtp-Source: ALg8bN6CSpj8eSUJSd3VXDju9Yevc6QAqgr9UJckWsfJclHkt0A5x23yVgcy3qsb4hfiQAAkcP2S8YNjuj8eUK45LiI=
X-Received: by 2002:ac2:5599:: with SMTP id v25mr8635837lfg.169.1548410291818;
 Fri, 25 Jan 2019 01:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20190124213225.11803-1-ricardo@ribalda.com> <CA+U=Dspe=xvki7rZPhofiV50yOLnRR2sg9v1R_XRVxHbDXh-_Q@mail.gmail.com>
In-Reply-To: <CA+U=Dspe=xvki7rZPhofiV50yOLnRR2sg9v1R_XRVxHbDXh-_Q@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Fri, 25 Jan 2019 10:57:55 +0100
Message-ID: <CAPybu_084MFXDT=Op7icdbo2K3LimxoK_jRew7S6R0=q-yqNng@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7476: Add support for ADS786X ADCs
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandru

On Fri, Jan 25, 2019 at 9:29 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Thu, Jan 24, 2019 at 11:33 PM Ricardo Ribalda Delgado
> <ricardo@ribalda.com> wrote:
> >
> > Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> > ADC.
> >
> > Datasheet: http://www.ti.com/product/ADS7866
> > Datasheet: http://www.ti.com/product/ADS7867
> > Datasheet: http://www.ti.com/product/ADS7868
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > ---
> >  drivers/iio/adc/Kconfig  |  3 ++-
> >  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index f9354e5ee65c..d86900fc2634 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -64,7 +64,8 @@ config AD7476
> >         help
> >           Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> >           AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> > -         AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> > +         AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> > +         to digital converters (ADC).
>
> The driver is for Analog Devices parts.
> And these new parts are from TI.
>
> I'm not sure what the policy is for mixing manufacturers in drivers.
> But if that is allowed/fine, then maybe it would be a good idea to
> highlight that these chips are from another manufacturer.
> Or maybe rename the driver to a generic form to support both manufacturers ?
>
> In any case, Jonathan will have to tell us what to do here :)

Thanks for your review.

I have to send a v2, because I have inverted the name of the devices :S.

I will send it right away to avoid that anyone uses this version and
then wait for Jonathan feedback

>
> Thanks
> Alex
>
> >
> >           To compile this driver as a module, choose M here: the
> >           module will be called ad7476.
> > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > index 0549686b9ef8..108c18d64f7d 100644
> > --- a/drivers/iio/adc/ad7476.c
> > +++ b/drivers/iio/adc/ad7476.c
> > @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
> >         ID_ADC081S,
> >         ID_ADC101S,
> >         ID_ADC121S,
> > +       ID_ADS7866,
> > +       ID_ADS7867,
> > +       ID_ADS7868,
> >  };
> >
> >  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> > @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> >  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> >                 BIT(IIO_CHAN_INFO_RAW))
> >  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits) + 4, 0, \
> > +               BIT(IIO_CHAN_INFO_RAW))
> >
> >  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> >         [ID_AD7091R] = {
> > @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> >                 .channel[0] = ADC081S_CHAN(12),
> >                 .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> >         },
> > +       [ID_ADS7866] = {
> > +               .channel[0] = ADS786X_CHAN(8),
> > +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > +       },
> > +       [ID_ADS7867] = {
> > +               .channel[0] = ADS786X_CHAN(10),
> > +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > +       },
> > +       [ID_ADS7868] = {
> > +               .channel[0] = ADS786X_CHAN(12),
> > +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > +       },
> >  };
> >
> >  static const struct iio_info ad7476_info = {
> > @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
> >         {"adc081s", ID_ADC081S},
> >         {"adc101s", ID_ADC101S},
> >         {"adc121s", ID_ADC121S},
> > +       {"ads7866", ID_ADS7866},
> > +       {"ads7867", ID_ADS7867},
> > +       {"ads7868", ID_ADS7868},
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7476_id);
> > --
> > 2.20.1
> >



-- 
Ricardo Ribalda
http://ribalda.com
