Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B4CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3942177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBHWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:40:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:40:49 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7ADF6CA08;
        Fri,  8 Feb 2019 22:40:48 +0000 (UTC)
Date:   Fri, 8 Feb 2019 14:40:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: update comments and kernel-doc
Message-Id: <20190208144047.66254b6d08edfea462e6466a@linux-foundation.org>
In-Reply-To: <1549626347-25461-1-git-send-email-rppt@linux.ibm.com>
References: <1549626347-25461-1-git-send-email-rppt@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Feb 2019 13:45:47 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:

> * Remove comments mentioning bootmem
> * Extend "DOC: memblock overview"
> * Add kernel-doc comments for several more functions
> 
> ...
>
> @@ -1400,6 +1413,19 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE);
>  }
>  
> +/**
> + * memblock_phys_alloc_range - allocate a memory block from specified MUMA node
> + * @size: size of memory block to be allocated in bytes
> + * @align: alignment of the region and block's size
> + * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> + *
> + * Allocates memory block from the specified NUMA node. If the node
> + * has no available memory, attempts to allocated from any node in the
> + * system.
> + *
> + * Return: physical address of the allocated memory block on success,
> + * %0 on failure.
> + */
>  phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
>  {
>  	return memblock_alloc_range_nid(size, align, 0,

copy-n-paste!

--- a/mm/memblock.c~memblock-update-comments-and-kernel-doc-fix
+++ a/mm/memblock.c
@@ -1414,7 +1414,7 @@ phys_addr_t __init memblock_phys_alloc_r
 }
 
 /**
- * memblock_phys_alloc_range - allocate a memory block from specified MUMA node
+ * memblock_phys_alloc_try_nid - allocate a memory block from specified MUMA node
  * @size: size of memory block to be allocated in bytes
  * @align: alignment of the region and block's size
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node

