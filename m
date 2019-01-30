Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EA3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3B720844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAvVwFiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfA3ODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:03:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39569 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3ODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:03:32 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so10595687itl.4;
        Wed, 30 Jan 2019 06:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Au8OGX4HLlsM2fGNTcJRx01vunFyfW2lWfvmwDV3u30=;
        b=FAvVwFiq0oToCn9CR5AI+uHqFf1CgpKFCYfdXzC3SzvLwEkghsiAb0UceyGiDipB7g
         HXWE3RwJkeIgEZId3QXvoONT4xWUj857I2VyDwoAbMVfIh6yAzU1fWulzEB05A87xZNj
         Bs2O/am7MrTw/6U4Lqi0WT0MnGKKunUUjSShwT2QLymJDUsGJ24iGqthZZsi8hJOXIko
         IxEqzx4cDZZD0QsLX1MBKtggMUWmbW82kSR1ECNhBVRjZlnyTzqDZJp5HrClcKNT1kyl
         WX+XJxgaqJOgGeXLpKV+UG6f0xTfH7rkrhKWguc5QHL37d770P+JndXuOf1Af9cwDHcM
         0kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Au8OGX4HLlsM2fGNTcJRx01vunFyfW2lWfvmwDV3u30=;
        b=oVzn6670M/AcsXl8xKOA29hq6pzQz14vVHOgkjjgko15c+YywBKDVquuzPH/608vKg
         D3X6eciODrKaaMYEAgeWZM8ib4NBkk9ZMRaPvsLU/E6SUeIrMMepXKD6bLnzS1ym21tA
         waHf74H+2YNfBFHg5Z7/Ze2SL25xX+7LrbvovJynE9OaWaga99uj77+CQdjhQ9vjXEyP
         N2aL2dgtfkTR6cf7RmKz7JHaEAyMpcjqh6S7n46uTdbbTfAM6UJ7WHFilrVsOfS8FRm6
         ubovTFvdB3s16DAUHnXbnRKRoL/GEuYVDxVAoTvjiCKO7DNUH7XqzQr2+z+OUZQNHvXE
         ZAKA==
X-Gm-Message-State: AJcUukejZWDpXYyhNkmyUMS24odb3BzfOsgbB7SDPlj84uZt5CWuJDJF
        2QVTOn9y0vUWVtwQsrEaltHwOeua2qLaaCGdF5c=
X-Google-Smtp-Source: ALg8bN42Ycql4vHjRGwh9ghTb02TUFMwDYQFu6CHEHnFAwYfpGvrjK+zIgJxflEer028oK0rJbcSNjP28Ab4X7vt3nM=
X-Received: by 2002:a24:80d2:: with SMTP id g201mr16065657itd.63.1548857011453;
 Wed, 30 Jan 2019 06:03:31 -0800 (PST)
MIME-Version: 1.0
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-5-git-send-email-aisheng.dong@nxp.com> <1548855138.6869.27.camel@pengutronix.de>
In-Reply-To: <1548855138.6869.27.camel@pengutronix.de>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 30 Jan 2019 22:03:20 +0800
Message-ID: <CAA+hA=Q79RcUk=epBighR_jZCLxaNzRvc9Lukzrzby_Av6d9wQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts support
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 9:33 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 30.01.2019, 13:06 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v1->v2:
> >  * calculate irq_count by fsl,num-irqs instead of parsing interrupts
> >    property from devicetree to match the input interrupts and outputs
> >  * improve output interrupt handler by searching only two registers
> >    withint the same group
> > ---
> >  drivers/irqchip/irq-imx-irqsteer.c | 76 +++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 59 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-i=
mx-irqsteer.c
> > index 67ed862..cc40039 100644
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
> > @@ -87,26 +91,45 @@ static const struct irq_domain_ops imx_irqsteer_dom=
ain_ops =3D {
> > > >   .xlate          =3D irq_domain_xlate_onecell,
> >  };
> >
> > +static int imx_irqsteer_get_hwirq_base(struct irqsteer_data *data, u32=
 irq)
