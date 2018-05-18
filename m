Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeERWQD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:16:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeERWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:16:02 -0400
Subject: Re: [Xen-devel][RFC 2/3] xen/grant-table: Extend API to work with DMA
 buffers
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180517082604.14828-1-andr2000@gmail.com>
 <20180517082604.14828-3-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <28532709-6c87-f048-be6a-3c4ba02ae56f@oracle.com>
Date: Fri, 18 May 2018 18:19:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517082604.14828-3-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=763
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 04:26 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/grant-table.c | 49 +++++++++++++++++++++++++++++++++++++++
>  include/xen/grant_table.h |  7 ++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index bb36b1e1dbcc..c27bcc420575 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -729,6 +729,55 @@ void gnttab_free_pages(int nr_pages, struct page **pages)
>  }
>  EXPORT_SYMBOL(gnttab_free_pages);
>  
> +int gnttab_dma_alloc_pages(struct device *dev, bool coherent,
> +			   int nr_pages, struct page **pages,
> +			   void **vaddr, dma_addr_t *dev_bus_addr)
> +{
> +	int i;
> +	int ret;
> +
> +	ret = alloc_dma_xenballooned_pages(dev, coherent, nr_pages, pages,
> +					   vaddr, dev_bus_addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +#if BITS_PER_LONG < 64
> +		struct xen_page_foreign *foreign;
> +
> +		foreign = kzalloc(sizeof(*foreign), GFP_KERNEL);
> +		if (!foreign) {
> +			gnttab_dma_free_pages(dev, flags, nr_pages, pages,
> +					      *vaddr, *dev_bus_addr);
> +			return -ENOMEM;
> +		}
> +		set_page_private(pages[i], (unsigned long)foreign);
> +#endif
> +		SetPagePrivate(pages[i]);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(gnttab_dma_alloc_pages);
> +
> +void gnttab_dma_free_pages(struct device *dev, bool coherent,
> +			   int nr_pages, struct page **pages,
> +			   void *vaddr, dma_addr_t dev_bus_addr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (PagePrivate(pages[i])) {
> +#if BITS_PER_LONG < 64
> +			kfree((void *)page_private(pages[i]));
> +#endif
> +			ClearPagePrivate(pages[i]);
> +		}
> +	}
> +	free_dma_xenballooned_pages(dev, coherent, nr_pages, pages,
> +				    vaddr, dev_bus_addr);
> +}
> +EXPORT_SYMBOL(gnttab_dma_free_pages);


Given that these routines look almost exactly like their non-dma
counterparts I wonder whether common code could be factored out.

-boris




> +
>  /* Handling of paged out grant targets (GNTST_eagain) */
>  #define MAX_DELAY 256
>  static inline void
> diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
> index 34b1379f9777..20ee2b5ba965 100644
> --- a/include/xen/grant_table.h
> +++ b/include/xen/grant_table.h
> @@ -195,6 +195,13 @@ void gnttab_free_auto_xlat_frames(void);
>  int gnttab_alloc_pages(int nr_pages, struct page **pages);
>  void gnttab_free_pages(int nr_pages, struct page **pages);
>  
> +int gnttab_dma_alloc_pages(struct device *dev, bool coherent,
> +			   int nr_pages, struct page **pages,
> +			   void **vaddr, dma_addr_t *dev_bus_addr);
> +void gnttab_dma_free_pages(struct device *dev, bool coherent,
> +			   int nr_pages, struct page **pages,
> +			   void *vaddr, dma_addr_t dev_bus_addr);
> +
>  int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
>  		    struct gnttab_map_grant_ref *kmap_ops,
>  		    struct page **pages, unsigned int count);
