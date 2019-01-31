Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C057BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1CE218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgULjSuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAaTEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:04:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40247 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:04:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so3476317edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akr30pAwS8aXT26iYHWwyNZhFX052Gxp713ZlQMxPhU=;
        b=FgULjSuz5BCZ0ugc8utUzlXwb98WwiCySpVHfcicRDXcp6eQy/eWk/yjA/+X7O5GUJ
         XwXjCxb0dapBnuY6ZUGeppXlvZ/6N+sRLGpkrsInc7wKHruxz4xIvylr+xeO6ZEmAn54
         1XrbvhLsHoqYBsZFKJd0UHLbPoqDhGojuxhV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akr30pAwS8aXT26iYHWwyNZhFX052Gxp713ZlQMxPhU=;
        b=oaD+lrv9UXN2XdgMLp/fu9NfnPYGKz8ryWe7ATW+SM4c9qJ78ccSgdccZ0rxWm7SIS
         l76P4wf5TUYwcm2Sg8rG0OdQffnoEXOFnzoBLuQgScLLN8/B17xM9RkLfHRYRe6O7180
         wqywIonu6h8zx3mjPl93ZvOBJGh5WGfswVpj60cSSQL4HT1DV52vPVyie5kLzYmMP3tH
         v0YVZv/AlCPJqOLtmJ9Jp1Nvi2Y5nPXvDXdVPS/9Hcnbot95dVzcu8ZGupaZLY847I0i
         /M6KwvWI7ANJCQIvOVV4jVj8ZPcIC46WxcWgYqGRDLGSa8BTOGpIxAP6gtG0os/4PF6f
         J0dg==
X-Gm-Message-State: AJcUukelzIS7xz+z+VVtrFJuH27W3RlQCBmmchSQvgu+mexK6hpgxXI2
        sZtwaDBjZQweuiHDODw3m8os/PH+SYE=
X-Google-Smtp-Source: ALg8bN6rFQn10ETY7D8HltK6hzTG2V+qDNma+3v3slJeEmO7+zOGDead56sllPyqHFjqxLGpzGxFrw==
X-Received: by 2002:a50:b536:: with SMTP id y51mr35053151edd.201.1548961484460;
        Thu, 31 Jan 2019 11:04:44 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id j4sm1478728edh.69.2019.01.31.11.04.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:04:43 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id b3so3522252ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:04:43 -0800 (PST)
X-Received: by 2002:a50:84a9:: with SMTP id 38mr35333601edq.185.1548961483104;
 Thu, 31 Jan 2019 11:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20190130094338.14203-1-kraxel@redhat.com> <20190130094338.14203-6-kraxel@redhat.com>
In-Reply-To: <20190130094338.14203-6-kraxel@redhat.com>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Thu, 31 Jan 2019 11:04:31 -0800
X-Gmail-Original-Message-ID: <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
Message-ID: <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in virtio_gpu_resource_create_ioctl
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 1:43 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> There is no need to wait for completion here.
>
> The host will process commands in submit order, so commands can
> reference the new resource just fine even when queued up before
> completion.

Does virtio_gpu_execbuffer_ioctl also wait for completion for a host response?

From the guest driver perspective, a fence is just implemented has a
virtio 3D resource.

https://gitlab.freedesktop.org/mesa/mesa/blob/master/src/gallium/winsys/virgl/drm/virgl_drm_winsys.c#L787

The DRM_IOCTL_VIRTGPU_WAIT ioctl essentially waits for the reservation
objects associated with that fence resource to become available.  So
the flow is:

virtio_gpu_execbuffer_ioctl
virtio_gpu_resource_create_ioctl with fence resource
virtio_gpu_wait_ioctl with that fence resource --> associated with a
GL wait on the host side

Does this change modify this sequence of events?

>
> On the guest side there is no need to wait for completion too.  Which
> btw is different from resource destroy, where we have to make sure the
> host has seen the destroy and thus doesn't use it any more before
> releasing the pages backing the resource.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 51 +---------------------------------
>  1 file changed, 1 insertion(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 431e5d767e..da06ebbb3a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -279,10 +279,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>         struct virtio_gpu_object *qobj;
>         struct drm_gem_object *obj;
>         uint32_t handle = 0;
> -       struct list_head validate_list;
> -       struct ttm_validate_buffer mainbuf;
> -       struct virtio_gpu_fence *fence = NULL;
> -       struct ww_acquire_ctx ticket;
>         struct virtio_gpu_object_params params = { 0 };
>
>         if (vgdev->has_virgl_3d == false) {
> @@ -298,9 +294,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>                         return -EINVAL;
>         }
>
> -       INIT_LIST_HEAD(&validate_list);
> -       memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
> -
>         params.pinned = false,
>         params.format = rc->format;
>         params.width = rc->width;
> @@ -329,62 +322,20 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>
>                 ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
>         } else {
> -               /* use a gem reference since unref list undoes them */
> -               drm_gem_object_get(&qobj->gem_base);
> -               mainbuf.bo = &qobj->tbo;
> -               list_add(&mainbuf.head, &validate_list);
> -
> -               ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> -               if (ret) {
> -                       DRM_DEBUG("failed to validate\n");
> -                       goto fail_unref;
> -               }
> -
> -               fence = virtio_gpu_fence_alloc(vgdev);
> -               if (!fence) {
> -                       ret = -ENOMEM;
> -                       goto fail_backoff;
> -               }
> -
>                 virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
> -               ret = virtio_gpu_object_attach(vgdev, qobj, fence);
> -               if (ret) {
> -                       dma_fence_put(&fence->f);
> -                       goto fail_backoff;
> -               }
> -               ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
> +               ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
>         }
>
>         ret = drm_gem_handle_create(file_priv, obj, &handle);
>         if (ret) {
> -
>                 drm_gem_object_release(obj);
> -               if (vgdev->has_virgl_3d) {
> -                       virtio_gpu_unref_list(&validate_list);
> -                       dma_fence_put(&fence->f);
> -               }
>                 return ret;
>         }
>         drm_gem_object_put_unlocked(obj);
>
>         rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
>         rc->bo_handle = handle;
> -
> -       if (vgdev->has_virgl_3d) {
> -               virtio_gpu_unref_list(&validate_list);
> -               dma_fence_put(&fence->f);
> -       }
>         return 0;
> -fail_backoff:
> -       ttm_eu_backoff_reservation(&ticket, &validate_list);
> -fail_unref:
> -       if (vgdev->has_virgl_3d) {
> -               virtio_gpu_unref_list(&validate_list);
> -               dma_fence_put(&fence->f);
> -       }
> -//fail_obj:
> -//     drm_gem_object_handle_unreference_unlocked(obj);
> -       return ret;
>  }
>
>  static int virtio_gpu_resource_info_ioctl(struct drm_device *dev, void *data,
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
