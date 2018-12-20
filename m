Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D720866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Oi79WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbeLTMeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:34:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36339 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbeLTMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:34:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so1406588ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=irr36FLl9S+FZSa0kq4qrUCmjMsfLE/+lShBNcbTi6A=;
        b=O7Oi79WOKID1W/QrJ2CteJn/wsHBu3SziGqznkbxE9snliLiuIILZ7s6pEf1yUuivH
         26bQoh8x3WkPXYnFL4myyZ1QJfZb922cs8EuJr+GPOMukd5+pAqsPjuzQk9Sa0dQ5sty
         QdMW/AmuFgkJrnhKL3lQ0IUec3ka4HvUiETnUctLErNrtz6wTKKbHz8QCmIYcGlRg1Lf
         +lRYYj9DRm50smCRfYtRFdFYcIKRHXqKA0fhFr4nWZilBD0gwpxev9tKpeG+MwomIXBO
         NxkrYdP8E6jLdVAKpwQ7+0jAoAIAWjx/xyzb8zEMlKrU8MOnZ4EY7fzErWlKMugNyl9f
         2ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=irr36FLl9S+FZSa0kq4qrUCmjMsfLE/+lShBNcbTi6A=;
        b=IDtRcu3sw3HR8kW5KVoqAnOUFqyecd4fSpy8f0x9vnWnDWWoFLYcY8+5301HSAdOum
         IscKpjXE6cfh+F3y95rBsQbE947R+ci6PlMv+V4icPypm2C2TPOWhp6SLr7XQnOQZavd
         tLqe3IOHdue6QL+JcAscK4J5ZeZUtZ516fopPeV+cPyW/cefzlOIyiwmHE6/IUbAp7Yw
         ArmDKRqNg+yaFpBxgApHDrUzD93dmtv0Ld8dUazLrQowHJKiMRWdlwFD0ertYNzeAGkB
         r3zO4yY57WD24izVmry4DCOaTsQR4+XKXf6bYoMBZ25fJ7ioOzhBadBRIEyVqyfAfqxH
         QFdQ==
X-Gm-Message-State: AA+aEWb/tEoJ6Tku6W3tgEzbGEarW1QR02ketmAvMwHRBV5ZDGbv2a2h
        tqqN77D1CYt6Hm00vbKacIo=
X-Google-Smtp-Source: AFSGD/Xggj8wnx5lEQaBZpHmWLCLMdN5mUx54fD7ovLJmDK7gxDg6MLrCm6tAxqvbxKxz0c2e3HIYg==
X-Received: by 2002:a2e:2246:: with SMTP id i67-v6mr1836425lji.154.1545309256161;
        Thu, 20 Dec 2018 04:34:16 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id d10sm4321954lfa.71.2018.12.20.04.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:34:15 -0800 (PST)
Subject: Re: [PATCH 07/14] drm/bochs: atomic: use atomic page_flip helper
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-8-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <04c01f61-6d4d-5b4d-7678-4e89311cb2ae@gmail.com>
Date:   Thu, 20 Dec 2018 14:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step five.
> Use atomic page_flip helper for crtc.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_kms.c | 23 +----------------------
>   1 file changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index dcc8b864fc..9e836386e9 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -104,27 +104,6 @@ static void bochs_crtc_commit(struct drm_crtc *crtc)
>   {
>   }
>   
> -static int bochs_crtc_page_flip(struct drm_crtc *crtc,
> -				struct drm_framebuffer *fb,
> -				struct drm_pending_vblank_event *event,
> -				uint32_t page_flip_flags,
> -				struct drm_modeset_acquire_ctx *ctx)
> -{
> -	struct bochs_device *bochs =
> -		container_of(crtc, struct bochs_device, crtc);
> -	struct drm_framebuffer *old_fb = crtc->primary->fb;
> -	unsigned long irqflags;
> -
> -	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
> -	bochs_crtc_mode_set_base(crtc, 0, 0, old_fb);
> -	if (event) {
> -		spin_lock_irqsave(&bochs->dev->event_lock, irqflags);
> -		drm_crtc_send_vblank_event(crtc, event);
> -		spin_unlock_irqrestore(&bochs->dev->event_lock, irqflags);
> -	}
> -	return 0;
> -}
> -
>   static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
>   				     struct drm_crtc_state *old_crtc_state)
>   {
> @@ -152,7 +131,7 @@ static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
>   static const struct drm_crtc_funcs bochs_crtc_funcs = {
>   	.set_config = drm_atomic_helper_set_config,
>   	.destroy = drm_crtc_cleanup,
> -	.page_flip = bochs_crtc_page_flip,
> +	.page_flip = drm_atomic_helper_page_flip,
>   	.reset = drm_atomic_helper_crtc_reset,
>   	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

