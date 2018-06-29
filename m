Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F0C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D522502B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GeQdH3iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D522502B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936792AbeF2Pzi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:55:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbeF2Pzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:55:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TFraaR183539
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=rimTq9lRAdZAgYCoXp7Tp6nIGfD8q0e8zdvN+MUagVg=;
 b=GeQdH3iCQY3aBJTnzngpxZkrz/SHixBdUnNf/WS89bgJzwKgpemsaw0SLP0t5jTE7Gml
 wsfz7E2aIo7qWD0NdwLqBP0kQU7YvUubg/2GWygQEHHrOtl4DOtyiGygur33Hdy7B8ZX
 u5sFy4zhhdO7fWuFqjwrlBqP8eGLSUdKDZ0zJGS3mrM8ktD1n3HXLTvaJ04hAiRqePzx
 42Uh2odDo5cwIDxQqSGF5CDGbyxb+O+hRBpp0tjANYzAzwmVeOM/yupJ4xy/fLkG+UNA
 lYzUS6ZC5tvP7+9i1x+dIg/VChar6rbjYifsTLpeWOkkKBbj3zzSa6ZvkRV0SG/ekHTs FA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jum0af213-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:55:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TFtYTk015681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:55:35 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TFtYYC019952
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 15:55:34 GMT
Received: from mail-ot0-f179.google.com (/74.125.82.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 08:55:34 -0700
Received: by mail-ot0-f179.google.com with SMTP id b10-v6so8467435otl.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:55:34 -0700 (PDT)
X-Gm-Message-State: APt69E15tFbQrB3Yn3i0kpSF3LzpAway1Qf9CKiBFzyZkTSWmzP7y0xt
        m+ezzYL6cha3iQtUGQFvosB/NLz+Ls6z+eVk2Dc=
X-Google-Smtp-Source: AAOMgpdhTd1NG6ZY1gJPqlBVUiS1kZdUd25xyTbQgmRW4iZy3Kgqq6HPG5GKw+7Q25hG5EAaod7nmmjMgSkLyAyxcx0=
X-Received: by 2002:a9d:2e5b:: with SMTP id c27-v6mr18386otd.176.1530287733440;
 Fri, 29 Jun 2018 08:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180628173010.23849-1-pasha.tatashin@oracle.com>
 <20180628173010.23849-2-pasha.tatashin@oracle.com> <20180629143527.GA23545@techadventures.net>
In-Reply-To: <20180629143527.GA23545@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 11:54:57 -0400
X-Gmail-Original-Message-ID: <CAGM2reaW94eNnz20FoSnocoXFPUV1_fCbKwj6+Q5EzqCoKE8uQ@mail.gmail.com>
Message-ID: <CAGM2reaW94eNnz20FoSnocoXFPUV1_fCbKwj6+Q5EzqCoKE8uQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/sparse: add sparse_init_nid()
To:     osalvador@techadventures.net
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:35 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Thu, Jun 28, 2018 at 01:30:09PM -0400, Pavel Tatashin wrote:
> > sparse_init() requires to temporary allocate two large buffers:
> > usemap_map and map_map. Baoquan He has identified that these buffers are so
> > large that Linux is not bootable on small memory machines, such as a kdump
> > boot.
> >
> > Baoquan provided a fix, which reduces these sizes of these buffers, but it
> > is much better to get rid of them entirely.
> >
> > Add a new way to initialize sparse memory: sparse_init_nid(), which only
> > operates within one memory node, and thus allocates memory either in large
> > contiguous block or allocates section by section. This eliminates the need
> > for use of temporary buffers.
> >
> > For simplified bisecting and review, the new interface is going to be
> > enabled as well as old code removed in the next patch.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >  include/linux/mm.h  |  8 ++++
> >  mm/sparse-vmemmap.c | 49 ++++++++++++++++++++++++
> >  mm/sparse.c         | 90 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 147 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a0fbb9ffe380..ba200808dd5f 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2651,6 +2651,14 @@ void sparse_mem_maps_populate_node(struct page **map_map,
> >                                  unsigned long pnum_end,
> >                                  unsigned long map_count,
> >                                  int nodeid);
> > +struct page * sparse_populate_node(unsigned long pnum_begin,
> > +                                unsigned long pnum_end,
> > +                                unsigned long map_count,
> > +                                int nid);
> > +struct page * sprase_populate_node_section(struct page *map_base,
> > +                                unsigned long map_index,
> > +                                unsigned long pnum,
> > +                                int nid);
> >
> >  struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
> >               struct vmem_altmap *altmap);
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index e1a54ba411ec..4655503bdc66 100644
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
> > +     unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
> > +     unsigned long pnum, map_index = 0;
> > +     void *vmemmap_buf_start;
> > +
> > +     size = ALIGN(size, PMD_SIZE) * map_count;
> > +     vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
> > +                                                   PMD_SIZE,
> > +                                                   __pa(MAX_DMA_ADDRESS));
> > +     if (vmemmap_buf_start) {
> > +             vmemmap_buf = vmemmap_buf_start;
> > +             vmemmap_buf_end = vmemmap_buf_start + size;
> > +     }
> > +
> > +     for (pnum = pnum_begin; map_index < map_count; pnum++) {
> > +             if (!present_section_nr(pnum))
> > +                     continue;
> > +             if (!sparse_mem_map_populate(pnum, nid, NULL))
> > +                     break;
> > +             map_index++;
> > +             BUG_ON(pnum >= pnum_end);
> > +     }
>
> Besides the typos, I could not find anything wrong in the patch.
> Only cosmetic:
>
> Could not the loop above be converted to a for_each_present_section_nr() or would it be
> less readable?

for_each_present_section_nr is defined in sparse.c, so I decided to
use what is used in other places in sparse-vmemmap.c

>
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
> > +struct page * __init sprase_populate_node_section(struct page *map_base,
> > +                                               unsigned long map_index,
> > +                                               unsigned long pnum,
> > +                                               int nid)
> > +{
> > +     return pfn_to_page(section_nr_to_pfn(pnum));
> > +}
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index d18e2697a781..60eaa2a4842a 100644
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
> > +
> > +/*
> > + * Try to allocate all struct pages for this node, if this fails, we will
> > + * be allocating one section at a time in sprase_populate_node_section().
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
> > +struct page * __init sprase_populate_node_section(struct page *map_base,
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
> > +}
> >  #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
> >
> >  static void __init sparse_early_mem_maps_alloc_node(void *data,
> > @@ -520,6 +557,59 @@ static void __init alloc_usemap_and_memmap(void (*alloc_func)
> >                                               map_count, nodeid_begin);
> >  }
> >
> > +/*
> > + * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
> > + * And number of present sections in this node is map_count.
> > + */
> > +void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> > +                                unsigned long pnum_end,
> > +                                unsigned long map_count)
> > +{
> > +     unsigned long pnum, usemap_longs, *usemap, map_index;
> > +     struct page *map, *map_base;
> > +     struct mem_section *ms;
>
> What about moving "struct mem_section" into the second for_each_present_section_nr() loop.
> It is only being used there.
> And we could move "struct page *map" into the first loop as well.

Thank you for the review, I will move the declarations into loops.

>
> But the patch looks good to me anyway.
> Maybe I am missing something, but so far:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> --
> Oscar Salvador
> SUSE L3
>
