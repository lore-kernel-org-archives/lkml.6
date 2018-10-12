Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE602C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8862A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOpoXENZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8862A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeJLSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:39:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44438 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJLSja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:39:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so5689692pgu.11;
        Fri, 12 Oct 2018 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PfRVg9bkslElvRjN+WwJ6XVt+xZWxED6ICTWbAZDClI=;
        b=LOpoXENZJParfoq1ObZuxmkctFyiheM80mxYdFRAd0OvjKil2mkBSy6dvKmtDfoccx
         ZNKIvfTgGhVFfRo6n/bOrrfDDZUMsOezjnsQAmsSyuaFxLSSHaCfHHCqi+bRDAbV6rAL
         ZIfRpx0CUEcLB0gfqoF7fTSTYVc8hs066acmpdMGHahi/zdauKQK8v+fnYo/WK712Ii4
         +T6+hZA7tp99LlrSGxpph5RJ1BYJi7vYVJRfDr+7KPp2kROE+GnvNXIJ/+JPAlg+6a37
         GQDw0BPXaTLdl04uI3emBL/gQpixUia7akLpUHvh+igWnvkUP1Ay6kz2TqUd1aPDmWms
         MqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PfRVg9bkslElvRjN+WwJ6XVt+xZWxED6ICTWbAZDClI=;
        b=f1NH+G2VnjTMEZbP3T1GftQwrmDFeWTJhK5YeMIH81Moitb+GDekLavNuat9ajXzMg
         4HiZqEpjNohHbSdEJHkMAloa24Vpm8j3K3XE88ARzXSmYJ8ByKINs5rYwwbgrvb0XuEU
         r+sXI0OhE9LVbJNt1C/z1y9ghhEIMDOP4pdRftw41xqwVz1f9UkPozMRipB962sJD0GO
         mamf8TOvlMdgXaMBRWsAfNZynUoakXsHN7Mi5WMKlL1cig8QbQk50Ui5k7JFPBj0zGpH
         lSu9CzfhPBHZzuqFb2i3MrYDbc6XHwNjoc+0uDnsrApjkT4sNcQTEjrnKjtL9Hs1lSlz
         QheA==
X-Gm-Message-State: ABuFfojJSudN4WsNrfPhXibK9T40APFG8VcgLLbjxim0zHkKgbNI0csE
        j3kv18ReZZGqmR/ZQv37VXg=
X-Google-Smtp-Source: ACcGV63s8/2fpWu6A27C3sQekvGJY+VwpIAjbEHGvbnXMdCz25acx8TpQDAnF+RjakCy//faXVaNlg==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr5114266pgu.260.1539342454407;
        Fri, 12 Oct 2018 04:07:34 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id a11-v6sm1608831pfn.66.2018.10.12.04.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:07:32 -0700 (PDT)
Date:   Fri, 12 Oct 2018 22:07:28 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm: track gup pages with page->dma_pinned_* fields
Message-ID: <20181012110728.GL8537@350D>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012060014.10242-7-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:00:14PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This patch sets and restores the new page->dma_pinned_flags and
> page->dma_pinned_count fields, but does not actually use them for
> anything yet.
> 
> In order to use these fields at all, the page must be removed from
> any LRU list that it's on. The patch also adds some precautions that
> prevent the page from getting moved back onto an LRU, once it is
> in this state.
> 
> This is in preparation to fix some problems that came up when using
> devices (NICs, GPUs, for example) that set up direct access to a chunk
> of system (CPU) memory, so that they can DMA to/from that memory.
> 
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Jan Kara <jack@suse.cz>
> CC: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 15 ++-----------
>  mm/gup.c           | 56 ++++++++++++++++++++++++++++++++++++++++++++--
>  mm/memcontrol.c    |  7 ++++++
>  mm/swap.c          | 51 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 76d18aada9f8..44878d21e27b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -944,21 +944,10 @@ static inline void put_page(struct page *page)
>  }
>  
>  /*
> - * put_user_page() - release a page that had previously been acquired via
> - * a call to one of the get_user_pages*() functions.
> - *
>   * Pages that were pinned via get_user_pages*() must be released via
> - * either put_user_page(), or one of the put_user_pages*() routines
> - * below. This is so that eventually, pages that are pinned via
> - * get_user_pages*() can be separately tracked and uniquely handled. In
> - * particular, interactions with RDMA and filesystems need special
> - * handling.
> + * one of these put_user_pages*() routines:
>   */
> -static inline void put_user_page(struct page *page)
> -{
> -	put_page(page);
> -}
> -
> +void put_user_page(struct page *page);
>  void put_user_pages_dirty(struct page **pages, unsigned long npages);
>  void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
>  void put_user_pages(struct page **pages, unsigned long npages);
> diff --git a/mm/gup.c b/mm/gup.c
> index 05ee7c18e59a..fddbc30cde89 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -20,6 +20,51 @@
>  
>  #include "internal.h"
>  
> +static int pin_page_for_dma(struct page *page)
> +{
> +	int ret = 0;
> +	struct zone *zone;
> +
> +	page = compound_head(page);
> +	zone = page_zone(page);
> +
> +	spin_lock(zone_gup_lock(zone));
> +
> +	if (PageDmaPinned(page)) {
> +		/* Page was not on an LRU list, because it was DMA-pinned. */
> +		VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +		atomic_inc(&page->dma_pinned_count);
> +		goto unlock_out;
> +	}
> +
> +	/*
> +	 * Note that page->dma_pinned_flags is unioned with page->lru.
> +	 * Therefore, the rules are: checking if any of the
> +	 * PAGE_DMA_PINNED_FLAGS bits are set may be done while page->lru
> +	 * is in use. However, setting those flags requires that
> +	 * the page is both locked, and also, removed from the LRU.
> +	 */
> +	ret = isolate_lru_page(page);
> +

isolate_lru_page() can be expensive and in terms of the overall locking order
sounds like zone_gup_lock is higher in the hierarchy than the locks taken
inside isolate_lru_page()

> +	if (ret == 0) {
> +		/* Avoid problems later, when freeing the page: */
> +		ClearPageActive(page);
> +		ClearPageUnevictable(page);
> +
> +		/* counteract isolate_lru_page's effects: */
> +		put_page(page);

Can the page get reaped here? What's the expected page count?

> +
> +		atomic_set(&page->dma_pinned_count, 1);
> +		SetPageDmaPinned(page);
> +	}
> +
> +unlock_out:
> +	spin_unlock(zone_gup_lock(zone));
> +
> +	return ret;
> +}
> +
>  static struct page *no_page_table(struct vm_area_struct *vma,
>  		unsigned int flags)
>  {
> @@ -659,7 +704,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		unsigned int gup_flags, struct page **pages,
>  		struct vm_area_struct **vmas, int *nonblocking)
>  {
> -	long i = 0;
> +	long i = 0, j;
>  	int err = 0;
>  	unsigned int page_mask;
>  	struct vm_area_struct *vma = NULL;
> @@ -764,6 +809,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  	} while (nr_pages);
>  
>  out:
> +	if (pages)
> +		for (j = 0; j < i; j++)
> +			pin_page_for_dma(pages[j]);
> +

