Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6CDC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA44217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEFZB7m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfBCMQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:16:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38726 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfBCMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:16:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id j15so1454576lfh.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsr2lcuUZ78duCduOrjEIhzTac5FkzmhdngvDyze87g=;
        b=DEFZB7m2x3lEjsSr4Vebj+gVVt7RLH0LzvwCLxLo87w5byYcx/eb6nkp/k5rPLuF39
         mmpb1Mq5bkecyhhJJlhVeKWccLyDB6pbFTcG0XIJojHQ1bHDN6mtm+KoI8VXXSqh4yl8
         ipfUr4T2tWkt0zjGXzc9GQDjaIzV49m5XBPq5fafnpOPUlJkiK438F1eBMpOp9WOD031
         rS4TLTf9kl1YBlwKdOL4uPVoF0bqQVtg2TbM4tLaPL2XM6xJkhQmwMfCYyZNuUDWKGnu
         yXDuK0R70C2y4wvmF0CXFDycc+8qwbZhCbA6fzZGslHQA2fZUVEj6ZEW4WTc5BAZ/kpz
         u8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsr2lcuUZ78duCduOrjEIhzTac5FkzmhdngvDyze87g=;
        b=HaI4ueDvMJCShQO86N6iHYjjcTiutpEv0rF9cEAg6AzO7IulHjj0iLUwYncL3/qUr/
         8HGZHICD24UF1c71mVFjC1rIaxnVr+MXhWEzfENz6Oh8peZIOB466Xkwrurd4ef6y5tP
         9+GLrdS/MYFklo+bxYBcbxq3PcikarOC61RNPGr4+A+gpFTvj6C1R8xbtvwgsI5UaPhz
         8iXPQ9Uu7oA1dDIGKqfWKa74c+mDNN7Mx0IgBagNUnsqaBL9a+XlUDr6q1/ntMnyx/VY
         JHRTIcsNBn4a+XNp7Ks+7mvyCoSzoC0zHpVgDk+gjtTJn9V0600E2MbiezGZ0fiWLRKR
         AeNA==
X-Gm-Message-State: AHQUAuY3pSt+JH2ytzVxiLc6dflDidFOiroz7oyGWfqqkUtJtilwll62
        QXTlmJvg+PWfdmH+yxsRpEYYvSezuTWgaS1Wd1E=
X-Google-Smtp-Source: AHgI3IaQ2Z3KDC+FnOhj++jsrTaCbQdTU8++guI2WhAsqUj3GwbfmgS1POV51VcyVAyZUuz4VlciqPBClODpIE97UkE=
X-Received: by 2002:a19:5004:: with SMTP id e4mr3804044lfb.75.1549196171078;
 Sun, 03 Feb 2019 04:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131030900.GA2284@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190131030900.GA2284@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 3 Feb 2019 17:46:02 +0530
Message-ID: <CAFqt6zZCmUTf1Pj+i0eYeQJ1x8A5u+26cM0v00TRpiNYDHky8Q@mail.gmail.com>
Subject: Re: [PATCHv2 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, Jan 31, 2019 at 8:34 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Does it looks good ?

> ---
>  arch/arm/mm/dma-mapping.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922..915f701 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1575,31 +1575,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                     unsigned long attrs)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long usize = vma->vm_end - vma->vm_start;
>         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       unsigned long off = vma->vm_pgoff;
> +       int err;
>
>         if (!pages)
>                 return -ENXIO;
>
> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> +       if (vma->vm_pgoff >= nr_pages)
>                 return -ENXIO;
>
> -       pages += off;
> -
> -       do {
> -               int ret = vm_insert_page(vma, uaddr, *pages++);
> -               if (ret) {
> -                       pr_err("Remapping memory failed: %d\n", ret);
> -                       return ret;
> -               }
> -               uaddr += PAGE_SIZE;
> -               usize -= PAGE_SIZE;
> -       } while (usize > 0);
> +       err = vm_insert_range(vma, pages, nr_pages);
> +       if (err)
> +               pr_err("Remapping memory failed: %d\n", err);
>
> -       return 0;
> +       return err;
>  }
>  static int arm_iommu_mmap_attrs(struct device *dev,
>                 struct vm_area_struct *vma, void *cpu_addr,
> --
> 1.9.1
>
