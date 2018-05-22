Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEVHIJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:08:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbeEVHIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:08:01 -0400
Subject: Re: [PATCH v2 2/4] mm: check for proper migrate type during isolation
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        David Nellans <dnellans@nvidia.com>, Laura Abbott <labbott@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20180503232935.22539-1-mike.kravetz@oracle.com>
 <20180503232935.22539-3-mike.kravetz@oracle.com>
 <0a74f688-74fb-b841-4782-f9c96b1b9cfc@suse.cz>
 <f50d6814-8bc6-80cd-c0e5-b2cfa4f9e576@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 A3XDrKOXTZil3g8D
Message-ID: <a9816b88-015e-7e44-cbb8-a7ff04453870@suse.cz>
Date: Tue, 22 May 2018 09:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f50d6814-8bc6-80cd-c0e5-b2cfa4f9e576@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 01:10 AM, Mike Kravetz wrote:
> On 05/18/2018 03:32 AM, Vlastimil Babka wrote:
>> On 05/04/2018 01:29 AM, Mike Kravetz wrote:
>>> The routine start_isolate_page_range and alloc_contig_range have
>>> comments saying that migratetype must be either MIGRATE_MOVABLE or
>>> MIGRATE_CMA.  However, this is not enforced.
>>
>> Enforced, no. But if the pageblocks really were as such, it used to
>> shortcut has_unmovable_pages(). This was wrong and removed in
>> d7b236e10ced ("mm: drop migrate type checks from has_unmovable_pages")
>> plus 4da2ce250f98 ("mm: distinguish CMA and MOVABLE isolation in
>> has_unmovable_pages()").
>>
>>
>>   What is important is
>>> that that all pageblocks in the range are of type migratetype.
>>                                                the same
>>> This is because blocks will be set to migratetype on error.
>>
>> Strictly speaking this is true only for the CMA case. For other cases,
>> the best thing actually would be to employ the same heuristics as page
>> allocation migratetype fallbacks, and count how many pages are free and
>> how many appear to be movable, see how steal_suitable_fallback() uses
>> the last parameter of move_freepages_block().
>>
>>> Add a boolean argument enforce_migratetype to the routine
>>> start_isolate_page_range.  If set, it will check that all pageblocks
>>> in the range have the passed migratetype.  Return -EINVAL is pageblock
>>                                                             if
>>> is wrong type is found in range.
>>   of
>>>
>>> A boolean is used for enforce_migratetype as there are two primary
>>> users.  Contiguous range allocation which wants to enforce migration
>>> type checking.  Memory offline (hotplug) which is not concerned about
>>> type checking.
>>
>> This is missing some high-level result. The end change is that CMA is
>> now enforcing. So we are making it more robust when it's called on
>> non-CMA pageblocks by mistake? (BTW I still do hope we can remove
>> MIGRATE_CMA soon after Joonsoo's ZONE_MOVABLE CMA conversion. Combined
>> with my suggestion above we could hopefully get rid of the migratetype
>> parameter completely instead of enforcing it?). Is this also a
>> preparation for introducing find_alloc_contig_pages() which will be
>> enforcing? (I guess, and will find out shortly, but it should be stated
>> here)
> 
> Thank you for looking at these patches Vlastimil.
> 
> My primary motivation for this patch was the 'error recovery' in
> start_isolate_page_range.  It takes a range and attempts to set
> all pageblocks to MIGRATE_ISOLATE.  If it encounters an error after
> setting some blocks to isolate, it will 'clean up' by setting the
> migrate type of previously modified blocks to the passed migratetype.

Right.

> So, one possible side effect of an error in start_isolate_page_range
> is that the migrate type of some pageblocks could be modified.  Thinking
> about it more now, that may be OK.

It would be definitely OK if the migratetype was changed similarly as
steal_suitable_fallback() does it, as I've said above.

> It just does not seem like the
> right thing to do, especially with comments saying "migratetype must
> be either MIGRATE_MOVABLE or MIGRATE_CMA".  I'm fine with leaving the
> code as is and just cleaning up the comments if you think that may
> be better.

That's also possible, especially when the code is restructured as I've
suggested in the other reply, which should significantly reduce the
amount of error recoveries.
