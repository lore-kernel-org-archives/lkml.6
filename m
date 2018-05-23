Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934796AbeEWTvX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:51:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbeEWTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:51:21 -0400
Date: Wed, 23 May 2018 12:51:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 10/10] mm/memory_hotplug: allow online/offline memory
 by a kernel module
Message-ID: <20180523195119.GA20852@infradead.org>
References: <20180523151151.6730-1-david@redhat.com>
 <20180523151151.6730-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523151151.6730-11-david@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 05:11:51PM +0200, David Hildenbrand wrote:
> Kernel modules that want to control how/when memory is onlined/offlined
> need a proper interface to these functions. Also, for adding memory
> properly, memory_block_size_bytes is required.

Which module?  Please send it along with the enabling code.

> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -88,6 +88,7 @@ unsigned long __weak memory_block_size_bytes(void)
>  {
>  	return MIN_MEMORY_BLOCK_SIZE;
>  }
> +EXPORT_SYMBOL(memory_block_size_bytes);

> +EXPORT_SYMBOL(mem_hotplug_begin);

> +EXPORT_SYMBOL(mem_hotplug_done);

EXPORT_SYMBOL_GPL for any deep down VM internals, please.
