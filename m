Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C29ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A382147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l2v+XxR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A382147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeIREJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:09:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIREJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NG2/lZRrjall5ytcKP/USx9pTn+syVwQEtXZB0iuayg=; b=l2v+XxR1D/EkfrqSztzJjBpWg
        S6fdsJ2cRfqXig84hYpnVOHgTh4Qta/JoL6EYcQ5zKXW+ImT/cG6ux3s+AH4HSnxAuMjexVTYKfaE
        WRxgdY9wKkPsZ05LpEFnZ4KOPmmU4DBHatQl5VtN4mqvHQXuz9JpgLkawpZfcwRriAd4BKac+jZln
        jKrYPa3PCVU3JYecoK3eK9orBFHQ1qyKjEYw1hHOJoFyUz6SU//vI97/xagS8RjBlBzbNA3bXmNFv
        WVHXmIiDmi1Kpt+G3MLbhbAKiM3qXtQ79dFibtqdJFQ/NZEpiSDEmXzxFoh+Qb1g4OofXZ/uRRK6M
        H7txjyYoQ==;
Received: from 177.96.206.239.dynamic.adsl.gvt.net.br ([177.96.206.239] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g22BA-000426-Ly; Mon, 17 Sep 2018 22:39:41 +0000
Date:   Mon, 17 Sep 2018 19:39:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [media] dib7000p: Remove dead code
Message-ID: <20180917193936.33e90d5a@coco.lan>
In-Reply-To: <CAKwvOdmQ4pbbPuvYrVYB9myD8ap36h6nLjEdL-mSbYjM37UJ_g@mail.gmail.com>
References: <20180915054739.14117-1-natechancellor@gmail.com>
        <CAKwvOdmQ4pbbPuvYrVYB9myD8ap36h6nLjEdL-mSbYjM37UJ_g@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 17 Sep 2018 10:58:32 -0700
Nick Desaulniers <ndesaulniers@google.com> escreveu:

> On Fri, Sep 14, 2018 at 10:47 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns that 'interleaving' is assigned to itself in this function.
> >
> > drivers/media/dvb-frontends/dib7000p.c:1874:15: warning: explicitly
> > assigning value of variable of type 'int' to itself [-Wself-assign]
> >         interleaving =3D interleaving;
> >         ~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
> > 1 warning generated.
> >
> > It's correct. Just removing the self-assignment would sufficiently hide
> > the warning but all of this code is dead because 'tmp' is zero due to
> > being multiplied by zero. This doesn't appear to be an issue with
> > dib8000, which this code was copied from in commit 041ad449683b
> > ("[media] dib7000p: Add DVBv5 stats support").
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/media/dvb-frontends/dib7000p.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb=
-frontends/dib7000p.c
> > index 58387860b62d..25843658fc68 100644
> > --- a/drivers/media/dvb-frontends/dib7000p.c
> > +++ b/drivers/media/dvb-frontends/dib7000p.c
> > @@ -1800,9 +1800,8 @@ static u32 dib7000p_get_time_us(struct dvb_fronte=
nd *demod) =20
>=20
> Something looks wrong here (with this function).  The patch is no
> functional change, since as you point out `interleaving` is
> initialized to 0, then never updated before read, but I think there's
> an underlying bug here that should be fixed differently.  Thanks for
> the patch though, as it does raise the question.
>=20
> dib7000p_get_time_us has this comment above it:
>=20
>   1798 /* FIXME: may require changes - this one was borrowed from
> dib8000 */

The goal of dib7000p_get_time_us() is to estimate how much time it
takes, with current tuning parameters, to have a certain number of
DVB-T packets. This is used for block error count. That's said,
on a quick look, it seems that the code is not right on many ways.

It should be aligned with the amount of data it is required for
dib7000 to update the block/bit error counters. There are two kinds
of implementation:

1) the frontend has an internal counter that it is shifted and made
   available to the driver after a certain amount of received data
   (usually in the order of 10^5 to 10^7 bits);

2) the frontend has an internal timer that shifts the data from its
   internal counter after a certain amount of time (usually at the
   seconds range).

Different vendors opt for either one of the strategy. Some updates
a counter with the amount of bits taken. Unfortunately, this is not
the case of those dib* frontends. So, the Kernel has to estimate
it, based on the tuning parameters.

=46rom the code, it seems that, for block errors, it waits for 1,250,000
bits to arrive (e. g. about 766 packets), so, it uses type (1) strategy:

                /* Estimate the number of packets based on bitrate */
                if (!time_us)
                        time_us =3D dib7000p_get_time_us(demod);

                if (time_us) {
                        blocks =3D 1250000ULL * 1000000ULL;	// the multiply=
 here is to convert to microsseconds...
                        do_div(blocks, time_us * 8 * 204);	// As here it di=
vides by the time in microsseconds
                        c->block_count.stat[0].scale =3D FE_SCALE_COUNTER;
                        c->block_count.stat[0].uvalue +=3D blocks;
                }

For BER, the logic assumes that the bit error count should be divided
by 10^-8:

                c->post_bit_count.stat[0].uvalue +=3D 100000000;

and the counter is updated every second. So, it uses (2).

>=20
> Wondering if it has the same bug, it seems it does not:
> drivers/media/dvb-frontends/dib8000.c#dib8000_get_time_us():3986
>=20
> dib8000_get_time_us() seems to loop over multiple layers, and then
> assigns interleaving to the final layers interleaving (that looks like
> loop invariant code to me).
>=20
> Mauro, should dib7000p_get_time_us() use c->layer[???].interleaving?

I don't think that time interleaving would affect the bit rate.
I suspect that the dead code on dib8000 is just a dead code.

> I don't see a single reference to `layer` in
> drivers/media/dvb-frontends/dib7000p.c.

Layers are specific for ISDB-T, but I think DVB-T (or at least DVB-T2)
may use time interleaving.=20

Yet, as I said, the goal is to estimate the streaming bit rate.=20

I don't remember anymore from where the dib8000 formula came.

My guts tell that time interleaving shouldn't do much changes (if any)
to the bit rate. I suspect that removing the dead code is likely
OK, but I'll try to see if I can find something related to where this
formula came.

>=20
> >  {
> >         struct dtv_frontend_properties *c =3D &demod->dtv_property_cach=
e;
> >         u64 time_us, tmp64;
> > -       u32 tmp, denom;
> > -       int guard, rate_num, rate_denum =3D 1, bits_per_symbol;
> > -       int interleaving =3D 0, fft_div;
> > +       u32 denom;
> > +       int guard, rate_num, rate_denum =3D 1, bits_per_symbol, fft_div;
> >
> >         switch (c->guard_interval) {
> >         case GUARD_INTERVAL_1_4:
> > @@ -1871,8 +1870,6 @@ static u32 dib7000p_get_time_us(struct dvb_fronte=
nd *demod)
> >                 break;
> >         }
> >
> > -       interleaving =3D interleaving;
> > -
> >         denom =3D bits_per_symbol * rate_num * fft_div * 384;
> >
> >         /* If calculus gets wrong, wait for 1s for the next stats */
> > @@ -1887,9 +1884,6 @@ static u32 dib7000p_get_time_us(struct dvb_fronte=
nd *demod)
> >         time_us +=3D denom / 2;
> >         do_div(time_us, denom);
> >
> > -       tmp =3D 1008 * 96 * interleaving;
> > -       time_us +=3D tmp + tmp / guard;
> > -
> >         return time_us;
> >  }
> >
> > --
> > 2.18.0
> > =20
>=20
>=20



Thanks,
Mauro
