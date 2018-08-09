Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44322C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A0221CD1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A0221CD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeHIOeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:34:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:34:22 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 82EBA907;
        Thu,  9 Aug 2018 12:09:45 +0000 (UTC)
Date:   Thu, 9 Aug 2018 11:49:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] staging: fbtft: Fixes some defines styles -
 Style
Message-ID: <20180809094953.GA22141@kroah.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
 <cb5b3900e97e3b295dda63b5d8b29d6fed669893.1533686201.git.leobras.c@gmail.com>
 <20180808122219.GC20272@kroah.com>
 <CADvQ+rGiF2kT62tBJjruGkQ8TbxU45PmgpW7xfrMy8xi1tOTBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvQ+rGiF2kT62tBJjruGkQ8TbxU45PmgpW7xfrMy8xi1tOTBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:39:55AM -0300, Leonardo Bras wrote:
> On Wed, Aug 08, 2018 at 02:22:19PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 07, 2018 at 09:29:25PM -0300, Leonardo Brás wrote:
> > > Fixing some styles as recommended by checkpatch.pl.
> > >
> > > Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> > > ---
> > >  drivers/staging/fbtft/fbtft-bus.c  | 10 ++++++----
> > >  drivers/staging/fbtft/fbtft-core.c |  6 ++++--
> > >  drivers/staging/fbtft/fbtft.h      |  4 ++--
> > >  3 files changed, 12 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/staging/fbtft/fbtft-bus.c
> b/drivers/staging/fbtft/fbtft-bus.c
> > > index 8ce1ff9b6c2a..20d94712cc84 100644
> > > --- a/drivers/staging/fbtft/fbtft-bus.c
> > > +++ b/drivers/staging/fbtft/fbtft-bus.c
> > > @@ -60,11 +60,13 @@ void func(struct fbtft_par *par, int len, ...)
>                           \
> > >  out:
>            \
> > >     va_end(args);
>    \
> > >  }
>        \
> > > -EXPORT_SYMBOL(func);
> > > +EXPORT_SYMBOL(func)
> >
> > why did you change this line?
> 
> checkpatch.pl recommended removing ";" from the end of a macro define,
> and attaching it after the usage of the macro.
> 
> Probably to make the macro usage more likely a function declaration.

Ah, I was confused by your initial subject/changelog, you did not
explain why you were doing what you were doing, and you lumped a bunch
of different types of changes all in a single patch, which is not
allowed.

Please only do one patch per "type" of change, this should be a patch
series.

> > >
> > > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> > > -define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16,
> cpu_to_be16)
> > > -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> > > +#define no_modf /*No modifier*/
> >
> > Ick ick ick, no.
> 
> Please help me understand.
> There are 3 steps that may be bad here:
> 1. Defining no_modf as a comment.

Yes.

> 2. Defining no_modf as "nothing"

Yes.

> 3. Using no_modf (defined as nothing) as a filler to avoid not
> passing a "parameter" to the macro.

Yes.

> I understand it may be a combination of the above, but i need
> to understand it better.

Why do you want to do any of the above?  What is wrong with the existing
macro?

thanks,

greg k-h
