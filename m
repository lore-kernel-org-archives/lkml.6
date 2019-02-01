Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D919E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0odsBFkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfBALDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:03:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44228 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfBALDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:03:10 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so5309899iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrPb7VH8euHcrGaQyjRXK3k9fqMcYbYi1MMm8EGa/TY=;
        b=0odsBFkMi4xt7zVXA3B4ishnkDjidNB1MWFWGc5GbKhDaXUroz8Wau4yH3KPqVx+HD
         TWPxw97f7StiinOS6ffsdEu/r4FWBRK2aFfusoUmrsm2u2docEd+1rRJ+AT9bXlFUDD3
         wgNjaSNKlH+yI5nNqzBRmrzObKp/hnH/+sN8nVBkt0jystoGWGephXsi1CgOzfagCkIc
         6fNbiocnl7H34256gVVUcm0BEaRz8IFz1oLur3z077Pi1LXZWsqUqR8u5pi44RAMiseJ
         FbajzM0xXqC3SoUbwxk0P9knj9QPbK8cDxpyWAmTVbKgpLeKo2n93C07nwn0Y9LW0yqt
         iaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrPb7VH8euHcrGaQyjRXK3k9fqMcYbYi1MMm8EGa/TY=;
        b=KXL+eta09CUD+uhZ5VIotAyLWwl1kbS4fbY4mDqvTvcgFVVNc/phX5nAWKGPvKBcB8
         WLtcRFSOifHrX05nNF2WVCLoicJwnb4nPp65vLmRzXbmbl/dC6/n603lSmBw5cWeE6iB
         lNUaH4Mes4/amN/dcvgsTty17skEZM7Lpuo02l7PH4IfFhaj2Q/d/oLETWhLmP4iqtCF
         K0yGOBPWnA+bj/8HLUD63sGRgj/E68LFPU60AVvC5L5OAtVpe6G/bwc1hzJbSBMOp5zy
         Y3Sy14rFPklTPz1K60I4cnTF273dNHNZDDuekTwnBSUn93hzp4PR1116eaJD/slzFTO9
         X7GA==
X-Gm-Message-State: AHQUAuaRvbVbHnTfBJkF29o7ZcE4TcTCn4GG5aRjlpqjlDBZ8rZGLCh2
        T0YJerzVJuCp96OWPHd0XwsqD3jyZxvGZvyT8quz7g==
X-Google-Smtp-Source: AHgI3IbZzae4Qym3bnQH48nrLJHRznuS4bbcLQcmQ4SfELK/KG4Br3NAREQxnqrEAK5KHWOouGj+Apgtli7OzcQNhWk=
X-Received: by 2002:a5d:928b:: with SMTP id s11mr24670804iom.111.1549018989097;
 Fri, 01 Feb 2019 03:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-4-brgl@bgdev.pl>
 <20190129090706.33wcxb6d2c64yx7c@pengutronix.de> <CAMRc=Me6bGaGiiwvGNXbcr+fxarYsrgH-3MhQpSKjOjKQ6BtTw@mail.gmail.com>
 <20190129125525.ahgiwaftubs3tlog@pengutronix.de>
In-Reply-To: <20190129125525.ahgiwaftubs3tlog@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Feb 2019 12:02:58 +0100
Message-ID: <CAMRc=MeyozpMhVMA5tFc9d3V17guu78WAX5_3=iYr22SW-kJPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 29 sty 2019 o 13:55 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Tue, Jan 29, 2019 at 12:01:37PM +0100, Bartosz Golaszewski wrote:
> > wt., 29 sty 2019 o 10:07 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > Hello Bartosz,
> > >
> > > On Tue, Jan 29, 2019 at 09:44:05AM +0100, Bartosz Golaszewski wrote:
> > > > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > > > +void irq_sim_fire_type(struct irq_sim *sim,
> > > > +                    unsigned int offset, unsigned int type)
> > > >  {
> > > >       struct irq_sim_irq_ctx *ctx =3D irq_sim_get_ctx(sim, offset);
> > > >
> > > > -     if (ctx->enabled) {
> > > > +     /* Only care about relevant flags. */
> > > > +     type &=3D IRQ_TYPE_SENSE_MASK;
> > > > +
> > > > +     if (ctx->enabled && (ctx->type & type)) {
> > > >               set_bit(offset, sim->work_ctx.pending);
> > > >               irq_work_queue(&sim->work_ctx.work);
> > > >       }
> > > >  }
> > > > -EXPORT_SYMBOL_GPL(irq_sim_fire);
> > > > +EXPORT_SYMBOL_GPL(irq_sim_fire_type);
> > >
> > > This looks better than the previous variant. I wonder if it would be
> > > still more sensible to have type only in the mockup driver. But I don=
't
> > > have the complete picture here and it might be easier this way.
> > >
> >
> > I'm afraid I don't follow. Wasn't that the way it was done in v1?
>
> No, in v1 you already had "type" in the irq_sim driver and the logic if
> the irq should trigger in mockup. My wondering is about having both in
> the mockup driver.
>
> Then you have the tracking of the line's level and the logic if it should
> trigger an irq in a single place.
>
> But as I said, I'm not sure if this is better than your proposed
> solution in v2.
>

I think this a good compromise in case some other user would need it.
If there are no major objections to it, I'd like to keep it that way.

Bart
