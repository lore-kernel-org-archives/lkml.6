Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E970C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064C52082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="atczp3DT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064C52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeKCAEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:04:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39302 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeKCAEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:04:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so1129837pla.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pFoxizr4Xshbd5d8jK4zxzhTO29DQ2bXf51DghjpV14=;
        b=atczp3DTmvRl9d5b9+DIRIxwMnoTGityuk2T04GsRV1LshZYOdifXOeoDrv0MovV5Q
         DR0Q7/1yozXzvT1hI5WpYyo9/vOD/Di3TG4hOi3381BlWZcwELAUb8sZPJeKc2uuJngt
         KV5r+ZYtoNjyRhDkyAZfaOh6ZaPN9Kvng2qzkLpwHAxmhv5e7G0q/HH7wNYqastANj+b
         VummX3qLHjMzhXqnyoO9Gg7q2lH0wNNzB3FOOa7svL21akwFPZgia2FKTaL6jNYesfdp
         mzy6JnXkoOoavZGy9Uyf9fcNSxXdc1T6MPjozdErhjF04n7UcbIBYgG/8V4W9XRZ9aDQ
         uChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFoxizr4Xshbd5d8jK4zxzhTO29DQ2bXf51DghjpV14=;
        b=OiPmL6OMO8x7hv+hPSoIFM4mijwNClZTVqgS/yGhwIxnV5h8GsNR02KcPa53/JWi7U
         3BaN0PJbEs9PkqLFshDAw3d3uRWLYFn8VuIQxoNDaiSD8lZP+wl2/jyyYLLQWVhOry2/
         qoRaUCKBKkNcfUAp1VKurUnj28sJ7YLFSpd8b8pkbZg4kqXgV0basPndkCKhadKI6ztR
         T/Nz29S+Xd/Mq0zdL2uH/27lS73W0X08KTL74le6LvEMnGM27E7PvVfo6mRNC9Uq4pbo
         lfK9w854xUSusbdArp2C1AGPObDPDVncPIyTADAviRXjVffqG/pmf4J6WEPiQ2NYr+fG
         3AgQ==
X-Gm-Message-State: AGRZ1gK00H280q8jwL78SFqIKA6kliJVTHWtrogFpmzzO2WuXSjttBAF
        Z0ql/EBOG0pqkdxDYaGaSygFQA==
X-Google-Smtp-Source: AJdET5ej91OyV+0PsCQ/XK6Teze5aYjPT19TnnDkpiRVy3OHYO7f2dkehftK8+tn2xhZ/DerbNLBVQ==
X-Received: by 2002:a17:902:7682:: with SMTP id m2-v6mr12128606pll.89.1541170604724;
        Fri, 02 Nov 2018 07:56:44 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id z2sm2539911pgu.4.2018.11.02.07.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 07:56:43 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E9F4630164F; Fri,  2 Nov 2018 17:56:38 +0300 (+03)
Date:   Fri, 2 Nov 2018 17:56:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     torvalds@linux-foundation.org
Cc:     Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, mingo@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, mhocko@kernel.org, hughd@google.com
Subject: Re: [PATCH] mremap: properly flush TLB before releasing the page
Message-ID: <20181102145638.gehn7eszv22lelh6@kshutemo-mobl1>
References: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:22:42PM +0000, Will Deacon wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.

I have never seen the original patch on mailing lists, so I'll reply to
the backport.

> 
> This is a backport to stable 4.4.y.
> 
> Jann Horn points out that our TLB flushing was subtly wrong for the
> mremap() case.  What makes mremap() special is that we don't follow the
> usual "add page to list of pages to be freed, then flush tlb, and then
> free pages".  No, mremap() obviously just _moves_ the page from one page
> table location to another.
> 
> That matters, because mremap() thus doesn't directly control the
> lifetime of the moved page with a freelist: instead, the lifetime of the
> page is controlled by the page table locking, that serializes access to
> the entry.

I believe we do control the lifetime of the page with mmap_sem, don't we?

I mean any shoot down of the page from a mapping would require at least
down_read(mmap_sem) and we hold down_write(mmap_sem). Hm?

