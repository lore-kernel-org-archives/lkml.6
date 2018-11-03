Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF9C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A277320833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxn+vZUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A277320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKCVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeKCVuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:50:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2572082D;
        Sat,  3 Nov 2018 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541248772;
        bh=XbGxSqlcR9UL/VoSrkCtgrWStggiXjrBzUNa4HskOq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gxn+vZUkoz84alUXVdSOKceL8JQ7h615FpUR3ZO1D3KGAOCXpPPloUNAn4Sw5KC9b
         3EidGw3GypkkIx6Fj09pfxPPYQ85iUA3RZGbDwOesbXgcmwV3ithBjb2JKrXXHVsQV
         bbcOekApc6f3yKbEBFeeni07VEmnv5mNSzy7A9Eo=
Date:   Sat, 3 Nov 2018 12:39:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <20181103123927.339611b1@archlinux>
In-Reply-To: <20181101153508.GA5176@himanshu-Vostro-3559>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
        <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
        <20181101153508.GA5176@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 21:05:09 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Wed, Oct 31, 2018 at 09:30:36PM +0530, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index d3e7d5aad2c8..7c50def91a2b 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -701,6 +701,12 @@ static int ad2s1210_remove(struct spi_device *spi)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad2s1210_of_match[] = {
> > +	{ .compatible = "adi,ad2s1210", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);  
> 
> I believe this needs to be documented at:
> 
> Documentation/devicetree/bindings/iio/resolver/ad2s1210.txt
> 
> Cc'ed to devictree list + Rob(DT Maintainer).
> 
> Just wondering why didn't it came up till now from the IIO reviewers ? v7!!

Because in staging drivers graduations we often hold off doing the
dt-bindings document until we have full visibility of where we are going.

A lot of them have dodgy DT bindings (and that might even be the reason
they are in staging).  What we don't want is to have a doc for a silly
binding in the 'official' list as we'll have to support it for ever.

It needs documenting before moving out staging, but not necessarily now.
Particularly as this device is complex and has a 'lot' of other stuff
that isn't currently supported and quite possibly never will be.
Some of that would have non obvious dt bindings if we did support it.
For example we 'might' route the encoder outputs round to the inputs
of a counter driver and end up with a complex entity representing
the facilities that both fo them provide.

Agreed, the DT binding doc needs to come soon and before the move out
staging, but I am quite happy with it being in the next series.

A line in the description to that effect would have been useful of
course!

Jonathan

> 
> 

