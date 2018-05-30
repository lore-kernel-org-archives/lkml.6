Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbeE3Ec3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:32:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbeE3EcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:32:25 -0400
Subject: Re: [PATCH 2/8] xen/balloon: Move common memory reservation routines
 to a module
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180525153331.31188-1-andr2000@gmail.com>
 <20180525153331.31188-3-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b838fcb8-fa7f-5d75-d536-4dca47bd20aa@suse.com>
Date: Wed, 30 May 2018 06:32:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525153331.31188-3-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/18 17:33, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Memory {increase|decrease}_reservation and VA mappings update/reset
> code used in balloon driver can be made common, so other drivers can
> also re-use the same functionality without open-coding.
> Create a dedicated module for the shared code and export corresponding
> symbols for other kernel modules.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/Makefile          |   1 +
>  drivers/xen/balloon.c         |  71 ++----------------
>  drivers/xen/mem-reservation.c | 134 ++++++++++++++++++++++++++++++++++
>  include/xen/mem_reservation.h |  29 ++++++++
>  4 files changed, 170 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/xen/mem-reservation.c
>  create mode 100644 include/xen/mem_reservation.h

Can you please name this include/xen/mem-reservation.h ?

> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 451e833f5931..3c87b0c3aca6 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
>  obj-$(CONFIG_X86)			+= fallback.o
>  obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
> +obj-y	+= mem-reservation.o
>  obj-y	+= events/
>  obj-y	+= xenbus/
>  
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 065f0b607373..57b482d67a3a 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -71,6 +71,7 @@
>  #include <xen/balloon.h>
>  #include <xen/features.h>
>  #include <xen/page.h>
> +#include <xen/mem_reservation.h>
>  
>  static int xen_hotplug_unpopulated;
>  
> @@ -157,13 +158,6 @@ static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
>  #define GFP_BALLOON \
>  	(GFP_HIGHUSER | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC)
>  
> -static void scrub_page(struct page *page)
> -{
> -#ifdef CONFIG_XEN_SCRUB_PAGES
> -	clear_highpage(page);
> -#endif
> -}
> -
>  /* balloon_append: add the given page to the balloon. */
>  static void __balloon_append(struct page *page)
>  {
> @@ -463,11 +457,6 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  	int rc;
>  	unsigned long i;
>  	struct page   *page;
> -	struct xen_memory_reservation reservation = {
> -		.address_bits = 0,
> -		.extent_order = EXTENT_ORDER,
> -		.domid        = DOMID_SELF
> -	};
>  
>  	if (nr_pages > ARRAY_SIZE(frame_list))
>  		nr_pages = ARRAY_SIZE(frame_list);
> @@ -486,9 +475,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  		page = balloon_next_page(page);
>  	}
>  
> -	set_xen_guest_handle(reservation.extent_start, frame_list);
> -	reservation.nr_extents = nr_pages;
> -	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
> +	rc = xenmem_reservation_increase(nr_pages, frame_list);
>  	if (rc <= 0)
>  		return BP_EAGAIN;
>  
> @@ -496,29 +483,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>  		page = balloon_retrieve(false);
>  		BUG_ON(page == NULL);
>  
> -#ifdef CONFIG_XEN_HAVE_PVMMU
> -		/*
> -		 * We don't support PV MMU when Linux and Xen is using
> -		 * different page granularity.
> -		 */
> -		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> -
> -		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> -			unsigned long pfn = page_to_pfn(page);
> -
> -			set_phys_to_machine(pfn, frame_list[i]);
> -
> -			/* Link back into the page tables if not highmem. */
> -			if (!PageHighMem(page)) {
> -				int ret;
> -				ret = HYPERVISOR_update_va_mapping(
> -						(unsigned long)__va(pfn << PAGE_SHIFT),
> -						mfn_pte(frame_list[i], PAGE_KERNEL),
> -						0);
> -				BUG_ON(ret);
> -			}
> -		}
> -#endif
> +		xenmem_reservation_va_mapping_update(1, &page, &frame_list[i]);
>  
>  		/* Relinquish the page back to the allocator. */
>  		free_reserved_page(page);
> @@ -535,11 +500,6 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  	unsigned long i;
>  	struct page *page, *tmp;
>  	int ret;
> -	struct xen_memory_reservation reservation = {
> -		.address_bits = 0,
> -		.extent_order = EXTENT_ORDER,
> -		.domid        = DOMID_SELF
> -	};
>  	LIST_HEAD(pages);
>  
>  	if (nr_pages > ARRAY_SIZE(frame_list))
> @@ -553,7 +513,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  			break;
>  		}
>  		adjust_managed_page_count(page, -1);
> -		scrub_page(page);
> +		xenmem_reservation_scrub_page(page);
>  		list_add(&page->lru, &pages);
>  	}
>  
> @@ -575,25 +535,8 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  		/* XENMEM_decrease_reservation requires a GFN */
>  		frame_list[i++] = xen_page_to_gfn(page);
>  
> -#ifdef CONFIG_XEN_HAVE_PVMMU
> -		/*
> -		 * We don't support PV MMU when Linux and Xen is using
> -		 * different page granularity.
> -		 */
> -		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> -
> -		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> -			unsigned long pfn = page_to_pfn(page);
> +		xenmem_reservation_va_mapping_reset(1, &page);
>  
> -			if (!PageHighMem(page)) {
> -				ret = HYPERVISOR_update_va_mapping(
> -						(unsigned long)__va(pfn << PAGE_SHIFT),
> -						__pte_ma(0), 0);
> -				BUG_ON(ret);
> -			}
> -			__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
> -		}
> -#endif
>  		list_del(&page->lru);
>  
>  		balloon_append(page);
> @@ -601,9 +544,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>  
>  	flush_tlb_all();
>  
> -	set_xen_guest_handle(reservation.extent_start, frame_list);
> -	reservation.nr_extents   = nr_pages;
> -	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
> +	ret = xenmem_reservation_decrease(nr_pages, frame_list);
>  	BUG_ON(ret != nr_pages);
>  
>  	balloon_stats.current_pages -= nr_pages;
> diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
> new file mode 100644
> index 000000000000..29882e4324f5
> --- /dev/null
> +++ b/drivers/xen/mem-reservation.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +/******************************************************************************
> + * Xen memory reservation utilities.
> + *
> + * Copyright (c) 2003, B Dragovic
> + * Copyright (c) 2003-2004, M Williamson, K Fraser
> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
> + * Copyright (c) 2010 Daniel Kiper
> + * Copyright (c) 2018, Oleksandr Andrushchenko, EPAM Systems Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include <asm/tlb.h>
> +#include <asm/xen/hypercall.h>
> +
> +#include <xen/interface/memory.h>
> +#include <xen/page.h>
> +
> +/*
> + * Use one extent per PAGE_SIZE to avoid to break down the page into
> + * multiple frame.
> + */
> +#define EXTENT_ORDER (fls(XEN_PFN_PER_PAGE) - 1)
> +
> +void xenmem_reservation_scrub_page(struct page *page)
> +{
> +#ifdef CONFIG_XEN_SCRUB_PAGES
> +	clear_highpage(page);
> +#endif
> +}
> +EXPORT_SYMBOL(xenmem_reservation_scrub_page);

EXPORT_SYMBOL_GPL()

Multiple times below, too.

As a general rule of thumb: new exports should all be
EXPORT_SYMBOL_GPL() if you can't give a reason why they shouldn't be.


Juergen
