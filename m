Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D75021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R0AF+Bmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBLJTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:19:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43509 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:19:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so3203032ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2uLupT1QQwxU8AFl9JvO1v3r42Gob4IGk4YOh/TsaI4=;
        b=R0AF+Bmwxp3KBazX0Iuu+wUwr/1rd94g6SrNjDtg/TZwFGcKKq7+C3jZp54LWKiHUG
         Aplm3c3YiDnikHPE0W0y4AumVQF0Uz/n7SaG+N50jes/RoOIP7bwDd7B07ucz0ucY78G
         sD4P2s/1vXMHw1lb4bF4TXK8hGATFH2VsJq4de6hF1YkA7rRrjbK7UfsHrbJKk7Y78vG
         M20DUOPXMKhDV7//R34TiwLtfmR/Jsxpk/Y6dQ1UDSQwhmZUz/HSkisemSkJfqMyOa6j
         hQSEPZ/yEHlyslv8uA4WAM2v8L/5anVWF7P3AtUjTyP61I1+roqSyRNvBat6p2+kMB1G
         m3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2uLupT1QQwxU8AFl9JvO1v3r42Gob4IGk4YOh/TsaI4=;
        b=VYwc5bIToYVbXGhjepk4wEsMh5gmcikQ77S6sZvva+FuCsU6FYkWFcepMThbrJmR73
         2TK57NUs67X+Pgaomij01bXf7aUaTPMw81NRNZN8J3FEUujMPNvLDTldQLIjd2eS+Sgi
         Cdvh3bwEFGgRQW9sbBWGB1Aqo6UkKGXGiFTh+rsFAQE8cbW9NAyX00PWRcUHSvf9fhh3
         9faiZVmHVnMJwsqQBLn+PbdfWOLp5EJ7lHeaIR3Pqw3sQmHcgjh1QO7jSYpeiPBIZzRE
         RLl4S5Ls9SH39EP6acK6Z4qr5+Ipk2q8WHLmm/rtIdEXdFg79295jNZNwWaa8gRC13F8
         uMBQ==
X-Gm-Message-State: AHQUAuapc08lVSPC6YmQ/8vrd9iv/y8CX4RZnqEOvDZcY9zwKFDyDcKX
        VXWXnmdSylx70mFkPgPL9DTCjzy2lXmR3MBH71d8MA==
X-Google-Smtp-Source: AHgI3IbZ6KvFbpulYeVakIpeJFF3D8jLJqoKIvE4saDnSAK2oF7kh+0DhgnuORlJXZPiCQHdETc85Aa9/u8xV8pzhFU=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr2688993ote.234.1549963170895;
 Tue, 12 Feb 2019 01:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com>
In-Reply-To: <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Feb 2019 10:19:20 +0100
Message-ID: <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 10:10 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(a=
):
>
> On 29/01/2019 08:44, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Provide a more specialized variant of irq_sim_fire() that allows to
> > specify the type of the fired interrupt. The type is stored in the
> > dummy irq context struct via the set_type callback.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  include/linux/irq_sim.h |  9 ++++++++-
> >  kernel/irq/irq_sim.c    | 26 ++++++++++++++++++++++----
> >  2 files changed, 30 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > index b96c2f752320..647a6c8ffb31 100644
> > --- a/include/linux/irq_sim.h
> > +++ b/include/linux/irq_sim.h
> > @@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
> >
> >  struct irq_sim_irq_ctx {
> >       bool                    enabled;
> > +     unsigned int            type;
> >  };
> >
> >  struct irq_sim {
> > @@ -37,7 +38,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int n=
um_irqs);
> >  int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
> >                     unsigned int num_irqs);
> >  void irq_sim_fini(struct irq_sim *sim);
> > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
> > +void irq_sim_fire_type(struct irq_sim *sim,
> > +                    unsigned int offset, unsigned int type);
> >  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
> >
> > +static inline void irq_sim_fire(struct irq_sim *sim, unsigned int offs=
et)
> > +{
> > +     irq_sim_fire_type(sim, offset, IRQ_TYPE_DEFAULT);
> > +}
> > +
> >  #endif /* _LINUX_IRQ_SIM_H */
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index 2bcdbab1bc5a..e3160b5e59b8 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *data)
> >       irq_ctx->enabled =3D true;
> >  }
> >
> > +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
> > +{
> > +     struct irq_sim_irq_ctx *irq_ctx =3D irq_data_get_irq_chip_data(da=
ta);
> > +
> > +     irq_ctx->type =3D type;
> > +
> > +     return 0;
> > +}
> > +
> >  static void irq_sim_handle_irq(struct irq_work *work)
> >  {
> >       struct irq_sim_work_ctx *work_ctx;
> > @@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int =
num_irqs)
> >       sim->chip.name =3D "irq_sim";
> >       sim->chip.irq_mask =3D irq_sim_irqmask;
> >       sim->chip.irq_unmask =3D irq_sim_irqunmask;
> > +     sim->chip.irq_set_type =3D irq_sim_set_type;
> >
> >       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> >       if (!sim->work_ctx.pending) {
> > @@ -192,21 +202,29 @@ irq_sim_get_ctx(struct irq_sim *sim, unsigned int=
 offset)
> >  }
> >
> >  /**
> > - * irq_sim_fire - Enqueue an interrupt.
> > + * irq_sim_fire_type - Enqueue an interrupt.
> >   *
> >   * @sim:        The interrupt simulator object.
> >   * @offset:     Offset of the simulated interrupt which should be fire=
d.
> > + * @type:    Type of the fired interrupt. Must be one of the following=
:
> > + *           IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING,
> > + *           IRQ_TYPE_EDGE_BOTH, IRQ_TYPE_LEVEL_HIGH,
> > + *           IRQ_TYPE_LEVEL_LOW, IRQ_TYPE_DEFAULT
> >   */
> > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > +void irq_sim_fire_type(struct irq_sim *sim,
> > +                    unsigned int offset, unsigned int type)
> >  {
> >       struct irq_sim_irq_ctx *ctx =3D irq_sim_get_ctx(sim, offset);
> >
> > -     if (ctx->enabled) {
> > +     /* Only care about relevant flags. */
> > +     type &=3D IRQ_TYPE_SENSE_MASK;
> > +
> > +     if (ctx->enabled && (ctx->type & type)) {
>
> I wonder how realistic this is, given that you do not track the release
> of a level. In short, mo matter what the type is, you treat everything
> as edge.
>
> What is the point of this?
>

When userspace wants to monitor GPIO line interrupts, the GPIO
framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
IRQF_TRIGGER_RISING or both. The testing module tries to act like real
hardware and so if we pass only one of the *_TRIGGER_* flags, we want
the simulated interrupt of corresponding type to be fired.

Another solution - if you don't like this one -  would be to have more
specialized functions: irq_sim_fire_rising() and
irq_sim_fire_falling(). How about that?

Bart

> >               set_bit(offset, sim->work_ctx.pending);
> >               irq_work_queue(&sim->work_ctx.work);
> >       }
> >  }
> > -EXPORT_SYMBOL_GPL(irq_sim_fire);
> > +EXPORT_SYMBOL_GPL(irq_sim_fire_type);
> >
> >  /**
> >   * irq_sim_irqnum - Get the allocated number of a dummy interrupt.
> >
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
