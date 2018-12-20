Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE033C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D10820869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dYB+Kt4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeLTHEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:04:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38703 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeLTHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:04:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so810544ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/azk92ppZHFnYtbRpk+MeJHm45ISgA7jTZreX7coQ30=;
        b=dYB+Kt4DmyEWzj0wglm3DlWkg99DczB1k+gG9Vu9/kWw4Z0dMnZc1un2WEgVDJQsIw
         IVR5lS74by4RZJpTGTzE3QDB5el3+2PWWEPeZ+iB+nJienCw8u6i59jCe+Gbb2jmfTr5
         2qD0Z5XtxtG/lj3UXzQermv2HLMk3hiZbHgLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/azk92ppZHFnYtbRpk+MeJHm45ISgA7jTZreX7coQ30=;
        b=fYc2ZCp0FNhIWYGLioK1qEogH/GtDen1aDpA39YuqWpxAHJSSD7+PlZBs0xpKWdYBz
         oaBJnv6UIpO34UVQ8C9zZhGHtyhfSMwMM2jp6krWnkawlXe9JBkHgLGBZlTiggBgrXex
         rrsRPFYtIyJJnHK65/l8+R0iB5/t+X0jKkllGruA7EprCNmypmZXBh3o9SvAOGIH3pFE
         ciFv0yQV1qw0n2UD2IWyJb8XQeVTwfQVieI6akBIgbgD8JH5uXVAWyXdRvFO2QiBdoGw
         LxlL3YhOd39srrKHtwvznBnrtiMuwGFq+pekhrLBvb5WPNTkGpZvsqEFTVU6jY/z80wS
         YBDg==
X-Gm-Message-State: AA+aEWZXoktypq/FdLTaSJ/wJEfABY9YGFbsWxN+68G4oVDmQ98869PS
        PK2IJg6F1evqLL2sGgBW2rdUEA==
X-Google-Smtp-Source: AFSGD/WchUwQRCC+Vu3q67HvJv4iOXG7uBMsSiNN1FEpDq5EcPLCT/UDXHyRsWErSQToIbsYiFRCSQ==
X-Received: by 2002:a17:906:881:: with SMTP id n1-v6mr18311160eje.7.1545289448328;
        Wed, 19 Dec 2018 23:04:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x58sm6056619edm.10.2018.12.19.23.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 23:04:07 -0800 (PST)
Date:   Thu, 20 Dec 2018 08:04:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6/7] drm: Remove use of drm_mode_object
Message-ID: <20181220070405.GB21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
 <6f92f57a290658824bf25b45db58687afd098e44.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f92f57a290658824bf25b45db58687afd098e44.1545254191.git.shayenneluzmoura@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 07:28:36PM -0200, Shayenne Moura wrote:
> This patch removes the drm_mode_object prints, evaluation and use from
> drm_display_mode objects used in drm files. It removes dependency from
> drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/drm_crtc_helper.c | 5 ++---
>  drivers/gpu/drm/drm_modes.c       | 5 -----
>  2 files changed, 2 insertions(+), 8 deletions(-)
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
> index 24a750436559..e2689afdcf50 100644
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

You seem to have lost the 3rd hunk here compared to the previous version.

For reordering patches the best way is to use 

$ git rebase --interactive

which fires up a text editor where you can reorder the patches as you see
fit. That way you don't have to touch them and risk breaking something.

Another thing: When resending patches unchanged, and your previous version
has received r-b/a-b tags, please include them. That way people know what
still needs to be reviewed and what is already reviewed. I think there was
also some other patches than this one that I reviewed already, can you pls
redo the patch series with r-b tags included, patch commit log (where you
did change something) added and then resend?

Threading looks good now.

Thanks, Daniel

> -
>  	return nmode;
>  }
>  EXPORT_SYMBOL(drm_mode_create);
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
