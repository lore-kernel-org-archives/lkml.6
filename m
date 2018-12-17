Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487FC20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545041304;
	bh=uldrmWlnUuRIU+GeLe+oXcXApXC3MjzE9zsY6+G22LU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lKROqyW3dtqyMl3xB7e/AsWwCBEYLffbg4OjvH4zgGB/8TpqSvJ9VOkJLCjrBmMmM
	 IJ2s99wUBT8Kz8EuAD+MS8ALkO4/Qe7nZwMOLL0fepJVrxCNB8Bf6tWi+nKlXEDUSU
	 QCI75UmCba/gInvu9borL+AZvKqK8WmkDLY2FXqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeLQKIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732281AbeLQKIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:08:21 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF682133F;
        Mon, 17 Dec 2018 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545041300;
        bh=uldrmWlnUuRIU+GeLe+oXcXApXC3MjzE9zsY6+G22LU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPlJY4N5qrOJNupI6nCHMVViKfy4v7z3ji03cz+6l+fOGvTg/brV/CDIqbxIosWUZ
         0r9pC4qaFQyakteJenfRjqq9g3T2+1xWH3lH4ZAGwWNUPyurhGblWAaquLlKWr7Ap6
         RMMa9tEmYeGi9eUV278KqkIzJddMBvNOwxM7Y2ls=
Received: by mail-wr1-f43.google.com with SMTP id l9so11572085wrt.13;
        Mon, 17 Dec 2018 02:08:20 -0800 (PST)
X-Gm-Message-State: AA+aEWbjBlYu9kz1Vsgwr+w80SLozUHC8PlJ2CqfV4rGxNs5N2Fv+XGo
        LkCxB4N+PymsOXYu2RHZxuS098d5aKUAsDJSNb0=
X-Google-Smtp-Source: AFSGD/XzHEzNbX+pP9grNMFQx8tx/KrsCNPBJt27bEz9hXuLjx6Ns1QerQJu0tdmncqZhfC5fZrqEIvVRXlGnZYbEy4=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr9681710wrw.132.1545041298541;
 Mon, 17 Dec 2018 02:08:18 -0800 (PST)
MIME-Version: 1.0
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
 <1544506645-27979-2-git-send-email-long.cheng@mediatek.com>
 <CAGp9LzqB=hzkOHZqa-ZzRLcJujU--7gxYZczXiEj3DiH+FmhbQ@mail.gmail.com>
 <1544700985.28871.26.camel@mhfsdcap03> <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
 <1545035989.28871.41.camel@mhfsdcap03>
In-Reply-To: <1545035989.28871.41.camel@mhfsdcap03>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 17 Dec 2018 02:07:45 -0800
X-Gmail-Original-Message-ID: <CAGp9LzqFS5ku8-WE0Xc2xwztw9DumeU0DE4ZXbpH8w8u12LnOA@mail.gmail.com>
Message-ID: <CAGp9LzqFS5ku8-WE0Xc2xwztw9DumeU0DE4ZXbpH8w8u12LnOA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dmaengine: 8250_mtk_dma: add Mediatek uart DMA support
To:     long.cheng@mediatek.com
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        =?UTF-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, YT Shen <yt.shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:40 AM Long Cheng <long.cheng@mediatek.com> wrote:
>
> On Fri, 2018-12-14 at 12:09 -0800, Sean Wang wrote:

< ... >

> > > > > +
> > > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> > > > > +               mtk_dma_chan_write(c, VFF_LEN, rx_len);
> > > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> > > > > +               mtk_dma_chan_write(c,
> > > > > +                                  VFF_INT_EN, VFF_RX_INT_EN0_B
> > > > > +                                  | VFF_RX_INT_EN1_B);
> > > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> > > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > > >
> > > > I'd prefer to move those channel interrupt enablement to
> > > > .device_alloc_chan_resources
> > > > and related disablement to .device_free_chan_resources
> > > >
> > >
> > > i think that, first need set the config to HW, and the enable the DMA.
> > >
> >
> > I've read through the client driver and the dmaengine, I probably know
> > how interaction they work and find out there is something you seem
> > completely make a wrong.
> >
> > You can't do enable DMA with enabling VFF here. That causes a big
> > problem, DMA would self decide to move data and not managed and issued
> > by the dmaengine framework. For instance in DMA Tx path, because you
> > enable the DMA and DMA  buffer (VFF) and UART Tx ring uses the same
> > memory area,  DMA would self start to move data once data from
> > userland go in Tx ring even without being issued by dmaengine.
> >
> > Instead, you should ensure all descriptors are being batched by
> > .device_prep_slave_sg and DMA does not start moving data until
> > .device_issue_pending done and once descriptors are issued, DMA
> > hardware or software have to do it as fast as possible.
> >
>
> the VFF enable just enable the DMA function. DMA can't move data here.
> Now, the code get length of the data in '.device_prep_slave_sg'.
> And let DMA move data in '.device_issue_pending function'. in here, just
> enable the function.
>

