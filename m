Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A8BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E411F21479
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frl819Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E411F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeKKW0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKW0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:26:36 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26DC20866;
        Sun, 11 Nov 2018 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541939887;
        bh=VVe5DPNABTjHvFAmWRnpqAp8eL21WZSndR91too0OLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Frl819TbHpdqfn8aalrr4jtVasMAUbbvBti6+WyNNdAoK7/czPnyrKUcAJbzTQhu3
         lt/6wHWd5pWIKXV7g6RmLvuwVjFYioQ8b6rQovh10DVywn+aABWp2Y3Rie0xsMIvOS
         zAFa6nCBLizuvt5vVpdj2lcLueY7nrvm8J7iEegk=
Date:   Sun, 11 Nov 2018 12:38:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <20181111123802.212a8b79@archlinux>
In-Reply-To: <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
        <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 08:11:57 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2018-11-09 at 13:08 +0530, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID.  
> 
> One comment inline for this.
> 
> Thanks
> Alex
> 
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7816.c
> > b/drivers/staging/iio/adc/ad7816.c
> > index a2fead85cd46..b8a9149fbac1 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -422,6 +422,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad7816_of_match[] = {
> > +	{ .compatible = "adi,ad7816", },  
> 
> I think you also need to add:
> +	{ .compatible = "adi,ad7817", },
> +	{ .compatible = "adi,ad7818", },
> 

Yes, please add all parts to the dt binding.
Particularly as they are functionally different in this case!

Please send a v4 for just this patch as the rest have now been
applied.

Thanks,


Jonathan

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > +
> >  static const struct spi_device_id ad7816_id[] = {
> >  	{ "ad7816", ID_AD7816 },
> >  	{ "ad7817", ID_AD7817 },
> > @@ -434,6 +440,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
> >  static struct spi_driver ad7816_driver = {
> >  	.driver = {
> >  		.name = "ad7816",
> > +		.of_match_table = of_match_ptr(ad7816_of_match),
> >  	},
> >  	.probe = ad7816_probe,
> >  	.id_table = ad7816_id,  

