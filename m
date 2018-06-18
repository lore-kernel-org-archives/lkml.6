Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFF82083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PmYIcHXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFF82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935443AbeFRRVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:21:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbeFRRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R2/XQ1TMiQoV9vTqGhJPmvQYUHOxnlYsEgJJvd/vI3w=; b=PmYIcHXgiVhd8jGydYaIz4oez
        LP4G3tVyn86UP3JJBevqW8sxYZgubEDeH62zFDiDKNhqb7DJ+9/I/BC5S+Wrkw/7+1J1Wx5+Wq83P
        trcipOX3r5QO7bpm1TixjTZ9i4X2rSqgVPtibBSZIesHLEm6DTyY2jPtbox62PxyATcFCscLtCZyE
        bhyQU9Suv2YS421lUzTr+eoLP6tG8SpSDDuDmyWYMIIGcBMHR74Cl9oqEGiQ36BoyBlHN34QBJTFg
        aQKSr/fSSyDjVzZamfj8ET9ZVym8At8370AiSTwMUJXTyHUYcksup8veNDcmwsa3fMnYx1yE2uvSv
        jsQZnqV6A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUxqO-0002eQ-2y; Mon, 18 Jun 2018 17:21:32 +0000
Subject: Re: [PATCH 10/11] docs/mm: memblock: add overview documentation
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1529341199-17682-11-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fd545e61-6ccc-58b6-e9be-4e7f180c2ca9@infradead.org>
Date:   Mon, 18 Jun 2018 10:21:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529341199-17682-11-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/18/2018 09:59 AM, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  mm/memblock.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c4838a9..8bfeb82 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -26,6 +26,61 @@
>  
>  #include "internal.h"
>  
> +/**
> + * DOC: memblock overview
> + *
> + * Memblock is a method of managing memory regions during the early
> + * boot period when the usual kernel memory allocators are not up and
> + * running.
> + *
> + * Memblock views the system memory as collections of contiguous
> + * regions. There are several types of these collections:
> + *
> + * * ``memory`` - describes the physical memory available to the
> + *   kernel; this may differ from the actual physical memory installed
> + *   in the system, for instance when the memory is restricted with
> + *   ``mem=`` command line parameter
> + * * ``reserved`` - describes the regions that were allocated
> + * * ``physmap`` - describes the actual physical memory regardless of
> + *   the possible restrictions; the ``physmap`` type is only available
> + *   on some architectures.
> + *
> + * Each region is represented by :c:type:`struct memblock_region` that
> + * defines the region extents, its attributes and NUMA node id on NUMA
> + * systems. Every memory type is described by the :c:type:`struct
> + * memblock_type` which contains an array of memory regions along with
> + * the allocator metadata. The memory types are nicely wrapped with
> + * :c:type:`struct memblock`. This structure is statically initialzed
> + * at build time. The region arrays for the "memory" and "reserved"
> + * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
> + * "physmap" type to %INIT_PHYSMEM_REGIONS.
> + * The :c:func:`memblock_allow_resize` enables automatic resizing of
> + * the region arrays during addition of new regions. This feature
> + * should be used with care so that memory allocated for the region
> + * array will not overlap with areas that should be reserved, for
> + * example initrd.
> + *
> + * The early architecture setup should tell memblock what is the

      The early architecture setup should tell memblock what the physical
      memory layout is by using :c:func:`memblock_add` or

> + * physical memory layout using :c:func:`memblock_add` or
> + * :c:func:`memblock_add_node` functions. The first function does not
> + * assign the region to a NUMA node and it is approptiate for UMA

                                                 appropriate

> + * systems. Yet, it is possible to use it on NUMA systems as well and
> + * assign the region to a NUMA node later in the setup process using
> + * :c:func:`memblock_set_node`. The :c:func:`memblock_add_node`
> + * performs such an assignment directly.
> + *
> + * Once memblock is setup the memory can be allocated using either
> + * memblock or bootmem APIs.
> + *
> + * As the system boot progresses, the architecture specific
> + * :c:func:`mem_init` function frees all the memory to the buddy page
> + * allocator.
> + *
> + * If an architecure enables %CONFIG_ARCH_DISCARD_MEMBLOCK, the
> + * memblock data structures will be discarded after the system
> + * intialization compltes

      initialization completes.

> + */
> +
>  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>  static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> 


-- 
~Randy
