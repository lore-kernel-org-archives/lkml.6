Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BEBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A250321476
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A250321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHFLBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:01:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34783 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeHFLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:01:10 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmbGF-0002yi-Br; Mon, 06 Aug 2018 10:53:07 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fmbGC-0007cx-1Q; Mon, 06 Aug 2018 10:53:04 +0200
Date:   Mon, 6 Aug 2018 10:53:03 +0200
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
Subject: Re: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
Message-ID: <20180806085303.rn63s2kdeovlth2j@pengutronix.de>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
 <1531487327-21879-3-git-send-email-yibin.gong@nxp.com>
 <20180713061604.tza3udckmyaoq5wh@pengutronix.de>
 <DB6PR04MB3223F5A07E59F173D5BD0B6D89510@DB6PR04MB3223.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB6PR04MB3223F5A07E59F173D5BD0B6D89510@DB6PR04MB3223.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:48:22 up 54 days, 17:57, 55 users,  load average: 0.17, 0.58,
 0.51
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 09:40:51AM +0000, Robin Gong wrote:
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > Sent: 2018年7月13日 14:16
> > To: Robin Gong <yibin.gong@nxp.com>
> > Cc: vkoul@kernel.org; dan.j.williams@intel.com; shawnguo@kernel.org; Fabio
> > Estevam <fabio.estevam@nxp.com>; linux@armlinux.org.uk;
> > linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
> > 
> > On Fri, Jul 13, 2018 at 09:08:46PM +0800, Robin Gong wrote:
> > > Add MEMCPY capability for imx-sdma driver.
> > >
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > ---
> > >  drivers/dma/imx-sdma.c | 95
> > > ++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 92 insertions(+), 3 deletions(-)
> > >
> > > @@ -1318,6 +1347,63 @@ static struct sdma_desc
> > *sdma_transfer_init(struct sdma_channel *sdmac,
> > >  	return NULL;
> > >  }
> > >
> > > +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> > > +		struct dma_chan *chan, dma_addr_t dma_dst,
> > > +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> > > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > > +	struct sdma_engine *sdma = sdmac->sdma;
> > > +	int channel = sdmac->channel;
> > > +	size_t count;
> > > +	int i = 0, param;
> > > +	struct sdma_buffer_descriptor *bd;
> > > +	struct sdma_desc *desc;
> > > +
> > > +	if (!chan || !len)
> > > +		return NULL;
> > > +
> > > +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
> > > +		&dma_src, &dma_dst, len, channel);
> > > +
> > > +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
> > > +					len / SDMA_BD_MAX_CNT + 1);
> > > +	if (!desc)
> > > +		return NULL;
> > > +
> > > +	do {
> > > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > > +		bd = &desc->bd[i];
> > > +		bd->buffer_addr = dma_src;
> > > +		bd->ext_buffer_addr = dma_dst;
> > > +		bd->mode.count = count;
> > > +		desc->chn_count += count;
> > > +		/* align with sdma->dma_device.copy_align: 4bytes */
> > > +		bd->mode.command = 0;
> > > +
> > > +		dma_src += count;
> > > +		dma_dst += count;
> > > +		len -= count;
> > > +		i++;
> > 
> > NACK.
> > 
> > Please actually look at your code and find out where you do unaligned DMA
> > accesses. Hint: What happens when this loop body is executed more than
> > once?
> > 
> > Sascha
> Actually internal sdma script has already take such 'align' matter like below:
> Burst with words if source/dest address and data length are all aligned with words, burst with
> Byte if not.

If that's the case why did you add the DMAENGINE_ALIGN_4_BYTES flag in the
first place?

Also, if the SDMA script falls back to byte copy when necessary, doing
so probably has performance impacts, so I wonder why you don't just cut
'count' to something that is four byte aligned.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
