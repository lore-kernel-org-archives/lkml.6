Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B905DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBFB20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC2aQ/55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBFB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeJaSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:38:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39423 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:38:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id h78so8518229vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koEaX2WE3ZBls9EXsPoMftPSIHHrvv/SRUgkNf2FbOU=;
        b=mC2aQ/55/kNbVcXO7H+OVooLBG3SzRPkH8yq1FphKRHeBqwUIofYETrh+gN4GvZ7tO
         wHSjiaWQ8aouKOrkaRsqThDqRASksKAf+oFveUEo336/9UYNyP0XQmnjgWwu7jFvFO4N
         /IkCjfKaeK+0GNZCy4X+yHDuG3Pg3Hx7wRAQmyz5f6mhJ3lU7wBtkoA4clEDScOIGrr2
         yFtZTM9O6H9kJedkHEvgxWP6Fg8xK+dh+8YWGMkopR9/E9dRi1firRSCMoTsGd3OBy/c
         NWlX4T90HDlilEE+aVeYfNUvxBJVPLLmTBkQ8hkbXTUhEPUHO1YmP5nS90J8Y136oB5a
         tErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koEaX2WE3ZBls9EXsPoMftPSIHHrvv/SRUgkNf2FbOU=;
        b=sW0KhmgFZBahmuM3IFqILYxiIgyp11qCJaZQqg5NA76rHtrBi4vECFnYv8n2sSIKdT
         jVyECyHvvQ2KHJZRjXOqFNb29oKm+zi6PMkfg/+St2Ot3Jevp882ALOBCo7wMeKUbDkq
         f8d4Svx0eLJ9vJMAbzklYzOC8GwWAnm4FTlEy0na4A86Y/+t3QVn3nVcjNRZ3rGcKT65
         Gt+hp4cXIkTdveSqlRxAx6AEepWTEF7rAfmVSxiHoZgfArjTNj7hR7wOwhO7CnBLCkRC
         CLlV4WHCrxbJorV5d0BDpoVZavteX2t6v8aomptyDMgpqXxq02UhCDtYvDPfA4bn5yba
         hWpg==
X-Gm-Message-State: AGRZ1gJo4bqqmg7LXGVc2rPZKvYVj4M0gkpumBDOyhb/4kBCLnjoQkGt
        BHZrpdqSbv8zhbeS/Y3XNrJUls/k9aWiJrdzi6k=
X-Google-Smtp-Source: AJdET5cl2cZF8cg1vsNzGbteoTWiVPOCHDUif641XN+/a9MbazyDtrVHx/T6xub4RTK+6ovcsDAFQg8uv09R3EfW1L4=
X-Received: by 2002:a67:3144:: with SMTP id x65mr953819vsx.186.1540978849675;
 Wed, 31 Oct 2018 02:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com> <20181025183739.9375-5-robert.foss@collabora.com>
In-Reply-To: <20181025183739.9375-5-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 09:39:31 +0000
Message-ID: <CACvgo52oG3uMPj2ASqPWvBYS7mUwm=nzKwMYSs8xZWq_OAL_2w@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/virtio: add out-fences support for explicit synchronization
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>
> On the out-fence side we get fence returned by the submitted draw call
> and attach it to a sync_file and send the sync_file fd to userspace. On
> error -1 is returned to userspace.
>
Can we have both an IN and OUT fence at the same time? Either way, please
mention that in the commit message.

> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 50 +++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0368195966aa..32e714a1c753 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -106,7 +106,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
>         struct drm_gem_object *gobj;
> -       struct virtio_gpu_fence *fence;
> +       struct virtio_gpu_fence *out_fence;
>         struct virtio_gpu_object *qobj;
>         int ret;
>         uint32_t *bo_handles = NULL;
> @@ -116,7 +116,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         int i;
>         struct ww_acquire_ctx ticket;
>         struct dma_fence *in_fence = NULL;
> +       struct sync_file *sync_file;
>         int in_fence_fd = exbuf->fence_fd;
> +       int out_fence_fd = -1;
>         void *buf;
>
>         exbuf->fence_fd = -1;
> @@ -143,6 +145,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 }
>         }
>
> +       if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
> +               out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> +               if (out_fence_fd < 0) {
> +                       ret = out_fence_fd;
> +                       goto out_in_fence;
> +               }
> +       }
> +
If the answer to the above is "no" we want a check around here.

With that the patch is
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
