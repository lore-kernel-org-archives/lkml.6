Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D428DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F176217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MCh7hFK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeLSNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:12:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43878 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:12:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so16885088eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=edUgZzd8BLfo6Hu38x+e5OW6IeTonKqX3TQ9mg8Dy6A=;
        b=MCh7hFK3cjjVAmnSYIz0vdkhL60E/M0qh0WxBLN/VWnEMo/uNjMMBsWz5x3FqIjAF4
         /PM4oYEPpiMDfY33lzXkwHlRmxwDYlo+al5CgmFW+maJNH5gv425s0p2TJv4Dw79hZWe
         OZ/pqdgFA2+IJgTgNYIdkdrL682ndgOw6KRlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=edUgZzd8BLfo6Hu38x+e5OW6IeTonKqX3TQ9mg8Dy6A=;
        b=VYHZvhEAc1s4J/xwnrqnb9HKINDhxwONEZKy2USj4UsS3Uhmi0fvm/BuOgaeBZTlLJ
         pk1vmD3QDoyMI+ekWtAhlZvSbqEXXtsJPpbEadrEp8a/vCHKXk/Ui5GzXFr4FThdqqWA
         ISrtawyQhNXI0ek/V7/QGDlWwTH3ceWn2LplHThQatuOembqXoMT/0mWYtewZL+2EaDL
         jtOQ8BCLdeW9ILzHFYUJ5w+CbL0OUcHy3X2SSBajmhYvbSGokE6aogViZyqCwoyVMWhi
         ickw3K6sGajFyA2e55FYVXaEkz3700T2FI50tKXZfYoyPlajNp4/sg3JFQG1rIFsbv0j
         xS9w==
X-Gm-Message-State: AA+aEWZY8ns6Uj+m9gH0zs/AT2xNBaDw4MwPJzSS0jNigA0UrYFIh9C4
        7lQ6qQSKEraFAclt73b42wPFEw==
X-Google-Smtp-Source: AFSGD/VgK9Vb5/vJmty/w5fbJTVc1XgoElGasCES4JuC75vXYT1AWcf4tfATVTcC7/JPI7mK5TXSYw==
X-Received: by 2002:a17:906:6b99:: with SMTP id l25-v6mr15913524ejr.154.1545225120016;
        Wed, 19 Dec 2018 05:12:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b11-v6sm2725298ejd.16.2018.12.19.05.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:11:59 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:11:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/7] drm: omapdrm: Delete base.id prints
Message-ID: <20181219131157.GQ21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133815.vr3hi5dpq6g7kgh4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133815.vr3hi5dpq6g7kgh4@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:15AM -0200, Shayenne Moura wrote:
> This patch removes base.id prints from drm_display_mode                         
> objects in omapdrm files. It removes dependency from drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Same comment as for msm, I think better to use this opportunity to switch
over to DRM_MODE_FMT/ARG.
-Daniel
> ---
>  drivers/gpu/drm/omapdrm/omap_connector.c | 4 ++--
>  drivers/gpu/drm/omapdrm/omap_crtc.c      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
> index b81302c4bf9e..e02986e0b2c6 100644
> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> @@ -306,9 +306,9 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
>  
>  done:
>  	DBG("connector: mode %s: "
> -			"%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			"\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
>  			(ret == MODE_OK) ? "valid" : "invalid",
> -			mode->base.id, mode->name, mode->vrefresh, mode->clock,
> +			mode->name, mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
>  			mode->vdisplay, mode->vsync_start,
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
> index caffc547ef97..3d6febb2e9c4 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -427,8 +427,8 @@ static void omap_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
>  	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>  
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -	    omap_crtc->name, mode->base.id, mode->name,
> +	DBG("%s: set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +	    omap_crtc->name, mode->name,
>  	    mode->vrefresh, mode->clock,
>  	    mode->hdisplay, mode->hsync_start, mode->hsync_end, mode->htotal,
>  	    mode->vdisplay, mode->vsync_start, mode->vsync_end, mode->vtotal,
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
