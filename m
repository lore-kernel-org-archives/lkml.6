Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2037081-1518460981-2-1600890710929264712
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518460980; b=vLSn8fdOS2IYeVwGQSotaHKnzg+n/0dc1+aBmGluvUYTnOF
    EwUnUtwcbETch6AmJK6yD8RVUT4SCTtvh5PdSEwz6OxYe515c9DOSf0dCZwWMrO0
    vsb+dxQXSxn/mvcCu89BJLs9L90zSYmfOlrUVNfvRAu8RZla+AOjZ7c2BSGn5y2O
    CQ4mrhYYDjsioUjzuSBrGFyvcBmgMtKJBDl8jGkd7sSgCxiP3uzm9vzgo14Ahoue
    dZzNBW1OzB76g18hAJrRN3Yo0cLtk7PzBqc2Xq7JZ9Yqo1hBcMf+rTPI7LIUebKV
    mWyh0FLWWR0PKwzsxNjuV32/NMEt4uiFjc/rgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518460980; bh=RMu6XIyvfPY4IPmJG8Hsfep2BRKdTMtr5N3D23OrtlU=; b=G
    /JtPCTLKLUFzU1ASTBBV2w0rLjDHUV35cBXXbjIdJ5TlQKjpNgJnRDwn1ORvV+SR
    f7uPK0dSNBcXFy2YHpb62iFKvVL2DOqbykSSQL3ldjU9V+FYoyd4ECjx2c4J/nJ4
    5gx8v8y7/0kbsxBcQHzgdfw008/TgEdM0Gb2deFDGo1oQMAUf+VPwL0+6zkile90
    WfhSqhTsDxWuwiA1W2Xp3kJJEe8KY95B1+IgX0+noptqWOkydoEgXsNe6HEfsZ0h
    x9vSAMwgF7FGqfaGg9yPO3mUKXyvs9cKG0krNd+HMsikjT4M++FMKvivLWH66jNq
    n+CVWovwShFnwB3DtMo0Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ridP7XhE;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ridP7XhE;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226j7JKy0tznzo8a7gHhkzcBh/cIZD56Yr7CTVAB2MkeXpuRkbDpRCkbNv1I6vgNDi5ioopsyA==
Subject: Re: [PATCH] staging: android: ion: Add requested allocation alignment
To: Alexey Skidanov <alexey.skidanov@intel.com>, sumit.semwal@linaro.org,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, devel@driverdev.osuosl.org
References: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <ae413008-6c8b-5e53-9251-d11f4ae9713a@redhat.com>
Date: Mon, 12 Feb 2018 10:42:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/10/2018 02:17 AM, Alexey Skidanov wrote:
> Current ion defined allocation ioctl doesn't allow to specify the requested
> allocation alignment. CMA heap allocates buffers aligned on buffer size
> page order.
> 
> Sometimes, the alignment requirement is less restrictive. In such cases,
> providing specific alignment may reduce the external memory fragmentation
> and in some cases it may avoid the allocation request failure.
> 

I really do not want to bring this back as part of the regular
ABI. Having an alignment parameter that gets used for exactly
one heap only leads to confusion (which is why it was removed
from the ABI in the first place).

The alignment came from the behavior of the DMA APIs. Do you
actually need to specify any alignment from userspace or do
you only need page size?

Thanks,
Laura

