Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335EEC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E127C2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E127C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJDQon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:44:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31189 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbeJDQon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:44:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A3B083F3D;
        Thu,  4 Oct 2018 09:52:14 +0000 (UTC)
Received: from [10.36.117.44] (ovpn-117-44.ams2.redhat.com [10.36.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7772F2CE5C;
        Thu,  4 Oct 2018 09:52:10 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/5] mm/memory_hotplug: Add nid parameter to
 arch_remove_memory
To:     Oscar Salvador <osalvador@techadventures.net>, linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        dave.jiang@intel.com, Oscar Salvador <osalvador@suse.de>
References: <20181002150029.23461-1-osalvador@techadventures.net>
 <20181002150029.23461-2-osalvador@techadventures.net>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <df5ebe1d-2fd9-3015-321a-378bb160c4f0@redhat.com>
Date:   Thu, 4 Oct 2018 11:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002150029.23461-2-osalvador@techadventures.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Oct 2018 09:52:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 17:00, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> This patch is only a preparation for the following-up patches.
> The idea of passing the nid is that will allow us to get rid
> of the zone parameter in the patches that follow
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/ia64/mm/init.c            | 2 +-
>  arch/powerpc/mm/mem.c          | 2 +-
>  arch/s390/mm/init.c            | 2 +-
>  arch/sh/mm/init.c              | 2 +-
>  arch/x86/mm/init_32.c          | 2 +-
>  arch/x86/mm/init_64.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 +-
>  kernel/memremap.c              | 4 +++-
>  mm/memory_hotplug.c            | 2 +-
>  9 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index d5e12ff1d73c..904fe55e10fc 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -661,7 +661,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 578cbb262c01..445fce705f91 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -138,7 +138,7 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -int __meminit arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +int __meminit arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index e472cd763eb3..f705da1a085f 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -239,7 +239,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>  	/*
>  	 * There is no hardware or firmware interface which could trigger a
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index c8c13c777162..a8e5c0e00fca 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -443,7 +443,7 @@ EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  #endif
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn = PFN_DOWN(start);
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index f2837e4c40b3..b2a698d87a0e 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -860,7 +860,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 5fab264948c2..c754d9543ae1 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1147,7 +1147,7 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
>  	remove_pagetable(start, end, true, NULL);
>  }
>  
> -int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +int __ref arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index ffd9cd10fcf3..f9fc35819e65 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -107,7 +107,7 @@ static inline bool movable_node_is_enabled(void)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -extern int arch_remove_memory(u64 start, u64 size,
> +extern int arch_remove_memory(int nid, u64 start, u64 size,
>  		struct vmem_altmap *altmap);
>  extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
>  	unsigned long nr_pages, struct vmem_altmap *altmap);
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index e3036433ce4e..fe54bba2d7e2 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -121,6 +121,7 @@ static void devm_memremap_pages_release(void *data)
>  	struct resource *res = &pgmap->res;
>  	resource_size_t align_start, align_size;
>  	unsigned long pfn;
> +	int nid;
>  
>  	pgmap->kill(pgmap->ref);
>  	for_each_device_pfn(pfn, pgmap)
> @@ -130,6 +131,7 @@ static void devm_memremap_pages_release(void *data)
>  	align_start = res->start & ~(SECTION_SIZE - 1);
>  	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
>  		- align_start;
> +	nid = dev_to_node(dev);
>  
>  	mem_hotplug_begin();
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> @@ -137,7 +139,7 @@ static void devm_memremap_pages_release(void *data)
>  		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
>  				align_size >> PAGE_SHIFT, NULL);
>  	} else {
> -		arch_remove_memory(align_start, align_size,
> +		arch_remove_memory(nid, align_start, align_size,
>  				pgmap->altmap_valid ? &pgmap->altmap : NULL);
>  		kasan_remove_zero_shadow(__va(align_start), align_size);
>  	}
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d4c7e42e46f3..11b7dcf83323 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1890,7 +1890,7 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  	memblock_free(start, size);
>  	memblock_remove(start, size);
>  
> -	arch_remove_memory(start, size, NULL);
> +	arch_remove_memory(nid, start, size, NULL);
>  
>  	try_offline_node(nid);
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
