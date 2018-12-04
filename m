Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D70C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303BD20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uKXt4Ifb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303BD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLDL5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:57:24 -0500
Received: from casper.infradead.org ([85.118.1.10]:44572 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w0iB6gtLaQWbVKPK/NCzFuNHzV5vMt2n+9v0mr9i4q8=; b=uKXt4IfbH3kVLVJrKPxfk56pZ5
        QWgOsa6G4lsEKsl70bPzO4bFdpnk3HzNzR7Kgm+vHYnQoFkpEfAUDhGDNaUUrVpQAaElpkqyRlIyP
        IPABv9un1qY01xQqnekjef2ggvXgg4wTf5Ojyv2xQrtHXv0DUQj6xj9B/hJM/HsVnId+MiGkFxXyl
        /MqHottm0adp3BOeVbpE7B87JzF8/hE+9oHcQfuArMYg2+Fx0lEc18jHstJUxO8+ExDINKE0zpr7T
        xc32NI6oUvUXPpRBSG/99ZgATcIF3tbopCe8CDbgez/aZXWVlHG+TiGWdz21PUQKOd6aQY0PhMX2B
        yr5crnhw==;
Received: from [191.33.148.129] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU9KJ-0006KU-9H; Tue, 04 Dec 2018 11:57:19 +0000
Date:   Tue, 4 Dec 2018 09:57:14 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [media] dib7000p: Remove dead code
Message-ID: <20181204095714.60ee5b95@coco.lan>
In-Reply-To: <20181204102639.3qsvfxrzmsvybiop@gofer.mess.org>
References: <20180915054739.14117-1-natechancellor@gmail.com>
        <CAKwvOdmQ4pbbPuvYrVYB9myD8ap36h6nLjEdL-mSbYjM37UJ_g@mail.gmail.com>
        <20180917193936.33e90d5a@coco.lan>
        <20181204102639.3qsvfxrzmsvybiop@gofer.mess.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 4 Dec 2018 10:26:40 +0000
Sean Young <sean@mess.org> escreveu:

> On Mon, Sep 17, 2018 at 07:39:36PM -0300, Mauro Carvalho Chehab wrote:
> > Em Mon, 17 Sep 2018 10:58:32 -0700
> > Nick Desaulniers <ndesaulniers@google.com> escreveu:
> >   
> > > On Fri, Sep 14, 2018 at 10:47 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:  
> > > >
> > > > Clang warns that 'interleaving' is assigned to itself in this function.
> > > >
> > > > drivers/media/dvb-frontends/dib7000p.c:1874:15: warning: explicitly
> > > > assigning value of variable of type 'int' to itself [-Wself-assign]
> > > >         interleaving = interleaving;
> > > >         ~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
> > > > 1 warning generated.
> > > >
> > > > It's correct. Just removing the self-assignment would sufficiently hide
> > > > the warning but all of this code is dead because 'tmp' is zero due to
> > > > being multiplied by zero. This doesn't appear to be an issue with
> > > > dib8000, which this code was copied from in commit 041ad449683b
> > > > ("[media] dib7000p: Add DVBv5 stats support").
> > > >
> > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/media/dvb-frontends/dib7000p.c | 10 ++--------
> > > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
> > > > index 58387860b62d..25843658fc68 100644
> > > > --- a/drivers/media/dvb-frontends/dib7000p.c
> > > > +++ b/drivers/media/dvb-frontends/dib7000p.c
> > > > @@ -1800,9 +1800,8 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)    
> > > 
> > > Something looks wrong here (with this function).  The patch is no
> > > functional change, since as you point out `interleaving` is
> > > initialized to 0, then never updated before read, but I think there's
> > > an underlying bug here that should be fixed differently.  Thanks for
> > > the patch though, as it does raise the question.
> > > 
> > > dib7000p_get_time_us has this comment above it:
> > > 
> > >   1798 /* FIXME: may require changes - this one was borrowed from
> > > dib8000 */  
> > 
> > The goal of dib7000p_get_time_us() is to estimate how much time it
> > takes, with current tuning parameters, to have a certain number of
> > DVB-T packets. This is used for block error count. That's said,
> > on a quick look, it seems that the code is not right on many ways.
> > 
> > It should be aligned with the amount of data it is required for
> > dib7000 to update the block/bit error counters. There are two kinds
> > of implementation:
> > 
> > 1) the frontend has an internal counter that it is shifted and made
> >    available to the driver after a certain amount of received data
> >    (usually in the order of 10^5 to 10^7 bits);
> > 
> > 2) the frontend has an internal timer that shifts the data from its
> >    internal counter after a certain amount of time (usually at the
> >    seconds range).
> > 
> > Different vendors opt for either one of the strategy. Some updates
> > a counter with the amount of bits taken. Unfortunately, this is not
> > the case of those dib* frontends. So, the Kernel has to estimate
> > it, based on the tuning parameters.
> > 
> > From the code, it seems that, for block errors, it waits for 1,250,000
> > bits to arrive (e. g. about 766 packets), so, it uses type (1) strategy:
> > 
> >                 /* Estimate the number of packets based on bitrate */
> >                 if (!time_us)
> >                         time_us = dib7000p_get_time_us(demod);
> > 
> >                 if (time_us) {
> >                         blocks = 1250000ULL * 1000000ULL;	// the multiply here is to convert to microsseconds...
> >                         do_div(blocks, time_us * 8 * 204);	// As here it divides by the time in microsseconds
> >                         c->block_count.stat[0].scale = FE_SCALE_COUNTER;
> >                         c->block_count.stat[0].uvalue += blocks;
> >                 }
> > 
> > For BER, the logic assumes that the bit error count should be divided
> > by 10^-8:
> > 
> >                 c->post_bit_count.stat[0].uvalue += 100000000;
> > 
> > and the counter is updated every second. So, it uses (2).
> >   
> > > 
> > > Wondering if it has the same bug, it seems it does not:
> > > drivers/media/dvb-frontends/dib8000.c#dib8000_get_time_us():3986
> > > 
> > > dib8000_get_time_us() seems to loop over multiple layers, and then
> > > assigns interleaving to the final layers interleaving (that looks like
> > > loop invariant code to me).
> > > 
> > > Mauro, should dib7000p_get_time_us() use c->layer[???].interleaving?  
> > 
> > I don't think that time interleaving would affect the bit rate.
> > I suspect that the dead code on dib8000 is just a dead code.
> >   
> > > I don't see a single reference to `layer` in
> > > drivers/media/dvb-frontends/dib7000p.c.  
> > 
> > Layers are specific for ISDB-T, but I think DVB-T (or at least DVB-T2)
> > may use time interleaving. 
> > 
> > Yet, as I said, the goal is to estimate the streaming bit rate. 
> > 
> > I don't remember anymore from where the dib8000 formula came.
> > 
> > My guts tell that time interleaving shouldn't do much changes (if any)
> > to the bit rate. I suspect that removing the dead code is likely
> > OK, but I'll try to see if I can find something related to where this
> > formula came.  
> 
> So we have two issues. One is the clang issue and clearly the code needs
> fixing up. The second issue is that we're not sure about the algorithm;
> I've been reading up on mpeg-ts but I'm not anywhere near getting to an
> answer on this.
> 
> How about we merge a patch which just fixes the clang issue and leave
> the rest of the code as-is for now?

