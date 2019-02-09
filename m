Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B4C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EB321929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549731729;
	bh=hxEB6OyB6IgopB2P/p1T98w4xf5RsnnEJOzJiht6OeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WUfpVNI1KOgWxWlnYOfD3hPccMtC9WdJzLCs1w3FO9Z/hnzY03ZpBbHWzN+x7DCBd
	 b0E6FoTkyiYsEr0Mvo5J9DJ2hwWnfINX1qyouzNijaof2sPDCpc4G2PLetEsJvlTkQ
	 yp7fJ9adTR7FFejpy4vPO01zdR0AgnCpyKvC0ukc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBIRCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBIRCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:02:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF3521919;
        Sat,  9 Feb 2019 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549731727;
        bh=hxEB6OyB6IgopB2P/p1T98w4xf5RsnnEJOzJiht6OeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q8jOk6xTMYUHH04nQLcSZYyD1TtO8YeJXINDwq6SUfYilv2/gLj/c65U68F1CfF/M
         wrS6Sy+o8VSzjcgAetO/dOfyGZbdj0ScZFSVQdorgsZEZ+bkON8oamwMIq7EEkZf1E
         Z5xoOVipEJGQ9sGz7YMqFgiz+WgJvDIZR0k+Utl0=
Date:   Sat, 9 Feb 2019 17:02:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ads124s08: fix spelling mistake "converions"
 -> "conversions"
Message-ID: <20190209170202.716ea020@archlinux>
In-Reply-To: <e083e2af-a00d-fb1f-a860-26c369ac5932@ti.com>
References: <20190207093902.7081-1-colin.king@canonical.com>
        <e083e2af-a00d-fb1f-a860-26c369ac5932@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 07:14:00 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Colin
> 
> Thanks for the patch
> 
> On 2/7/19 3:39 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in several dev_err messages. Fix these.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iio/adc/ti-ads124s08.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> > index c2cf58908fc8..53f17e4f2f23 100644
> > --- a/drivers/iio/adc/ti-ads124s08.c
> > +++ b/drivers/iio/adc/ti-ads124s08.c
> > @@ -232,7 +232,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
> >  
> >  		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> >  		if (ret) {
> > -			dev_err(&priv->spi->dev, "Start converions failed\n");
> > +			dev_err(&priv->spi->dev, "Start conversions failed\n");
> >  			goto out;
> >  		}
> >  
> > @@ -246,7 +246,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
> >  
> >  		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> >  		if (ret) {
> > -			dev_err(&priv->spi->dev, "Stop converions failed\n");
> > +			dev_err(&priv->spi->dev, "Stop conversions failed\n");
> >  			goto out;
> >  		}
> >  
> > @@ -283,12 +283,12 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
> >  
> >  		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> >  		if (ret)
> > -			dev_err(&priv->spi->dev, "Start ADC converions failed\n");
> > +			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
> >  
> >  		buffer[j] = ads124s_read(indio_dev, scan_index);
> >  		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> >  		if (ret)
> > -			dev_err(&priv->spi->dev, "Stop ADC converions failed\n");
> > +			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
> >  
> >  		j++;
> >  	}
> >   
> 
> Acked-by: Dan Murphy <dmurphy@ti.com>
> 
Applied, thanks,

Jonathan


