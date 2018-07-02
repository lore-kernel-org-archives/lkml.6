Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6297EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A902242C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="l+s38BYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A902242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeGBMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:33:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34919 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeGBMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:33:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id i7-v6so7100419pgp.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TkUr2Dab3Znlbqv8nT1zjzmrbvK3FlU5OFIV/CwMY8k=;
        b=l+s38BYsJMsM4P4ZXRoMjSGl9CDQOUWSbJ5OKx8lfpigE9M0arX7owuAaXds6pyOFX
         Ifd8LA1Yafu389FQcCELuMy1LoqIQ9oDg/m1p81NWzZUsju2gvvr4zWynHV9ujI7oPwH
         I/7HmUvmMLUvjfNFg6JW07X2G01roKyWyPRWYDmBahrY4Sa8sTawqA+nmRQYy48uLRZX
         PAXVQXRwPB6GWn6lftjuY5y32SMhOqj0K01cEuEbqaCp47jaiegNiWt/RopLnt69cBb1
         +naZ45MXMZ5vL9aVjj45kznxd3ymeYYFcSlQwItrd5K8Z71aFDnYJ1DSqUtRmkoyQAOw
         TdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkUr2Dab3Znlbqv8nT1zjzmrbvK3FlU5OFIV/CwMY8k=;
        b=qXlKbgGpODz/nUjSIgJHD1pQ4IC5/0yAOwP39MFG93np7smwJfXNaVoaulSOQ9H/YD
         OWg6F5GUdNfkBNynrCnTW9XUiS1MjIzpFataeU+hgPUqhDMvaCrMZ/qCxu0xZ5yWiP+H
         DJeLH9bRmmNLK2MmgAAGp/Dpbpjyv8DJpDDfaUgqT5rHvsp9V1bYSFJbYA/r+GBXo2wj
         vyAU1ey5N+RTt1wEJVuhb+zfVG7zM/Fuz2XKrTlFfPk07Aj7ydmQQlG9ra0IHjbPmqmx
         CQIegiY5SRpXlV1VHCzU2KvUBmLkXaWayVAubgxL84LVnXGP8TyBl4GKQRb8PwziivrW
         XuLA==
X-Gm-Message-State: APt69E1eEJrB8I2iRJE+eV6oRk9vMx3iPIBac40TZWPDJ/IofSZ+1IAb
        ztCTkJhu04T3FfbZSwNH5ttVwQ==
X-Google-Smtp-Source: AAOMgpee7UEFfVIeeQ6XXyD/MbyvxWzmrdacE9dpzdIGzB3jVJrNde0RPhbVswGC9TNAzUUwX9BoRg==
X-Received: by 2002:a63:8f03:: with SMTP id n3-v6mr13876709pgd.166.1530534835583;
        Mon, 02 Jul 2018 05:33:55 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id w76-v6sm32312827pfk.188.2018.07.02.05.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:33:54 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 6826430003C; Mon,  2 Jul 2018 15:33:50 +0300 (+03)
