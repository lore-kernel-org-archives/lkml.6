Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09171C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C179C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CqzK4RBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C179C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeKVDJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:09:53 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37244 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbeKVDJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:09:53 -0500
Received: by mail-io1-f67.google.com with SMTP id a3so4508868ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lw7aSLQudTUlj95EBrw2GbSBIKWK7CVyT8TuTdPbfP4=;
        b=CqzK4RBlI26hDiq7za8yAPgJGjTxP3tkkDjsBIV/A1lKbNq5dLbPH1OHiga+RapN0J
         tutRAtNQYqRpgjJ3gf2KOHTBtg1UzL64oVL2qVDXL77d6PVCNK/CL1RbkX0/6fOMnzYh
         JPhb0qXp0TYL6KG6UguCHFR5vMMTXiedEclhddNKwQ3rY8595ZhZguZB8zwXe4FUlUBv
         nhtMZuj/UdvjJB550/SoB6gVfdXk1zrlI2pIZ+ULzVYH583ExmsQR27Zh5FdqlzFaHII
         /Dxg1aL1yuI3csPmanZzXC3XZiSeYGBtTds9rvYI7uAnZX9JmweDc0/vX6yOr5FR93dk
         jjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lw7aSLQudTUlj95EBrw2GbSBIKWK7CVyT8TuTdPbfP4=;
        b=srH2aKiIvnBKcdfIL/bYW/EaoigyrkhF/tblRAbFr0YqMyGNSzNXS+YdM2pyWdsU6B
         k2AZS1poOgYtYsLc8b5jnAcdqzrLjKny5LAG2xWh5rgGYNY8J7fR00k34Ar0tvhNhHby
         3DHOPVAZY8USVY+la5oisUohJ5Z4eH31A2FLJob5MThiyhObpkwZXrdlqMf4k5G13Uze
         MpSiD59GI+QLPGvrEXT05jUWmwlulvQZCX67jGexBs0FOfBufM5RCBf24ExBXo1HhBwR
         apvtebjj2IfdH5irfS92qAI31d2VAw8X1IgIGvL06mPwxzHLAW5deB/fXa23ZzPP7pSJ
         g7DQ==
X-Gm-Message-State: AA+aEWYuT9X9M4+Li2yOXvlxyGscdJ4V3M6krCEwKz8aJ94Ckw6r4n8H
        EbjgyySkLMwlnSsXv7Z/t4BNR97UQCe05V6ExBf1L9G5
X-Google-Smtp-Source: AFSGD/VuqsqDJQzqW7bf9bCwnruAnT/fUf5qVhBh9T2AUeZVBzEsnVr217LYMlUxCaVHz8rFpwHCANled6AdWFH98DE=
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr5362688ioj.258.1542818083260;
 Wed, 21 Nov 2018 08:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de>
In-Reply-To: <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 21 Nov 2018 17:34:32 +0100
Message-ID: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 20 lis 2018 o 18:17 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Tue, Nov 20, 2018 at 02:40:31PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The irq_sim irqchip doesn't allow to configure the sensitivity so every
> > call to irq_sim_fire() fires a dummy interrupt. This used to not matter
> > for gpio-mockup (one of the irq_sim users) until commit fa38869b0161
> > ("gpiolib: Don't support irq sharing for userspace") which made it
> > impossible for gpio-mockup to ignore certain events (e.g. only receive
> > notifications about rising edge events).
> >
> > Introduce a specialized variant of irq_sim_fire() which takes another
> > argument called edge. allowing to specify the trigger type for the
> > dummy interrupt.
>
> I wonder if it's worth the effort to fix irq_sim. If you take a look in
> my gpio-simulator patch, it is trivial to get it right without external
> help with an amount of code that is usual for a driver that handles
> irqs.
>

You're basically recommending handcrafting another local piece of code
for simulating interrupts - something that multiple users may be
interested in. You did that in your proposed gpio-simulator and I
still can't understand why you couldn't reuse the existing solution.
Even if it's broken for your use-case, it's surely easier to fix it
than to rewrite and duplicate it? There are very few cases where code
consolidation is not a good thing and I don't think this is one of
them.

The interrupt simulator exists and is used by two testing drivers
currently. One of them needs some more flexibility and this is what
this patch is trying to add. I believe it is worth the effort.

Best regards,
Bartosz

> > @@ -161,12 +171,28 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> >   */
> >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> >  {
> > -     if (sim->irqs[offset].enabled) {
> > +     /* Don't care about the edge. */
> > +     irq_sim_fire_edge(sim, offset, IRQ_TYPE_EDGE_BOTH);
>
> Conceptually irq_sim_fire_edge should be defined above irq_sim_fire.
>
> > +EXPORT_SYMBOL_GPL(irq_sim_fire);
> > +
> > +/**
> > + * irq_sim_fire_edge - Enqueue an interrupt, specify the edge.
> > + *
> > + * @sim:        The interrupt simulator object.
> > + * @offset:     Offset of the simulated interrupt which should be fire=
d.
> > + * edge:        Edge of the interrupt (IRQ_TYPE_EDGE_RISING/FALLING).
> > + */
> > +void irq_sim_fire_edge(struct irq_sim *sim, unsigned int offset, int e=
dge)
> > +{
> > +     struct irq_sim_irq_ctx *irq =3D &sim->irqs[offset];
> > +
> > +     if (irq->enabled && (irq->edge & edge)) {
> >               set_bit(offset, sim->work_ctx.pending);
> >               irq_work_queue(&sim->work_ctx.work);
> >       }
> >  }
> > -EXPORT_SYMBOL_GPL(irq_sim_fire);
> > +EXPORT_SYMBOL_GPL(irq_sim_fire_edge);
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
