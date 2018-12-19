Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF72C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D8221841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATHZbMSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeLSPKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:10:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45570 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbeLSPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:10:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so17676960ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pyo3HxLqItgoaMk0tN0BA9uxUK+KW/CbGHwkAY8i67g=;
        b=ATHZbMSVBQti1Eq6WP1RBkfnUDTRk93HBRssjVA7iOvyMgk9J04xNfGVCYKLBX4urK
         0SXeiFgErC98HPl9IwUZfTqJyTR7H2Y+iwbNXmIu6Mae+xTEi2wYyM+huuoFTACcuVVX
         jAYlhwdSz8/N8SsFlGAMrlBXs42LBhpTXFV+3IdGWg+RviYKagKE4RpW7dYxWOdfMGyx
         tj2j2oItMVrQhm5Xw9GuUMppeRI6bKik3q6QaDGViBCGSi6JYCb8bQ4XroYAW7jGFi0I
         etVlXyaDT+M4friKbrOJLjyN3d5oLfSmaJNDz6GR40a1UixsMVrp623GnJ5du3DNVqRU
         tyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pyo3HxLqItgoaMk0tN0BA9uxUK+KW/CbGHwkAY8i67g=;
        b=h/zzfAdiN9oCC2VJ03TgEkyOx9+uBLXqFnTXY6MuYPDFS51wQOIqRhTLs3Mlsnfh1t
         1/x8bdj1Oosf3DhxzOXDVw/rv2Vhyo2XlPd5V1Koxwq8Mg48WB6b6hSc8Z53ZYvrxY98
         pUYkkrgyD6RmyJ5ScECT40cnJs2mLH8jN/MOaMtttR4e6pJVFz9kxznXuVUjuaViCm/h
         /8iuHDCHWwJywPUUaFfWTVXTGolv0JzxdIjPbo2c6bblNp6kWr4BwQlPnEUTV3gkwzMw
         e8HkOwyyN9KpyQ9TvWCAVseKitbT5PnXBmh4kNLgm3RynCspEYt9wamJB1ZcdVMbOoRb
         9vOg==
X-Gm-Message-State: AA+aEWaS4fCGRn2+ms9Z74Cviq/lbOxnfESoMmyYxoP8KD7czVKRkx81
        nN/UhI/vF9jdWQMRqSFNrEU=
X-Google-Smtp-Source: AFSGD/WKUhJ0qQcvaYwYAYkVQ4aifO7+lZJfvkgUT6es5jjGb/lTQs0aJQ/9Y9RuMNz9zT7j6BZjSA==
X-Received: by 2002:a2e:8992:: with SMTP id c18-v6mr5148044lji.17.1545232221184;
        Wed, 19 Dec 2018 07:10:21 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id 185-v6sm1048817ljj.49.2018.12.19.07.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:10:20 -0800 (PST)
Subject: Re: [PATCH 02/14] drm/bochs: split bochs_hw_setmode
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-3-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <22c8b837-7f6a-7f6e-b4b7-96cec7d41c02@gmail.com>
Date:   Wed, 19 Dec 2018 17:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gerd!

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Create a separate bochs_hw_setformat function to configure
> the framebuffer format (actually just the byteorder).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs.h     |  5 +++--
>   drivers/gpu/drm/bochs/bochs_hw.c  | 19 ++++++++++++-------
>   drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
>   3 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index fb38c8b857..4dc1b6384e 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -121,8 +121,9 @@ int bochs_hw_init(struct drm_device *dev);
>   void bochs_hw_fini(struct drm_device *dev);
>   
>   void bochs_hw_setmode(struct bochs_device *bochs,
> -		      struct drm_display_mode *mode,
> -		      const struct drm_format_info *format);
> +		      struct drm_display_mode *mode);
> +void bochs_hw_setformat(struct bochs_device *bochs,
> +			const struct drm_format_info *format);
>   void bochs_hw_setbase(struct bochs_device *bochs,
>   		      int x, int y, u64 addr);
>   int bochs_hw_load_edid(struct bochs_device *bochs);
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index c90a0d492f..bbb251fc78 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -197,8 +197,7 @@ void bochs_hw_fini(struct drm_device *dev)
>   }
>   
>   void bochs_hw_setmode(struct bochs_device *bochs,
> -		      struct drm_display_mode *mode,
> -		      const struct drm_format_info *format)
> +		      struct drm_display_mode *mode)
>   {
>   	bochs->xres = mode->hdisplay;
>   	bochs->yres = mode->vdisplay;
> @@ -206,12 +205,8 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>   	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
>   	bochs->yres_virtual = bochs->fb_size / bochs->stride;
>   
> -	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, format %c%c%c%c, vy %d\n",
> +	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, vy %d\n",
>   			 bochs->xres, bochs->yres, bochs->bpp,
> -			 (format->format >>  0) & 0xff,
> -			 (format->format >>  8) & 0xff,
> -			 (format->format >> 16) & 0xff,
> -			 (format->format >> 24) & 0xff,
>   			 bochs->yres_virtual);
>   
>   	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
> @@ -229,6 +224,16 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>   
>   	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,
>   			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
> +}
> +
> +void bochs_hw_setformat(struct bochs_device *bochs,
> +			const struct drm_format_info *format)
> +{
> +	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
> +			 (format->format >>  0) & 0xff,
> +			 (format->format >>  8) & 0xff,
> +			 (format->format >> 16) & 0xff,
> +			 (format->format >> 24) & 0xff);
>   
>   	switch (format->format) {
>   	case DRM_FORMAT_XRGB8888:
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index c8ce54498d..f7e6d1a9b3 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -80,7 +80,8 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
>   	if (WARN_ON(crtc->primary->fb == NULL))
>   		return -EINVAL;
>   
> -	bochs_hw_setmode(bochs, mode, crtc->primary->fb->format);
> +	bochs_hw_setmode(bochs, mode);
> +	bochs_hw_setformat(bochs, crtc->primary->fb->format);

I was about to suggest that you go away from direct crtc->primary

use, but it seems this code goes away in this series

>   	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
>   	return 0;
>   }
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
