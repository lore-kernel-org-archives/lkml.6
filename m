Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE20C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D72206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbeLQJig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:38:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbeLQJig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:38:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F8F287633;
        Mon, 17 Dec 2018 09:38:35 +0000 (UTC)
Received: from [10.36.117.250] (ovpn-117-250.ams2.redhat.com [10.36.117.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 577E71000049;
        Mon, 17 Dec 2018 09:38:33 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
 <476a80cb-5524-16c1-6dd5-da5febbd6139@redhat.com>
 <bcd0c49c-e417-ef8b-996f-99ecef540d9c@redhat.com>
 <20181214202315.1c685f1e@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <cffab731-81e0-b80c-665e-c9a62faed4ec@redhat.com>
Date:   Mon, 17 Dec 2018 10:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181214202315.1c685f1e@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 17 Dec 2018 09:38:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.18 20:23, Gerald Schaefer wrote:
> On Fri, 14 Dec 2018 16:49:14 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.12.18 16:22, David Hildenbrand wrote:
>>> On 12.12.18 18:27, Mikhail Zaslonko wrote:  
>>>> If memory end is not aligned with the sparse memory section boundary, the
>>>> mapping of such a section is only partly initialized. This may lead to
>>>> VM_BUG_ON due to uninitialized struct page access from
>>>> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>>>> memory_hotplug sysfs handlers:
>>>>
>>>> Here are the the panic examples:
>>>>  CONFIG_DEBUG_VM=y
>>>>  CONFIG_DEBUG_VM_PGFLAGS=y
>>>>
>>>>  kernel parameter mem=2050M
>>>>  --------------------------
>>>>  page:000003d082008000 is uninitialized and poisoned
>>>>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>>>  Call Trace:
>>>>  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>>>>   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>>>>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>>>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>>>   [<00000000003e4194>] seq_read+0x204/0x480
>>>>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>>>>   [<00000000003b55b2>] vfs_read+0x82/0x138
>>>>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>>>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>>>  Last Breaking-Event-Address:
>>>>   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>>>>  Kernel panic - not syncing: Fatal exception: panic_on_oops
>>>>
>>>>  kernel parameter mem=3075M
>>>>  --------------------------
>>>>  page:000003d08300c000 is uninitialized and poisoned
>>>>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>>>  Call Trace:
>>>>  ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
>>>>   [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
>>>>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>>>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>>>   [<00000000003e4194>] seq_read+0x204/0x480
>>>>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>>>>   [<00000000003b55b2>] vfs_read+0x82/0x138
>>>>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>>>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>>>  Last Breaking-Event-Address:
>>>>   [<000000000038596c>] is_mem_section_removable+0xb4/0x190
>>>>  Kernel panic - not syncing: Fatal exception: panic_on_oops
>>>>
>>>> Fix the problem by initializing the last memory section of each zone
>>>> in memmap_init_zone() till the very end, even if it goes beyond the zone
>>>> end.
>>>>
>>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>>  mm/page_alloc.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 2ec9cc407216..e2afdb2dc2c5 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -5542,6 +5542,18 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>>>  			cond_resched();
>>>>  		}
>>>>  	}
>>>> +#ifdef CONFIG_SPARSEMEM
>>>> +	/*
>>>> +	 * If the zone does not span the rest of the section then
>>>> +	 * we should at least initialize those pages. Otherwise we
>>>> +	 * could blow up on a poisoned page in some paths which depend
>>>> +	 * on full sections being initialized (e.g. memory hotplug).
>>>> +	 */
>>>> +	while (end_pfn % PAGES_PER_SECTION) {
>>>> +		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
>>>> +		end_pfn++;  
>>>
>>> This page will not be marked as PG_reserved - although it is a physical
>>> memory gap. Do we care?
>>>   
>>
>> Hm, or do we even have any idea what this is (e.g. could it also be
>> something not a gap)?
> 
> In the "mem=" restriction scenario it would be a gap, and probably fall
> into the PG_reserved categorization from your recent patch:
>  * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
>  *   to read/write these pages might end badly. Don't touch!
> 
> Not sure if it could be something else. In theory, if it is possible to have
> a scenario where memory zones are not section-aligned, then this
> end_pfn % PAGES_PER_SECTION part could be part of another zone. But then it
> should not matter if the pages get pre-initialized here, with or w/o
> PG_reseved, because they should later be properly initialized in their zone.
> 
> So marking them as PG_reserved sounds right, especially in the light of your
> current PG_reserved clean-up.
> 
>>
>> For physical memory gaps within a section, architectures usually exclude
>> that memory from getting passed to e.g. the page allocator by
>> memblock_reserve().
>>
>> Before handing all free pages to the page allocator, all such reserved
>> memblocks will be marked reserved.
>>
>> But this here seems to be different. We don't have a previous
>> memblock_reserve(), because otherwise these pages would have properly
>> been initialized already when marking them reserved.
> 
> Not sure how memblock_reserve() and struct page initialization are
> related, but at least on s390 there is a memblock_reserve() on the range
> in question in setup_arch() -> reserve_memory_end(). However, in this
> "mem=" scenario, the range is also removed later with memblock_remove()
> in setup_memory_end(), because it is beyond memory_end.
> 

I am wondering if we should fix this on the memblock level instead than.
Something like, before handing memory over to the page allocator, add
memory as reserved up to the last section boundary. Or even when setting
the physical memory limit (mem= scenario).

-- 

Thanks,

David / dhildenb
