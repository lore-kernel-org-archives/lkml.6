Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A45C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36913217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrqVO1E5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbeLTNQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:16:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33763 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeLTNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:16:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so1541859ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rLiaP2mDPQVwh+1KwPfkdo4z8oGXMYZAvdrxqwirswY=;
        b=CrqVO1E55Njq91i+yc9JVxeFiPUqiknqZ8QtGthmXBWDTbCsibIgshlrzpTRdeMfub
         W1rLVQJHNypYJokOBERCc3elnXSvQnzhdhHhrN7/L675SH0UADlInRxUSu08O27UjE8s
         GdHlomYpDWJr2/70mAP0VG+9t7e8gV5vJUp3qvdKcbafAjk7bktvJU1btc9mOHqH/aHJ
         Db9c9RC2PlJr5mdEo81Q6PlH6HCSkvzSJJ9ZBk285ID/eyHarhxmmEHgyvSLlL5NpnCW
         glcTqw2n535fSCQgbqXDstlfifx8OL4lP/DeUEOD5qz3sOCBtZ1aCNTld0sGTcow8ClH
         ECdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rLiaP2mDPQVwh+1KwPfkdo4z8oGXMYZAvdrxqwirswY=;
        b=aQvI01YxfqvRU/0VopqN4unyqvu105uVq48Jkt7FlschNy7FIgpBm4xNL3FR2mezfb
         qJw7wHFmpu4nLhgtXB2jCsWpGURXZO9YCSi1gLunMwwQOup5lkdGUDs2UTK8E1D7gzLo
         0jrEYa3PkZA44XqBKSTT/c7t6xejjdDZe+r+pC7RA5zcNj0Pjad3GSPDioF/O4ePANjQ
         EmO99y8q0bfnoRLty1ZZKEnbOqxoi4pZGuAIgIlSIK8T9kX2ylLpeJRzOmL8fasyv2k/
         un9OGKyXJPkgr0mXaPEcuh08vUFMpBjuMFhU/m/N3OfkkWA9jcsaO4bm7dgQs749otAj
         eaDg==
X-Gm-Message-State: AA+aEWYrPUhmClXTVrYp92gVfZCI1DfOAQn05mivqf95hCOQ9iArmzpz
        BcD03S4BBRvBOiB4p6fdAP7fQ+fo
X-Google-Smtp-Source: AFSGD/VPtfNfDPEy9MYd2q10BTA2ZCWX+Ha1l6Omz6BmYrr9EqGB6ssc17D78xqheI3hhUT+Hqh9cA==
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr15166087ljp.12.1545311794310;
        Thu, 20 Dec 2018 05:16:34 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id s3-v6sm4145943lje.73.2018.12.20.05.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:16:33 -0800 (PST)
