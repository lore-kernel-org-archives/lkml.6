Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F92C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFC4214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiK6enNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFC4214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbeKVFsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeKVFsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:48:18 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20E6206BB;
        Wed, 21 Nov 2018 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827564;
        bh=B2GFOcKRb2UPXfHAwb+EnD2/+Ba76pF/aJDGrLjg0fI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SiK6enNBgVLDHIbDgfWqYrEEo4XM+CjNyXMenRJyevMMNZ+E1mhAx6DJjWE6TKjJb
         0j8biY8HfmnGVM1ST2sm3q1xaKxGP35btAjK0GdXuVvV4qLh1OhyCE8YYzGhyyMV55
         c1TUs5J9XhTMRLBu+nzLeU6n6mVmGa1e0gSSOUDk=
Date:   Wed, 21 Nov 2018 19:12:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Victor Colombo <victorcolombo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] staging:iio:ad2s90: Add device tree support
Message-ID: <20181121191239.5aa312ea@archlinux>
In-Reply-To: <CAHd-oW4mq1HnTqr_XZt7cktTgy_ytH=ARg+d3ac+Q5bSdbciUQ@mail.gmail.com>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
        <20181118042540.12697-2-matheus.bernardino@usp.br>
        <f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel@analog.com>
        <CAHd-oW4mq1HnTqr_XZt7cktTgy_ytH=ARg+d3ac+Q5bSdbciUQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 21:59:19 -0200
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> On Mon, Nov 19, 2018 at 6:09 AM Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> wrote:
> >
> > On Sun, 2018-11-18 at 02:25 -0200, Matheus Tavares wrote:  
> > > This patch adds device tree support to ad2s90 with standard
> > > device tree id table.
> > >  
> >
> > Hey,
> >
> > Comment inline
> >  
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > ---
> > > Changes in v2:
> > >  - none
> > >
> > >  drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/staging/iio/resolver/ad2s90.c
> > > b/drivers/staging/iio/resolver/ad2s90.c
> > > index 3e257ac46f7a..6ffbac66b837 100644
> > > --- a/drivers/staging/iio/resolver/ad2s90.c
> > > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > > @@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
> > >       return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > >  }
> > >
> > > +static const struct of_device_id ad2s90_of_match[] = {
> > > +     { .compatible = "adi,ad2s90", },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ad2s90_of_match);
> > > +
> > >  static const struct spi_device_id ad2s90_id[] = {
> > >       { "ad2s90" },
> > >       {}
> > > @@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
> > >  static struct spi_driver ad2s90_driver = {
> > >       .driver = {
> > >               .name = "ad2s90",
> > > +             .of_match_table = of_match_ptr(ad2s90_of_match),  
> >
> > I think you need to remove the of_match_ptr().
> > There was a comment from Jonathan on another thread about this.
> > See:
> >    https://patchwork.kernel.org/patch/10682963/
> >  
> 
> Hm, got it, thanks!
> 
> I don't understand much about ACPI yet, and I had understood the
> "of_match_ptr" as a guard. Could someone point me in which cases it
> should be used? Or is it obsolete?
>
It's an odd one.  The ACPI route allows you to basically provide
a temporary (these are really just for debugging purposes)

https://lwn.net/Articles/612062/
https://www.kernel.org/doc/Documentation/acpi/enumeration.txt
search for prp0001

So of_match_ptr is sort of obsolete, but conversely for some
types of driver it might never make sense to use the prp0001
route.  For the stuff I play with in my day job for example
we can just change the firmware to do it right whenever we
need to and have appropriate ACPI ids to be able to issue
unique ones.

Jonathan

> Matheus
> 
> > So,
> > +               .of_match_table = of_match_ptr(ad2s90_of_match),
> >
> > becomes  
> > > +             .of_match_table = ad2s90_of_match,  
> >  
> > >       },
> > >       .probe = ad2s90_probe,
> > >       .id_table = ad2s90_id,  
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > To post to this group, send email to kernel-usp@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel%40analog.com.
> > For more options, visit https://groups.google.com/d/optout.  

