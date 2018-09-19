Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF115C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B372151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9hCEzTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B372151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeITAeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39269 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbeITAet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so105945pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZL4gfyy9fnDJwzPepvkdkBntNmOPRKo1AATrHJHZ8Q=;
        b=I9hCEzThovmipZc4V6WY/QoOxEUyTi1CDYa1qVevTe/VJA32gqwCxsqv9bOjg/U6Xn
         J1mD5ddIWlg6RgkrwNuKkbLNkYpg1gb/BNjUOh5XQ5+9Iv6pVtCIi9LOTHqoNwsd0REl
         ooXjMo31aU47biLg3j4u0e53bLbztZpTmg3aAWnoFFDRRhYnO8spgvXoluJGx2ha+4cA
         6x+M9/D0DuX3FHSMgOOL52MhxbR4myedrWayuVVJg80bXKwBgqW9Pq5XsjK0Lxjo+QVE
         02opNghElAO8gNeC2MH/SGxOT6lURCAoWij2T3EUQvqVZElb6yt6gy3r/dMp0Ypzb2ee
         hGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZL4gfyy9fnDJwzPepvkdkBntNmOPRKo1AATrHJHZ8Q=;
        b=rZpXfAmoz7KjOkL15SO+N1XKliwqLQJ7kk45eQ5ugIi9g0tFtQEiB7cW4hiKDHDr17
         puMP0A6/bFUEz1rRQjFu6XbmrD37m138rXXaE0Oxz3Msl9Nvzqt1HffWPsHww9b/hrYh
         TXuVW1k+Z/lmp2QtYj4WUA6bhUVDRuhs9YKVXQ10mfnyLF0gDlKb4rxRvids2kqYpm6L
         0YueG2F0sacgxtSkb7AIJ+KK2F8eNX1UqwgwPCvmpXPWy4aGmBDeBCatUVDpc6v4drOV
         ekH1jwrfWCNoJ6YbCSUZaKcn5isUoTDVPUr2Vp5fb0ceeidt3VSdd0IDb+wRCUxtQa0q
         jX3g==
X-Gm-Message-State: APzg51CcypoltH0OmRQU8g9jVw61ileeOLI+mNR3x2nYyh0XrCnhm8I4
        fTsgLNpuqgnsgILMayzL0GO3Wt4W3/s7QzT+4QaEJA==
X-Google-Smtp-Source: ANB0VdbBII81Or/c/+VTMIWxkLAOhrtJYu95hKHX15N1WGt4tOmujKTPcKOarxwEBsNRj6cpOfqacF0ULxFfdBklfg0=
X-Received: by 2002:a63:c245:: with SMTP id l5-v6mr33679929pgg.255.1537383334041;
 Wed, 19 Sep 2018 11:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180915054739.14117-1-natechancellor@gmail.com>
 <CAKwvOdmQ4pbbPuvYrVYB9myD8ap36h6nLjEdL-mSbYjM37UJ_g@mail.gmail.com> <20180917193936.33e90d5a@coco.lan>
In-Reply-To: <20180917193936.33e90d5a@coco.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 11:55:21 -0700
Message-ID: <CAKwvOdne+wYiK7Zek5teGz5JsAjQq+i8g+rjf2-L05c_AuXKEg@mail.gmail.com>
Subject: Re: [PATCH] [media] dib7000p: Remove dead code
To:     mchehab+samsung@kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 3:39 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
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
>                         blocks = 1250000ULL * 1000000ULL;       // the multiply here is to convert to microsseconds...
>                         do_div(blocks, time_us * 8 * 204);      // As here it divides by the time in microsseconds
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

Thanks for the detailed feedback.  If you find no other references,
then I assume this version of the patch is good to go.

>
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



-- 
Thanks,
~Nick Desaulniers
