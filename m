Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeDFKCm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:02:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeDFKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:02:41 -0400
Date: Fri, 6 Apr 2018 12:02:36 +0200
From: Michal Hocko <mhocko@kernel.org>
To: akpm@linux-foundation.org
Cc: JianKang Chen <chenjiankang1@huawei.com>, mgorman@techsingularity.net,
        hannes@cmpxchg.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xieyisheng1@huawei.com, guohanjun@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH resend] mm/page_alloc: fix comment is __get_free_pages
Message-ID: <20180406100236.GK8286@dhcp22.suse.cz>
References: <1511780964-64864-1-git-send-email-chenjiankang1@huawei.com>
 <20171127113341.ldx32qvexqe2224d@dhcp22.suse.cz>
 <20171129160446.jluzpv3n6mjc3fwv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129160446.jluzpv3n6mjc3fwv@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-11-17 17:04:46, Michal Hocko wrote:
[...]
> From 000bb422fe07adbfa8cd8ed953b18f48647a45d6 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 29 Nov 2017 17:02:33 +0100
> Subject: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
> 
> There is no real reason to blow up just because the caller doesn't know
> that __get_free_pages cannot return highmem pages. Simply fix that up
> silently. Even if we have some confused users such a fixup will not be
> harmful.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Andrew, have we reached any conclusion for this? Should I repost or drop
it on the floor?

> ---
>  mm/page_alloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0d518e9b2ee8..3dd960ea8c13 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4284,9 +4284,7 @@ unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order)
>  	 * __get_free_pages() returns a virtual address, which cannot represent
>  	 * a highmem page
>  	 */
> -	VM_BUG_ON((gfp_mask & __GFP_HIGHMEM) != 0);
> -
> -	page = alloc_pages(gfp_mask, order);
> +	page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order);
>  	if (!page)
>  		return 0;
>  	return (unsigned long) page_address(page);
> -- 
> 2.15.0
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
