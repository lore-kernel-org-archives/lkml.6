Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeE3PvN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:51:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33972 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeE3PvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:51:11 -0400
Subject: Re: [PATCH 2/8] xen/balloon: Move common memory reservation routines
 to a module
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180525153331.31188-1-andr2000@gmail.com>
 <20180525153331.31188-3-andr2000@gmail.com>
 <59ab73b0-967b-a82f-3b0d-95f1b0dc40a5@oracle.com>
 <89de7bdb-8759-419f-63bf-8ed0d57650f0@gmail.com>
 <edfa937b-3311-98db-2e6f-b4083598f796@oracle.com>
 <6ca7f428-eede-2c14-85fe-da4a20bcea0d@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <5dd3378d-ac32-691e-1f80-7218a5d07fd6@oracle.com>
Date: Wed, 30 May 2018 11:54:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6ca7f428-eede-2c14-85fe-da4a20bcea0d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 04:29 AM, Oleksandr Andrushchenko wrote:
> On 05/29/2018 11:03 PM, Boris Ostrovsky wrote:
>> On 05/29/2018 02:22 PM, Oleksandr Andrushchenko wrote:
>>> On 05/29/2018 09:04 PM, Boris Ostrovsky wrote:
>>>> On 05/25/2018 11:33 AM, Oleksandr Andrushchenko wrote:
>>>> @@ -463,11 +457,6 @@ static enum bp_state
>>>> increase_reservation(unsigned long nr_pages)
>>>>        int rc;
>>>>        unsigned long i;
>>>>        struct page   *page;
>>>> -    struct xen_memory_reservation reservation = {
>>>> -        .address_bits = 0,
>>>> -        .extent_order = EXTENT_ORDER,
>>>> -        .domid        = DOMID_SELF
>>>> -    };
>>>>          if (nr_pages > ARRAY_SIZE(frame_list))
>>>>            nr_pages = ARRAY_SIZE(frame_list);
>>>> @@ -486,9 +475,7 @@ static enum bp_state
>>>> increase_reservation(unsigned long nr_pages)
>>>>            page = balloon_next_page(page);
>>>>        }
>>>>    -    set_xen_guest_handle(reservation.extent_start, frame_list);
>>>> -    reservation.nr_extents = nr_pages;
>>>> -    rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
>>>> +    rc = xenmem_reservation_increase(nr_pages, frame_list);
>>>>        if (rc <= 0)
>>>>            return BP_EAGAIN;
>>>>    @@ -496,29 +483,7 @@ static enum bp_state
>>>> increase_reservation(unsigned long nr_pages)
>>>>            page = balloon_retrieve(false);
>>>>            BUG_ON(page == NULL);
>>>>    -#ifdef CONFIG_XEN_HAVE_PVMMU
>>>> -        /*
>>>> -         * We don't support PV MMU when Linux and Xen is using
>>>> -         * different page granularity.
>>>> -         */
>>>> -        BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
>>>> -
>>>> -        if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>>>> -            unsigned long pfn = page_to_pfn(page);
>>>> -
>>>> -            set_phys_to_machine(pfn, frame_list[i]);
>>>> -
>>>> -            /* Link back into the page tables if not highmem. */
>>>> -            if (!PageHighMem(page)) {
>>>> -                int ret;
>>>> -                ret = HYPERVISOR_update_va_mapping(
>>>> -                        (unsigned long)__va(pfn << PAGE_SHIFT),
>>>> -                        mfn_pte(frame_list[i], PAGE_KERNEL),
>>>> -                        0);
>>>> -                BUG_ON(ret);
>>>> -            }
>>>> -        }
>>>> -#endif
>>>> +        xenmem_reservation_va_mapping_update(1, &page,
>>>> &frame_list[i]);
>>>>
>>>> Can you make a single call to xenmem_reservation_va_mapping_update(rc,
>>>> ...)? You need to keep track of pages but presumable they can be put
>>>> into an array (or a list). In fact, perhaps we can have
>>>> balloon_retrieve() return a set of pages.
>>> This is actually how it is used later on for dma-buf, but I just
>>> didn't want
>>> to alter original balloon code too much, but this can be done, in
>>> order of simplicity:
>>>
>>> 1. Similar to frame_list, e.g. static array of struct page* of size
>>> ARRAY_SIZE(frame_list):
>>> more static memory is used, but no allocations
>>>
>>> 2. Allocated at run-time with kcalloc: allocation can fail
>>
>> If this is called in freeing DMA buffer code path or in error path then
>> we shouldn't do it.
>>
>>
>>> 3. Make balloon_retrieve() return a set of pages: will require
>>> list/array allocation
>>> and handling, allocation may fail, balloon_retrieve prototype change
>>
>> balloon pages are strung on the lru list. Can we keep have
>> balloon_retrieve return a list of pages on that list?
> First of all, before we go deep in details, I will highlight
> the goal of the requested change: for balloon driver we call
> xenmem_reservation_va_mapping_update(*1*, &page, &frame_list[i]);
> from increase_reservation
> and
> xenmem_reservation_va_mapping_reset(*1*, &page);
> from decrease_reservation and it seems to be not elegant because of
> that one page/frame passed while we might have multiple pages/frames
> passed at once.
>
> In the balloon driver the producer of pages for increase_reservation
> is balloon_retrieve(false) and for decrease_reservation it is
> alloc_page(gfp).
> In case of decrease_reservation the page is added on the list:
> LIST_HEAD(pages);
> [...]
> list_add(&page->lru, &pages);
>
> and in case of increase_reservation it is retrieved page by page
> and can be put on a list as well with the same code from
> decrease_reservation, e.g.
> LIST_HEAD(pages);
> [...]
> list_add(&page->lru, &pages);
>
> Thus, both decrease_reservation and increase_reservation may hold
> their pages on a list before calling
> xenmem_reservation_va_mapping_{update|reset}.
>
> For that we need a prototype change:
> xenmem_reservation_va_mapping_reset(<nr_pages>, <list of pages>);
> But for xenmem_reservation_va_mapping_update it will look like:
> xenmem_reservation_va_mapping_update(<nr_pages>, <list of pages>,
> <array of frames>)
> which seems to be inconsistent. Converting entries of the static
> frame_list array
> into corresponding list doesn't seem to be cute as well.
>
> For dma-buf use-case arrays are more preferable as dma-buf constructs
> scatter-gather
> tables from array of pages etc. and if page list is passed then it
> needs to be
> converted into page array anyways.
>
> So, we can:
> 1. Keep the prototypes as is, e.g. accept array of pages and use
> nr_pages == 1 in
> case of balloon driver (existing code)
> 2. Statically allocate struct page* array in the balloon driver and
> fill it with pages
> when those pages are retrieved:
> static struct page *page_list[ARRAY_SIZE(frame_list)];
> which will take additional 8KiB of space on 64-bit platform, but
> simplify things a lot.
> 3. Allocate struct page *page_list[ARRAY_SIZE(frame_list)] dynamically
>
> As to Boris' suggestion "balloon pages are strung on the lru list. Can
> we keep have
> balloon_retrieve return a list of pages on that list?"
> Because of alloc_xenballooned_pages' retry logic for page retireval, e.g.
>     while (pgno < nr_pages) {
>         page = balloon_retrieve(true);
>         if (page) {
> [...]
>         } else {
>             ret = add_ballooned_pages(nr_pages - pgno);
> [...]
>     }
> I wouldn't change things that much.
>
> IMO, we can keep 1 page based API with the only overhead for balloon
> driver of
> function calls to xenmem_reservation_va_mapping_{update|reset} for
> each page.



I still think what I suggested is doable but we can come back to it
later and keep your per-page implementation for now.

BTW, I also think you can further simplify
xenmem_reservation_va_mapping_* routines by bailing out right away if
xen_feature(XENFEAT_auto_translated_physmap). In fact, you might even
make them inlines, along the lines of

inline void xenmem_reservation_va_mapping_reset(unsigned long count,
					 struct page **pages)
{
#ifdef CONFIG_XEN_HAVE_PVMMU
	if (!xen_feature(XENFEAT_auto_translated_physmap))
		__xenmem_reservation_va_mapping_reset(...)
#endif
} 

Or some such.

-boris

-boris