I'm ok with that, but it would be better to add a FIXME note somewhere.

> 
> Thanks,
> 
> Sean
> 
> ---
> From c6e4c5f514c38511d2054c69f7b103e98c520af4 Mon Sep 17 00:00:00 2001
> From: Sean Young <sean@mess.org>
> Date: Tue, 4 Dec 2018 09:59:10 +0000
> Subject: [PATCH v2] media: dib7000p: Remove dead code
> 
> Clang warns that 'interleaving' is assigned to itself in this function.
> 
> drivers/media/dvb-frontends/dib7000p.c:1874:15: warning: explicitly
> assigning value of variable of type 'int' to itself [-Wself-assign]
>         interleaving = interleaving;
>         ~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
> 1 warning generated.
> 
> Just remove the self-assign and leave existing code in place for now.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/media/dvb-frontends/dib7000p.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
> index 58387860b62d..cd84320c61c9 100644
> --- a/drivers/media/dvb-frontends/dib7000p.c
> +++ b/drivers/media/dvb-frontends/dib7000p.c
> @@ -1871,8 +1871,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
>  		break;
>  	}
>  
> -	interleaving = interleaving;
> -
>  	denom = bits_per_symbol * rate_num * fft_div * 384;

something like:

	/* 
	 * FIXME: check if the math makes sense. If so, fill the
	 * interleaving var.
	 */
>  
>  	/* If calculus gets wrong, wait for 1s for the next stats */



Thanks,
Mauro
