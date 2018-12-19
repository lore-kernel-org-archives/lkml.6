Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07058C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C493621852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC8NhEyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeLSHiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:38:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38087 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLSHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:38:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so16517423lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nKteQZDBd3gzsGTCfuuQEnMUp8pCvaLKltXicBLdXA=;
        b=HC8NhEyVB9kD7O1pj7c8mms2uKXEFa/ffxgZBYPd9cUf3bEjF489LvrLpLq3EQjYBt
         ojRvwQ13mAsKn3bQbzR9JB98e9qWwWpDruXu2z1lciZfORoE+p6VgztPKXow10fU41yO
         rnOB0O/YXVHzaJbvIGGL7Pu6xzQuZyZWJDF9MPui0x8V/fUbFrKesHg1ay1QUGWhW/3J
         yAo3dIkuhT999I0D1Fih9ghdvciA19vVA27YfYXCSxEu2101CTn/fiLvuXaBAf/bR7Yo
         Ba0CXkpPbsESVI+ZL6GBROYfDRFct8EpQfkA45yihd9CjYAR5Dcm77EAjz3siuCyLomj
         rLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nKteQZDBd3gzsGTCfuuQEnMUp8pCvaLKltXicBLdXA=;
        b=Kv9A7ozO9TCL5fopoZnLirKwUdWGnLH/XXI7D7jbukKsDaR5g+O/QN84MTfpJoyc9U
         WiLxMFQCcGbs9/hfhKnPOlrrVHE0zpGphUGlJZwkJNaaCPK1dmwLtkOnGOjPhLkDaC6q
         6rkFXsfAivWB7xpRh/JIeyP3FxSAfEGZ4QWU7wR5IK8OE6BYqlgz/sSX9ayuycJf05dd
         S0dC6i4gBV3Rhhbb556yQQU06gerLfo2asuV7Mbi0sv3F0vV6Amg0vs+s0z0rhtHr8FJ
         SQe5d0USrEpJ3GWFVL3wOCFOTjD4mp7A2GIX6hMxTdkqfSdP3ryRt1blCVbCa1z8hk8r
         7GqA==
X-Gm-Message-State: AA+aEWZZX5ioXOdDkd1D76Z39yAryiaALLktl5LnLEA/fzx2N9WgCSW9
        SEIcUZiRu+eFu364mU70sokrBcfO5+anTfop3GigMg==
X-Google-Smtp-Source: AFSGD/U+gtrtfWcpvU2l4tks0uj9AZLIsDch5JID04B3M24MB2ELf2CKCGIZq2itPT1kAoEAWD1wKY1YtFelEcFa/P8=
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr11369694ljb.11.1545205092130;
 Tue, 18 Dec 2018 23:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20181217202448.GA14918@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181217202448.GA14918@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 19 Dec 2018 13:08:00 +0530
Message-ID: <CAFqt6zZ9JxE_GZ97On54YzdUtgbShL3q0JjK4j2CEMVpAJbejA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 1:50 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>

Cc'd: Robin Murphy
> ---
>  drivers/iommu/dma-iommu.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..de7ffd8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>
>  int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       int ret = -ENXIO;
> +       unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>
> -       for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -               ret = vm_insert_page(vma, uaddr, pages[i]);
> -               if (ret)
> -                       break;
> -               uaddr += PAGE_SIZE;
> -       }
> -       return ret;
> +       return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff,
> +                               count - vma->vm_pgoff);
>  }
>
>  static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> --
> 1.9.1
>
