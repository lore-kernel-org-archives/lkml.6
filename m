Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C19FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33F92080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oevr7aay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfBLI47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:56:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51509 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfBLI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:56:58 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so5408334itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Uh2RbxxbT1TL52BKAeNgU+q3ni8tSqBO595zFIBfVI=;
        b=oevr7aaygJE25Dhsr0Bwm/uYopqiSl4A2x+aQJ245JwREYgR3qloPqDVitg9UmBooM
         oQAWukZVHlESLuanPGZ3pFUC3AoOISD/+HAiIgPSGE+Mjxuy/a2iwIxzQed3zx9nMTSo
         nqNL8on/8O+Wsx5+wXnEd7ES3pbJPbOoGhrMe7JJpGDkGu9QuCLZGlej+yeG72pxsUmr
         WclmyAumtMG9gpMWXSr662IOpwPlGTs8swx0fao227PEQcj9KNC9m2/HfNvN0S4zvDjZ
         G5YvyjwWNwc8Ob98VLext/9IsBZXiJcZnH3cfBf3dGFHh2JJKGFCkxQ1knzW6NrdUdlS
         a27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Uh2RbxxbT1TL52BKAeNgU+q3ni8tSqBO595zFIBfVI=;
        b=LMYbLaWUxF5SsEKgUUneuVBxXDDENs7E1qdpVDrK9uhKwSmCBMP60XP2fo8c/gy1T6
         EMF0pu3ua0s09LaEZT4UmNFnaGw4e7S/8pvbLmYSyZD31z1ynZNZXCgUy7qKHMcvWggf
         0S15vBmmjRgq/xpKweBbiAMKP/9sJ9oUA/fDwuZHtSziRN2PgOU7IjXE17qNNflb+/Mp
         T9L84FNUTW+SgJskmbhFNDJiypkiR0qfY1znE33dVdgPbmM5szCRosngXmvwXD6CfV4o
         TkMxwTjkHeorJwq1VGlEgY+lW+zRqpLRCSlz4UYxDbi1Y4koiYiTdr8iFo2Q+IE0njix
         qDZQ==
X-Gm-Message-State: AHQUAua2wOgnB6SwHy0oIVB4MNnZfIVmtMZ/pJEieXly5ddJGYmgu7XD
        Vl5TJgRtCqlXsUpm+e68qaY3SL2xhZEOnH+n0EuZUA==
X-Google-Smtp-Source: AHgI3IbigNPsNOkWPNLThMW1+BGlSsuGy6fORkJpLPG7RUTFVug/FqpIhTVmRr+oDJDpZbatVdNmj+cWsC3TZgYkwu0=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr1414120ior.258.1549961817392;
 Tue, 12 Feb 2019 00:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-3-brgl@bgdev.pl>
 <20190211222610.42e9189b@why.wild-wind.fr.eu.org> <CAMpxmJXN0g10BMd1Mj1yx2_F6HuoKEyjHPoW+jS9pgmk-uNs8g@mail.gmail.com>
 <867ee5tmkz.wl-marc.zyngier@arm.com>
In-Reply-To: <867ee5tmkz.wl-marc.zyngier@arm.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 09:56:46 +0100
Message-ID: <CAMRc=Md8SvX8a-NBE7PrdZ+enZkn+LR1+XOmOZ6oyJUPp1T0cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] irq/irq_sim: use irq domain
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

