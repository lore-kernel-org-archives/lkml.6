Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeBVHLF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:11:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:50679 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbeBVHLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:11:04 -0500
Date: Thu, 22 Feb 2018 08:11:00 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180222071100.GB30681@dhcp22.suse.cz>
References: <20180222143057.3a1b3746@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222143057.3a1b3746@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-02-18 14:30:57, Stephen Rothwell wrote:
> Hi Andrew,
> 
> [As reported by Randy for uml ...]
> 
> After merging the akpm-current tree, today's linux-next build (sparc
> defconfig) failed like this:
> 
> /home/sfr/next/next/mm/page_alloc.c: In function 'memmap_init_zone':
> /home/sfr/next/next/mm/page_alloc.c:5450:11: error: implicit declaration of function 'memblock_next_valid_pfn'; did you mean 'memblock_virt_alloc_low'? [-Werror=implicit-function-declaration]
>      pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
>            ^~~~~~~~~~~~~~~~~~~~~~~
>            memblock_virt_alloc_low

This is interesting. I thought that IS_ENABLED(CONFIG_HAVE_MEMBLOCK)
would have the same meaning as ifdef CONFIG_HAVE_MEMBLOCK so the branch
will never be considered. If that is not the case then I would rather
reintroduce that ifdef. We already have those in the function anyway.
-- 
Michal Hocko
SUSE Labs
