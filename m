Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F60C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A6720878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzvkg0NW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfAKVN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:13:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39280 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfAKVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:13:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so20409077qtj.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06yp1b9pg/ewoGwVUdqX/v6YRrwhbq9hvYcQrtRjLEc=;
        b=tzvkg0NWOS31JkV7K6sPRK7gT5uz/BhYObVcdy/T5kK93Ff++9S22xVf0fZp1CmJ+Q
         157OEzfTruCmQ0f96yz0e41mTMmnH0yGhGIF77NP4wwJDcAQMoJ5IO5+pK0h/5Sms3Mm
         TX1kwCNrj/GKXN7eNGGU5RcNGqRmCciXubZ4WwzQNO389Ag61h+m31hY1pDjhrAooIzW
         OWzpvvwoPUqbsRWFz+aqI3SclpxUdh2u+PIcN1pNJRtT9NMwbnseL8ByLcNmwKq+OUQD
         CCm/hCwqvnv2CDv7kF2qRPBRR3XNdOyR12/DPq1P1Hlpwb5zbgbni5cl94MPqGTWNLfF
         kTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06yp1b9pg/ewoGwVUdqX/v6YRrwhbq9hvYcQrtRjLEc=;
        b=WLWLNgI1oGi+GamzpOXYPIU4wnitucxFs59BQlS69aIQ1Wx1qrfP+fKCL/dNVsR1iO
         b74NhrHuG33CtwiDPz6qT5QEDUnv+dj70jAQkWGsJ+8ATRKnWjIFOrlh/uRgB+s5+bWo
         x6m/Kj4S/RWKPYzVeeNSOuzTLvHFYHKw3e3bkHz46oDsYhbmoU1jnJY/RjPF7F4P9tAn
         CjGb1X6HHN6LCQyGfpEiO31miNJ8V56E8VO083gFYl/6wPq1Mx4V7oKQjaTEkqWz8SCH
         dir7oWc/N0arLGu812RXJW6qsTiZLCgK536WSLeXgbbF7sh+QeJc7tsqhCLHyqUa6IAs
         KTZQ==
X-Gm-Message-State: AJcUukcVWxfpRrskx+QGXLUz0/eN07C1220MGxYaGmGTHUmWUTw10gVb
        XdB9c4teVxU2nI41ZoOU1WpP6pDhYtqVFauKvWM=
X-Google-Smtp-Source: ALg8bN7AOf8jxUQfg6BfIQxpI/W3J1L9vZqqGjn4U72FAWvR0+ATWiND326f6BQ41IuaHTXfl0xLLXRNC4+0JRM/i6Y=
X-Received: by 2002:a0c:e84f:: with SMTP id l15mr15225307qvo.124.1547241234609;
 Fri, 11 Jan 2019 13:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20190110081750.11358-1-kraxel@redhat.com>
In-Reply-To: <20190110081750.11358-1-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 12 Jan 2019 07:13:42 +1000
Message-ID: <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 18:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> userspace.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c   |  4 ----
>  drivers/gpu/drm/qxl/qxl_prime.c | 14 --------------
>  2 files changed, 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 13c8a662f9..ccb090f3ab 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -250,14 +250,10 @@ static struct drm_driver qxl_driver = {
>  #if defined(CONFIG_DEBUG_FS)
>         .debugfs_init = qxl_debugfs_init,
>  #endif
> -       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>         .gem_prime_export = drm_gem_prime_export,
>         .gem_prime_import = drm_gem_prime_import,
>         .gem_prime_pin = qxl_gem_prime_pin,
>         .gem_prime_unpin = qxl_gem_prime_unpin,
> -       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> -       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
>         .gem_prime_vmap = qxl_gem_prime_vmap,
>         .gem_prime_vunmap = qxl_gem_prime_vunmap,
>         .gem_prime_mmap = qxl_gem_prime_mmap,
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> index a55dece118..df65d3c1a7 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -38,20 +38,6 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
>         WARN_ONCE(1, "not implemented");
>  }
>
> -struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
> -{
> -       WARN_ONCE(1, "not implemented");
> -       return ERR_PTR(-ENOSYS);
> -}
> -
> -struct drm_gem_object *qxl_gem_prime_import_sg_table(
> -       struct drm_device *dev, struct dma_buf_attachment *attach,
> -       struct sg_table *table)
> -{
> -       WARN_ONCE(1, "not implemented");
> -       return ERR_PTR(-ENOSYS);
> -}
> -
>  void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
>  {
>         WARN_ONCE(1, "not implemented");
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