> To fix this, we add an alignment parameter to the allocation ioctl.
> 
> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
> ---
>   drivers/staging/android/ion/ion-ioctl.c         |  3 ++-
>   drivers/staging/android/ion/ion.c               | 14 +++++++++-----
>   drivers/staging/android/ion/ion.h               |  9 ++++++---
>   drivers/staging/android/ion/ion_carveout_heap.c |  3 ++-
>   drivers/staging/android/ion/ion_chunk_heap.c    |  3 ++-
>   drivers/staging/android/ion/ion_cma_heap.c      | 18 ++++++++++++------
>   drivers/staging/android/ion/ion_system_heap.c   |  6 ++++--
>   drivers/staging/android/uapi/ion.h              |  7 +++----
>   8 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
> index c789893..9fe022b 100644
> --- a/drivers/staging/android/ion/ion-ioctl.c
> +++ b/drivers/staging/android/ion/ion-ioctl.c
> @@ -83,7 +83,8 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   
>   		fd = ion_alloc(data.allocation.len,
>   			       data.allocation.heap_id_mask,
> -			       data.allocation.flags);
> +			       data.allocation.flags,
> +			       data.allocation.align);
>   		if (fd < 0)
>   			return fd;
>   
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index f480885..35ddc7a 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -78,7 +78,8 @@ static void ion_buffer_add(struct ion_device *dev,
>   static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>   					    struct ion_device *dev,
>   					    unsigned long len,
> -					    unsigned long flags)
> +					    unsigned long flags,
> +					    unsigned int align)
>   {
>   	struct ion_buffer *buffer;
>   	int ret;
> @@ -90,14 +91,14 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>   	buffer->heap = heap;
>   	buffer->flags = flags;
>   
> -	ret = heap->ops->allocate(heap, buffer, len, flags);
> +	ret = heap->ops->allocate(heap, buffer, len, flags, align);
>   
>   	if (ret) {
>   		if (!(heap->flags & ION_HEAP_FLAG_DEFER_FREE))
>   			goto err2;
>   
>   		ion_heap_freelist_drain(heap, 0);
> -		ret = heap->ops->allocate(heap, buffer, len, flags);
> +		ret = heap->ops->allocate(heap, buffer, len, flags, align);
>   		if (ret)
>   			goto err2;
>   	}
> @@ -390,7 +391,10 @@ static const struct dma_buf_ops dma_buf_ops = {
>   	.unmap = ion_dma_buf_kunmap,
>   };
>   
> -int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
> +int ion_alloc(size_t len,
> +	      unsigned int heap_id_mask,
> +	      unsigned int flags,
> +	      unsigned int align)
>   {
>   	struct ion_device *dev = internal_dev;
>   	struct ion_buffer *buffer = NULL;
> @@ -417,7 +421,7 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   		/* if the caller didn't specify this heap id */
>   		if (!((1 << heap->id) & heap_id_mask))
>   			continue;
> -		buffer = ion_buffer_create(heap, dev, len, flags);
> +		buffer = ion_buffer_create(heap, dev, len, flags, align);
>   		if (!IS_ERR(buffer))
>   			break;
>   	}
> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
> index f5f9cd6..0c161d2 100644
> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -123,8 +123,10 @@ struct ion_device {
>    */
>   struct ion_heap_ops {
>   	int (*allocate)(struct ion_heap *heap,
> -			struct ion_buffer *buffer, unsigned long len,
> -			unsigned long flags);
> +			struct ion_buffer *buffer,
> +			unsigned long len,
> +			unsigned long flags,
> +			unsigned int align);
>   	void (*free)(struct ion_buffer *buffer);
>   	void * (*map_kernel)(struct ion_heap *heap, struct ion_buffer *buffer);
>   	void (*unmap_kernel)(struct ion_heap *heap, struct ion_buffer *buffer);
> @@ -228,7 +230,8 @@ int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
>   
>   int ion_alloc(size_t len,
>   	      unsigned int heap_id_mask,
> -	      unsigned int flags);
> +	      unsigned int flags,
> +	      unsigned int align);
>   
>   /**
>    * ion_heap_init_shrinker
> diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
> index fee7650..deae9dd 100644
> --- a/drivers/staging/android/ion/ion_carveout_heap.c
> +++ b/drivers/staging/android/ion/ion_carveout_heap.c
> @@ -59,7 +59,8 @@ static void ion_carveout_free(struct ion_heap *heap, phys_addr_t addr,
>   static int ion_carveout_heap_allocate(struct ion_heap *heap,
>   				      struct ion_buffer *buffer,
>   				      unsigned long size,
> -				      unsigned long flags)
> +				      unsigned long flags,
> +				      unsigned int align)
>   {
>   	struct sg_table *table;
>   	phys_addr_t paddr;
> diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
> index 102c093..15f9518 100644
> --- a/drivers/staging/android/ion/ion_chunk_heap.c
> +++ b/drivers/staging/android/ion/ion_chunk_heap.c
> @@ -35,7 +35,8 @@ struct ion_chunk_heap {
>   static int ion_chunk_heap_allocate(struct ion_heap *heap,
>   				   struct ion_buffer *buffer,
>   				   unsigned long size,
> -				   unsigned long flags)
> +				   unsigned long flags,
> +				   unsigned int align)
>   {
>   	struct ion_chunk_heap *chunk_heap =
>   		container_of(heap, struct ion_chunk_heap, heap);
> diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
> index 86196ff..f3f8deb 100644
> --- a/drivers/staging/android/ion/ion_cma_heap.c
> +++ b/drivers/staging/android/ion/ion_cma_heap.c
> @@ -32,25 +32,31 @@ struct ion_cma_heap {
>   #define to_cma_heap(x) container_of(x, struct ion_cma_heap, heap)
>   
>   /* ION CMA heap operations functions */
> -static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
> +static int ion_cma_allocate(struct ion_heap *heap,
> +			    struct ion_buffer *buffer,
>   			    unsigned long len,
> -			    unsigned long flags)
> +			    unsigned long flags,
> +			    unsigned int align)
>   {
>   	struct ion_cma_heap *cma_heap = to_cma_heap(heap);
>   	struct sg_table *table;
>   	struct page *pages;
>   	unsigned long size = PAGE_ALIGN(len);
>   	unsigned long nr_pages = size >> PAGE_SHIFT;
> -	unsigned long align = get_order(size);
> +	int order = get_order(align);
>   	int ret;
>   
> -	if (align > CONFIG_CMA_ALIGNMENT)
> -		align = CONFIG_CMA_ALIGNMENT;
> +	/* CMA allocation alignment is in PAGE_SIZE order */
> +	if (order > CONFIG_CMA_ALIGNMENT)
> +		order = CONFIG_CMA_ALIGNMENT;
>   
> -	pages = cma_alloc(cma_heap->cma, nr_pages, align, GFP_KERNEL);
> +	pages = cma_alloc(cma_heap->cma, nr_pages, order, GFP_KERNEL);
>   	if (!pages)
>   		return -ENOMEM;
>   
> +	pr_debug("Allocated block of %lu pages starting at 0x%lX",
> +		 nr_pages, page_to_pfn(pages));
> +
>   	table = kmalloc(sizeof(*table), GFP_KERNEL);
>   	if (!table)
>   		goto err;
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 4dc5d7a..b5a1720 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -125,7 +125,8 @@ static struct page *alloc_largest_available(struct ion_system_heap *heap,
>   static int ion_system_heap_allocate(struct ion_heap *heap,
>   				    struct ion_buffer *buffer,
>   				    unsigned long size,
> -				    unsigned long flags)
> +				    unsigned long flags,
> +				    unsigned int align)
>   {
>   	struct ion_system_heap *sys_heap = container_of(heap,
>   							struct ion_system_heap,
> @@ -363,7 +364,8 @@ device_initcall(ion_system_heap_create);
>   static int ion_system_contig_heap_allocate(struct ion_heap *heap,
>   					   struct ion_buffer *buffer,
>   					   unsigned long len,
> -					   unsigned long flags)
> +					   unsigned long flags,
> +					   unsigned int align)
>   {
>   	int order = get_order(len);
>   	struct page *page;
> diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
> index 9e21451..b093edd 100644
> --- a/drivers/staging/android/uapi/ion.h
> +++ b/drivers/staging/android/uapi/ion.h
> @@ -70,9 +70,8 @@ enum ion_heap_type {
>    * @len:		size of the allocation
>    * @heap_id_mask:	mask of heap ids to allocate from
>    * @flags:		flags passed to heap
> - * @handle:		pointer that will be populated with a cookie to use to
> - *			refer to this allocation
> - *
> + * @fd:		file descriptor associated with newly allocated buffer
> + * @align:	allocation alignment
>    * Provided by userspace as an argument to the ioctl
>    */
>   struct ion_allocation_data {
> @@ -80,7 +79,7 @@ struct ion_allocation_data {
>   	__u32 heap_id_mask;
>   	__u32 flags;
>   	__u32 fd;
> -	__u32 unused;
> +	__u32 align;
>   };
>   
>   #define MAX_HEAP_NAME			32
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
