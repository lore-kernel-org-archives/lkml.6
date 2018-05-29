Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965662AbeE2SBk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:01:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965391AbeE2SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:01:36 -0400
Subject: Re: [PATCH 2/8] xen/balloon: Move common memory reservation routines
 to a module
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180525153331.31188-1-andr2000@gmail.com>
 <20180525153331.31188-3-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <59ab73b0-967b-a82f-3b0d-95f1b0dc40a5@oracle.com>
Date: Tue, 29 May 2018 14:04:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525153331.31188-3-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 11:33 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Memory {increase|decrease}_reservation and VA mappings update/reset
> code used in balloon driver can be made common, so other drivers can
> also re-use the same functionality without open-coding.
> Create a dedicated module 

IIUIC this is not really a module, it's a common file.


> for the shared code and export corresponding
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


Can you make a single call to xenmem_reservation_va_mapping_update(rc,
...)? You need to keep track of pages but presumable they can be put
into an array (or a list). In fact, perhaps we can have
balloon_retrieve() return a set of pages.




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


and here too.


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


Why is this "OR MIT"? The original file was licensed GPLv2 only.


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
> +
> +void xenmem_reservation_va_mapping_update(unsigned long count,
> +					  struct page **pages,
> +					  xen_pfn_t *frames)
> +{
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		struct page *page;
> +
> +		page = pages[i];
> +		BUG_ON(page == NULL);
> +
> +		/*
> +		 * We don't support PV MMU when Linux and Xen is using
> +		 * different page granularity.
> +		 */
> +		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> +
> +		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> +			unsigned long pfn = page_to_pfn(page);
> +
> +			set_phys_to_machine(pfn, frames[i]);
> +
> +			/* Link back into the page tables if not highmem. */
> +			if (!PageHighMem(page)) {
> +				int ret;
> +
> +				ret = HYPERVISOR_update_va_mapping(
> +						(unsigned long)__va(pfn << PAGE_SHIFT),
> +						mfn_pte(frames[i], PAGE_KERNEL),
> +						0);
> +				BUG_ON(ret);
> +			}
> +		}
> +	}
> +#endif
> +}
> +EXPORT_SYMBOL(xenmem_reservation_va_mapping_update);
> +
> +void xenmem_reservation_va_mapping_reset(unsigned long count,
> +					 struct page **pages)
> +{
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		/*
> +		 * We don't support PV MMU when Linux and Xen is using
> +		 * different page granularity.
> +		 */
> +		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
> +
> +		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
> +			struct page *page = pages[i];
> +			unsigned long pfn = page_to_pfn(page);
> +
> +			if (!PageHighMem(page)) {
> +				int ret;
> +
> +				ret = HYPERVISOR_update_va_mapping(
> +						(unsigned long)__va(pfn << PAGE_SHIFT),
> +						__pte_ma(0), 0);
> +				BUG_ON(ret);
> +			}
> +			__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
> +		}
> +	}
> +#endif
> +}
> +EXPORT_SYMBOL(xenmem_reservation_va_mapping_reset);
> +
> +int xenmem_reservation_increase(int count, xen_pfn_t *frames)
> +{
> +	struct xen_memory_reservation reservation = {
> +		.address_bits = 0,
> +		.extent_order = EXTENT_ORDER,
> +		.domid        = DOMID_SELF
> +	};
> +
> +	set_xen_guest_handle(reservation.extent_start, frames);
> +	reservation.nr_extents = count;
> +	return HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
> +}
> +EXPORT_SYMBOL(xenmem_reservation_increase);
> +
> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames)
> +{
> +	struct xen_memory_reservation reservation = {
> +		.address_bits = 0,
> +		.extent_order = EXTENT_ORDER,
> +		.domid        = DOMID_SELF
> +	};
> +
> +	set_xen_guest_handle(reservation.extent_start, frames);
> +	reservation.nr_extents = count;
> +	return HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
> +}
> +EXPORT_SYMBOL(xenmem_reservation_decrease);
> diff --git a/include/xen/mem_reservation.h b/include/xen/mem_reservation.h
> new file mode 100644
> index 000000000000..9306d9b8743c
> --- /dev/null
> +++ b/include/xen/mem_reservation.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */

and here too.


-boris


> +
> +/*
> + * Xen memory reservation utilities.
> + *
> + * Copyright (c) 2003, B Dragovic
> + * Copyright (c) 2003-2004, M Williamson, K Fraser
> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
> + * Copyright (c) 2010 Daniel Kiper
> + * Copyright (c) 2018, Oleksandr Andrushchenko, EPAM Systems Inc.
> + */
> +
> +#ifndef _XENMEM_RESERVATION_H
> +#define _XENMEM_RESERVATION_H
> +
> +void xenmem_reservation_scrub_page(struct page *page);
> +
> +void xenmem_reservation_va_mapping_update(unsigned long count,
> +					  struct page **pages,
> +					  xen_pfn_t *frames);
> +
> +void xenmem_reservation_va_mapping_reset(unsigned long count,
> +					 struct page **pages);
> +
> +int xenmem_reservation_increase(int count, xen_pfn_t *frames);
> +
> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
> +
> +#endif
