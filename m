Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F01C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B122A2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnnlg12B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B122A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJMUPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeJMUPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:15:36 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935E620865;
        Sat, 13 Oct 2018 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539434315;
        bh=dlRX3uJfhM1be3iMI1STOV+hzKHYAM6yrf7wBTtPN8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnnlg12B+MxOuae4QMaClFfTcoHaEoRfltyfNuVPtVosOSZt3laHRm7nqDIXqAbed
         25Yw2fuNbSYNA8cPkT9Ne3jofoQOPHRS0mgYGedasSfWRWLwGvw1GjSK24KyYcoJgZ
         nmCE/g4cEq3d4IvKJgEpok2Qhdu4ggutlR4u+vTY=
Date:   Sat, 13 Oct 2018 13:38:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dpot-dac: mark expected switch fall-through
Message-ID: <20181013133831.7dbd31e8@archlinux>
In-Reply-To: <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
References: <20181008173528.GA31787@embeddedor.com>
        <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 20:42:41 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2018-10-08 19:35, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.  
> 
> The way I see it, it is pretty well marked up as is. So, this paragraph
> is not describing the change.
> 
> > 
> > Notice that in this particular case, I replaced "...and fall through."
> > with a proper "fall through", which is what GCC is expecting to find.  
> 
> What is not "proper" about the existing comment? Yes yes, I *know* that
> GCC is not very intelligent about it and requires hand-holding, but
> blaming the existing comment for not *properly* marking an intentional
> fall through is ... rich.
> 
> > 
> > Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/iio/dac/dpot-dac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
> > index a791d0a..e353946 100644
> > --- a/drivers/iio/dac/dpot-dac.c
> > +++ b/drivers/iio/dac/dpot-dac.c
> > @@ -78,7 +78,7 @@ static int dpot_dac_read_raw(struct iio_dev *indio_dev,  
> 
> Adding some more context here.
> 
> 		case IIO_VAL_INT:
> 			/*
> 			 * Convert integer scale to fractional scale by
> 			 * setting the denominator (val2) to one...
> >  			 */
> >  			*val2 = 1;
> >  			ret = IIO_VAL_FRACTIONAL;
> > -			/* ...and fall through. */
> > +			/* fall through */
> >  		case IIO_VAL_FRACTIONAL:
> >  			*val *= regulator_get_voltage(dac->vref) / 1000;
> >  			*val2 *= dac->max_ohms;
> >   
> 
> Considering the above added context, I have to say that this mindless
> change is not an improvement, as you have just destroyed the continued
> sentence from the previous comment. You must have noticed that this
> was the end of a continued sentence, as you even quoted it in the commit
> message. The big question is why you did not stop to think and consider
> the context?
> 
> Yes, I'm annoyed by mindless changes. Especially mindless changes aimed
> at improving readability while in fact making things less readable.
> 
> TL;DR, if you are desperate to fix "the problem" with this fall through
> comment, please do so in a way that preserves overall readability. And
> it would be nice to not blame the existing code for brain damage in GCC
> and various other static analyzers.
> 
> Cheers,
> Peter
I agree with you in principle Peter and have tweaked the patch description
to make it clearer that we are doing this to make GCC static analysis more
helpful (suppressing a false warning is a worthwhile if you are dealing with
lots of them).

However, nice though it is to have elegant comment structure I think we
should still have this patch in place.  This effort to 'fix' these
warnings has already identified a few places where it was wrong so
I'm keen to see it applied by default even if it isn't perfect.

Jonathan


