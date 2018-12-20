Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD17C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A302084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eepE1tPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeLTMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:54:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42831 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeLTMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:54:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so1445838lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W8AqJqjm79F15oV/olXh/bn3gHenxmenKP/4q9jvics=;
        b=eepE1tPZAnQuFRCNtgOEAvH6bcrN3z/raXGuhlNhqk6gDTW9CD3+F4j3s2W43VsweQ
         COne3eIik7n2bGh6UPXKf6vXKaNpW1Z7FuWCC+pWaOgRLzotbeTi1N7yTP9x5PEX4DNi
         NBsWvpcxjHBG5WVxJqkKFMrcRO58PSVqipBwJBbQmWCOdBOjDYw/Z6GCGaEBsVzf+h2V
         1u3vQTqSsv9hPppBQ/LSwrbrMre2FiOzXhIuG8xdJ+CQUL3pzHqmxpxeMvGKUxRrlGwT
         q2awJGvExSCHwaG6sheKQFFHQEOaVHFRDHzfr5RrcHxpeVfvvz4K4a2yPwqGbHLTMN0N
         C5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W8AqJqjm79F15oV/olXh/bn3gHenxmenKP/4q9jvics=;
        b=oAa1Slh85+TXOrUlyRpptreRNo/LPWNYa77tbLtBLFckFCxpuCR+iI3pd2Zz893ovm
         UyUJffB3Z/0KiHyagFL2ja9z1bHq/sw8M+SDhehU3Lxl4TZHRjaQi7caytYmKz0WQa7B
         qDXPjJGwGdAqshQ0rqhzxW/zowktNDCOoPMgrbSObOZBeKRhLEUBN2jlMS4U1jLzugLJ
         TDViYQ69lyf5mKNinMdWPWjNcXtKSkWG0hnFYzp6xYBVSRvyY7TRIDLCEp1HCrof27CR
         pqM2D1X9bXsj+5ozucUO3It1mNlyQj7ZWFVZ5DIT56eXL545/arwJWWoqjl2bZXdab4Q
         GtGQ==
X-Gm-Message-State: AA+aEWZDUTpXmjphQ/7mbFbXM9tZjdxviDG0tClHIeVgTk7fqitEaIsk
        wtbudhbH89xgxOmebRvKQhpOsAlD
X-Google-Smtp-Source: AFSGD/UnXC0PNXdY42tOZ8U32n0wMGgK2BdWNNSuqLcy7dF0CP4q8PTf87A1AVl6QgxRd96mEZYRwA==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr8912273ljk.55.1545310457334;
        Thu, 20 Dec 2018 04:54:17 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id u12-v6sm4055125ljk.79.2018.12.20.04.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:54:16 -0800 (PST)
Subject: Re: [PATCH 10/14] drm/bochs: drop unused gpu_addr arg from
 bochs_bo_pin()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-11-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <0db5ad72-0f53-8f54-5656-2a3ad64dce72@gmail.com>
Date:   Thu, 20 Dec 2018 14:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-11-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> It's always NULL, so just remove it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs.h       |  2 +-
>   drivers/gpu/drm/bochs/bochs_fbdev.c |  2 +-
>   drivers/gpu/drm/bochs/bochs_kms.c   |  2 +-
>   drivers/gpu/drm/bochs/bochs_mm.c    | 11 +----------
>   4 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index 4dc1b6384e..d0d474e06f 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -142,7 +142,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
>   int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>   			   uint32_t handle, uint64_t *offset);
>   
> -int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr);
> +int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
>   int bochs_bo_unpin(struct bochs_bo *bo);
>   
>   /* bochs_kms.c */
> diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
> index d9f3d42999..92feb817ff 100644
> --- a/drivers/gpu/drm/bochs/bochs_fbdev.c
> +++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
> @@ -81,7 +81,7 @@ static int bochsfb_create(struct drm_fb_helper *helper,
>   	if (ret)
>   		return ret;
>   
> -	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
> +	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
>   	if (ret) {
>   		DRM_ERROR("failed to pin fbcon\n");
>   		ttm_bo_unreserve(&bo->bo);
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 85dd268fa1..a1a0129f3e 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -96,7 +96,7 @@ static int bochs_plane_prepare_fb(struct drm_plane *plane,
>   	if (!new_state->fb)
>   		return 0;
>   	bo = gem_to_bochs_bo(new_state->fb->obj[0]);
> -	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
> +	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
>   }
>   
>   static void bochs_plane_cleanup_fb(struct drm_plane *plane,
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index 0980411e41..5a0e092847 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -210,20 +210,13 @@ static void bochs_ttm_placement(struct bochs_bo *bo, int domain)
>   	bo->placement.num_busy_placement = c;
>   }
>   
> -static inline u64 bochs_bo_gpu_offset(struct bochs_bo *bo)
> -{
> -	return bo->bo.offset;
> -}
> -
> -int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr)
> +int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
>   	int i, ret;
>   
>   	if (bo->pin_count) {
>   		bo->pin_count++;
> -		if (gpu_addr)
> -			*gpu_addr = bochs_bo_gpu_offset(bo);
>   		return 0;
>   	}
>   
> @@ -235,8 +228,6 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr)
>   		return ret;
>   
>   	bo->pin_count = 1;
> -	if (gpu_addr)
> -		*gpu_addr = bochs_bo_gpu_offset(bo);
>   	return 0;
>   }
>   

