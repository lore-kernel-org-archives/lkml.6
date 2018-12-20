Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB60EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBF72186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPapwROZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbeLTNHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:07:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43291 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeLTNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:07:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so1483624lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ol1C2r9425BAupMQBj6DoOYjEdUlF0GF/bdvdnt4viA=;
        b=RPapwROZ4hkqnOak5LO4PkBCbuzAgU7z3B/QPtcm7UiOU8H6ph4VP3S3yZXDyiEiho
         vs0CMCKyMQiag5uHhjk6LbPamtc8swVXLUQh1ATPktemaTKSmoYVrpo801kofazig1dV
         rW6T2Ze383Z1RsT+R35gv1khF5yH+HIPzWXJn/LeLLWtoRAjCOnNhiQH6CxxYkm8WG/k
         l0U//S91SgE2QbNXiba5JxpDPk6bFsgVBf8nWcr3bJbhria0vd0v7KH+de+xE0F4FDQ4
         HZfbrB5pQZ/XVRRhwQ+5grgfiEt6jjR8ox6CXFsfuhqkY4eQYaZsxMNzX+G0vjLxtFaZ
         7k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ol1C2r9425BAupMQBj6DoOYjEdUlF0GF/bdvdnt4viA=;
        b=VYkaoK41FNT0vbpMbk21r2TWjmGB/f2/p8xqHu5b5K2HlpzPo2Puf7R0sYNGNblgbD
         4g39NbIke8h/lSUQmpDOxaByE75dUQ2DZDE1cqgtlN2k+ir6MblSD48z7igXRaCbF3cP
         AH6PtZlTkvpgIYZ0R6SoXbOT2051MlWxHSsLZQBpBpbm7SZvZh/yLSoTbIHGr553bAQ8
         Ue89PdCI21NvmJ8iTlwwhS0Ne+hpfEQSmIqxifrhUiZH/BIABlKoixQ61bBAscdMYlxj
         5vc7bmmlJ/rBeoRR+ctP5CmpuEsd5jM/e74ue59trH8eODaUJK7SRHWN+sKvMDpQdknX
         jysA==
X-Gm-Message-State: AA+aEWadeFmsV9oe6+irG0V6zDXfwctCQDlA+r5mPierCY7hTXaJxLcT
        zH/Zz+XBla0jsaoqZO9+PvBSLOu1
X-Google-Smtp-Source: AFSGD/Wqi8OFmmcfNbjxb9kTIzFhAZDGlhPUWjwcgoM0fexW6cGCPSa+nLQr6dMJ6lAsQz5SDpJqSA==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr14955648ljg.87.1545311264303;
        Thu, 20 Dec 2018 05:07:44 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id p186sm4364161lfd.83.2018.12.20.05.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:07:43 -0800 (PST)
