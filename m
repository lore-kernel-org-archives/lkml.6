Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979C920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRiOWuwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979C920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJZCnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:43:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:43:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so2460293wma.4;
        Thu, 25 Oct 2018 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+cxPkbpKfADHvJ29kZRwQRMCY4jLKARDRApEhm6PUA=;
        b=BRiOWuwiNHNheRWGvz2xPyejTnf9Ats25A4P6glwcvW7QkR8kumc8nt5Y4L0UQqNlq
         2t3XxtwKKM3bMUYuS2P8hjB1esh6RU5R2B8ldlsUitFzZid11RNkPXQS1zBA1wI63lD6
         7T8FK367TTMtWAD2EVEFeZnpjxyga87vr5r3OTErlzmPUJHIxPspNlkoRrf8jmUVgLDY
         0lgX1tpynT9zxE+HIOvWgf+xj/TWCbakvj0fd2VdinLdEQq9tSp18Tfoi+5/5saGE4Wa
         u3k1voL+zpyRnHptIwMRbU4jZ17SMbbgWQGIY7ARh7js+O+g/taP0FM9C6dcHgbQQ5nH
         gd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+cxPkbpKfADHvJ29kZRwQRMCY4jLKARDRApEhm6PUA=;
        b=tPAqAFTJfvIHRLsM54KKf5MXN8LjAQeKp8hNWebv8XBm+MDrccZOo+7APRaF4Nl5Zd
         vXuAkEX+JA1S5Y5124N2bBJNHSiAukJ2zs0BD6fbmPd793t/XC+mPC2quX4ZtJR2xo0X
         QXqpuksijPsbEgnjOlB88NPA6I4Ubop0YjZlEtb/t0gbo8M7fUUw+dFKrHO5gWE1vuut
         CQd8jroIyW8PpbgN7gCkiTSwSM03Me7N8EqtsDErVnIF8j2pFW9ibReriv3p4T3w/mgI
         vGfEC/A/sK8EVKNLnrMlYqZATZt4gsaaLiW+lqYhSvcU6bliLsOH2pj29tP/ueT7QJh1
         N1bg==
X-Gm-Message-State: AGRZ1gI5S2kGoVGolusCo0+0gyzqvf0FH9wp4r0DPriisnXcU4voDkHB
        eycLB7UN81WgO9pujWiVNbXLjwm0Dek=
X-Google-Smtp-Source: AJdET5dE0VB2SO98OavqJh2Q/66AK/yyuL8tuSrMWVUTy/S6mm/0Fwge/rsRcNJgJ/dGznk121ZAsQ==
X-Received: by 2002:a1c:870c:: with SMTP id j12-v6mr2976039wmd.40.1540490989168;
        Thu, 25 Oct 2018 11:09:49 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u191-v6sm2339415wmd.31.2018.10.25.11.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:09:47 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:09:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [media] dib7000p: Remove dead code
Message-ID: <20181025180945.GA28756@flashbox>
References: <20180915054739.14117-1-natechancellor@gmail.com>
 <CAKwvOdmQ4pbbPuvYrVYB9myD8ap36h6nLjEdL-mSbYjM37UJ_g@mail.gmail.com>
 <20180917193936.33e90d5a@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917193936.33e90d5a@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:39:36PM -0300, Mauro Carvalho Chehab wrote:
