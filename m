Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeEPJgB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:36:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49391 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbeEPJf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:35:58 -0400
Subject: Re: [PATCH] mm/page_alloc: use ac->high_zoneidx for classzone_idx
To: Joonsoo Kim <js1304@gmail.com>, Mel Gorman <mgorman@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1525408246-14768-1-git-send-email-iamjoonsoo.kim@lge.com>
 <8b06973c-ef82-17d2-a83d-454368de75e6@suse.cz>
 <20180504103322.2nbadmnehwdxxaso@suse.de>
 <CAAmzW4PKZFbAS6UEYKP2BBAqgk0=yTMuJRMTz--_0YTj-SjKvw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 A3XDrKOXTZil3g8D
Message-ID: <aa3452e1-db01-42ae-29eb-b23572e88969@suse.cz>
Date: Wed, 16 May 2018 11:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4PKZFbAS6UEYKP2BBAqgk0=yTMuJRMTz--_0YTj-SjKvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 03:00 AM, Joonsoo Kim wrote:
>> classzone predates my involvement with Linux but I would be less concerneed
>> about what the original intent was and instead ensure that classzone index
>> is consistent, sane and potentially renamed while preserving the intent of
>> "reserve pages in lower zones when an allocation request can use higher
>> zones". While historically the critical intent was to preserve Normal and
>> to a lesser extent DMA on 32-bit systems, there still should be some care
>> of DMA32 so we should not lose that.
> 
> Agreed!
> 
>> With the patch, the allocator looks like it would be fine as just
>> reservations change. I think it's unlikely that CMA usage will result
>> in lowmem starvation.  Compaction becomes a bit weird as classzone index
>> has no special meaning versis highmem and I think it'll be very easy to
>> forget.

I don't understand this point, what do you mean about highmem here? I've
checked and compaction seems to use classzone_idx 1) to pass it to
watermark checks as part of compaction suitability checks, i.e. the
usual lowmem protection, and 2) to limit compaction of higher zones in
kcompactd if the direct compactor can't use them anyway - seems this
part has currently the same zone imbalance problem as reclaim.

>> Similarly, vmscan can reclaim pages from remote nodes and zones
>> that are higher than the original request. That is not likely to be a
>> problem but it's a change in behaviour and easy to miss.
>>
>> Fundamentally, I find it extremely weird we now have two variables that are
>> essentially the same thing. They should be collapsed into one variable,
>> renamed and documented on what the index means for page allocator,
>> compaction, vmscan and the special casing around CMA.
> 
> Agreed!
> I will update this patch to reflect your comment. If someone have an idea
> on renaming this variable, please let me know.

Pehaps max_zone_idx? Seems a bit more clear than "high_zoneidx". And I
have no idea what was actually meant by "class".

> Thanks.
> 
