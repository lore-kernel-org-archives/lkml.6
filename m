Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D772086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW0LAgV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390203AbeKQDSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeKQDSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:18:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272592087C;
        Fri, 16 Nov 2018 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542387933;
        bh=MkQ0ELlPv25ltfzuU6MGzfMPX3vYmZ+Nr0WX1QfHgXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GW0LAgV/Mu7I9E0xAxIowwcUIER5XT0lNBUPNgSJNr8xhgRXjr234E0Gjqmfkl2b5
         hthKRFZfAPe83L+XD9KuKC03ZavqJUwsPnZjZQ8/EwjkxWBqRwbHIIL4iWi4akPhoI
         MRxHnJjCHNCS4fUT4ZXOM9FGu49JxMPJ8bv3UHlM=
Date:   Fri, 16 Nov 2018 17:05:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <20181116170528.10bd3740@archlinux>
In-Reply-To: <20181115142504.GA4098@nishad>
References: <cover.1542215638.git.nishadkamdar@gmail.com>
        <d2df511b4a84b92925a39b5051932eef4426f18d.1542215638.git.nishadkamdar@gmail.com>
        <4abed67ee07c763151a76cf9e687b6edc6ced5c6.camel@analog.com>
        <20181115142504.GA4098@nishad>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 19:55:06 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> On Thu, Nov 15, 2018 at 08:16:03AM +0000, Ardelean, Alexandru wrote:
> > On Wed, 2018-11-14 at 23:16 +0530, Nishad Kamdar wrote:  
> > > Add device tree table for matching vendor ID.
> > >   
> > 
> > This could have been just one patch.
> > Something like 
> >    [PATCH v4] staging: iio: ad7816: Add device tree table.
> > 
> > It's no longer a series, because the other patches were applied already.
> > 
> > I don't think you need to re-spin this [it's up to Jonathan though].
> > 
> > It's just something to keep in mind for later when re-spinning patches or
> > series of patches.
> > 
> > Alex
> >  
> 
> Ok. I'll keep that in mind.
> 
> Thanks for the review.
> 
> Regards,
> Nishad
> 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7816.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > b/drivers/staging/iio/adc/ad7816.c
> > > index a2fead85cd46..925f7086bc07 100644
> > > --- a/drivers/staging/iio/adc/ad7816.c
> > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > @@ -422,6 +422,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
> > >  	return 0;
> > >  }
> > >  
> > > +static const struct of_device_id ad7816_of_match[] = {
> > > +	{ .compatible = "adi,ad7816", },
> > > +	{ .compatible = "adi,ad7817", },
> > > +	{ .compatible = "adi,ad7818", },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > > +
> > >  static const struct spi_device_id ad7816_id[] = {
> > >  	{ "ad7816", ID_AD7816 },
> > >  	{ "ad7817", ID_AD7817 },
> > > @@ -434,6 +442,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
> > >  static struct spi_driver ad7816_driver = {
> > >  	.driver = {
> > >  		.name = "ad7816",
> > > +		.of_match_table = of_match_ptr(ad7816_of_match),
Also, don't use of_match_ptr, it defines the table to NULL if
CONFIG_OF is not set, which breaks the ACPI based probing using
the magic number to tell it to use the DT bindings (weird
corner case).  One of those really obscure corners cases
(and one that hasn't existed for that long!)

I'll fix up.

Applied to to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> > >  	},
> > >  	.probe = ad7816_probe,
> > >  	.id_table = ad7816_id,  

