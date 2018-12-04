Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBEB2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBEB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeLDRi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:38:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbeLDRi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:38:29 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 56275D7B87A5C;
        Wed,  5 Dec 2018 01:38:25 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 01:38:17 +0800
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
To:     Robin Murphy <robin.murphy@arm.com>, <hch@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
 <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
 <58fb3579-d101-db2b-c63a-609ddd651932@huawei.com>
 <eccb5b60-b831-c4bd-6c61-4867296e1232@arm.com>
CC:     <m.szyprowski@samsung.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <cai@gmx.us>,
        <salil.mehta@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bba358b1-8117-dfbf-df8b-675e8bdbb90e@huawei.com>
Date:   Tue, 4 Dec 2018 17:38:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <eccb5b60-b831-c4bd-6c61-4867296e1232@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>>> In fact, having got this far in, what I'd quite like to do is to get rid
>>> of dma_debug_resize_entries() such that we never need to free things at
>>> all, since then we could allocate whole pages as blocks of entries to
>>> save on masses of individual slab allocations.
>>>
>>
>> On a related topic, is it possible for the user to learn the total
>> entries created at a given point in time? If not, could we add a file
>> in the debugfs folder for this?
>

Hi Robin,

> I did get as far as pondering that you effectively lose track of
> utilisation once the low-water-mark of min_free_entries hits 0 and stays

I did try your patches and I noticed this, i.e I was hitting the point 
at which we start to alloc more entries.

> there - AFAICS it should be sufficient to just expose nr_total_entries
> as-is, since users can then calculate current and maximum occupancy
> based on *_free_entries. Does that sound reasonable to you?
>

Sounds ok. I am just interested to know roughly how many DMA buffers 
we're using in our system.

> That also indirectly reminds me that this lot is documented in
> DMA_API.txt, so I should be good and update that too...

Thanks,
John

>
> Cheers,
> Robin.
>
> .
>