Subject: Re: [PATCH 11/14] drm/bochs: add basic prime support
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-12-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <bf6b259d-d8a5-af6a-d4f2-ecfba6a561a7@gmail.com>
Date:   Thu, 20 Dec 2018 15:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-12-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Generic framebuffer emulation needs this.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs.h     | 11 +++++++
>   drivers/gpu/drm/bochs/bochs_drv.c | 15 +++++++++-
>   drivers/gpu/drm/bochs/bochs_mm.c  | 63 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index d0d474e06f..4236d5d811 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -145,6 +145,17 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>   int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
>   int bochs_bo_unpin(struct bochs_bo *bo);
>   
> +int bochs_gem_prime_pin(struct drm_gem_object *obj);
> +void bochs_gem_prime_unpin(struct drm_gem_object *obj);
> +struct sg_table *bochs_gem_prime_get_sg_table(struct drm_gem_object *obj);
> +struct drm_gem_object *bochs_gem_prime_import_sg_table(
> +        struct drm_device *dev, struct dma_buf_attachment *attach,
> +        struct sg_table *sgt);
Please change 8 spaces to a single tab
> +void *bochs_gem_prime_vmap(struct drm_gem_object *obj);
> +void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
> +int bochs_gem_prime_mmap(struct drm_gem_object *obj,
> +			 struct vm_area_struct *vma);
> +
>   /* bochs_kms.c */
>   int bochs_kms_init(struct bochs_device *bochs);
>   void bochs_kms_fini(struct bochs_device *bochs);
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index 278f9d2e7f..a9c7140e3b 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -81,7 +81,8 @@ static const struct file_operations bochs_fops = {
>   };
>   
>   static struct drm_driver bochs_driver = {
> -	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> +				  DRIVER_PRIME,
>   	.fops			= &bochs_fops,
>   	.name			= "bochs-drm",
>   	.desc			= "bochs dispi vga interface (qemu stdvga)",
> @@ -91,6 +92,18 @@ static struct drm_driver bochs_driver = {
>   	.gem_free_object_unlocked = bochs_gem_free_object,
>   	.dumb_create            = bochs_dumb_create,
>   	.dumb_map_offset        = bochs_dumb_mmap_offset,
> +
> +	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +	.gem_prime_export = drm_gem_prime_export,
> +	.gem_prime_import = drm_gem_prime_import,
> +	.gem_prime_pin = bochs_gem_prime_pin,
> +	.gem_prime_unpin = bochs_gem_prime_unpin,
> +	.gem_prime_get_sg_table = bochs_gem_prime_get_sg_table,
> +	.gem_prime_import_sg_table = bochs_gem_prime_import_sg_table,
> +	.gem_prime_vmap = bochs_gem_prime_vmap,
> +	.gem_prime_vunmap = bochs_gem_prime_vunmap,
> +	.gem_prime_mmap = bochs_gem_prime_mmap,
>   };
>   
>   /* ---------------------------------------------------------------------- */
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index 5a0e092847..cfe061c25f 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -387,3 +387,66 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>   	drm_gem_object_put_unlocked(obj);
>   	return 0;
>   }
> +
> +/* ---------------------------------------------------------------------- */
> +
> +int bochs_gem_prime_pin(struct drm_gem_object *obj)
> +{
> +	struct bochs_bo *bo = gem_to_bochs_bo(obj);
> +
> +	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
> +}
> +
> +void bochs_gem_prime_unpin(struct drm_gem_object *obj)
> +{
> +	struct bochs_bo *bo = gem_to_bochs_bo(obj);
> +
> +	bochs_bo_unpin(bo);
> +}
> +
> +struct sg_table *bochs_gem_prime_get_sg_table(struct drm_gem_object *obj)
> +{
> +	WARN_ONCE(1, "not implemented");
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +struct drm_gem_object *bochs_gem_prime_import_sg_table(
> +	struct drm_device *dev, struct dma_buf_attachment *attach,
> +	struct sg_table *table)
> +{
> +	WARN_ONCE(1, "not implemented");
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +void *bochs_gem_prime_vmap(struct drm_gem_object *obj)
> +{
> +	struct bochs_bo *bo = gem_to_bochs_bo(obj);
> +	bool is_iomem;
> +	int ret;
> +
> +	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
> +	if (ret)
> +		return NULL;
> +	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
> +	if (ret) {
> +		bochs_bo_unpin(bo);
> +		return NULL;
> +	}
> +	return ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
> +}
> +
> +void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
> +{
> +	struct bochs_bo *bo = gem_to_bochs_bo(obj);
> +
> +	ttm_bo_kunmap(&bo->kmap);
> +	bochs_bo_unpin(bo);
> +}
> +
> +int bochs_gem_prime_mmap(struct drm_gem_object *obj,
> +			 struct vm_area_struct *vma)
> +{
> +	struct bochs_bo *bo = gem_to_bochs_bo(obj);
> +
> +	return ttm_fbdev_mmap(vma, &bo->bo);
> +}
With the above fixed:
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
