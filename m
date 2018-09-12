Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A286FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534AC20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEjWOW2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534AC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeILPCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:02:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33897 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILPCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:02:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so804603pgv.1;
        Wed, 12 Sep 2018 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fsyu22oVQUzZyQK/54w8JcJG5zggwSObJYESkgC27CU=;
        b=sEjWOW2LTlp6Bf2QEd9RhfWH0JVDpEgh9tc9s1qxAvBtDy/9BBXSvNU42y5fa4MEgz
         0YwpHmYOWUuXWNkbL0dkGx87j7VfFPdFI7Vp0ktDlcGrI+40SJA1yQlDVBEo2IKXVSIt
         zIl2mny73oqNP/GrDZnEbAXcmTKUQjhz9wsNQpCR4/tTxZ2rM4dsFQ8SxqUgmMU5yqab
         t3qlA8T5Es/ccFL2+V5ix/84XDydNdtZTWRVvydyiyTTU9bxd6JbD7xznjXg0lXI+7sW
         P47K8LL6AwsS5+mZKLnxgEsSuYPv67j1z9X7fvk3kBu08mdq34s5H7qumyNfTPqAESJJ
         mMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fsyu22oVQUzZyQK/54w8JcJG5zggwSObJYESkgC27CU=;
        b=ELQHnfxbfsmPc/7H33QzmfGIrFMMEXk+L62vTmcuFB60OUp6ZDidphHVdCdyUENHOj
         N2lnVLMgD6Ap7I8KzDwQGPXW/xmbJY9oipZxb3yr2b2oAgTxaq99Ek0hmjolsx2soRc7
         Hq6MuAFcRWcQtJtHjmR9ZhewFx8sIsq2I5ruudHeRryEn8ub2hdERgGaXfoQCdgz4dnJ
         KppniiHGtrdPAJ0Q1sLO5GGrBGcer8O+Q0dNmI4elpDCAC8yTQWvOpQ0XmvNyYP6iLOB
         S5SaMgT8Hx0QuOgHWiTg8NZle4VjWCWYtFZ45poA85uD+65K59mPnF6q7HSWEagrNRpt
         P0ew==
X-Gm-Message-State: APzg51DCw92nZZM7lHV9CcuS3KQvrSVyQjEf4qQQtvhzF8ogWCEl5cJW
        3lNpLn3Yv+8/4hkElvbi9yg=
X-Google-Smtp-Source: ANB0VdauMyiMTg1U0hqm/sB7kKY94f86rIzXFKy1ocF1h9VHAHjMvkS8XlXUhM5BcZi3QaoPGiEd2g==
X-Received: by 2002:a63:5d4b:: with SMTP id o11-v6mr1241066pgm.349.1536746309549;
        Wed, 12 Sep 2018 02:58:29 -0700 (PDT)
Received: from [9.124.31.179] ([125.16.236.130])
        by smtp.gmail.com with ESMTPSA id u184-v6sm2555960pgd.46.2018.09.12.02.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 02:58:28 -0700 (PDT)
From:   "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
X-Google-Original-From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] mm, thp: Fix mlocking THP page with migration enabled
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vegard Nossum <vegard.nossum@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
Message-ID: <6fcb5b5b-43fa-f1d0-ce78-37fb51b46a75@linux.ibm.com>
Date:   Wed, 12 Sep 2018 15:28:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 4:04 PM, Kirill A. Shutemov wrote:
> A transparent huge page is represented by a single entry on an LRU list.
> Therefore, we can only make unevictable an entire compound page, not
> individual subpages.
> 
> If a user tries to mlock() part of a huge page, we want the rest of the
> page to be reclaimable.
> 
> We handle this by keeping PTE-mapped huge pages on normal LRU lists: the
> PMD on border of VM_LOCKED VMA will be split into PTE table.
> 
> Introduction of THP migration breaks the rules around mlocking THP
> pages. If we had a single PMD mapping of the page in mlocked VMA, the
> page will get mlocked, regardless of PTE mappings of the page.
> 
> For tmpfs/shmem it's easy to fix by checking PageDoubleMap() in
> remove_migration_pmd().
> 
> Anon THP pages can only be shared between processes via fork(). Mlocked
> page can only be shared if parent mlocked it before forking, otherwise
> CoW will be triggered on mlock().
> 
> For Anon-THP, we can fix the issue by munlocking the page on removing PTE
> migration entry for the page. PTEs for the page will always come after
> mlocked PMD: rmap walks VMAs from oldest to newest.
> 
> Test-case:
> 
> 	#include <unistd.h>
> 	#include <sys/mman.h>
> 	#include <sys/wait.h>
> 	#include <linux/mempolicy.h>
> 	#include <numaif.h>
> 
> 	int main(void)
> 	{
> 	        unsigned long nodemask = 4;
> 	        void *addr;
> 
> 		addr = mmap((void *)0x20000000UL, 2UL << 20, PROT_READ | PROT_WRITE,
> 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, -1, 0);
> 
> 	        if (fork()) {
> 			wait(NULL);
> 			return 0;
> 	        }
> 
> 	        mlock(addr, 4UL << 10);
> 	        mbind(addr, 2UL << 20, MPOL_PREFERRED | MPOL_F_RELATIVE_NODES,
> 	                &nodemask, 4, MPOL_MF_MOVE | MPOL_MF_MOVE_ALL);
> 
> 	        return 0;
> 	}
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Cc: <stable@vger.kernel.org> [v4.14+]
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> ---
>   mm/huge_memory.c | 2 +-
>   mm/migrate.c     | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 533f9b00147d..00704060b7f7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2931,7 +2931,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   	else
>   		page_add_file_rmap(new, true);
>   	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
> -	if (vma->vm_flags & VM_LOCKED)
> +	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
>   		mlock_vma_page(new);
>   	update_mmu_cache_pmd(vma, address, pvmw->pmd);
>   }
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d6a2e89b086a..01dad96b25b5 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -275,6 +275,9 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>   		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
>   			mlock_vma_page(new);
>   
> +		if (PageTransCompound(new) && PageMlocked(page))
> +			clear_page_mlock(page);
> +

Can you explain this more? I am confused by the usage of 'new' and 
'page' there. I guess the idea is if we are removing the migration pte 
at level 4 table, and if we found the backing page compound don't mark 
the page Mlocked?


-aneesh
