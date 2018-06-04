Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeFDSmd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:42:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59646 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:42:32 -0400
Subject: Re: [PATCH v2 4/9] xen/grant-table: Allow allocating buffers suitable
 for DMA
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-5-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <9214078e-6e94-e31b-6b36-c066e1aa5e40@oracle.com>
Date: Mon, 4 Jun 2018 14:46:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601114132.22596-5-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Extend grant table module API to allow allocating buffers that can
> be used for DMA operations and mapping foreign grant references
> on top of those.
> The resulting buffer is similar to the one allocated by the balloon
> driver in terms that proper memory reservation is made
> ({increase|decrease}_reservation and VA mappings updated if needed).
> This is useful for sharing foreign buffers with HW drivers which
> cannot work with scattered buffers provided by the balloon driver,
> but require DMAable memory instead.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/Kconfig       |  13 +++++
>  drivers/xen/grant-table.c | 109 ++++++++++++++++++++++++++++++++++++++
>  include/xen/grant_table.h |  18 +++++++
>  3 files changed, 140 insertions(+)
>
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index e5d0c28372ea..39536ddfbce4 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -161,6 +161,19 @@ config XEN_GRANT_DEV_ALLOC
>  	  to other domains. This can be used to implement frontend drivers
>  	  or as part of an inter-domain shared memory channel.
>  
> +config XEN_GRANT_DMA_ALLOC
> +	bool "Allow allocating DMA capable buffers with grant reference module"
> +	depends on XEN && HAS_DMA
> +	help
> +	  Extends grant table module API to allow allocating DMA capable
> +	  buffers and mapping foreign grant references on top of it.
> +	  The resulting buffer is similar to one allocated by the balloon
> +	  driver in terms that proper memory reservation is made
> +	  ({increase|decrease}_reservation and VA mappings updated if needed).
> +	  This is useful for sharing foreign buffers with HW drivers which
> +	  cannot work with scattered buffers provided by the balloon driver,
> +	  but require DMAable memory instead.
> +
>  config SWIOTLB_XEN
>  	def_bool y
>  	select SWIOTLB
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index dbb48a89e987..5658e58d9cc6 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -45,6 +45,9 @@
>  #include <linux/workqueue.h>
>  #include <linux/ratelimit.h>
>  #include <linux/moduleparam.h>
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +#include <linux/dma-mapping.h>
> +#endif
>  
>  #include <xen/xen.h>
>  #include <xen/interface/xen.h>
> @@ -57,6 +60,7 @@
>  #ifdef CONFIG_X86
>  #include <asm/xen/cpuid.h>
>  #endif
> +#include <xen/mem-reservation.h>
>  #include <asm/xen/hypercall.h>
>  #include <asm/xen/interface.h>
>  
> @@ -811,6 +815,73 @@ int gnttab_alloc_pages(int nr_pages, struct page **pages)
>  }
>  EXPORT_SYMBOL_GPL(gnttab_alloc_pages);
>  
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +/**
> + * gnttab_dma_alloc_pages - alloc DMAable pages suitable for grant mapping into
> + * @args: arguments to the function
> + */
> +int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
> +{
> +	unsigned long pfn, start_pfn;
> +	size_t size;
> +	int i, ret;
> +
> +	size = args->nr_pages << PAGE_SHIFT;
> +	if (args->coherent)
> +		args->vaddr = dma_alloc_coherent(args->dev, size,
> +						 &args->dev_bus_addr,
> +						 GFP_KERNEL | __GFP_NOWARN);
> +	else
> +		args->vaddr = dma_alloc_wc(args->dev, size,
> +					   &args->dev_bus_addr,
> +					   GFP_KERNEL | __GFP_NOWARN);
> +	if (!args->vaddr) {
> +		pr_err("Failed to allocate DMA buffer of size %zu\n", size);
> +		return -ENOMEM;
> +	}
> +
> +	start_pfn = __phys_to_pfn(args->dev_bus_addr);
> +	for (pfn = start_pfn, i = 0; pfn < start_pfn + args->nr_pages;
> +			pfn++, i++) {
> +		struct page *page = pfn_to_page(pfn);
> +
> +		args->pages[i] = page;
> +		args->frames[i] = xen_page_to_gfn(page);
> +		xenmem_reservation_scrub_page(page);
> +	}
> +
> +	xenmem_reservation_va_mapping_reset(args->nr_pages, args->pages);
> +
> +	ret = xenmem_reservation_decrease(args->nr_pages, args->frames);
> +	if (ret != args->nr_pages) {
> +		pr_err("Failed to decrease reservation for DMA buffer\n");
> +		ret = -EFAULT;
> +		goto fail_free_dma;
> +	}
> +
> +	ret = gnttab_pages_set_private(args->nr_pages, args->pages);
> +	if (ret < 0)
> +		goto fail_clear_private;
> +
> +	return 0;
> +
> +fail_clear_private:
> +	gnttab_pages_clear_private(args->nr_pages, args->pages);
> +fail_free_dma:
> +	xenmem_reservation_increase(args->nr_pages, args->frames);
> +	xenmem_reservation_va_mapping_update(args->nr_pages, args->pages,
> +					     args->frames);
> +	if (args->coherent)
> +		dma_free_coherent(args->dev, size,
> +				  args->vaddr, args->dev_bus_addr);
> +	else
> +		dma_free_wc(args->dev, size,
> +			    args->vaddr, args->dev_bus_addr);
> +	return ret;
> +}


