Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B0920837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNrDdjIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B0920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLHT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:58:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44591 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeLHT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:58:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so6302178lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ETVN4Uk2IiTYy8m37PtiprjZf12dk6GDFSfbVtyXY4=;
        b=rNrDdjIGa/NiPNtdIAsdwuESvirJseUkTZ22pKns7gVXCV4CX30uCyKehOjFsQ9RqO
         gEJ/wYmor7cqPkEKZdOnaREO5YlA/MFbrHDX03bqSNiXthOmhbIppqJfZw2hcqnNIROp
         b84pze7IRAR6coBavag4sV04lODEUVYDCuV99PBbfePBQV4TjLZVstlSM/OTsWFi6vfi
         KFrq/dBHr2KCjBkScUWKuPl2fsySWO03flP+rA5NU7E8oUJF3JBHRcX3MG7/A7XeMEXr
         LKkP75Fie76qVz75iv/bHbww2P+HEnUvEUBv+dlCd0fjFBzoeX9dVa1OndsNNKBGa9UX
         t0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ETVN4Uk2IiTYy8m37PtiprjZf12dk6GDFSfbVtyXY4=;
        b=g8mYjRgMbojDsGn9ymsznLHL1RZ0W5B/g56L3O5akQTJGqOGg+V2PWTNmywUSxYhev
         EoOghX0Y0RpkWECAneos0v+IAUWi/c9dULuZQhZFyyjF6jKWFsWYfwud9Dh5NufB1T3M
         m31M3ZD9uYjbr/rLLa540RGk1lxQQDMCJGg98J+CVvpTXMJnahEnSLhLdgUvxY0QvlyB
         K0IxMosO7j7F8yxpJTYSB47Vs4md3gNKSyfrfJXZBwaF525zS6RORvUAYit5E5zlnXFe
         SU8xVbMegsbSqn3GvhiBPwc3gILRvUPRJz0UEjumQAm5ESFjlYkRmqdVXtGOBDGGci0C
         4LtA==
X-Gm-Message-State: AA+aEWa1cNSZbloJu1PYkFA+Qgt7io6MsR9rSsTyhJCO5sgWTphuPImI
        X5AuyAo6GPeRtYrAOOtev+qAgXO62r0GcVjTwwI=
X-Google-Smtp-Source: AFSGD/WAaZSNVAYyYF+Z/SPNez8lRgKFdzg3nLBroheTV+1L+ROxRcT1Hjmcm3YKx1TTvsmuYRoqeu8fCgBNRtYkvUU=
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr3430976ljk.99.1544299083671;
 Sat, 08 Dec 2018 11:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 9 Dec 2018 01:31:40 +0530
Message-ID: <CAFqt6zY9JjGhedtmhYh-+mxSMrYs6P5vtQDMSzCfL02CbLys=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
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

Hi Robin,

On Fri, Dec 7, 2018 at 12:07 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  arch/arm/mm/dma-mapping.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48..4eec323 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                     unsigned long attrs)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long usize = vma->vm_end - vma->vm_start;
> +       unsigned long page_count = vma_pages(vma);
>         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>         unsigned long off = vma->vm_pgoff;
> +       int err;
>
>         if (!pages)
>                 return -ENXIO;
>
> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> +       if (off >= nr_pages || page_count > nr_pages - off)
>                 return -ENXIO;
>
>         pages += off;
> +       err = vm_insert_range(vma, vma->vm_start, pages, page_count);

Just to clarify, do we need to adjust page_count with vma->vm_pgoff as
original code
have not consider it and run the loop for entire range irrespective of
vma->vm_pgoff value ?

> +       if (err)
> +               pr_err("Remapping memory failed: %d\n", err);
>
> -       do {
> -               int ret = vm_insert_page(vma, uaddr, *pages++);
> -               if (ret) {
> -                       pr_err("Remapping memory failed: %d\n", ret);
> -                       return ret;
> -               }
> -               uaddr += PAGE_SIZE;
> -               usize -= PAGE_SIZE;
> -       } while (usize > 0);
> -
> -       return 0;
> +       return err;
>  }
>  static int arm_iommu_mmap_attrs(struct device *dev,
>                 struct vm_area_struct *vma, void *cpu_addr,
> --
> 1.9.1
>
