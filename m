Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B562E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu5lXJXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B562E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJaShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:37:24 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45322 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:37:24 -0400
Received: by mail-vs1-f68.google.com with SMTP id 124so9562373vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CQy1/VUW6sK32rDRikKm2BgIyWxCsrT0BkLa04nM8g=;
        b=Qu5lXJXBK9RNONC3MZlwsOXW1RJ15EZzd5fy3kXLq9ahNLw9yuMxp+9qccNdFQ0+yv
         HrUbCdQyy7qVrHquqd4k+pwee89htv6ObzCJsa9VTIof1yJh0RkUKR2pAwzg9mpDpK20
         2hQn9c/V9GwfHv8dIpbazyl1dXhwqzQ6C8TK9HJTOrP1/CPCjcGClNjJYHbOppqx6c60
         OsdOts5ijX6sU8CPwqZnBO7rhuH1+sDumxaXJT1DmahW+1ZT9KmiXFxZ0wfqCLFveRlh
         zSKXYxYbDEjYRZ+JqD1dRl3MbT5FYeFnuLejU7SeGXrBt5+s4SgickLgccAXwKyc1yqO
         eQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CQy1/VUW6sK32rDRikKm2BgIyWxCsrT0BkLa04nM8g=;
        b=VWj3GSpEgTA9lS/G6h+lju8Io+bWt6zaRvKXooOf04VZKYYsOhlmCeGgerJmAuFRpE
         XvuDpBLI0loYWgvl+NtCHrIyTlZ+iyyQLTI1T+jvIawVbw4N9L5AdRyneM/TjitVo0+z
         eH0vOiZ4J9uVaAangLsAGePB18hRfUsx7UgDrtwfn3Tzq3lG4GAHnwXRCu93rW/x4clv
         2KOmkVK316ld3SRcw9sp6GURU3HOjvbsFokIpsAL8/QH02/aSMV9UikDsUh7+rvzF3DQ
         hrRvTM1xEo3cXJ66yV3n/PWza1TIezbi2nDdpr9zjtYeaJA739mPJ2UANBxQE0m1oBnU
         LOsg==
X-Gm-Message-State: AGRZ1gI14msHzRgKaN3SGBpN1p2llm07ih4iWAz5kRX85BnJ95Vcrr8w
        ywbs6G+ofovov2+gVQn2Q9yymgm0XQ1clRrS3zw=
X-Google-Smtp-Source: AJdET5ek2vVXNeE9UlX9h/Wyyw6H/GtYbZVOftfTGfvE68MxtI2fJcz0s12i/twJ2ObXuE4WqrVyb9DbilWhnPS5Jpw=
X-Received: by 2002:a67:41db:: with SMTP id x88mr939034vsf.138.1540978801689;
 Wed, 31 Oct 2018 02:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com> <20181025183739.9375-3-robert.foss@collabora.com>
In-Reply-To: <20181025183739.9375-3-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 09:38:43 +0000
Message-ID: <CACvgo51LU3dAfO-jNcV02ZyYBOv8fKLhG_2QyRrB9XYfGJrzHQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
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
> Add a new field called fence_fd that will be used by userspace to send
> in-fences to the kernel and receive out-fences created by the kernel.
>
> This uapi enables virtio to take advantage of explicit synchronization of
> dma-bufs.
>
> There are two new flags:
>
> * VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
> * VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd
>
> The execbuffer IOCTL is now read-write to allow the userspace to read the
> out-fence.
>
> On error -1 should be returned in the fence_fd field.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> ---
> Changes since v2:
>  - Since exbuf-flags is a new flag, check that unsupported
>    flags aren't set.
>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>  include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index d01a9ed100d1..1af289b28fc4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -116,9 +116,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         struct ww_acquire_ctx ticket;
>         void *buf;
>
> +       exbuf->fence_fd = -1;
> +
Move this after the sanity checking.

>         if (vgdev->has_virgl_3d == false)
>                 return -ENOSYS;
>
> +       if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> +               return -EINVAL;
> +
I assume this did this trigger when using old userspace?

With those the patch is
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Thanks
Emil
