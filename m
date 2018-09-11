Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A884C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81B820880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aBsc7rlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81B820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeILCah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:30:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46506 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeILCah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:30:37 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A252E992;
        Tue, 11 Sep 2018 23:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536701363;
        bh=qW9HWvevWV5F6NlH/0K2Oajlw9gYktfTXNp4VcaFqQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBsc7rlKXeo3jKf5XlYDWyMgUaoV5QEBih8IUaqxb49Ee0PcINNbDp5thRWQPaos5
         qqt85i9cUcH6XZr78yCFmU9B/J0qWhfPqTn2jCUdu1wEpgD7jwN9Qlwa6g6PiT0/+c
         zknxgzh+8TRcrafCVXA5msDVgOKupOTVs/1AFgdc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/omap: remove set but not used variable 'frame_height'
Date:   Wed, 12 Sep 2018 00:29:34 +0300
Message-ID: <30141949.h7u3WbzelH@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1536667253-5792-1-git-send-email-yuehaibing@huawei.com>
References: <1536667253-5792-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

Thank you for the patch.

On Tuesday, 11 September 2018 15:00:53 EEST YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/omapdrm/dss/dispc.c: In function 'dispc_ovl_setup_common':
> drivers/gpu/drm/omapdrm/dss/dispc.c:2627:19: warning:
>  variable 'frame_height' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I expect Tomi to pick this patch up, but I've also applied it to my tree to 
make sure it won't get lost.

> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c
> b/drivers/gpu/drm/omapdrm/dss/dispc.c index e61a959..7c23f23 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -2624,7 +2624,7 @@ static int dispc_ovl_setup_common(struct dispc_device
> *dispc, unsigned int offset0, offset1;
>  	s32 row_inc;
>  	s32 pix_inc;
> -	u16 frame_width, frame_height;
> +	u16 frame_width;
>  	unsigned int field_offset = 0;
>  	u16 in_height = height;
>  	u16 in_width = width;
> @@ -2714,13 +2714,10 @@ static int dispc_ovl_setup_common(struct
> dispc_device *dispc, row_inc = 0;
>  	pix_inc = 0;
> 
> -	if (plane == OMAP_DSS_WB) {
> +	if (plane == OMAP_DSS_WB)
>  		frame_width = out_width;
> -		frame_height = out_height;
> -	} else {
> +	else
>  		frame_width = in_width;
> -		frame_height = height;
> -	}
> 
>  	calc_offset(screen_width, frame_width,
>  			fourcc, fieldmode, field_offset,

-- 
Regards,

Laurent Pinchart



