Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990BC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC3D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zktDCgyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfBLI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:29:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43884 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfBLI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:29:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so2997822ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y/2gDVuTPu6rdry6EfYXGDSx73+z/8VFCgq9bYuIhmQ=;
        b=zktDCgyg4qL5DfZf2v1Z/W6hYf3xSOnI1AnyTDGk+NqzoXtIBwx9PXvzNeUzIDJ8JO
         ceiW6UHWoRN3e4E7jz/lUWLBqBBCX30ozWf+sQyuHf3uDweQ8fuVbvpw4ALykM1mTU4u
         Kaaz63VHY3Gf2ru8A7f8o9PGbQHucRoI94RZZcPE58X5l/v+P2OdlhiiT8QILASgY6fP
         FQjSTga+/kSyDacIMMa+N3gzLEGPo+lwURK0/2n4+fe4j7MzZz6B1IWX+IsLO8ey98/g
         x+hcCoV+9/t+YZzO7YldxRJCdzU+yT116TaFfxxg/3xKY7nwLXeLAhb8ardfopOFx/gz
         BnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y/2gDVuTPu6rdry6EfYXGDSx73+z/8VFCgq9bYuIhmQ=;
        b=GN8v2k2BMJxPAy1NybE3lcKxH5JzuOBUbdwst8akovss0oPXwTrd3Vkl9PAkTw8tX9
         oneQ2BHIghNr3P+WzKQUzzCTUZaMjNNAFGimOwcLYVQW8Thc8ptdnBtCvdgPKnS7FpHn
         T0ppsxPTe4To2sUoZknjFqZrshPauL1k9BrLKFhKV4IYXmoXMOWnDCuSKd//axXZLJp2
         B/7ouotOKBUFE9Q4fkNrtKf4vL5i9WUbzKThSQCGmHdoQhVTjYUG30d+Jm2vAg+HTc6q
         kHcWWJLfKWdznA2bsZ8RYpfsB36tBFOWrysqwJUd4BT6EZ2R5Wr3Gm4X6PwZe4ruDwRV
         ovrA==
X-Gm-Message-State: AHQUAuYITBwGnRFJX6eICFS6RIEVgHtY/KQHOzqV+j4QfusBZeaUKQXI
        8fUgAjHl96+2ZSXt42Lf2B+kBYE6db+m+jHg3NKAmQ==
X-Google-Smtp-Source: AHgI3IZXojEmkpNEQum7/eFrh1PZp3C75mLgiECln5AB+GTI2ifU/JcoW187WGJAYZACFv2/VxjB3U7vZC0F9Nw2C1M=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr2520781ote.234.1549960152320;
 Tue, 12 Feb 2019 00:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-2-brgl@bgdev.pl>
 <20190211222839.7a7ad87f@why.wild-wind.fr.eu.org>
In-Reply-To: <20190211222839.7a7ad87f@why.wild-wind.fr.eu.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Feb 2019 09:29:01 +0100
Message-ID: <CAMpxmJUVHNU8mvOiKOvk6rkqjVOtxy_j+LVm0rjjV7ys0+DHPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] irq/irq_sim: don't share the irq_chip structure
 between simulators
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

pon., 11 lut 2019 o 23:28 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(=
a):
>
> On Tue, 29 Jan 2019 09:44:03 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We want to support multiple instances of irq_sim. Make struct irq_chip
> > part of the irq_sim structure.
>
> Why? There is nothing dynamic in an irqchip structure. It is all code
> that is set in stone for the lifetime of the irqchip.
>
> I've sure you have a use for such indirection, so why don't you explain
> what you have in mind?
>

No you're right, this can be dropped.

Bart

> Thanks,
>
>         M.
>
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  include/linux/irq_sim.h |  2 ++
> >  kernel/irq/irq_sim.c    | 12 +++++-------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > index 4500d453a63e..eda132c22b57 100644
> > --- a/include/linux/irq_sim.h
> > +++ b/include/linux/irq_sim.h
> > @@ -6,6 +6,7 @@
> >  #ifndef _LINUX_IRQ_SIM_H
> >  #define _LINUX_IRQ_SIM_H
> >
> > +#include <linux/irq.h>
> >  #include <linux/irq_work.h>
> >  #include <linux/device.h>
> >
> > @@ -25,6 +26,7 @@ struct irq_sim_irq_ctx {
> >  };
> >
> >  struct irq_sim {
> > +     struct irq_chip         chip;
> >       struct irq_sim_work_ctx work_ctx;
> >       int                     irq_base;
> >       unsigned int            irq_count;
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index 98a20e1594ce..b732e4e2e45b 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -25,12 +25,6 @@ static void irq_sim_irqunmask(struct irq_data *data)
> >       irq_ctx->enabled =3D true;
> >  }
> >
> > -static struct irq_chip irq_sim_irqchip =3D {
> > -     .name           =3D "irq_sim",
> > -     .irq_mask       =3D irq_sim_irqmask,
> > -     .irq_unmask     =3D irq_sim_irqunmask,
> > -};
> > -
> >  static void irq_sim_handle_irq(struct irq_work *work)
> >  {
> >       struct irq_sim_work_ctx *work_ctx;
> > @@ -74,6 +68,10 @@ int irq_sim_init(struct irq_sim *sim, unsigned int n=
um_irqs)
> >               return sim->irq_base;
> >       }
> >
> > +     sim->chip.name =3D "irq_sim";
> > +     sim->chip.irq_mask =3D irq_sim_irqmask;
> > +     sim->chip.irq_unmask =3D irq_sim_irqunmask;
> > +
> >       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> >       if (!sim->work_ctx.pending) {
> >               kfree(sim->irqs);
> > @@ -84,7 +82,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int nu=
m_irqs)
> >       for (i =3D 0; i < num_irqs; i++) {
> >               sim->irqs[i].irqnum =3D sim->irq_base + i;
> >               sim->irqs[i].enabled =3D false;
> > -             irq_set_chip(sim->irq_base + i, &irq_sim_irqchip);
> > +             irq_set_chip(sim->irq_base + i, &sim->chip);
> >               irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
> >               irq_set_handler(sim->irq_base + i, &handle_simple_irq);
> >               irq_modify_status(sim->irq_base + i,
>
>
>
> --
> Without deviation from the norm, progress is not possible.
