Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D0EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB43A20895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="dHxmT2vE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB43A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933323AbeFPXeg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 19:34:36 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40950 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756922AbeFPXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 19:34:35 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 29EAD5C02DA;
        Sun, 17 Jun 2018 01:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529192074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g1nFgxv8JBYInDh3HYkggX3nSd+27fy25Zu/+HN3us=;
        b=dHxmT2vElTmSgARsvPxN6MKKbepSv4S6B6mcpk5MzhIEu7S63HXeqWMwOlOBStQWoxK1zB
        S3lnESMy+MR3vq8wOlVH7ZtdjxJS+GsOQPVJTfI3uaH7BGqP/EA1ZdR1Akcf8ZZ+2Qfn0s
        dNbfKGIAtljKyDqk18wCARyRZnxTuvY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Jun 2018 01:34:34 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, maxime.ripard@bootlin.com,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atmel-hlcdc: remove unnecessary if statement
In-Reply-To: <20170807062650.9863-1-stefan@agner.ch>
References: <20170807062650.9863-1-stefan@agner.ch>
Message-ID: <041e4264a89b5d8ab748f6dc3bf501db@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         TO_DN_NONE(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris, Maxime,

On 07.08.2017 08:26, Stefan Agner wrote:
> The statement always evaluates to true since the struct fields
> are arrays. This has shown up as a warning when compiling with
> clang:
>   warning: address of array 'desc->layout.xstride' will always
>       evaluate to 'true' [-Wpointer-bool-conversion]

It seems that this patch never made it upstream. It still produces a
warning when building with clang. Maybe you could have a look and queue?

--
Stefan

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 1124200bb280..9bd8c4888035 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -854,24 +854,21 @@ static int
> atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
>  				struct atmel_hlcdc_plane_properties *props)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	int ret;
>  
>  	if (desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
>  	    desc->type == ATMEL_HLCDC_CURSOR_LAYER)
>  		drm_object_attach_property(&plane->base.base,
>  					   props->alpha, 255);
>  
> -	if (desc->layout.xstride && desc->layout.pstride) {
> -		int ret;
> -
> -		ret = drm_plane_create_rotation_property(&plane->base,
> -							 DRM_MODE_ROTATE_0,
> -							 DRM_MODE_ROTATE_0 |
> -							 DRM_MODE_ROTATE_90 |
> -							 DRM_MODE_ROTATE_180 |
> -							 DRM_MODE_ROTATE_270);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = drm_plane_create_rotation_property(&plane->base,
> +						 DRM_MODE_ROTATE_0,
> +						 DRM_MODE_ROTATE_0 |
> +						 DRM_MODE_ROTATE_90 |
> +						 DRM_MODE_ROTATE_180 |
> +						 DRM_MODE_ROTATE_270);
> +	if (ret)
> +		return ret;
>  
>  	if (desc->layout.csc) {
>  		/*
