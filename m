Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368013-2-14233500369577908550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523368012; b=A6M59U0v1auHSN2cBmPGZpGSDfCemDVUeD91p95/qyZJcVAn4S
    Itfg0f26kB8dC39qPmBgMZJzwLNptTYqlJvkRWgoMqiPRfym43DM4zCyjpa4C+5D
    IWlhUYHqYTXa/xo4SkHlIv5PUF4Hthr7VQWcpm707cAxuLhdcAX2p4iagxlumBwj
    8rtZDNSyz3bM8R/3xIbTqgqfZcvULNxgZ+PXvZPf2gokJvgovyoEu3/2Jhx7+tmw
    2dYmnmsnuJYOnJbHD1WemM4RzMbuRGDGW9W4TCEaYAyduGjO+qDvrkhQZje8wnfq
    Df3Tg+et8/1mGHdA/UtYJj1zKwUAiKmCNqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523368012; bh=ZvDqPxlUfEm2l/af8ko8f4WaHB5gLt
    pKDZR9JzO7cls=; b=ST28joIvd41z8A3Up+tk8SaSC0WM5Pf67HuDhOP/xpBQY1
    7fC2VYWU8D6wMY+PwPUJIE2THTTrwh5VwdWD+ah0YPCLc+wUKUWU7CM7072h4Ne4
    ctuYeDeFxoDsrF1DmnykrTxUr6I/BjQ+FdMUyQVXBXxBkrjtw3+AiL0ZxE2dVX/I
    4rKMEFjHdoh439rn6nXTuYlbTBnvwgB6Cj+gLDAjZmDuxQbfw38BA9PYEhLya2Xo
    kAv1EeQMZFYSiuL2S6dk/tHDhI0ObgPcwrnSP81OdKK75SnpdlpMGlrQ762rZU5T
    JeN4vqpY/W+3kjmb5/jf6MvCWz8fzAvfxMWh2W1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCv1GTHmowJ9oyq1YjU6CnEOWyxsc0dasM5s6mP4Ptw7NKlpsbNioWPApC4FP++oLwPWkc92CNB2RcwGTNGua7YQ9aL8Ai3bznwFcawEjkk7x/xA9Wi3
    bHd79bXAvuzvbq/+Eh8Ldo5foRL8qqCt7uvWMIO20s57XWf1DzY9eoaBWogB7oRl2CrECR2gBboj56MdHOpmzTO+od63kNcGe/4qGl4h3gu3JDd05lJ/nRC7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Cb-ZYbnvyzChmF_QQssA:9
    a=BDhKxnAnP7y38y7t:21 a=IzC0K2XU_l9OM5o0:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDJNqt (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:46:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752874AbeDJNqt (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:46:49 -0400
Date: Tue, 10 Apr 2018 15:46:46 +0200
From: Jan Kara <jack@suse.cz>
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
Message-ID: <20180410134646.p5wuhl6fwtg6megr@quack2.suse.cz>
References: <20180410125351.15837-1-willy@infradead.org>
 <20180410125351.15837-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125351.15837-2-willy@infradead.org>
User-Agent: NeoMutt/20170421 (1.8.2)
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

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
