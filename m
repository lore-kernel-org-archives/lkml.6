Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A286C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86220878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ2zr1lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfAKVOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:14:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36221 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfAKVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:14:32 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so20418001qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqQgiSuVNjHbY0DzQNt6elhDjZhe5frmxgkV4u9a6GE=;
        b=QJ2zr1lOYsT7gDDV4zRwyv79xFg/jiWJ5QOOMJNYG2DCruLD47wvFWcgMUxm6vN7PP
         bL3RBcmY92WqgU8X31IwgPD5T2ZJYvaBr7WTAG/oAg0bxHTmOFMzNNN2iy3vFjB6CFgd
         HmTReMZGUKpO/dyzfNYZFv56iRr632l6O4k6phzZ/hFmraxB2+I6nBQBf62RzaAN7shG
         P1hr0kNaLtSWlgLqKvlTtGLqKYz4VZ2RdIfCYpdK6XhlvmIFy8fS+1BUcxFNo7qJguIL
         3w5PysFaAnYUVkuNXn5F9oYBf3EybL09ltu/xUpZgyr7p+/ANQkZg9/fIOEJRqpBpKVn
         E1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqQgiSuVNjHbY0DzQNt6elhDjZhe5frmxgkV4u9a6GE=;
        b=YYJn1bG/m9Bj0+RvTobgXeJZ2+NTbfD1Jk9I0TjLtuNirz6GZDo9d5TLC364XpdvxW
         sz43oBl4cbnEySbBchuS/XSpiBJXfcn0+vpE5t/zD2MhZVqb1nGegfpPf5DC54SzMOxy
         cSmK0qr6paYSTEjt5zzE+KqUgiNwx/lMr07x1aN6QTq7arOI+Iqn93NWwvy3GhQBqO+2
         YhOMehdmWdNGDl0XFxW5Jb18Hyr2QpT5P86YgTs0r+loRXJjnhVNxSAg8hBuAe+b2WW5
         BMgM9gG0gYFrFWaV0apknW5NGDpMw1lvUKw5iii81UyJYRNWwxGOoUpSxMTsDNidrUhR
         dV5g==
X-Gm-Message-State: AJcUukfh24SnmKn9hQ/B9PK2DFe1hDnplyLgcm5lSoyPOr+f+A9IHlTm
        pEGedTLx+iorJhxHrk6hVQUl0IzhV8PDHbC6jffj1Q==
X-Google-Smtp-Source: ALg8bN6IunOGWiP7vxXnsEDuKvRknJLMQefvsmopOXUMkk3/L/TfKGqKao870k0Me08pA9KrGfX8W9EibuaD2zYrfS4=
X-Received: by 2002:ac8:296a:: with SMTP id z39mr15647575qtz.264.1547241271614;
 Fri, 11 Jan 2019 13:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20190110111545.26768-1-kraxel@redhat.com>
In-Reply-To: <20190110111545.26768-1-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 12 Jan 2019 07:14:19 +1000
Message-ID: <CAPM=9txB+gB6Wy42V+5bPN6XvVbxbbSmmg1bkzbQWmCcVT5BiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: drop prime import/export callbacks
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 21:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> userspace.

Reviewed-by: Dave Airlie <airlied@redhat.com>
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ----
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ----
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 14 --------------
>  3 files changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index cf896d8793..4f2f3c43a4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -354,10 +354,6 @@ int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
>  /* virtgpu_prime.c */
>  int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
>  void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
> -struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> -struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> -       struct drm_device *dev, struct dma_buf_attachment *attach,
> -       struct sg_table *sgt);
>  void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
>  void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
>  int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index af92964b68..b996ac1d4f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -205,14 +205,10 @@ static struct drm_driver driver = {
>  #if defined(CONFIG_DEBUG_FS)
>         .debugfs_init = virtio_gpu_debugfs_init,
>  #endif
> -       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>         .gem_prime_export = drm_gem_prime_export,
>         .gem_prime_import = drm_gem_prime_import,
>         .gem_prime_pin = virtgpu_gem_prime_pin,
>         .gem_prime_unpin = virtgpu_gem_prime_unpin,
> -       .gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
> -       .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
>         .gem_prime_vmap = virtgpu_gem_prime_vmap,
>         .gem_prime_vunmap = virtgpu_gem_prime_vunmap,
>         .gem_prime_mmap = virtgpu_gem_prime_mmap,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 86ce0ae93f..c59ec34c80 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -39,20 +39,6 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
>         WARN_ONCE(1, "not implemented");
>  }
>
> -struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
> -{
> -       WARN_ONCE(1, "not implemented");
> -       return ERR_PTR(-ENODEV);
> -}
> -
> -struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> -       struct drm_device *dev, struct dma_buf_attachment *attach,
> -       struct sg_table *table)
> -{
> -       WARN_ONCE(1, "not implemented");
> -       return ERR_PTR(-ENODEV);
> -}
> -
>  void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
>  {
>         struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
