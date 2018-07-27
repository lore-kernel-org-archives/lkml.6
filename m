Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF05BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA4820897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nRTpl/Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA4820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeG0StQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:49:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0StQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:49:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6RHNO5K057214
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=DWszz6lWAgTL6oiVoY2IvjPWewk0jrjjzemS4k9MunU=;
 b=nRTpl/TmyIp+zIujvr2Qt/PGPDvPbY9etLaK5DHrxw0hyaiNtlK4sj7p8CZvV3zfnRPz
 cicTHjNFZyXXK22UpqfkRucK3o7Qrvzur03IRUcyM/JCKa2A/jAECLZYZF+krurIKGDf
 SJyioRcdMKTAqN2WRcBjlM8yrBRDj2MkNSyBOXDkFI7YmiNVPy6wJuMOJNuP9AUbGyjx
 Wy/qoBq9wnAgWFl/hGdjBYwB0jCN8744N62jVDT1RzKkzJ1zfeRaZteZL3VfbMBxOLFj
 G9ZD7ELS0zZuxUZMgTw9r8aoc/c1g4bVpLJL5T9TtX7u8zbybqyXiJ2ShXqlV3o6IaDy rg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kbv8tg56w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:26:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6RHQNiM026541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:26:23 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6RHQMWu030254
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:26:22 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Jul 2018 10:26:22 -0700
Received: by mail-oi0-f54.google.com with SMTP id 13-v6so10396963ois.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:26:22 -0700 (PDT)
X-Gm-Message-State: AOUpUlF2qVjrkAj6+bAHx0HC/CXYMwWVzEvZ2MQuplcnvY7r2JINSrTx
        49bZSHT23z3vwayJUqa4srRE2am+SI9w/+YVAqw=
X-Google-Smtp-Source: AAOMgpczWTeZ0fkcANse3ETI7MWR2rvs+AUpi1LdgDAHNMzzHhKIeJexQQVkxvv1YYUpJYFwFHSu3HtR0KKhtaMs4FA=
X-Received: by 2002:aca:b541:: with SMTP id e62-v6mr7969067oif.136.1532712381856;
 Fri, 27 Jul 2018 10:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180727165454.27292-1-david@redhat.com>
In-Reply-To: <20180727165454.27292-1-david@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 27 Jul 2018 13:25:45 -0400
X-Gmail-Original-Message-ID: <CAGM2reYOat1bxBi0KCZAKrh0YS2PX=w-AkpesuuNVY26SSDu9A@mail.gmail.com>
Message-ID: <CAGM2reYOat1bxBi0KCZAKrh0YS2PX=w-AkpesuuNVY26SSDu9A@mail.gmail.com>
Subject: Re: [PATCH v1] mm: inititalize struct pages when adding a section
To:     david@redhat.com
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, Michal Hocko <mhocko@suse.com>,
        jack@suse.cz, mawilcox@microsoft.com, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kirill.shutemov@linux.intel.com, Vlastimil Babka <vbabka@suse.cz>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        malat@debian.org, Mel Gorman <mgorman@suse.de>,
        iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8967 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807270176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Jul 27, 2018 at 12:55 PM David Hildenbrand <david@redhat.com> wrote:
>
> Right now, struct pages are inititalized when memory is onlined, not
> when it is added (since commit d0dc12e86b31 ("mm/memory_hotplug: optimize
> memory hotplug")).
>
> remove_memory() will call arch_remove_memory(). Here, we usually access
> the struct page to get the zone of the pages.
>
> So effectively, we access stale struct pages in case we remove memory that
> was never onlined.

Yeah, this is a bug, thank you for catching it.

> So let's simply inititalize them earlier, when the
> memory is added. We only have to take care of updating the zone once we
> know it. We can use a dummy zone for that purpose.
>
> So effectively, all pages will already be initialized and set to
> reserved after memory was added but before it was onlined (and even the
> memblock is added). We only inititalize pages once, to not degrade
> performance.

Yes, but we still add one more npages loop, so there will be some
performance degradation, but not severe.

There are many conflicts with linux-next, please sync before sending
out next patch.

> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1162,7 +1162,15 @@ static inline void set_page_address(struct page *page, void *address)
>  {
>         page->virtual = address;
>  }
> +static void set_page_virtual(struct page *page, and enum zone_type zone)
> +{
> +       /* The shift won't overflow because ZONE_NORMAL is below 4G. */
> +       if (!is_highmem_idx(zone))
> +               set_page_address(page, __va(pfn << PAGE_SHIFT));
> +}
>  #define page_address_init()  do { } while(0)
> +#else
> +#define set_page_virtual(page, zone)  do { } while(0)
>  #endif

Please use inline functions for both if WANT_PAGE_VIRTUAL case and else case.

>  #if defined(HASHED_PAGE_VIRTUAL)
> @@ -2116,6 +2124,8 @@ extern unsigned long find_min_pfn_with_active_regions(void);
>  extern void free_bootmem_with_active_regions(int nid,
>                                                 unsigned long max_low_pfn);
>  extern void sparse_memory_present_with_active_regions(int nid);
> +extern void __meminit init_single_page(struct page *page, unsigned long pfn,
> +                                      unsigned long zone, int nid);

I do not like making init_single_page() public. There is less chance
it is going to be inlined. I think a better way is to have a new
variant of memmap_init_zone that will handle hotplug case.

>
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7deb49f69e27..3f28ca3c3a33 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -250,6 +250,7 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
>                 struct vmem_altmap *altmap, bool want_memblock)
>  {
>         int ret;
> +       int i;
>
>         if (pfn_valid(phys_start_pfn))
>                 return -EEXIST;
> @@ -258,6 +259,23 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
>         if (ret < 0)
>                 return ret;
>
> +       /*
> +        * Initialize all pages in the section before fully exposing them to the
> +        * system so nobody will stumble over a half inititalized state.
> +        */
> +       for (i = 0; i < PAGES_PER_SECTION; i++) {
> +               unsigned long pfn = phys_start_pfn + i;
> +               struct page *page;
> +
> +               if (!pfn_valid(pfn))
> +                       continue;
> +               page = pfn_to_page(pfn);
> +
> +               /* dummy zone, the actual one will be set when onlining pages */
> +               init_single_page(page, pfn, ZONE_NORMAL, nid);
> +               SetPageReserved(page);
> +       }

Please move all of the above into a new memmap_init_hotplug() that
should be located in page_alloc.c


> @@ -5519,9 +5515,12 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>
>  not_early:
>                 page = pfn_to_page(pfn);
> -               __init_single_page(page, pfn, zone, nid);
> -               if (context == MEMMAP_HOTPLUG)
> -                       SetPageReserved(page);
> +               if (context == MEMMAP_HOTPLUG) {
> +                       /* everything but the zone was inititalized */
> +                       set_page_zone(page, zone);
> +                       set_page_virtual(page, zone);
> +               } else
> +                       init_single_page(page, pfn, zone, nid);
>

Please add a new function:
memmap_init_zone_hotplug() that will handle only the zone and virtual
fields for onlined hotplug memory.

Please remove: "enum memmap_context context" from everywhere.

Thank you,
Pavel
