Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A01C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AF321E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdOiu/OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AF321E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbeHIUPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:15:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37225 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeHIUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:15:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id j205-v6so11312424oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VTMCT/kYNEDzZrEOGiVHoWNeqRR9eXXQB/ruTwB4j6E=;
        b=FdOiu/OJLS7HuLGr8O+UhnF3J+NDaHRLlEobKo6NgLoR68QAkLUede0MG659uHj9+6
         VoMwXPJyKsBfvPVTQ44wo6rNm+Jn4RvzBf4sxuHu+yvpsD+W2UKj/tkeFgEUREda9iES
         w6LJTVb2mkmPwZqOAjw6GIfbIZzrx8NRTEzJT76SELeuC+qhY+VhhPjt2xiGzP+iSjbH
         SRNtYiTJAB45tQX9z4yPFpnSj9eblKlPXbz5//SbTQ+tfmeNME7Kxvi5S4SOmUXcKz4u
         ry2zU8f3kjk05Sof4Wq8S6E7aYxZAV1Ymyv4X4hfTG0LRP4LL/URgXRdyqG1DBLFjFnq
         tGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VTMCT/kYNEDzZrEOGiVHoWNeqRR9eXXQB/ruTwB4j6E=;
        b=nN4splxrJIJCyEQ4o2QQJH4v3+864hOyJ2fUH1SGRXOdAU+2/j/a4zbTR5MmZ3SXD5
         cD6VEX5tIF3AZU9Vy4BIpRabcZM32YLQYOgDwz2XUqtjS9GrTNGaUdCG4SpBtfkp2r1u
         +ZFZF7bi4YMwHvbBx/tHqlse4e5UaBBuaXP24AKXoKypWg6/MxUNkLwjbRaH2ToP5fCI
         exAw5WQZ070EG4YpRaR0UvcN9vn6MUEAn6tZUrWoPk5fpyeqhdUH1EVtJ+1zCpoBDM1p
         nQ5rXpT19KyGUOaVO/asoErfUADc5ipEIibgnoJX0X4tuiTmwpp1z/0lTjkzb+JUWvV1
         Bo/A==
X-Gm-Message-State: AOUpUlFNxXsDgZfro6cfYo1NdTRl8GRW1vh5MzfiTqrmQ7Mp/2Z0KXw0
        Fj2IduALE9JXBYAPHI+xwvYtHrRzdq+6KD4rscw=
X-Google-Smtp-Source: AA+uWPyqXzZo/cIxQCcxks6wKmylVPoFG41YTLIvLb5n0dDY0jbrKxAhvkYdvH6pwcIghxdNaZzZGnVngG2OGC0VaQs=
X-Received: by 2002:aca:b355:: with SMTP id c82-v6mr3286824oif.9.1533836995132;
 Thu, 09 Aug 2018 10:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7702:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 10:49:54 -0700 (PDT)
In-Reply-To: <318f9118-df78-e78f-1ae2-72a33cbee28e@arm.com>
References: <20180807085437.15965-1-ganapatrao.kulkarni@cavium.com> <318f9118-df78-e78f-1ae2-72a33cbee28e@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 9 Aug 2018 23:19:54 +0530
Message-ID: <CAKTKpr6HfLtkeertCyfA_vJt2rXi5qFOKKXohLfX1Z9QiK=Uvw@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: Optimise attempts to allocate iova from 32bit
 address range
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, Aug 9, 2018 at 9:54 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 07/08/18 09:54, Ganapatrao Kulkarni wrote:
>>
>> As an optimisation for PCI devices, there is always first attempt
>> been made to allocate iova from SAC address range. This will lead
>> to unnecessary attempts/function calls, when there are no free ranges
>> available.
>>
>> This patch optimises by adding flag to track previous failed attempts
>> and avoids further attempts until replenish happens.
>
>
> Agh, what I overlooked is that this still suffers from the original problem,
> wherein a large allocation which fails due to fragmentation then blocks all
> subsequent smaller allocations, even if they may have succeeded.
>
> For a minimal change, though, what I think we could do is instead of just
> having a flag, track the size of the last 32-bit allocation which failed. If
> we're happy to assume that nobody's likely to mix aligned and unaligned
> allocations within the same domain, then that should be sufficiently robust
> whilst being no more complicated than this version, i.e. (modulo thinking up
> a better name for it):

I agree, it would be better to track size and attempt to allocate for
smaller chunks, if not for bigger one.

>
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>> This patch is based on comments from Robin Murphy <robin.murphy@arm.com>
>> for patch [1]
>>
>> [1] https://lkml.org/lkml/2018/4/19/780
>>
>>   drivers/iommu/iova.c | 11 ++++++++++-
>>   include/linux/iova.h |  1 +
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 83fe262..d97bb5a 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
>> long granule,
>>         iovad->granule = granule;
>>         iovad->start_pfn = start_pfn;
>>         iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
>> +       iovad->free_32bit_pfns = true;
>
>
>         iovad->max_32bit_free = iovad->dma_32bit_pfn;
>
>>         iovad->flush_cb = NULL;
>>         iovad->fq = NULL;
>>         iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain
>> *iovad, struct iova *free)
>>         cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>>         if (free->pfn_hi < iovad->dma_32bit_pfn &&
>> -           free->pfn_lo >= cached_iova->pfn_lo)
>> +           free->pfn_lo >= cached_iova->pfn_lo) {
>>                 iovad->cached32_node = rb_next(&free->node);
>> +               iovad->free_32bit_pfns = true;
>
>
>                 iovad->max_32bit_free = iovad->dma_32bit_pfn;

i think, you intended to say,
  iovad->max_32bit_free += (free->pfn_hi - free->pfn_lo);

>
>> +       }
>>         cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>>         if (free->pfn_lo >= cached_iova->pfn_lo)
>> @@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long
>> size,
>>         struct iova *new_iova;
>>         int ret;
>>   +     if (limit_pfn <= iovad->dma_32bit_pfn &&
>> +                       !iovad->free_32bit_pfns)
>
>
>                         size >= iovad->max_32bit_free)
>
>> +               return NULL;
>> +
>>         new_iova = alloc_iova_mem();
>>         if (!new_iova)
>>                 return NULL;
>> @@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long
>> size,
>>         if (ret) {
>>                 free_iova_mem(new_iova);
>> +               if (limit_pfn <= iovad->dma_32bit_pfn)
>> +                       iovad->free_32bit_pfns = false;
>
>
>                         iovad->max_32bit_free = size;

same here, we should decrease available free range after successful allocation.
iovad->max_32bit_free -= size;

>
> What do you think?

most likely this should work, i will try this and confirm at the earliest,

>
> Robin.
>
>
>>                 return NULL;
>>         }
>>   diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index 928442d..3810ba9 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -96,6 +96,7 @@ struct iova_domain {
>>                                                    flush-queues */
>>         atomic_t fq_timer_on;                   /* 1 when timer is active,
>> 0
>>                                                    when not */
>> +       bool    free_32bit_pfns;
>>   };
>>     static inline unsigned long iova_size(struct iova *iova)
>>
>

thanks,
Ganapat
