Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CC320862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6/WP15W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CC320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeIDENW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 00:13:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40776 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIDENW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 00:13:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id c126-v6so1282589qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSUA4Lm64sa73r7X4V9ladYa+Xc4WdOkaN6ottBtR/Q=;
        b=j6/WP15WRKlgnFp9tM+aJRPKQMqzzY9LajBjhmruMWcN6Slx+EDOOQwioqlr4zmeM0
         UGvZNOXZm41fDk5LbJJTnVR/vTGZs0IwFs1/AwrEBz1Yo+VTU//ubUKD7dPYVf5Ktbok
         EaLOP0C2Dw3dt9izHGDSnATeKDynAHIBqkwN/6DR0KTtlAmMuGg477WlT6ThOd9l0ABB
         T3FYcs3HdSbgvezcorIO4GqEyE3YzD+G/KnZ5D2o1bAoKQadLRcE/PsAFnu36ZaAEh4j
         pfVRnYtNRjCosnujb9y5oXmA2VjQQ/+5MmclTsm0rdk9C29b2o9qubS4Z1dUJNFQ7pbY
         ZUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSUA4Lm64sa73r7X4V9ladYa+Xc4WdOkaN6ottBtR/Q=;
        b=oKf7BVJGXJd43WiQ7FZETHwgbvfP4PMgA+VWsFruDGDO/lXTt/y+xPjlanpyp1vGUW
         4ukVOy+tO0c9rfIDrMBBIShO/L4KynoY7KEpQ2sAQuRv+DZv9R/FONHInx5ggcnDghhr
         nDqWE6gDR/54hQslHNOYmwNIDGjLQ2zvXepyNLGjQ9a8kFA8ZZFYXZrS4Ske2ltSeA+V
         YpBditaKcHRyFH2OMhzFp8ezMBAgkqO7LyVchkj7r3W7M93o0U6Nrzvg7WNELpRxqjgy
         nuUldJqBZxv5Fmh6aEj997x4zTpXyXpQ7SPwV9SN+y3tx9ocfuO59bGygnoEVvpNxDHB
         6RXw==
X-Gm-Message-State: APzg51C74jA6KJSjY4CQs/Bjb39lKW4sqZsDDqGHuuFxRUXgFOypmpML
        Zc02Y07VmrwChlHGAK6tyyDISGyeFVG+mrC6tjM=
X-Google-Smtp-Source: ANB0VdamD+akWNepsSW3I/o1x0lA8GRTj+B5BK177KhPZHhtjNgg9CPoBvv5FZVcS8Q3FkMAuTaqz4Wt96lUUmD/4wU=
X-Received: by 2002:a37:5744:: with SMTP id l65-v6mr27099051qkb.216.1536018653657;
 Mon, 03 Sep 2018 16:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180829122026.27012-1-kraxel@redhat.com> <20180829122026.27012-3-kraxel@redhat.com>
In-Reply-To: <20180829122026.27012-3-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 4 Sep 2018 09:50:42 +1000
Message-ID: <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        virtio-dev@lists.oasis-open.org, Dave Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the series,

Reviewed-by: Dave Airlie <airlied@redhat.com>
On Wed, 29 Aug 2018 at 22:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use the dma mapping api and properly add iommu mappings for
> objects, unless virtio is in iommu quirk mode.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 46 +++++++++++++++++++++++++++++-------
>  2 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index cbbff01077..ec9a38f995 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -57,6 +57,7 @@ struct virtio_gpu_object {
>         uint32_t hw_res_handle;
>
>         struct sg_table *pages;
> +       uint32_t mapped;
>         void *vmap;
>         bool dumb;
>         struct ttm_place                placement_code;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index af24e91267..bf631d32d4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -424,7 +424,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
>  }
>
>  static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
> -                                                 uint32_t resource_id)
> +                                                 uint32_t resource_id,
> +                                                 struct virtio_gpu_fence **fence)
>  {
>         struct virtio_gpu_resource_detach_backing *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
> @@ -435,7 +436,7 @@ static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgde
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING);
>         cmd_p->resource_id = cpu_to_le32(resource_id);
>
> -       virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +       virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
>  }
>
>  void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
> @@ -848,9 +849,10 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>                              uint32_t resource_id,
>                              struct virtio_gpu_fence **fence)
>  {
> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
>         struct virtio_gpu_mem_entry *ents;
>         struct scatterlist *sg;
> -       int si;
> +       int si, nents;
>
>         if (!obj->pages) {
>                 int ret;
> @@ -860,23 +862,33 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>                         return ret;
>         }
>
> +       if (use_dma_api) {
> +               obj->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> +                                        obj->pages->sgl, obj->pages->nents,
> +                                        DMA_TO_DEVICE);
> +               nents = obj->mapped;
> +       } else {
> +               nents = obj->pages->nents;
> +       }
> +
>         /* gets freed when the ring has consumed it */
> -       ents = kmalloc_array(obj->pages->nents,
> -                            sizeof(struct virtio_gpu_mem_entry),
> +       ents = kmalloc_array(nents, sizeof(struct virtio_gpu_mem_entry),
>                              GFP_KERNEL);
>         if (!ents) {
>                 DRM_ERROR("failed to allocate ent list\n");
>                 return -ENOMEM;
>         }
>
> -       for_each_sg(obj->pages->sgl, sg, obj->pages->nents, si) {
> -               ents[si].addr = cpu_to_le64(sg_phys(sg));
> +       for_each_sg(obj->pages->sgl, sg, nents, si) {
> +               ents[si].addr = cpu_to_le64(use_dma_api
> +                                           ? sg_dma_address(sg)
> +                                           : sg_phys(sg));
>                 ents[si].length = cpu_to_le32(sg->length);
>                 ents[si].padding = 0;
>         }
>
>         virtio_gpu_cmd_resource_attach_backing(vgdev, resource_id,
> -                                              ents, obj->pages->nents,
> +                                              ents, nents,
>                                                fence);
>         obj->hw_res_handle = resource_id;
>         return 0;
> @@ -885,7 +897,23 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>  void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
>                               struct virtio_gpu_object *obj)
>  {
> -       virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle);
> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +       struct virtio_gpu_fence *fence;
> +
> +       if (use_dma_api && obj->mapped) {
> +               /* detach backing and wait for the host process it ... */
> +               virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, &fence);
> +               dma_fence_wait(&fence->f, true);
> +               dma_fence_put(&fence->f);
> +
> +               /* ... then tear down iommu mappings */
> +               dma_unmap_sg(vgdev->vdev->dev.parent,
> +                            obj->pages->sgl, obj->mapped,
> +                            DMA_TO_DEVICE);
> +               obj->mapped = 0;
> +       } else {
> +               virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, NULL);
> +       }
>  }
>
>  void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
> --
> 2.9.3
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
