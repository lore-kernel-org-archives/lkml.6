Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F01BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE882253F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QWo2j1kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE882253F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbeGBUaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:30:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeGBUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:30:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62KSgBK078485
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=/N8iExQ/YSugGmMArkfxdwjXTJmhHN+eV1IlL/nQQBs=;
 b=QWo2j1kKDlYINegDzSIgN+NUSEa0D+BZOgVTIfyG/FHlQlD5a1/2g0ocTsCdSaVZUzaE
 3SCNO85B2C6YJeonfuxvgINRqtRryt9CN0VBNVyAc7OFRy8LD6wF/5K1UgrIWtEnaLZs
 Xd4YHA5j12QeXTouxZSFQVV7rlH9oW1Umr1RPk+iEf0EO9doG4RC6rRM65/20ljxCyHC
 qFSyy2rTjaNjj3k9gQKiZoCGfW5RGW/II+wSKRJphCa10F5+/7Lp62fVtQ2855d3kRly
 0zMmcavKVdPZqPPOWGYZH0qjHcLF+TloIxNFZw889JAc3slNaPTarXyXzv52h7Oo/gAr Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jx19sp117-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:30:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w62KTwKV017677
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:29:59 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w62KTwRm006396
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:29:58 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 13:29:58 -0700
Received: by mail-oi0-f53.google.com with SMTP id d189-v6so10111876oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:29:58 -0700 (PDT)
X-Gm-Message-State: APt69E3vLC92TIfMVf3ExCR/H5Vdw7m4aSYxQE2Y07pVtZCjPV0obM/Z
        as1D+Og733ah+O+uRIubrQbJ28AWVlkBbblYwWE=
X-Google-Smtp-Source: AAOMgpdrz7khEhgDMHQ4Ikujy4iyfsfUIw/+GZO3a3KdwpG8mTguuUFqMupXKehgEuNdVcruslgsR/hYTr0xGyJ7TUc=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr18328314oia.229.1530563398042;
 Mon, 02 Jul 2018 13:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <ba037a25-eef0-c2b1-91f2-5db5588b2881@intel.com>
In-Reply-To: <ba037a25-eef0-c2b1-91f2-5db5588b2881@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 16:29:21 -0400
X-Gmail-Original-Message-ID: <CAGM2reaOpSA6VjuYfMWyNqq4MrsCYdmwX7Crw_vRsBwPNHU+aA@mail.gmail.com>
Message-ID: <CAGM2reaOpSA6VjuYfMWyNqq4MrsCYdmwX7Crw_vRsBwPNHU+aA@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:00 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > @@ -2651,6 +2651,14 @@ void sparse_mem_maps_populate_node(struct page **map_map,
> >                                  unsigned long pnum_end,
> >                                  unsigned long map_count,
> >                                  int nodeid);
> > +struct page * sparse_populate_node(unsigned long pnum_begin,
>
> CodingStyle: put the "*" next to the function name, no space, please.

OK

>
> > +                                unsigned long pnum_end,
> > +                                unsigned long map_count,
> > +                                int nid);
> > +struct page * sparse_populate_node_section(struct page *map_base,
> > +                                unsigned long map_index,
> > +                                unsigned long pnum,
> > +                                int nid);
>
> These two functions are named in very similar ways.  Do they do similar
> things?

Yes, they do in non-vmemmap:

sparse_populate_node() -> populates the whole node if we can using a
single allocation
sparse_populate_node_section() -> populate only one section in the
given node if the whole node is not already populated.

However, vemmap variant is a little different: sparse_populate_node()
populates in a single allocation if can, and if not it still populates
the whole node but in smaller chunks, so
sparse_populate_node_section()  has nothing left to do.

>
> >  struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
> >               struct vmem_altmap *altmap);
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index e1a54ba411ec..b3e325962306 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -311,3 +311,52 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> >               vmemmap_buf_end = NULL;
> >       }
> >  }
> > +
> > +struct page * __init sparse_populate_node(unsigned long pnum_begin,
> > +                                       unsigned long pnum_end,
> > +                                       unsigned long map_count,
> > +                                       int nid)
> > +{
>
> Could you comment what the function is doing, please?

Sure, I will add comments.

>
> > +     unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
> > +     unsigned long pnum, map_index = 0;
> > +     void *vmemmap_buf_start;
> > +
> > +     size = ALIGN(size, PMD_SIZE) * map_count;
> > +     vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
> > +                                                   PMD_SIZE,
> > +                                                   __pa(MAX_DMA_ADDRESS));
>
> Let's not repeat the mistakes of the previous version of the code.
> Please explain why we are aligning this.  Also,
> __earlyonly_bootmem_alloc()->memblock_virt_alloc_try_nid_raw() claims to
> be aligning the size.  Do we also need to do it here?
>
> Yes, I know the old code did this, but this is the cost of doing a
> rewrite. :)

