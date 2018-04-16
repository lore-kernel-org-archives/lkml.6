Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbeDPMIV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39387 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755230AbeDPMIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:08:19 -0400
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
To: Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180413133519.GA213834@rodete-laptop-imager.corp.google.com>
 <20180413135923.GT17484@dhcp22.suse.cz>
 <13f1f5b5-f3f8-956c-145a-4641fb996048@suse.cz>
 <20180413142821.GW17484@dhcp22.suse.cz> <20180413143716.GA5378@cmpxchg.org>
 <20180416114144.GK17484@dhcp22.suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1475594b-c1ad-9625-7aeb-ad8ad385b793@suse.cz>
Date: Mon, 16 Apr 2018 14:06:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416114144.GK17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 01:41 PM, Michal Hocko wrote:
> On Fri 13-04-18 10:37:16, Johannes Weiner wrote:
>> On Fri, Apr 13, 2018 at 04:28:21PM +0200, Michal Hocko wrote:
>>> On Fri 13-04-18 16:20:00, Vlastimil Babka wrote:
>>>> We would need kmalloc-reclaimable-X variants. It could be worth it,
>>>> especially if we find more similar usages. I suspect they would be more
>>>> useful than the existing dma-kmalloc-X :)
>>>
>>> I am still not sure why __GFP_RECLAIMABLE cannot be made work as
>>> expected and account slab pages as SLAB_RECLAIMABLE
>>
>> Can you outline how this would work without separate caches?
> 
> I thought that the cache would only maintain two sets of slab pages
> depending on the allocation reuquests. I am pretty sure there will be
> other details to iron out and

For example the percpu (and other) array caches...

> maybe it will turn out that such a large
> portion of the chache would need to duplicate the state that a
> completely new cache would be more reasonable.

I'm afraid that's the case, yes.

> Is this worth exploring
> at least? I mean something like this should help with the fragmentation
> already AFAIU. Accounting would be just free on top.

Yep. It could be also CONFIG_urable so smaller systems don't need to
deal with the memory overhead of this.

So do we put it on LSF/MM agenda?
