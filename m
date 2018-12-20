Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ECCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B012084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM9IeDml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbeLTNeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:34:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55934 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbeLTNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:34:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so2038876wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Tp+LM6CIPfg85kk5szcakbEu7KBVe+NO6Ld9DXJaDDA=;
        b=XM9IeDmlqMyQIQpZFsjwb93I/tCohK88sxg4sfD8J+bXrEGlm6ETOShlYR0txCWkjU
         rAkM+uWWTiz1FbsXRglR8A1k73hiYNc0dM4PWcqg9eDR2wY/XHUfCK862u6sGdHSfA4/
         ULGZKBGg4oB3JNP68mu7gCCnz5PsknhWVfJb0s8FBHhRQFGryEeUfLriTNGwhBMe5djJ
         ziQqtFRvKwP5pfvwz8z7j6MuJXWKvl48nEGkHJOzEF2GZe5Av3K/Sl3E2e9QGIXVRu7U
         uePvOfYk4rKZA/Lg834WU49YNDwrn4CJ0i8wN3ql3CuwE1BN5aQUXBCkiOxIgStKcINI
         oFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Tp+LM6CIPfg85kk5szcakbEu7KBVe+NO6Ld9DXJaDDA=;
        b=EE3E/Eihb/Hkwmg/d7OxSPk+15+Vguf7j+6a4EbLI3F/bkux8ErLbB7YWwBgYAPMNw
         ohZlclCsCwHrqXad6E16Yc5cckHDU9jLkdEKMGoZSLv6RIHjSVp2l6hz7rv3p3lQz9ht
         GXmo8JTh8ayJb0TV/KEykBXuzeTTMGat+vYNYVWEwI+8T7jDJ5dIVstV+4kwiduGta3I
         IQzdHQIJp884BcQi9WIMlbgL/6ZM2MKgYusi/PmG8T2OeRUbOBi3xMhcvjrc1HFqhIx3
         uB7j78ZPwNjIbFYKmNA8Yaft0Xsnyn95QphNlOD9UHg7EbACdWgBXNNqlMR8sC/zJO+8
         jt7Q==
X-Gm-Message-State: AA+aEWZetjvmVcggWmnKhDyfrhieyQO5DOWU7Vkt38dTrOER6t5Zp9Ax
        g0ILtknW4PNU6BIwl7CfMns=
X-Google-Smtp-Source: AFSGD/X77gyVJyDWleTn9z7RPVgI277xe8KKuU8+M0dAXDb5slUYQh4prWrybKDjNqqrqHCZ9ZGR4A==
X-Received: by 2002:a1c:5746:: with SMTP id l67mr11715876wmb.118.1545312845302;
        Thu, 20 Dec 2018 05:34:05 -0800 (PST)
Received: from ?IPv6:2a02:908:125b:9a00:a142:2be6:b7be:5a3a? ([2a02:908:125b:9a00:a142:2be6:b7be:5a3a])
        by smtp.gmail.com with ESMTPSA id w16sm9451003wrp.1.2018.12.20.05.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:34:04 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/ttm: Use drm_debug_printer for all
 ttm_bo_mem_space_debug output
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181220112209.8063-1-michel@daenzer.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <306fa608-0468-17e6-47b3-aae46f61a1de@gmail.com>
Date:   Thu, 20 Dec 2018 14:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220112209.8063-1-michel@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.12.18 um 12:22 schrieb Michel Dänzer:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> No need for pr_err here, the pr_err message in ttm_bo_evict is enough
> to draw attention to something not going as planned.
>
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> Similar to a previous patch, but this one leaves the pr_err messages in
> ttm_bo_evict untouched.
>
>   drivers/gpu/drm/ttm/ttm_bo.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index d87935bf8e30..0ec08394e17a 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -77,38 +77,39 @@ static inline int ttm_mem_type_from_place(const struct ttm_place *place,
>   	return 0;
>   }
>   
> -static void ttm_mem_type_debug(struct ttm_bo_device *bdev, int mem_type)
> +static void ttm_mem_type_debug(struct ttm_bo_device *bdev, struct drm_printer *p,
> +			       int mem_type)
>   {
>   	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
> -	struct drm_printer p = drm_debug_printer(TTM_PFX);
>   
> -	pr_err("    has_type: %d\n", man->has_type);
> -	pr_err("    use_type: %d\n", man->use_type);
> -	pr_err("    flags: 0x%08X\n", man->flags);
> -	pr_err("    gpu_offset: 0x%08llX\n", man->gpu_offset);
> -	pr_err("    size: %llu\n", man->size);
> -	pr_err("    available_caching: 0x%08X\n", man->available_caching);
> -	pr_err("    default_caching: 0x%08X\n", man->default_caching);
> +	drm_printf(p, "    has_type: %d\n", man->has_type);
> +	drm_printf(p, "    use_type: %d\n", man->use_type);
> +	drm_printf(p, "    flags: 0x%08X\n", man->flags);
> +	drm_printf(p, "    gpu_offset: 0x%08llX\n", man->gpu_offset);
> +	drm_printf(p, "    size: %llu\n", man->size);
> +	drm_printf(p, "    available_caching: 0x%08X\n", man->available_caching);
> +	drm_printf(p, "    default_caching: 0x%08X\n", man->default_caching);
>   	if (mem_type != TTM_PL_SYSTEM)
> -		(*man->func->debug)(man, &p);
> +		(*man->func->debug)(man, p);
>   }
>   
>   static void ttm_bo_mem_space_debug(struct ttm_buffer_object *bo,
>   					struct ttm_placement *placement)
>   {
> +	struct drm_printer p = drm_debug_printer(TTM_PFX);
>   	int i, ret, mem_type;
>   
> -	pr_err("No space for %p (%lu pages, %luK, %luM)\n",
> -	       bo, bo->mem.num_pages, bo->mem.size >> 10,
> -	       bo->mem.size >> 20);
> +	drm_printf(&p, "No space for %p (%lu pages, %luK, %luM)\n",
> +		   bo, bo->mem.num_pages, bo->mem.size >> 10,
> +		   bo->mem.size >> 20);
>   	for (i = 0; i < placement->num_placement; i++) {
>   		ret = ttm_mem_type_from_place(&placement->placement[i],
>   						&mem_type);
>   		if (ret)
>   			return;
> -		pr_err("  placement[%d]=0x%08X (%d)\n",
> -		       i, placement->placement[i].flags, mem_type);
> -		ttm_mem_type_debug(bo->bdev, mem_type);
> +		drm_printf(&p, "  placement[%d]=0x%08X (%d)\n",
> +			   i, placement->placement[i].flags, mem_type);
> +		ttm_mem_type_debug(bo->bdev, &p, mem_type);
>   	}
>   }
>   

