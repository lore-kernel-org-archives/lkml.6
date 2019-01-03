Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6451AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7522073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfACROz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:14:55 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52736 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731181AbfACROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:14:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THSwDTY_1546535572;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THSwDTY_1546535572)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jan 2019 01:12:54 +0800
Subject: Re: [v4 PATCH 2/2] mm: swap: add comment for swap_vma_readahead
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     tim.c.chen@intel.com, minchan@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1546145375-793-1-git-send-email-yang.shi@linux.alibaba.com>
 <1546145375-793-2-git-send-email-yang.shi@linux.alibaba.com>
 <875zv6w5m6.fsf@yhuang-dev.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ac47b98e-4418-7f61-bb90-4311f3b5dc2b@linux.alibaba.com>
Date:   Thu, 3 Jan 2019 09:12:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <875zv6w5m6.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/19 11:41 PM, Huang, Ying wrote:
> Yang Shi <yang.shi@linux.alibaba.com> writes:
>
>> swap_vma_readahead()'s comment is missed, just add it.
>>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Tim Chen <tim.c.chen@intel.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/swap_state.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 78d500e..dd8f698 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -698,6 +698,23 @@ static void swap_ra_info(struct vm_fault *vmf,
>>   	pte_unmap(orig_pte);
>>   }
>>   
>> +/**
>> + * swap_vm_readahead - swap in pages in hope we need them soon
> s/swap_vm_readahead/swap_vma_readahead/
>
>> + * @entry: swap entry of this memory
>> + * @gfp_mask: memory allocation flags
>> + * @vmf: fault information
>> + *
>> + * Returns the struct page for entry and addr, after queueing swapin.
>> + *
>> + * Primitive swap readahead code. We simply read in a few pages whoes
>> + * virtual addresses are around the fault address in the same vma.
>> + *
>> + * This has been extended to use the NUMA policies from the mm triggering
>> + * the readahead.
> What is this?  I know you copy it from swap_cluster_readahead(), but we
> have only one mm for vma readahead.

Aha, I see. Actually I was confused by this too, so just copied from 
swap_cluster_readahead.

>
>> + * Caller must hold down_read on the vma->vm_mm if vmf->vma is not NULL.
> Better to make it explicit that your are talking about mmap_sem?

Sure.

Thanks,
Yang

>
> Best Regards,
> Huang, Ying
>
>> + *
>> + */
>>   static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>>   				       struct vm_fault *vmf)
>>   {

