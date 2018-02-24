Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeBXAwj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:52:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:58895 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752782AbeBXAwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:52:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="37031461"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][mm-next] mm, swap: make bool enable_vma_readahead and function swap_vma_readahead static
References: <20180223164852.5159-1-colin.king@canonical.com>
Date: Sat, 24 Feb 2018 08:52:32 +0800
In-Reply-To: <20180223164852.5159-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 23 Feb 2018 16:48:52 +0000")
Message-ID: <87vaen2oq7.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> The bool enable_vma_readahead and function swap_vma_readahead are local
> to the source and do not need to be in global scope, so make them static.
>
> Cleans up sparse warnings:
> mm/swap_state.c:41:6: warning: symbol 'enable_vma_readahead' was not
> declared. Should it be static?
> mm/swap_state.c:742:13: warning: symbol 'swap_vma_readahead' was not
> declared. Should it be static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/swap_state.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 8dde719e973c..f3952138f01d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -38,7 +38,7 @@ static const struct address_space_operations swap_aops = {
>  
>  struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
>  static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
> -bool enable_vma_readahead __read_mostly = true;
> +static bool enable_vma_readahead __read_mostly = true;
>  
>  #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
>  #define SWAP_RA_HITS_MASK	((1UL << SWAP_RA_WIN_SHIFT) - 1)
> @@ -739,8 +739,8 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	pte_unmap(orig_pte);
>  }
>  
> -struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
> -				    struct vm_fault *vmf)
> +static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
> +				       struct vm_fault *vmf)
>  {
>  	struct blk_plug plug;
>  	struct vm_area_struct *vma = vmf->vma;
