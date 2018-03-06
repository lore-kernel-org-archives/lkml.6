Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932804AbeCFAAM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:00:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCFAAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:00:11 -0500
Date: Mon, 5 Mar 2018 16:00:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, cpandya@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] memblock: add memblock_free() alloc when
 CONFIG_HAVE_MEMBLOCK is not set
Message-Id: <20180305160009.d24507e7b02ccb8be9dbc091@linux-foundation.org>
In-Reply-To: <1520208889-3908-3-git-send-email-frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
        <1520208889-3908-3-git-send-email-frowand.list@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Mar 2018 16:14:48 -0800 frowand.list@gmail.com wrote:

> From: Frank Rowand <frank.rowand@sony.com>
> 
> When CONFIG_HAVE_MEMBLOCK is not set, an error version of
> memblock_alloc() exists.  Add the matching memblock_free().
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Andrew or Michal, can you please ack this patch to be accepted
> by Rob?
> 
> 
> With "of: add early boot allocation of
> of_find_node_by_phandle() cache" applied, kbuild test robot reports
> tilex architecture build error due to no prototype for memblock_free().
> 
> The version of the patch that kbuild test robot reported was
> "[PATCH v4 2/2] of: add early boot allocation of
> of_find_node_by_phandle() cache".  An updated version of that
> patch is now patch 3/3 of this series.
> 
> ...
>
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -432,6 +432,10 @@ static inline unsigned long memblock_reserved_memory_within(phys_addr_t start_ad
>  	return 0;
>  }
>  
> +static inline int memblock_free(phys_addr_t base, phys_addr_t size)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_HAVE_MEMBLOCK */
>  
>  #endif /* __KERNEL__ */

Acked-by: Andrew Morton <akpm@linux-foundation.org>