Actually, I was thinking about this particular case when I was
rewriting this code. Here we align size before multiplying by
map_count aligns after memblock_virt_alloc_try_nid_raw(). So, we must
have both as they are different.

>
> > +     if (vmemmap_buf_start) {
> > +             vmemmap_buf = vmemmap_buf_start;
> > +             vmemmap_buf_end = vmemmap_buf_start + size;
> > +     }
>
> It would be nice to call out that these are globals that other code
> picks up.

I do not like these globals, they should have specific functions that
access them only, something:
static struct {
  buffer;
  buffer_end;
} vmemmap_buffer;
vmemmap_buffer_init() allocate buffer
vmemmap_buffer_alloc()  return NULL if buffer is empty
vmemmap_buffer_fini()

Call vmemmap_buffer_init()  and vmemmap_buffer_fini()  from
sparse_populate_node() and
vmemmap_buffer_alloc() from vmemmap_alloc_block_buf().

But, it should be a separate patch. If you would like I can add it to
this series, or submit separately.

>
> > +     for (pnum = pnum_begin; map_index < map_count; pnum++) {
> > +             if (!present_section_nr(pnum))
> > +                     continue;
> > +             if (!sparse_mem_map_populate(pnum, nid, NULL))
> > +                     break;
>
> ^ This consumes "vmemmap_buf", right?  That seems like a really nice
> thing to point out here if so.

It consumes vmemmap_buf if __earlyonly_bootmem_alloc() was successful,
otherwise it allocates struct pages a section at a time.

>
> > +             map_index++;
> > +             BUG_ON(pnum >= pnum_end);
> > +     }
> > +
> > +     if (vmemmap_buf_start) {
> > +             /* need to free left buf */
> > +             memblock_free_early(__pa(vmemmap_buf),
> > +                                 vmemmap_buf_end - vmemmap_buf);
> > +             vmemmap_buf = NULL;
> > +             vmemmap_buf_end = NULL;
> > +     }
> > +     return pfn_to_page(section_nr_to_pfn(pnum_begin));
> > +}
> > +
> > +/*
> > + * Return map for pnum section. sparse_populate_node() has populated memory map
> > + * in this node, we simply do pnum to struct page conversion.
> > + */
> > +struct page * __init sparse_populate_node_section(struct page *map_base,
> > +                                               unsigned long map_index,
> > +                                               unsigned long pnum,
> > +                                               int nid)
> > +{
> > +     return pfn_to_page(section_nr_to_pfn(pnum));
> > +}
>
> What is up with all of the unused arguments to this function?

Because the same function is called from non-vmemmap sparse code.

>
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index d18e2697a781..c18d92b8ab9b 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -456,6 +456,43 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> >                      __func__);
> >       }
> >  }
> > +
> > +static unsigned long section_map_size(void)
> > +{
> > +     return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
> > +}
>
> Seems like if we have this, we should use it wherever possible, like
> sparse_populate_node().

It is used in sparse_populate_node():

401 struct page * __init sparse_populate_node(unsigned long pnum_begin,
406         return memblock_virt_alloc_try_nid_raw(section_map_size()
* map_count,
407                                                PAGE_SIZE,
__pa(MAX_DMA_ADDRESS),
408
BOOTMEM_ALLOC_ACCESSIBLE, nid);


>
>
> > +/*
> > + * Try to allocate all struct pages for this node, if this fails, we will
> > + * be allocating one section at a time in sparse_populate_node_section().
> > + */
> > +struct page * __init sparse_populate_node(unsigned long pnum_begin,
> > +                                       unsigned long pnum_end,
> > +                                       unsigned long map_count,
> > +                                       int nid)
> > +{
> > +     return memblock_virt_alloc_try_nid_raw(section_map_size() * map_count,
> > +                                            PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> > +                                            BOOTMEM_ALLOC_ACCESSIBLE, nid);
> > +}
> > +
> > +/*
> > + * Return map for pnum section. map_base is not NULL if we could allocate map
> > + * for this node together. Otherwise we allocate one section at a time.
> > + * map_index is the index of pnum in this node counting only present sections.
> > + */
> > +struct page * __init sparse_populate_node_section(struct page *map_base,
> > +                                               unsigned long map_index,
> > +                                               unsigned long pnum,
> > +                                               int nid)
> > +{
> > +     if (map_base) {
> > +             unsigned long offset = section_map_size() * map_index;
> > +
> > +             return (struct page *)((char *)map_base + offset);
> > +     }
> > +     return sparse_mem_map_populate(pnum, nid, NULL);
>
> Oh, you have a vmemmap and non-vmemmap version.
>
> BTW, can't the whole map base calculation just be replaced with:
>
>         return &map_base[PAGES_PER_SECTION * map_index];

Unfortunately no.  Because map_base might be allocated in chunks
larger than PAGES_PER_SECTION * sizeof(struct page). See: PAGE_ALIGN()
in section_map_size

Thank you,
Pavel
