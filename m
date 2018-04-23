Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3888946-1524442193-2-12517196634652995932
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524442193; b=TNvD5mXez+jaUusgpghgnWolHbiq10f/NP4Rv+2B1spEo1GzLA
    3E3U0fyhle1MC8Ha5zaOmNCUwJTgMkxwluCMDWHoK3GTybAfvv62y6rT4fyaKLaD
    /E5LuZ6w5wt7Nt7R8yF6qTalwTd74s/EmOvkk0x1U1XLdIZOf2xaj2QJX1mRWsBz
    yi8cs/8ia2PB66onEbjDzdZbG+8u9p7YNMROtrvmYZEgcAwfWf49VzxU5Vy3qAbi
    Ux6v8HJQLMV+6R+6XqiaiNc+jL8MxRFPTc5msXXu2BMTSyPD8OujqEQeOXR6ywUH
    Jojm5thn44ioQUJ/LS1FdHq8W7P2UH/CIr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524442193; bh=KP1LPpS3Iuu63cTNYMIIxzJfxDyTo6
    dkiptsHVUdGGU=; b=iLILUti5D4h4/TDalyS7YmFquNWWO4FZFOP+rgAOScEBF0
    eP5Ol1u+ha2+mfGG3z6tIA34e60A0uAlOR/b6bOsU6GV8H0dtPVbnEFkUcIw5qRa
    KH6FN/qJrhaEV+jkdDVFiqZIyIOrSQkcaVJGEAd5Tv5W95aNNmC4rSJC2Bz2xfcM
    cbBr5AOlX7Xt2EoZj8ygmO0jbRYJlv1tmn4xAkNDczUb8ExeP+L+HEVz4Imhofpj
    Z0uP7js+ngevw4kzCKfE33IP5DxT4cEl8r7WcT/WBprywcqB1AnnNXEC0N75oCRR
    FBTmsOm3POxNYCE6GHssXDdUtscbDlbRwPDEW8lg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ7P749aIE+ADF0ajKvqKxzvAorns0TWqPCEdWp2c8b59Lpc5OQm8gV0MThknOsOPICLzVhbqfP1NO936em11vR4TZOvc2IjttpcdeMN2LAU6OkjWW5K
    SSQxW+s2aQG57UqVua/v3BCHbdyK8L3iP5yr+tPJi2l+oiGkhO3KRoNIOnggQj5CpqfGzqwDfIMws51UGIkitCirpAlVdkpY3pSxebNc+E0fZHBMzD6cdjNP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gVvHBaZr1ZDVsfV6UgUA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeDWAJt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 20:09:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbeDWAJs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 22 Apr 2018 20:09:48 -0400
Date: Sun, 22 Apr 2018 18:09:43 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm: add find_alloc_contig_pages() interface
Message-ID: <20180423000943.GO17484@dhcp22.suse.cz>
References: <20180417020915.11786-1-mike.kravetz@oracle.com>
 <20180417020915.11786-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417020915.11786-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 19:09:14, Mike Kravetz wrote:
[...]
> @@ -2010,9 +2011,13 @@ static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  {
>  	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
>  }
> +#define contig_alloc_migratetype_ok(migratetype) \
> +	((migratetype) == MIGRATE_CMA || (migratetype) == MIGRATE_MOVABLE)
>  #else
>  static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  					unsigned int order) { return NULL; }
> +#define contig_alloc_migratetype_ok(migratetype) \
> +	((migratetype) == MIGRATE_MOVABLE)
>  #endif
>  
>  /*
> @@ -7822,6 +7827,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  
> +	if (!contig_alloc_migratetype_ok(migratetype))
> +		return -EINVAL;
> +
>
>  	/*
>  	 * What we do here is we mark all pageblocks in range as
>  	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
> @@ -7912,8 +7920,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  
>  	/* Make sure the range is really isolated. */
>  	if (test_pages_isolated(outer_start, end, false)) {
> -		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> -			__func__, outer_start, end);
> +		if (!(migratetype == MIGRATE_MOVABLE)) /* only print for CMA */
> +			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> +				__func__, outer_start, end);
>  		ret = -EBUSY;
>  		goto done;
>  	}

This probably belongs to a separate patch. I would be tempted to say
that we should get rid of this migratetype thingy altogether. I confess
I have forgot everything about why this is required actually but it is
ugly as hell. Not your fault of course.

> @@ -7949,6 +7958,82 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  	}
>  	WARN(count != 0, "%ld pages are still in use!\n", count);
>  }
> +
> +static bool contig_pfn_range_valid(struct zone *z, unsigned long start_pfn,
> +					unsigned long nr_pages)
> +{
> +	unsigned long i, end_pfn = start_pfn + nr_pages;
> +	struct page *page;
> +
> +	for (i = start_pfn; i < end_pfn; i++) {
> +		if (!pfn_valid(i))
> +			return false;
> +
> +		page = pfn_to_page(i);

It believe we want pfn_to_online_page here. The old giga pages code is
buggy in that regard but nothing really critical because the
alloc_contig_range will notice that.

Also do we want to check other usual suspects? E.g. PageReserved? And
generally migrateable pages if page count > 0. Or do we want to leave
everything to the alloc_contig_range?

> +
> +		if (page_zone(page) != z)
> +			return false;
> +
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
> + *				range of pages
> + * @order:	number of pages
> + * @gfp:	gfp mask used to limit search as well as during compaction
> + * @nid:	target node
> + * @nodemask:	mask of other possible nodes
> + *
> + * Pages can be freed with a call to free_contig_pages(), or by manually
> + * calling __free_page() for each page allocated.
> + *
> + * Return: pointer to 'order' pages on success, or NULL if not successful.
> + */
> +struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +					int nid, nodemask_t *nodemask)

Vlastimil asked about this but I would even say that we do not want to
make this order based. Why would we want to restrict the api to 2^order
sizes in the first place? What if somebody wants to allocate 123 pages?

> +{
> +	unsigned long pfn, nr_pages, flags;
> +	struct page *ret_page = NULL;
> +	struct zonelist *zonelist;
> +	struct zoneref *z;
> +	struct zone *zone;
> +	int rc;
> +
> +	nr_pages = 1 << order;
> +	zonelist = node_zonelist(nid, gfp);
> +	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp),
> +					nodemask) {
> +		spin_lock_irqsave(&zone->lock, flags);
> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> +		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
> +			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
> +				spin_unlock_irqrestore(&zone->lock, flags);

I know that the giga page allocation does use the zone lock but why? I
suspect it wants to stabilize zone_start_pfn but zone lock doesn't do
that.

> +
> +				rc = alloc_contig_range(pfn, pfn + nr_pages,
> +							MIGRATE_MOVABLE, gfp);
> +				if (!rc) {
> +					ret_page = pfn_to_page(pfn);
> +					return ret_page;
> +				}
> +				spin_lock_irqsave(&zone->lock, flags);
> +			}
> +			pfn += nr_pages;
> +		}
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +	}

Other than that this API looks much saner than alloc_contig_range. We
still need to sort out some details (e.g. alignment) but it should be an
improvement.

Thanks!
-- 
Michal Hocko
SUSE Labs
