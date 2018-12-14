Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE51C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F113A204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeLNTXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:23:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730405AbeLNTXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:23:24 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEJLdMZ020845
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:23:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pcftjfwvv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:23:23 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Fri, 14 Dec 2018 19:23:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 19:23:17 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEJNGHw3408186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 19:23:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD1B11C058;
        Fri, 14 Dec 2018 19:23:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567D911C050;
        Fri, 14 Dec 2018 19:23:16 +0000 (GMT)
Received: from thinkpad (unknown [9.145.44.24])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 19:23:16 +0000 (GMT)
Date:   Fri, 14 Dec 2018 20:23:15 +0100
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
In-Reply-To: <bcd0c49c-e417-ef8b-996f-99ecef540d9c@redhat.com>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
        <20181212172712.34019-2-zaslonko@linux.ibm.com>
        <476a80cb-5524-16c1-6dd5-da5febbd6139@redhat.com>
        <bcd0c49c-e417-ef8b-996f-99ecef540d9c@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18121419-4275-0000-0000-000002F0A52F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121419-4276-0000-0000-000037FDD6BD
Message-Id: <20181214202315.1c685f1e@thinkpad>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 16:49:14 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 14.12.18 16:22, David Hildenbrand wrote:
> > On 12.12.18 18:27, Mikhail Zaslonko wrote:  
> >> If memory end is not aligned with the sparse memory section boundary, the
> >> mapping of such a section is only partly initialized. This may lead to
> >> VM_BUG_ON due to uninitialized struct page access from
> >> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
> >> memory_hotplug sysfs handlers:
> >>
> >> Here are the the panic examples:
> >>  CONFIG_DEBUG_VM=y
> >>  CONFIG_DEBUG_VM_PGFLAGS=y
> >>
> >>  kernel parameter mem=2050M
> >>  --------------------------
> >>  page:000003d082008000 is uninitialized and poisoned
> >>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >>  Call Trace:
> >>  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
> >>   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
> >>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
> >>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
> >>   [<00000000003e4194>] seq_read+0x204/0x480
> >>   [<00000000003b53ea>] __vfs_read+0x32/0x178
> >>   [<00000000003b55b2>] vfs_read+0x82/0x138
> >>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
> >>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
> >>  Last Breaking-Event-Address:
> >>   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
> >>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> >>
> >>  kernel parameter mem=3075M
> >>  --------------------------
> >>  page:000003d08300c000 is uninitialized and poisoned
> >>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >>  Call Trace:
> >>  ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
> >>   [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
> >>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
> >>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
> >>   [<00000000003e4194>] seq_read+0x204/0x480
> >>   [<00000000003b53ea>] __vfs_read+0x32/0x178
> >>   [<00000000003b55b2>] vfs_read+0x82/0x138
> >>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
> >>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
> >>  Last Breaking-Event-Address:
> >>   [<000000000038596c>] is_mem_section_removable+0xb4/0x190
> >>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> >>
> >> Fix the problem by initializing the last memory section of each zone
> >> in memmap_init_zone() till the very end, even if it goes beyond the zone
> >> end.
> >>
> >> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> >> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>  mm/page_alloc.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 2ec9cc407216..e2afdb2dc2c5 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -5542,6 +5542,18 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >>  			cond_resched();
> >>  		}
> >>  	}
> >> +#ifdef CONFIG_SPARSEMEM
> >> +	/*
> >> +	 * If the zone does not span the rest of the section then
> >> +	 * we should at least initialize those pages. Otherwise we
> >> +	 * could blow up on a poisoned page in some paths which depend
> >> +	 * on full sections being initialized (e.g. memory hotplug).
> >> +	 */
> >> +	while (end_pfn % PAGES_PER_SECTION) {
> >> +		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
> >> +		end_pfn++;  
> > 
> > This page will not be marked as PG_reserved - although it is a physical
> > memory gap. Do we care?
> >   
> 
> Hm, or do we even have any idea what this is (e.g. could it also be
> something not a gap)?

In the "mem=" restriction scenario it would be a gap, and probably fall
into the PG_reserved categorization from your recent patch:
 * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
 *   to read/write these pages might end badly. Don't touch!

Not sure if it could be something else. In theory, if it is possible to have
a scenario where memory zones are not section-aligned, then this
end_pfn % PAGES_PER_SECTION part could be part of another zone. But then it
should not matter if the pages get pre-initialized here, with or w/o
PG_reseved, because they should later be properly initialized in their zone.

So marking them as PG_reserved sounds right, especially in the light of your
current PG_reserved clean-up.

> 
> For physical memory gaps within a section, architectures usually exclude
> that memory from getting passed to e.g. the page allocator by
> memblock_reserve().
> 
> Before handing all free pages to the page allocator, all such reserved
> memblocks will be marked reserved.
> 
> But this here seems to be different. We don't have a previous
> memblock_reserve(), because otherwise these pages would have properly
> been initialized already when marking them reserved.

Not sure how memblock_reserve() and struct page initialization are
related, but at least on s390 there is a memblock_reserve() on the range
in question in setup_arch() -> reserve_memory_end(). However, in this
"mem=" scenario, the range is also removed later with memblock_remove()
in setup_memory_end(), because it is beyond memory_end.

