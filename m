Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7EAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE482133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbeLQL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:57:21 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:51786 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727255AbeLQL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:57:21 -0500
X-UUID: 2420496297034a8c81cef50108929910-20181217
X-UUID: 2420496297034a8c81cef50108929910-20181217
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1336393856; Mon, 17 Dec 2018 19:57:08 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Dec
 2018 19:57:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 19:57:06 +0800
Message-ID: <1545047826.28871.69.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/2] dmaengine: 8250_mtk_dma: add Mediatek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?= 
        <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>,
        Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= 
        <sean.wang@mediatek.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Date:   Mon, 17 Dec 2018 19:57:06 +0800
In-Reply-To: <CAGp9LzqFS5ku8-WE0Xc2xwztw9DumeU0DE4ZXbpH8w8u12LnOA@mail.gmail.com>
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
         <1544506645-27979-2-git-send-email-long.cheng@mediatek.com>
         <CAGp9LzqB=hzkOHZqa-ZzRLcJujU--7gxYZczXiEj3DiH+FmhbQ@mail.gmail.com>
         <1544700985.28871.26.camel@mhfsdcap03>
         <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
         <1545035989.28871.41.camel@mhfsdcap03>
         <CAGp9LzqFS5ku8-WE0Xc2xwztw9DumeU0DE4ZXbpH8w8u12LnOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 02:07 -0800, Sean Wang wrote:
> On Mon, Dec 17, 2018 at 12:40 AM Long Cheng <long.cheng@mediatek.com> wrote:
> >
> > On Fri, 2018-12-14 at 12:09 -0800, Sean Wang wrote:
> 
> < ... >
> 
> > > > > > +
> > > > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> > > > > > +               mtk_dma_chan_write(c, VFF_LEN, rx_len);
> > > > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> > > > > > +               mtk_dma_chan_write(c,
> > > > > > +                                  VFF_INT_EN, VFF_RX_INT_EN0_B
> > > > > > +                                  | VFF_RX_INT_EN1_B);
> > > > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> > > > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > > > >
> > > > > I'd prefer to move those channel interrupt enablement to
> > > > > .device_alloc_chan_resources
> > > > > and related disablement to .device_free_chan_resources
> > > > >
> > > >
> > > > i think that, first need set the config to HW, and the enable the DMA.
> > > >
> > >
> > > I've read through the client driver and the dmaengine, I probably know
> > > how interaction they work and find out there is something you seem
> > > completely make a wrong.
> > >
> > > You can't do enable DMA with enabling VFF here. That causes a big
> > > problem, DMA would self decide to move data and not managed and issued
> > > by the dmaengine framework. For instance in DMA Tx path, because you
> > > enable the DMA and DMA  buffer (VFF) and UART Tx ring uses the same
> > > memory area,  DMA would self start to move data once data from
> > > userland go in Tx ring even without being issued by dmaengine.
> > >
> > > Instead, you should ensure all descriptors are being batched by
> > > .device_prep_slave_sg and DMA does not start moving data until
> > > .device_issue_pending done and once descriptors are issued, DMA
> > > hardware or software have to do it as fast as possible.
> > >
> >
> > the VFF enable just enable the DMA function. DMA can't move data here.
> > Now, the code get length of the data in '.device_prep_slave_sg'.
> > And let DMA move data in '.device_issue_pending function'. in here, just
> > enable the function.
> >
> 
> My all curiosity are all from the descriptor programmed in
> .device_issue_pending in the other drivers at least includes
> information such data length, target address, and hardware control
> code, but in the driver only includes data length and even the target
> address is set up at device_config, that seems unusual.
> 
> And, It does too for DMA_DEV_TO_MEM?  What I see is there is almost no
> any code be programmed for kick off the hardware for the direction but
> DMA still can move. That is another point I got confused.
> 

8250_dma in tty, mapping xmit buffer to DMA buffer. and the tx just use
the only one buffer. it's ring buffer. 8250_dma set the begin address
and length of the buffer by means of '.deivce_config' function. 
when TX happen, tty_write will write data to xmit buffer. in 8250_dma,
will set the address and length of the data by means of
'.device_prep_slave_sg'. but the address is in the xmit buffer rang. the
WPT(write pointer), RPT(read pointer) registers are recored the DMA data
transfer status, include the current location of transmission. and the
apdma is only for UART. So don't need recored the the address of data ,
target address in '.device_prep_slave_sg'.
in '.device_issue_pending', just using the data length from descriptor,
WPT ,  we can figure out what's data need to move. then update the WPT
and flush TX.

RX too. RX use other buffer in instead of XMIT buffer. when RX interrupt
coming, will update the RPT, and 8250_dma will get the length from vchan
complete. then 8250_dma can get the data.

> > > > > > +
> > > > > > +               if (!c->requested) {
> > > > > > +                       c->requested = true;
> > > > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > > > +                                         mtk_dma_rx_interrupt,
> > > > > > +                                         IRQF_TRIGGER_NONE,
> > > > > > +                                         KBUILD_MODNAME, chan);
> > > > >
> > > > > ISR registration usually happens as the driver got probe, it can give
> > > > > the system more flexibility to manage such IRQ affinity on the fly.
> > > > >
> > > >
> > > > i will move the request irq to alloc channel.
> > > >
> > >
> > > why don't let it done in driver probe?
> > >
> > there are many uart ports, like UART[0-5]. in probe, just get the all
> > irq of ports. which port is using, who request irq. example, UART1 is
> > using. we just request irq of uart1. uart0, uart[2-5] don't need request
> > irq.
> >
> > > > > > +                       if (ret < 0) {
> > > > > > +                               dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
> > > > > > +                               return -EINVAL;
> > > > > > +                       }
> > > > > > +               }
> > > > > > +       } else if (cfg->direction == DMA_MEM_TO_DEV)    {
> > > > > > +               unsigned int tx_len = cfg->dst_addr_width * 1024;
> > > > >
> > > > > Ditto as above, it seems you should use cfg->dst_port_window_size
> > > > >
> > > > > > +
> > > > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
> > > > > > +               mtk_dma_chan_write(c, VFF_LEN, tx_len);
> > > > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
> > > > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> > > > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > > > >
> > > > > ditto, I'd prefer to move those channel interrupt enablement to
> > > > > .device_alloc_chan_resources and related disablement to
> > > > > .device_free_chan_resources
> > > > >
> > > > > > +
> > > > > > +               if (!c->requested) {
> > > > > > +                       c->requested = true;
> > > > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > > > +                                         mtk_dma_tx_interrupt,
> > > > > > +                                         IRQF_TRIGGER_NONE,
> > > > > > +                                         KBUILD_MODNAME, chan);
> > > > >
> > > > > ditto, we can request ISR with devm_request_irq in the driver got
> > > > > probe and trim the c->request member
> > > > >
> > > > > > +                       if (ret < 0) {
> > > > > > +                               dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
> > > > > > +                               return -EINVAL;
> > > > > > +                       }
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > > +       if (mtkd->support_33bits)
> > > > > > +               mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
> > > > > > +
> > > > > > +       if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {
> > > > > > +               dev_err(chan->device->dev,
> > > > > > +                       "config dma dir[%d] fail\n", cfg->direction);
> > > > > > +               return -EINVAL;
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
< ... >