Why does get_user_pages() unconditionally pin_page_for_dma?

>  	return i ? i : err;
>  }
>  
> @@ -1841,7 +1890,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  			struct page **pages)
>  {
>  	unsigned long addr, len, end;
> -	int nr = 0, ret = 0;
> +	int nr = 0, ret = 0, i;
>  
>  	start &= PAGE_MASK;
>  	addr = start;
> @@ -1862,6 +1911,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  		ret = nr;
>  	}
>  
> +	for (i = 0; i < nr; i++)
> +		pin_page_for_dma(pages[i]);

Why does get_user_pages_fast() unconditionally pin_page_for_dma?

> +
>  	if (nr < nr_pages) {
>  		/* Try to get the remaining pages with get_user_pages */
>  		start += nr << PAGE_SHIFT;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e79cb59552d9..af9719756081 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2335,6 +2335,11 @@ static void lock_page_lru(struct page *page, int *isolated)
>  	if (PageLRU(page)) {
>  		struct lruvec *lruvec;
>  
> +		/* LRU and PageDmaPinned are mutually exclusive: they use the
> +		 * same fields in struct page, but for different purposes.
> +		 */

Comment style needs fixing

> +		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
> +
>  		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
>  		ClearPageLRU(page);
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
> @@ -2352,6 +2357,8 @@ static void unlock_page_lru(struct page *page, int isolated)
>  
>  		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		VM_BUG_ON_PAGE(PageDmaPinned(page), page);
> +
>  		SetPageLRU(page);
>  		add_page_to_lru_list(page, lruvec, page_lru(page));
>  	}
> diff --git a/mm/swap.c b/mm/swap.c
> index efab3a6b6f91..6b2b1a958a67 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -134,6 +134,46 @@ void put_pages_list(struct list_head *pages)
>  }
>  EXPORT_SYMBOL(put_pages_list);
>  
> +/*
> + * put_user_page() - release a page that had previously been acquired via
> + * a call to one of the get_user_pages*() functions.
> + *
> + * Pages that were pinned via get_user_pages*() must be released via
> + * either put_user_page(), or one of the put_user_pages*() routines
> + * below. This is so that eventually, pages that are pinned via
> + * get_user_pages*() can be separately tracked and uniquely handled. In
> + * particular, interactions with RDMA and filesystems need special
> + * handling.
> + */
> +void put_user_page(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +
> +	page = compound_head(page);
> +
> +	VM_BUG_ON_PAGE(PageLRU(page), page);
> +	VM_BUG_ON_PAGE(!PageDmaPinned(page), page);
> +
> +	if (atomic_dec_and_test(&page->dma_pinned_count)) {
> +		spin_lock(zone_gup_lock(zone));
> +
> +		/* Re-check while holding the lock, because
> +		 * pin_page_for_dma() or get_page() may have snuck in right
> +		 * after the atomic_dec_and_test, and raised the count
> +		 * above zero again. If so, just leave the flag set. And
> +		 * because the atomic_dec_and_test above already got the
> +		 * accounting correct, no other action is required.
> +		 */
> +		if (atomic_read(&page->dma_pinned_count) == 0)
> +			ClearPageDmaPinned(page);
> +
> +		spin_unlock(zone_gup_lock(zone));
> +	}
> +
> +	put_page(page);
> +}
> +EXPORT_SYMBOL(put_user_page);
> +
>  /*
>   * put_user_pages_dirty() - for each page in the @pages array, make
>   * that page (or its head page, if a compound page) dirty, if it was
> @@ -907,6 +947,11 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>  	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
>  	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> +
> +	/* LRU and PageDmaPinned are mutually exclusive: they use the
> +	 * same fields in struct page, but for different purposes.
> +	 */
> +	VM_BUG_ON_PAGE(PageDmaPinned(page_tail), page);
>  	VM_BUG_ON(NR_CPUS != 1 &&
>  		  !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
>  
> @@ -946,6 +991,12 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> +	/* LRU and PageDmaPinned are mutually exclusive: they use the
> +	 * same fields in struct page, but for different purposes.
> +	 */
> +	if (PageDmaPinned(page))
> +		return;
> +
>  	SetPageLRU(page);
>  	/*
>  	 * Page becomes evictable in two ways:
> -- 
> 2.19.1


Balbir
