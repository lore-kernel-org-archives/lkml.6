Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8B42081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8B42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeLDQJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:09:34 -0500
Received: from foss.arm.com ([217.140.101.70]:35962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeLDQJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:09:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FF09A78;
        Tue,  4 Dec 2018 08:09:33 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066FB3F614;
        Tue,  4 Dec 2018 08:09:31 -0800 (PST)
Subject: Re: [PATCH 2/4] dma-debug: Refactor dma_debug_entry allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
References: <cover.1543856576.git.robin.murphy@arm.com>
 <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
 <20181204142731.GB2767@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4efce7aa-2146-e759-1214-04bab917db2f@arm.com>
Date:   Tue, 4 Dec 2018 16:09:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204142731.GB2767@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 14:27, Christoph Hellwig wrote:
> On Mon, Dec 03, 2018 at 05:28:07PM +0000, Robin Murphy wrote:
>> Make prealloc_memory() a little more general and robust so that it
>> serves for runtime reallocations too. The first thing we can do with
>> that is clean up dma_debug_resize_entries() quite a bit.
> 
> Maybe also renamed it to dma_debug_alloc_entries or something like
> that?

Yes, that's definitely nicer.

> Otherwise this looks fine to me.

Thanks (and for the review on #1)

Robin.
