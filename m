Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD38C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999552147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4QW6D+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfA0ODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:03:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52474 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0ODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:03:10 -0500
Received: by mail-it1-f193.google.com with SMTP id d11so17006351itf.2;
        Sun, 27 Jan 2019 06:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvjaMtoCZExGiMT2FyI4koJ0UPtbXCHbovdkZaR21eY=;
        b=G4QW6D+uRzus557flxpuGp2rsJyR6ogM1bdSJq1LRTH1dcdrcrHX42d7KgcqiUtQVT
         flmZoW4bGOBvQDmfvS+B/Z19MYnP0RC1e8Ss2YxeHG8ZUpVjdcC8PJ8pw1yy3QR2hCb3
         ernizcjiehGIVShXhf7ySJu4E8YJTTRDP7LI4rurlBnBFIZSvigb6w2tflUcPIeUMpSs
         JHaZ2xDX0dvsAqAFWNU39Am4iK4/0hsq8NEnqIoE6TmluLZzzMXuw61YyZ8pVjNawrrD
         fgD7YMDK2OEQULYQzzl+cfD9AzTgWzVb/H3OOZFFbJ0pk86PzmqeuR6w0T9/FdBi+uWe
         trsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvjaMtoCZExGiMT2FyI4koJ0UPtbXCHbovdkZaR21eY=;
        b=LMmMjaFM3N13r5MxSsT0E/ihyS1gE4Uu77Kpxyj4HUmvNkNEhngmbFy8nhXHQDK1Rl
         vQ0ASd45GZ0+40exQq9rSpiIJrnwhqfsOM5mw+1yYPyrmEeSBiL+9pfqH5XfqBEIXvAI
         t/vSmqzQm8Raalmt0N2SbxBOkWAErlXJXmhacHcCRQ6h33iUdrENKub9PvSIwAUBh0eh
         D6kizioUUu5IKDkTNFKNCwRPPuBZL9HpGPplXgVQnaFiQrNKKbWzmDS0kFH9qMQlY85A
         kzgfcQYb9y6wQRDh1CGc9mTmfXyPt06lJKx3JgJdZ9lmIvuQ5OQcTfxntNoVgoZlProL
         WKWg==
X-Gm-Message-State: AJcUukdnDuu4oH+NfppU0nYrIP75yUt+ZI1Ig9JNqJWoyxu4NBFz58O5
        Ln8IMK+4sKHB2KOUn4GlACF8ktHOY/Ev8elOePM=
X-Google-Smtp-Source: ALg8bN5iCtsmN/4SlgXENnzc/k2k8wl3zCFITXp1H4qgjh9zJXXUEOpa8+LMxDlBJqko4opDB85ofIFsGfHRrdEBOR4=
X-Received: by 2002:a24:65c8:: with SMTP id u191mr8511124itb.7.1548597788745;
 Sun, 27 Jan 2019 06:03:08 -0800 (PST)
MIME-Version: 1.0
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com> <1548413675.28802.45.camel@pengutronix.de>
In-Reply-To: <1548413675.28802.45.camel@pengutronix.de>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Sun, 27 Jan 2019 22:02:57 +0800
Message-ID: <CAA+hA=SSP8eF6hikBgBqAxv29W4J2+szyvsLS2MXSMvxRv9wDw@mail.gmail.com>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts support
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 6:55 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/irqchip/irq-imx-irqsteer.c | 39 +++++++++++++++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> > index 1bebf0a..54802fa 100644
> > --- a/drivers/irqchip/irq-imx-irqsteer.c
> > +++ b/drivers/irqchip/irq-imx-irqsteer.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/spinlock.h>
> >
> > @@ -21,10 +22,13 @@
> > >  #define CHAN_MINTDIS(t)            (CTRL_STRIDE_OFF(t, 3) + 0x4)
> > >  #define CHAN_MASTRSTAT(t)  (CTRL_STRIDE_OFF(t, 3) + 0x8)
> >
> > > +#define CHAN_MAX_OUTPUT_INT        0x8
> > +
> >  struct irqsteer_data {
> > > >   void __iomem            *regs;
> > > >   struct clk              *ipg_clk;
> > > > - int                     irq;
> > > > + int                     irq[CHAN_MAX_OUTPUT_INT];
> > > > + int                     irq_count;
> > > >   raw_spinlock_t          lock;
> > > >   int                     reg_num;
> > > >   int                     channel;
> > @@ -117,7 +121,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> > >     struct device_node *np = pdev->dev.of_node;
> > >     struct irqsteer_data *data;
> > >     struct resource *res;
> > > -   int ret;
> > > +   int i, ret;
> >
> > >     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > >     if (!data)
> > @@ -130,12 +134,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> > >             return PTR_ERR(data->regs);
> > >     }
> >
> > > -   data->irq = platform_get_irq(pdev, 0);
> > > -   if (data->irq <= 0) {
> > > -           dev_err(&pdev->dev, "failed to get irq\n");
> > > -           return -ENODEV;
> > > -   }
> > -
> > >     data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> > >     if (IS_ERR(data->ipg_clk)) {
> > >             ret = PTR_ERR(data->ipg_clk);
> > @@ -177,8 +175,23 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> > >             return -ENOMEM;
> > >     }
> >
> > > -   irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
> > > -                                    data);
> > +     data->irq_count = of_irq_count(np);
>
> We normally don't validate stuff that comes from the DT, but I guess it
> might be helpful to validate that the number of output irqs specified
> matches what the number of input irqs, i.e. there is one output irqs
> specified for each group of 64 inputs.
>

Sound like a good idea.
I think we can calculate the irq_count from irqs number instead of of_irq_count.
Then the following irq_of_parse_and_map() will validate them automatically.

However, i think we'd better to keep the irq_count range check as well.

> > +     if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
> > > +           clk_disable_unprepare(data->ipg_clk);
> > > +           return -EINVAL;
> > > +   }
> > +
> > > +   for (i = 0; i < data->irq_count; i++) {
> > > +           data->irq[i] = irq_of_parse_and_map(np, i);
> > > +           if (!data->irq[i]) {
> > > +                   clk_disable_unprepare(data->ipg_clk);
> > > +                   return -EINVAL;
> > > +           }
> > +
> > > +           irq_set_chained_handler_and_data(data->irq[i],
> > > +                                            imx_irqsteer_irq_handler,
> > +                                              data);
>
> We really want some data about the output irq being passed here, so we
> can cut down the number of register reads in the irq handler to the
> maximum of 2 status registers per group.
>

Will implement it and resend.

Regards
Dong Aisheng

> Regards,
> Lucas
