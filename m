Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF84C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D05B2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlgOUHFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D05B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeKBWml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:42:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43213 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:42:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id k14so1054783vsm.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxmEoFAh28hIXQKFU/paHExjK4yamEXOL11rTKpWL98=;
        b=TlgOUHFzn3YRwlc2mJIqNO1Tvsw074+4+U4C/UWOcg+lDqbt4aoZkJupG+42OJNAGX
         ro+tL45ih/y0QWZRFBfSPexwkZz24qMHdaXZgaddeC5DUGzLDPbzytj4zU89VVICldMa
         QVjWKH4VAzfulPdhTjnEN96/XJQ2vNhU6RGC6aiZ9nmyEGs6ulshYIdUpmj3YtK5Dm+x
         D36fgTtiBidt+PEVhIwMFC8eT0FZ7i18LpEIqHeUhFhAKpkcLeNEfqPOrB+pw5QWz081
         1nlxnWaHJldu/3Eos/LGssNya8dHAnYC2WDR4uKLXIbe8bX02QEvwfyY4FXeHuc2kCHP
         JL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxmEoFAh28hIXQKFU/paHExjK4yamEXOL11rTKpWL98=;
        b=jWqxoKl7jfwuyJ8hc3xjuPrhsVVfaWUY4Q1XntNMnA0K0gUc3GOrZ7IZv3MGVG6QK/
         dPQVxcNXZTiT/2hFcyshJ4FX6dgXtXLnytuJLZx5Tf94y09LAeeO7HgoixwanpSOV0cY
         3W5LxjZlHZJWqSDpZflPWLt6YVAW91q4bfgttv2VOnjWfHBksmQ/m684IHLQhUMLc6WV
         6U6k6TSgcyzoAtjxGsJWql8A03nRC6mgV741efa8qPUJGucngR+KN+g5/1Va83e8RWqj
         7CCqkH0S+YmU4oHWTaclHmE62uul5BI636Ti9x6RZNTcaf6jwrat6mBaM6zchgZKGgo+
         N/UQ==
X-Gm-Message-State: AGRZ1gKlOAz6IWcXudjUfXbc0KU+iGVdBF24bvQCsKJlzKePBKUiwnB+
        P3ic8qFpwenVS5E1Bta6wccmwqeVSpD9J8cM9xY=
X-Google-Smtp-Source: AJdET5cX+8yFNtCay+o4OSZcOwnkShUOx1w8m0nPv88XqtPL+e6Gz9E+0HVmH/jD6goRCF6tPr1KZPwZTdFQMo0aYlQ=
X-Received: by 2002:a67:3f0f:: with SMTP id m15mr4845472vsa.37.1541165729233;
 Fri, 02 Nov 2018 06:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com>
 <20181025183739.9375-3-robert.foss@collabora.com> <CACvgo51LU3dAfO-jNcV02ZyYBOv8fKLhG_2QyRrB9XYfGJrzHQ@mail.gmail.com>
 <3a8a03d6-a544-b9f3-15a2-f6a2411bdb28@collabora.com>
In-Reply-To: <3a8a03d6-a544-b9f3-15a2-f6a2411bdb28@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 2 Nov 2018 13:34:07 +0000
Message-ID: <CACvgo50ARCHZckjxj-eoZbY6U4LA7O4iHQd6X4iQE-xu+Q5hRg@mail.gmail.com>
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

On Thu, 1 Nov 2018 at 12:56, Robert Foss <robert.foss@collabora.com> wrote:
> On 2018-10-31 10:38, Emil Velikov wrote:
> > Hi Rob,
> >
> > On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
> >>
> >> Add a new field called fence_fd that will be used by userspace to send
> >> in-fences to the kernel and receive out-fences created by the kernel.
> >>
> >> This uapi enables virtio to take advantage of explicit synchronization of
> >> dma-bufs.
> >>
> >> There are two new flags:
> >>
> >> * VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
> >> * VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd
> >>
> >> The execbuffer IOCTL is now read-write to allow the userspace to read the
> >> out-fence.
> >>
> >> On error -1 should be returned in the fence_fd field.
> >>
> >> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> >> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> >> ---
> >> Changes since v2:
> >>   - Since exbuf-flags is a new flag, check that unsupported
> >>     flags aren't set.
> >>
> >>   drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
> >>   include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
> >>   2 files changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> index d01a9ed100d1..1af289b28fc4 100644
> >> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> @@ -116,9 +116,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >>          struct ww_acquire_ctx ticket;
> >>          void *buf;
> >>
> >> +       exbuf->fence_fd = -1;
> >> +
> > Move this after the sanity checking.
>
> Agreed. Fixed in v4
>
> >
> >>          if (vgdev->has_virgl_3d == false)
> >>                  return -ENOSYS;
> >>
> >> +       if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> >> +               return -EINVAL;
> >> +
> > I assume this did this trigger when using old userspace?
>
> No, not as far as I'm aware. This check is there to prevent userspace from
> polluting the bitspace of flag, so that all free bits can be used for new flags.
>
> As far as I understand this is pointed out by a drm driver development document
> written by danvet, which I unfortunately can't seem to find the link for at the
> moment.
>
Yes that is correct. What I was asking is:

Does a kernel with this patch, work with mesa lacking the corresponding updates?
I'd imagine things work just fine.

-Emil
