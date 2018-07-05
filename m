Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711E1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDC723E90
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDC723E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeGENja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:39:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:4371 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeGENj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:39:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 06:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="55334724"
Received: from avafana1-mobl.amr.corp.intel.com (HELO [10.254.104.152]) ([10.254.104.152])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2018 06:39:26 -0700
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com>
 <ba037a25-eef0-c2b1-91f2-5db5588b2881@intel.com>
 <CAGM2reaOpSA6VjuYfMWyNqq4MrsCYdmwX7Crw_vRsBwPNHU+aA@mail.gmail.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, rientjes@google.com,
        mingo@kernel.org, osalvador@techadventures.net
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <85bd8e50-8aff-eb9b-5c04-f936b2e445af@intel.com>
Date:   Thu, 5 Jul 2018 06:39:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGM2reaOpSA6VjuYfMWyNqq4MrsCYdmwX7Crw_vRsBwPNHU+aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 01:29 PM, Pavel Tatashin wrote:
> On Mon, Jul 2, 2018 at 4:00 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>> +     unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
>>> +     unsigned long pnum, map_index = 0;
>>> +     void *vmemmap_buf_start;
>>> +
>>> +     size = ALIGN(size, PMD_SIZE) * map_count;
>>> +     vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
>>> +                                                   PMD_SIZE,
>>> +                                                   __pa(MAX_DMA_ADDRESS));
>>
>> Let's not repeat the mistakes of the previous version of the code.
>> Please explain why we are aligning this.  Also,
>> __earlyonly_bootmem_alloc()->memblock_virt_alloc_try_nid_raw() claims to
>> be aligning the size.  Do we also need to do it here?
>>
>> Yes, I know the old code did this, but this is the cost of doing a
>> rewrite. :)
> 
> Actually, I was thinking about this particular case when I was
> rewriting this code. Here we align size before multiplying by
> map_count aligns after memblock_virt_alloc_try_nid_raw(). So, we must
> have both as they are different.

That's a good point that they do different things.

But, which behavior of the two different things is the one we _want_?

>>> +     if (vmemmap_buf_start) {
>>> +             vmemmap_buf = vmemmap_buf_start;
>>> +             vmemmap_buf_end = vmemmap_buf_start + size;
>>> +     }
>>
>> It would be nice to call out that these are globals that other code
>> picks up.
> 
> I do not like these globals, they should have specific functions that
> access them only, something:
> static struct {
>   buffer;
>   buffer_end;
> } vmemmap_buffer;
> vmemmap_buffer_init() allocate buffer
> vmemmap_buffer_alloc()  return NULL if buffer is empty
> vmemmap_buffer_fini()
> 
> Call vmemmap_buffer_init()  and vmemmap_buffer_fini()  from
> sparse_populate_node() and
> vmemmap_buffer_alloc() from vmemmap_alloc_block_buf().
> 
> But, it should be a separate patch. If you would like I can add it to
> this series, or submit separately.

Seems like a nice cleanup, but I don't think it needs to be done here.

>>> + * Return map for pnum section. sparse_populate_node() has populated memory map
>>> + * in this node, we simply do pnum to struct page conversion.
>>> + */
>>> +struct page * __init sparse_populate_node_section(struct page *map_base,
>>> +                                               unsigned long map_index,
>>> +                                               unsigned long pnum,
>>> +                                               int nid)
>>> +{
>>> +     return pfn_to_page(section_nr_to_pfn(pnum));
>>> +}
>>
>> What is up with all of the unused arguments to this function?
> 
> Because the same function is called from non-vmemmap sparse code.

That's probably good to call out in the patch description if not there
already.

>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index d18e2697a781..c18d92b8ab9b 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>> @@ -456,6 +456,43 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>>>                      __func__);
>>>       }
>>>  }
>>> +
>>> +static unsigned long section_map_size(void)
>>> +{
>>> +     return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>>> +}
>>
>> Seems like if we have this, we should use it wherever possible, like
>> sparse_populate_node().
> 
> It is used in sparse_populate_node():
> 
> 401 struct page * __init sparse_populate_node(unsigned long pnum_begin,
> 406         return memblock_virt_alloc_try_nid_raw(section_map_size()
> * map_count,
> 407                                                PAGE_SIZE,
> __pa(MAX_DMA_ADDRESS),
> 408
> BOOTMEM_ALLOC_ACCESSIBLE, nid);

I missed the PAGE_ALIGN() until now.  That really needs a comment
calling out how it's not really the map size but the *allocation* size
of a single section's map.

It probably also needs a name like section_memmap_allocation_size() or
something to differentiate it from the *used* size.

>>> +/*
>>> + * Try to allocate all struct pages for this node, if this fails, we will
>>> + * be allocating one section at a time in sparse_populate_node_section().
>>> + */
>>> +struct page * __init sparse_populate_node(unsigned long pnum_begin,
>>> +                                       unsigned long pnum_end,
>>> +                                       unsigned long map_count,
>>> +                                       int nid)
>>> +{
>>> +     return memblock_virt_alloc_try_nid_raw(section_map_size() * map_count,
>>> +                                            PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
>>> +                                            BOOTMEM_ALLOC_ACCESSIBLE, nid);
>>> +}
>>> +
>>> +/*
>>> + * Return map for pnum section. map_base is not NULL if we could allocate map
>>> + * for this node together. Otherwise we allocate one section at a time.
>>> + * map_index is the index of pnum in this node counting only present sections.
>>> + */
>>> +struct page * __init sparse_populate_node_section(struct page *map_base,
>>> +                                               unsigned long map_index,
>>> +                                               unsigned long pnum,
>>> +                                               int nid)
>>> +{
>>> +     if (map_base) {
>>> +             unsigned long offset = section_map_size() * map_index;
>>> +
>>> +             return (struct page *)((char *)map_base + offset);
>>> +     }
>>> +     return sparse_mem_map_populate(pnum, nid, NULL);
>>
>> Oh, you have a vmemmap and non-vmemmap version.
>>
>> BTW, can't the whole map base calculation just be replaced with:
>>
>>         return &map_base[PAGES_PER_SECTION * map_index];
> 
> Unfortunately no.  Because map_base might be allocated in chunks
> larger than PAGES_PER_SECTION * sizeof(struct page). See: PAGE_ALIGN()
> in section_map_size

Good point.

Oh, well, can you at least get rid of the superfluous "(char *)" cast?
That should make the whole thing a bit less onerous.
