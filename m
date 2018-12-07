Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FBC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9449C20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdKn8AcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9449C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGUiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:38:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38655 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:38:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so3959378lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soQMyuLItvBaN+WfY46FQ8iGd6LcF+x7DNBq1UZcPCE=;
        b=NdKn8AcNqJZLNDvDm1YknseZweKL3f2IOHLxOzk+/PygPEAr3Z+t0lqZ8VEYK+f0Kw
         bHtxh9gXvNfiT4cQWaR/ogA3rnji257kG+C2rRZcLqWzCh7y33i8ZCFrFPeClzoXBSZ/
         AIXB1Dd+ZAhGPVmE8d8X1qklY+BdO+hYJaNK4dO21uwWJ4Osoot+DCVcziIJ9byoc/va
         i6Yj+eC5tCU/YkdXbj9/NYeftU82uyPSE9l5SCHqLJbw6atuYfMl/MZJ2ZBjUI0jtBTe
         TXSuZQwv4Nr5+2axPFrb2Pjf2CH8T6stIyy9JOq1ahoRVpagMgfHW2iO4t0pGbsABRMj
         rSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soQMyuLItvBaN+WfY46FQ8iGd6LcF+x7DNBq1UZcPCE=;
        b=bePKWx31yzp04vyQBXd7I9a0ES+eqMAhJM1FQo0yaYsCQXOer1g61OhdNHiVUF6pWX
         2j8Qmqa5ZqSfhxTlxulzfzRIxig2WqDz2xPqZBgPJ3KPG8aMwPKonMkt4uhvaIxGHmDi
         q1cFJ/u+gc9ZKBuxxvX6qRZMkPDQz9Pc6So/upf7z822vO9Ey4MOHi/iKYrF82pLAdD+
         C7OKXmNqwpYHhJuEI6NYZJ2vrwwr2RsiFt5A2DQspu/ftDl6lRFw1rztvT/cfkPJqjac
         GJ9PEdcOCgYchngxeJATTVrRMW4VIPO6qzZfnvJ+U8KaYUvfZL14/B0zZZxO+pnezk2S
         LvQw==
X-Gm-Message-State: AA+aEWbqR8lwNGv9FSRNGaACd/I30EymmIby/X/bHWNF7jQzMtLMaueE
        nbxUPcYoZBg3FtBuS4fbj+AoI3jtc0pW3+Icbo0=
X-Google-Smtp-Source: AFSGD/WE1tbUw4v5k4ozbyB7fiQOpJuFpuxZZwZVX3bJk0cD9pJt+y6aIMzEbmGfjsxYu4UTNEXb2BmCkQxm+gR/b3M=
X-Received: by 2002:a19:6514:: with SMTP id z20mr2126605lfb.31.1544215092820;
 Fri, 07 Dec 2018 12:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20181206184343.GA30569@jordon-HP-15-Notebook-PC> <d02ad9d7-d0f6-c891-bb7e-fdf6661f651c@arm.com>
In-Reply-To: <d02ad9d7-d0f6-c891-bb7e-fdf6661f651c@arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Dec 2018 02:11:49 +0530
Message-ID: <CAFqt6zYF5fFQuGFGss3D1q=jKJGPOD33XLmZiAkBFT9zx_55LA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     robin.murphy@arm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, joro@8bytes.org,
        Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 7:17 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/12/2018 18:43, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 13 +++----------
> >   1 file changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index d1b0475..a2c65e2 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >
> >   int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> >   {
> > -     unsigned long uaddr = vma->vm_start;
> > -     unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -     int ret = -ENXIO;
> > +     unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >
> > -     for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> > -             ret = vm_insert_page(vma, uaddr, pages[i]);
> > -             if (ret)
> > -                     break;
> > -             uaddr += PAGE_SIZE;
> > -     }
> > -     return ret;
> > +     return vm_insert_range(vma, vma->vm_start,
> > +                             pages + vma->vm_pgoff, count);
>
> You also need to adjust count to compensate for the pages skipped by
> vm_pgoff, otherwise you've got an out-of-bounds dereference triggered
> from userspace, which is pretty high up the "not good" scale (not to
> mention the entire call would then propagate -EFAULT back from
> vm_insert_page() and thus always appear to fail for nonzero offsets).

So this should something similar to ->

        return vm_insert_range(vma, vma->vm_start,
                                pages + vma->vm_pgoff, count - vma->vm_pgoff);
