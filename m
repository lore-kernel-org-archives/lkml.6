Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012342077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hEyymOCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfBLKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:15:43 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38015 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfBLKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:15:43 -0500
Received: by mail-it1-f193.google.com with SMTP id z20so6161044itc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vp3NcEUpAsn6A+7rWNvCBkDt8r5T4jiwcBdhF2+B1ss=;
        b=hEyymOCXoBQXKre+s0T389p0ZO69rJMdKeC+tRchPq4DBWEWi98ZJCLhltH7Lpzxqb
         pD493xCmwO9omhPQ7VfPmqr/TNLbGk7O2Q8K+MRz6v42vZ78DpCd7XhzKfRYs6fAPWtJ
         s3lx0ZFBcm3a+ElRpH7QehJ4Ea8cAl884hPeGDguSZVVgG6jr7rzvpnkTxCzVETWzGrn
         0YizMbPIj3nDAgn051Yay4JEQe2cNAboco9XpsOSi0dwFg2O5qYOFeHycBrL3psl7aIx
         6vgL26tRyENacbWyPY1WJ/ff1Sqdmc5Fin6eBNFwwNvyF9R9568P7RkRuo/YzGBU+VU6
         Jtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vp3NcEUpAsn6A+7rWNvCBkDt8r5T4jiwcBdhF2+B1ss=;
        b=oDJsLMRk8An6B/yh/KXzbCc0UJcc0KadiCrb2iPbFnRyLSGRPGubvU1LVWWTgC9cED
         WEkW8U2rePRb4NBIppMCxS5CPcTq27jyHQClF/8sUZmn+BAWcZcdgwasI0rDW4TojUjs
         46mH8I7UWFu6vIvm9W2LsKXxur5rlSElwGPSv4MGxOfY406g4bo4zn0TZZ1X8g6ONxV2
         4m572H4nJl/4/RfNQWzA9llW/xn+bvVJ4QrWcWY4yVcCrOOLpvfDNviGKXaNJjAh7LCV
         WS/B6fS+HXpM0MDWbH8YRotdFoDOHCFvpm889rpAnqbZwi5dedjyJajXt+59scompKgk
         bEeg==
X-Gm-Message-State: AHQUAub+e79iZW1xbsDDsGByNKEaVmDEkzHxfUZF+L/hXA1E7G18NQS1
        ItuyaoLC+PjLYROmUnoaiIoC2oMfgy+awwJBA1K0Gg==
X-Google-Smtp-Source: AHgI3Ia5++xuARMcUIDQnG6RFhrMJNt6qXGP9b1LzuKNLQoh3Wvon8Pg7mVOOEP7xLRX2DtSoBCkele7PaVzB/UYGBM=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr1560109ior.258.1549966541731;
 Tue, 12 Feb 2019 02:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com> <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
 <20190212100607.4etnqytsrtxtcqvc@pengutronix.de>
In-Reply-To: <20190212100607.4etnqytsrtxtcqvc@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 11:15:30 +0100
Message-ID: <CAMRc=Md+pAPSyQeFOOEiOiBb6bLvQ=FTNQHVYA-=6iZMfsuHng@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 11:06 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Tue, Feb 12, 2019 at 10:19:20AM +0100, Bartosz Golaszewski wrote:
> > wt., 12 lut 2019 o 10:10 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=
=82(a):
> > >
> > > On 29/01/2019 08:44, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Provide a more specialized variant of irq_sim_fire() that allows to
> > > > specify the type of the fired interrupt. The type is stored in the
> > > > dummy irq context struct via the set_type callback.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  include/linux/irq_sim.h |  9 ++++++++-
> > > >  kernel/irq/irq_sim.c    | 26 ++++++++++++++++++++++----
> > > >  2 files changed, 30 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > > > index b96c2f752320..647a6c8ffb31 100644
> > > > --- a/include/linux/irq_sim.h
> > > > +++ b/include/linux/irq_sim.h
> > > > @@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
> > > >
> > > >  struct irq_sim_irq_ctx {
> > > >       bool                    enabled;
> > > > +     unsigned int            type;
> > > >  };
> > > >
> > > >  struct irq_sim {
> > > > @@ -37,7 +38,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned i=
nt num_irqs);
> > > >  int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
> > > >                     unsigned int num_irqs);
> > > >  void irq_sim_fini(struct irq_sim *sim);
> > > > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
> > > > +void irq_sim_fire_type(struct irq_sim *sim,
> > > > +                    unsigned int offset, unsigned int type);
> > > >  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
> > > >
> > > > +static inline void irq_sim_fire(struct irq_sim *sim, unsigned int =
offset)
> > > > +{
> > > > +     irq_sim_fire_type(sim, offset, IRQ_TYPE_DEFAULT);
> > > > +}
> > > > +
> > > >  #endif /* _LINUX_IRQ_SIM_H */
> > > > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > > > index 2bcdbab1bc5a..e3160b5e59b8 100644
> > > > --- a/kernel/irq/irq_sim.c
> > > > +++ b/kernel/irq/irq_sim.c
> > > > @@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *d=
ata)
> > > >       irq_ctx->enabled =3D true;
> > > >  }
> > > >
> > > > +static int irq_sim_set_type(struct irq_data *data, unsigned int ty=
pe)
> > > > +{
> > > > +     struct irq_sim_irq_ctx *irq_ctx =3D irq_data_get_irq_chip_dat=
a(data);
> > > > +
> > > > +     irq_ctx->type =3D type;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static void irq_sim_handle_irq(struct irq_work *work)
> > > >  {
> > > >       struct irq_sim_work_ctx *work_ctx;
> > > > @@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned =
int num_irqs)
> > > >       sim->chip.name =3D "irq_sim";
> > > >       sim->chip.irq_mask =3D irq_sim_irqmask;
> > > >       sim->chip.irq_unmask =3D irq_sim_irqunmask;
> > > > +     sim->chip.irq_set_type =3D irq_sim_set_type;
> > > >
> > > >       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL)=
;
> > > >       if (!sim->work_ctx.pending) {
> > > > @@ -192,21 +202,29 @@ irq_sim_get_ctx(struct irq_sim *sim, unsigned=
 int offset)
> > > >  }
> > > >
> > > >  /**
> > > > - * irq_sim_fire - Enqueue an interrupt.
> > > > + * irq_sim_fire_type - Enqueue an interrupt.
> > > >   *
> > > >   * @sim:        The interrupt simulator object.
> > > >   * @offset:     Offset of the simulated interrupt which should be =
fired.
> > > > + * @type:    Type of the fired interrupt. Must be one of the follo=
wing:
> > > > + *           IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING,
> > > > + *           IRQ_TYPE_EDGE_BOTH, IRQ_TYPE_LEVEL_HIGH,
> > > > + *           IRQ_TYPE_LEVEL_LOW, IRQ_TYPE_DEFAULT
> > > >   */
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
> > >
> > > I wonder how realistic this is, given that you do not track the relea=
se
> > > of a level. In short, mo matter what the type is, you treat everythin=
g
> > > as edge.
> > >
> > > What is the point of this?
> > >
> >
> > When userspace wants to monitor GPIO line interrupts, the GPIO
> > framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
> > IRQF_TRIGGER_RISING or both.
>
> I think the background of the question was: Why is there no support for
> level sensitive irqs?
>
> The userspace API has this limitation (also for no good reason I think).
>

Fair point. We also need support for programmable pull-up/down
resistors as it's something many users request. It's just a matter of
someone getting down to doing it. :)

Bart
