Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53BC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8250120868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzkNk7vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8250120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJLS2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:28:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44881 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJLS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:28:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so6006633pff.11;
        Fri, 12 Oct 2018 03:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=izr9Lgu2Apw+ah+gBIeRMbByZIeAzHyDADmayQvsxVA=;
        b=kzkNk7vvFpeyrUl+TR5lI8ukacgkbTWMtPLVXDkqvfpA26UILK+XyBu/QOUSnayVea
         88UCcXuyeXluf/0ic2eVybvPis/G6yEHH1nRCeS4B2bvCbjbY616Y+/oF+U1F4wwnSeq
         964ErOflIyu/6h7S14A5JhwFfrvJLToNswo/KhSSMtztiZnWMtHc3nSmDZwP3Fz2Dd5F
         9qS+/VIpJvdcbHHLTPF3PVl4yOiY5j53ps4HL0mMt0EPmY4zdly+ufRYSpF/HDq7+GG/
         amW3mdQdIFpGjOGbx98K3EpNoXmBOmOFhqNDht7NpN/c0T8llUPUm3EqwmTmA3k3/JVw
         ChkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=izr9Lgu2Apw+ah+gBIeRMbByZIeAzHyDADmayQvsxVA=;
        b=mqocn0hwIlgqddX6HOSzdDlMkpV+zR9T2W+MkZ+FelwYBd7hXDplMBgBytsW0qK03I
         3lsc+3mepqeezqTLjG2WbWJgrnvtH6pDDgbBI1L87IXRpUJeBp5Yuy9u6BuSu5HGJ18A
         KTvFOTcIxIyt9Vbodd6Dx+K8HB9i+ckVgqaXvYQVKK1qLUXVjN/bZS1G4EU0DKQpiMaI
         1i5lDtIBWt2rpoqv1zbDok6+xXbny/b6L5rB8Ic+xZlnroW+4TLxXemmAucHwOSCGfcD
         23S61YzGuapf5q87Jocm/fKjwsdCUrRFCNp5yQTP0U+ANR1dHaYjo/0lPEXK+v1uNDuD
         phKA==
X-Gm-Message-State: ABuFfogRUOXh3TXq59kcN1S0ptPT+Kx9GkpXoTQ5DVvmIsuEfhmTUux7
        c40+7w3fGV0p0b7NyttQMuM=
X-Google-Smtp-Source: ACcGV61vDsHVMvOHRCcppnVpBkJppKMUv9+ZmkBnwQBYXauEZok3NnJng1NG+R0D+5Kc9B6jTcV64g==
X-Received: by 2002:a63:6507:: with SMTP id z7-v6mr5039326pgb.200.1539341800467;
        Fri, 12 Oct 2018 03:56:40 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id y71-v6sm1881967pfk.70.2018.10.12.03.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:56:39 -0700 (PDT)
Date:   Fri, 12 Oct 2018 21:56:12 +1100
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
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
Message-ID: <20181012105612.GK8537@350D>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012060014.10242-5-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:00:12PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Add two struct page fields that, combined, are unioned with
> struct page->lru. There is no change in the size of
> struct page. These new fields are for type safety and clarity.
> 
> Also add page flag accessors to test, set and clear the new
> page->dma_pinned_flags field.
> 
> The page->dma_pinned_count field will be used in upcoming
> patches
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm_types.h   | 22 +++++++++++++-----
>  include/linux/page-flags.h | 47 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f6292a53..017ab82e36ca 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -78,12 +78,22 @@ struct page {
>  	 */
>  	union {
>  		struct {	/* Page cache and anonymous pages */
> -			/**
> -			 * @lru: Pageout list, eg. active_list protected by
> -			 * zone_lru_lock.  Sometimes used as a generic list
> -			 * by the page owner.
> -			 */
> -			struct list_head lru;
> +			union {
> +				/**
> +				 * @lru: Pageout list, eg. active_list protected
> +				 * by zone_lru_lock.  Sometimes used as a
> +				 * generic list by the page owner.
> +				 */
> +				struct list_head lru;
> +				/* Used by get_user_pages*(). Pages may not be
> +				 * on an LRU while these dma_pinned_* fields
> +				 * are in use.
> +				 */
> +				struct {
> +					unsigned long dma_pinned_flags;
> +					atomic_t      dma_pinned_count;
> +				};
> +			};
>  			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>  			struct address_space *mapping;
>  			pgoff_t index;		/* Our offset within mapping. */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 74bee8cecf4c..81ed52c3caae 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -425,6 +425,53 @@ static __always_inline int __PageMovable(struct page *page)
>  				PAGE_MAPPING_MOVABLE;
>  }
>  
> +/*
> + * Because page->dma_pinned_flags is unioned with page->lru, any page that
> + * uses these flags must NOT be on an LRU. That's partly enforced by
> + * ClearPageDmaPinned, which gives the page back to LRU.
> + *
> + * PageDmaPinned also corresponds to PageTail (the 0th bit in the first union
> + * of struct page), and this flag is checked without knowing whether it is a
> + * tail page or a PageDmaPinned page. Therefore, start the flags at bit 1 (0x2),
> + * rather than bit 0.
> + */
> +#define PAGE_DMA_PINNED		0x2
> +#define PAGE_DMA_PINNED_FLAGS	(PAGE_DMA_PINNED)
> +

This is really subtle, additional changes to compound_head will need to coordinate
with these flags? Also doesn't this bit need to be unique across all structs in
the union? I guess that is guaranteed by the fact that page == compound_head(page)
as per your assertion, but I've forgotten why that is true. Could you please
add some commentary on that

> +/*
> + * Because these flags are read outside of a lock, ensure visibility between
> + * different threads, by using READ|WRITE_ONCE.
> + */
> +static __always_inline int PageDmaPinnedFlags(struct page *page)
> +{
> +	VM_BUG_ON(page != compound_head(page));
> +	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED_FLAGS) != 0;
> +}
> +
> +static __always_inline int PageDmaPinned(struct page *page)
> +{
> +	VM_BUG_ON(page != compound_head(page));
> +	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED) != 0;
> +}
> +
> +static __always_inline void SetPageDmaPinned(struct page *page)
> +{
> +	VM_BUG_ON(page != compound_head(page));

VM_BUG_ON(!list_empty(&page->lru))

> +	WRITE_ONCE(page->dma_pinned_flags, PAGE_DMA_PINNED);
> +}
> +
> +static __always_inline void ClearPageDmaPinned(struct page *page)
> +{
> +	VM_BUG_ON(page != compound_head(page));
> +	VM_BUG_ON_PAGE(!PageDmaPinnedFlags(page), page);
> +
> +	/* This does a WRITE_ONCE to the lru.next, which is also the
> +	 * page->dma_pinned_flags field. So in addition to restoring page->lru,
> +	 * this provides visibility to other threads.
> +	 */
> +	INIT_LIST_HEAD(&page->lru);

This assumes certain things about list_head, why not use the correct
initialization bits.

> +}
> +
>  #ifdef CONFIG_KSM
>  /*
>   * A KSM page is one of those write-protected "shared pages" or "merged pages"
> -- 
> 2.19.1
> 
