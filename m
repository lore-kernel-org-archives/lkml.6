Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3451D20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3451D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKTUsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:48:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15121 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeKTUsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:48:03 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CD12DE74D375D;
        Tue, 20 Nov 2018 18:19:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 18:19:28 +0800
Subject: Re: [PATCH] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
References: <1541699709-25474-1-git-send-email-john.garry@huawei.com>
 <1e2b8689-dc1f-3ede-4eeb-4a91d3a3f63f@huawei.com>
 <CAKTKpr4S_v+Fm9K0F8xZTuwKSArZapXr-4Xo1YoNn8=X70H83g@mail.gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        "Ganapatrao Kulkarni" <ganapatrao.kulkarni@cavium.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <be6141f0-ae12-378c-9628-dee306f803cf@huawei.com>
Date:   Tue, 20 Nov 2018 10:19:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAKTKpr4S_v+Fm9K0F8xZTuwKSArZapXr-4Xo1YoNn8=X70H83g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 10:09, Ganapatrao Kulkarni wrote:
> Hi John,
>
> On Tue, Nov 20, 2018 at 3:35 PM John Garry <john.garry@huawei.com> wrote:
>>
>> On 08/11/2018 17:55, John Garry wrote:
>>> Change function __iommu_dma_alloc_pages() to allocate memory/pages
>>> for DMA from respective device NUMA node.
>>>
>>
>> Ping.... a friendly reminder on this patch.
>>
>> Thanks
>>
>>> Originally-from: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>
>>> This patch was originally posted by Ganapatrao in [1] *.
>>>
>>> However, after initial review, it was never reposted (due to lack of
>>> cycles, I think). In addition, the functionality in its sibling patches
>>> were merged through patches, as mentioned in [2]; this also refers to a
>>> discussion on device local allocations vs CPU local allocations for DMA
>>> pool, and which is better [3].
>>>
>>> However, as mentioned in [3], dma_alloc_coherent() uses the locality
>>> information from the device - as in direct DMA - so this patch is just
>>> applying this same policy.
>>>
>>> [1] https://lore.kernel.org/patchwork/patch/833004/
>>> [2] https://lkml.org/lkml/2018/8/22/391
>>> [3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html
>>>
>>> * Authorship on this updated patch may need to be fixed - I add not want to
>>>   add Ganapatrao's SOB without permission.
>
> thanks for taking this up. please feel free to add my SoB.

OK, I will also make you the author and repost.

Thanks,
John

>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index d1b0475..ada00bc 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>>>       kvfree(pages);
>>>  }
>>>
>>> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>> -             unsigned long order_mask, gfp_t gfp)
>>> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
>>> +             unsigned int count, unsigned long order_mask, gfp_t gfp)
>>>  {
>>>       struct page **pages;
>>> -     unsigned int i = 0, array_size = count * sizeof(*pages);
>>> +     unsigned int i = 0, nid = dev_to_node(dev);
>>>
>>>       order_mask &= (2U << MAX_ORDER) - 1;
>>>       if (!order_mask)
>>>               return NULL;
>>>
>>> -     if (array_size <= PAGE_SIZE)
>>> -             pages = kzalloc(array_size, GFP_KERNEL);
>>> -     else
>>> -             pages = vzalloc(array_size);
>>> +     pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);
>>>       if (!pages)
>>>               return NULL;
>>>
>>> @@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>>                       unsigned int order = __fls(order_mask);
>>>
>>>                       order_size = 1U << order;
>>> -                     page = alloc_pages((order_mask - order_size) ?
>>> -                                        gfp | __GFP_NORETRY : gfp, order);
>>> +                     page = alloc_pages_node(nid,
>>> +                                             (order_mask - order_size) ?
>>> +                                             gfp | __GFP_NORETRY : gfp,
>>> +                                             order);
>>>                       if (!page)
>>>                               continue;
>>>                       if (!order)
>>> @@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>               alloc_sizes = min_size;
>>>
>>>       count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>> -     pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
>>> +     pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
>>> +                                     gfp);
>>>       if (!pages)
>>>               return NULL;
>>>
>>>
>>
>>
>
> thanks
> Ganapat
>
> .
>


