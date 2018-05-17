Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEQLsY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:48:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:48:23 -0400
Date: Thu, 17 May 2018 04:48:21 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [RFC v3 PATCH 1/5] mm/page_alloc: use helper functions to
 add/remove a page to/from buddy
Message-ID: <20180517114821.GA26689@bombadil.infradead.org>
References: <20180509085450.3524-1-aaron.lu@intel.com>
 <20180509085450.3524-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509085450.3524-2-aaron.lu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 04:54:46PM +0800, Aaron Lu wrote:
> +static inline void add_to_buddy_head(struct page *page, struct zone *zone,
> +					unsigned int order, int mt)
> +{
> +	add_to_buddy_common(page, zone, order);
> +	list_add(&page->lru, &zone->free_area[order].free_list[mt]);
> +}

Isn't this function (and all of its friends) misnamed?  We're not adding
this page to the buddy allocator, we're adding it to the freelist.  It
doesn't go to the buddy allocator until later, if at all.
