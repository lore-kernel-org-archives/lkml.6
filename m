Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD10C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4082133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IFDOJwvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLSNLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:11:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46602 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:11:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so16884114edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xf58R6fPKhp2mNddbhQhBC+O3GJIVAQiKLkkeZe5vYE=;
        b=IFDOJwvVpNhmR4SmkGEKJGe2xqmufRhjs9Ip1IVjND4ZEDt+LdU1VbB9EUqAeV8qdU
         IGSZ7MFU8nlIhAWBUF98GL8/23VHeB8qchuhtkQqL4uskyzaQT2sSjuiVbj3zZQxhURm
         5eoTo42qpQ6dUREh/EwImWvtwkgU0hSod/uPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xf58R6fPKhp2mNddbhQhBC+O3GJIVAQiKLkkeZe5vYE=;
        b=NS41BftlRYMoW1u4yBJGnEl+/ZNdiDjfTVgnLZ8m+D6is22/VvAm/Wt2+Z74munkkm
         caxjtRrq2Q8xhhSciJzby42K4nBoCAZzqL9Seq5Y/OR9R+WI/1rL+JAoWd5NgY/R0J6A
         VZ/ffXjpcsIWasvvNSxz1d5SA8x9IbBzQ3FNf7o69jV4/Qf7y2QrNmov7JuLdrEVgTRw
         GKTzsen1JKyL6XJ9JtQY9NSgvk5thKewLlPS/lXUQ6g0l8VDGGlA9yQPScNQzpuhlcL8
         M1lNQj1itw03hGiM/vAtzBpXikNcGv/OWiwzY+Sq9iMu0o7qZiYi4hwjKMq3aobpb+FK
         uBjg==
X-Gm-Message-State: AA+aEWanvZdIpgpny82OX6cNfrIIXMA2XY4LHex744wgfKX/9hZ9MbNq
        1OPx13Q6Dto3tLurQEPifUqT/XZFoW0=
X-Google-Smtp-Source: AFSGD/UFVYRcmcuv2m9S1o6Ugl1mwFcOwWUvXCROcNx9Ru4PWoAiyIU3CBCKuW7lkc1ygkyrW9AuPQ==
X-Received: by 2002:a50:b8e5:: with SMTP id l92mr19583135ede.294.1545225081977;
        Wed, 19 Dec 2018 05:11:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c12sm5048042edi.52.2018.12.19.05.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:11:21 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:11:19 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/7] drm: Remove use of drm_mode_object
Message-ID: <20181219131119.GP21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133810.aqhmqflvl5mqrfgo@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133810.aqhmqflvl5mqrfgo@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:10AM -0200, Shayenne Moura wrote:
> This patch removes the drm_mode_object prints, evaluation and use from 
> drm_display_mode objects used in drm files. It removes dependency from
> drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_crtc_helper.c | 5 ++---
>  drivers/gpu/drm/drm_modes.c       | 9 ---------
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index a3c81850e755..cc5cc8d109a2 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -386,9 +386,8 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
>  		if (!encoder_funcs)
>  			continue;
>  
> -		DRM_DEBUG_KMS("[ENCODER:%d:%s] set [MODE:%d:%s]\n",
> -			encoder->base.id, encoder->name,
> -			mode->base.id, mode->name);
> +		DRM_DEBUG_KMS("[ENCODER:%d:%s] set [MODE:%s]\n",
> +			encoder->base.id, encoder->name, mode->name);
>  		if (encoder_funcs->mode_set)
>  			encoder_funcs->mode_set(encoder, mode, adjusted_mode);
>  
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 24a750436559..adce9a26bac9 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -71,11 +71,6 @@ struct drm_display_mode *drm_mode_create(struct drm_device *dev)
>  	if (!nmode)
>  		return NULL;
>  
> -	if (drm_mode_object_add(dev, &nmode->base, DRM_MODE_OBJECT_MODE)) {
> -		kfree(nmode);
> -		return NULL;
> -	}

With this we stop filing out base.id and base.type, so this patch should
be reordered in the series to be after all users of these fields are gone
from drivers. But before the last patch that removes these fields.

Thanks, Daniel

> -
>  	return nmode;
>  }
>  EXPORT_SYMBOL(drm_mode_create);
> @@ -92,8 +87,6 @@ void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode)
>  	if (!mode)
>  		return;
>  
> -	drm_mode_object_unregister(dev, &mode->base);
> -
>  	kfree(mode);
>  }
>  EXPORT_SYMBOL(drm_mode_destroy);
> @@ -911,11 +904,9 @@ EXPORT_SYMBOL(drm_mode_set_crtcinfo);
>   */
>  void drm_mode_copy(struct drm_display_mode *dst, const struct drm_display_mode *src)
>  {
> -	int id = dst->base.id;
>  	struct list_head head = dst->head;
>  
>  	*dst = *src;
> -	dst->base.id = id;
>  	dst->head = head;
>  }
>  EXPORT_SYMBOL(drm_mode_copy);
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