> > +{
> > > +   int i;
> > +
> > > +   for (i =3D 0; i < data->irq_count; i++) {
> > > +           if (data->irq[i] =3D=3D irq)
> > +                     break;
>
> return i * 64; here...
> > +     }
> > +
> > +     return i * 64;
>
> ... and -EINVAL or something here, so we don't return a out of bounds
> hwirq base if the loop ever doesn't match something?
>

Good suggestion, will add it.

> > +}
> > +
> >  static void imx_irqsteer_irq_handler(struct irq_desc *desc)
> >  {
> > >     struct irqsteer_data *data =3D irq_desc_get_handler_data(desc);
> > > +   int hwirq;
> > >     int i;
> >
> > >     chained_irq_enter(irq_desc_get_chip(desc), desc);
> >
> > > -   for (i =3D 0; i < data->reg_num * 32; i +=3D 32) {
> > > -           int idx =3D imx_irqsteer_get_reg_index(data, i);
> > > +   hwirq =3D imx_irqsteer_get_hwirq_base(data, irq_desc_get_irq(desc=
));
> > +
> > > +   for (i =3D 0; i < 2; i++) {
> > > +           int idx =3D imx_irqsteer_get_reg_index(data, hwirq);
> > >             unsigned long irqmap;
> > >             int pos, virq;
> >
> > > +           if (hwirq >=3D data->reg_num * 32)
> > > +                   break;
> > +
> > >             irqmap =3D readl_relaxed(data->regs +
> > >                                    CHANSTATUS(idx, data->reg_num));
> >
> > >             for_each_set_bit(pos, &irqmap, 32) {
> > > -                   virq =3D irq_find_mapping(data->domain, pos + i);
> > +                     virq =3D irq_find_mapping(data->domain, pos + hwi=
rq);
>
> The irq index calculation need to be "pos + i * 32 + hwirq", otherwise
> this will map to the wrong virqs for the second register in each group.
>

For second register map, hwirq will plus 32 in next round.
So i can't see this will map a wrong virqs.
And it looks to me ""pos + i * 32 + hwirq" is equal to "hwirq + 32".
Am i missed something?

> >                       if (virq)
> > >                             generic_handle_irq(virq);
> > >             }
> > +             hwirq +=3D 32;
>
> Could be folded into the loop head.
>

You mean =E2=80=9Cfor (i =3D 0; i < 2; i++, hwirq +=3D32)=E2=80=9D ?
I feel that's not quite necessary.

> >       }
> >
> > >     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > @@ -117,7 +140,8 @@ static int imx_irqsteer_probe(struct platform_devic=
e *pdev)
> > >     struct device_node *np =3D pdev->dev.of_node;
> > >     struct irqsteer_data *data;
> > >     struct resource *res;
> > > -   int ret;
> > > +   u32 irqs_num;
> > > +   int i, ret;
> >
> > >     data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > >     if (!data)
> > @@ -130,12 +154,6 @@ static int imx_irqsteer_probe(struct platform_devi=
ce *pdev)
> > >             return PTR_ERR(data->regs);
> > >     }
> >
> > > -   data->irq =3D platform_get_irq(pdev, 0);
> > > -   if (data->irq <=3D 0) {
> > > -           dev_err(&pdev->dev, "failed to get irq\n");
> > > -           return -ENODEV;
> > > -   }
> > -
> > >     data->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
> > >     if (IS_ERR(data->ipg_clk)) {
> > >             ret =3D PTR_ERR(data->ipg_clk);
> > @@ -146,11 +164,17 @@ static int imx_irqsteer_probe(struct platform_dev=
ice *pdev)
> >
> > >     raw_spin_lock_init(&data->lock);
> >
> > > -   of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
> > > +   of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
> > >     of_property_read_u32(np, "fsl,channel", &data->channel);
> >
> > > -   /* one register bit map represents 32 input interrupts */
> > > -   data->reg_num /=3D 32;
> > > +   /*
> > +      * There is one output irqs for each group of 64 inputs.
>
> "irq", singular.
>

Got it

> > +      * One register bit map can represent 32 input interrupts.
> > > +    */
> > > +   data->irq_count =3D irqs_num / 64;
> > > +   if (irqs_num % 64)
> > +             data->irq_count +=3D 1;
>
> This is a weird way of writing DIV_ROUND_UP.
>

Good suggestion

> > +     data->reg_num =3D irqs_num / 32;
> >
> > >     if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> > >             data->saved_reg =3D devm_kzalloc(&pdev->dev,
> > @@ -177,8 +201,22 @@ static int imx_irqsteer_probe(struct platform_devi=
ce *pdev)
> > >             return -ENOMEM;
> > >     }
> >
> > > -   irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_hand=
ler,
> > > -                                    data);
> > > +   if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
> > > +           clk_disable_unprepare(data->ipg_clk);
> > > +           return -EINVAL;
> > > +   }
> > +
> > > +   for (i =3D 0; i < data->irq_count; i++) {
> > > +           data->irq[i] =3D irq_of_parse_and_map(np, i);
> > > +           if (!data->irq[i]) {
> > > +                   clk_disable_unprepare(data->ipg_clk);
> > +                     return -EINVAL;
>
> With a lot of failure paths now replicating the clk_disable_unprepare,
> return error, I think this warrants a common cleanup path that all
> those paths could reach via simple goto.
>

Sound goods to me

Regards
Dong Aisheng

> > +             }
> > +
> > > +           irq_set_chained_handler_and_data(data->irq[i],
> > > +                                            imx_irqsteer_irq_handler=
,
> > > +                                            data);
> > > +   }
> >
> > >     platform_set_drvdata(pdev, data);
> >
> > @@ -188,8 +226,12 @@ static int imx_irqsteer_probe(struct platform_devi=
ce *pdev)
> >  static int imx_irqsteer_remove(struct platform_device *pdev)
> >  {
> > >     struct irqsteer_data *irqsteer_data =3D platform_get_drvdata(pdev=
);
> > > +   int i;
> > +
> > > +   for (i =3D 0; i < irqsteer_data->irq_count; i++)
> > > +           irq_set_chained_handler_and_data(irqsteer_data->irq[i],
> > > +                                            NULL, NULL);
> >
> > > -   irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
> > >     irq_domain_remove(irqsteer_data->domain);
> >
> > >     clk_disable_unprepare(irqsteer_data->ipg_clk);
