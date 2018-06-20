Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B07C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDF20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f6AL82cl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l+yPlOYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FDF20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTEpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:45:44 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34046 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbeFTEpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:45:42 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so768266ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mpmq0mnmrI1oMXMAMgyJOTGgRg942O6drn90OhWIB7k=;
        b=f6AL82cl/ySWnpcuKJrzuikUgy8VQ5+SjGfaEKZWAAvsLRQ18kgy5PDxohYS7n0hqt
         nu7KvLbKLyE4BBCpE93s2zmLk4HIWKBNO4SCxcjDkTfmt0W0oRjzpsA2FNZ0qVku+H3/
         b5dpqp4yU3I+G4vTh75D6jiwAn4KhJp4g0kxd7ahKHuZPXUFiFWfKPE3s7A8YdAVspXg
         V0yWxOTfe0Z7TjG7SLFAGaBAK7UL8yGLySiIQgTDdpFOsysfEI77cg9ZJGiAWGhoKydy
         5hz/nBjBvmTevSCKrpaWg3HTKBscC4V0961k9t0gKsjZQWXH0QZJMM5fsIfFdM2//KJK
         Q7RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mpmq0mnmrI1oMXMAMgyJOTGgRg942O6drn90OhWIB7k=;
        b=l+yPlOYoOILeArD1e2j9cubU4p+7s5JxNzl+Aezz57AN4SzDB89yjVgE8odieFVwnm
         pJ+1Ii5d7NO4tPiDjL6PkGh6g52gH+ZSRlxX4kmY+0aJbX76HOUefgsUlrieYGqJJg5J
         /+AeCOARf8tlbhRsnJC9oG/1mgc817tduxHzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Mpmq0mnmrI1oMXMAMgyJOTGgRg942O6drn90OhWIB7k=;
        b=rmxbvkDjqoyu07UMGxDzpngXliLJ/A8saFry6NbVM6Xg1ZeC5EkSsb1up2jVCV09y2
         Iv0IHgsMSvfAMjnGSAO70A6wR/9wDtS88bbNV+lCRSgNNs5O+1LLISWHsygTVeT660N7
         MpWomlGEkTHVmVzm85Vw4ik5cJJb/HQ7RBaGtbLC1oipvnu/aBsEuw0QccKQYQ7RI87x
         9WawcMDUyCv/6V5Mr/pEJ8PGMZdJrYRkTKW3Xvq8G7QYdxnuodVg1/99cISqmwJgsLiA
         t1zJIHik3nLDnheNUYC4LHqMv583+oQ9EC2LM6JMsFNonCcC8599Gyhy6/alcRW5iqIM
         NVoA==
X-Gm-Message-State: APt69E2aOZ3BnvceCFNnLd2LaaTVvYpajPC/ybS6pcPy6WjBQajP+OtK
        5xobnDIkQeLqeTwac+2QaNjXqJPAcnhth1pr4VmqvQ==
X-Google-Smtp-Source: ADUXVKIMrb7rDPYBDJm4EH4LzlTRZZ9m76JyHz32YJhWmItHjV5cE1f35aUIQuHrEzY4dCpypquXQbmNy1tDAmSmCe4=
X-Received: by 2002:a25:ab10:: with SMTP id u16-v6mr10321520ybi.112.1529469941956;
 Tue, 19 Jun 2018 21:45:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 21:45:41
 -0700 (PDT)
In-Reply-To: <20180524172436.GA17738@beast>
References: <20180524172436.GA17738@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 19 Jun 2018 21:45:41 -0700
X-Google-Sender-Auth: 6kw-uw6ZGEm2m10kRle88PM7tvM
Message-ID: <CAGXu5jJPmeJTLiJrPqeQWhcRwFh3GgpL8RfWvHoK+Kvd=mybFg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/secboot/acr: Remove VLA usage
To:     Alexandre Courbot <acourbot@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:24 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the working buffers before starting the writing so it won't
> abort in the middle. This needs an initial walk of the lists to figure
> out how large the buffer should be.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping. Who is best to take this patch?

Thanks!

-Kees

