Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E40ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C4121470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pENDHjKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C4121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJRJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:40:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36512 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJRJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:40:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so32502779qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPCDPbZhW5bvN7kMwbuu498fIAZZn/kroSCUQVQi1Ew=;
        b=pENDHjKgoXqYzfE+7b3ONcaWJxvHbkXxB0K42q9q1FsXcQNyrCHY2Cm/z8gnH/iGPM
         5vcqWjCHiQFRLRCMNShhL90t4qCXTetteu2TaEq0D6o8pwE0r9CADt+KsB44XAG7MW12
         WgGNqPUhaqfyJZyMjpKY2WnyNbsBLqnNQCZY7HfvjW0vYyR1zUvOuXQCe62fbm9cGq40
         9pS55nv5mWVvh2EkkrCefy0rwa3tHoB4gXWJnOji6BEDxZ2Q1ZI8uYhgOy7FuibkE/u+
         tWMajCjiXeHIf6Vxx9QIrc+UULTU38eZKsApkUUbQ5x1Hzn32LL9QDlDaQnQzn4Vtq9y
         DtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPCDPbZhW5bvN7kMwbuu498fIAZZn/kroSCUQVQi1Ew=;
        b=aFRdtWAP2sigpyJdlPoYAb0ikz2hoLYs5Qqm5cRMh/FviTHZgj7GIZF6j6geopDtth
         UX35kQ6UeckmQuN1rOtCb147B/PcxkmAZsWPdaTYAK2CKKPP5tuh+mVidHVDWXACyxC5
         RDcp/RPccySlKG2c6MwPlOUA0BWpZZEH515/3GO2+Knrs+tIZ/yJBO2wCsAFU6e6WZOY
         AYQVSKioqqTgW8ouImR5MdsUD0esx7OSS01qSndV05I0A2x0SOaVDHgF/qcKFzYgROf+
         uF1g9jB8KW7AufU21GILRxQyDpJFFWiNxndKkAXQX5xet8LLayakUt7UkzguatmwryhO
         dC1w==
X-Gm-Message-State: ABuFfogaS3kQ+WHSWrSomQC6Zc1gfBrDXiXabPULnZl+RH5W2Z4T7ovO
        V6IewgbWcYr1zTdZZfprtO9b/FvnCEo84QXU1Lg=
X-Google-Smtp-Source: ACcGV61L9c5B31Hok/fIcaKsgYuxre+F6HOZWn5/knZud520IajGswc/dDvOWfOi64EpDnaF2u4ql6im/DBNkOCfPpg=
X-Received: by 2002:ac8:1739:: with SMTP id w54-v6mr26717470qtj.76.1539826926501;
 Wed, 17 Oct 2018 18:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181001103222.11924-1-kraxel@redhat.com> <20181001103222.11924-8-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-8-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 18 Oct 2018 11:41:52 +1000
Message-ID: <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach} calls.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Remove the virtio_gpu_object_{attach,detach} calls from move_notify()
> callback.  Add them to the ttm_tt_{populate,unpopulate} callbacks, which
> is the correct place to handle this.
>
> The new ttm_tt_{populate,unpopulate} callbacks call the
> ttm_pool_populate()/unpopulate() functions (which are the default
> implementation in case the callbacks not present) for the actual ttm
> work.  Additionally virtio_gpu_object_{attach,detach} is called to
> update the state on the host.

This to me feels more like a bind/unbind operation rather than a
populate/unpopulate operation,

bind is " Bind the backend pages into the aperture in the location"

whereas populate is

allocate pages for a ttm.

Dave.

