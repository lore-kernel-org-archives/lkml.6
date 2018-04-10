Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836988-1523365761-2-8100971292523252371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523365761; b=G8/u7nWgADC6jSeoTutynSghXyHCHi3utRhlq7JM1yur7ZP7jW
    F5My+OfM6OFX4uJ5/7qSb2tFjB1RGSJ84VD/9ybFlQL3ZZi+QMZ49kHznljGwhvY
    UqZpu6HnGEpD+fnKdBjmAIPl4dfIq3YrN9X/uhr/Tl1YG4h6BPYO4Y1BswncT6e1
    QTBWXIn6lQ5SsgHMQWe4v9Dnj8YCNGHZE8vXSwseNvSY8GcN5vMmEIC1A9oKtMfW
    ogOcICED9O+zUZYssPbXqaAi00gI3W2mpwDbRpTJxXeZ3B9++hnPi4xsp3MU6lh+
    RYpfdCdRSvLtizhuo3X921oKYjCiJtaq1dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523365761; bh=LjE1X8Hjrk9DC0HKugcaLKOnv/rdH0
    1qMKmDlfYP2Qo=; b=TGFW8Rlspku74aCOSW5OG/qvxwMMUCIxB4YWo8Zf9rT2A3
    4Vvbi4w7zP7qhGt+qjly5aIehtAmM5Az6fMK7Q/c+LP1yR57oB7R5REHgO1qAxFH
    lrM+U2UAcJ93I+GXVYSfZxeRoyLSMLqgngIf1WqE/y7Kmwp5APHt54akX7iu8EO+
    4nkrMMVQls2/r8bdA60afyA8CBBIGV60DlDqQFVBfh04zGZoKURhAGFYBGnFtB0G
    PagbaQwP5MD6H3+JkTrRvmltMwulrFHb9Ymo4ygjuuB5B/ac6u7VDLtW2pBl8zuz
    l2I+WrTk4LCeE0n5AQO5Pch6PO6U4thxpqcr68Yg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGhheAe2/wxhTHFV2giWRN/blmcekqJYPlW+twct46J6BBv7XvwAMyYXlSMz4g6uiqAYjHxqjXvWHIBwsy0GYHMRk/wkYWeovws91YbLh25iN8Plxz4w
    P7RDCM2oh51Eiwlel4ib/RcM3nsZ1UAOglHC+XzxoMb3w66ZSg99Tvd+u0CfyEbMa9Rys3Ar/zD5IR5oK2OyWIqE1oXevyUICXUwFPOys5qjQvx3MEViwciY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Cb-ZYbnvyzChmF_QQssA:9
    a=mee9lrOWgqtSaTtF:21 a=xOiJwVtKnCH0oj9d:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDJNJS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:09:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:47068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbeDJNJS (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:09:18 -0400
Date: Tue, 10 Apr 2018 15:09:16 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] page cache: Mask off unwanted GFP flags
Message-ID: <20180410130916.GN21835@dhcp22.suse.cz>
References: <20180410125351.15837-1-willy@infradead.org>
 <20180410125351.15837-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125351.15837-2-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 10-04-18 05:53:51, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The page cache has used the mapping's GFP flags for allocating
> radix tree nodes for a long time.  It took care to always mask off the
> __GFP_HIGHMEM flag, and masked off other flags in other paths, but the
> __GFP_ZERO flag was still able to sneak through.  The __GFP_DMA and
> __GFP_DMA32 flags would also have been able to sneak through if they
> were ever used.  Fix them all by using GFP_RECLAIM_MASK at the innermost
> location, and remove it from earlier in the callchain.
> 
> Fixes: 19f99cee206c ("f2fs: add core inode operations")
> Reported-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@vger.kernel.org

I would push this into __radix_tree_preload...
Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/filemap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c2147682f4c3..1a4bfc5ed3dc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -785,7 +785,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
>  	VM_BUG_ON_PAGE(!PageLocked(new), new);
>  	VM_BUG_ON_PAGE(new->mapping, new);
>  
> -	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
> +	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
>  	if (!error) {
>  		struct address_space *mapping = old->mapping;
>  		void (*freepage)(struct page *);
> @@ -841,7 +841,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  			return error;
>  	}
>  
> -	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
> +	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
>  	if (error) {
>  		if (!huge)
>  			mem_cgroup_cancel_charge(page, memcg, false);
> @@ -1574,8 +1574,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  		if (fgp_flags & FGP_ACCESSED)
>  			__SetPageReferenced(page);
>  
> -		err = add_to_page_cache_lru(page, mapping, offset,
> -				gfp_mask & GFP_RECLAIM_MASK);
> +		err = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
>  		if (unlikely(err)) {
>  			put_page(page);
>  			page = NULL;
> @@ -2378,7 +2377,7 @@ static int page_cache_read(struct file *file, pgoff_t offset, gfp_t gfp_mask)
>  		if (!page)
>  			return -ENOMEM;
>  
> -		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask & GFP_KERNEL);
> +		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
>  		if (ret == 0)
>  			ret = mapping->a_ops->readpage(file, page);
>  		else if (ret == -EEXIST)
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
