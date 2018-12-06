Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2516C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774A420892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774A420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLFSba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:31:30 -0500
Received: from foss.arm.com ([217.140.101.70]:58222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbeLFSb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:31:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D6E80D;
        Thu,  6 Dec 2018 10:31:29 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B6F3F5AF;
        Thu,  6 Dec 2018 10:31:28 -0800 (PST)
Subject: Re: [PATCH v2 4/8] dma-debug: Dynamically expand the dma_debug_entry
 pool
To:     Christoph Hellwig <hch@lst.de>
Cc:     cai@gmx.us, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <cover.1544037783.git.robin.murphy@arm.com>
 <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
 <20181206142423.GB24642@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <99a5f83b-8362-937e-9e50-116eedb7e593@arm.com>
Date:   Thu, 6 Dec 2018 18:31:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206142423.GB24642@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 14:24, Christoph Hellwig wrote:
>> @@ -47,6 +47,8 @@
>>   #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>>   #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>   #endif
> 
> FYI, I think we should drop the potential arch hook with the ifndef
> here once we support the dynamic adjustment.

Sure - I have a vague feeling that thought did cross my mind at the 
time, but it didn't stick.

> 
>> +		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES, GFP_ATOMIC)) {
> 
> Overly long line.

Bah, I deliberately didn't bother wrapping this since it gets shorter 
again later, but now I realise it also slipped through the s/create/add/ 
rebase so it's just busted, and due to another last-minute fix I 
actually ended up with an even longer line elsewhere.

I'll tidy all of that up for a v3.

Robin.
