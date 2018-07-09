Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87712C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270512087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rbNC65ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270512087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeGIOcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:32:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39464 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeGIOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:32:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69ESQdx098678
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 14:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=AGuoFgD6vbv4db8FbHoFcTQ1zUkqJKERJ2IQ7mnjg04=;
 b=rbNC65jazcfOHKtF5bV8ryMbm1kzNzu1n0zBgp0yTd16xJ2GO7pAzM/BLXgJVHhaO8Uh
 QuW5CRgyvB2qNqyNMPinzWiK5i/JjbzB+HRMzk7dWDIYpSSZorMhIe18J+YVBvfTGye6
 CNtm+LcCgedfDdm/ZEkwspFcfbCeBKFzMMB4fHUDCH6lZGAc36/9/8TESkZqBfKqQozX
 mgr5Vwti01EH36BRZ7QzTzpJH/rlHzJJMuOt5oXfA0ZIpgn+G0mLgQvpPFSEeoY0xHko
 THUNy404Qz0z/Bz8YCgL8cQqkzVf7DiKm2CFACes6WSi5A7BzVIUhxWNZULTyamY5Evh zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p75vew6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:32:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69EW6Qo018110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 14:32:06 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w69EW6VN020494
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 14:32:06 GMT
Received: from mail-oi0-f43.google.com (/209.85.218.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 07:32:05 -0700
Received: by mail-oi0-f43.google.com with SMTP id b15-v6so36210474oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:32:05 -0700 (PDT)
X-Gm-Message-State: APt69E2fZ37Pxe5KBLOUjb56DrkVcAhitS4T/CWeIx9B00MoCaGkNc1I
        OtkwoX6+dnmuv+Xe1DGTnQ1TNMKEmWAgMiPUVxw=
X-Google-Smtp-Source: AAOMgpc3Vf4ZTot7YY7p1wIYswdPhVMGjRndgFeN7iidv8OTey+XPiy9PJTWR3qeJV+Ukkx6Py5H3IWEc4n4n+8WADc=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr24806101oiy.191.1531146725633;
 Mon, 09 Jul 2018 07:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <ba037a25-eef0-c2b1-91f2-5db5588b2881@intel.com>
 <CAGM2reaOpSA6VjuYfMWyNqq4MrsCYdmwX7Crw_vRsBwPNHU+aA@mail.gmail.com> <85bd8e50-8aff-eb9b-5c04-f936b2e445af@intel.com>
In-Reply-To: <85bd8e50-8aff-eb9b-5c04-f936b2e445af@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 9 Jul 2018 10:31:29 -0400
X-Gmail-Original-Message-ID: <CAGM2rearPLo+jdTkQ7rmgBFWg7W3F7KKPokAOeZtKUkiVtmodQ@mail.gmail.com>
Message-ID: <CAGM2rearPLo+jdTkQ7rmgBFWg7W3F7KKPokAOeZtKUkiVtmodQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
To:     dave.hansen@intel.com
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
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 9:39 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 07/02/2018 01:29 PM, Pavel Tatashin wrote:
> > On Mon, Jul 2, 2018 at 4:00 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >>> +     unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
> >>> +     unsigned long pnum, map_index = 0;
> >>> +     void *vmemmap_buf_start;
> >>> +
> >>> +     size = ALIGN(size, PMD_SIZE) * map_count;
> >>> +     vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
> >>> +                                                   PMD_SIZE,
> >>> +                                                   __pa(MAX_DMA_ADDRESS));
> >>
> >> Let's not repeat the mistakes of the previous version of the code.
> >> Please explain why we are aligning this.  Also,
> >> __earlyonly_bootmem_alloc()->memblock_virt_alloc_try_nid_raw() claims to
> >> be aligning the size.  Do we also need to do it here?
> >>
> >> Yes, I know the old code did this, but this is the cost of doing a
> >> rewrite. :)
> >
> > Actually, I was thinking about this particular case when I was
> > rewriting this code. Here we align size before multiplying by
> > map_count aligns after memblock_virt_alloc_try_nid_raw(). So, we must
> > have both as they are different.
>
> That's a good point that they do different things.
>
> But, which behavior of the two different things is the one we _want_?

We definitely want the first one:
size = ALIGN(size, PMD_SIZE) * map_count;

The alignment in memblock is not strictly needed for this case, but it
already comes with memblock allocator.

