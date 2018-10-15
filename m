Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32063C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D112D2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="P7ByBJty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D112D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeJOX1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:27:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40575 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeJOX1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:27:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so9345128pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qB94+A2LnG2Qk3a46B4voHq5yr4VlTDLtEy7xL559kg=;
        b=P7ByBJty/o5iAyy5ykGxeWTRQF+KXH+KW9pwGrVAf0b/4sf6BTgfEBlnJQv29p9Vsn
         VUtyt/liai8jN2hk+bAoWYlyRj/BLdmWlfu4FWe25Fo72lVmxT8jTWMdDhJdlD0/QSzi
         W/trT5edJjdHxzwk/dt1m374KqaJfQHhCECSRwPtROgwZo0s9zuMvuwrYOzbyrStDqYS
         6gxxKcYI/H7glCwCy4kr/9ULE+kLfo4Wu87WL1Kuvpb6AUkr4NEi9yPOeG3uZblXAbqn
         jg5GTe2sTY7yEpkn2wVL4O+zZZIS0333o7Ha5Ua84cLrLRJFefJlh7wllVfenNusTjWq
         Sn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qB94+A2LnG2Qk3a46B4voHq5yr4VlTDLtEy7xL559kg=;
        b=HiaDZ2avy7jP8YYjOPuRoa0h+nst0zLF2wJuXq9OJeAlLS1R+nOAvbTHDNifQ1Gb34
         3Lk2B0zGsxyTE+CwRF8WvW7R26Ce2H7tQxQtY0CZ5v7uhgc/4m+2+C2b9i0aCvGyqItt
         uMWy6cZuCp6AdtJXRBdq5h2d154hJnLqmlU1+hk+Np0zxt2QF3u14XPSLUKNwELOk4Gd
         pbIdQFlkZsmQi/DqpMYK0cO4uOI7gUbGsP+d+AUfeANMP16cLWOPOsk05xizg+YFIipY
         Y65qyfVXt8mRZTf+1hKEC1c27qWSCQcqYYz4P9r5dcueevA5p6QFEYp3sKEEFvlQI1Jq
         Jqww==
X-Gm-Message-State: ABuFfohb+/q0MMyWZVdaEk/eeUmLWqODUtpEgM0Fj56WqH05Xmo3U7vr
        L1rfeVYqij45acncKKGp8t2iGw==
X-Google-Smtp-Source: ACcGV61rXE0RRKuLTlTlADHcCXmhwYQSb6jO2KrX52JzHioUOZLQRCWkfLzRZzFtNEdHau1rg7xAyQ==
X-Received: by 2002:a63:ef53:: with SMTP id c19-v6mr16554170pgk.386.1539618078408;
        Mon, 15 Oct 2018 08:41:18 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id d2-v6sm17631283pfd.100.2018.10.15.08.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:41:17 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E4AF1300030; Mon, 15 Oct 2018 18:41:12 +0300 (+03)
Date:   Mon, 15 Oct 2018 18:41:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, imbrenda@linux.vnet.ibm.com,
        corbet@lwn.net, ndesaulniers@google.com, dave.jiang@intel.com,
        jglisse@redhat.com, jia.he@hxt-semitech.com,
        paulmck@linux.vnet.ibm.com, colin.king@canonical.com,
        jiang.biao2@zte.com.cn, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ksm: Assist buddy allocator to assemble 1-order pages
Message-ID: <20181015154112.6bj5p4zuxjtz43pd@kshutemo-mobl1>
References: <153925511661.21256.9692370932417728663.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153925511661.21256.9692370932417728663.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 01:52:22PM +0300, Kirill Tkhai wrote:
> try_to_merge_two_pages() merges two pages, one of them
> is a page of currently scanned mm, the second is a page
> with identical hash from unstable tree. Currently, we
> merge the page from unstable tree into the first one,
> and then free it.
> 
> The idea of this patch is to prefer freeing that page
> of them, which has a free neighbour (i.e., neighbour
> with zero page_count()). This allows buddy allocator
> to assemble at least 1-order set from the freed page
> and its neighbour; this is a kind of cheep passive
> compaction.
> 
> AFAIK, 1-order pages set consists of pages with PFNs
> [2n, 2n+1] (odd, even), so the neighbour's pfn is
> calculated via XOR with 1. We check the result pfn
> is valid and its page_count(), and prefer merging
> into @tree_page if neighbour's usage count is zero.
> 
> There a is small difference with current behavior
> in case of error path. In case of the second
> try_to_merge_with_ksm_page() is failed, we return
> from try_to_merge_two_pages() with @tree_page
> removed from unstable tree. It does not seem to matter,
> but if we do not want a change at all, it's not
> a problem to move remove_rmap_item_from_tree() from
> try_to_merge_with_ksm_page() to its callers.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/ksm.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 5b0894b45ee5..b83ca37e28f0 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1321,6 +1321,21 @@ static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
>  {
>  	int err;
>  
> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
> +		unsigned long pfn;
> +		/*
> +		 * Find neighbour of @page containing 1-order pair
> +		 * in buddy-allocator and check whether it is free.

You cannot really check if the page is free. There are some paths that
makes the refcount zero temporarely, but doesn't free the page.
See page_ref_freeze() for instance.

It should be fine for the use case, but comment should state that we
speculate about page usage, not having definetive answer.

[ I don't know enough about KSM to ack the patch in general, but it looks
fine to me at the first glance.]

> +		 * If it is so, try to use @tree_page as ksm page
> +		 * and to free @page.
> +		 */
> +		pfn = (page_to_pfn(page) ^ 1);
> +		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn)) == 0) {
> +			swap(rmap_item, tree_rmap_item);
> +			swap(page, tree_page);
> +		}
> +	}
> +
>  	err = try_to_merge_with_ksm_page(rmap_item, page, NULL);
>  	if (!err) {
>  		err = try_to_merge_with_ksm_page(tree_rmap_item,
> 

-- 
 Kirill A. Shutemov
