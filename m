Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F1C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8B20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2CHIEDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA8B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeKCWWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 18:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKCWWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 18:22:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE8E2082E;
        Sat,  3 Nov 2018 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541250652;
        bh=oUkojuTHqsnCHnPMmDc+mo53D1MYvLemB6y3jAsS7ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U2CHIEDf0PlKwmjqjo1AvDiHBqFseJok7KA3zS2VNktSdbkNXo+sBcvnFjMX235/p
         DyznsxbLB631HYEzMd0Eq99E3urtqP88xTl7Kq8wiToYnt2zTbwqFtF+aFA4MYOyaZ
         pOKiSJi1CBXl7Mu9ZRHAvO2S2ACOFhF44Sa1RPhc=
Date:   Sat, 3 Nov 2018 13:10:47 +0000
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
Subject: Re: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <20181103131047.235ee9cf@archlinux>
In-Reply-To: <8e33078437ba3153305c5d31aba54412a786a9bb.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
        <8e33078437ba3153305c5d31aba54412a786a9bb.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 15:28:19 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2018-11-01 at 11:43 -0300, Renato Lui Geh wrote:
> > This patch removes the unnecessary field int_vref_mv in ad7780_state
> > referring to the device's voltage.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed unnecessary int_vref_mv from ad7780_state
> > 
> >  drivers/staging/iio/adc/ad7780.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index f2a11e9424cd..f250370efcf7 100644
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
> > @@ -190,9 +189,7 @@ static int ad7780_probe(struct spi_device *spi)
> >  	st->chip_info =
> >  		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> >  
> > -	if (voltage_uv)
> > -		st->int_vref_mv = voltage_uv / 1000;
> > -	else
> > +	if (!voltage_uv)
> >  		dev_warn(&spi->dev, "Reference voltage unspecified\n");  
> 
> I think you could remove this altogether, and also remove the entire
> `voltage_uv = regulator_get_voltage(st->reg);` assignment.
> 
> It doesn't make much sense to read the voltage here, since it won't be used
> in the probe part anymore.
> 
Absolutely agree on this. There is no point in reading here at all.

Jonathan
> >  
> >  	spi_set_drvdata(spi, indio_dev);  

