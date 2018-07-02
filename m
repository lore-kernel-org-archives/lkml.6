Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA3425557
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZLRRcQ35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA3425557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGBBpZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:45:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58192 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeGBBpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:45:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w621iQnI092323
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=VBm908lwr2tZcnhD9lGxnHhfnHbhW2LHZWsXVwGjU98=;
 b=ZLRRcQ35uhW0DlZquyN9fFYflhZPHur3iR8wlvX8Zra+zOOE/RUDeSG+Zhydf8xYht5O
 jRdcxp3g9T9SXhqSdQizd9LMKiHz1uC0qJzFuFL0h/2AcrK2Vw8f8f9lgOyIM84uFmNW
 NkP0CwiEfaYdrCuqu4FjTGKa31C/LVDt3ETgaz0roN3Taif+Cxkjs7oD8WkbVfcf1XBS
 cMrb8W6YnVE92kPEd20XiMwb6T+K7LUTM/D61YrPmsHg+4DjFdEMrFUz49rnX7d1rQL3
 g/+20RZrZUOjERH9bjaYEVbtKgZnyjGfCqxhdEMdwsz/kcjCS1BOStllDkCKUP3HJ/Jr 0g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jwyccjp8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:45:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w621jMMa030991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:45:22 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w621jLPQ015348
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:45:21 GMT
Received: from mail-oi0-f41.google.com (/209.85.218.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 18:45:21 -0700
Received: by mail-oi0-f41.google.com with SMTP id 13-v6so1048776ois.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 18:45:21 -0700 (PDT)
X-Gm-Message-State: APt69E0WFYN8IzfWlhQzPObnSqBP+JalUj0wVPAcd7cktCDuOglQ5M8h
        b2HVsKcsYGdIrXJDSRrLw6WiQ3SmOHlDo70pNv0=
X-Google-Smtp-Source: AAOMgpeY7LJWB6MAbGeASidzuOAJAjjViZ+8WuU2CoqpD6d3oAXrdcmZc3q2A+9tt6TCfwdtSjLEQEMcDhE749Hdpgs=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr8123125oig.221.1530495920840;
 Sun, 01 Jul 2018 18:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180630030944.9335-1-pasha.tatashin@oracle.com>
 <20180630030944.9335-3-pasha.tatashin@oracle.com> <20180702013402.GI3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702013402.GI3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 21:44:44 -0400
X-Gmail-Original-Message-ID: <CAGM2reaoORijUVeNaeLQ075zJS737TaEhDxs3O=eMfyTUZXAdA@mail.gmail.com>
Message-ID: <CAGM2reaoORijUVeNaeLQ075zJS737TaEhDxs3O=eMfyTUZXAdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
To:     bhe@redhat.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 9:34 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pavel,
>
> On 06/29/18 at 11:09pm, Pavel Tatashin wrote:
> > Change sprase_init() to only find the pnum ranges that belong to a specific
> > node and call sprase_init_nid() for that range from sparse_init().
> >
> > Delete all the code that became obsolete with this change.
>
> > @@ -617,87 +491,24 @@ void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >   */
> >  void __init sparse_init(void)
> >  {
> > -     unsigned long pnum;
> > -     struct page *map;
> > -     struct page **map_map;
> > -     unsigned long *usemap;
> > -     unsigned long **usemap_map;
> > -     int size, size2;
> > -     int nr_consumed_maps = 0;
> > -
> > -     /* see include/linux/mmzone.h 'struct mem_section' definition */
> > -     BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));
> > +     unsigned long pnum_begin = first_present_section_nr();
> > +     int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
> > +     unsigned long pnum_end, map_count = 1;
> >
> > -     /* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
> > -     set_pageblock_order();
>
> Not very sure if removing set_pageblock_order() calling here is OK. What
> if CONFIG_HUGETLB_PAGE_SIZE_VARIABLE is enabled? usemap_size() depends
> on value of 'pageblock_order'.

Hi Baoquan,

Nice catch, you are right, I incorrectly removed this call, will add
it back in the next version.

Pavel

>
> Thanks
> Baoquan
>
> > +     for_each_present_section_nr(pnum_begin + 1, pnum_end) {
> > +             int nid = sparse_early_nid(__nr_to_section(pnum_end));
> >
> > -     /*
> > -      * map is using big page (aka 2M in x86 64 bit)
> > -      * usemap is less one page (aka 24 bytes)
> > -      * so alloc 2M (with 2M align) and 24 bytes in turn will
> > -      * make next 2M slip to one more 2M later.
> > -      * then in big system, the memory will have a lot of holes...
> > -      * here try to allocate 2M pages continuously.
> > -      *
> > -      * powerpc need to call sparse_init_one_section right after each
> > -      * sparse_early_mem_map_alloc, so allocate usemap_map at first.
> > -      */
> > -     size = sizeof(unsigned long *) * nr_present_sections;
> > -     usemap_map = memblock_virt_alloc(size, 0);
> > -     if (!usemap_map)
> > -             panic("can not allocate usemap_map\n");
> > -     alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
> > -                             (void *)usemap_map,
> > -                             sizeof(usemap_map[0]));
> > -
> > -     size2 = sizeof(struct page *) * nr_present_sections;
> > -     map_map = memblock_virt_alloc(size2, 0);
> > -     if (!map_map)
> > -             panic("can not allocate map_map\n");
> > -     alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
> > -                             (void *)map_map,
> > -                             sizeof(map_map[0]));
> > -
> > -     /* The numner of present sections stored in nr_present_sections
> > -      * are kept the same since mem sections are marked as present in
> > -      * memory_present(). In this for loop, we need check which sections
> > -      * failed to allocate memmap or usemap, then clear its
> > -      * ->section_mem_map accordingly. During this process, we need
> > -      * increase 'nr_consumed_maps' whether its allocation of memmap
> > -      * or usemap failed or not, so that after we handle the i-th
> > -      * memory section, can get memmap and usemap of (i+1)-th section
> > -      * correctly. */
> > -     for_each_present_section_nr(0, pnum) {
> > -             struct mem_section *ms;
> > -
> > -             if (nr_consumed_maps >= nr_present_sections) {
> > -                     pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
> > -                     break;
> > -             }
> > -             ms = __nr_to_section(pnum);
> > -             usemap = usemap_map[nr_consumed_maps];
> > -             if (!usemap) {
> > -                     ms->section_mem_map = 0;
> > -                     nr_consumed_maps++;
> > -                     continue;
> > -             }
> > -
> > -             map = map_map[nr_consumed_maps];
> > -             if (!map) {
> > -                     ms->section_mem_map = 0;
> > -                     nr_consumed_maps++;
> > +             if (nid == nid_begin) {
> > +                     map_count++;
> >                       continue;
> >               }
> > -
> > -             sparse_init_one_section(__nr_to_section(pnum), pnum, map,
> > -                                                             usemap);
> > -             nr_consumed_maps++;
> > +             sparse_init_nid(nid, pnum_begin, pnum_end, map_count);
> > +             nid_begin = nid;
> > +             pnum_begin = pnum_end;
> > +             map_count = 1;
> >       }
> > -
> > +     sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
> >       vmemmap_populate_print_last();
> > -
> > -     memblock_free_early(__pa(map_map), size2);
> > -     memblock_free_early(__pa(usemap_map), size);
> >  }
> >
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > --
> > 2.18.0
> >
>
