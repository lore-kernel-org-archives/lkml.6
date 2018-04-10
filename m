Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523367958-2-16123573183244736838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523367957; b=ACGXLGHcg2q5LruyCAaARa/CmdGb8+MKEH6Gx0UQQIptAJRWiT
    ha8b62yNOH91b1DfOOzX1GqJJcf6HmwTMBn1vgjUJtUxQxUPCbvZjzv4HeBt2Wrl
    PYPvdbdGNLAf8XSP17bhBpdeyS00SIY+S1fgZnsCjF26wB+wuqjb3AXd7byTdWGu
    qcF/78hdAX+MP9J6YZyOWUWtFmZFKwrqSVDchP2+ehOFtP4NXV8hkGxSw5WpHs2y
    P16tDgYrGiXhUlIf2rnEmL5dcQZ50VFwuufpDSe5oed9O9YXdKbF7QBPgRDFWMWQ
    o+4yMjgbEfxhLQNrcrV8+0aVdrY1T3Qf7lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523367957; bh=ZeAVmPM/KYKLrh4bEBY8yPDCNJ70Ou
    W8CwOLSICbt9Y=; b=dHTPUPe8cBwUD9IwCX4QAeocbs4yIglUts+h5xASnyzOq2
    OaGJqT1QhEWXELKxLgQW4twF95vci26Y7zNpsD+ATjDdmNy7Wjsbc9bkaJxtWAHt
    ddWkX0FPNcxd91bP95bnfl3DX68paDAJj+ZFqxNyK3tpI+qymMqEXqTzQmYgiYlE
    YE02ojVkTV6/ls7/Tima2o3xjzMDWl89GUe+HXIRmqxGhcHdMxD5It3HedKCGrxR
    lQGF5uLkAudepmDF61nUcrFPaV8HMLpoCHrkcacbi1VLH/u0GNqNJcFwMisGDFZY
    pubjpkTbiyR6Uy72DUUleupLNc9unERXvzc9I1fg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PygIAya+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SOomVLwr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PygIAya+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SOomVLwr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEpPLvjsWFwdKFZFC4mdTdaEK10ly7/6KeZ3GxABmQ36m/ApjXBXuT+/uZhWWExIDJpEeVIThsmDJpUklbvzyMWtmi5tvt3Ao52xVZikoiFkn02UXFwa
    pVXqhc0pE9l2DQEMyMQrF2yYtG8jOkMfYBWQp8SxQygLnATBxWZFIjXTpn1D4FoE+ShTC1witGx8WV+R13itlxowJPz8NpUzTnGbjOcXb0QDVZwLnPwft59Z
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=Cb-ZYbnvyzChmF_QQssA:9
    a=E6PsIlTVB50LPunw:21 a=KfckjAQfn04yULFn:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeDJNpz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:45:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36761 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeDJNpy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 09:45:54 -0400
X-Google-Smtp-Source: AIpwx4+6ogu+6ehoxvqGnVfME9LalicO7BZQQlIRhdvQjQEH2rvzu9rQfPhS7xmvo1i1rm7BpAalJw==
Date: Tue, 10 Apr 2018 22:45:45 +0900
From: Minchan Kim <minchan@kernel.org>
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
        stable@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH 2/2] page cache: Mask off unwanted GFP flags
Message-ID: <20180410134545.GA35354@rodete-laptop-imager.corp.google.com>
References: <20180410125351.15837-1-willy@infradead.org>
 <20180410125351.15837-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125351.15837-2-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 05:53:51AM -0700, Matthew Wilcox wrote:
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

Why this patch fix 19f99cee206c instead of 449dd6984d0e?
F2FS doesn't have any problem before introducing 449dd6984d0e?


> Reported-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@vger.kernel.org
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
