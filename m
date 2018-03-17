Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeCQDIO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 23:08:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8681 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCQDIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 23:08:13 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 20:08:12 -0700
Subject: Re: [PATCH 05/14] mm/hmm: use struct for hmm_vma_fault(),
 hmm_vma_get_pfns() parameters
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-6-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <9b8ad818-252d-e1f2-0cdb-a7228ccaa392@nvidia.com>
Date: Fri, 16 Mar 2018 20:08:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316191414.3223-6-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 

Hi Jerome,

I failed to find any problems in this patch, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

There are a couple of documentation recommended typo fixes listed
below, which are very minor but as long as I'm here I'll point them out.

> Both hmm_vma_fault() and hmm_vma_get_pfns() were taking a hmm_range
> struct as parameter and were initializing that struct with others of
> their parameters. Have caller of those function do this as they are
> likely to already do and only pass this struct to both function this
> shorten function signature and make it easiers in the future to add

                                         easier

> new parameters by simply adding them to the structure.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 18 ++++---------
>  mm/hmm.c            | 78 +++++++++++++++++++----------------------------------
>  2 files changed, 33 insertions(+), 63 deletions(-)


<snip>
>  
>  
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 64d9e7dae712..49f0f6b337ed 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -490,11 +490,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  
>  /*
>   * hmm_vma_get_pfns() - snapshot CPU page table for a range of virtual addresses
> - * @vma: virtual memory area containing the virtual address range
> - * @range: used to track snapshot validity
> - * @start: range virtual start address (inclusive)
> - * @end: range virtual end address (exclusive)
> - * @entries: array of hmm_pfn_t: provided by the caller, filled in by function
> + * @range: range being snapshoted and all needed informations

Let's just say this:

* @range: range being snapshotted


<snip>

> @@ -628,11 +617,7 @@ EXPORT_SYMBOL(hmm_vma_range_done);
>  
>  /*
>   * hmm_vma_fault() - try to fault some address in a virtual address range
> - * @vma: virtual memory area containing the virtual address range
> - * @range: use to track pfns array content validity
> - * @start: fault range virtual start address (inclusive)
> - * @end: fault range virtual end address (exclusive)
> - * @pfns: array of hmm_pfn_t, only entry with fault flag set will be faulted
> + * @range: range being faulted and all needed informations

Similarly here, let's just write it like this:

* @range: range being faulted


thanks,
-- 
John Hubbard
NVIDIA
