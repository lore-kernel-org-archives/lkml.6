Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663BFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AABB218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF27zpcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfABSyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:54:31 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37067 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfABSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:54:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so21619501lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0TThPyKzDm2TNNQAjf6clRHUIGAL0tpEQheWlPEAJg=;
        b=uF27zpcSxW4FK/pFshlTh+C0RI25exWJVydsIqaXcpteuwt9BR0V0JVVLsT0xWR6ZX
         g34IEDWcvEGjCactyz1Sv97ErjtVwfKP5NVOHe1wgRd8FqHH5lWvcM6o2GaN+zmc4Yuo
         VemKcc5QSvuWVU3fsD1pEpZOz4mNVt8odaCkVAHB3faHi6SVgWu8OuCw+W7GreXTi8Dr
         bHiEXiTUucccDC43vIi2SP73VElNrxqF0uiXFginYmDFutOucjJM4mw66cZK+TLeMASc
         WSbl6pgK8XKwkAGm95XvFRNAqStJAJUtfO5kkM6N2nqceOkyZunuveZIY6jZ2SjSdF4J
         zlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0TThPyKzDm2TNNQAjf6clRHUIGAL0tpEQheWlPEAJg=;
        b=BM4PbvAe/Q7IlUlTk1YxVRX4KMa9TxLTsupH/9jnRy8HsHfgjBfY+bEitwgz91LnoL
         VrFlDbyon9tjGh7TmGLk1fUQ4hF7kDnsPsVNIlvBh8PRSwGxQTxigIINnynIlKh8XxYF
         RcLEqoE0Ko15nR9YsjgUB5Uv7whvx2Ufv2a9YMhCbtt5G6++NXicTmi6ABAS3kj+8P4T
         BK8sv02g+KkBxBMI30dG29oO2WR74NCoCfLOkw63y+Ne8erEeFkoq3Qdjkpx1Nh/889u
         bEhPOeQ3k13pd4j5Z0Zcoty7FeLYoof46zdSzlW95Il6LJdT0YQIU5ElTlwNoOeVfYMf
         /PJg==
X-Gm-Message-State: AA+aEWbn2o0spbrZlyNdYsejmXQeJia7wLu1YHZAU0MIg8zbhwF3rrKu
        M846gO23JIoGILXxXNskVma2ybgMQp5Ovd2CR7fmtg==
X-Google-Smtp-Source: AFSGD/Wev/hvRV8NLc2yKT9L/LNczKxpRPqerhlYFArA1blFSqrdHd55CBN/ruQrSF+dO6aRrX0+SWiZLv9vYKAYDmo=
X-Received: by 2002:a19:c70a:: with SMTP id x10mr21717597lff.88.1546455268476;
 Wed, 02 Jan 2019 10:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20181224132751.GA22184@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181224132751.GA22184@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 3 Jan 2019 00:28:19 +0530
Message-ID: <CAFqt6za2_BOZaynNV2iVkLCjadzyR_bOJog=R6j43dDCDwgFzw@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] xen/gntdev.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 6:53 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  drivers/xen/gntdev.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index b0b02a5..430d4cb 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
>         int index = vma->vm_pgoff;
>         int count = vma_pages(vma);
>         struct gntdev_grant_map *map;
> -       int i, err = -EINVAL;
> +       int err = -EINVAL;
>
>         if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
>                 return -EINVAL;
> @@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
>                 goto out_put_map;
>
>         if (!use_ptemod) {
> -               for (i = 0; i < count; i++) {
> -                       err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
> -                               map->pages[i]);
> -                       if (err)
> -                               goto out_put_map;
> -               }

Looking into the original code, the loop should run from i =0 to *i <
map->count*.
There is no error check for *count > map->count* and we might end up
overrun the map->pages[i] boundary.

While converting this code with suggested vm_insert_range(), this can be fixed.


> +               err = vm_insert_range(vma, vma->vm_start, map->pages, count);
> +               if (err)
> +                       goto out_put_map;
>         } else {
>  #ifdef CONFIG_X86
>                 /*
> --
> 1.9.1
>