Subject: Re: [PATCH 13/14] drm/bochs: drop old fbdev emulation code
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-14-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ea0e7d2b-ebbd-a4eb-93c4-be3cf5a238a8@gmail.com>
Date:   Thu, 20 Dec 2018 15:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-14-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Not needed any more, bochs uses the generic emulation now.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs.h       |   9 ---
>   drivers/gpu/drm/bochs/bochs_drv.c   |   6 --
>   drivers/gpu/drm/bochs/bochs_fbdev.c | 137 ------------------------------------
>   3 files changed, 152 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index 4236d5d811..42a587e71e 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -80,12 +80,6 @@ struct bochs_device {
>   		struct ttm_bo_device bdev;
>   		bool initialized;
>   	} ttm;
> -
> -	/* fbdev */
> -	struct {
> -		struct drm_framebuffer *fb;
> -		struct drm_fb_helper helper;
> -	} fb;
>   };
>   
>   struct bochs_bo {
> @@ -161,7 +155,4 @@ int bochs_kms_init(struct bochs_device *bochs);
>   void bochs_kms_fini(struct bochs_device *bochs);
>   
>   /* bochs_fbdev.c */
> -int bochs_fbdev_init(struct bochs_device *bochs);
> -void bochs_fbdev_fini(struct bochs_device *bochs);
> -
>   extern const struct drm_mode_config_funcs bochs_mode_funcs;
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index f1f65324bb..ad1290ca7b 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -110,12 +110,9 @@ static int bochs_pm_suspend(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -	struct bochs_device *bochs = drm_dev->dev_private;
>   
>   	drm_kms_helper_poll_disable(drm_dev);
>   
> -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
> -
>   	return 0;
>   }
>   
> @@ -123,12 +120,9 @@ static int bochs_pm_resume(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -	struct bochs_device *bochs = drm_dev->dev_private;
>   
>   	drm_helper_resume_force_mode(drm_dev);
>   
> -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
> -
>   	drm_kms_helper_poll_enable(drm_dev);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
> index 92feb817ff..7cac3f5253 100644
> --- a/drivers/gpu/drm/bochs/bochs_fbdev.c
> +++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
> @@ -11,132 +11,6 @@
>   
>   /* ---------------------------------------------------------------------- */
>   
> -static int bochsfb_mmap(struct fb_info *info,
> -			struct vm_area_struct *vma)
> -{
> -	struct drm_fb_helper *fb_helper = info->par;
> -	struct bochs_bo *bo = gem_to_bochs_bo(fb_helper->fb->obj[0]);
> -
> -	return ttm_fbdev_mmap(vma, &bo->bo);
> -}
> -
> -static struct fb_ops bochsfb_ops = {
> -	.owner = THIS_MODULE,
> -	DRM_FB_HELPER_DEFAULT_OPS,
> -	.fb_fillrect = drm_fb_helper_cfb_fillrect,
> -	.fb_copyarea = drm_fb_helper_cfb_copyarea,
> -	.fb_imageblit = drm_fb_helper_cfb_imageblit,
> -	.fb_mmap = bochsfb_mmap,
> -};
> -
> -static int bochsfb_create_object(struct bochs_device *bochs,
> -				 const struct drm_mode_fb_cmd2 *mode_cmd,
> -				 struct drm_gem_object **gobj_p)
> -{
> -	struct drm_device *dev = bochs->dev;
> -	struct drm_gem_object *gobj;
> -	u32 size;
> -	int ret = 0;
> -
> -	size = mode_cmd->pitches[0] * mode_cmd->height;
> -	ret = bochs_gem_create(dev, size, true, &gobj);
> -	if (ret)
> -		return ret;
> -
> -	*gobj_p = gobj;
> -	return ret;
> -}
> -
> -static int bochsfb_create(struct drm_fb_helper *helper,
> -			  struct drm_fb_helper_surface_size *sizes)
> -{
> -	struct bochs_device *bochs =
> -		container_of(helper, struct bochs_device, fb.helper);
> -	struct fb_info *info;
> -	struct drm_framebuffer *fb;
> -	struct drm_mode_fb_cmd2 mode_cmd;
> -	struct drm_gem_object *gobj = NULL;
> -	struct bochs_bo *bo = NULL;
> -	int size, ret;
> -
> -	if (sizes->surface_bpp != 32)
> -		return -EINVAL;
> -
> -	mode_cmd.width = sizes->surface_width;
> -	mode_cmd.height = sizes->surface_height;
> -	mode_cmd.pitches[0] = sizes->surface_width * 4;
> -	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
> -	size = mode_cmd.pitches[0] * mode_cmd.height;
> -
> -	/* alloc, pin & map bo */
> -	ret = bochsfb_create_object(bochs, &mode_cmd, &gobj);
> -	if (ret) {
> -		DRM_ERROR("failed to create fbcon backing object %d\n", ret);
> -		return ret;
> -	}
> -
> -	bo = gem_to_bochs_bo(gobj);
> -
> -	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> -	if (ret)
> -		return ret;
> -
> -	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
> -	if (ret) {
> -		DRM_ERROR("failed to pin fbcon\n");
> -		ttm_bo_unreserve(&bo->bo);
> -		return ret;
> -	}
> -
> -	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages,
> -			  &bo->kmap);
> -	if (ret) {
> -		DRM_ERROR("failed to kmap fbcon\n");
> -		ttm_bo_unreserve(&bo->bo);
> -		return ret;
> -	}
> -
> -	ttm_bo_unreserve(&bo->bo);
> -
> -	/* init fb device */
> -	info = drm_fb_helper_alloc_fbi(helper);
> -	if (IS_ERR(info)) {
> -		DRM_ERROR("Failed to allocate fbi: %ld\n", PTR_ERR(info));
> -		return PTR_ERR(info);
> -	}
> -
> -	info->par = &bochs->fb.helper;
> -
> -	fb = drm_gem_fbdev_fb_create(bochs->dev, sizes, 0, gobj, NULL);
> -	if (IS_ERR(fb)) {
> -		DRM_ERROR("Failed to create framebuffer: %ld\n", PTR_ERR(fb));
> -		return PTR_ERR(fb);
> -	}
> -
> -	/* setup helper */
> -	bochs->fb.helper.fb = fb;
> -
> -	strcpy(info->fix.id, "bochsdrmfb");
> -
> -	info->fbops = &bochsfb_ops;
> -
> -	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
> -	drm_fb_helper_fill_var(info, &bochs->fb.helper, sizes->fb_width,
> -			       sizes->fb_height);
> -
> -	info->screen_base = bo->kmap.virtual;
> -	info->screen_size = size;
> -
> -	drm_vma_offset_remove(&bo->bo.bdev->vma_manager, &bo->bo.vma_node);
> -	info->fix.smem_start = 0;
> -	info->fix.smem_len = size;
> -	return 0;
> -}
> -
> -static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
> -	.fb_probe = bochsfb_create,
> -};
> -
>   static struct drm_framebuffer *
>   bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
>   		    const struct drm_mode_fb_cmd2 *mode_cmd)
> @@ -153,14 +27,3 @@ const struct drm_mode_config_funcs bochs_mode_funcs = {
>   	.atomic_check = drm_atomic_helper_check,
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
> -
> -int bochs_fbdev_init(struct bochs_device *bochs)
> -{
> -	return drm_fb_helper_fbdev_setup(bochs->dev, &bochs->fb.helper,
> -					 &bochs_fb_helper_funcs, 32, 1);
> -}
> -
> -void bochs_fbdev_fini(struct bochs_device *bochs)
> -{
> -	drm_fb_helper_fbdev_teardown(bochs->dev);
> -}

