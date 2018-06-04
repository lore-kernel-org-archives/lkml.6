Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeFDGqH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:46:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbeFDGqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:46:07 -0400
Date: Mon, 4 Jun 2018 08:46:04 +0200
From: Michal Hocko <mhocko@kernel.org>
To: kpark3469@gmail.com
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vinmenon@codeaurora.org, jack@suse.cz,
        Sahara <keun-o.park@darkmatter.ae>
Subject: Re: [PATCH] mm: clean up page_is_poisoned in linux/mm.h
Message-ID: <20180604064604.GC19202@dhcp22.suse.cz>
References: <1528014138-27674-1-git-send-email-kpark3469@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528014138-27674-1-git-send-email-kpark3469@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03-06-18 12:22:18, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@darkmatter.ae>
> 
> When bd33ef36("mm: enable page poisoning early at boot") got rid of
> the PAGE_EXT_DEBUG_POISON, page_is_poisoned in the header left
> behind. This patch cleans up the leftovers under the table.

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. we tend to use abbrev = 12 for sha1 references.

> Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
> ---
>  include/linux/mm.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c6fa9a2..a53b0ad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2522,12 +2522,10 @@ extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
>  #ifdef CONFIG_PAGE_POISONING
>  extern bool page_poisoning_enabled(void);
>  extern void kernel_poison_pages(struct page *page, int numpages, int enable);
> -extern bool page_is_poisoned(struct page *page);
>  #else
>  static inline bool page_poisoning_enabled(void) { return false; }
>  static inline void kernel_poison_pages(struct page *page, int numpages,
>  					int enable) { }
> -static inline bool page_is_poisoned(struct page *page) { return false; }
>  #endif
>  
>  #ifdef CONFIG_DEBUG_PAGEALLOC
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
