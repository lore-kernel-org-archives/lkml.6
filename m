Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E01C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCFB2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCFB2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJPQp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:45:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeJPQp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:45:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23204C106577;
        Tue, 16 Oct 2018 08:56:02 +0000 (UTC)
Received: from [10.36.117.196] (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2027A68DB7;
        Tue, 16 Oct 2018 08:55:56 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory
 functions
To:     Oscar Salvador <osalvador@techadventures.net>,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-3-osalvador@techadventures.net>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d0a12eb5-3824-8d25-75f8-3e62f1e81994@redhat.com>
Date:   Tue, 16 Oct 2018 10:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181015153034.32203-3-osalvador@techadventures.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Oct 2018 08:56:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> index 42d79bcc8aab..d3e52ae71bd9 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -996,6 +996,7 @@ static void hmm_devmem_release(struct device *dev, void *data)
>  	struct zone *zone;
>  	struct page *page;
>  	int nid;
> +	bool mapping;
>  
>  	if (percpu_ref_tryget_live(&devmem->ref)) {
>  		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
> @@ -1010,12 +1011,15 @@ static void hmm_devmem_release(struct device *dev, void *data)
>  	zone = page_zone(page);
>  	nid = zone->zone_pgdat->node_id;
>  
> -	mem_hotplug_begin();
>  	if (resource->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
> -		__remove_pages(zone, start_pfn, npages, NULL);
> +		mapping = false;
>  	else
> -		arch_remove_memory(nid, start_pfn << PAGE_SHIFT,
> -				   npages << PAGE_SHIFT, NULL);
> +		mapping = true;
> +
> +	mem_hotplug_begin();
> +	del_device_memory(nid, start_pfn << PAGE_SHIFT, npages << PAGE_SHIFT,
> +								NULL,
> +								mapping);
>  	mem_hotplug_done();
>  
>  	hmm_devmem_radix_release(resource);
> @@ -1026,6 +1030,7 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
>  	resource_size_t key, align_start, align_size, align_end;
>  	struct device *device = devmem->device;
>  	int ret, nid, is_ram;
> +	bool mapping;
>  
>  	align_start = devmem->resource->start & ~(PA_SECTION_SIZE - 1);
>  	align_size = ALIGN(devmem->resource->start +
> @@ -1084,7 +1089,6 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
>  	if (nid < 0)
>  		nid = numa_mem_id();
>  
> -	mem_hotplug_begin();
>  	/*
>  	 * For device private memory we call add_pages() as we only need to
>  	 * allocate and initialize struct page for the device memory. More-
> @@ -1096,20 +1100,17 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
>  	 * want the linear mapping and thus use arch_add_memory().
>  	 */

Some parts of this comment should be moved into add_device_memory now.
(e.g. we call add_pages() ...)

>  	if (devmem->pagemap.type == MEMORY_DEVICE_PUBLIC)
> -		ret = arch_add_memory(nid, align_start, align_size, NULL,
> -				false);
> +		mapping = true;
>  	else
> -		ret = add_pages(nid, align_start >> PAGE_SHIFT,
> -				align_size >> PAGE_SHIFT, NULL, false);
> -	if (ret) {
> -		mem_hotplug_done();
> -		goto error_add_memory;
> -	}
> -	move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> -				align_start >> PAGE_SHIFT,
> -				align_size >> PAGE_SHIFT, NULL);
> +		mapping = false;
> +
> +	mem_hotplug_begin();
> +	ret = add_device_memory(nid, align_start, align_size, NULL, mapping);
>  	mem_hotplug_done();
>  
> +	if (ret)
> +		goto error_add_memory;
> +
>  	/*
>  	 * Initialization of the pages has been deferred until now in order
>  	 * to allow us to do the work while not holding the hotplug lock.
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 33d448314b3f..5874aceb81ac 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1889,4 +1889,45 @@ void remove_memory(int nid, u64 start, u64 size)
>  	unlock_device_hotplug();
>  }
>  EXPORT_SYMBOL_GPL(remove_memory);
> +
> +#ifdef CONFIG_ZONE_DEVICE
> +int del_device_memory(int nid, unsigned long start, unsigned long size,
> +				struct vmem_altmap *altmap, bool mapping)
> +{
> +	int ret;

nit: personally I prefer short parameters last in the list.

> +	unsigned long start_pfn = PHYS_PFN(start);
> +	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	struct zone *zone = page_zone(pfn_to_page(pfn));
> +
> +	if (mapping)
> +		ret = arch_remove_memory(nid, start, size, altmap);
> +	else
> +		ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
> +
> +	return ret;
> +}
> +#endif
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> +
> +#ifdef CONFIG_ZONE_DEVICE
> +int add_device_memory(int nid, unsigned long start, unsigned long size,
> +				struct vmem_altmap *altmap, bool mapping)
> +{
> +	int ret;

dito

> +	unsigned long start_pfn = PHYS_PFN(start);
> +	unsigned long nr_pages = size >> PAGE_SHIFT;
> +
> +	if (mapping)
> +		ret = arch_add_memory(nid, start, size, altmap, false);
> +	else
> +		ret = add_pages(nid, start_pfn, nr_pages, altmap, false);
> +
> +	if (!ret) {
> +		struct zone *zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
> +
> +		move_pfn_range_to_zone(zone, start_pfn, nr_pages, altmap);
> +	}
> +
> +	return ret;
> +}
> +#endif
> 

Can you document for both functions that they should be called with the
memory hotplug lock in write?

Apart from that looks good to me.

-- 

Thanks,

David / dhildenb
