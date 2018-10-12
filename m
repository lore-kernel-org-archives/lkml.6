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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB843C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8A21473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuhK7K1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJLPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:06:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41452 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJLPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:06:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so5745441pfi.8;
        Fri, 12 Oct 2018 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2n5JUxIZKOr3Y0dMNt0D11c7QRKGACeIKwJ3kNOlySg=;
        b=RuhK7K1BwXZR9FRX7mAl+ukPvcUsJzm3yZ+74LiO2dkEA2SiwR004xJcClPOTt4+AJ
         4Qq6kReoM0NRRROOVLlcNXpQ/om/NEYF9ST9CJ2ImAnGXcy/he61bXygAi4uzKktac84
         Ihsl97aYKxD6Ih1lDb4PHkxRnmf3L+pXzWUjh0/Pbh/a9LDhQmI9WC8moAwk5Ys9GzmP
         WA00CogTIoTf2+Q7dPW+n7foY/JJYDErRZ5hzn6A8Hc5NjUfdFmem3yiIitsPxHcHNrX
         e8NzdJZusJ7dPEG1MLjbWoQJBC7cDgJv8wxZldZjjDZEm1GD8REZwG0aMjCHI2SFZLOy
         C3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2n5JUxIZKOr3Y0dMNt0D11c7QRKGACeIKwJ3kNOlySg=;
        b=dMDeanJrwFMnUg323l2aDKwybA+VsKG3p9omIpMdKKi7stneVpGIkDZ4xdUjOH2wap
         blxkX2kDgsJF5HuKHX4lkhJ0v813ni6laa3mj6ZSWWx6nEMMqZl63Zgr46air+aC4NZk
         17moX0lm5VuHmn03E9h7fav4SgU+jfdFxYO3KWuapXSfo7uCHoTCDFJ+4d5U7IDDT4U0
         q/MVhNuNO+WJwvwa7Sf4mnWz5KKEjO+uhoAdsp52AIywfz7VSfuCbTBWpw2jkaNlNJfZ
         /g3PKVSjBPZgytZ7DYiWHYX2dsF293+348lTtt0qNQQajCNnFi7j+5U02ApYxR7rkVFO
         dQ2w==
X-Gm-Message-State: ABuFfohdYA+G/wu1ucb+7PPv26K78bn3P17wBqcp7wMW5XqF8tZ1euzI
        bxWQyBVMMuhMQLwRItTcfSI=
