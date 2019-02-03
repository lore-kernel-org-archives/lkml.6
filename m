Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6465B217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFfWeqvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfBCMMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:12:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36266 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfBCMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:12:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so9446825ljk.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 04:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10Q4A8cRCVZ62JEp8/wkwk+13xjXhUiGKYrwNjDciL8=;
        b=nFfWeqvCAFPf7SyAF02GxnT6T0aeeFZK6SDzSFPnAFHXCMXkqhXP7WaR//u0/QIFBo
         /krDPpuTpTU25c9htE+FY6UCucyRl3ngWDnoPEEmSNY+EMfNZi1gCS4HCK47bBIZPjLv
         H8IGi9gskuDoZz5cDX8mxEJeyeekYVEBnCIkRlyOrU67eqkuRY49O7Cc+JBbj+Bt9IDY
         v2MIw2+a2Bquf7hsXOZRor6Uzyaut/+b7elxyDnGP3FG6DeUPTmhuAq4eaXbeyiVR90j
         EHy1JWUSAH/6YHsTI0u4a9jeu/oM2RgBidKqsATvR2UgYsR+RR0Z9iQdSVoclpV3U0p1
         P0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10Q4A8cRCVZ62JEp8/wkwk+13xjXhUiGKYrwNjDciL8=;
        b=CsnV7I9fPYhnneXBurGswGAm7GtciTYsXzg61hWnp3vnZGjBkAEvAwd6IJmb3r94ar
         jFNb8Mhih0jgOKSYvJuNd1pvxfQo49AQOm/xWlV2rF/A+0NZfoIK6mrNft0qRpgn/9Ru
         PVwmvoB2XEZ/BnDEihU4xC6EkaROe/ubeJrBj0vmJIxOyjQxVekI1cGZ52HB96po8VY2
         0clIwHCakTzRpcDnO4AZFWFMf0Ba0uo/POY/y0QgELu4MVUsAxtzuw+2l8+X7j3HqHjt
         TFGar9+wwX55d6e0QT3wlWMw1nOsSpCKM4AebYPzulwrSPoAuprFYjezD3G3L9MwKUcT
         IFPQ==
X-Gm-Message-State: AJcUukdaX+ncn3WrPZK5+GwAk4XkMYNrdo7Zuf/pYjSoHGHnhSy3Sy0l
        KetebKNyatjM9oWxfZSWpgVXPg4xLgPIYHqQ10A=
X-Google-Smtp-Source: ALg8bN7afLT02AkCWiIGrjJWd2raxmzBBviphe+sD/WPR2mbwBp3XwWNgngc6PGN+CjVjnQIWU1Bpfwx9bsgBTYtJlE=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr36673565ljj.9.1549195937638;
 Sun, 03 Feb 2019 04:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131031222.GA2356@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190131031222.GA2356@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 3 Feb 2019 17:42:09 +0530
Message-ID: <CAFqt6zbw4wbjMYjRs_Sy6BegzqOSq_YK27rhjHw_dr_jR8neAw@mail.gmail.com>
Subject: Re: [PATCHv2 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, joro@8bytes.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Thu, Jan 31, 2019 at 8:38 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Can you please help to review this patch ?

> ---
>  drivers/iommu/dma-iommu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d19f3d6..bdf14b87 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -620,17 +620,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>
>  int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       int ret = -ENXIO;
> -
> -       for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -               ret = vm_insert_page(vma, uaddr, pages[i]);
> -               if (ret)
> -                       break;
> -               uaddr += PAGE_SIZE;
> -       }
> -       return ret;
> +       return vm_insert_range(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
>  }
>
>  static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> --
> 1.9.1
>
