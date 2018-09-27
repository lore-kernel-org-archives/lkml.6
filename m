Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355752147D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SqdEiZVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355752147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI0TIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:08:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36466 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0TIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:08:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so1907757pgo.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quiYalV23/vFXpRW0xIBQa0oObcLfNfvL1V6WSPd7Qk=;
        b=SqdEiZVeWIzydhRg3SUEDG+QqH1cyLptJDT4JyOszfmYzlxYzXg6Q9AK4C8Sdyaj4+
         QCOpwFQQWPky+ZrT0ey/514kfVJFCviAVckjFBJlZKjrxobIUq3GV4SNcuhSrgZekA/L
         /0Wk1Ic1jpLk2RN1ZxQO2YtxHah8f21witMc/Cu5xCC8BpPzyI2aEs7fCWgSJugC1Oea
         0ZzE5LDpovG4YiGHlxPx9nFD9gY/TxGGf8JIsCFYZGvKzqRA//Z+pPB/KWzWvayFyxoa
         itXU4zRRmZSwh2TmW7G1ro3gwhI3mBX6yxMIhpaaXGOa4G30vyzt4b9feJK/+xfuf14B
         xCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quiYalV23/vFXpRW0xIBQa0oObcLfNfvL1V6WSPd7Qk=;
        b=eQPrycxJ1fhHOt2dn/BiaPdIMK1pi3I5ole0RMfKHsSEVfsF5APJ9ftQs3SNp9TZz3
         cLuJcDPkitTqKXxe1ogOtZsZCPGz7OqRpdV8S2r6tBY5zphzQra2ZhkbdXDbYbBH5kgI
         t/17MlAjmbvzAQeAemPHSKgdSrZlGrA64tB0AWXmmnVgyMZm4VCi9LC6uaNQ0zEosycE
         hL46/G/wvdmf7RxNpAIVVwNjSLZgMTPz6MtJpChNAgCcHgg3WuftDtSGlxJHNHTBvzz1
         yp6CV9U5cwYZJ9gS5NaJ7/Herei2s+rS2+ATFPd4VXk4O2zZaKhS37Za6Y8evYIgrWV5
         GIew==
X-Gm-Message-State: ABuFfogA9dDTRPXgGxI/2yWervyvC3m2Q2+LBnhyTU2ZXuvdb9q9nim+
        NTOMNsKO/LWKHcEHqURZvI2X9g==
X-Google-Smtp-Source: ACcGV61EQ5aXzEkCOsXbeh2bJEBF/HXAj1nE37CTUfa7JSMrq/ebxbNvSjQJdZsU2NM5KiIkydDEGQ==
X-Received: by 2002:a62:d286:: with SMTP id c128-v6mr10078115pfg.14.1538052631695;
        Thu, 27 Sep 2018 05:50:31 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id h88-v6sm6943235pfa.184.2018.09.27.05.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 05:50:30 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1EB8E300029; Thu, 27 Sep 2018 15:50:26 +0300 (+03)
Date:   Thu, 27 Sep 2018 15:50:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2 -mm] mm: brk: dwongrade mmap_sem to read when
 shrinking
Message-ID: <20180927125025.xnvoh2btdq5kjmai@kshutemo-mobl1>
References: <1537985434-22655-1-git-send-email-yang.shi@linux.alibaba.com>
 <1537985434-22655-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537985434-22655-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:10:34AM +0800, Yang Shi wrote:
> brk might be used to shinrk memory mapping too other than munmap().

s/shinrk/shrink/

> So, it may hold write mmap_sem for long time when shrinking large
> mapping, as what commit ("mm: mmap: zap pages with read mmap_sem in
> munmap") described.
> 
> The brk() will not manipulate vmas anymore after __do_munmap() call for
> the mapping shrink use case. But, it may set mm->brk after
> __do_munmap(), which needs hold write mmap_sem.
> 
> However, a simple trick can workaround this by setting mm->brk before
> __do_munmap(). Then restore the original value if __do_munmap() fails.
> With this trick, it is safe to downgrade to read mmap_sem.
> 
> So, the same optimization, which downgrades mmap_sem to read for
> zapping pages, is also feasible and reasonable to this case.
> 
> The period of holding exclusive mmap_sem for shrinking large mapping
> would be reduced significantly with this optimization.
> 
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: Rephrase the commit per Michal
> 
>  mm/mmap.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 017bcfa..0d2fae1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -193,9 +193,11 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
>  	unsigned long retval;
>  	unsigned long newbrk, oldbrk;
>  	struct mm_struct *mm = current->mm;
> +	unsigned long origbrk = mm->brk;

Is it safe to read mm->brk outside the lock?

>  	struct vm_area_struct *next;
>  	unsigned long min_brk;
>  	bool populate;
> +	bool downgrade = false;

Again,

s/downgrade/downgraded/ ?

>  	LIST_HEAD(uf);
>  
>  	if (down_write_killable(&mm->mmap_sem))
> @@ -229,14 +231,29 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
>  
>  	newbrk = PAGE_ALIGN(brk);
>  	oldbrk = PAGE_ALIGN(mm->brk);
> -	if (oldbrk == newbrk)
> -		goto set_brk;
> +	if (oldbrk == newbrk) {
> +		mm->brk = brk;
> +		goto success;
> +	}
>  
> -	/* Always allow shrinking brk. */
> +	/*
> +	 * Always allow shrinking brk.
> +	 * __do_munmap() may downgrade mmap_sem to read.
> +	 */
>  	if (brk <= mm->brk) {
> -		if (!do_munmap(mm, newbrk, oldbrk-newbrk, &uf))
> -			goto set_brk;
> -		goto out;
> +		/*
> +		 * mm->brk need to be protected by write mmap_sem, update it
> +		 * before downgrading mmap_sem.
> +		 * When __do_munmap fail, it will be restored from origbrk.
> +		 */
> +		mm->brk = brk;
> +		retval = __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
> +		if (retval < 0) {
> +			mm->brk = origbrk;
> +			goto out;
> +		} else if (retval == 1)
> +			downgrade = true;
> +		goto success;
>  	}
>  
>  	/* Check against existing mmap mappings. */
> @@ -247,18 +264,21 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
>  	/* Ok, looks good - let it rip. */
>  	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
>  		goto out;
> -
> -set_brk:
>  	mm->brk = brk;
> +
> +success:
>  	populate = newbrk > oldbrk && (mm->def_flags & VM_LOCKED) != 0;
> -	up_write(&mm->mmap_sem);
> +	if (downgrade)
> +		up_read(&mm->mmap_sem);
> +	else
> +		up_write(&mm->mmap_sem);
>  	userfaultfd_unmap_complete(mm, &uf);
>  	if (populate)
>  		mm_populate(oldbrk, newbrk - oldbrk);
>  	return brk;
>  
>  out:
> -	retval = mm->brk;
> +	retval = origbrk;
>  	up_write(&mm->mmap_sem);
>  	return retval;
>  }
> -- 
> 1.8.3.1
> 

-- 
 Kirill A. Shutemov
