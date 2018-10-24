Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62354C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E66520833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYSzMcQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E66520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJXT2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:28:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36642 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeJXT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:28:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id l6-v6so2148892pgp.3;
        Wed, 24 Oct 2018 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e14WxnPfVenXgvmMq2kyVKYpSsxDR4AHoOEIWmdr9pc=;
        b=gYSzMcQ3bWJC8a5pvsa7avhXcq8YTfC03xMupSnE2shfGZIFNPeBkUiffXEX8ucOii
         B6aGagvGKBIQ3JencEwhXNkdJeXZPldGISpWknyBBqJryTMtHV3THEaQE+XKLfwrBqd2
         z/e1LZJd5QZu6cZBly1AcZEFEPHZqlPj4fudBw+jwan8joER/rEndCA14c11mLSXdj4g
         fem4X6hXunGFTcj4sDyrkYzh/OtEFxRJK2QIQR9cVSPn9nZvZkxLYnZapO0gEqEL8pmS
         fWcLgVz9LWDSLIKWGTsVB9x4pC+r1NVM+Y1q6hDilBPM6JCWlK24VMzRwGoAyRepx7u9
         ERMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e14WxnPfVenXgvmMq2kyVKYpSsxDR4AHoOEIWmdr9pc=;
        b=RLfdmHbo/RP+egTmpH0qGmHlpXHmRvFxw5CPE0rilE4Kq347L/rlpeEg2gm2xDiUku
         PBX3+jnXgi909GJlM76GYcFxDgutONvyXF0Vj7DGl5cSZR0Ehjm7kAUl9w1jYgmBmGgq
         VTX97w5tqQrVnEjEH8xXiWRmfusoD6WGUU07L5yvXvnKNGo1txOwQM1ztA2sIDDuQtnK
         F2h9DLPFHnIAxxusScMgQb/+oYaPS1t6R3crknYFd9NZuyYX0NOaJqymP7Oe/aNWG5S7
         4av4ZmZd3XXovcGeysuH2QOr52wdzYAG23BXSyck1MLpm0we5x0nRB1Uf4zlp5Z4yo15
         dKrA==
X-Gm-Message-State: AGRZ1gKoUzK0wzAPLNmKiU7aNAli/7Sj5Ic84DY4R3S5Oyw5lu5mzvUX
        azkVgWHNt3znam3cq3HMRx4=
X-Google-Smtp-Source: AJdET5eSF+hDW0vJDraYbxPbeSFbTG+DBcBJCw40NfJlbV8aNyk0VTzIIhTH1q2dPGLitqMhUg7EIw==
X-Received: by 2002:a63:40c2:: with SMTP id n185-v6mr2118656pga.116.1540378836425;
        Wed, 24 Oct 2018 04:00:36 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id 70-v6sm6854901pfm.36.2018.10.24.04.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 04:00:35 -0700 (PDT)
Date:   Wed, 24 Oct 2018 22:00:31 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
Message-ID: <20181024110031.GM8537@350D>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com>
 <20181012105612.GK8537@350D>
 <b115b2ce-8fe8-db03-da9c-452511c8ed27@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115b2ce-8fe8-db03-da9c-452511c8ed27@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:15:51PM -0700, John Hubbard wrote:
