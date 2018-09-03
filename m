Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76FCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4709F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g68gczzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4709F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeIDEFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 00:05:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43539 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeIDEFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 00:05:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id 130-v6so1267866qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpClmVdRBAJLP8358jxqDWLLg0qTjT/aM88Cu/hzyUo=;
        b=g68gczzKpyx/mgTBKO5o9YJzcoD8zp8VTbVuz22TseiOTS2Kg5mn0t6MfUlfK0mXn2
         5PgZVLtUudcbHOuegj8hxQPdcx6BzZ6uJAoAhadfUGq4/V4l+QzykqBDRlMBojRaYRfs
         DWKcQ3tTC9jBLDaIiAaWGbG469F6HAXaKW99Mtmw+EWXNh5tgQEJy2Ch2vDUFW3Y0b0u
         CClgz3lYOQ69hOUobujmC6DdtSADLtwdOwROiyR+2SVl4QvKKB0t6y2BiIHOaJya1RFS
         UxVlKlka2S+EHKfBLoJDfh/x0vGI7J+kEeIa1kTYRWJrWrveIONQOQLG5dxIyzLzfGCy
         icNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpClmVdRBAJLP8358jxqDWLLg0qTjT/aM88Cu/hzyUo=;
        b=htns2Cd+6mjI6IFO8H2WWYwDqXAOKfTGfFBFMG91bm4jXHCwAOFweSj7WML9NZ2iVB
         xvd/zSKs0LanYeXsUvwINhojDdD2WC+5vp0G2TQQPBi2MVZHI6CNrJSQm7jQSU/BvTLC
         kQHv3i/cpzO40h2RQAz+kYfeifjIOOyVvD/g/0i24oO/3NbdIoLq0HNht5mzGnbgSceX
         7EY6cJiqtNc+8bQjGYaXhyf+TG4L2LaMmVigVtJ/qUEQqPQ6dOkjYf+dBfhWf/Nn9EAw
         RsF5V0fBf7NoBfNeZ8yUdqO3L4G0sCGq3sBbq8KE30LoykClFInke4eCu0gBCuMk0QFV
         BpEg==
X-Gm-Message-State: APzg51ARnW79knEkZvghSzri3QX/4bjAtIopJk4ispkeYrZgMWOd0KzG
        37UlzO9WycOKQNN24QajT/M11U5YUPwEL06xyLEU/A==
X-Google-Smtp-Source: ANB0VdbvMG/zzyWvQx4e2eB114ZL/Q0U34emG60j3RNvVbKUcFw3+Bq/TW+4VZii5bi2Rd4xtTxFNBusCYxutHTjxIc=
X-Received: by 2002:a37:5744:: with SMTP id l65-v6mr27083057qkb.216.1536018186887;
 Mon, 03 Sep 2018 16:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180813152855.12863-1-kraxel@redhat.com>
In-Reply-To: <20180813152855.12863-1-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 4 Sep 2018 09:42:54 +1000
Message-ID: <CAPM=9txw2=wtTArOY-EHGsq28xfnWse070fRzLT7JR4oyxZN8g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: track virtual output state
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

On Tue, 14 Aug 2018 at 01:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Track whenever an virtual output (crtc) is enabled or disabled.
>
> On atomic updates check for both framebuffer being present and crtc
> being enabled to figure whenever the output is active or not.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
>  drivers/gpu/drm/virtio/virtgpu_display.c | 4 ++++
>  drivers/gpu/drm/virtio/virtgpu_plane.c   | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 65605e207b..d46f10e656 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -114,6 +114,7 @@ struct virtio_gpu_output {
>         struct virtio_gpu_update_cursor cursor;
>         int cur_x;
>         int cur_y;
> +       bool enabled;
>  };
>  #define drm_crtc_to_virtio_gpu_output(x) \
>         container_of(x, struct virtio_gpu_output, crtc)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 25503b9335..9f1e0a669d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -109,6 +109,9 @@ static void virtio_gpu_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
>                                           struct drm_crtc_state *old_state)
>  {
> +       struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
> +
> +       output->enabled = true;
>  }
>
>  static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
> @@ -119,6 +122,7 @@ static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
>         struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
>
>         virtio_gpu_cmd_set_scanout(vgdev, output->index, 0, 0, 0, 0, 0);
> +       output->enabled = false;
>  }
>
>  static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index dc5b5b2b7a..88f2fb8c61 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -152,7 +152,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>         if (WARN_ON(!output))
>                 return;
>
> -       if (plane->state->fb) {
> +       if (plane->state->fb && output->enabled) {
>                 vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
>                 bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
>                 handle = bo->hw_res_handle;
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