X-Google-Smtp-Source: ACcGV62kgz5jzJCgpPZ+e8RwQAdK/NVpnTJr1DCNaeT/5U8kY1BmSt71SEULWb9qq9ipJwZOq9fJlg==
X-Received: by 2002:a62:ff09:: with SMTP id b9-v6mr4936357pfn.46.1539329727009;
        Fri, 12 Oct 2018 00:35:27 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id u62-v6sm807471pfu.69.2018.10.12.00.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 00:35:26 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:35:22 +1100
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 2/6] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181012073521.GJ8537@350D>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012060014.10242-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:00:10PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Introduces put_user_page(), which simply calls put_page().
> This provides a way to update all get_user_pages*() callers,
> so that they call put_user_page(), instead of put_page().
> 
> Also introduces put_user_pages(), and a few dirty/locked variations,
> as a replacement for release_pages(), and also as a replacement
> for open-coded loops that release multiple pages.
> These may be used for subsequent performance improvements,
> via batching of pages to be released.
> 
> This is the first step of fixing the problem described in [1]. The steps
> are:
> 
> 1) (This patch): provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, any will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem. Again, [1] provides details as to why that is
>    desirable.
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Michal Hocko <mhocko@kernel.org>
> CC: Christopher Lameter <cl@linux.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Jan Kara <jack@suse.cz>
> CC: Al Viro <viro@zeniv.linux.org.uk>
> CC: Jerome Glisse <jglisse@redhat.com>
> CC: Christoph Hellwig <hch@infradead.org>
> CC: Ralph Campbell <rcampbell@nvidia.com>
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 20 +++++++++++
>  mm/swap.c          | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0416a7204be3..76d18aada9f8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -943,6 +943,26 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
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
> +static inline void put_user_page(struct page *page)
> +{
> +	put_page(page);
> +}
> +
> +void put_user_pages_dirty(struct page **pages, unsigned long npages);
> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
> +void put_user_pages(struct page **pages, unsigned long npages);
> +
>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define SECTION_IN_PAGE_FLAGS
>  #endif
> diff --git a/mm/swap.c b/mm/swap.c
> index 26fc9b5f1b6c..efab3a6b6f91 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -134,6 +134,89 @@ void put_pages_list(struct list_head *pages)
>  }
>  EXPORT_SYMBOL(put_pages_list);
>  
> +/*
> + * put_user_pages_dirty() - for each page in the @pages array, make
> + * that page (or its head page, if a compound page) dirty, if it was
> + * previously listed as clean. Then, release the page using
> + * put_user_page().
> + *
> + * Please see the put_user_page() documentation for details.
> + *
> + * set_page_dirty(), which does not lock the page, is used here.
> + * Therefore, it is the caller's responsibility to ensure that this is
> + * safe. If not, then put_user_pages_dirty_lock() should be called instead.
> + *
> + * @pages:  array of pages to be marked dirty and released.
> + * @npages: number of pages in the @pages array.
> + *
> + */
> +void put_user_pages_dirty(struct page **pages, unsigned long npages)
> +{
> +	unsigned long index;
> +
> +	for (index = 0; index < npages; index++) {
Do we need any checks on npages, npages <= (PUD_SHIFT - PAGE_SHIFT)?

> +		struct page *page = compound_head(pages[index]);
> +
> +		if (!PageDirty(page))
> +			set_page_dirty(page);
> +
> +		put_user_page(page);
> +	}
> +}
> +EXPORT_SYMBOL(put_user_pages_dirty);
> +
> +/*
> + * put_user_pages_dirty_lock() - for each page in the @pages array, make
> + * that page (or its head page, if a compound page) dirty, if it was
> + * previously listed as clean. Then, release the page using
> + * put_user_page().
> + *
> + * Please see the put_user_page() documentation for details.
> + *
> + * This is just like put_user_pages_dirty(), except that it invokes
> + * set_page_dirty_lock(), instead of set_page_dirty().
> + *
> + * @pages:  array of pages to be marked dirty and released.
> + * @npages: number of pages in the @pages array.
> + *
> + */
> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
> +{
> +	unsigned long index;
> +
> +	for (index = 0; index < npages; index++) {
> +		struct page *page = compound_head(pages[index]);
> +
> +		if (!PageDirty(page))
> +			set_page_dirty_lock(page);
> +
> +		put_user_page(page);
> +	}
> +}
> +EXPORT_SYMBOL(put_user_pages_dirty_lock);
> +

This can be collapsed w.r.t put_user_pages_dirty, a function pointer indirection
for the locked vs unlocked case, not sure how that affects function optimization.


> +/*
> + * put_user_pages() - for each page in the @pages array, release the page
> + * using put_user_page().
> + *
> + * Please see the put_user_page() documentation for details.
> + *
> + * This is just like put_user_pages_dirty(), except that it invokes
> + * set_page_dirty_lock(), instead of set_page_dirty().

The comment is incorrect.

> + *
> + * @pages:  array of pages to be marked dirty and released.
> + * @npages: number of pages in the @pages array.
> + *
> + */
> +void put_user_pages(struct page **pages, unsigned long npages)
> +{
> +	unsigned long index;
> +
> +	for (index = 0; index < npages; index++)
> +		put_user_page(pages[index]);
> +}

Ditto in terms of code duplication

How about

for_each_page_index(index, npages) {
	<do the dirty bits if needed>
	put_user_pages(pages[index]
}

Then pass what you want the page iterator to do


> +EXPORT_SYMBOL(put_user_pages);
> +
>  /*
>   * get_kernel_pages() - pin kernel pages in memory
>   * @kiov:	An array of struct kvec structures
> -- 
> 2.19.1
> 

Balbir Singh.
