Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50457ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF2220671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GBjU7IO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF2220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeINQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:19:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34724 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:19:31 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A891CE;
        Fri, 14 Sep 2018 13:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536923130;
        bh=TjfBITH3ykZbb8M4EilMPSeO+/ew7fREE0U+atIwL80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBjU7IO5BO7j3ddemEcFjFWWVT2lgk/VFuKxno7UX72CQClNJvlY+VK2Yf3kYTMLD
         yEPDmTYWSaTqj5nDaKBrsE4L+0tjI4etDJwbrmTJeM1mzZ99G0WcB/j6y7onkeFYmE
         3+mkNHtQq4ZiXOnQ0pcm/cRkrCeqNI9/FZVbFRMQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: rcar-du: Update Gen3 output limitations
Date:   Fri, 14 Sep 2018 14:05:44 +0300
Message-ID: <4037354.l5ltzbp0ev@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180831181259.29529-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com> <20180831181259.29529-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 31 August 2018 21:12:57 EEST Kieran Bingham wrote:
> The R-Car Gen3 DU utilises the VSP1 hardware for memory access. The
> limits on the RPF and WPF in this pipeline are 8190x8190.
> 
> Update the supported maximum sizes accordingly.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> b/drivers/gpu/drm/rcar-du/rcar_du_kms.c index ed7fa3204892..7c7aff8cdf77
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -512,12 +512,22 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
> 
>  	dev->mode_config.min_width = 0;
>  	dev->mode_config.min_height = 0;
> -	dev->mode_config.max_width = 4095;
> -	dev->mode_config.max_height = 2047;
>  	dev->mode_config.normalize_zpos = true;
>  	dev->mode_config.funcs = &rcar_du_mode_config_funcs;
>  	dev->mode_config.helper_private = &rcar_du_mode_config_helper;
> 
> +	if (rcdu->info->gen < 3) {
> +		dev->mode_config.max_width = 4095;
> +		dev->mode_config.max_height = 2047;
> +	} else {
> +		/*
> +		 * The Gen3 DU uses the VSP1 for memory access, and is limited
> +		 * to frame sizes of 8190x8190.
> +		 */
> +		dev->mode_config.max_width = 8190;
> +		dev->mode_config.max_height = 8190;
> +	}
> +
>  	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
> 
>  	ret = rcar_du_properties_init(rcdu);

-- 
Regards,

Laurent Pinchart



