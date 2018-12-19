Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA3821841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHvWDOOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeLSOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:43:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46697 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbeLSOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:43:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so17577359ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=a6E41MBCQ28KQUpROOYH3tyfLzba+ZTa6M4cgsFPthE=;
        b=PHvWDOOpPNtUPfhFkJe0+JVwsZGGNOU81nC5KVRX8lG/vzehlInQGJcW7Evi+j42d5
         ps1Izd6VT1H2Fxa25D3U87qh8bpr3cDtHKICghwyw4sKVdc4sW6R6wQIVfxitF0Vb8AQ
         5H/D5j7k1/8aDfJC5ZUU9+OWL3S0VU4JpSo64RLY1B4CYUd+CJUPe7kOoZZr3hzX9xby
         6BI2muvuDuDTtCyL2v1HibryKaEQdEFZB78mOKNki72geBTB0b0L7Kz5q9rHur0FJAUJ
         E7SAnSdpfVbCT7y0fIguKXueXhtqWKW/jJ8sIRhHaxYqwJGOzU+A1uZo1xOOY2emRKTs
         jsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=a6E41MBCQ28KQUpROOYH3tyfLzba+ZTa6M4cgsFPthE=;
        b=AAvegdOVCfvmf+Fy8b7ZgnDBh4c9Z4/EFScPcblCgMP2vP7LykH/fAbo/9W7lncoKk
         SGMzynKh41/zW/x+r1URQ/YQxo9E7ttF5+l1EvLAX1Vr9lfHDav1NfeWCBWWtTVFtAib
         lifxWGmoqHIrziR1+Imj/wMw6UTz8YnMS7cgYRr99zfB7slM9m53t7Dt1N3tgM2DoGQt
         ogbD/jNsRWkzZKhFfD4kNPxAB39M1kvtzflAeYWtuboxL8XvzFcWZwPqJAXNoaVNv5DZ
         aK1eA00dnAWRLB8pFUx5XhmjvrsL9LL4FxIOazbTjwQJET+U5LC9nXqHcUf15+3P/Uta
         Lakg==
X-Gm-Message-State: AA+aEWYWmUb82/k60NDvRZHnky9lg0nuMi/Z5avPWXQDxI9KxQZfgwj6
        JiA1yJ6Huqz/rd4PNGAJLII=
X-Google-Smtp-Source: AFSGD/We50Abh8sLDrhUR5sJdESFuwFBAre6Ph+O0LP3D0LXmZ6y0Pyp1VPn9wgQy8EaNb+B1quKRQ==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr6011154ljg.67.1545230616768;
        Wed, 19 Dec 2018 06:43:36 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id p23sm3804015lfh.47.2018.12.19.06.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 06:43:36 -0800 (PST)
Subject: Re: [PATCH 01/14] drm/bochs: encoder cleanup
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-2-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <6a5eb6a3-17e9-852f-2257-1a164789872c@gmail.com>
Date:   Wed, 19 Dec 2018 16:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gerd!

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Most unused callbacks can be NULL pointers these days.
> Drop a bunch of empty encoder callbacks.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs_kms.c | 26 --------------------------
>   1 file changed, 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index f87c284dd9..c8ce54498d 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -170,31 +170,6 @@ static void bochs_crtc_init(struct drm_device *dev)
>   	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
>   }
>   
> -static void bochs_encoder_mode_set(struct drm_encoder *encoder,
> -				   struct drm_display_mode *mode,
> -				   struct drm_display_mode *adjusted_mode)
> -{
> -}
> -
> -static void bochs_encoder_dpms(struct drm_encoder *encoder, int state)
> -{
> -}
> -
> -static void bochs_encoder_prepare(struct drm_encoder *encoder)
> -{
> -}
> -
> -static void bochs_encoder_commit(struct drm_encoder *encoder)
> -{
> -}
> -
> -static const struct drm_encoder_helper_funcs bochs_encoder_helper_funcs = {
> -	.dpms = bochs_encoder_dpms,
> -	.mode_set = bochs_encoder_mode_set,
> -	.prepare = bochs_encoder_prepare,
> -	.commit = bochs_encoder_commit,
> -};
> -
>   static const struct drm_encoder_funcs bochs_encoder_encoder_funcs = {
>   	.destroy = drm_encoder_cleanup,
>   };
> @@ -207,7 +182,6 @@ static void bochs_encoder_init(struct drm_device *dev)
>   	encoder->possible_crtcs = 0x1;
>   	drm_encoder_init(dev, encoder, &bochs_encoder_encoder_funcs,
>   			 DRM_MODE_ENCODER_DAC, NULL);
> -	drm_encoder_helper_add(encoder, &bochs_encoder_helper_funcs);
>   }
>   
>   
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
