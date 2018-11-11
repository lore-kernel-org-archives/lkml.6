Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AB521104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz8H3+Om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AB521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeKLATU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbeKLATU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:19:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C660D208A3;
        Sun, 11 Nov 2018 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541946637;
        bh=dyodpUQ19CDwjkCBl6KTmuqPbMOlybeC5rnXjNq5XKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rz8H3+Omyq1esf/tva3RBmWL/osmZfAEBiQ+J25QmUe5y9PKmoYLeubN4Dekam5nL
         V/UAVorBeVcQKr/gU09H4SN7/PCRkGiZiTnG350ObCUm90yoa/aMpTKA5njY4bvyTE
         610v6kK6oteXCIA0RUTTBe9YZKe4WpZIOZX+u5HU=
Date:   Sun, 11 Nov 2018 14:30:31 +0000
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
Subject: Re: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181111142939.316cdd47@archlinux>
In-Reply-To: <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
        <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
        <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 09:24:44 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2018-11-05 at 17:14 -0200, Renato Lui Geh wrote:
> > The ad7780 driver previously did not read the correct device output, as
> > it read an outdated value set at initialization. It now updates its
> > voltage on read.
> >   
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to check it.  I'm not that fussed about pushing this
one as a fix, as most of the time these things are on fixed regulators
anyway, but it is nice to do it right.

> Looks good from my side.
Ack?

Much preferred if you are willing to give a formal acknowledgement.

Thanks,

Jonathan


> 
> Alex
> 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed initialization (int voltage_uv = 0)
> > 	- returns error when voltage_uv is null
> > Changes in v4:
> > 	- returns error when voltage_uv is negative
> > 
> >  drivers/staging/iio/adc/ad7780.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index b67412db0318..c7cb05cedbbc 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -87,12 +87,16 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  			   long m)
> >  {
> >  	struct ad7780_state *st = iio_priv(indio_dev);
> > +	int voltage_uv;
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_RAW:
> >  		return ad_sigma_delta_single_conversion(indio_dev, chan,
> > val);
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = st->int_vref_mv * st->gain;
> > +		voltage_uv = regulator_get_voltage(st->reg);
> > +		if (voltage_uv < 0)
> > +			return voltage_uv;
> > +		*val = (voltage_uv / 1000) * st->gain;
> >  		*val2 = chan->scan_type.realbits - 1;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:  

