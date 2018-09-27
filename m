Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C002147D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nPjhcedu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C002147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeI0TEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:04:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46460 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeI0TEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:04:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id d8-v6so1825163pfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=glg8Kn1zuYKucLuibWvdd7IIHSdDkUywOJ5LGPayBGA=;
        b=nPjhceduI+T4YxmC9xvm0wY24g/tXUe5lEYAKj3OOaVnZwgu++AX9p60BTTw7wknDb
         uJklD4uVVLs3uFbOnGdApULXA/1uVmpZr27gOzWBaJN+/lZ1p5n6i1ygVzIveJmj0+58
         XgB++wjavYauL4LI+5iuWtDKR1xE/3+ZwN8B63XlsfHhHDxa4Yr6LODdBHoCSNq5vD6r
         dmMPSQBFt+riYlMf2boqOZ8x5bhO7/+pRWHP65bkuHIs6GKMZHPUGhtDoDKYZ+7nNwYv
         F8jQVigNHJfveE6MzPdN4vlAsnz+YSDUCMmp0m1RtZbwfoJaA3Z+18jScNDOGQJbdyOA
         o4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=glg8Kn1zuYKucLuibWvdd7IIHSdDkUywOJ5LGPayBGA=;
        b=llItgljCXG8dO2FbY0HjnyV1CoC+jrBO4eaR8ZRUu8CoqS3CFDd04jra3AUI0W2C2x
         RydmhZI0YSISexye7sjUjL7MnJ0a1L0eA94nrhGDVAyGF+LXBlhKZC6O0vQT0BC5haB6
         I/DDkG930o1Bjv4RJp1aoMeqc2iJDVzCAQIrNCKSXrLzkRTvbzCM/aIEIhSG6mGe0vhy
         CQyEntdL/11vdEH1SZUJolIH5PTA16xhyUwA+Kb/KG/ZKNY25LuzmeIFRIKjn7eyfvPL
         wQwecPdh8cusiTfaO8NF6ODN2TDy5po1N3xXf8Z/kOUW9fbEvtenBZ1XF7OFtUiOVAG5
         60jQ==
X-Gm-Message-State: ABuFfoilcYfEqZjdtgMEw6sJQEbpAMSNlq8a4gmVNNWMdHlHxweewXwA
        Oy07PAeghUxHwszlhyKBgftbk91NWTzOyw==
X-Google-Smtp-Source: ACcGV63UBxlSqjOuqM4rf8gynxzqSA09Q5i2KNoHaAin4/EdIhQ0z70vGwRRpPdcNVXNEghKintX/w==
X-Received: by 2002:a63:e355:: with SMTP id o21-v6mr921233pgj.251.1538052383994;
        Thu, 27 Sep 2018 05:46:23 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id a19-v6sm4339229pfj.38.2018.09.27.05.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 05:46:22 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A994C300029; Thu, 27 Sep 2018 15:46:18 +0300 (+03)
Date:   Thu, 27 Sep 2018 15:46:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2 -mm] mm: mremap: dwongrade mmap_sem to read when
 shrinking
Message-ID: <20180927124618.dsg4xtxcmn5hrdj6@kshutemo-mobl1>
References: <1537985434-22655-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537985434-22655-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:10:33AM +0800, Yang Shi wrote:
> Other than munmap, mremap might be used to shrink memory mapping too.
> So, it may hold write mmap_sem for long time when shrinking large
> mapping, as what commit ("mm: mmap: zap pages with read mmap_sem in
> munmap") described.
> 
> The mremap() will not manipulate vmas anymore after __do_munmap() call for
> the mapping shrink use case, so it is safe to downgrade to read mmap_sem.
> 
> So, the same optimization, which downgrades mmap_sem to read for zapping
> pages, is also feasible and reasonable to this case.
> 
> The period of holding exclusive mmap_sem for shrinking large mapping
> would be reduced significantly with this optimization.
> 
> MREMAP_FIXED and MREMAP_MAYMOVE are more complicated to adopt this
> optimization since they need manipulate vmas after do_munmap(),
> downgrading mmap_sem may create race window.
> 
> Simple mapping shrink is the low hanging fruit, and it may cover the
> most cases of unmap with munmap together.
> 
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: Rephrase the commit log per Michal
> 
>  include/linux/mm.h |  2 ++
>  mm/mmap.c          |  4 ++--
>  mm/mremap.c        | 17 +++++++++++++----
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a61ebe8..3028028 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2286,6 +2286,8 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot, unsigned long flags,
>  	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
>  	struct list_head *uf);
> +extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
> +		       struct list_head *uf, bool downgrade);
>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
>  		     struct list_head *uf);
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 847a17d..017bcfa 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2687,8 +2687,8 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>   * work.  This now handles partial unmappings.
>   * Jeremy Fitzhardinge <jeremy@goop.org>
>   */
> -static int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> -		       struct list_head *uf, bool downgrade)
> +int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> +		struct list_head *uf, bool downgrade)
>  {
>  	unsigned long end;
>  	struct vm_area_struct *vma, *prev, *last;
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5c2e185..8f1ec2b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -525,6 +525,7 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
>  	unsigned long ret = -EINVAL;
>  	unsigned long charged = 0;
>  	bool locked = false;
> +	bool downgrade = false;

s/downgrade/downgraded/ ?

Otherwise looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
