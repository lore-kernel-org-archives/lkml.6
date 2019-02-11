Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2455F218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zb6zL4Ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfBKRlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:41:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43685 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:41:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id f196so6447421qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlkMwnyxqiywgQrnwg1E3Cz9ULiUcCPJ5gOy2kXG/iM=;
        b=Zb6zL4BaIJPAjGFX0V1pbTe4IE2qJ+o2fCm1vYWJNlWAr0GIDK3yHZIoFhpTB2YrAe
         NApI8/4DTtlshkQI4MBtXQ+rA7CPy1rc+AuVEs/YOv1t/xOdjH5n3oDCpBIV/N0AGYOO
         hwmXK8Za8rNUdP0HErKuWaLfMeaZuu163yUyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlkMwnyxqiywgQrnwg1E3Cz9ULiUcCPJ5gOy2kXG/iM=;
        b=TTGeuw2LYGtDXqLMStm3EY8rj9Bg9b/k4uvc79EXW/IzVOJwTgVQE1RQeXtE8ceEdP
         2rysbYatWl1G8GK46+lN22nw1/sZNAB1SHLL9Di/ge2FmFg081i7UbRfGlmhmoHADBXo
         rDd8AsUIjGhCrupwEELM61+bIy5N+NI973kVkoMXYu1Q53km9iQ0RgBT53wnRSh7JPVB
         lxZeKM0m1Zc+XLiEK/SLPpMno0DhTP9qcGbwiQJpQj2rpokTWxU3m22mPo3M2Dk6qYah
         16fe36SqY3jKaqnbevHhXuGqP7Tvzw+xOixXgdzfGq0IxIyRLElgZESYN8rP+LmaBo7r
         Ej+g==
X-Gm-Message-State: AHQUAubF/jp9n9XSmk6MjrUQ1tEhcFDKlGb/uzfAnrDRGirTp3jmOzce
        Vw4QRnrryYUGUYescCxSsGQemA==
X-Google-Smtp-Source: AHgI3IZR2zvMXASiBOs8UfJ47VnZ5vQ7r9KS8wsoeK0PXqbv3rG0JJwSwQlGxfVhV10SN5ISZ14ODw==
X-Received: by 2002:ae9:dd42:: with SMTP id r63mr25739025qkf.264.1549906864495;
        Mon, 11 Feb 2019 09:41:04 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id c202sm14673397qkb.19.2019.02.11.09.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 09:41:03 -0800 (PST)
Date:   Mon, 11 Feb 2019 12:41:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sandeep Patil <sspatil@android.com>
Cc:     vbabka@suse.cz, adobriyan@gmail.com, akpm@linux-foundation.org,
        avagin@openvz.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com, dancol@google.com
Subject: Re: [PATCH v2] mm: proc: smaps_rollup: Fix pss_locked calculation
Message-ID: <20190211174102.GA16019@google.com>
References: <20190203065425.14650-1-sspatil@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203065425.14650-1-sspatil@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 10:54:25PM -0800, Sandeep Patil wrote:
> The 'pss_locked' field of smaps_rollup was being calculated incorrectly.
> It accumulated the current pss everytime a locked VMA was found.  Fix
> that by adding to 'pss_locked' the same time as that of 'pss' if the vma
> being walked is locked.
> 
> Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
> Cc: stable@vger.kernel.org # 4.14.y 4.19.y
> Signed-off-by: Sandeep Patil <sspatil@android.com>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel


> 
> v1->v2
> ------
> - Move pss_locked accounting into smaps_account() inline with pss
> 
>  fs/proc/task_mmu.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f0ec9edab2f3..85b0ef890b28 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -423,7 +423,7 @@ struct mem_size_stats {
>  };
>  
>  static void smaps_account(struct mem_size_stats *mss, struct page *page,
> -		bool compound, bool young, bool dirty)
> +		bool compound, bool young, bool dirty, bool locked)
>  {
>  	int i, nr = compound ? 1 << compound_order(page) : 1;
>  	unsigned long size = nr * PAGE_SIZE;
> @@ -450,24 +450,31 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>  		else
>  			mss->private_clean += size;
>  		mss->pss += (u64)size << PSS_SHIFT;
> +		if (locked)
> +			mss->pss_locked += (u64)size << PSS_SHIFT;
>  		return;
>  	}
>  
>  	for (i = 0; i < nr; i++, page++) {
>  		int mapcount = page_mapcount(page);
> +		unsigned long pss = (PAGE_SIZE << PSS_SHIFT);
>  
>  		if (mapcount >= 2) {
>  			if (dirty || PageDirty(page))
>  				mss->shared_dirty += PAGE_SIZE;
>  			else
>  				mss->shared_clean += PAGE_SIZE;
> -			mss->pss += (PAGE_SIZE << PSS_SHIFT) / mapcount;
> +			mss->pss += pss / mapcount;
> +			if (locked)
> +				mss->pss_locked += pss / mapcount;
>  		} else {
>  			if (dirty || PageDirty(page))
>  				mss->private_dirty += PAGE_SIZE;
>  			else
>  				mss->private_clean += PAGE_SIZE;
> -			mss->pss += PAGE_SIZE << PSS_SHIFT;
> +			mss->pss += pss;
> +			if (locked)
> +				mss->pss_locked += pss;
>  		}
>  	}
>  }
> @@ -490,6 +497,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  {
>  	struct mem_size_stats *mss = walk->private;
>  	struct vm_area_struct *vma = walk->vma;
> +	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
>  
>  	if (pte_present(*pte)) {
> @@ -532,7 +540,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	if (!page)
>  		return;
>  
> -	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte));
> +	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte), locked);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -541,6 +549,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  {
>  	struct mem_size_stats *mss = walk->private;
>  	struct vm_area_struct *vma = walk->vma;
> +	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page;
>  
>  	/* FOLL_DUMP will return -EFAULT on huge zero page */
> @@ -555,7 +564,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		/* pass */;
>  	else
>  		VM_BUG_ON_PAGE(1, page);
> -	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd));
> +	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
>  }
>  #else
>  static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> @@ -737,11 +746,8 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>  		}
>  	}
>  #endif
> -
>  	/* mmap_sem is held in m_start */
>  	walk_page_vma(vma, &smaps_walk);
> -	if (vma->vm_flags & VM_LOCKED)
> -		mss->pss_locked += mss->pss;
>  }
>  
>  #define SEQ_PUT_DEC(str, val) \
> -- 
> 2.20.1.611.gfbb209baf1-goog
> 
