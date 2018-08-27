Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAABC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C4A208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="gQ1648Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C4A208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeH0RWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:22:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34182 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeH0RWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:22:05 -0400
Received: by mail-it0-f65.google.com with SMTP id x79-v6so11693144ita.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fPS2nuY68PcImo6pAHOaRuo6qjcr4svJAWQc5AmU9vE=;
        b=gQ1648GjXpQqTi0BwE1W5d/ZOqIwwlMBN82JNuyigjWYpbc1cABZrtVbloIx3uFFxf
         7kSffn2tyP9UYEocAQDtyyXUlmTKUh9NFOtVE+VmI8krxou7OB8PAemja/IKBLsqiiSJ
         A++VKBHlm8vJxm8Lx1sok5qYQKqr7O79BbayryLP0Dh19uGyxHh0uYMd7KOXO+dzAu8D
         yRhCvs+BHf/JXHGYRnN0uKbxxXsFOROM3obFhrB5hUAFSd1U89M0sbXz/K8jkWnmWZdo
         rMfkvLdag+dIOuR+liFqt6ABistMaA2PDDilz+HptH7zvOK96V9G3IFV2iwKITdk0NGI
         4oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fPS2nuY68PcImo6pAHOaRuo6qjcr4svJAWQc5AmU9vE=;
        b=byXlZ3nNcTH8YSZdCSiUGOOvcQGMLSn3kp3emArt9hbimu5stG55L7WHTPC+krN5yp
         ravNfrXZbCyoOGS0g2qTFjYauppfzSwk6vgKCmhEL7bjUz5Y9r5RRzfcu65LE8qQVi1O
         x9jhwM7qAhjnaRjdMuX69Juh9qS2zZF8RWYWdCa4MSpC4TXR2T/qRlReMVnWS0BIdJQe
         FVrSK5/LZiAlpbGY6VEZuaL8eoPTynmy9A4Zel0UcaOuLzclUNZdMglZk0qz6DNkfKLb
         SNVlJG58n3A0uuRdX5sSi9se+d55aBPJ0KIn06Snya7d/y2Cn3H7oU4RZMtRzOvi1tKC
         ltZw==
X-Gm-Message-State: APzg51Axo/fbqvvtzT8WbRGeydLMjqsQVG8OnOsNQNpR8CuwgOHmnTCt
        OPo3hcB2QgO+MPYAZRKOECjxyXvLkt0nJw1Wc6ICyhtLsoI=
X-Google-Smtp-Source: ANB0VdaK7wa338kh2Ur4CzoDvVt6swGOxHBcg6iXEvjIe6MYL6+X6DJ49+q8j4yqvvuYiK+yn0d11cgEVCwP/IpVVj4=
X-Received: by 2002:a24:8189:: with SMTP id q131-v6mr6330759itd.154.1535376924752;
 Mon, 27 Aug 2018 06:35:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:1645:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 06:35:24
 -0700 (PDT)
In-Reply-To: <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
References: <20180822060704.GA12007@dragonet> <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 27 Aug 2018 15:35:24 +0200
Message-ID: <CAB0TPYGZHD2rH=Ce8GzB451rnukzV8vxNGJ4oJQKa347P8qORA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in binder_update_page_range
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Dae R. Jeong" <threeearcat@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Minchan!

On Thu, Aug 23, 2018 at 7:29 AM, Minchan Kim <minchan@kernel.org> wrote:
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Martijn Coenen <maco@android.com>

> ---
>  drivers/android/binder_alloc.c | 43 +++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 3f3b7b253445..64fd96eada31 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -332,6 +332,35 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>         return vma ? -ENOMEM : -ESRCH;
>  }
>
> +
> +static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
> +               struct vm_area_struct *vma)
> +{
> +       if (vma)
> +               alloc->vma_vm_mm = vma->vm_mm;
> +       /*
> +        * If we see alloc->vma is not NULL, buffer data structures set up
> +        * completely. Look at smp_rmb side binder_alloc_get_vma.
> +        * We also want to guarantee new alloc->vma_vm_mm is always visible
> +        * if alloc->vma is set.
> +        */
> +       smp_wmb();
> +       alloc->vma = vma;
> +}
> +
> +static inline struct vm_area_struct *binder_alloc_get_vma(
> +               struct binder_alloc *alloc)
> +{
> +       struct vm_area_struct *vma = NULL;
> +
> +       if (alloc->vma) {
> +               /* Look at description in binder_alloc_set_vma */
> +               smp_rmb();
> +               vma = alloc->vma;
> +       }
> +       return vma;
> +}
> +
>  static struct binder_buffer *binder_alloc_new_buf_locked(
>                                 struct binder_alloc *alloc,
>                                 size_t data_size,
> @@ -348,7 +377,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>         size_t size, data_offsets_size;
>         int ret;
>
> -       if (alloc->vma == NULL) {
> +       if (!binder_alloc_get_vma(alloc)) {
>                 binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
>                                    "%d: binder_alloc_buf, no vma\n",
>                                    alloc->pid);
> @@ -723,9 +752,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>         buffer->free = 1;
>         binder_insert_free_buffer(alloc, buffer);
>         alloc->free_async_space = alloc->buffer_size / 2;
> -       barrier();
> -       alloc->vma = vma;
> -       alloc->vma_vm_mm = vma->vm_mm;
> +       binder_alloc_set_vma(alloc, vma);
>         mmgrab(alloc->vma_vm_mm);
>
>         return 0;
> @@ -754,10 +781,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>         int buffers, page_count;
>         struct binder_buffer *buffer;
>
> -       BUG_ON(alloc->vma);
> -
>         buffers = 0;
>         mutex_lock(&alloc->mutex);
> +       BUG_ON(alloc->vma);
> +
>         while ((n = rb_first(&alloc->allocated_buffers))) {
>                 buffer = rb_entry(n, struct binder_buffer, rb_node);
>
> @@ -900,7 +927,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
>   */
>  void binder_alloc_vma_close(struct binder_alloc *alloc)
>  {
> -       WRITE_ONCE(alloc->vma, NULL);
> +       binder_alloc_set_vma(alloc, NULL);
>  }
>
>  /**
> @@ -935,7 +962,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>
>         index = page - alloc->pages;
>         page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
> -       vma = alloc->vma;
> +       vma = binder_alloc_get_vma(alloc);
>         if (vma) {
>                 if (!mmget_not_zero(alloc->vma_vm_mm))
>                         goto err_mmget;
> --
> 2.18.0.1017.ga543ac7ca45-goog
>
>
>
>
