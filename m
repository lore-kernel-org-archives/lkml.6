Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CE420855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZpWWLFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CE420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeKZRhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:37:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41873 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:37:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so12661370lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Dk+Y5KFpsCRxqkcabWN5tKZQdKxD4FthV8nVu/eV5w=;
        b=bZpWWLFZ/Z5f/06L2ElryChuLoN5t6ohSLtQFqJcpQR19GF6KZC8fKc4p80Fu/W4z9
         B9Atuvei/J9JQOCbU5LaJ+VRU1ZJ/BVL1HyjrXV2+/Zq9aViJVowv9IlKftu8kg8zGII
         PXUwGQ1keTOTTat0lFq5giLosVbD07W9SJVwCQ/ea/S8wEujWTKO/465J60wMIHnR8Km
         8ROuL8YGkotPZZRfO5cLMMdBufRPGB/PTYP1xJeGtQLnCzZHeuqhkZlSVEpZeIK0cA7i
         SzxJABSnP85yHZ9XJWq8kw5EVCY2QYuIM5dCXATLXEsMrOz/aVsN+SVSpnyuujOzIkEX
         zY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Dk+Y5KFpsCRxqkcabWN5tKZQdKxD4FthV8nVu/eV5w=;
        b=WpKSsQ7AEbDFA5on0cVNb3ot+Sup2qJ0Xja9OkRC+AGZu9wtUVW1zVa/ORgWlgwpLd
         T3y9vUS/H9vqOuA9/qjl+R/fJ2ToCgLb3T1hSqTq/7y0VPxVVByd7noUdbxdMCEk/0Gf
         g/XG/8/TM5s4kIF0760C5iVXWQIAx3m5zPZpG5i/LT0Ph947vz0h9/Fwr4AUIrN3bXe9
         r6k+74AMF8HhdsfSI3lUba+HGCWtzw66fFHr60fWWcMemPXn+Mv2heZKFa7YLtTX9Ui2
         7rNGlDzb4M/8QyQYoNEaU3pBnMsH6F+c5VN0JgtOEPqdRtYi2l8K2hglBMFK2WThXrRj
         iriw==
X-Gm-Message-State: AGRZ1gIaXOHi7KI2hB8tN78M8gGClgrcGd4icbqXMvp1qTaZrIkpITc0
        mQzw4rzGw+Z5Hx5aYAyiKHw03xjZlio+4sr8ZHukkjOu
X-Google-Smtp-Source: AJdET5cD9F2DuT58f3lTqmqMBQS120UbPEmjggX1ubl1fYsqga8TRt6rpCFrZNB1Bf/j7w0VgHsQrSoMmt5GF2Aza8g=
X-Received: by 2002:a19:2906:: with SMTP id p6mr14474539lfp.17.1543214676676;
 Sun, 25 Nov 2018 22:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
 <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com> <20181123213448.GW3065@bombadil.infradead.org>
In-Reply-To: <20181123213448.GW3065@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 26 Nov 2018 12:14:22 +0530
Message-ID: <CAFqt6zYmy5SdZY6_1BXFbY2pBQaNd+Z8R71wHEs6nKmxjht07A@mail.gmail.com>
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

I am unable to trace back where vma->vm_pgoff is set for this driver ? if any ?
If default value set to 0 then I think existing code is correct.

>
> I suppose.
>

> Although arguably we should respect vm_pgoff inside vm_insert_region()
> and then callers automatically get support for vm_pgoff without having
> to think about it ...

I assume, vm_insert_region() means vm_insert_range(). If we respect vm_pgoff
inside vm_insert_range, for any uninitialized/ error value set for vm_pgoff from
drivers will introduce a bug inside core mm which might be difficult
to trace back.
But when vm_pgoff set and passed from caller (drivers) it might be
easy to figure out.

> although we should then also pass in the length
> of the pages array to avoid pages being mapped in which aren't part of
> the allocated array.

Mostly Partial mapping is done by starting from an index and mapped it till
end of pages array. Calculating length of the pages array will have a small
overhead for each drivers.

Please correct me if I am wrong.