My all curiosity are all from the descriptor programmed in
.device_issue_pending in the other drivers at least includes
information such data length, target address, and hardware control
code, but in the driver only includes data length and even the target
address is set up at device_config, that seems unusual.

And, It does too for DMA_DEV_TO_MEM?  What I see is there is almost no
any code be programmed for kick off the hardware for the direction but
DMA still can move. That is another point I got confused.

> > > > > +
> > > > > +               if (!c->requested) {
> > > > > +                       c->requested = true;
> > > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > > +                                         mtk_dma_rx_interrupt,
> > > > > +                                         IRQF_TRIGGER_NONE,
> > > > > +                                         KBUILD_MODNAME, chan);
> > > >
> > > > ISR registration usually happens as the driver got probe, it can give
> > > > the system more flexibility to manage such IRQ affinity on the fly.
> > > >
> > >
> > > i will move the request irq to alloc channel.
> > >
> >
> > why don't let it done in driver probe?
> >
> there are many uart ports, like UART[0-5]. in probe, just get the all
> irq of ports. which port is using, who request irq. example, UART1 is
> using. we just request irq of uart1. uart0, uart[2-5] don't need request
> irq.
>
> > > > > +                       if (ret < 0) {
> > > > > +                               dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +               }
> > > > > +       } else if (cfg->direction == DMA_MEM_TO_DEV)    {
> > > > > +               unsigned int tx_len = cfg->dst_addr_width * 1024;
> > > >
> > > > Ditto as above, it seems you should use cfg->dst_port_window_size
> > > >
> > > > > +
> > > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
> > > > > +               mtk_dma_chan_write(c, VFF_LEN, tx_len);
> > > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
> > > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> > > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > > >
> > > > ditto, I'd prefer to move those channel interrupt enablement to
> > > > .device_alloc_chan_resources and related disablement to
> > > > .device_free_chan_resources
> > > >
> > > > > +
> > > > > +               if (!c->requested) {
> > > > > +                       c->requested = true;
> > > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > > +                                         mtk_dma_tx_interrupt,
> > > > > +                                         IRQF_TRIGGER_NONE,
> > > > > +                                         KBUILD_MODNAME, chan);
> > > >
> > > > ditto, we can request ISR with devm_request_irq in the driver got
> > > > probe and trim the c->request member
> > > >
> > > > > +                       if (ret < 0) {
> > > > > +                               dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       if (mtkd->support_33bits)
> > > > > +               mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
> > > > > +
> > > > > +       if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {
> > > > > +               dev_err(chan->device->dev,
> > > > > +                       "config dma dir[%d] fail\n", cfg->direction);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int mtk_dma_terminate_all(struct dma_chan *chan)
> > > > > +{
> > > > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > > > +       unsigned long flags;
> > > > > +
> > > > > +       spin_lock_irqsave(&c->vc.lock, flags);
> > > > > +       list_del_init(&c->node);
> > > > > +       mtk_dma_stop(c);
> > > > > +       spin_unlock_irqrestore(&c->vc.lock, flags);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int mtk_dma_device_pause(struct dma_chan *chan)
> > > > > +{
> > > > > +       /* just for check caps pass */
> > > > > +       return -EINVAL;
> > > >
> > > > always return error code seems not the client driver wants us to do.
> > > >
> > > > maybe if the hardware doesn't support pause, we can make a software
> > > > pause, that waits until all active descriptors in hardware done, then
> > > > disable interrupt and then stop handling the following vd in the
> > > > vchan.
> > > >
> > > > > +}
> > >
> > > the code can't run. just for 8250 native code to check the function
> > > pointer. in the future, if the function useful, we can realize. thanks.
> > >
> >
> > Always return an error code looks like it's a faked function just to
> > pass the criteria check. It seems not a good idea.
> >
>
> yes, the function is fake. i just review the 8250 uart framework. there
> no check the return value of the function. so i can modify it to 'return
> 0'
>
> > > > > +
> > > > > +static int mtk_dma_device_resume(struct dma_chan *chan)
> > > > > +{
> > > > > +       /* just for check caps pass */
> > > > > +       return -EINVAL;
> >
> > < ... >
> >
> > > > > +static struct platform_driver mtk_dma_driver = {
> > > >
> > > > mtk_dma is much general and all functions and structures in the driver
> > > > should be all consistent.  I'd prefer to have all naming starts with
> > > > mtk_uart_apdma.
> > > >
> > >
> > > the function name and parameters' name, i will modify it. but before the
> > > 8250_mtk.c and the Doc. are recorded. if modify file name and Kconfig,
> > > will bring about the disorder. i suggest that after the patch is
> > > recorded, modify this. thanks.
> > >
> >
> > We can do it in separate patches and in a logical order for the
> > changes required across different subsystems.
> >
> > > > > +       .probe  = mtk_apdma_probe,
> > > >
> > > > such  as
> > > > mtk_uart_apdma_probe
> > > >
> > > > > +       .remove = mtk_apdma_remove,
> > > >
> > > > mtk_uart_apdma_remove
> > > >
> > > > > +       .driver = {
> > > > > +               .name           = KBUILD_MODNAME,
> > > > > +               .pm             = &mtk_dma_pm_ops,
> > > >
> > > > mtk_uart_apdma_pm_ops
> > > >
> > > > > +               .of_match_table = of_match_ptr(mtk_uart_dma_match),
> > > >
> > > > mtk_uart_apdma_match
> > > >
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +module_platform_driver(mtk_dma_driver);
> > > >
> > > > mtk_uart_apdma_driver
> > > >
> > > > > +
> > > > > +MODULE_DESCRIPTION("MediaTek UART APDMA Controller Driver");
> > > > > +MODULE_AUTHOR("Long Cheng <long.cheng@mediatek.com>");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > +
> > > > > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > > > > index 27bac0b..d399624 100644
> > > > > --- a/drivers/dma/mediatek/Kconfig
> > > > > +++ b/drivers/dma/mediatek/Kconfig
> > > > > @@ -1,4 +1,15 @@
> > > > >
> > > > > +config DMA_MTK_UART
> > > >
> > > > MTK_UART_APDMA to align the other drivers
> > > >
> > > > > +       tristate "MediaTek SoCs APDMA support for UART"
> > > > > +       depends on OF && SERIAL_8250_MT6577
> > > > > +       select DMA_ENGINE
> > > > > +       select DMA_VIRTUAL_CHANNELS
> > > > > +       help
> > > > > +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> > > > > +         when 8250 mtk uart is enabled, and if you want to using DMA,
> > > >
> > > > 8250 mtk uart should be changed to SERIAL_8250_MT6577 to be more intuitive
> > > >
> > > > > +         you can enable the config. the DMA engine just only be used
> > > > > +         with MediaTek Socs.
> > > >
> > > > SoCs
> > > >
> > > > > +
> > > > >  config MTK_HSDMA
> > > > >         tristate "MediaTek High-Speed DMA controller support"
> > > > >         depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > > diff --git a/drivers/dma/mediatek/Makefile b/drivers/dma/mediatek/Makefile
> > > > > index 6e778f8..2f2efd9 100644
> > > > > --- a/drivers/dma/mediatek/Makefile
> > > > > +++ b/drivers/dma/mediatek/Makefile
> > > > > @@ -1 +1,2 @@
> > > > > +obj-$(CONFIG_DMA_MTK_UART) += 8250_mtk_dma.o
> > > >
> > > > obj-$(CONFIG_MTK_UART_APDMA) += mtk-uart-apdma.o
> > > > to align the other dirvers
> > > >
> > > > >  obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
> > > > > --
> > > > > 1.7.9.5
> > > > >
> > >
> > >
>
>
