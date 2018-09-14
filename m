Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE05ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1642083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Jky9QXDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1642083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeINTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:09:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36336 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeINTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:09:37 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8739FCE;
        Fri, 14 Sep 2018 15:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536933074;
        bh=Jut+6EaRzIXGHgcH1Xs1/BcZ717S3UkXLYodY7y92eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jky9QXDRCrRguWMc9T0qiq4DY/pGv1GpOXSY/ooS/0gK2lEvCqVOj5kMRA1qmho3K
         hCiKbfqj7aWhLZH/op9mgQ2fWAkhdZGtkQAE+tVpP2rsznKakgAKpkLC8OuXoBWvge
         DXWnEfFmMkRkFnYELpx/WQ+HDZkDNKgMg2Bzx174=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: Remove packed VYUY support
Date:   Fri, 14 Sep 2018 16:51:28 +0300
Message-ID: <1759929.4apJ9N5u4E@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180914132149.26354-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180914132149.26354-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 14 September 2018 16:21:49 EEST Kieran Bingham wrote:
> The Gen3 VSP used by the DU for display does not support packed the VYUY
> pixel format. Gen2 VSP hardware is able to process this format, but it
> is not officially supported there either and thus it's output can not be
> guaranteed.

I think we could guarantee proper operation on Gen2, but as DU + VSP operation 
isn't enabled in the drivers by default, and as the VYUY format isn't a 
strategic target, I think we can ignore that.

How about updating the commit message as follows ?

"The Gen3 VSP used by the DU for display does not support packed the VYUY 
pixel format. Gen2 VSP hardware is able to process this format, but DU + VSP 
operation isn't enabled on Gen2, and VYUY isn't a strategic format, so it can 
be ignored."

> Remove the format from the capabilities of the DU driver.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c index 4480243813ec..4576119e7777
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -126,7 +126,6 @@ static const u32 formats_kms[] = {
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_UYVY,
> -	DRM_FORMAT_VYUY,
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YVYU,
>  	DRM_FORMAT_NV12,
> @@ -155,7 +154,6 @@ static const u32 formats_v4l2[] = {
>  	V4L2_PIX_FMT_ABGR32,
>  	V4L2_PIX_FMT_XBGR32,
>  	V4L2_PIX_FMT_UYVY,
> -	V4L2_PIX_FMT_VYUY,
>  	V4L2_PIX_FMT_YUYV,
>  	V4L2_PIX_FMT_YVYU,
>  	V4L2_PIX_FMT_NV12M,

-- 
Regards,

Laurent Pinchart



