Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684ACC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FA2208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FA2208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeGKHLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:11:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50583 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeGKHLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:11:47 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fd9FB-00037Z-JE; Wed, 11 Jul 2018 09:08:57 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fd9FA-0001jn-It; Wed, 11 Jul 2018 09:08:56 +0200
Date:   Wed, 11 Jul 2018 09:08:56 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Message-ID: <20180711070856.tk6hjivns7zpdtqe@pengutronix.de>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
 <DB6PR04MB3223B22099D9C7A079608409895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711070107.roscdmzw4pbyvia6@pengutronix.de>
 <DB6PR04MB32238D762101425CC0CEE0F2895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB6PR04MB32238D762101425CC0CEE0F2895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:06:39 up 28 days, 16:15, 47 users,  load average: 0.09, 0.23,
 0.17
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:05:23AM +0000, Robin Gong wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > Sent: 2018年7月11日 15:01
> > To: Robin Gong <yibin.gong@nxp.com>
> > Cc: vkoul@kernel.org; dan.j.williams@intel.com; shawnguo@kernel.org; Fabio
> > Estevam <fabio.estevam@nxp.com>; linux@armlinux.org.uk;
> > linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
> > 
> > On Wed, Jul 11, 2018 at 06:56:18AM +0000, Robin Gong wrote:
> > >
> > > > -----Original Message-----
> > > > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > > > Sent: 2018年7月11日 14:25
> > > > To: Robin Gong <yibin.gong@nxp.com>
> > > > Cc: vkoul@kernel.org; dan.j.williams@intel.com; shawnguo@kernel.org;
> > > > Fabio Estevam <fabio.estevam@nxp.com>; linux@armlinux.org.uk;
> > > > linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de;
> > > > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy
> > > > interface
> > > >
> > > > On Wed, Jul 11, 2018 at 12:23:10AM +0800, Robin Gong wrote:
> > > > > Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead of
> > > > > '0xffff'.
> > > > >
> > > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > > ---
> > > > > +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> > > > > +		struct dma_chan *chan, dma_addr_t dma_dst,
> > > > > +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> > > > > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > > > > +	struct sdma_engine *sdma = sdmac->sdma;
> > > > > +	int channel = sdmac->channel;
> > > > > +	size_t count;
> > > > > +	int i = 0, param;
> > > > > +	struct sdma_buffer_descriptor *bd;
> > > > > +	struct sdma_desc *desc;
> > > > > +
> > > > > +	if (!chan || !len)
> > > > > +		return NULL;
> > > > > +
> > > > > +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu,
> > channel=%d.\n",
> > > > > +		&dma_src, &dma_dst, len, channel);
> > > > > +
> > > > > +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len /
> > > > SDMA_BD_MAX_CNT
> > > > > +					+ 1);
> > > > > +	if (!desc)
> > > > > +		goto err_out;
> > > > > +
> > > > > +	do {
> > > > > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > > >
> > > > When len is bigger than 0xffff you initialize count to 0xffff...
> > > In this case, the data will be split into several bds, for example, If
> > > the total count is 0x10000, two bd used then. One is for 0xffff,
> > > Another is for the last 1
> > 
> > And you are doing byte size DMA? Wouldn't word size accesses be more
> > optimal?
> > 
> > Sascha
> Default is words, and I'll force the buswidth to word and set into BD.
> sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;

So guess which alignment the second transfer has when the first has the
size 0xffff.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
