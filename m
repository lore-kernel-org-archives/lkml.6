Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F4AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED2D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlDXtypS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED2D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeKTUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:38:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43531 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKTUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:38:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so1135663otr.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuTXG+7hWhellvogEp5h0I0J+YO+uaVkNlq69jSlRMg=;
        b=PlDXtypSJe+IKYah9c9AeKrHH3umMaj4aT8vtt6vJIEt9KxFnor4JKwAVGheEAw1h1
         HHfL0UpA51DMJo77/A27KKui1ven3LXFE5b/4R5/2jYBZIChgcOBsvljctlxuA9Kv+qk
         9p8HEkOXXocep7ylFH8PL3WWBEninjubJqFspI2SSLJVOzXeR/k1J2mwNZ1AYoc11WPT
         poTNNF/gElrwoWcZ+CWFGeFGkqouhvZhnEkoYrBGsWp5Kd1C1zT1ubvFKYxZbgg6ffia
         /+GOr/7ZN2RAoBjp7DT0RHn+sG0v1JprukZi4gZLtAbi3BKCHQYCBmp3pkmGtlenlGHL
         wMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuTXG+7hWhellvogEp5h0I0J+YO+uaVkNlq69jSlRMg=;
        b=IlRSxZ4tlGJKDp8PDei6fH9h8HPn18S+MW/Y8Vrk/DcNuAmnEaF1Gb4vBnjvMjf7dU
         wP7JBNHyD7E5EGblrQDHyULq7B3hnreg4U9kzHzOBQDiUH4ImAw/aiVn8UNIIWLjQ3Si
         SM8gJ6KjTiD6eLY1+l+xqfi3CeUTq7Tls9LzUhpCLYIXWb4Z6FR0F1yT/ag2gHQQrZuM
         Y0oiw9qQgrnIZUzr3jgAKHuffKZSVc4EA0YBwsLFUdJVNmOpsgTDpgLrEpr/UetK+9lY
         hduIv5Y39W2jHCIrC+jPLzGjzmYXqoZHrK1acsxTVuf0D2b1SyCGeF7p+JRiVSMduak8
         hayw==
X-Gm-Message-State: AA+aEWYwfBQHMeRzpS98wXf+QoXpenCA4MEi5HsfPDyvghMjvApJdLMC
        Jbha9IiI7UBQ+6Dd+JlDqdF9H/1Edc9qsWKdTsDpzQ==
X-Google-Smtp-Source: AFSGD/UeVT7G2DZP1MM4kH01nsh7ljAUbTq0Iq4sNZMJsM4RkGfI2kDrX5ffTwhL+ew7zQK93uOZD8ZEsQ2Vd9xxOUU=
X-Received: by 2002:a9d:2841:: with SMTP id h1mr737637otd.215.1542708581925;
 Tue, 20 Nov 2018 02:09:41 -0800 (PST)
MIME-Version: 1.0
References: <1541699709-25474-1-git-send-email-john.garry@huawei.com> <1e2b8689-dc1f-3ede-4eeb-4a91d3a3f63f@huawei.com>
In-Reply-To: <1e2b8689-dc1f-3ede-4eeb-4a91d3a3f63f@huawei.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 20 Nov 2018 15:39:30 +0530
Message-ID: <CAKTKpr4S_v+Fm9K0F8xZTuwKSArZapXr-4Xo1YoNn8=X70H83g@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Use NUMA aware memory allocations in __iommu_dma_alloc_pages()
To:     John Garry <john.garry@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Tue, Nov 20, 2018 at 3:35 PM John Garry <john.garry@huawei.com> wrote:
>
> On 08/11/2018 17:55, John Garry wrote:
> > Change function __iommu_dma_alloc_pages() to allocate memory/pages
> > for DMA from respective device NUMA node.
> >
>
> Ping.... a friendly reminder on this patch.
>
> Thanks
>
> > Originally-from: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > ---
> >
> > This patch was originally posted by Ganapatrao in [1] *.
> >
> > However, after initial review, it was never reposted (due to lack of
> > cycles, I think). In addition, the functionality in its sibling patches
> > were merged through patches, as mentioned in [2]; this also refers to a
> > discussion on device local allocations vs CPU local allocations for DMA
> > pool, and which is better [3].
> >
> > However, as mentioned in [3], dma_alloc_coherent() uses the locality
> > information from the device - as in direct DMA - so this patch is just
> > applying this same policy.
> >
> > [1] https://lore.kernel.org/patchwork/patch/833004/
> > [2] https://lkml.org/lkml/2018/8/22/391
> > [3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html
> >
> > * Authorship on this updated patch may need to be fixed - I add not want to
> >   add Ganapatrao's SOB without permission.

thanks for taking this up. please feel free to add my SoB.
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index d1b0475..ada00bc 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
> >       kvfree(pages);
> >  }
> >
> > -static struct page **__iommu_dma_alloc_pages(unsigned int count,
> > -             unsigned long order_mask, gfp_t gfp)
> > +static struct page **__iommu_dma_alloc_pages(struct device *dev,
> > +             unsigned int count, unsigned long order_mask, gfp_t gfp)
> >  {
> >       struct page **pages;
> > -     unsigned int i = 0, array_size = count * sizeof(*pages);
> > +     unsigned int i = 0, nid = dev_to_node(dev);
> >
> >       order_mask &= (2U << MAX_ORDER) - 1;
> >       if (!order_mask)
> >               return NULL;
> >
> > -     if (array_size <= PAGE_SIZE)
> > -             pages = kzalloc(array_size, GFP_KERNEL);
> > -     else
> > -             pages = vzalloc(array_size);
> > +     pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);
> >       if (!pages)
> >               return NULL;
> >
> > @@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
> >                       unsigned int order = __fls(order_mask);
> >
> >                       order_size = 1U << order;
> > -                     page = alloc_pages((order_mask - order_size) ?
> > -                                        gfp | __GFP_NORETRY : gfp, order);
> > +                     page = alloc_pages_node(nid,
> > +                                             (order_mask - order_size) ?
> > +                                             gfp | __GFP_NORETRY : gfp,
> > +                                             order);
> >                       if (!page)
> >                               continue;
> >                       if (!order)
> > @@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >               alloc_sizes = min_size;
> >
> >       count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -     pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> > +     pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
> > +                                     gfp);
> >       if (!pages)
> >               return NULL;
> >
> >
>
>

thanks
Ganapat
