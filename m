Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1B82082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYpcOL8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1B82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbeKXPsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 10:48:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40621 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbeKXPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 10:48:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so9912046lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 21:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMEYpdytmtRkHudMGsMT8oN29PsYA5sGcuNVsmhdHcI=;
        b=BYpcOL8seYpKjSHIS69W+N0l+ZvJUWn7a7ZtwcZ36h9smdJgIgdq3mG2/t0AQjjE2s
         /Hs/drhHf85x6/NW86UYLCQ3vTnIqZQVOw96AVyU5MW1/8jp3jdBVmt41HQAxBl3sZFo
         tlgXSF6uzYj/070q1PB5ZUfx6H9ZnHa7CHdoxgepQGa058QoBzHkidyw1KtI7P621re/
         QKw0gfs/2gpzBUH/dQ33Mz9oVyEjyB8E80VuOdENZk8JOJa3dwcQvCeQftrfFdpzJ2qy
         wzBS6Wv/pAODNoVTwFF5VN6FBFrfcuJ1ihGAvuMEBuAcKRvbQ7bWsVBCBR93Yks2nR6c
         /tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMEYpdytmtRkHudMGsMT8oN29PsYA5sGcuNVsmhdHcI=;
        b=dB7WF41L82lN44J2LHJVJAlHTHCz8iuKmlJo56DvtoSKhtCMXlu2KYouWq3vtR5LEz
         P9uheRkC5i3HdcQquJfBl24ZrUVU/HlmAUfLLATGz7y7BMToylu7iv/IGKOIhPKlmLFo
         hNj4kA2M4DIqq1iEWaznPYQa+wYT2/D/EiMw8dcdVFB0FkDpu5SqMv1QXsEk/Sc/l16p
         TAniPxgv+lTL2RuqhyvlGzrlzAfkvf4OGB/b86vlZLb3JNvHy5+hbJH5pjiwblA57nrK
         hO9MPLSoL+jU34WHm9U77wpGUCLf8UA55WKtwARliB2aZ9s5iqJIACGwNZ59Ot4kLhpJ
         ieSw==
X-Gm-Message-State: AGRZ1gLq9TJy2QVE6xYKCAGWYlS+jj8PZsyi/eO1ww9qmm3OkMHnMaiU
        rQVK29xvLEcFEKvUIQvaWu7DgHC/YAO6B3U2gMnfQCN5
X-Google-Smtp-Source: AJdET5c/zsNAxWijbrLIx/RexASo5N97gX8baZY+tfiqUob14rDXzKwheBaYtAM80keDrMfECEPJTJcZcHQfruV1Esk=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr11237096lfk.77.1543035693507;
 Fri, 23 Nov 2018 21:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
 <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com> <20181123213448.GW3065@bombadil.infradead.org>
In-Reply-To: <20181123213448.GW3065@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 24 Nov 2018 10:31:20 +0530
Message-ID: <CAFqt6zawenCGGhLoVzCrjzdHH4rV1RqpWGswDGjGE-VqJETFBA@mail.gmail.com>
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     Matthew Wilcox <willy@infradead.org>
Cc:     robin.murphy@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, joro@8bytes.org,
        Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 3:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 23, 2018 at 05:23:06PM +0000, Robin Murphy wrote:
> > On 15/11/2018 15:49, Souptick Joarder wrote:
> > > Convert to use vm_insert_range() to map range of kernel
> > > memory to user vma.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > > ---
> > >   drivers/iommu/dma-iommu.c | 12 ++----------
> > >   1 file changed, 2 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index d1b0475..69c66b1 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> > >   int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> > >   {
> > > -   unsigned long uaddr = vma->vm_start;
> > > -   unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > > -   int ret = -ENXIO;
> > > +   unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > > -   for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> > > -           ret = vm_insert_page(vma, uaddr, pages[i]);
> > > -           if (ret)
> > > -                   break;
> > > -           uaddr += PAGE_SIZE;
> > > -   }
> > > -   return ret;
> > > +   return vm_insert_range(vma, vma->vm_start, pages, count);
> >
> > AFIACS, vm_insert_range() doesn't respect vma->vm_pgoff, so doesn't this
> > break partial mmap()s of a large buffer? (which I believe can be a thing)
>
> Whoops.  That should have been:
>
> return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff, count);
>
> I suppose.

Matthew, patch "drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range"
also need to address the same issue ?

>
> Although arguably we should respect vm_pgoff inside vm_insert_region()
> and then callers automatically get support for vm_pgoff without having
> to think about it ... although we should then also pass in the length
> of the pages array to avoid pages being mapped in which aren't part of
> the allocated array.
>
> Hm.  More thought required.