> On 10/12/18 3:56 AM, Balbir Singh wrote:
> > On Thu, Oct 11, 2018 at 11:00:12PM -0700, john.hubbard@gmail.com wrote:
> >> From: John Hubbard <jhubbard@nvidia.com>
> [...]
> >> + * Because page->dma_pinned_flags is unioned with page->lru, any page that
> >> + * uses these flags must NOT be on an LRU. That's partly enforced by
> >> + * ClearPageDmaPinned, which gives the page back to LRU.
> >> + *
> >> + * PageDmaPinned also corresponds to PageTail (the 0th bit in the first union
> >> + * of struct page), and this flag is checked without knowing whether it is a
> >> + * tail page or a PageDmaPinned page. Therefore, start the flags at bit 1 (0x2),
> >> + * rather than bit 0.
> >> + */
> >> +#define PAGE_DMA_PINNED		0x2
> >> +#define PAGE_DMA_PINNED_FLAGS	(PAGE_DMA_PINNED)
> >> +
> > 
> > This is really subtle, additional changes to compound_head will need to coordinate
> > with these flags? Also doesn't this bit need to be unique across all structs in
> > the union? I guess that is guaranteed by the fact that page == compound_head(page)
> > as per your assertion, but I've forgotten why that is true. Could you please
> > add some commentary on that
> > 
> 
> Yes, agreed. I've rewritten and augmented that comment block, plus removed the 
> PAGE_DMA_PINNED_FLAGS (there are no more bits available, so it's just misleading 
> to even have it). So now it looks like this:
> 
> /*
>  * Because page->dma_pinned_flags is unioned with page->lru, any page that
>  * uses these flags must NOT be on an LRU. That's partly enforced by
>  * ClearPageDmaPinned, which gives the page back to LRU.
>  *
>  * PageDmaPinned is checked without knowing whether it is a tail page or a
>  * PageDmaPinned page. For that reason, PageDmaPinned avoids PageTail (the 0th
>  * bit in the first union of struct page), and instead uses bit 1 (0x2),
>  * rather than bit 0.
>  *
>  * PageDmaPinned can only be used if no other systems are using the same bit
>  * across the first struct page union. In this regard, it is similar to
>  * PageTail, and in fact, because of PageTail's constraint that bit 0 be left
>  * alone, bit 1 is also left alone so far: other union elements (ignoring tail
>  * pages) put pointers there, and pointer alignment leaves the lower two bits
>  * available.
>  *
>  * So, constraints include:
>  *
>  *     -- Only use PageDmaPinned on non-tail pages.
>  *     -- Remove the page from any LRU list first.
>  */
> #define PAGE_DMA_PINNED		0x2
> 
> /*
>  * Because these flags are read outside of a lock, ensure visibility between
>  * different threads, by using READ|WRITE_ONCE.
>  */
> static __always_inline int PageDmaPinned(struct page *page)
> {
> 	VM_BUG_ON(page != compound_head(page));
> 	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED) != 0;
> }
> 
> [...]
> >> +static __always_inline void SetPageDmaPinned(struct page *page)
> >> +{
> >> +	VM_BUG_ON(page != compound_head(page));
> > 
> > VM_BUG_ON(!list_empty(&page->lru))
> 
> 
> There is only one place where we set this flag, and that is when (in patch 6/6)
> transitioning from a page that might (or might not) have been
> on an LRU. In that case, the calling code has already corrupted page->lru, by
> writing to page->dma_pinned_count, which is unions with page->lru:
> 
> 		atomic_set(&page->dma_pinned_count, 1);
> 		SetPageDmaPinned(page);
> 
> ...so it would be inappropriate to call a list function, such as 
> list_empty(), on that field.  Let's just leave it as-is.
> 
> 
> > 
> >> +	WRITE_ONCE(page->dma_pinned_flags, PAGE_DMA_PINNED);
> >> +}
> >> +
> >> +static __always_inline void ClearPageDmaPinned(struct page *page)
> >> +{
> >> +	VM_BUG_ON(page != compound_head(page));
> >> +	VM_BUG_ON_PAGE(!PageDmaPinnedFlags(page), page);
> >> +
> >> +	/* This does a WRITE_ONCE to the lru.next, which is also the
> >> +	 * page->dma_pinned_flags field. So in addition to restoring page->lru,
> >> +	 * this provides visibility to other threads.
> >> +	 */
> >> +	INIT_LIST_HEAD(&page->lru);
> > 
> > This assumes certain things about list_head, why not use the correct
> > initialization bits.
> > 
> 
> Yes, OK, changed to:
> 
> static __always_inline void ClearPageDmaPinned(struct page *page)
> {
> 	VM_BUG_ON(page != compound_head(page));
> 	VM_BUG_ON_PAGE(!PageDmaPinned(page), page);
> 
> 	/* Provide visibility to other threads: */
> 	WRITE_ONCE(page->dma_pinned_flags, 0);
> 
> 	/*
> 	 * Safety precaution: restore the list head, before possibly returning
> 	 * the page to other subsystems.
> 	 */
> 	INIT_LIST_HEAD(&page->lru);
> }
> 
>

Sorry, I've been distracted with other things

This looks better, do we still need the INIT_LIST_HEAD?

Balbir Singh.
 
> 
> -- 
> thanks,
> John Hubbard
> NVIDIA
