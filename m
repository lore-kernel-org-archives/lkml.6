Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE6AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497682186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFaxvCz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbeLTMqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:46:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46620 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeLTMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:46:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so1413859ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A1Ndp7n2tY5CKgTko8nq6J4SrDWNK1zOCeJmxWXGyP8=;
        b=NFaxvCz36B7myhiKzAoasNDu6NCz0umkeCd6EjBHI8Ul84i+UgGPLctO6QP+9ge6GQ
         MNNui/AQyumS5qPLEQ0ou8HNq4v3DK0FWR/doNyfwADhNajMWDmfahyCP6yFrmepKoZu
         sBUibJRrp1goFDDGksXKHwQdebzGxW3nejdzCuO21po0uwQ3ItjCE87NYe0cXVAqnm1r
         /B1v95mAaIJ1NtNrPqakoks7gSp3/wQNX1erGUt2gtTIV+I2sgxlH4j7aAp6bkti+4lj
         d0j6VX+C6Uht9aCnOW8zRUxKTJTwg0qPrNXQgzzBVrPogqsjREhSyMwaYAIpWW9MKd1B
         ywNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A1Ndp7n2tY5CKgTko8nq6J4SrDWNK1zOCeJmxWXGyP8=;
        b=JPiOBwb+gX3FYCvnZmOAaWUf6C3tvQzJT1ymnJElzAjS7/p+XwWzcG3Pzqnczo+33+
         OjjRalXS+qneTOpMH5rTbqYM9PhmvSnyvvjFY2j8/dUTSIN/GXmHw07gyzl6kkNhVuJq
         IW2ikJBWq3QRiBwOcKBMxTI+bCQlE12scLcllTt6jC7GZ16uvR7I4ISbaswGSWB5uiH0
         ErffSRaN5PVYw4IbWWXumM8VOglIW3CQRUJTaKz2DiGtFrgCelG2N1lcxWSuBImBvw+H
         b/FnIKOm8gSvLzv3dQ2k/NYu95AkMDRcOS0gLq6PwZW+nd1tXKLL/++r6t4sdC0dmPCe
         1QpA==
X-Gm-Message-State: AA+aEWavXohm8yfGizAtS1A63uFhQyofaOesn//mZu+1tIqOV+/peX7s
        YmuDnEuAlM5vGeiZyrtmlu4=
X-Google-Smtp-Source: AFSGD/UNW7zx+i6XrgYw7w+cwo1sd9PrQcmBD/nTOVP9eCwQeYYVf4L6AFRLJXo2dZRGnqLbFlfhFg==
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr8030928ljc.84.1545310008957;
        Thu, 20 Dec 2018 04:46:48 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id x16sm4188765lff.26.2018.12.20.04.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:46:48 -0800 (PST)
Subject: Re: [PATCH 09/14] drm/bochs: remove old bochs_crtc_* functions
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-10-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1a5a120f-a28d-e965-b1df-3f7139f70b23@gmail.com>
Date:   Thu, 20 Dec 2018 14:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-10-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Remove the old, now unused crtc callbacks.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_kms.c | 81 ---------------------------------------
>   1 file changed, 81 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 9e836386e9..85dd268fa1 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -20,74 +20,6 @@ MODULE_PARM_DESC(defy, "default y resolution");
>   
>   /* ---------------------------------------------------------------------- */
>   
> -static void bochs_crtc_dpms(struct drm_crtc *crtc, int mode)
> -{
> -	switch (mode) {
> -	case DRM_MODE_DPMS_ON:
> -	case DRM_MODE_DPMS_STANDBY:
> -	case DRM_MODE_DPMS_SUSPEND:
> -	case DRM_MODE_DPMS_OFF:
> -	default:
> -		return;
> -	}
> -}
> -
> -static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
> -				    struct drm_framebuffer *old_fb)
> -{
> -	struct bochs_device *bochs =
> -		container_of(crtc, struct bochs_device, crtc);
> -	struct bochs_bo *bo;
> -	u64 gpu_addr = 0;
> -	int ret;
> -
> -	if (old_fb) {
> -		bo = gem_to_bochs_bo(old_fb->obj[0]);
> -		ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> -		if (ret) {
> -			DRM_ERROR("failed to reserve old_fb bo\n");
> -		} else {
> -			bochs_bo_unpin(bo);
> -			ttm_bo_unreserve(&bo->bo);
> -		}
> -	}
> -
> -	if (WARN_ON(crtc->primary->fb == NULL))
> -		return -EINVAL;
> -
> -	bo = gem_to_bochs_bo(crtc->primary->fb->obj[0]);
> -	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> -	if (ret)
> -		return ret;
> -
> -	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
> -	if (ret) {
> -		ttm_bo_unreserve(&bo->bo);
> -		return ret;
> -	}
> -
> -	ttm_bo_unreserve(&bo->bo);
> -	bochs_hw_setbase(bochs, x, y, gpu_addr);
> -	return 0;
> -}
> -
> -static int bochs_crtc_mode_set(struct drm_crtc *crtc,
> -			       struct drm_display_mode *mode,
> -			       struct drm_display_mode *adjusted_mode,
> -			       int x, int y, struct drm_framebuffer *old_fb)
> -{
> -	struct bochs_device *bochs =
> -		container_of(crtc, struct bochs_device, crtc);
> -
> -	if (WARN_ON(crtc->primary->fb == NULL))
> -		return -EINVAL;
> -
> -	bochs_hw_setmode(bochs, mode);
> -	bochs_hw_setformat(bochs, crtc->primary->fb->format);
> -	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
> -	return 0;
> -}
> -
>   static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   {
>   	struct bochs_device *bochs =
> @@ -96,14 +28,6 @@ static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   	bochs_hw_setmode(bochs, &crtc->mode);
>   }
>   
> -static void bochs_crtc_prepare(struct drm_crtc *crtc)
> -{
> -}
> -
> -static void bochs_crtc_commit(struct drm_crtc *crtc)
> -{
> -}
> -
>   static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
>   				     struct drm_crtc_state *old_crtc_state)
>   {
> @@ -138,12 +62,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
>   };
>   
>   static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
> -	.dpms = bochs_crtc_dpms,
> -	.mode_set = bochs_crtc_mode_set,
> -	.mode_set_base = bochs_crtc_mode_set_base,
>   	.mode_set_nofb = bochs_crtc_mode_set_nofb,
> -	.prepare = bochs_crtc_prepare,
> -	.commit = bochs_crtc_commit,
>   	.atomic_enable = bochs_crtc_atomic_enable,
>   	.atomic_flush = bochs_crtc_atomic_flush,
>   };