> As a result, we need to flush the TLB not just before releasing the lock
> for the source location (to avoid any concurrent accesses to the entry),
> but also before we release the destination page table lock (to avoid the
> TLB being flushed after somebody else has already done something to that
> page).
> 
> This also makes the whole "need_flush" logic unnecessary, since we now
> always end up flushing the TLB for every valid entry.
> 
> Reported-and-tested-by: Jann Horn <jannh@google.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [will: backport to 4.4 stable]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  mm/huge_memory.c |  6 +++++-
>  mm/mremap.c      | 21 ++++++++++++++++-----
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c4ea57ee2fd1..465786cd6490 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1511,7 +1511,7 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
>  	spinlock_t *old_ptl, *new_ptl;
>  	int ret = 0;
>  	pmd_t pmd;
> -
> +	bool force_flush = false;
>  	struct mm_struct *mm = vma->vm_mm;
>  
>  	if ((old_addr & ~HPAGE_PMD_MASK) ||
> @@ -1539,6 +1539,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
>  		if (new_ptl != old_ptl)
>  			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>  		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
> +		if (pmd_present(pmd))
> +			force_flush = true;
>  		VM_BUG_ON(!pmd_none(*new_pmd));
>  
>  		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
> @@ -1547,6 +1549,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
>  			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>  		}
>  		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
> +		if (force_flush)
> +			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
>  		if (new_ptl != old_ptl)
>  			spin_unlock(new_ptl);
>  		spin_unlock(old_ptl);
> diff --git a/mm/mremap.c b/mm/mremap.c
> index fe7b7f65f4f4..450b306d473e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -96,6 +96,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  	struct mm_struct *mm = vma->vm_mm;
>  	pte_t *old_pte, *new_pte, pte;
>  	spinlock_t *old_ptl, *new_ptl;
> +	bool force_flush = false;
> +	unsigned long len = old_end - old_addr;
>  
>  	/*
>  	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
> @@ -143,12 +145,26 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  		if (pte_none(*old_pte))
>  			continue;
>  		pte = ptep_get_and_clear(mm, old_addr, old_pte);
> +		/*
> +		 * If we are remapping a valid PTE, make sure
> +		 * to flush TLB before we drop the PTL for the PTE.
> +		 *
> +		 * NOTE! Both old and new PTL matter: the old one
> +		 * for racing with page_mkclean(), the new one to
> +		 * make sure the physical page stays valid until
> +		 * the TLB entry for the old mapping has been
> +		 * flushed.
> +		 */

Could you elaborate on the race with page_mkclean()?

I think the new logic is unnecessary strict (and slow).

Any barely sane userspace must not access the old mapping after
mremap(MREMAP_MAYMOVE) called and must not access the new mapping
before the mremap() returns.

The old logic *should* be safe if this argument valid.

Do I miss something?

> +		if (pte_present(pte))
> +			force_flush = true;
>  		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
>  		pte = move_soft_dirty_pte(pte);
>  		set_pte_at(mm, new_addr, new_pte, pte);
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> +	if (force_flush)
> +		flush_tlb_range(vma, old_end - len, old_end);
>  	if (new_ptl != old_ptl)
>  		spin_unlock(new_ptl);
>  	pte_unmap(new_pte - 1);
> @@ -168,7 +184,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  {
>  	unsigned long extent, next, old_end;
>  	pmd_t *old_pmd, *new_pmd;
> -	bool need_flush = false;
>  	unsigned long mmun_start;	/* For mmu_notifiers */
>  	unsigned long mmun_end;		/* For mmu_notifiers */
>  
> @@ -207,7 +222,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  					anon_vma_unlock_write(vma->anon_vma);
>  			}
>  			if (err > 0) {
> -				need_flush = true;
>  				continue;
>  			} else if (!err) {
>  				split_huge_page_pmd(vma, old_addr, old_pmd);
> @@ -224,10 +238,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			extent = LATENCY_LIMIT;
>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent,
>  			  new_vma, new_pmd, new_addr, need_rmap_locks);
> -		need_flush = true;
>  	}
> -	if (likely(need_flush))
> -		flush_tlb_range(vma, old_end-len, old_addr);
>  
>  	mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
>  
> -- 
> 2.1.4
> 

-- 
 Kirill A. Shutemov
