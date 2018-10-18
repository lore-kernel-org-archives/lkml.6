Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A54ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763862083E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH5jXvHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763862083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJRJYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:24:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41177 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:24:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so32437386qtl.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t27sUZb2P/VMpTeQiWfb7AKdjdCcA4gG+3+9VZsQwkE=;
        b=lH5jXvHSaFzKTV4aDhLuP/b+cPLrRrwGWw9NkpGtNbu20YAh1m3kPZKKAA5841A2DS
         tog01DbiydB6AUYlxfUT7J1ZDhOs/kP1XL89av3RGxBtGpx7IxXgkYdd/lJA93Egosm3
         SzBb/qcTpnQErMQq3T1qb7iPjymE+gj1mX7RPCwUMb70rp8moLokvBpBYgfnbnqjI+2r
         hBk+qYzvQGDdIjunQyQHeQh6wjT8ZyMZ4V3zCnme+u+0aXApBjgT0KJd9Zd4z6A1mdSk
         CFuo59zfVssX6fGoyBZ2N/q5qnWCOROBP4sXut+lYEI3geJ3EI74Te3LDlhGPKR5eiXl
         2F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t27sUZb2P/VMpTeQiWfb7AKdjdCcA4gG+3+9VZsQwkE=;
        b=hsq8nCUhvOHOLDxjjwV2m7UWFhPXWM2JGsXaTHvVU5mv5Nrd+Kex2cG5GurXGsP9RX
         bj18q3KoGNRktOoPLGgrxaC6MpwDkJhUwTRrQ/l/kYF5y7IOP2gtfp8JKj9MhIHVjdl3
         yaesokqaM0wwbJ9D52IEN+9rHKTZ/AFtkyvQ1cW/eO9I5r39SWxqRUi5pD4CWAPZzdLH
         R5+TrgL9klSgQierUqk+Z78Y6loNgxCCfj3bjzjIHwC6trfjXSXDsJwzSSTBxXU6uhlY
         32UY4K+27ogrDnRRDrwb3+sDVsUBU7xhJDiIxEpmQFJHwvvn4zk/01bHeXzVvcoNTMx5
         igaQ==
X-Gm-Message-State: ABuFfoj2pQ3yzfSR4QXlOkE90CyVgcE+3Ch8EOGKG6GLq7oNZX9TfAec
        uzaJLMyttiJXFHNvQyQSM9noJy1JyycV0C2A4RA=
X-Google-Smtp-Source: ACcGV62Gsu5JDILhTmTqIjKVmjsp0aElx69gPAsza+1wPcFbPa0a556Fj5fSXYtzSLYJj9SDXOPNFWlSDV6rwd/q4TE=
X-Received: by 2002:ac8:1739:: with SMTP id w54-v6mr26680844qtj.76.1539825934204;
 Wed, 17 Oct 2018 18:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181001103222.11924-1-kraxel@redhat.com> <20181001103222.11924-6-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-6-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 18 Oct 2018 11:25:22 +1000
Message-ID: <CAPM=9tzpzxv9TorRDWX3=sj_=EEqu3gyU2+AyWAFVHLPzZVcew@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/virtio: track created object state
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
> Track whenever the virtio_gpu_object is already created (i.e. host knows
> about it) in a new variable.  Add checks to virtio_gpu_object_attach()
> to do nothing on objects not created yet.
>
> Make virtio_gpu_ttm_bo_destroy() use the new variable too, instead of
> expecting hw_res_handle indicating the object state.

Is there a potential patch ordering issue here? If this patch changes
the code to avoid using hw_res_handle,
is after patches that start filling in hw_res_handle in places we
haven't filled it in before.

Maybe this patch should happen earlier.

Dave.

>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 3 ++-
>  drivers/gpu/drm/virtio/virtgpu_fb.c     | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_gem.c    | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 3 ++-
>  drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 8 ++++++--
>  6 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9b26e8ee84..4a39877ce6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -65,6 +65,7 @@ struct virtio_gpu_object {
>         struct ttm_placement            placement;
>         struct ttm_buffer_object        tbo;
>         struct ttm_bo_kmap_obj          kmap;
> +       bool created;
>  };
>  #define gem_to_virtio_gpu_obj(gobj) \
>         container_of((gobj), struct virtio_gpu_object, gem_base)
> @@ -263,7 +264,7 @@ void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
>                                uint32_t *resid);
>  void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
>  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
> -                                   uint32_t resource_id,
> +                                   struct virtio_gpu_object *bo,
>                                     uint32_t format,
>                                     uint32_t width,
>                                     uint32_t height);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
> index b16c62c4d8..c22a8246b6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fb.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
> @@ -232,7 +232,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
>                 return PTR_ERR(obj);
>
>         virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
> -       virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
> +       virtio_gpu_cmd_create_resource(vgdev, obj, format,
>                                        mode_cmd.width, mode_cmd.height);
>
>         ret = virtio_gpu_object_kmap(obj);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 5450f7ab5b..665d18a49d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -104,7 +104,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>         format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
>         obj = gem_to_virtio_gpu_obj(gobj);
>         virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
> -       virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
> +       virtio_gpu_cmd_create_resource(vgdev, obj, format,
>                                        args->width, args->height);
>
>         /* attach the object to the resource */
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 44c9160c14..f9c55ecfca 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -256,7 +256,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>         virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
>
>         if (!vgdev->has_virgl_3d) {
> -               virtio_gpu_cmd_create_resource(vgdev, qobj->hw_res_handle, rc->format,
> +               virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
>                                                rc->width, rc->height);
>
>                 ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
> @@ -285,6 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>                 rc_3d.flags = cpu_to_le32(rc->flags);
>
>                 virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
> +               qobj->created = true;
>                 ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
>                 if (ret) {
>                         ttm_eu_backoff_reservation(&ticket, &validate_list);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index eca7655374..6611c487d7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -33,7 +33,7 @@ static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>         bo = container_of(tbo, struct virtio_gpu_object, tbo);
>         vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
>
> -       if (bo->hw_res_handle)
> +       if (bo->created)
>                 virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
>         if (bo->pages)
>                 virtio_gpu_object_free_sg_table(bo);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index dd4464ccb1..45da3c87b6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -388,7 +388,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>
>  /* create a basic resource */
>  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
> -                                   uint32_t resource_id,
> +                                   struct virtio_gpu_object *bo,
>                                     uint32_t format,
>                                     uint32_t width,
>                                     uint32_t height)
> @@ -400,12 +400,13 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>         memset(cmd_p, 0, sizeof(*cmd_p));
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
>         cmd_p->format = cpu_to_le32(format);
>         cmd_p->width = cpu_to_le32(width);
>         cmd_p->height = cpu_to_le32(height);
>
>         virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +       bo->created = true;
>  }
>
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
> @@ -868,6 +869,9 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>         struct scatterlist *sg;
>         int si, nents;
>
> +       if (!obj->created)
> +               return 0;
> +
>         if (!obj->pages) {
>                 int ret;
>
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
