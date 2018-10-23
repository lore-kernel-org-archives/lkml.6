Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705CC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643082075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b628VAjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643082075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJWMZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:25:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38211 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:25:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id k11-v6so7025784lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 21:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlfDScFrQxukYdJ0Wug8LGJXaEEKMrLGQcd4wayr7Fc=;
        b=b628VAjL6T5PD5veh/zV0gIV3TI//51hIzPrZjevit9v+CvJLyqP98xOfn/d5YXxFa
         dWCi1PEs0yq19nlgB27CZoTX2qsI4DKzRmB+zsSnyYqfDYafI9eMl+yMIo8kikxKs0uW
         l+fJkJ+scoV4MPw+SIMRyRVnHx7CV0OiSlNmFaR2C57MDln9S43x8paHklFVzvnmSNUl
         RYGe8bCkA1E9sypKL0s/eRL0BUYEijNcKwhya3C/c6P3RKKGhYtGIMjXnrzpU5XEmxqt
         fh13t3WTn1+n+bHL96cCXDfh+pugXTBrS4Eo5J90WFhHBn/inWM/hShza9e0ANBkwo4x
         sJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlfDScFrQxukYdJ0Wug8LGJXaEEKMrLGQcd4wayr7Fc=;
        b=I0GNR/QJmajj3ZpCob77lymO7+bAtJ+B/lMaDD1rBf20fuOvpOd/gn09MYeD223B29
         rL+8xtJbegJAuksD8gClakV2jdKkpbqCFntPBHkWTODS1MkhsaRXwJXMX3LlH0P2kvAA
         Mzlw6FcB6TT00H2rkrwKOwn+cLl1BnoMjp7cdJqjTOaE66yKPmQhhSldEPm7WR1tzOVc
         Ax9FprjrxGpnp/Q6xwuUtdPaPY4lJ0bqkfZ9RPuGRsazm8RAdqSBla8d7PZWTyhLWBuZ
         o2W8H2iiwn1pwkVDnukil74TZW/wz/RUgxINQ5Tjots5v/J7s44TLGIopI1iVSjpUpBK
         pTsw==
X-Gm-Message-State: ABuFfogoYmw5paPHVFncneC1OBQJuRKHhpZR5WAQDzRQSLzV0KpU0gpG
        xp7GfwPaLzk53WQ/l6cqEhv5b8ZInfWDvSpkCKs=
X-Google-Smtp-Source: ACcGV63c6NoPUP3qahPCKc009TkzeSOXafonGO7esYEE5eoCkiUU08bnEY7tHeqPpx9Rqjp9gHBLxN9CmlTChJeHGRo=
X-Received: by 2002:a2e:b04b:: with SMTP id d11-v6mr30485010ljl.93.1540267417602;
 Mon, 22 Oct 2018 21:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com>
In-Reply-To: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 23 Oct 2018 09:36:55 +0530
Message-ID: <CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/virtio/virtgpu_vq.c: Use kmem_cache_zalloc
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     airlied@linux.ie, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 9:30 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced kmem_cache_alloc + memset with kmem_cache_zalloc

Put a new line gap in between these two lines and send v2.

> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 020070d..e001b79 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -98,10 +98,9 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
>  {
>         struct virtio_gpu_vbuffer *vbuf;
>
> -       vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
> +       vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL);
>         if (!vbuf)
>                 return ERR_PTR(-ENOMEM);
> -       memset(vbuf, 0, VBUFFER_SIZE);
>
>         BUG_ON(size > MAX_INLINE_CMD_SIZE);
>         vbuf->buf = (void *)vbuf + sizeof(*vbuf);
> --
> 2.7.4
>