>
> With that in place the move and move_notify callbacks are not needed
> any more, so drop them.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ttm.c | 70 +++++++++++-------------------------
>  1 file changed, 21 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index cd63dffa6d..96fb17e0fc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -250,33 +250,24 @@ static void virtio_gpu_ttm_io_mem_free(struct ttm_bo_device *bdev,
>   */
>  struct virtio_gpu_ttm_tt {
>         struct ttm_dma_tt               ttm;
> -       struct virtio_gpu_device        *vgdev;
> -       u64                             offset;
> +       struct virtio_gpu_object        *obj;
>  };
>
>  static int virtio_gpu_ttm_backend_bind(struct ttm_tt *ttm,
>                                        struct ttm_mem_reg *bo_mem)
>  {
> -       struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
> -
> -       gtt->offset = (unsigned long)(bo_mem->start << PAGE_SHIFT);
> -       if (!ttm->num_pages)
> -               WARN(1, "nothing to bind %lu pages for mreg %p back %p!\n",
> -                    ttm->num_pages, bo_mem, ttm);
> -
> -       /* Not implemented */
>         return 0;
>  }
>
>  static int virtio_gpu_ttm_backend_unbind(struct ttm_tt *ttm)
>  {
> -       /* Not implemented */
>         return 0;
>  }
>
>  static void virtio_gpu_ttm_backend_destroy(struct ttm_tt *ttm)
>  {
> -       struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
> +       struct virtio_gpu_ttm_tt *gtt =
> +               container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
>
>         ttm_dma_tt_fini(&gtt->ttm);
>         kfree(gtt);
> @@ -299,7 +290,7 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
>         if (gtt == NULL)
>                 return NULL;
>         gtt->ttm.ttm.func = &virtio_gpu_backend_func;
> -       gtt->vgdev = vgdev;
> +       gtt->obj = container_of(bo, struct virtio_gpu_object, tbo);
>         if (ttm_dma_tt_init(&gtt->ttm, bo, page_flags)) {
>                 kfree(gtt);
>                 return NULL;
> @@ -307,49 +298,30 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
>         return &gtt->ttm.ttm;
>  }
>
> -static void virtio_gpu_move_null(struct ttm_buffer_object *bo,
> -                                struct ttm_mem_reg *new_mem)
> -{
> -       struct ttm_mem_reg *old_mem = &bo->mem;
> -
> -       BUG_ON(old_mem->mm_node != NULL);
> -       *old_mem = *new_mem;
> -       new_mem->mm_node = NULL;
> -}
> -
> -static int virtio_gpu_bo_move(struct ttm_buffer_object *bo, bool evict,
> -                             struct ttm_operation_ctx *ctx,
> -                             struct ttm_mem_reg *new_mem)
> +static int virtio_gpu_ttm_tt_populate(struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>  {
> +       struct virtio_gpu_ttm_tt *gtt =
> +               container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
> +       struct virtio_gpu_device *vgdev =
> +               (struct virtio_gpu_device *)gtt->obj->gem_base.dev->dev_private;
>         int ret;
>
> -       ret = ttm_bo_wait(bo, ctx->interruptible, ctx->no_wait_gpu);
> +       ret = ttm_pool_populate(ttm, ctx);
>         if (ret)
>                 return ret;
> -
> -       virtio_gpu_move_null(bo, new_mem);
> -       return 0;
> +       virtio_gpu_object_attach(vgdev, gtt->obj, NULL);
> +       return ret;
>  }
>
> -static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
> -                                     bool evict,
> -                                     struct ttm_mem_reg *new_mem)
> +static void virtio_gpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
>  {
> -       struct virtio_gpu_object *bo;
> -       struct virtio_gpu_device *vgdev;
> +       struct virtio_gpu_ttm_tt *gtt =
> +               container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
> +       struct virtio_gpu_device *vgdev =
> +               (struct virtio_gpu_device *)gtt->obj->gem_base.dev->dev_private;
>
> -       bo = container_of(tbo, struct virtio_gpu_object, tbo);
> -       vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
> -
> -       if (!new_mem || (new_mem->placement & TTM_PL_FLAG_SYSTEM)) {
> -               if (bo->hw_res_handle)
> -                       virtio_gpu_object_detach(vgdev, bo);
> -
> -       } else if (new_mem->placement & TTM_PL_FLAG_TT) {
> -               if (bo->hw_res_handle) {
> -                       virtio_gpu_object_attach(vgdev, bo, NULL);
> -               }
> -       }
> +       virtio_gpu_object_detach(vgdev, gtt->obj);
> +       ttm_pool_unpopulate(ttm);
>  }
>
>  static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
> @@ -366,15 +338,15 @@ static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
>
>  static struct ttm_bo_driver virtio_gpu_bo_driver = {
>         .ttm_tt_create = &virtio_gpu_ttm_tt_create,
> +       .ttm_tt_populate = &virtio_gpu_ttm_tt_populate,
> +       .ttm_tt_unpopulate = &virtio_gpu_ttm_tt_unpopulate,
>         .invalidate_caches = &virtio_gpu_invalidate_caches,
>         .init_mem_type = &virtio_gpu_init_mem_type,
>         .eviction_valuable = ttm_bo_eviction_valuable,
>         .evict_flags = &virtio_gpu_evict_flags,
> -       .move = &virtio_gpu_bo_move,
>         .verify_access = &virtio_gpu_verify_access,
>         .io_mem_reserve = &virtio_gpu_ttm_io_mem_reserve,
>         .io_mem_free = &virtio_gpu_ttm_io_mem_free,
> -       .move_notify = &virtio_gpu_bo_move_notify,
>         .swap_notify = &virtio_gpu_bo_swap_notify,
>  };
>
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
