Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD1CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D41A2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef1pDDYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfAYGY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:24:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33833 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfAYGY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:24:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so6150595lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9H0PZn0OolgP7kJc7bV76uoKOIASZFoEKdhk7G9bBk=;
        b=ef1pDDYSKyrj1erjXfMRwQ4zhAIgmRtb1F9M5tlxxKSVhLW29fgSSAg0cvRjSAt4eq
         ISzDFaYnevqUWJ44Fqp1geuq6YHoKJEiTJFxHeE3UGJ/uRMuP61YgOChbdvFwfRx90z0
         J8mi/RFim70I55KL0tiFI0q657AfRlZfx/ERMWp7ZUlh6DsUY7sKpCN7nImUaWUFmoUB
         aM7mPzJd2AEujN1ivrlfZIwEjFW1vo2BOjqaV6IMV/1rX44n4z7w91vWS6NSaAzwEX54
         X4WDAk+bXaeuyS6aU58BfbGzRmA/d+cChU0BZQEXqGGuqX6Z1y/q8Zg+tlnvgOExryY1
         7yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9H0PZn0OolgP7kJc7bV76uoKOIASZFoEKdhk7G9bBk=;
        b=PhoM8d3RL1RxVJEG77EVRiGr5fhxWNztncG+PoPd28RQweErprm3s4Nz1vmqEaS28C
         f/9kgjPRHEXVeo3TF0r81TF/+wue5Em449ig5n5jEnOrlZMlDdzno6LK79jPdBm5lBzF
         ZPT1zpNBQVPenHZCVniUHEgE0O3dDqJmPeFo5VN+9dSyCJv2GXm80R82qMprUWEFiu0h
         7ya0HkmtVPVVNIv04AT6qA3OS8Xh5ViiJc3cI8k4mX9tzocMsbRZVZ9Tk/C2RgauZ/pH
         dQMmwYPnohz7XXqWaYovnR1irLYV/y6Ibbdro6G2EeCE333rmA3aRoQXLsIpHqoQUWPL
         BixQ==
X-Gm-Message-State: AJcUukezSUm3/kikkh+rdSlXYx0PrkGrDmtX1U3YTJTXl/EiVCj3sR9p
        kvZohe79ooctNhjNb37O9Lp2o9HemBUcElgPVRE=
X-Google-Smtp-Source: ALg8bN4/c2BufFVRM0EfReatatcnmTcHehlYAGb5rddAFsXXWUnAVKBofZHpJCmih2EhMvrwnV0BKWGHlw6p0Seg/Zw=
X-Received: by 2002:a19:7111:: with SMTP id m17mr7456686lfc.64.1548397465269;
 Thu, 24 Jan 2019 22:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 25 Jan 2019 11:54:13 +0530
Message-ID: <CAFqt6zZx9qxx_Xv=n-PY45OvS7E8ZBq+ZqaeEKfsaCirwaASSg@mail.gmail.com>
Subject: Re: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
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

On Fri, Jan 11, 2019 at 8:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  arch/arm/mm/dma-mapping.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 78de138..5334391 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1582,31 +1582,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
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