> Em Mon, 17 Sep 2018 10:58:32 -0700
> Nick Desaulniers <ndesaulniers@google.com> escreveu:
> 
> > On Fri, Sep 14, 2018 at 10:47 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns that 'interleaving' is assigned to itself in this function.
> > >
> > > drivers/media/dvb-frontends/dib7000p.c:1874:15: warning: explicitly
> > > assigning value of variable of type 'int' to itself [-Wself-assign]
> > >         interleaving = interleaving;
> > >         ~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
> > > 1 warning generated.
> > >
> > > It's correct. Just removing the self-assignment would sufficiently hide
> > > the warning but all of this code is dead because 'tmp' is zero due to
> > > being multiplied by zero. This doesn't appear to be an issue with
> > > dib8000, which this code was copied from in commit 041ad449683b
> > > ("[media] dib7000p: Add DVBv5 stats support").
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/media/dvb-frontends/dib7000p.c | 10 ++--------
> > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
> > > index 58387860b62d..25843658fc68 100644
> > > --- a/drivers/media/dvb-frontends/dib7000p.c
> > > +++ b/drivers/media/dvb-frontends/dib7000p.c
> > > @@ -1800,9 +1800,8 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)  
> > 
> > Something looks wrong here (with this function).  The patch is no
> > functional change, since as you point out `interleaving` is
> > initialized to 0, then never updated before read, but I think there's
> > an underlying bug here that should be fixed differently.  Thanks for
> > the patch though, as it does raise the question.
> > 
> > dib7000p_get_time_us has this comment above it:
> > 
> >   1798 /* FIXME: may require changes - this one was borrowed from
> > dib8000 */
> 
> The goal of dib7000p_get_time_us() is to estimate how much time it
> takes, with current tuning parameters, to have a certain number of
> DVB-T packets. This is used for block error count. That's said,
> on a quick look, it seems that the code is not right on many ways.
> 
> It should be aligned with the amount of data it is required for
> dib7000 to update the block/bit error counters. There are two kinds
> of implementation:
> 
> 1) the frontend has an internal counter that it is shifted and made
>    available to the driver after a certain amount of received data
>    (usually in the order of 10^5 to 10^7 bits);
> 
> 2) the frontend has an internal timer that shifts the data from its
>    internal counter after a certain amount of time (usually at the
>    seconds range).
> 
> Different vendors opt for either one of the strategy. Some updates
> a counter with the amount of bits taken. Unfortunately, this is not
> the case of those dib* frontends. So, the Kernel has to estimate
> it, based on the tuning parameters.
> 
> From the code, it seems that, for block errors, it waits for 1,250,000
> bits to arrive (e. g. about 766 packets), so, it uses type (1) strategy:
> 
>                 /* Estimate the number of packets based on bitrate */
>                 if (!time_us)
>                         time_us = dib7000p_get_time_us(demod);
> 
>                 if (time_us) {
>                         blocks = 1250000ULL * 1000000ULL;	// the multiply here is to convert to microsseconds...
>                         do_div(blocks, time_us * 8 * 204);	// As here it divides by the time in microsseconds
>                         c->block_count.stat[0].scale = FE_SCALE_COUNTER;
>                         c->block_count.stat[0].uvalue += blocks;
>                 }
> 
> For BER, the logic assumes that the bit error count should be divided
> by 10^-8:
> 
>                 c->post_bit_count.stat[0].uvalue += 100000000;
> 
> and the counter is updated every second. So, it uses (2).
> 
> > 
> > Wondering if it has the same bug, it seems it does not:
> > drivers/media/dvb-frontends/dib8000.c#dib8000_get_time_us():3986
> > 
> > dib8000_get_time_us() seems to loop over multiple layers, and then
> > assigns interleaving to the final layers interleaving (that looks like
> > loop invariant code to me).
> > 
> > Mauro, should dib7000p_get_time_us() use c->layer[???].interleaving?
> 
> I don't think that time interleaving would affect the bit rate.
> I suspect that the dead code on dib8000 is just a dead code.
> 
> > I don't see a single reference to `layer` in
> > drivers/media/dvb-frontends/dib7000p.c.
> 
> Layers are specific for ISDB-T, but I think DVB-T (or at least DVB-T2)
> may use time interleaving. 
> 
> Yet, as I said, the goal is to estimate the streaming bit rate. 
> 
> I don't remember anymore from where the dib8000 formula came.
> 
> My guts tell that time interleaving shouldn't do much changes (if any)
> to the bit rate. I suspect that removing the dead code is likely
> OK, but I'll try to see if I can find something related to where this
> formula came.
> 

Hi Mauro,

Were you able to find anything related to that formula? If not, is this
patch acceptable?

Thanks!
Nathan

> > 
> > >  {
> > >         struct dtv_frontend_properties *c = &demod->dtv_property_cache;
> > >         u64 time_us, tmp64;
> > > -       u32 tmp, denom;
> > > -       int guard, rate_num, rate_denum = 1, bits_per_symbol;
> > > -       int interleaving = 0, fft_div;
> > > +       u32 denom;
> > > +       int guard, rate_num, rate_denum = 1, bits_per_symbol, fft_div;
> > >
> > >         switch (c->guard_interval) {
> > >         case GUARD_INTERVAL_1_4:
> > > @@ -1871,8 +1870,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
> > >                 break;
> > >         }
> > >
> > > -       interleaving = interleaving;
> > > -
> > >         denom = bits_per_symbol * rate_num * fft_div * 384;
> > >
> > >         /* If calculus gets wrong, wait for 1s for the next stats */
> > > @@ -1887,9 +1884,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
> > >         time_us += denom / 2;
> > >         do_div(time_us, denom);
> > >
> > > -       tmp = 1008 * 96 * interleaving;
> > > -       time_us += tmp + tmp / guard;
> > > -
> > >         return time_us;
> > >  }
> > >
> > > --
> > > 2.18.0
> > >  
> > 
> > 
> 
> 
> 
> Thanks,
> Mauro
