Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE7C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F94820882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F94820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeIMNrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:47:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36935 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIMNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:47:39 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g0N9J-00038v-Ug; Thu, 13 Sep 2018 10:38:53 +0200
Message-ID: <1536827930.3452.4.camel@pengutronix.de>
Subject: Re: [PATCH v2 6/8] drm/imx: support handling bridge timings bus
 flags
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, linus.walleij@linaro.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 10:38:50 +0200
In-Reply-To: <20180912183222.25414-7-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
         <20180912183222.25414-7-stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 11:32 -0700, Stefan Agner wrote:
> A bridge might require specific settings for the pixel data on
> the bus.

On which bus? The bridge has input and output.

> Copy the bus flags from the bridge timings if a bridge
> is in use.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index aefd04e18f93..7798a0621df7 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
>  	if (ret && ret != -ENODEV)
>  		return ret;
>  
> +	if (imxpd->bridge && imxpd->bridge->timings)
> +		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;

Oh, ok. I'd also specify input bus in the commit message.

> +
>  	imxpd->dev = dev;
>  
>  	ret = imx_pd_register(drm, imxpd);

regards
Philipp
