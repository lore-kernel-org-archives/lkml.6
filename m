Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3EAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD963214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="hdtQ8Z7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfAJI5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:57:55 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:53270 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfAJI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=toSHB2G0ge17AobBTfMRKQv/eziW95ImP3z9T2YITzw=;
        b=hdtQ8Z7BXGeTyJBo6KWFXso9pH3PvffX+KQfrwaOASh/2oNceWrzQRRCB4kxWXvJMhp6s8AW8gmO4WbnwjLljcgvTnhnvJHKO1Pxo2W+FKM5fwxhLUV2lgUZ04uW5ImGiilSpE6AuoBn8Kq7Pq+PJu/+7RBC9Ig7qnHKUGvWIb7PM5nCHb5ZbBi3P5Zi/jQnw7POgRLa5i84b2lebEe4tW+80Fmrb9YFf1+TOENaWCPXLIDUv6hPY3d8dTTzaA/wedCNWb9ydWfKfk9+n/rQJySkGabRC+tmJkJdbjDeaRvOP+uSqkvqSgBunMGf0UFMGCQE0YicW46jNfftKy0G4w==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:57434 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ghW9v-0005Jr-6d; Thu, 10 Jan 2019 09:57:51 +0100
Subject: Re: [PATCH v3 14/15] drm/bochs: drop old fbdev emulation code
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20190110082845.3453-1-kraxel@redhat.com>
 <20190110082845.3453-15-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <faf265e5-8f47-f652-5b19-d55fd4ed7d67@tronnes.org>
Date:   Thu, 10 Jan 2019 09:57:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110082845.3453-15-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.01.2019 09.28, skrev Gerd Hoffmann:
> Not needed any more, bochs uses the generic emulation now.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/bochs/bochs.h       |   9 ---
>  drivers/gpu/drm/bochs/bochs_drv.c   |   6 --
>  drivers/gpu/drm/bochs/bochs_fbdev.c | 129 ------------------------------------
>  3 files changed, 144 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index ede22beb85..03711394f1 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -80,12 +80,6 @@ struct bochs_device {
>  		struct ttm_bo_device bdev;
>  		bool initialized;
>  	} ttm;
> -
> -	/* fbdev */
> -	struct {
> -		struct drm_framebuffer *fb;
> -		struct drm_fb_helper helper;
> -	} fb;
>  };
>  
>  struct bochs_bo {
> @@ -157,7 +151,4 @@ int bochs_kms_init(struct bochs_device *bochs);
>  void bochs_kms_fini(struct bochs_device *bochs);
>  
>  /* bochs_fbdev.c */
> -int bochs_fbdev_init(struct bochs_device *bochs);
> -void bochs_fbdev_fini(struct bochs_device *bochs);
> -
>  extern const struct drm_mode_config_funcs bochs_mode_funcs;
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index 1d86c0fb5f..a8968cd8d5 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -102,12 +102,9 @@ static int bochs_pm_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -	struct bochs_device *bochs = drm_dev->dev_private;
>  
>  	drm_kms_helper_poll_disable(drm_dev);
>  
> -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);

The generic fbdev emulation doesn't take care of suspend/resume. You
could do this:
drm_fb_helper_set_suspend_unlocked(drm_dev->fb_helper, 1);

> -
>  	return 0;
>  }
>  
> @@ -115,12 +112,9 @@ static int bochs_pm_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -	struct bochs_device *bochs = drm_dev->dev_private;
>  
>  	drm_helper_resume_force_mode(drm_dev);

The docs for this function has this to say:
* This function is deprecated. New drivers should implement atomic mode-
* setting and use the atomic suspend/resume helpers.

Maybe you can use drm_mode_config_helper_suspend/resume() instead like
suggested in the drm_fbdev_generic_setup() docs.

Noralf.

>  
> -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
> -
>  	drm_kms_helper_poll_enable(drm_dev);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
> index ccf783b038..7cac3f5253 100644
> --- a/drivers/gpu/drm/bochs/bochs_fbdev.c
> +++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
> @@ -11,124 +11,6 @@
>  
>  /* ---------------------------------------------------------------------- */
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
> -	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
> -	if (ret) {
> -		DRM_ERROR("failed to pin fbcon\n");
> -		return ret;
> -	}
> -
> -	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages,
> -			  &bo->kmap);
> -	if (ret) {
> -		DRM_ERROR("failed to kmap fbcon\n");
> -		return ret;
> -	}
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
>  static struct drm_framebuffer *
>  bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
>  		    const struct drm_mode_fb_cmd2 *mode_cmd)
> @@ -145,14 +27,3 @@ const struct drm_mode_config_funcs bochs_mode_funcs = {
>  	.atomic_check = drm_atomic_helper_check,
>  	.atomic_commit = drm_atomic_helper_commit,
>  };
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
> 
