Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58228C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2906E21855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfAYJfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:35:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38361 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:35:36 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gmxta-0001gw-Ol; Fri, 25 Jan 2019 10:35:30 +0100
Message-ID: <1548408930.28802.34.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible
 parts
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 25 Jan 2019 10:35:30 +0100
In-Reply-To: <20190125025528.15645-3-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190125025528.15645-1-angus@akkea.ca>
         <20190125025528.15645-3-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 24.01.2019, 19:55 -0700 schrieb Angus Ainslie (Purism):
> This is identical to the imx7d data structures but we need to
> be able to differentiate that the imx8mq has 2 sdma controllers.

No, we don't, see comment on patch 4/5. This can reuse the imx7d data.

Regards,
Lucas

> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/dma/imx-sdma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5e5ef0b5a973..ec6fb48f387a 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -556,6 +556,12 @@ static struct sdma_driver_data sdma_imx7d = {
> >  	.script_addrs = &sdma_script_imx7d,
>  };
>  
> +static struct sdma_driver_data sdma_imx8mq = {
> > +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> > +	.num_events = 48,
> > +	.script_addrs = &sdma_script_imx7d,
> +};
> +
>  static const struct platform_device_id sdma_devtypes[] = {
> >  	{
> >  		.name = "imx25-sdma",
> @@ -578,6 +584,9 @@ static const struct platform_device_id sdma_devtypes[] = {
> >  	}, {
> >  		.name = "imx7d-sdma",
> >  		.driver_data = (unsigned long)&sdma_imx7d,
> > +	}, {
> > +		.name = "imx8mq-sdma",
> > +		.driver_data = (unsigned long)&sdma_imx8mq,
> >  	}, {
> >  		/* sentinel */
> >  	}
> @@ -592,6 +601,7 @@ static const struct of_device_id sdma_dt_ids[] = {
> >  	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
> >  	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
> >  	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
> > +	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
> >  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdma_dt_ids);
