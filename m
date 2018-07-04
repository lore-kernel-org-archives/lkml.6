Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35FE240F7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpbMvR/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35FE240F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeGDQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:28:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42441 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeGDQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:28:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id v9-v6so3042766pff.9;
        Wed, 04 Jul 2018 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S7Y3YgfryNM+k8fvUdmVQ7FtrRa8j4XdS3Vf+0ChyU4=;
        b=cpbMvR/sPszHW3p7rwFi3+DM2XC97r5ikG2ZUVJdoxfHb2nTqInFJyoDpXhW5UdAHg
         pPEVq1z5BqKb4aK3VO6obxPtLwptKLGa3BMT7SSWJMOJN5hwKkO+xYpf3BURolo0ft0z
         HpTmSrlVL2PjqL5l0+QzMBAkmFbY4//2oVZnslt6t3HFrssB9jUJLEzSPREwHdNN9JgM
         8fl8Tnk1G+M9N8DpTPshyEEvzffuTei9cCpZdtInX3KgT4N5feJ0J9abAk3aZDh0DqGO
         CjXRDoGY/2byBeNq0dz2VVgyijuuskSQDeuBDOm1Z34V07NbcO9xaCGczWg2GqHhn5fe
         C3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7Y3YgfryNM+k8fvUdmVQ7FtrRa8j4XdS3Vf+0ChyU4=;
        b=fuUqUyKChi9lqPtRxAz4PKr9YPkYp194XOt1MY/VGSb0X0D10JLWrc7PIvRwhUPox/
         BDj7rGG36/X1we3l1sY6b6dLtuj5o8oKD29bKlGThybFm1NoypjVE9k9tn3iuN1vmsPZ
         6FUQMKezh9f6a07GPM0cEfmJYwQjg6Lto7ixRwdsn5yiKAc4crUYXBp0qbyqBad8/+Jj
         n36GpZE4Pdqbb7281herABH2yHTsUThGpj8k28gHYjkMu8nw0GXZ7FqmznpmJ77MSzjE
         t1SFctpNbsQvdGR+Ode6b+iBR0/Iif0Iwm6IdiZVjmJ5/TDpA7vK3CTFtrCBC0nOOldu
         cEJg==
X-Gm-Message-State: APt69E36AJYztFp8Ae1BlF+n8SH3km8TOQVcDlqbw4NgU/s2SAfzh6Ta
        b58gRhV0sfDOLGoopwxTxdt2/PRcFwR44dbqQ1Q=
X-Google-Smtp-Source: AAOMgpeAnMLQfQRGhkA4ta1AvU9UACK6EBfxjdLzlc/ged2wfa+gU+7GWoxG1v3v7UDRct+dmZoLKWg03ZKTwBjY/0g=
X-Received: by 2002:a63:a1a:: with SMTP id 26-v6mr2528179pgk.221.1530721696063;
 Wed, 04 Jul 2018 09:28:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:28:15
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-2-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-2-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 21:58:15 +0530
Message-ID: <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of channels
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
> As part of the work to support various other Ingenic JZ47xx SoC versions,
> which don't feature the same number of DMA channels per core, we now
> deduce the number of DMA channels available from the devicetree
> compatible string.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 53 +++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 85820a2d69d4..b40f491f0367 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -23,8 +24,6 @@
>  #include "dmaengine.h"
>  #include "virt-dma.h"
>
> -#define JZ_DMA_NR_CHANNELS     32
> -
>  /* Global registers. */
>  #define JZ_DMA_REG_DMAC                0x1000
>  #define JZ_DMA_REG_DIRQP       0x1004
> @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>         unsigned int curr_hwdesc;
>  };
>
> +enum jz_version {
> +       ID_JZ4780,
> +};
> +
>  struct jz4780_dma_dev {
>         struct dma_device dma_device;
>         void __iomem *base;
>         struct clk *clk;
>         unsigned int irq;
> +       unsigned int nb_channels;
> +       enum jz_version version;
>
>         uint32_t chan_reserved;
> -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
> +       struct jz4780_dma_chan chan[];

Looks like a variable length array in struct. I think there is some
effort to remove the usage of VLA. Can you revisit this? I may be
wrong, please feel free to correct.

>  };
>
>  struct jz4780_dma_filter_data {
> @@ -648,7 +653,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
>
>         pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
>
> -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
> +       for (i = 0; i < jzdma->nb_channels; i++) {
>                 if (!(pending & (1<<i)))
>                         continue;
>
> @@ -728,7 +733,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>         data.channel = dma_spec->args[1];
>
>         if (data.channel > -1) {
> -               if (data.channel >= JZ_DMA_NR_CHANNELS) {
> +               if (data.channel >= jzdma->nb_channels) {
>                         dev_err(jzdma->dma_device.dev,
>                                 "device requested non-existent channel %u\n",
>                                 data.channel);
> @@ -752,19 +757,45 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>         }
>  }
>
> +static const unsigned int jz4780_dma_nb_channels[] = {
> +       [ID_JZ4780] = 32,
> +};
> +
> +static const struct of_device_id jz4780_dma_dt_match[] = {
> +       { .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
> +
>  static int jz4780_dma_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *of_id = of_match_device(
> +                       jz4780_dma_dt_match, dev);
>         struct jz4780_dma_dev *jzdma;
>         struct jz4780_dma_chan *jzchan;
>         struct dma_device *dd;
>         struct resource *res;
> +       enum jz_version version;
> +       unsigned int nb_channels;
>         int i, ret;
>
> -       jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> +       if (of_id)
> +               version = (enum jz_version)of_id->data;
> +       else
> +               version = ID_JZ4780; /* Default when not probed from DT */
> +
> +       nb_channels = jz4780_dma_nb_channels[version];
> +
> +       jzdma = devm_kzalloc(dev, sizeof(*jzdma)
> +                               + sizeof(*jzdma->chan) * nb_channels,
> +                               GFP_KERNEL);
>         if (!jzdma)
>                 return -ENOMEM;
>
> +       jzdma->nb_channels = nb_channels;
> +       jzdma->version = version;
> +
>         platform_set_drvdata(pdev, jzdma);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -839,7 +870,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>
>         INIT_LIST_HEAD(&dd->channels);
>
> -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
> +       for (i = 0; i < jzdma->nb_channels; i++) {
>                 jzchan = &jzdma->chan[i];
>                 jzchan->id = i;
>
> @@ -884,19 +915,13 @@ static int jz4780_dma_remove(struct platform_device *pdev)
>
>         free_irq(jzdma->irq, jzdma);
>
> -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
> +       for (i = 0; i < jzdma->nb_channels; i++)
>                 tasklet_kill(&jzdma->chan[i].vchan.task);
>
>         dma_async_device_unregister(&jzdma->dma_device);
>         return 0;
>  }
>
> -static const struct of_device_id jz4780_dma_dt_match[] = {
> -       { .compatible = "ingenic,jz4780-dma", .data = NULL },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
> -
>  static struct platform_driver jz4780_dma_driver = {
>         .probe          = jz4780_dma_probe,
>         .remove         = jz4780_dma_remove,
> --
> 2.18.0
>
>
