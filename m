Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeEDNS6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59627 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDNS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:18:57 -0400
Date: Fri, 4 May 2018 15:18:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Huaisheng Ye <yehs1@lenovo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
        mgorman@techsingularity.net, pasha.tatashin@oracle.com,
        alexander.levin@verizon.com, hannes@cmpxchg.org,
        penguin-kernel@I-love.SAKURA.ne.jp, colyli@suse.de, chengnt@lenovo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/page_alloc: Fix typo in debug info of
 calculate_node_totalpages
Message-ID: <20180504131854.GQ4535@dhcp22.suse.cz>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-4-git-send-email-yehs1@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525416729-108201-4-git-send-email-yehs1@lenovo.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-05-18 14:52:09, Huaisheng Ye wrote:
> realtotalpages is calculated by taking off absent_pages from
> spanned_pages in every zone.
> Debug message of calculate_node_totalpages shall accurately
> indicate that it is real totalpages to avoid ambiguity.

Is the printk actually useful? Why don't we simply remove it? You can
get the information from /proc/zoneinfo so why to litter the dmesg
output?

> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1b39db4..9d57db2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5967,7 +5967,7 @@ static void __meminit calculate_node_totalpages(struct pglist_data *pgdat,
>  
>  	pgdat->node_spanned_pages = totalpages;
>  	pgdat->node_present_pages = realtotalpages;
> -	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id,
> +	printk(KERN_DEBUG "On node %d realtotalpages: %lu\n", pgdat->node_id,
>  							realtotalpages);
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