>
> >>> +     if (vmemmap_buf_start) {
> >>> +             vmemmap_buf = vmemmap_buf_start;
> >>> +             vmemmap_buf_end = vmemmap_buf_start + size;
> >>> +     }
> >>
> >> It would be nice to call out that these are globals that other code
> >> picks up.
> >
> > I do not like these globals, they should have specific functions that
> > access them only, something:
> > static struct {
> >   buffer;
> >   buffer_end;
> > } vmemmap_buffer;
> > vmemmap_buffer_init() allocate buffer
> > vmemmap_buffer_alloc()  return NULL if buffer is empty
> > vmemmap_buffer_fini()
> >
> > Call vmemmap_buffer_init()  and vmemmap_buffer_fini()  from
> > sparse_populate_node() and
> > vmemmap_buffer_alloc() from vmemmap_alloc_block_buf().
> >
> > But, it should be a separate patch. If you would like I can add it to
> > this series, or submit separately.
>
> Seems like a nice cleanup, but I don't think it needs to be done here.
>
> >>> + * Return map for pnum section. sparse_populate_node() has populated memory map
> >>> + * in this node, we simply do pnum to struct page conversion.
> >>> + */
> >>> +struct page * __init sparse_populate_node_section(struct page *map_base,
> >>> +                                               unsigned long map_index,
> >>> +                                               unsigned long pnum,
> >>> +                                               int nid)
> >>> +{
> >>> +     return pfn_to_page(section_nr_to_pfn(pnum));
> >>> +}
> >>
> >> What is up with all of the unused arguments to this function?
> >
> > Because the same function is called from non-vmemmap sparse code.
>
> That's probably good to call out in the patch description if not there
> already.
>
> >>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>> index d18e2697a781..c18d92b8ab9b 100644
> >>> --- a/mm/sparse.c
> >>> +++ b/mm/sparse.c
> >>> @@ -456,6 +456,43 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> >>>                      __func__);
> >>>       }
> >>>  }
> >>> +
> >>> +static unsigned long section_map_size(void)
> >>> +{
> >>> +     return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
> >>> +}
> >>
> >> Seems like if we have this, we should use it wherever possible, like
> >> sparse_populate_node().
> >
> > It is used in sparse_populate_node():
> >
> > 401 struct page * __init sparse_populate_node(unsigned long pnum_begin,
> > 406         return memblock_virt_alloc_try_nid_raw(section_map_size()
> > * map_count,
> > 407                                                PAGE_SIZE,
> > __pa(MAX_DMA_ADDRESS),
> > 408
> > BOOTMEM_ALLOC_ACCESSIBLE, nid);
>
> I missed the PAGE_ALIGN() until now.  That really needs a comment
> calling out how it's not really the map size but the *allocation* size
> of a single section's map.
>
> It probably also needs a name like section_memmap_allocation_size() or
> something to differentiate it from the *used* size.
>
> >>> +/*
> >>> + * Try to allocate all struct pages for this node, if this fails, we will
> >>> + * be allocating one section at a time in sparse_populate_node_section().
> >>> + */
> >>> +struct page * __init sparse_populate_node(unsigned long pnum_begin,
> >>> +                                       unsigned long pnum_end,
> >>> +                                       unsigned long map_count,
> >>> +                                       int nid)
> >>> +{
> >>> +     return memblock_virt_alloc_try_nid_raw(section_map_size() * map_count,
> >>> +                                            PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> >>> +                                            BOOTMEM_ALLOC_ACCESSIBLE, nid);
> >>> +}
> >>> +
> >>> +/*
> >>> + * Return map for pnum section. map_base is not NULL if we could allocate map
> >>> + * for this node together. Otherwise we allocate one section at a time.
> >>> + * map_index is the index of pnum in this node counting only present sections.
> >>> + */
> >>> +struct page * __init sparse_populate_node_section(struct page *map_base,
> >>> +                                               unsigned long map_index,
> >>> +                                               unsigned long pnum,
> >>> +                                               int nid)
> >>> +{
> >>> +     if (map_base) {
> >>> +             unsigned long offset = section_map_size() * map_index;
> >>> +
> >>> +             return (struct page *)((char *)map_base + offset);
> >>> +     }
> >>> +     return sparse_mem_map_populate(pnum, nid, NULL);
> >>
> >> Oh, you have a vmemmap and non-vmemmap version.
> >>
> >> BTW, can't the whole map base calculation just be replaced with:
> >>
> >>         return &map_base[PAGES_PER_SECTION * map_index];
> >
> > Unfortunately no.  Because map_base might be allocated in chunks
> > larger than PAGES_PER_SECTION * sizeof(struct page). See: PAGE_ALIGN()
> > in section_map_size
>
> Good point.
>
> Oh, well, can you at least get rid of the superfluous "(char *)" cast?
> That should make the whole thing a bit less onerous.

I will see what can be done, if it is not going to be cleaner, I will
keep the cast.

Thank you,
Pavel
