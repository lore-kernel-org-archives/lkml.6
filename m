Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A2C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B258B20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrkEZvke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfA1Gb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:31:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfA1Gbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:31:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so13225532ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xo1XRWo+UsOWJB0j8DeP+bJpW8d+zCzkO/oslyAm+ZY=;
        b=SrkEZvkewK8wCGCd4tU8le3LqMBD4FgqPce3jh4E0ohaqyKSaIfEK/T5MsQOsvOG0O
         VUtaLhraTkB6Od+YDPTqiH42Wp4M/w3QE51Rm7pYkn8HUzajXjGk9IOY8oGo7nUnqp1z
         ySB4RLtrTZByVloU5g9dGD/tLdVrksFbZKMYIkEII/XeruQrgsVAlXp/PXsxUC+TV+tA
         PyQGdNzEBr7b3vmqZu3B0hVsLpi9WoapymNWZXcdUIbMO18OmpqSs5kddu6kb+hRLJvD
         vz4Lui3WBETrIqEuQvkPe/deSUL4doBbTdWHuwAxyD4+tfL+NumMNwKyFzWTQDfenQaM
         mraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xo1XRWo+UsOWJB0j8DeP+bJpW8d+zCzkO/oslyAm+ZY=;
        b=Je3eWmM6eoKaZZAa4mstrMuNyQEr8dzq0fZeS6bIoWhxh8M5LeDb/yshDB3ntXhe2r
         CLDfrbRmc+ECN1Ro+SANlPlvqrMpAgi8nRQ59XvWDAGw0u3mAC6TcCqzQYLd/i+G3mnC
         qn2SNvx7YowkheW0LJqnbz7o+XfeGyIyMeg6DwKSF07U+ZC84PZqQdR8n4ZDI1BXU7c8
         ai15KWLV4rUY1TCWv1ln04Rhq2SfDC6CAvAblug0T9aC6Wur4jHzzWFe2E92kpTlqJf8
         kE7OYkeGMNjXzT5Fj4ygbvt2q6f8A48HnmsfwJU5/u/AdFujXBCjQwPEvcJ08X0ntP82
         0KOA==
X-Gm-Message-State: AJcUukduoDbMM1hHX3NjBRCrO6iXhsQrYQIgVchXxxhEzLjRW4VwCdw1
        lRI2PZ3ZuzXfvFCiYUxoy1UDJV4gtabBjSXIR1Y=
X-Google-Smtp-Source: ALg8bN7TnNqZso0t9ffTuek7639g3w1wEhMAxY4Zlyx88OaxeFSK82GVVYlDyXhzq513Dmj5SeO5IHfNEBVREoEcoCw=
X-Received: by 2002:a05:651c:14e:: with SMTP id c14mr16469993ljd.20.1548657113701;
 Sun, 27 Jan 2019 22:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20190111151110.GA2798@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111151110.GA2798@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 28 Jan 2019 12:01:42 +0530
Message-ID: <CAFqt6zYhudeTdj02Ex6jaLYoUQ-2YhmwTvJ6+nHRcAJN7NZ99w@mail.gmail.com>
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
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

On Fri, Jan 11, 2019 at 8:37 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?
> ---
>  drivers/iommu/dma-iommu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..802de67 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -622,17 +622,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
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
