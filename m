Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DEEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC232245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC232245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbeKNAvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:51:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731328AbeKNAvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:51:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51FCF80466;
        Tue, 13 Nov 2018 14:52:47 +0000 (UTC)
Received: from [10.36.116.155] (ovpn-116-155.ams2.redhat.com [10.36.116.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150AF1001938;
        Tue, 13 Nov 2018 14:52:43 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] mm: reference totalram_pages and managed_pages
 once per function
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org, willy@infradead.org
References: <1542090790-21750-1-git-send-email-arunks@codeaurora.org>
 <1542090790-21750-2-git-send-email-arunks@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <41af26ed-74a9-b5b4-bb73-867493f72d24@redhat.com>
Date:   Tue, 13 Nov 2018 15:52:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542090790-21750-2-git-send-email-arunks@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 13 Nov 2018 14:52:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.18 07:33, Arun KS wrote:
> This patch is in preparation to a later patch which converts totalram_pages
> and zone->managed_pages to atomic variables. Please note that re-reading
> the value might lead to a different value and as such it could lead to
> unexpected behavior. There are no known bugs as a result of the current code
> but it is better to prevent from them in principle.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  arch/um/kernel/mem.c                 |  2 +-
>  arch/x86/kernel/cpu/microcode/core.c |  5 +++--
>  drivers/hv/hv_balloon.c              | 19 ++++++++++---------
>  fs/file_table.c                      |  7 ++++---
>  kernel/fork.c                        |  5 +++--
>  kernel/kexec_core.c                  |  5 +++--
>  mm/page_alloc.c                      |  5 +++--
>  mm/shmem.c                           |  3 ++-
>  net/dccp/proto.c                     |  7 ++++---
>  net/netfilter/nf_conntrack_core.c    |  7 ++++---
>  net/netfilter/xt_hashlimit.c         |  5 +++--
>  net/sctp/protocol.c                  |  7 ++++---
>  12 files changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 1067469..2da2096 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -52,7 +52,7 @@ void __init mem_init(void)
>  	/* this will put all low memory onto the freelists */
>  	memblock_free_all();
>  	max_low_pfn = totalram_pages;
> -	max_pfn = totalram_pages;
> +	max_pfn = max_low_pfn;
>  	mem_init_print_info(NULL);
>  	kmalloc_ok = 1;
>  }
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 2637ff0..168fa27 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -434,9 +434,10 @@ static ssize_t microcode_write(struct file *file, const char __user *buf,
>  			       size_t len, loff_t *ppos)
>  {
>  	ssize_t ret = -EINVAL;
> +	unsigned long nr_pages = totalram_pages;
>  
> -	if ((len >> PAGE_SHIFT) > totalram_pages) {
> -		pr_err("too much data (max %ld pages)\n", totalram_pages);
> +	if ((len >> PAGE_SHIFT) > nr_pages) {
> +		pr_err("too much data (max %ld pages)\n", nr_pages);
>  		return ret;
>  	}
>  
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 4163151..f3e7da9 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1090,6 +1090,7 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
>  static unsigned long compute_balloon_floor(void)
>  {
>  	unsigned long min_pages;
> +	unsigned long nr_pages = totalram_pages;
>  #define MB2PAGES(mb) ((mb) << (20 - PAGE_SHIFT))
>  	/* Simple continuous piecewiese linear function:
>  	 *  max MiB -> min MiB  gradient
> @@ -1102,16 +1103,16 @@ static unsigned long compute_balloon_floor(void)
>  	 *    8192       744    (1/16)
>  	 *   32768      1512	(1/32)
>  	 */
> -	if (totalram_pages < MB2PAGES(128))
> -		min_pages = MB2PAGES(8) + (totalram_pages >> 1);
> -	else if (totalram_pages < MB2PAGES(512))
> -		min_pages = MB2PAGES(40) + (totalram_pages >> 2);
> -	else if (totalram_pages < MB2PAGES(2048))
> -		min_pages = MB2PAGES(104) + (totalram_pages >> 3);
> -	else if (totalram_pages < MB2PAGES(8192))
> -		min_pages = MB2PAGES(232) + (totalram_pages >> 4);
> +	if (nr_pages < MB2PAGES(128))
> +		min_pages = MB2PAGES(8) + (nr_pages >> 1);
> +	else if (nr_pages < MB2PAGES(512))
> +		min_pages = MB2PAGES(40) + (nr_pages >> 2);
> +	else if (nr_pages < MB2PAGES(2048))
> +		min_pages = MB2PAGES(104) + (nr_pages >> 3);
> +	else if (nr_pages < MB2PAGES(8192))
> +		min_pages = MB2PAGES(232) + (nr_pages >> 4);
>  	else
> -		min_pages = MB2PAGES(488) + (totalram_pages >> 5);
> +		min_pages = MB2PAGES(488) + (nr_pages >> 5);
>  #undef MB2PAGES
>  	return min_pages;
>  }
> diff --git a/fs/file_table.c b/fs/file_table.c
> index e49af4c..b6e9587 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -380,10 +380,11 @@ void __init files_init(void)
>  void __init files_maxfiles_init(void)
>  {
>  	unsigned long n;
> -	unsigned long memreserve = (totalram_pages - nr_free_pages()) * 3/2;
> +	unsigned long nr_pages = totalram_pages;
> +	unsigned long memreserve = (nr_pages - nr_free_pages()) * 3/2;
>  
> -	memreserve = min(memreserve, totalram_pages - 1);
> -	n = ((totalram_pages - memreserve) * (PAGE_SIZE / 1024)) / 10;
> +	memreserve = min(memreserve, nr_pages - 1);
> +	n = ((nr_pages - memreserve) * (PAGE_SIZE / 1024)) / 10;
>  
>  	files_stat.max_files = max_t(unsigned long, n, NR_FILE);
>  }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff..58422c5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -739,15 +739,16 @@ void __init __weak arch_task_cache_init(void) { }
>  static void set_max_threads(unsigned int max_threads_suggested)
>  {
>  	u64 threads;
> +	unsigned long nr_pages = totalram_pages;
>  
>  	/*
>  	 * The number of threads shall be limited such that the thread
>  	 * structures may only consume a small part of the available memory.
>  	 */
> -	if (fls64(totalram_pages) + fls64(PAGE_SIZE) > 64)
> +	if (fls64(nr_pages) + fls64(PAGE_SIZE) > 64)
>  		threads = MAX_THREADS;
>  	else
> -		threads = div64_u64((u64) totalram_pages * (u64) PAGE_SIZE,
> +		threads = div64_u64((u64) nr_pages * (u64) PAGE_SIZE,
>  				    (u64) THREAD_SIZE * 8UL);
>  
>  	if (threads > max_threads_suggested)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 86ef06d..7e967ca 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -152,6 +152,7 @@ int sanity_check_segment_list(struct kimage *image)
>  	int i;
>  	unsigned long nr_segments = image->nr_segments;
>  	unsigned long total_pages = 0;
> +	unsigned long nr_pages = totalram_pages;
>  
>  	/*
>  	 * Verify we have good destination addresses.  The caller is
> @@ -217,13 +218,13 @@ int sanity_check_segment_list(struct kimage *image)
>  	 * wasted allocating pages, which can cause a soft lockup.
>  	 */
>  	for (i = 0; i < nr_segments; i++) {
> -		if (PAGE_COUNT(image->segment[i].memsz) > totalram_pages / 2)
> +		if (PAGE_COUNT(image->segment[i].memsz) > nr_pages / 2)
>  			return -EINVAL;
>  
>  		total_pages += PAGE_COUNT(image->segment[i].memsz);
>  	}
>  
> -	if (total_pages > totalram_pages / 2)
> +	if (total_pages > nr_pages / 2)
>  		return -EINVAL;
>  
>  	/*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a919ba5..173312b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7245,6 +7245,7 @@ static void calculate_totalreserve_pages(void)
>  		for (i = 0; i < MAX_NR_ZONES; i++) {
>  			struct zone *zone = pgdat->node_zones + i;
>  			long max = 0;
> +			unsigned long managed_pages = zone->managed_pages;
>  
>  			/* Find valid and maximum lowmem_reserve in the zone */
>  			for (j = i; j < MAX_NR_ZONES; j++) {
> @@ -7255,8 +7256,8 @@ static void calculate_totalreserve_pages(void)
>  			/* we treat the high watermark as reserved pages. */
>  			max += high_wmark_pages(zone);
>  
> -			if (max > zone->managed_pages)
> -				max = zone->managed_pages;
> +			if (max > managed_pages)
> +				max = managed_pages;
>  
>  			pgdat->totalreserve_pages += max;
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ea26d7a..ccc08ea 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -114,7 +114,8 @@ static unsigned long shmem_default_max_blocks(void)
>  
>  static unsigned long shmem_default_max_inodes(void)
>  {
> -	return min(totalram_pages - totalhigh_pages, totalram_pages / 2);
> +	unsigned long nr_pages = totalram_pages;
> +	return min(nr_pages - totalhigh_pages, nr_pages / 2);
>  }
>  #endif
>  
> diff --git a/net/dccp/proto.c b/net/dccp/proto.c
> index 43733ac..4687960 100644
> --- a/net/dccp/proto.c
> +++ b/net/dccp/proto.c
> @@ -1131,6 +1131,7 @@ static inline void dccp_mib_exit(void)
>  static int __init dccp_init(void)
>  {
>  	unsigned long goal;
> +	unsigned long nr_pages = totalram_pages;
>  	int ehash_order, bhash_order, i;
>  	int rc;
>  
> @@ -1154,10 +1155,10 @@ static int __init dccp_init(void)
>  	 *
>  	 * The methodology is similar to that of the buffer cache.
>  	 */
> -	if (totalram_pages >= (128 * 1024))
> -		goal = totalram_pages >> (21 - PAGE_SHIFT);
> +	if (nr_pages >= (128 * 1024))
> +		goal = nr_pages >> (21 - PAGE_SHIFT);
>  	else
> -		goal = totalram_pages >> (23 - PAGE_SHIFT);
> +		goal = nr_pages >> (23 - PAGE_SHIFT);
>  
>  	if (thash_entries)
>  		goal = (thash_entries *
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> index e92e749..0480866 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -2251,6 +2251,7 @@ static __always_inline unsigned int total_extension_size(void)
>  
>  int nf_conntrack_init_start(void)
>  {
> +	unsigned long nr_pages = totalram_pages;
>  	int max_factor = 8;
>  	int ret = -ENOMEM;
>  	int i;
> @@ -2270,11 +2271,11 @@ int nf_conntrack_init_start(void)
>  		 * >= 4GB machines have 65536 buckets.
>  		 */
>  		nf_conntrack_htable_size
> -			= (((totalram_pages << PAGE_SHIFT) / 16384)
> +			= (((nr_pages << PAGE_SHIFT) / 16384)
>  			   / sizeof(struct hlist_head));
> -		if (totalram_pages > (4 * (1024 * 1024 * 1024 / PAGE_SIZE)))
> +		if (nr_pages > (4 * (1024 * 1024 * 1024 / PAGE_SIZE)))
>  			nf_conntrack_htable_size = 65536;
> -		else if (totalram_pages > (1024 * 1024 * 1024 / PAGE_SIZE))
> +		else if (nr_pages > (1024 * 1024 * 1024 / PAGE_SIZE))
>  			nf_conntrack_htable_size = 16384;
>  		if (nf_conntrack_htable_size < 32)
>  			nf_conntrack_htable_size = 32;
> diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
> index 3e7d259..9e7f9a3 100644
> --- a/net/netfilter/xt_hashlimit.c
> +++ b/net/netfilter/xt_hashlimit.c
> @@ -274,14 +274,15 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
>  	struct xt_hashlimit_htable *hinfo;
>  	const struct seq_operations *ops;
>  	unsigned int size, i;
> +	unsigned long nr_pages = totalram_pages;
>  	int ret;
>  
>  	if (cfg->size) {
>  		size = cfg->size;
>  	} else {
> -		size = (totalram_pages << PAGE_SHIFT) / 16384 /
> +		size = (nr_pages << PAGE_SHIFT) / 16384 /
>  		       sizeof(struct hlist_head);
> -		if (totalram_pages > 1024 * 1024 * 1024 / PAGE_SIZE)
> +		if (nr_pages > 1024 * 1024 * 1024 / PAGE_SIZE)
>  			size = 8192;
>  		if (size < 16)
>  			size = 16;
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 9b277bd..a5b2418 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1368,6 +1368,7 @@ static __init int sctp_init(void)
>  	int status = -EINVAL;
>  	unsigned long goal;
>  	unsigned long limit;
> +	unsigned long nr_pages = totalram_pages;
>  	int max_share;
>  	int order;
>  	int num_entries;
> @@ -1426,10 +1427,10 @@ static __init int sctp_init(void)
>  	 * The methodology is similar to that of the tcp hash tables.
>  	 * Though not identical.  Start by getting a goal size
>  	 */
> -	if (totalram_pages >= (128 * 1024))
> -		goal = totalram_pages >> (22 - PAGE_SHIFT);
> +	if (nr_pages >= (128 * 1024))
> +		goal = nr_pages >> (22 - PAGE_SHIFT);
>  	else
> -		goal = totalram_pages >> (24 - PAGE_SHIFT);
> +		goal = nr_pages >> (24 - PAGE_SHIFT);
>  
>  	/* Then compute the page order for said goal */
>  	order = get_order(goal);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
