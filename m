Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36129C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08DA21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xMqMafd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08DA21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeKLAUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbeKLAUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:20:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF01208A3;
        Sun, 11 Nov 2018 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541946683;
        bh=zlCI/2HnYYasvTJQT4bjeFXw/jBcfJzhjRluTlg/3Jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xMqMafd8JD/RyThHtG1rKbBi/KuacqKo2cYEt0zOqHw/ulbujGEf5QrF6i4ajx2zV
         cHB1eSyD3P8RR8QIfh/W0U1X4ytXdwkzeKF0tZUF5UViPE1GYw/9wZJuA6ve6A3I+d
         F3ToZPBXGOCZOZwQL0v1iN+btEI64ClSnTxdm2PE=
Date:   Sun, 11 Nov 2018 14:31:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v4 2/2] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <20181111143116.3c886b46@archlinux>
In-Reply-To: <f36da3b8962d463a68e53e29563b3c9bff2e0ddf.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
        <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
        <f36da3b8962d463a68e53e29563b3c9bff2e0ddf.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 09:25:27 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2018-11-05 at 17:16 -0200, Renato Lui Geh wrote:
> > This patch removes the unnecessary field int_vref_mv in ad7780_state
> > referring to the device's voltage.
> >   
> 
> Looks good from my side.
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Alex
> 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed unnecessary int_vref_mv from ad7780_state
> > Changes in v4:
> > 	- removed voltage reading on probe
> > 
> >  drivers/staging/iio/adc/ad7780.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index c7cb05cedbbc..52a914360574 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -42,7 +42,6 @@ struct ad7780_state {
> >  	struct regulator		*reg;
> >  	struct gpio_desc		*powerdown_gpio;
> >  	unsigned int	gain;
> > -	u16				int_vref_mv;
> >  
> >  	struct ad_sigma_delta sd;
> >  };
> > @@ -165,7 +164,7 @@ static int ad7780_probe(struct spi_device *spi)
> >  {
> >  	struct ad7780_state *st;
> >  	struct iio_dev *indio_dev;
> > -	int ret, voltage_uv = 0;
> > +	int ret;
> >  
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >  	if (!indio_dev)
> > @@ -185,16 +184,10 @@ static int ad7780_probe(struct spi_device *spi)
> >  		dev_err(&spi->dev, "Failed to enable specified AVdd
> > supply\n");
> >  		return ret;
> >  	}
> > -	voltage_uv = regulator_get_voltage(st->reg);
> >  
> >  	st->chip_info =
> >  		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> >  
> > -	if (voltage_uv)
> > -		st->int_vref_mv = voltage_uv / 1000;
> > -	else
> > -		dev_warn(&spi->dev, "Reference voltage unspecified\n");
> > -
> >  	spi_set_drvdata(spi, indio_dev);
> >  
> >  	indio_dev->dev.parent = &spi->dev;  

