Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFDUJU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:09:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeFDUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:09:18 -0400
Subject: Re: [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA buffers
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-6-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <64facf05-0a51-c3d9-9d3b-780893248628@oracle.com>
Date: Mon, 4 Jun 2018 16:12:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601114132.22596-6-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Allow mappings for DMA backed  buffers if grant table module
> supports such: this extends grant device to not only map buffers
> made of balloon pages, but also from buffers allocated with
> dma_alloc_xxx.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/gntdev.c      | 99 ++++++++++++++++++++++++++++++++++++++-
>  include/uapi/xen/gntdev.h | 15 ++++++
>  2 files changed, 112 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index bd56653b9bbc..9813fc440c70 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -37,6 +37,9 @@
>  #include <linux/slab.h>
>  #include <linux/highmem.h>
>  #include <linux/refcount.h>
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +#include <linux/of_device.h>
> +#endif
>  
>  #include <xen/xen.h>
>  #include <xen/grant_table.h>
> @@ -72,6 +75,11 @@ struct gntdev_priv {
>  	struct mutex lock;
>  	struct mm_struct *mm;
>  	struct mmu_notifier mn;
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	/* Device for which DMA memory is allocated. */
> +	struct device *dma_dev;
> +#endif
>  };
>  
>  struct unmap_notify {
> @@ -96,10 +104,27 @@ struct grant_map {
>  	struct gnttab_unmap_grant_ref *kunmap_ops;
>  	struct page **pages;
>  	unsigned long pages_vm_start;
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	/*
> +	 * If dmabuf_vaddr is not NULL then this mapping is backed by DMA
> +	 * capable memory.
> +	 */
> +
> +	struct device *dma_dev;
> +	/* Flags used to create this DMA buffer: GNTDEV_DMA_FLAG_XXX. */
> +	int dma_flags;
> +	void *dma_vaddr;
> +	dma_addr_t dma_bus_addr;
> +	/* This is required for gnttab_dma_{alloc|free}_pages. */

How about

/* Needed to avoid allocation in gnttab_dma_free_pages(). */

> +	xen_pfn_t *frames;
> +#endif
>  };
>  
>  static int unmap_grant_pages(struct grant_map *map, int offset, int pages);
>  
> +static struct miscdevice gntdev_miscdev;
> +
>  /* ------------------------------------------------------------------ */
>  
>  static void gntdev_print_maps(struct gntdev_priv *priv,
> @@ -121,8 +146,27 @@ static void gntdev_free_map(struct grant_map *map)
>  	if (map == NULL)
>  		return;
>  
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	if (map->dma_vaddr) {
> +		struct gnttab_dma_alloc_args args;
> +
> +		args.dev = map->dma_dev;
> +		args.coherent = map->dma_flags & GNTDEV_DMA_FLAG_COHERENT;
> +		args.nr_pages = map->count;
> +		args.pages = map->pages;
> +		args.frames = map->frames;
> +		args.vaddr = map->dma_vaddr;
> +		args.dev_bus_addr = map->dma_bus_addr;
> +
> +		gnttab_dma_free_pages(&args);
> +	} else
> +#endif
>  	if (map->pages)
>  		gnttab_free_pages(map->count, map->pages);
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	kfree(map->frames);
> +#endif


Can this be done under if (map->dma_vaddr) ? In other words, is it
possible for dma_vaddr to be NULL and still have unallocated frames pointer?


>  	kfree(map->pages);
>  	kfree(map->grants);
>  	kfree(map->map_ops);
> @@ -132,7 +176,8 @@ static void gntdev_free_map(struct grant_map *map)
>  	kfree(map);
>  }
>  
> -static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
> +static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
> +					  int dma_flags)
>  {
>  	struct grant_map *add;
>  	int i;
> @@ -155,6 +200,37 @@ static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
>  	    NULL == add->pages)
>  		goto err;
>  
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	add->dma_flags = dma_flags;
> +
> +	/*
> +	 * Check if this mapping is requested to be backed
> +	 * by a DMA buffer.
> +	 */
> +	if (dma_flags & (GNTDEV_DMA_FLAG_WC | GNTDEV_DMA_FLAG_COHERENT)) {
> +		struct gnttab_dma_alloc_args args;
> +
> +		add->frames = kcalloc(count, sizeof(add->frames[0]),
> +				      GFP_KERNEL);
> +		if (!add->frames)
> +			goto err;
> +
> +		/* Remember the device, so we can free DMA memory. */
> +		add->dma_dev = priv->dma_dev;
> +
> +		args.dev = priv->dma_dev;
> +		args.coherent = dma_flags & GNTDEV_DMA_FLAG_COHERENT;
> +		args.nr_pages = count;
> +		args.pages = add->pages;
> +		args.frames = add->frames;
> +
> +		if (gnttab_dma_alloc_pages(&args))
> +			goto err;
> +
> +		add->dma_vaddr = args.vaddr;
> +		add->dma_bus_addr = args.dev_bus_addr;
> +	} else
> +#endif
>  	if (gnttab_alloc_pages(count, add->pages))
>  		goto err;
>  
> @@ -325,6 +401,14 @@ static int map_grant_pages(struct grant_map *map)
>  		map->unmap_ops[i].handle = map->map_ops[i].handle;
>  		if (use_ptemod)
>  			map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +		else if (map->dma_vaddr) {
> +			unsigned long mfn;
> +
> +			mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));


Not pfn_to_mfn()?


-boris

> +			map->unmap_ops[i].dev_bus_addr = __pfn_to_phys(mfn);
> +		}
> +#endif
>  	}
>  	return err;
>  }
> @@ -548,6 +632,17 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>  	}
>  
>  	flip->private_data = priv;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	priv->dma_dev = gntdev_miscdev.this_device;
> +
> +	/*
> +	 * The device is not spawn from a device tree, so arch_setup_dma_ops
> +	 * is not called, thus leaving the device with dummy DMA ops.
> +	 * Fix this call of_dma_configure() with a NULL node to set
> +	 * default DMA ops.
> +	 */
> +	of_dma_configure(priv->dma_dev, NULL);
> +#endif
>  	pr_debug("priv %p\n", priv);
>  
>  	return 0;
> @@ -589,7 +684,7 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
>  		return -EINVAL;
>  
>  	err = -ENOMEM;
> -	map = gntdev_alloc_map(priv, op.count);
> +	map = gntdev_alloc_map(priv, op.count, 0 /* This is not a dma-buf. */);
>  	if (!map)
>  		return err;
>  
> diff --git a/include/uapi/xen/gntdev.h b/include/uapi/xen/gntdev.h
> index 6d1163456c03..4b9d498a31d4 100644
> --- a/include/uapi/xen/gntdev.h
> +++ b/include/uapi/xen/gntdev.h
> @@ -200,4 +200,19 @@ struct ioctl_gntdev_grant_copy {
>  /* Send an interrupt on the indicated event channel */
>  #define UNMAP_NOTIFY_SEND_EVENT 0x2
>  
> +/*
> + * Flags to be used while requesting memory mapping's backing storage
> + * to be allocated with DMA API.
> + */
> +
> +/*
> + * The buffer is backed with memory allocated with dma_alloc_wc.
> + */
> +#define GNTDEV_DMA_FLAG_WC		(1 << 0)
> +
> +/*
> + * The buffer is backed with memory allocated with dma_alloc_coherent.
> + */
> +#define GNTDEV_DMA_FLAG_COHERENT	(1 << 1)
> +
>  #endif /* __LINUX_PUBLIC_GNTDEV_H__ */
