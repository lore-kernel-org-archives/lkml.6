Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D93BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1621726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KG0OezPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAVXsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:48:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVXsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:48:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so333003wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MN0isz5F+MdRMOSY2iUYhiVoy0F5VHqyEF4TNCaU+g=;
        b=KG0OezPQsyLCAY2Wc44QhoBflmgiZxGOW5P8h79Rnsd4LgUPvPk9yqD9LyWNVAmjUO
         vAbDLZqsmerXn60zi1DEjxSkJ0TeU4Af0DL2TF3wkgwXG8bCH9OAzPNW16rIHlBMCf1Z
         lI93VyM4z/JVXEjFZDC+vOBePB00vXPSIwWPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MN0isz5F+MdRMOSY2iUYhiVoy0F5VHqyEF4TNCaU+g=;
        b=k8IhWK9dtMGvganAL7091ayX71fv1OywtpdXk2F5Hv6QARjA6Y+e2WANNkY7DZi4nr
         e1LyTG4JGhNcxGBOUEZnYjWL766TGzUZsKocAvZrGu8cYQDjrBKvAPUB73yeHyFkSFx/
         hv4zl1/3gIlErlO12CFEyafgdi9Abggnnmob+ALhRtEzuf6MGhPsoAXknziE9FYPvkW2
         hDT8vQlb8pMTGejra3GOryW5cAEbK7sO63prADU/MlQXQMU9vWbfcoFXhB/b29ImrVZQ
         kGa0XE3JRklXYpQwY6cfEgehecLCGBjbYBf8UIelBp/T3Qq+ZWt9uHkG/Iuwi8kt23i3
         YmvA==
X-Gm-Message-State: AJcUukcS9FYN/jL5pxc9aAgH1l5fkbCWUFd4b0c4L4gXE+vtLL0/fRDY
        hmbN4rdoyXfyuzx8zrOt6PbgWhs/hyw4RDGguEp1fQ==
X-Google-Smtp-Source: ALg8bN7gMsOA5QEslBEQ9vMHzviXqIOMzcuPKL1BX21JHltZQkaAlARfRWcwN4y5SQOWmn9DBqlDNON74U1Oa5Noy0s=
X-Received: by 2002:a5d:6988:: with SMTP id g8mr33520136wru.33.1548200913228;
 Tue, 22 Jan 2019 15:48:33 -0800 (PST)
MIME-Version: 1.0
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-4-git-send-email-john.stultz@linaro.org> <20190120111115.GU4635@vkoul-mobl>
In-Reply-To: <20190120111115.GU4635@vkoul-mobl>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 22 Jan 2019 15:48:22 -0800
Message-ID: <CALAqxLXauR4guYMtCYK-wnAqcZCkLY7-vWQ5U-knvHQt1twG4A@mail.gmail.com>
Subject: Re: [PATCH 3/8 v4] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
To:     Vinod Koul <vkoul@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Tanglei Han <hantanglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 3:12 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 16-01-19, 09:10, John Stultz wrote:
> > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> >
> > On the hi3660 hardware there are two (at least) DMA controllers,
> > the DMA-P (Peripherial DMA) and the DMA-A (Audio DMA). The
>                     ^^^
> typo

Thanks so much for the review!

Fixed!

> > +
> > +#define K3_FLAG_NOCLK  (1<<0)
>
> why not use BIT()
>
> space between two please

Fixed.

> > +static const struct k3dma_soc_data k3_v1_dma_data = {
> > +     .flags = 0,
> > +};
>
> So basically this is default right, do we need to set dma_data and not
> assume default..

I'm not sure I fully understand you here. Basically I'm just creating
a per-variant data structure. The k3_v1_dma_data isn't really the
default, but is the first variant supported. There may be future
variants that cause some new flag that the k3_v3_dma_data may need to
set. But for now that variant doesn't have any flags set.


> > +
> > +static const struct k3dma_soc_data asp_v1_dma_data = {
> > +     .flags = K3_FLAG_NOCLK,
> > +};
> > +
> >  static const struct of_device_id k3_pdma_dt_ids[] = {
> > -     { .compatible = "hisilicon,k3-dma-1.0", },
> > +     { .compatible = "hisilicon,k3-dma-1.0",
> > +       .data = &k3_v1_dma_data
> > +     },
> > +     { .compatible = "hisilicon,hisi-pcm-asp-dma-1.0",
> > +       .data = &asp_v1_dma_data
> > +     },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> > @@ -810,6 +830,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
> >
> >  static int k3_dma_probe(struct platform_device *op)
> >  {
> > +     const struct k3dma_soc_data *soc_data;
> >       struct k3_dma_dev *d;
> >       const struct of_device_id *of_id;
> >       struct resource *iores;
> > @@ -823,6 +844,10 @@ static int k3_dma_probe(struct platform_device *op)
> >       if (!d)
> >               return -ENOMEM;
> >
> > +     soc_data = device_get_match_data(&op->dev);
> > +     if (!soc_data)
> > +             return -EINVAL;
>
> So this is not optional, either ways fine by me :)

I think this way makes sense, but maybe I'm missing a better alternative?

Do let me know if there's an example you'd rather I follow.

Thanks so much again for the review!
-john
