Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B87217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLRHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:55:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbeLRHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:55:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI7sIh6051690
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:55:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pev5j21ue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:55:47 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 18 Dec 2018 07:55:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 07:55:41 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI7te5q33620004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 07:55:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87C4AA4062;
        Tue, 18 Dec 2018 07:55:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A655A405F;
        Tue, 18 Dec 2018 07:55:40 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Dec 2018 07:55:40 +0000 (GMT)
Date:   Tue, 18 Dec 2018 08:55:38 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [-next] lots of messages due to "mm, memory_hotplug: be more
 verbose for memory offline failures"
References: <20181217155922.GC3560@osiris>
 <20181217160350.GV30879@dhcp22.suse.cz>
 <20181217163949.GX30879@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20181217163949.GX30879@dhcp22.suse.cz>
X-TM-AS-GCONF: 00
x-cbid: 18121807-0008-0000-0000-000002A2E6C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121807-0009-0000-0000-0000220D78D2
Message-Id: <20181218075538.GA3590@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:39:49PM +0100, Michal Hocko wrote:
> On Mon 17-12-18 17:03:50, Michal Hocko wrote:
> > On Mon 17-12-18 16:59:22, Heiko Carstens wrote:
> > > Hi Michal,
> > > 
> > > with linux-next as of today on s390 I see tons of messages like
> > > 
> > > [   20.536664] page dumped because: has_unmovable_pages
> > > [   20.536792] page:000003d081ff4080 count:1 mapcount:0 mapping:000000008ff88600 index:0x0 compound_mapcount: 0
> > > [   20.536794] flags: 0x3fffe0000010200(slab|head)
> > > [   20.536795] raw: 03fffe0000010200 0000000000000100 0000000000000200 000000008ff88600
> > > [   20.536796] raw: 0000000000000000 0020004100000000 ffffffff00000001 0000000000000000
> > > [   20.536797] page dumped because: has_unmovable_pages
> > > [   20.536814] page:000003d0823b0000 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> > > [   20.536815] flags: 0x7fffe0000000000()
> > > [   20.536817] raw: 07fffe0000000000 0000000000000100 0000000000000200 0000000000000000
> > > [   20.536818] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> > > 
> > > bisect points to b323c049a999 ("mm, memory_hotplug: be more verbose for memory offline failures")
> > > which is the first commit with which the messages appear.
> > 
> > I would bet this is CMA allocator. How much is tons? Maybe we want a
> > rate limit or the other user is not really interested in them at all?

Yes, the system in question has a 4NB CMA area. "tons" translates to several hundred.

> In other words, this should silence those messages.

Yes, with the patch below applied the messages don't appear anymore.

> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 4ae347cbc36d..4eb26d278046 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -30,8 +30,11 @@ static inline bool is_migrate_isolate(int migratetype)
>  }
>  #endif
> 
> +#define SKIP_HWPOISON	0x1
> +#define REPORT_FAILURE	0x2
> +
>  bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> -			 int migratetype, bool skip_hwpoisoned_pages);
> +			 int migratetype, int flags);
>  void set_pageblock_migratetype(struct page *page, int migratetype);
>  int move_freepages_block(struct zone *zone, struct page *page,
>  				int migratetype, int *num_movable);
> @@ -44,10 +47,14 @@ int move_freepages_block(struct zone *zone, struct page *page,
>   * For isolating all pages in the range finally, the caller have to
>   * free all pages in the range. test_page_isolated() can be used for
>   * test it.
> + *
> + * The following flags are allowed (they can be combined in a bit mask)
> + * SKIP_HWPOISON - ignore hwpoison pages
> + * REPORT_FAILURE - report details about the failure to isolate the range
>   */
>  int
>  start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> -			 unsigned migratetype, bool skip_hwpoisoned_pages);
> +			 unsigned migratetype, int flags);
> 
>  /*
>   * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c82193db4be6..8537429d33a6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1226,7 +1226,7 @@ static bool is_pageblock_removable_nolock(struct page *page)
>  	if (!zone_spans_pfn(zone, pfn))
>  		return false;
> 
> -	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
> +	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, SKIP_HWPOISON);
>  }
> 
>  /* Checks if this range of memory is likely to be hot-removable. */
> @@ -1577,7 +1577,8 @@ static int __ref __offline_pages(unsigned long start_pfn,
> 
>  	/* set above range as isolated */
>  	ret = start_isolate_page_range(start_pfn, end_pfn,
> -				       MIGRATE_MOVABLE, true);
> +				       MIGRATE_MOVABLE,
> +				       SKIP_HWPOISON | REPORT_FAILURE);
>  	if (ret) {
>  		mem_hotplug_done();
>  		reason = "failure to isolate range";
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ec2c7916dc2d..ee4043419791 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7754,8 +7754,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>   * race condition. So you can't expect this function should be exact.
>   */
>  bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> -			 int migratetype,
> -			 bool skip_hwpoisoned_pages)
> +			 int migratetype, int flags)
>  {
>  	unsigned long pfn, iter, found;
> 
> @@ -7818,7 +7817,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * The HWPoisoned page may be not in buddy system, and
>  		 * page_count() is not 0.
>  		 */
> -		if (skip_hwpoisoned_pages && PageHWPoison(page))
> +		if ((flags & SKIP_HWPOISON) && PageHWPoison(page))
>  			continue;
> 
>  		if (__PageMovable(page))
> @@ -7845,7 +7844,8 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	return false;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	dump_page(pfn_to_page(pfn+iter), "unmovable page");
> +	if (flags & REPORT_FAILURE)
> +		dump_page(pfn_to_page(pfn+iter), "unmovable page");
>  	return true;
>  }
> 
> @@ -7972,8 +7972,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 */
> 
>  	ret = start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype,
> -				       false);
> +				       pfn_max_align_up(end), migratetype, 0);
>  	if (ret)
>  		return ret;
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 43e085608846..ce323e56b34d 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -15,8 +15,7 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/page_isolation.h>
> 
> -static int set_migratetype_isolate(struct page *page, int migratetype,
> -				bool skip_hwpoisoned_pages)
> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>  {
>  	struct zone *zone;
>  	unsigned long flags, pfn;
> @@ -60,8 +59,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype,
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>  	 * We just check MOVABLE pages.
>  	 */
> -	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
> -				 skip_hwpoisoned_pages))
> +	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
>  		ret = 0;
> 
>  	/*
> @@ -185,7 +183,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * prevents two threads from simultaneously working on overlapping ranges.
>   */
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> -			     unsigned migratetype, bool skip_hwpoisoned_pages)
> +			     unsigned migratetype, int flags)
>  {
>  	unsigned long pfn;
>  	unsigned long undo_pfn;
> @@ -199,7 +197,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	     pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
>  		if (page &&
> -		    set_migratetype_isolate(page, migratetype, skip_hwpoisoned_pages)) {
> +		    set_migratetype_isolate(page, migratetype, flags)) {
>  			undo_pfn = pfn;
>  			goto undo;
>  		}
> -- 
> Michal Hocko
> SUSE Labs
> 

