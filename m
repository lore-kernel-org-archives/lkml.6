Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521213301-2-16101739794283807760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213300; b=Z+iruFb0OahRtzQCLOyru8A2L0HxrOGj2bUlQwermelNXVx
    HNSM453eNM3WVBggA2UqnW5CyznWekpIjzF0yT3L7HXzr8tBBkygvHf3EUd0CHdn
    a/qxCnLdXUdOxx6Pe574hw2H4nJ5+giAfAbL+NSqsoLg4OhJtU3AosR6Eb3V+1iV
    fZkoA/87Ioe9/mPFIIEk3Krgyf1Y+hg8Si+Si+WhbBrEcMotL1T8a17DEZSJ6+nq
    zWMV9DoyY226VTO3Jhlf/476iJcfSaejeAMfxD1QVZuxg9NeA1OXxZNWmjGkBatL
    beVfOA2uK09EzLnGpivZ5F/ZSQ5TgZH0mDjxMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521213300; bh=dKsnjMTBUQIb3o0M0WErUYBYuw
    NpshEi/5wGMn3GJsU=; b=Xd3cryuJKaLPADlDpMOw6LPJgPcr130MuSJ4dX8uUe
    H3N0nPh9tG1qETzEsh+D6j0ExPgtvx3DZepehO4pK6Uc82P14cM/rf5bYj7wlYIX
    2RwlycUABmx8UXmeOdiBT4H0ul/ZqKkc6ATC7pTUh8fKqtLA/PIC5KCeYo89wNGp
    AUqwWwox6k60TgrIqLlZAh5Whz4NR7LmIpof7ufwQ2Fzej/127ix2Ixm7KtA/LlP
    nMbpLax72rb37g9zqeyWLdSE/5yaegAT6vs2sjP8WMZIWr9Yp94lgfuoDAeUq29M
    EF2/L+REzwHvnTGVR9mcFc4IPBv4c1vCpI1l7x9qk/IA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeCPPOd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:14:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPPOd (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 11:14:33 -0400
Date: Fri, 16 Mar 2018 16:14:30 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "mm: page_alloc: skip over regions of invalid
 pfns where possible"
Message-ID: <20180316151430.GL23100@dhcp22.suse.cz>
References: <20180316143855.29838-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316143855.29838-1-neelx@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-03-18 15:38:55, Daniel Vacek wrote:
> This reverts commit b92df1de5d289c0b5d653e72414bf0850b8511e0. The commit
> is meant to be a boot init speed up skipping the loop in memmap_init_zone()
> for invalid pfns. But given some specific memory mapping on x86_64 (or more
> generally theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID)
> the implementation also skips valid pfns which is plain wrong and causes
> 'kernel BUG at mm/page_alloc.c:1389!'
> 
> crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
> kernel BUG at mm/page_alloc.c:1389!
> invalid opcode: 0000 [#1] SMP
> --
> RIP: 0010:[<ffffffff8118833e>]  [<ffffffff8118833e>] move_freepages+0x15e/0x160
> RSP: 0018:ffff88054d727688  EFLAGS: 00010087
> --
> Call Trace:
>  [<ffffffff811883b3>] move_freepages_block+0x73/0x80
>  [<ffffffff81189e63>] __rmqueue+0x263/0x460
>  [<ffffffff8118c781>] get_page_from_freelist+0x7e1/0x9e0
>  [<ffffffff8118caf6>] __alloc_pages_nodemask+0x176/0x420
> --
> RIP  [<ffffffff8118833e>] move_freepages+0x15e/0x160
>  RSP <ffff88054d727688>
> 
> crash> page_init_bug -v | grep RAM
> <struct resource 0xffff88067fffd2f8>          1000 -        9bfff       System RAM (620.00 KiB)
> <struct resource 0xffff88067fffd3a0>        100000 -     430bffff       System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
> <struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff       System RAM ( 14.83 MiB = 15188.00 KiB)
> <struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff       System RAM (391.02 MiB = 400408.00 KiB)
> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
> <struct resource 0xffff88067fffd640>     100000000 -    67fffffff       System RAM ( 22.00 GiB)
> 
> crash> page_init_bug | head -6
> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
> <struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
> <struct page 0xffffea0001ede200> 505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
> <struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
> <struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
> BUG, zones differ!
> 
> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffea0001e00000  78000000                0        0  0 0
> ffffea0001ed7fc0  7b5ff000                0        0  0 0
> ffffea0001ed8000  7b600000                0        0  0 0       <<<<
> ffffea0001ede1c0  7b787000                0        0  0 0
> ffffea0001ede200  7b788000                0        0  1 1fffff00000000
> 
> Fixes: b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where possible")
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: stable@vger.kernel.org

Yes, this looks like the most simple way for now before a proper
solution is found
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memblock.h |  1 -
>  mm/memblock.c            | 28 ----------------------------
>  mm/page_alloc.c          | 11 +----------
>  3 files changed, 1 insertion(+), 39 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 8be5077efb5f..f92ea7783652 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -187,7 +187,6 @@ int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>  			    unsigned long  *end_pfn);
>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>  			  unsigned long *out_end_pfn, int *out_nid);
> -unsigned long memblock_next_valid_pfn(unsigned long pfn, unsigned long max_pfn);
>  
>  /**
>   * for_each_mem_pfn_range - early memory pfn range iterator
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b6ba6b7adadc..48376bd33274 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1101,34 +1101,6 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>  		*out_nid = r->nid;
>  }
>  
> -unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
> -						      unsigned long max_pfn)
> -{
> -	struct memblock_type *type = &memblock.memory;
> -	unsigned int right = type->cnt;
> -	unsigned int mid, left = 0;
> -	phys_addr_t addr = PFN_PHYS(++pfn);
> -
> -	do {
> -		mid = (right + left) / 2;
> -
> -		if (addr < type->regions[mid].base)
> -			right = mid;
> -		else if (addr >= (type->regions[mid].base +
> -				  type->regions[mid].size))
> -			left = mid + 1;
> -		else {
> -			/* addr is within the region, so pfn is valid */
> -			return pfn;
> -		}
> -	} while (left < right);
> -
> -	if (right == type->cnt)
> -		return -1UL;
> -	else
> -		return PHYS_PFN(type->regions[right].base);
> -}
> -
>  /**
>   * memblock_set_node - set node ID on memblock regions
>   * @base: base of area to set node ID for
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 635d7dd29d7f..e4566a3f8083 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5356,17 +5356,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		if (context != MEMMAP_EARLY)
>  			goto not_early;
>  
> -		if (!early_pfn_valid(pfn)) {
> -#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> -			/*
> -			 * Skip to the pfn preceding the next valid one (or
> -			 * end_pfn), such that we hit a valid pfn (or end_pfn)
> -			 * on our next iteration of the loop.
> -			 */
> -			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
> -#endif
> +		if (!early_pfn_valid(pfn))
>  			continue;
> -		}
>  		if (!early_pfn_in_nid(pfn, nid))
>  			continue;
>  		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
> -- 
> 2.16.2
> 

-- 
Michal Hocko
SUSE Labs
