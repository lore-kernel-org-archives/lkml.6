Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7BEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A334E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfA1JcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:32:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56577 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1JcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:32:12 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1go3Gw-0007wX-09; Mon, 28 Jan 2019 10:32:06 +0100
Message-ID: <85151aee51eca63d4a664b38837930c53cf8e7c1.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible
 parts
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 28 Jan 2019 10:32:04 +0100
In-Reply-To: <20190128060840.31695-3-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190128060840.31695-1-angus@akkea.ca>
         <20190128060840.31695-3-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 27.01.2019, 23:08 -0700 schrieb Angus Ainslie (Purism):
> This is identical to the imx7d.

So it can be dropped and the i.MX8M DT should just specify the
"fsl,imx7d-sdma" as a fallback compatible for the SDMA codes.

If both the imx8m and imx7d compatible are present in the DT, we can
introduce a more specific matchic when we actually need it. No need to
pollute the code with this from the start.

Regards,
Lucas

> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/dma/imx-sdma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 757fad2fbfae..c4db4fe6bcc9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -578,6 +578,9 @@ static const struct platform_device_id
> sdma_devtypes[] = {
>  	}, {
>  		.name = "imx7d-sdma",
>  		.driver_data = (unsigned long)&sdma_imx7d,
> +	}, {
> +		.name = "imx8mq-sdma",
> +		.driver_data = (unsigned long)&sdma_imx7d,
>  	}, {
>  		/* sentinel */
>  	}
> @@ -592,6 +595,7 @@ static const struct of_device_id sdma_dt_ids[] =
> {
>  	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
>  	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
>  	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
> +	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx7d, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdma_dt_ids);