Would it be possible to call gnttab_dma_free_pages() here?


> +EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
> +#endif
> +
>  void gnttab_pages_clear_private(int nr_pages, struct page **pages)
>  {
>  	int i;
> @@ -838,6 +909,44 @@ void gnttab_free_pages(int nr_pages, struct page **pages)
>  }
>  EXPORT_SYMBOL_GPL(gnttab_free_pages);
>  
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC

I'd move this after (or before) gnttab_dma_alloc_page() to keep both
inside a single ifdef block.

-boris


> +/**
> + * gnttab_dma_free_pages - free DMAable pages
> + * @args: arguments to the function
> + */
> +int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
> +{
> +	size_t size;
> +	int i, ret;
> +
> +	gnttab_pages_clear_private(args->nr_pages, args->pages);
> +
> +	for (i = 0; i < args->nr_pages; i++)
> +		args->frames[i] = page_to_xen_pfn(args->pages[i]);
> +
> +	ret = xenmem_reservation_increase(args->nr_pages, args->frames);
> +	if (ret != args->nr_pages) {
> +		pr_err("Failed to decrease reservation for DMA buffer\n");
> +		ret = -EFAULT;
> +	} else {
> +		ret = 0;
> +	}
> +
> +	xenmem_reservation_va_mapping_update(args->nr_pages, args->pages,
> +					     args->frames);
> +
> +	size = args->nr_pages << PAGE_SHIFT;
> +	if (args->coherent)
> +		dma_free_coherent(args->dev, size,
> +				  args->vaddr, args->dev_bus_addr);
> +	else
> +		dma_free_wc(args->dev, size,
> +			    args->vaddr, args->dev_bus_addr);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
> +#endif
> +
>  /* Handling of paged out grant targets (GNTST_eagain) */
>  #define MAX_DELAY 256
>  static inline void
> diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
> index de03f2542bb7..9bc5bc07d4d3 100644
> --- a/include/xen/grant_table.h
> +++ b/include/xen/grant_table.h
> @@ -198,6 +198,24 @@ void gnttab_free_auto_xlat_frames(void);
>  int gnttab_alloc_pages(int nr_pages, struct page **pages);
>  void gnttab_free_pages(int nr_pages, struct page **pages);
>  
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +struct gnttab_dma_alloc_args {
> +	/* Device for which DMA memory will be/was allocated. */
> +	struct device *dev;
> +	/* If set then DMA buffer is coherent and write-combine otherwise. */
> +	bool coherent;
> +
> +	int nr_pages;
> +	struct page **pages;
> +	xen_pfn_t *frames;
> +	void *vaddr;
> +	dma_addr_t dev_bus_addr;
> +};
> +
> +int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args);
> +int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args);
> +#endif
> +
>  int gnttab_pages_set_private(int nr_pages, struct page **pages);
>  void gnttab_pages_clear_private(int nr_pages, struct page **pages);
>  
