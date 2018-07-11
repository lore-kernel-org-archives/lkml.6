Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEE7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F142208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2laRGtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F142208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeGKHWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeGKHWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:22:06 -0400
Received: from localhost (unknown [106.200.243.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EED420846;
        Wed, 11 Jul 2018 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531293554;
        bh=9vrpgi0dDVX+xaYbQuWvAbjs/p8A6EmaxG2aDszvNzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2laRGtS8KXL3TgLJTkF0tIndqRY2QFz1WFb4KBUZKRfMFaArguWiGgp1ff7ZzrTF
         9nTQxl1VDZbViI2L42+IqETCKh/yBw7nfRHCm7aUOYUDS7MnIfDJqlNIH+yRwY4u5l
         tmAGdwv2RzkOzCsYnDD6y7nW+C3UNIZreDPL+YBA=
Date:   Wed, 11 Jul 2018 12:49:05 +0530
From:   Vinod <vkoul@kernel.org>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Message-ID: <20180711071905.GN3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
 <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-18, 08:53, s.hauer@pengutronix.de wrote:
> On Wed, Jul 11, 2018 at 06:37:02AM +0000, Robin Gong wrote:
> > 
> > > -----Original Message-----
> > > From: Vinod [mailto:vkoul@kernel.org]
> > > Sent: 2018年7月10日 23:33
> > > To: Robin Gong <yibin.gong@nxp.com>
> > > Cc: dan.j.williams@intel.com; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org;
> > > kernel@pengutronix.de; dmaengine@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
> > > 
> > > On 11-07-18, 00:23, Robin Gong wrote:
> > > > dmatest(memcpy) will never call dmaengine_slave_config before prep,
> > > 
> > > and that should have been a hint to you that you should not expect that
> > > 
> > > > so jobs in dmaengine_slave_config need to be moved into somewhere
> > > > before device_prep_dma_memcpy. Besides, dmatest never setup chan
> > > > ->private as other common case like uart/audio/spi will always setup
> > > > chan->private. Here check it to judge if it's dmatest case and do
> > > > jobs in slave_config.
> > > 
> > > and you should not do anything for dmatest. Supporting it means memcpy
> > > implementation is not correct :)
> > Okay, I will any word about dmatest here since memcpy assume no calling
> > slave_config.
> > > 
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > ---
> > > >  drivers/dma/imx-sdma.c | 37 ++++++++++++++++++++++++++++---------
> > > >  1 file changed, 28 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > > ed2267d..48f3749 100644
> > > > --- a/drivers/dma/imx-sdma.c
> > > > +++ b/drivers/dma/imx-sdma.c
> > > > @@ -1222,10 +1222,36 @@ static int sdma_alloc_chan_resources(struct
> > > > dma_chan *chan)  {
> > > >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > > >  	struct imx_dma_data *data = chan->private;
> > > > +	struct imx_dma_data default_data;
> > > >  	int prio, ret;
> > > >
> > > > -	if (!data)
> > > > -		return -EINVAL;
> > > > +	ret = clk_enable(sdmac->sdma->clk_ipg);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	ret = clk_enable(sdmac->sdma->clk_ahb);
> > > > +	if (ret)
> > > > +		goto disable_clk_ipg;
> > > > +	/*
> > > > +	 * dmatest(memcpy) will never call dmaengine_slave_config before prep,
> > > > +	 * so jobs in dmaengine_slave_config need to be moved into somewhere
> > > > +	 * before device_prep_dma_memcpy. Besides, dmatest never setup chan
> > > > +	 * ->private as other common cases like uart/audio/spi will setup
> > > > +	 * chan->private always. Here check it to judge if it's dmatest case
> > > > +	 * and do jobs in slave_config.
> > > > +	 */
> > > > +	if (!data) {
> > > > +		dev_warn(sdmac->sdma->dev, "dmatest is running?\n");
> > > 
> > > why is that a warning!
> > Current SDMA driver assume filter function to set chan->private with specific data 
> > (struct imx_dma_data dma_data)like below (sound/soc/fsl/fsl_asrc_dma.c):
> > static bool filter(struct dma_chan *chan, void *param)
> > {
> >         if (!imx_dma_is_general_purpose(chan))
> >                 return false;
> >         chan->private = param;
> >         return true;
> > }
> > 
> > But in memcpy case, at lease dmatest case, no chan->private set in its filter function.
> > So here take dmatest a special case and do some prepare jobs for memcpy. But if the
> > Upper device driver call dma_request_channel() with their specific filter without
> > 'chan->private' setting in the future. The warning message is a useful hint to them to
> > Add 'chan->private' in filter function.  Or doc it somewhere?
> 
> Instead of doing heuristics to guess whether we are doing memcpy you
> could instead make memcpy the default when slave_config is not called,
> i.e. drop the if (!data) check completely.
> 
> > > 
> > > > +		sdmac->word_size  =  sdmac->sdma->dma_device.copy_align;
> > > > +		default_data.priority = 2;
> > > > +		default_data.peripheral_type = IMX_DMATYPE_MEMORY;
> > > > +		default_data.dma_request = 0;
> > > > +		default_data.dma_request2 = 0;
> > > > +		data = &default_data;
> > > > +
> > > > +		sdma_config_ownership(sdmac, false, true, false);
> > > > +		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
> > > > +		sdma_load_context(sdmac);
> > > > +	}
> > > 
> > > this needs to be default for memcpy
> 
> The problem seems to be that we do not know whether we are doing memcpy
> or not. Normally we get the information how a channel is to be
> configured in dma_device->device_config, but this function is not called
> in the memcpy case.

Not really true, device_config only provides parameters to be
configured for next slave transaction

> An alternative might also be to do the setup in dma_device->device_prep_dma_memcpy.

Precisely, see how other drivers do this

Let's roll back a bit and foresee why is this required.

In case of memcpy, you need to tell DMA to do transfer from src to dstn
and size. Additional parameters like buswidth etc should be derived for
maximum throughput (after all we are dma, people want it to be done
fastest)

Now for slave, you are interfacing with a peripheral and don't know how
that is setup. So you need to match the parameters, otherwise you get
overflow or underflow and hence need for device_config

Please do not derive additional notions from these, please do not assume
anything else, unless provided in documentation :)

In doubt, just ask!

HTH
-- 
~Vinod
