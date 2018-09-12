Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE041C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4E52088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mzh450CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4E52088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeILP2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:28:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43770 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:28:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so1423718wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q8xalLbf3CxPj39DOk0PKZGvlQU6d43iaIbjyORJs5M=;
        b=mzh450CXyQ+qpAfmXaDBqYM7AJZ1Rf40jyi1oZEm87MEwVDWyW9um35ni057rgLtL8
         DIXq0PoXDsOudYAZp3O3BV9iExpV/JK52TY91kJJeLpDi2nfGW6ZEWWhpabvOKGqkwlI
         VThd5vA2mxqb2ct1YJuRT3zCucW0mbZMAR65PrlQl5jocJ6gYdsv/lrNPo/u9gk6dyTM
         WREjux3J+2CsBpUncV6L6nRS117TZ9/LUk+CVAwOrFPkXxcNrbyYru+oawsQpNOHzeSb
         Iq3kTW3Mz/WLzca5bYH+M8g3oF4ntCzbeuYnhqFxRaw35b7wroF3jl2rhokWGApiDv0t
         DTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8xalLbf3CxPj39DOk0PKZGvlQU6d43iaIbjyORJs5M=;
        b=tkkoOCsyI8xnBlnnVXIeXqWRXdwUsFdfSolnZ9qqtWO4n6f/83M4YrWOLBCQV5E2bV
         reDXb5t5OXBg6g7XFg4OBkpI9yLqTY0AxPwlWomq0eHtZE634bCtZUB83eIWyVqEh58T
         8sGFueQephv/tFlYtUi1IvERfcAWKnCG9FTvTY6bYIPvZVtWipOCBiTSQcfW7uKV6SVx
         A20C/8DNLFlWTwqWxFEmBXjbL2/f+LUr98MeqcSDzHVE7jXjCa7I7BgDotxJfY0LABSF
         LclHtVeOhJ3ZQoe5SPWnH7mCR7ET2rt7vqHBAvNwmtcfY1ublKeMqa1KNlFL74jejait
         Ux4Q==
X-Gm-Message-State: APzg51CXaHMQpcfUmk5LMuk3w1N3guQkme5O1kuveqPVNo3xuhat9Ht0
        LkXUlrTzoCdpo9LxEBga2czbXg==
X-Google-Smtp-Source: ANB0VdbdZq51B2TEAs5jgqQ27FqZ315XLz0r87183c54DP5P/g9Fn55Zn89H8ZdTDrVazsaBHzptsw==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr919571wrd.187.1536747900319;
        Wed, 12 Sep 2018 03:25:00 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-129-246-122-178.brest.dynamic.pppoe.byfly.by. [178.122.246.129])
        by smtp.gmail.com with ESMTPSA id s10-v6sm525330wrw.35.2018.09.12.03.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 03:24:59 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3B426300DB6; Wed, 12 Sep 2018 13:24:58 +0300 (+03)
Date:   Wed, 12 Sep 2018 13:24:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, thp: Fix mlocking THP page with migration enabled
Message-ID: <20180912102457.deuqtyx2b67zfi7u@kshutemo-mobl1>
References: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
 <6fcb5b5b-43fa-f1d0-ce78-37fb51b46a75@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fcb5b5b-43fa-f1d0-ce78-37fb51b46a75@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:28:24PM +0530, Aneesh Kumar K.V wrote:
> On 9/11/18 4:04 PM, Kirill A. Shutemov wrote:
> > A transparent huge page is represented by a single entry on an LRU list.
> > Therefore, we can only make unevictable an entire compound page, not
> > individual subpages.
> > 
> > If a user tries to mlock() part of a huge page, we want the rest of the
> > page to be reclaimable.
> > 
> > We handle this by keeping PTE-mapped huge pages on normal LRU lists: the
> > PMD on border of VM_LOCKED VMA will be split into PTE table.
> > 
> > Introduction of THP migration breaks the rules around mlocking THP
> > pages. If we had a single PMD mapping of the page in mlocked VMA, the
> > page will get mlocked, regardless of PTE mappings of the page.
> > 
> > For tmpfs/shmem it's easy to fix by checking PageDoubleMap() in
> > remove_migration_pmd().
> > 
> > Anon THP pages can only be shared between processes via fork(). Mlocked
> > page can only be shared if parent mlocked it before forking, otherwise
> > CoW will be triggered on mlock().
> > 
> > For Anon-THP, we can fix the issue by munlocking the page on removing PTE
> > migration entry for the page. PTEs for the page will always come after
> > mlocked PMD: rmap walks VMAs from oldest to newest.
> > 
> > Test-case:
> > 
> > 	#include <unistd.h>
> > 	#include <sys/mman.h>
> > 	#include <sys/wait.h>
> > 	#include <linux/mempolicy.h>
> > 	#include <numaif.h>
> > 
> > 	int main(void)
> > 	{
> > 	        unsigned long nodemask = 4;
> > 	        void *addr;
> > 
> > 		addr = mmap((void *)0x20000000UL, 2UL << 20, PROT_READ | PROT_WRITE,
> > 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, -1, 0);
> > 
> > 	        if (fork()) {
> > 			wait(NULL);
> > 			return 0;
> > 	        }
> > 
> > 	        mlock(addr, 4UL << 10);
> > 	        mbind(addr, 2UL << 20, MPOL_PREFERRED | MPOL_F_RELATIVE_NODES,
> > 	                &nodemask, 4, MPOL_MF_MOVE | MPOL_MF_MOVE_ALL);
> > 
> > 	        return 0;
> > 	}
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
> > Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> > Cc: <stable@vger.kernel.org> [v4.14+]
> > Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > ---
> >   mm/huge_memory.c | 2 +-
> >   mm/migrate.c     | 3 +++
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 533f9b00147d..00704060b7f7 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2931,7 +2931,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
> >   	else
> >   		page_add_file_rmap(new, true);
> >   	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
> > -	if (vma->vm_flags & VM_LOCKED)
> > +	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
> >   		mlock_vma_page(new);
> >   	update_mmu_cache_pmd(vma, address, pvmw->pmd);
> >   }
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index d6a2e89b086a..01dad96b25b5 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -275,6 +275,9 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
> >   		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
> >   			mlock_vma_page(new);
> > +		if (PageTransCompound(new) && PageMlocked(page))
> > +			clear_page_mlock(page);
> > +
> 
> Can you explain this more? I am confused by the usage of 'new' and 'page'
> there.

'new' is the PTE subpage of 'page'. clear_page_mlock() wants to see head
page.

I guess we can rewrite it more clearly:

+		if (PageTransHuge(page) && PageMlocked(page))
+			clear_page_mlock(page);
+

> I guess the idea is if we are removing the migration pte at level 4
> table, and if we found the backing page compound don't mark the page
> Mlocked?

We has to clear mlock, not only don't mark it as such.
remove_migration_pmd() for other VMA may mark it as mlock and we want to
revert it on the first PTE mapping of the page.

-- 
 Kirill A. Shutemov
