Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E73C282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E39218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548526649;
	bh=lgFuBwHkLU/6piaKUPoh8tsQjofieMDIzapn1TfeaoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vcdgGk149zdTu0DD/EBkvCtq1hdj1EEa8scLPwn61Yh3FLj6tD0zuUyLM7rzvD3jb
	 cufgzC8F1Dc0MOdtvwr0yHQyW3GHqVyhONjWrcMQJbs+z84aeboBsvt0I+CJ1IPk66
	 bXGjw+ykayMe1vtYai32mlujfJqYnbs0lggp9ML8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAZSR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfAZSR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:17:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D86E21872;
        Sat, 26 Jan 2019 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548526646;
        bh=lgFuBwHkLU/6piaKUPoh8tsQjofieMDIzapn1TfeaoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PnbcmM5ZOoQA3UxngMa/Zu4rlrg/pE9bvSrPiUcy/FMes10EQg3Wj7OzNBkMz6eUe
         9/rsfxwCGF9rVf8hJNYjBdtDizoa3u7CFTrQ7A72MFCf7tksf3cB44oVlWcZiXTDMA
         JaM6iRM0voAdwIWSRtiLvQHeZ07LnirWrbG7pHew=
Date:   Sat, 26 Jan 2019 18:17:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com
Subject: Re: [PATCH] iio: adc: ad7476: Add support for ADS786X ADCs
Message-ID: <20190126181721.5e176d6e@archlinux>
In-Reply-To: <CAPybu_084MFXDT=Op7icdbo2K3LimxoK_jRew7S6R0=q-yqNng@mail.gmail.com>
References: <20190124213225.11803-1-ricardo@ribalda.com>
        <CA+U=Dspe=xvki7rZPhofiV50yOLnRR2sg9v1R_XRVxHbDXh-_Q@mail.gmail.com>
        <CAPybu_084MFXDT=Op7icdbo2K3LimxoK_jRew7S6R0=q-yqNng@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 10:57:55 +0100
Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:

> Hi Alexandru
> 
> On Fri, Jan 25, 2019 at 9:29 AM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> >
> > On Thu, Jan 24, 2019 at 11:33 PM Ricardo Ribalda Delgado
> > <ricardo@ribalda.com> wrote:  
> > >
> > > Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> > > ADC.
> > >
> > > Datasheet: http://www.ti.com/product/ADS7866
> > > Datasheet: http://www.ti.com/product/ADS7867
> > > Datasheet: http://www.ti.com/product/ADS7868
> > >
> > > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > > ---
> > >  drivers/iio/adc/Kconfig  |  3 ++-
> > >  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
> > >  2 files changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index f9354e5ee65c..d86900fc2634 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -64,7 +64,8 @@ config AD7476
> > >         help
> > >           Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> > >           AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> > > -         AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> > > +         AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> > > +         to digital converters (ADC).  
> >
> > The driver is for Analog Devices parts.
> > And these new parts are from TI.
> >
> > I'm not sure what the policy is for mixing manufacturers in drivers.
> > But if that is allowed/fine, then maybe it would be a good idea to
> > highlight that these chips are from another manufacturer.
> > Or maybe rename the driver to a generic form to support both manufacturers ?

Don't rename the driver.  That always goes wrong in the long run.

However, absolutely highlight that multiple manufacturers parts are being
covered in the help text.  That should be sufficient.

This isn't the first time we have had a multi manufacturer driver but
they are rare in IIO.  Really common in other subsystems though where
cloning is more common (or devices are naturally similar because
they are simple - which is what I would guess is happening here though
I haven't actually looked yet!)

Jonathan


> >
> > In any case, Jonathan will have to tell us what to do here :)  
> 
> Thanks for your review.
> 
> I have to send a v2, because I have inverted the name of the devices :S.
> 
> I will send it right away to avoid that anyone uses this version and
> then wait for Jonathan feedback
> 
> >
> > Thanks
> > Alex
> >  
> > >
> > >           To compile this driver as a module, choose M here: the
> > >           module will be called ad7476.
> > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > index 0549686b9ef8..108c18d64f7d 100644
> > > --- a/drivers/iio/adc/ad7476.c
> > > +++ b/drivers/iio/adc/ad7476.c
> > > @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
> > >         ID_ADC081S,
> > >         ID_ADC101S,
> > >         ID_ADC121S,
> > > +       ID_ADS7866,
> > > +       ID_ADS7867,
> > > +       ID_ADS7868,
> > >  };
> > >
> > >  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> > > @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> > >  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> > >                 BIT(IIO_CHAN_INFO_RAW))
> > >  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > > +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits) + 4, 0, \
> > > +               BIT(IIO_CHAN_INFO_RAW))
> > >
> > >  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> > >         [ID_AD7091R] = {
> > > @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
> > >                 .channel[0] = ADC081S_CHAN(12),
> > >                 .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > >         },
> > > +       [ID_ADS7866] = {
> > > +               .channel[0] = ADS786X_CHAN(8),
> > > +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > +       },
> > > +       [ID_ADS7867] = {
> > > +               .channel[0] = ADS786X_CHAN(10),
> > > +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > +       },
> > > +       [ID_ADS7868] = {
> > > +               .channel[0] = ADS786X_CHAN(12),
> > > +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > +       },
> > >  };
> > >
> > >  static const struct iio_info ad7476_info = {
> > > @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
> > >         {"adc081s", ID_ADC081S},
> > >         {"adc101s", ID_ADC101S},
> > >         {"adc121s", ID_ADC121S},
> > > +       {"ads7866", ID_ADS7866},
> > > +       {"ads7867", ID_ADS7867},
> > > +       {"ads7868", ID_ADS7868},
> > >         {}
> > >  };
> > >  MODULE_DEVICE_TABLE(spi, ad7476_id);
> > > --
> > > 2.20.1
> > >  
> 
> 
> 

