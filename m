Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF97C67802
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD32098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rgsNGNrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCD32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeJKX4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:56:02 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53901 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbeJKX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:56:01 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w9BGRqlB006503;
        Fri, 12 Oct 2018 01:27:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9BGRqlB006503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539275273;
        bh=udD7PyRVeMVlw+xjAs7eCnVFo2rODvlOSW14DZO9N/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rgsNGNrFhl/WOCT2PCdGBRSYYyZRT47pMLNtepdZOxUbwtf2ZwNT3/3mViSQXyNZ9
         Zr7lNl8bFuY0tgoEGG/N/SuPVcE4e++merf3R4Ak+eYgjndWGUpAVl+rZX01Kim7te
         UsG94PMMXQslOqAEhikkceH57yZ6KkShqxKWaSo4a5N9IbD586jl7+OLvBeDGgUVHI
         zbpXV402RXPU93xCThF2kOdVIuLUOQ5BtkXdPW6C5lS+yeZfU/khvWy6pBcSUZvT4G
         wgiggcrZTNq9iF0UVFjcAyRhSg0q6ZEQjIT8J7lktYs4bk7UP1fdaithyYuF7MKA40
         doDo1cXMXmQrg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id w194so9107251vsc.11;
        Thu, 11 Oct 2018 09:27:52 -0700 (PDT)
X-Gm-Message-State: ABuFfohN/E+4JFaogQ2Ba+MQaBfOzVqkkoCP2rI/ObNDF7jYfCu0VZIB
        N+cUkl4B6wOoo0+9jq5zsVufEWz7vrV7pBHSlyY=
X-Google-Smtp-Source: ACcGV606JKx6swRIbiMpKF1oyBFWb78KPR2qbZ2QGgbsSMXRAuSB4i4vG2bQ34wvRrgIUxqry/rSBJF1Y2q+fYdKJgQ=
X-Received: by 2002:a67:f1d2:: with SMTP id v18mr916358vsm.181.1539275271609;
 Thu, 11 Oct 2018 09:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
 <1536799869-10643-3-git-send-email-yamada.masahiro@socionext.com>
 <20181005145706.GM2372@vkoul-mobl> <CAK7LNASF5Ct+ONWnRqZwstg+htAo0buG19HOGM-EV2EPe1NSbQ@mail.gmail.com>
 <20181006162246.GO2372@vkoul-mobl>
In-Reply-To: <20181006162246.GO2372@vkoul-mobl>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Oct 2018 01:27:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmbRF1zvs_zbS1Ux3SKmAS5Ew9kVYPMagoO1Uf-WPUPg@mail.gmail.com>
Message-ID: <CAK7LNASmbRF1zvs_zbS1Ux3SKmAS5Ew9kVYPMagoO1Uf-WPUPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 1:23 AM Vinod <vkoul@kernel.org> wrote:
> > > > +static int uniphier_mdmac_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct device *dev = &pdev->dev;
> > > > +     struct uniphier_mdmac_device *mdev;
> > > > +     struct dma_device *ddev;
> > > > +     struct resource *res;
> > > > +     int nr_chans, ret, i;
> > > > +
> > > > +     nr_chans = platform_irq_count(pdev);
> > > > +     if (nr_chans < 0)
> > > > +             return nr_chans;
> > > > +
> > > > +     ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> > > > +                         GFP_KERNEL);
> > > > +     if (!mdev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +     mdev->reg_base = devm_ioremap_resource(dev, res);
> > > > +     if (IS_ERR(mdev->reg_base))
> > > > +             return PTR_ERR(mdev->reg_base);
> > > > +
> > > > +     mdev->clk = devm_clk_get(dev, NULL);
> > > > +     if (IS_ERR(mdev->clk)) {
> > > > +             dev_err(dev, "failed to get clock\n");
> > > > +             return PTR_ERR(mdev->clk);
> > > > +     }
> > > > +
> > > > +     ret = clk_prepare_enable(mdev->clk);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ddev = &mdev->ddev;
> > > > +     ddev->dev = dev;
> > > > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > > > +     ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> > > > +     ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> > >
> > > undefined?
> >
> > Precisely, I do not know the *_addr_widths.
>
> This is "your" controller, you know the capability!

No, I do not.

I wrote this driver, but the hardware-internal is not fully documented
in the datasheet.
I can see the functionality only from the software point of view.


> >
> > As far as I read dmaengine/provider.rst
> > this represents the data bytes that are read/written at a time.
> >
> > Really I do not know (care about) the transfer width.
> >
> > As I commented in v2, the connection of the device side is hard-wired.
> > The transfer width cannot be observed from SW view.
> >
> > What should I do?
>
> Add the widths that are supported by the controller

To my best knowledge, this DMA engine is connected to a 32-bit bus.
So, 4 bytes are read/written at a time.

This HW allows to set the transfer size by byte granularity.
So, it would be possible to access the data bus
by 1-byte, 2-bytes, 3-bytes as well.

I will set the OR of 1, 2, 3, 4 bytes.





> > > > +static int uniphier_mdmac_remove(struct platform_device *pdev)
> > > > +{
> > > > +     struct uniphier_mdmac_device *mdev = platform_get_drvdata(pdev);
> > > > +
> > > > +     of_dma_controller_free(pdev->dev.of_node);
> > > > +     dma_async_device_unregister(&mdev->ddev);
> > > > +     clk_disable_unprepare(mdev->clk);
> > >
> > > at this point your irq is registered and can be fired, the tasklets are
> > > not killed :(
> >
> >
> > Please let me clarify the concerns here.
> >
> > Before the .remove hook is called, all the consumers should
> > have already put the dma channels.
> > So, no new descriptor is coming in.
> >
> > However,
> >
> > Some already-issued descriptors might be remaining, and being processed.
> >
> > [1] This DMA engine might be still running
> >     when clk_disable_unprepare() is being called.
> >     The register access with its clock disabled
> >     would cause the system crash.
>
> Yes and dmaengine may fire a spurious irq..
> >
> > [2] vchan_cookie_complete() might being called at this point
> >     and schedule the tasklet.
> >     It might call uniphier_mdmac_desc_free() after
> >     the reference disapperrs.
> >
> > Is this correct?
>
> Correct :)
>
> > Do you have recommendation
> > for module removal guideline?
>
> Yes please free up or disable irq explictly, ensure pending irqs have
> completed and then ensure all the tasklets are killed and in this order
> for obvious reasons

Also, need to free up the left-over descriptor(s) right?
Just killing the tasklets may result in memory leak.

Please let know if the implementation in v4 is wrong.



-- 
Best Regards
Masahiro Yamada
