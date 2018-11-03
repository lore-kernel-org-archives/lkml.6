Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A364CC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C85B20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXRg08pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C85B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeKCWSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 18:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeKCWSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 18:18:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0737A2082E;
        Sat,  3 Nov 2018 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541250446;
        bh=1DU/jIIVKUlpBUinxgKHrp5ClNGwMy3guBmpWLDUbmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fXRg08pTBqgCMuG1pjnPQKLLvqzil+xjmdXxdCH/7lR1qA4cXFa7oy0v1KSl8FsUt
         j0Nr/TQJKx9iGdK5rpsJDxFslDi6ocOCn6XmAaP5JMCSckE/+zNPBhXYEsMcbzJXAE
         Jiimpk90joy6575aPUQkxi+VNEweqljXwy7WlBnY=
Date:   Sat, 3 Nov 2018 13:07:21 +0000
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
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <20181103130721.53a806a5@archlinux>
In-Reply-To: <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
        <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 15:02:32 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> Good catch.
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
On the basis this has been broken for a long time, and you are clearly
doing other nearby not fix work, I'm going to take this through the togreg
tree rather than via the quicker fix path.  It makes my life
easier :)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> On Thu, 2018-11-01 at 11:43 -0300, Renato Lui Geh wrote:
> > Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
> > This was fixed by assigning the correct value instead.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7780.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index b67412db0318..91e016d534ed 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -96,7 +96,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  		*val2 = chan->scan_type.realbits - 1;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:
> > -		*val -= (1 << (chan->scan_type.realbits - 1));
> > +		*val = -(1 << (chan->scan_type.realbits - 1));
> >  		return IIO_VAL_INT;
> >  	}
> >    

