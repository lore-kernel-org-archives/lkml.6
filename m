Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4891DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C212089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cHcWw+RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C212089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeJPG6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:58:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56214 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeJPG6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:58:47 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B9A61A81;
        Tue, 16 Oct 2018 01:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539645081;
        bh=001rRNPyrySGqbEQWFBWXHB3iS4JlAVH7mwlUttDnPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHcWw+RVB/rBCTVHEFtLMXlGA4iv7+A6/Iiw6YRcGAWY6Vn+7ZIFDP/O0WPnjFIxj
         JeFNZAnBurldAqSM1I5uvJjv+a+dw7C8z3UlGRj5i4yNxgTbpWGKcvAx2xpx/a3rwW
         /osdHJ17gEt6GPDVx13HCT2aodjWTBr+WApE9Bmg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        zain wang <wzz@rock-chips.com>,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix misleading indentation reported by smatch
Date:   Tue, 16 Oct 2018 02:11:28 +0300
Message-ID: <3089039.JAYFEciPKB@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181013111844.22183-1-enric.balletbo@collabora.com>
References: <20181013111844.22183-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Saturday, 13 October 2018 14:18:44 EEST Enric Balletbo i Serra wrote:
> This patch avoids that building the bridge/analogix source code with
> smatch triggers complaints about inconsistent indenting.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c index
> d68986cea132..75e2649d7515 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1219,12 +1219,12 @@ static int analogix_dp_bridge_attach(struct
> drm_bridge *bridge) * plat_data->attch return, that's why we record the
> connector
>  	 * point after plat attached.
>  	 */
> -	 if (dp->plat_data->attach) {
> -		 ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
> -		 if (ret) {
> -			 DRM_ERROR("Failed at platform attch func\n");
> -			 return ret;
> -		 }
> +	if (dp->plat_data->attach) {
> +		ret = dp->plat_data->attach(dp->plat_data, bridge, connector);
> +		if (ret) {
> +			DRM_ERROR("Failed at platform attch func\n");
> +			return ret;
> +		}
>  	}

This looks good to me. While at it, could you s/attch/attach/ ? With that 
fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	if (dp->plat_data->panel) {

-- 
Regards,

Laurent Pinchart