Date:   Mon, 2 Jul 2018 15:33:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180702123350.dktmzlmztulmtrae@kshutemo-mobl1>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 06:39:44AM +0800, Yang Shi wrote:
> When running some mmap/munmap scalability tests with large memory (i.e.
> > 300GB), the below hung task issue may happen occasionally.
> 
> INFO: task ps:14018 blocked for more than 120 seconds.
>        Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
>  ps              D    0 14018      1 0x00000004
>   ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
>   ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
>   00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
>  Call Trace:
>   [<ffffffff817154d0>] ? __schedule+0x250/0x730
>   [<ffffffff817159e6>] schedule+0x36/0x80
>   [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
>   [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
>   [<ffffffff81717db0>] down_read+0x20/0x40
>   [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
>   [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
>   [<ffffffff81241d87>] __vfs_read+0x37/0x150
>   [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
>   [<ffffffff81242266>] vfs_read+0x96/0x130
>   [<ffffffff812437b5>] SyS_read+0x55/0xc0
>   [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
> 
> It is because munmap holds mmap_sem from very beginning to all the way
> down to the end, and doesn't release it in the middle. When unmapping
> large mapping, it may take long time (take ~18 seconds to unmap 320GB
> mapping with every single page mapped on an idle machine).
> 
> It is because munmap holds mmap_sem from very beginning to all the way
> down to the end, and doesn't release it in the middle. When unmapping
> large mapping, it may take long time (take ~18 seconds to unmap 320GB
> mapping with every single page mapped on an idle machine).
> 
> Zapping pages is the most time consuming part, according to the
> suggestion from Michal Hock [1], zapping pages can be done with holding
> read mmap_sem, like what MADV_DONTNEED does. Then re-acquire write
> mmap_sem to cleanup vmas. All zapped vmas will have VM_DEAD flag set,
> the page fault to VM_DEAD vma will trigger SIGSEGV.
> 
> Define large mapping size thresh as PUD size or 1GB, just zap pages with
> read mmap_sem for mappings which are >= thresh value.
> 
> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, then just
> fallback to regular path since unmapping those mappings need acquire
> write mmap_sem.
> 
> For the time being, just do this in munmap syscall path. Other
> vm_munmap() or do_munmap() call sites remain intact for stability
> reason.
> 
> The below is some regression and performance data collected on a machine
> with 32 cores of E5-2680 @ 2.70GHz and 384GB memory.
> 
> With the patched kernel, write mmap_sem hold time is dropped to us level
> from second.
> 
> [1] https://lwn.net/Articles/753269/
> 
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/mmap.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 87dcf83..d61e08b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2763,6 +2763,128 @@ static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
>  	return 1;
>  }
>  
> +/* Consider PUD size or 1GB mapping as large mapping */
> +#ifdef HPAGE_PUD_SIZE
> +#define LARGE_MAP_THRESH	HPAGE_PUD_SIZE
> +#else
> +#define LARGE_MAP_THRESH	(1 * 1024 * 1024 * 1024)
> +#endif

PUD_SIZE is defined everywhere.

> +
> +/* Unmap large mapping early with acquiring read mmap_sem */
> +static int do_munmap_zap_early(struct mm_struct *mm, unsigned long start,
> +			       size_t len, struct list_head *uf)
> +{
> +	unsigned long end = 0;
> +	struct vm_area_struct *vma = NULL, *prev, *tmp;
> +	bool success = false;
> +	int ret = 0;
> +
> +	if (!munmap_addr_sanity(start, len))
> +		return -EINVAL;
> +
> +	len = PAGE_ALIGN(len);
> +
> +	end = start + len;
> +
> +	/* Just deal with uf in regular path */
> +	if (unlikely(uf))
> +		goto regular_path;
> +
> +	if (len >= LARGE_MAP_THRESH) {
> +		/*
> +		 * need write mmap_sem to split vma and set VM_DEAD flag
> +		 * splitting vma up-front to save PITA to clean if it is failed

What errors do you talk about? ENOMEM on VMA split? Anything else?

> +		 */
> +		down_write(&mm->mmap_sem);
> +		ret = munmap_lookup_vma(mm, &vma, &prev, start, end);
> +		if (ret != 1) {
> +			up_write(&mm->mmap_sem);
> +			return ret;
> +		}
> +		/* This ret value might be returned, so reset it */
> +		ret = 0;
> +
> +		/*
> +		 * Unmapping vmas, which has VM_LOCKED|VM_HUGETLB|VM_PFNMAP
> +		 * flag set or has uprobes set, need acquire write map_sem,
> +		 * so skip them in early zap. Just deal with such mapping in
> +		 * regular path.
> +		 * Borrow can_madv_dontneed_vma() to check the conditions.
> +		 */
> +		tmp = vma;
> +		while (tmp && tmp->vm_start < end) {
> +			if (!can_madv_dontneed_vma(tmp) ||
> +			    vma_has_uprobes(tmp, start, end)) {
> +				up_write(&mm->mmap_sem);
> +				goto regular_path;
> +			}
> +			tmp = tmp->vm_next;
> +		}
> +		/*
> +		 * set VM_DEAD flag before tear down them.
> +		 * page fault on VM_DEAD vma will trigger SIGSEGV.
> +		 */
> +		tmp = vma;
> +		for ( ; tmp && tmp->vm_start < end; tmp = tmp->vm_next)
> +			tmp->vm_flags |= VM_DEAD;

I probably miss the explanation somewhere, but what's wrong with allowing
other thread to re-populate the VMA?

I would rather allow the VMA to be re-populated by other thread while we
are zapping the range. And later zap the range again under down_write.

It should also lead to consolidated regular path: take mmap_sem for write
and call do_munmap().

On the first path we just skip VMA we cannot deal with under
down_read(mmap_sem), regular path will take care of them.


> +		up_write(&mm->mmap_sem);
> +
> +		/* zap mappings with read mmap_sem */
> +		down_read(&mm->mmap_sem);

Yeah. There's race between up_write() and down_read().
Use downgrade, as Andrew suggested.

> +		zap_page_range(vma, start, len);
> +		/* indicates early zap is success */
> +		success = true;
> +		up_read(&mm->mmap_sem);

And here again.

This race can be avoided if we wouldn't carry vma to regular_path, but
just go directly to do_munmap().

> +	}
> +
> +regular_path:
> +	/* hold write mmap_sem for vma manipulation or regular path */
> +	if (down_write_killable(&mm->mmap_sem))
> +		return -EINTR;
> +	if (success) {
> +		/* vmas have been zapped, here clean up pgtable and vmas */
> +		struct vm_area_struct *next = prev ? prev->vm_next : mm->mmap;
> +		struct mmu_gather tlb;
> +		tlb_gather_mmu(&tlb, mm, start, end);
> +		free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> +			      next ? next->vm_start : USER_PGTABLES_CEILING);
> +		tlb_finish_mmu(&tlb, start, end);
> +
> +		detach_vmas_to_be_unmapped(mm, vma, prev, end);
> +		arch_unmap(mm, vma, start, end);
> +		remove_vma_list(mm, vma);
> +	} else {
> +		/* vma is VM_LOCKED|VM_HUGETLB|VM_PFNMAP or has uprobe */
> +		if (vma) {
> +			if (unlikely(uf)) {
> +				int ret = userfaultfd_unmap_prep(vma, start,
> +								 end, uf);
> +				if (ret)
> +					goto out;
> +			}
> +			if (mm->locked_vm) {
> +				tmp = vma;
> +				while (tmp && tmp->vm_start < end) {
> +					if (tmp->vm_flags & VM_LOCKED) {
> +						mm->locked_vm -= vma_pages(tmp);
> +						munlock_vma_pages_all(tmp);
> +					}
> +					tmp = tmp->vm_next;
> +				}
> +			}
> +			detach_vmas_to_be_unmapped(mm, vma, prev, end);
> +			unmap_region(mm, vma, prev, start, end);
> +			remove_vma_list(mm, vma);
> +		} else
> +			/* When mapping size < LARGE_MAP_THRESH */
> +			ret = do_munmap(mm, start, len, uf);
> +	}
> +
> +out:
> +	up_write(&mm->mmap_sem);
> +	return ret;
> +}
> +
>  /* Munmap is split into 2 main parts -- this part which finds
>   * what needs doing, and the areas themselves, which do the
>   * work.  This now handles partial unmappings.
> @@ -2829,6 +2951,17 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return 0;
>  }
>  
> +static int vm_munmap_zap_early(unsigned long start, size_t len)
> +{
> +	int ret;
> +	struct mm_struct *mm = current->mm;
> +	LIST_HEAD(uf);
> +
> +	ret = do_munmap_zap_early(mm, start, len, &uf);
> +	userfaultfd_unmap_complete(mm, &uf);
> +	return ret;
> +}
> +
>  int vm_munmap(unsigned long start, size_t len)
>  {
>  	int ret;
> @@ -2848,10 +2981,9 @@ int vm_munmap(unsigned long start, size_t len)
>  SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
>  {
>  	profile_munmap(addr);
> -	return vm_munmap(addr, len);
> +	return vm_munmap_zap_early(addr, len);
>  }
>  
> -
>  /*
>   * Emulation of deprecated remap_file_pages() syscall.
>   */
> -- 
> 1.8.3.1
> 

-- 
 Kirill A. Shutemov
