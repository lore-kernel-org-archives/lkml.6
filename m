Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FC3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC89218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeLZKTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:19:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:61831 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726172AbeLZKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:19:05 -0500
X-UUID: 15faf0724f9f490aae9a4cd03de26b4b-20181226
X-UUID: 15faf0724f9f490aae9a4cd03de26b4b-20181226
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 454183028; Wed, 26 Dec 2018 18:18:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Dec
 2018 18:18:56 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 18:18:54 +0800
Message-ID: <1545819534.28871.93.camel@mhfsdcap03>
Subject: Re: [PATCH v7 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Date:   Wed, 26 Dec 2018 18:18:54 +0800
In-Reply-To: <CANMq1KDKqtKwSw1mJyR0TgBwY1YRfvY52vWyogqWweF3xAgiKA@mail.gmail.com>
References: <1545701209-6884-1-git-send-email-long.cheng@mediatek.com>
         <1545701209-6884-2-git-send-email-long.cheng@mediatek.com>
         <CANMq1KA1ywLnQDzXRbLcuu-afXuj_yrprRBC4kejF4-20ztXyA@mail.gmail.com>
         <1545739611.28871.77.camel@mhfsdcap03>
         <CANMq1KDtUgOUFRy-TyQK0EmbpXGtLEVo9Mqg1Hvs0JoL9NrFyQ@mail.gmail.com>
         <1545806121.28871.88.camel@mhfsdcap03>
         <CANMq1KDKqtKwSw1mJyR0TgBwY1YRfvY52vWyogqWweF3xAgiKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-26 at 17:28 +0800, Nicolas Boichat wrote:

......

> > > > > > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > > > > > +{
> > > > > > +       /* just for check caps pass */
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int mtk_uart_apdma_device_resume(struct dma_chan *chan)
> > > > > > +{
> > > > > > +       /* just for check caps pass */
> > > > > > +       return 0;
> > > > > > +}
> > >
> > > Why do you need these? Seems wrong to advertise device_pause/resume
> > > (and the caps) if we don't actually support that?
> > >
> >
> > in serial 8250_dma.c file, when request DMA, will calll
> > 'dma_get_slave_caps' to get the caps. and the will check caps.cmd_pause.
> > the pause is device_pause.  our device can't support the functions. but
> > to check pass, need add the fake function. or you can give better
> > comments. thanks.
> 
> Well, then I guess this is a hack... I'm not too familiar with
> 8250_dma.c, but I guess that if it requires pause/resume to be
> implemented, then we should implement them, not just stub them out...
> 
> Is this something that can be implemented with 8250_mtk DMA?
> 

the HW can't support it.

> Also, I don't see where you need resume, so maybe implementing pause is enough?
> 

yes. pause is enough. for symmetry, add resume function.
anyway, the pause function need to keep.

> > > > > > +
> > > > > > +static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
> > > > > > +{
> > > > > > +       while (list_empty(&mtkd->ddev.channels) == 0) {
> > > > > > +               struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> > > > > > +                       struct mtk_chan, vc.chan.device_node);
> > > > > > +
> > > > > > +               list_del(&c->vc.chan.device_node);
> > > > > > +               tasklet_kill(&c->vc.task);
> > > > > > +       }
> > > > > > +}
> > > > > > +
> > > > > > +static const struct of_device_id mtk_uart_apdma_match[] = {
> > > > > > +       { .compatible = "mediatek,mt6577-uart-dma", },
> > > > > > +       { /* sentinel */ },
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(of, mtk_uart_apdma_match);
> > > > > > +
> > > > > > +static int mtk_uart_apdma_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +       struct mtk_uart_apdmadev *mtkd;
> > > > > > +       struct resource *res;
> > > > > > +       struct mtk_chan *c;
> > > > > > +       unsigned int i;
> > > > > > +       int rc;
> > > > > > +

......