> ---
>  .../nouveau/nvkm/subdev/secboot/acr_r352.c    | 25 ++++++++++++++++---
>  .../nouveau/nvkm/subdev/secboot/acr_r367.c    | 16 +++++++++++-
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> index a721354249ce..d02e183717dc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
> @@ -414,6 +414,20 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>  {
>         struct ls_ucode_img *_img;
>         u32 pos = 0;
> +       u32 max_desc_size = 0;
> +       u8 *gdesc;
> +
> +       /* Figure out how large we need gdesc to be. */
> +       list_for_each_entry(_img, imgs, node) {
> +               const struct acr_r352_ls_func *ls_func =
> +                                           acr->func->ls_func[_img->falcon_id];
> +
> +               max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
> +       }
> +
> +       gdesc = kmalloc(max_desc_size, GFP_KERNEL);
> +       if (!gdesc)
> +               return -ENOMEM;
>
>         nvkm_kmap(wpr_blob);
>
> @@ -421,7 +435,6 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>                 struct ls_ucode_img_r352 *img = ls_ucode_img_r352(_img);
>                 const struct acr_r352_ls_func *ls_func =
>                                             acr->func->ls_func[_img->falcon_id];
> -               u8 gdesc[ls_func->bl_desc_size];
>
>                 nvkm_gpuobj_memcpy_to(wpr_blob, pos, &img->wpr_header,
>                                       sizeof(img->wpr_header));
> @@ -447,6 +460,8 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>
>         nvkm_done(wpr_blob);
>
> +       kfree(gdesc);
> +
>         return 0;
>  }
>
> @@ -771,7 +786,11 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>         struct fw_bl_desc *hsbl_desc;
>         void *bl, *blob_data, *hsbl_code, *hsbl_data;
>         u32 code_size;
> -       u8 bl_desc[bl_desc_size];
> +       u8 *bl_desc;
> +
> +       bl_desc = kzalloc(bl_desc_size, GFP_KERNEL);
> +       if (!bl_desc)
> +               return -ENOMEM;
>
>         /* Find the bootloader descriptor for our blob and copy it */
>         if (blob == acr->load_blob) {
> @@ -802,7 +821,6 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>                               code_size, hsbl_desc->start_tag, 0, false);
>
>         /* Generate the BL header */
> -       memset(bl_desc, 0, bl_desc_size);
>         acr->func->generate_hs_bl_desc(load_hdr, bl_desc, offset);
>
>         /*
> @@ -811,6 +829,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>         nvkm_falcon_load_dmem(falcon, bl_desc, hsbl_desc->dmem_load_off,
>                               bl_desc_size, 0);
>
> +       kfree(bl_desc);
>         return hsbl_desc->start_tag << 8;
>  }
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
> index 866877b88797..978ad0790367 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
> @@ -265,6 +265,19 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>  {
>         struct ls_ucode_img *_img;
>         u32 pos = 0;
> +       u32 max_desc_size = 0;
> +       u8 *gdesc;
> +
> +       list_for_each_entry(_img, imgs, node) {
> +               const struct acr_r352_ls_func *ls_func =
> +                                           acr->func->ls_func[_img->falcon_id];
> +
> +               max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
> +       }
> +
> +       gdesc = kmalloc(max_desc_size, GFP_KERNEL);
> +       if (!gdesc)
> +               return -ENOMEM;
>
>         nvkm_kmap(wpr_blob);
>
> @@ -272,7 +285,6 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>                 struct ls_ucode_img_r367 *img = ls_ucode_img_r367(_img);
>                 const struct acr_r352_ls_func *ls_func =
>                                             acr->func->ls_func[_img->falcon_id];
> -               u8 gdesc[ls_func->bl_desc_size];
>
>                 nvkm_gpuobj_memcpy_to(wpr_blob, pos, &img->wpr_header,
>                                       sizeof(img->wpr_header));
> @@ -298,6 +310,8 @@ acr_r367_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>
>         nvkm_done(wpr_blob);
>
> +       kfree(gdesc);
> +
>         return 0;
>  }
>
> --
> 2.17.0
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
