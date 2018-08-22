Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B292C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557C20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557C20C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeHVOU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728234AbeHVOU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:20:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23CE5ADE3;
        Wed, 22 Aug 2018 10:56:00 +0000 (UTC)
Subject: Re: [RFC v8 PATCH 2/5] uprobes: introduce has_uprobes helper
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-3-git-send-email-yang.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <e7147e14-bc38-03d0-90a4-5e0ca7e40050@suse.cz>
Date:   Wed, 22 Aug 2018 12:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534358990-85530-3-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 08:49 PM, Yang Shi wrote:
> We need check if mm or vma has uprobes in the following patch to check
> if a vma could be unmapped with holding read mmap_sem. The checks and
> pre-conditions used by uprobe_munmap() look just suitable for this
> purpose.
> 
> Extracting those checks into a helper function, has_uprobes().
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/linux/uprobes.h |  7 +++++++
>  kernel/events/uprobes.c | 23 ++++++++++++++++-------
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 0a294e9..418764e 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -149,6 +149,8 @@ struct uprobes_state {
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  					 void *src, unsigned long len);
> +extern bool has_uprobes(struct vm_area_struct *vma, unsigned long start,
> +			unsigned long end);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> @@ -203,5 +205,10 @@ static inline void uprobe_copy_process(struct task_struct *t, unsigned long flag
>  static inline void uprobe_clear_state(struct mm_struct *mm)
>  {
>  }
> +static inline bool has_uprobes(struct vm_area_struct *vma, unsigned long start,
> +			       unsgined long end)
> +{
> +	return false;
> +}
>  #endif /* !CONFIG_UPROBES */
>  #endif	/* _LINUX_UPROBES_H */
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index aed1ba5..568481c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1114,22 +1114,31 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  	return !!n;
>  }
>  
> -/*
> - * Called in context of a munmap of a vma.
> - */
> -void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end)
> +bool
> +has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long end)

The name is not really great...

>  {
>  	if (no_uprobe_events() || !valid_vma(vma, false))
> -		return;
> +		return false;
>  
>  	if (!atomic_read(&vma->vm_mm->mm_users)) /* called by mmput() ? */
> -		return;
> +		return false;
>  
>  	if (!test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags) ||
>  	     test_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags))

This means that vma might have uprobes, but since RECALC is already set,
we don't need to set it again. That's different from "has uprobes".

Perhaps something like vma_needs_recalc_uprobes() ?

But I also worry there might be a race where we initially return false
because of MMF_RECALC_UPROBES, then the flag is cleared while vma's
still have uprobes, then we downgrade mmap_sem and skip uprobe_munmap().
Should be checked if e.g. mmap_sem and vma visibility changes protects
this case from happening.

> -		return;
> +		return false;
>  
>  	if (vma_has_uprobes(vma, start, end))
> +		return true;
> +
> +	return false;

Simpler:
	return vma_has_uprobes(vma, start, end);

> +}
> +
> +/*
> + * Called in context of a munmap of a vma.
> + */
> +void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end)
> +{
> +	if (has_uprobes(vma, start, end))
>  		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
>  }
>  
> 