wt., 12 lut 2019 o 09:53 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(a=
):
>
> Bartosz,
>
> On Tue, 12 Feb 2019 08:30:32 +0000,
> Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:
> >
> > pon., 11 lut 2019 o 23:26 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=
=82(a):
> > >
> > > On Tue, 29 Jan 2019 09:44:04 +0100
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Delegate the offset to virq number mapping to the provided framewor=
k
> > > > instead of handling it locally. Use the legacy domain as we want to
> > > > preallocate the irq descriptors.
> > >
> > > Why?
> > >
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  include/linux/irq_sim.h |  6 +--
> > > >  kernel/irq/irq_sim.c    | 94 +++++++++++++++++++++++++++++--------=
----
> > > >  2 files changed, 71 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > > > index eda132c22b57..b96c2f752320 100644
> > > > --- a/include/linux/irq_sim.h
> > > > +++ b/include/linux/irq_sim.h
> > > > @@ -8,6 +8,7 @@
> > > >
> > > >  #include <linux/irq.h>
> > > >  #include <linux/irq_work.h>
> > > > +#include <linux/irqdomain.h>
> > > >  #include <linux/device.h>
> > > >
> > > >  /*
> > > > @@ -21,16 +22,15 @@ struct irq_sim_work_ctx {
> > > >  };
> > > >
> > > >  struct irq_sim_irq_ctx {
> > > > -     int                     irqnum;
> > > >       bool                    enabled;
> > > >  };
> > > >
> > > >  struct irq_sim {
> > > >       struct irq_chip         chip;
> > > > +     struct irq_domain       *domain;
> > > >       struct irq_sim_work_ctx work_ctx;
> > > > -     int                     irq_base;
> > > > +     int                     virq_base;
> > > >       unsigned int            irq_count;
> > > > -     struct irq_sim_irq_ctx  *irqs;
> > > >  };
> > > >
> > > >  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
> > > > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > > > index b732e4e2e45b..2bcdbab1bc5a 100644
> > > > --- a/kernel/irq/irq_sim.c
> > > > +++ b/kernel/irq/irq_sim.c
> > > > @@ -44,6 +44,43 @@ static void irq_sim_handle_irq(struct irq_work *=
work)
> > > >       }
> > > >  }
> > > >
> > > > +static int irq_sim_domain_map(struct irq_domain *domain,
> > > > +                           unsigned int virq, irq_hw_number_t hw)
> > > > +{
> > > > +     struct irq_sim *sim =3D domain->host_data;
> > > > +     struct irq_sim_irq_ctx *ctx;
> > > > +
> > > > +     ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> > > > +     if (!ctx)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     irq_set_chip(virq, &sim->chip);
> > > > +     irq_set_chip_data(virq, ctx);
> > > > +     irq_set_handler(virq, handle_simple_irq);
> > >
> > > Consider using modern APIs such as irq_domain_set_info().
> > >
> > > > +     irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOP=
ROBE);
> > >
> > > Where is this requirement coming from?
> > >
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void irq_sim_domain_free(struct irq_domain *domain,
> > > > +                             unsigned int virq, unsigned int num_i=
rqs)
> > > > +{
> > > > +     struct irq_sim_irq_ctx *ctx;
> > > > +     struct irq_data *irq;
> > > > +     int i;
> > > > +
> > > > +     for (i =3D 0; i < num_irqs; i++) {
> > > > +             irq =3D irq_domain_get_irq_data(domain, virq + i);
> > > > +             ctx =3D irq_data_get_irq_chip_data(irq);
> > > > +             kfree(ctx);
> > > > +     }
> > > > +}
> > > > +
> > > > +static const struct irq_domain_ops irq_sim_domain_ops =3D {
> > > > +     .map =3D irq_sim_domain_map,
> > > > +     .free =3D irq_sim_domain_free,
> > >
> > > The intended use of the v2 API is to have alloc and free as a pair, a=
nd
> > > no map. So please choose which version of the API you're using here.
> > > The safest bet would be to move what you do on map into alloc.
> > >
> > > > +};
> > > > +
> > > >  /**
> > > >   * irq_sim_init - Initialize the interrupt simulator: allocate a r=
ange of
> > > >   *                dummy interrupts.
> > > > @@ -56,16 +93,15 @@ static void irq_sim_handle_irq(struct irq_work =
*work)
> > > >   */
> > > >  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
> > > >  {
> > > > -     int i;
> > > > -
> > > > -     sim->irqs =3D kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP=
_KERNEL);
> > > > -     if (!sim->irqs)
> > > > +     sim->virq_base =3D irq_alloc_descs(-1, 0, num_irqs, 0);
> > > > +     if (sim->virq_base < 0)
> > > > +             return sim->virq_base;
> > > > +
> > > > +     sim->domain =3D irq_domain_add_legacy(NULL, num_irqs, sim->vi=
rq_base,
> > > > +                                         0, &irq_sim_domain_ops, s=
im);
> > >
> > > Why do you need a legacy domain? As far as I can tell, this is new
> > > code, hence it has no legacy.
> > >
> > > > +     if (!sim->domain) {
> > > > +             irq_free_descs(sim->virq_base, num_irqs);
> > > >               return -ENOMEM;
> > > > -
> > > > -     sim->irq_base =3D irq_alloc_descs(-1, 0, num_irqs, 0);
> > > > -     if (sim->irq_base < 0) {
> > > > -             kfree(sim->irqs);
> > > > -             return sim->irq_base;
> > > >       }
> > > >
> > > >       sim->chip.name =3D "irq_sim";
> > > > @@ -74,25 +110,15 @@ int irq_sim_init(struct irq_sim *sim, unsigned=
 int num_irqs)
> > > >
> > > >       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL)=
;
> > > >       if (!sim->work_ctx.pending) {
> > > > -             kfree(sim->irqs);
> > > > -             irq_free_descs(sim->irq_base, num_irqs);
> > > > +             irq_domain_remove(sim->domain);
> > > > +             irq_free_descs(sim->virq_base, num_irqs);
> > > >               return -ENOMEM;
> > > >       }
> > > >
> > > > -     for (i =3D 0; i < num_irqs; i++) {
> > > > -             sim->irqs[i].irqnum =3D sim->irq_base + i;
> > > > -             sim->irqs[i].enabled =3D false;
> > > > -             irq_set_chip(sim->irq_base + i, &sim->chip);
> > > > -             irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
> > > > -             irq_set_handler(sim->irq_base + i, &handle_simple_irq=
);
> > > > -             irq_modify_status(sim->irq_base + i,
> > > > -                               IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_N=
OPROBE);
> > > > -     }
> > > > -
> > > >       init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
> > > >       sim->irq_count =3D num_irqs;
> > > >
> > > > -     return sim->irq_base;
> > > > +     return sim->virq_base;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(irq_sim_init);
> > > >
> > > > @@ -106,8 +132,8 @@ void irq_sim_fini(struct irq_sim *sim)
> > > >  {
> > > >       irq_work_sync(&sim->work_ctx.work);
> > > >       bitmap_free(sim->work_ctx.pending);
> > > > -     irq_free_descs(sim->irq_base, sim->irq_count);
> > > > -     kfree(sim->irqs);
> > > > +     irq_domain_free_irqs(sim->virq_base, sim->irq_count);
> > > > +     irq_domain_remove(sim->domain);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(irq_sim_fini);
> > > >
> > > > @@ -151,6 +177,20 @@ int devm_irq_sim_init(struct device *dev, stru=
ct irq_sim *sim,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> > > >
> > > > +static struct irq_sim_irq_ctx *
> > > > +irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
> > > > +{
> > > > +     struct irq_sim_irq_ctx *ctx;
> > > > +     struct irq_data *irq;
> > > > +     int virq;
> > > > +
> > > > +     virq =3D irq_find_mapping(sim->domain, offset);
> > > > +     irq =3D irq_domain_get_irq_data(sim->domain, virq);
> > > > +     ctx =3D irq_data_get_irq_chip_data(irq);
> > > > +
> > > > +     return ctx;
> > > > +}
> > > > +
> > > >  /**
> > > >   * irq_sim_fire - Enqueue an interrupt.
> > > >   *
> > > > @@ -159,7 +199,9 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> > > >   */
> > > >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > > >  {
> > > > -     if (sim->irqs[offset].enabled) {
> > > > +     struct irq_sim_irq_ctx *ctx =3D irq_sim_get_ctx(sim, offset);
> > > > +
> > > > +     if (ctx->enabled) {
> > > >               set_bit(offset, sim->work_ctx.pending);
> > > >               irq_work_queue(&sim->work_ctx.work);
> > > >       }
> > > > @@ -175,6 +217,6 @@ EXPORT_SYMBOL_GPL(irq_sim_fire);
> > > >   */
> > > >  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
> > > >  {
> > > > -     return sim->irqs[offset].irqnum;
> > > > +     return irq_find_mapping(sim->domain, offset);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(irq_sim_irqnum);
> > >
> > >
> > > Thanks,
> > >
> > >         M.
> > > --
> > > Without deviation from the norm, progress is not possible.
> >
> > Hi Marc,
> >
> > since we're so late in the release cycle and I really only need patch
> > 3/9 from this series - I'll drop this patch and 1/9 as well in v3. We
> > can come back to this in the next cycle.
>
> Then this series doesn't even compile once you remove these two
> patches (just removing patch #1 breaks everything). Please repost a
> fixed series that can be reviewed in the light of your new, reduced
> requirements.
>

Yes, this is what I meant by "I'll drop this patch and 1/9 as well in
v3" - I meant I'll repost a new version without the first two and with
patch 3/9 fixed.

> I'd also appreciate if you could answer the questions I have above, as
> it appears that you intend to bring this patch back in the future.
>

Sure, will do.

Bart
