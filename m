Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C1A207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="r1/0bv7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfBUXbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:31:03 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49860 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBUXbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:31:03 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53D17255;
        Fri, 22 Feb 2019 00:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550791860;
        bh=gUjRp+Du1mxA0tDbAd3yUT5HfdbgXs7AKHcKCOgYB0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1/0bv7z2nl3tCuUxrrvFjduwiehwQNn5IyNwKDcTLcQDxJNTYJKwtOrcNmtpcAns
         d8W7LM5VdxftGgXF3uJ7o1lQAAGV/ijcrX/8irfq5x6WSRTyiPbULQQr6jXDOU+QkR
         w8eLMWnzPWiCfT/2J+gsSGdThd9r+bagfMdseIcM=
Date:   Fri, 22 Feb 2019 01:30:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/bridge: cdns: Remove set but not used variable
 'bpp'
Message-ID: <20190221233055.GI3485@pendragon.ideasonboard.com>
References: <20190216073459.194792-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190216073459.194792-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

Thank you for the patch.

On Sat, Feb 16, 2019 at 07:34:59AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/bridge/cdns-dsi.c: In function 'cdns_dsi_bridge_enable':
> drivers/gpu/drm/bridge/cdns-dsi.c:986:6: warning:
>  variable 'bpp' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 6166dca6be81..07ee1685fdfe 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -785,13 +785,12 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
>  	unsigned long tx_byte_period;
>  	struct cdns_dsi_cfg dsi_cfg;
>  	u32 tmp, reg_wakeup, div;
> -	int bpp, nlanes;
> +	int nlanes;
>  
>  	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
>  		return;
>  
>  	mode = &bridge->encoder->crtc->state->adjusted_mode;
> -	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
>  	nlanes = output->dev->lanes;
>  
>  	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));

-- 
Regards,

Laurent Pinchart
