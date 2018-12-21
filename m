Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E042C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D60121906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QrawCGVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbeLUKFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:05:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43527 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbeLUKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:05:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so2374797pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHGqxMspZSo05eG5QAjnfhB5jd+3XWfd773eYtrC1jk=;
        b=QrawCGVaGUecFpcycCMar2MOKfNxMbT/ipGb4Pqybqfo3r3krb/BSKUkq5FBqAVFaO
         55FXC0K+0fqMELQ6qqLrAdaw9BS2wLgkVTSrhHaAqlRqDZp9a8ANZgVnE7k9m6HbEiZ1
         HXUEMaoVdBmQIPogpNUFr1wt3+xaGAMSRMTFBTyRBs60hRHXB+/nAOfgpwMtDkexAAqE
         83bc/kR25p2SqDSHtAkJWX2iFBe8jwIgDK03MGSr0OPDGcIoayXVLFfW77gC9Olx6F6y
         kA+xpSfT0s1UVmeYXxuaGnVtSJ0fr3kpVlB4FFqbXAzcyv9Ni995cOeBryc9P3g/VTrG
         Pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHGqxMspZSo05eG5QAjnfhB5jd+3XWfd773eYtrC1jk=;
        b=uN23gwd4FzjVHrbRBn0GPRGbdTD6EC9WxWkArnbhzxoeGgAFHE6sB9XV/diL00MKUT
         qQyeih9aiwSTnqEgrsA3g+PoZ+vnFrWoBnCNFmbKzpOu9eOZyYYLHi0JgQaDwwarvqT7
         k5CBl4pU/cjo7QJGkZIpICpNTm2C1VC3mZe8O5B+ORhpFe7rssLBkkpC3fsOncJWEmNT
         Vqji21XO/PlNOKNJs4AA+Odm2HF0EfXvoXzp5szHbsDQ2a+pK1yTDpF0mz96vqiHU2iJ
         WPxJvifdMVjVCamAh2+Nn2UJ69Rz7mZ0D9HD8ziBn3nIdRQzWw59+zwtwKbhATqJugVo
         qvMg==
X-Gm-Message-State: AA+aEWZNKzAKfgyCvSNKV2RdwiqBZObRiM9K/Jhk4gU9UB4fM4hGOfMT
        pNz+RM97t7/mzcO64QqS4NeFrA==
X-Google-Smtp-Source: AFSGD/Xxz5pY288mpOzvFCJAS6FSnGo5dau7G9bGPIBD+6scLPg3t/SGYwsGGQWAnyUrGOoRLn5Xwg==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr1941315pfh.228.1545386734484;
        Fri, 21 Dec 2018 02:05:34 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id l64sm27442346pge.73.2018.12.21.02.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 02:05:33 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E0C0C300816; Fri, 21 Dec 2018 13:05:28 +0300 (+03)
Date:   Fri, 21 Dec 2018 13:05:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing
 synchronization
Message-ID: <20181221100528.bkvddcqom7qaxwbe@kshutemo-mobl1>
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218223557.5202-2-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:35:56PM -0800, Mike Kravetz wrote:
> While looking at BUGs associated with invalid huge page map counts,
> it was discovered and observed that a huge pte pointer could become
> 'invalid' and point to another task's page table.  Consider the
> following:
> 
> A task takes a page fault on a shared hugetlbfs file and calls
> huge_pte_alloc to get a ptep.  Suppose the returned ptep points to a
> shared pmd.
> 
> Now, another task truncates the hugetlbfs file.  As part of truncation,
> it unmaps everyone who has the file mapped.  If the range being
> truncated is covered by a shared pmd, huge_pmd_unshare will be called.
> For all but the last user of the shared pmd, huge_pmd_unshare will
> clear the pud pointing to the pmd.  If the task in the middle of the
> page fault is not the last user, the ptep returned by huge_pte_alloc
> now points to another task's page table or worse.  This leads to bad
> things such as incorrect page map/reference counts or invalid memory
> references.
> 
> To fix, expand the use of i_mmap_rwsem as follows:
> - i_mmap_rwsem is held in read mode whenever huge_pmd_share is called.
>   huge_pmd_share is only called via huge_pte_alloc, so callers of
>   huge_pte_alloc take i_mmap_rwsem before calling.  In addition, callers
>   of huge_pte_alloc continue to hold the semaphore until finished with
>   the ptep.
> - i_mmap_rwsem is held in write mode whenever huge_pmd_unshare is called.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 39dde65c9940 ("shared page table for hugetlb page")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Other the few questions below. The patch looks reasonable to me.

> @@ -3252,11 +3253,23 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  
>  	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
>  		spinlock_t *src_ptl, *dst_ptl;
> +
>  		src_pte = huge_pte_offset(src, addr, sz);
>  		if (!src_pte)
>  			continue;
> +
> +		/*
> +		 * i_mmap_rwsem must be held to call huge_pte_alloc.
> +		 * Continue to hold until finished  with dst_pte, otherwise
> +		 * it could go away if part of a shared pmd.
> +		 *
> +		 * Technically, i_mmap_rwsem is only needed in the non-cow
> +		 * case as cow mappings are not shared.
> +		 */
> +		i_mmap_lock_read(mapping);

Any reason you do lock/unlock on each iteration rather than around whole
loop?

>  		dst_pte = huge_pte_alloc(dst, addr, sz);
>  		if (!dst_pte) {
> +			i_mmap_unlock_read(mapping);
>  			ret = -ENOMEM;
>  			break;
>  		}

...

> @@ -3772,14 +3789,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			};
>  
>  			/*
> -			 * hugetlb_fault_mutex must be dropped before
> -			 * handling userfault.  Reacquire after handling
> -			 * fault to make calling code simpler.
> +			 * hugetlb_fault_mutex and i_mmap_rwsem must be
> +			 * dropped before handling userfault.  Reacquire
> +			 * after handling fault to make calling code simpler.
>  			 */
>  			hash = hugetlb_fault_mutex_hash(h, mm, vma, mapping,
>  							idx, haddr);
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +			i_mmap_unlock_read(mapping);
> +

Do we have order of hugetlb_fault_mutex vs. i_mmap_lock documented?
I *looks* correct to me, but it's better to write it down somewhere.
Mayby add to the header of mm/rmap.c?

>  			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
> +
> +			i_mmap_lock_read(mapping);
>  			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  			goto out;
>  		}

-- 
 Kirill A. Shutemov
