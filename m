Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8639C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609EA22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609EA22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbeKMT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:26:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbeKMT0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:26:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C30180466;
        Tue, 13 Nov 2018 09:29:01 +0000 (UTC)
Received: from [10.36.118.33] (unknown [10.36.118.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1317A5D756;
        Tue, 13 Nov 2018 09:28:56 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm: make dev_pagemap_mapping_shift() externally
 visible
To:     Barret Rhoden <brho@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com,
        linux-mm@kvack.org
References: <20181109203921.178363-1-brho@google.com>
 <20181109203921.178363-2-brho@google.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <55978932-90ee-c327-b445-990849250eb1@redhat.com>
Date:   Tue, 13 Nov 2018 10:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109203921.178363-2-brho@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 13 Nov 2018 09:29:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.18 21:39, Barret Rhoden wrote:
> KVM has a use case for determining the size of a dax mapping.  The KVM
> code has easy access to the address and the mm; hence the change in
> parameters.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  include/linux/mm.h  |  3 +++
>  mm/memory-failure.c | 38 +++-----------------------------------
>  mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5411de93a363..51215d695753 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -935,6 +935,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>  }
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
>  
> +unsigned long dev_pagemap_mapping_shift(unsigned long address,
> +					struct mm_struct *mm);
> +
>  static inline void get_page(struct page *page)
>  {
>  	page = compound_head(page);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 0cd3de3550f0..c3f2c6a8607e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -265,40 +265,6 @@ void shake_page(struct page *p, int access)
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
>  
> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> -		struct vm_area_struct *vma)
> -{
> -	unsigned long address = vma_address(page, vma);
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -
> -	pgd = pgd_offset(vma->vm_mm, address);
> -	if (!pgd_present(*pgd))
> -		return 0;
> -	p4d = p4d_offset(pgd, address);
> -	if (!p4d_present(*p4d))
> -		return 0;
> -	pud = pud_offset(p4d, address);
> -	if (!pud_present(*pud))
> -		return 0;
> -	if (pud_devmap(*pud))
> -		return PUD_SHIFT;
> -	pmd = pmd_offset(pud, address);
> -	if (!pmd_present(*pmd))
> -		return 0;
> -	if (pmd_devmap(*pmd))
> -		return PMD_SHIFT;
> -	pte = pte_offset_map(pmd, address);
> -	if (!pte_present(*pte))
> -		return 0;
> -	if (pte_devmap(*pte))
> -		return PAGE_SHIFT;
> -	return 0;
> -}
> -
>  /*
>   * Failure handling: if we can't find or can't kill a process there's
>   * not much we can do.	We just print a message and ignore otherwise.
> @@ -329,7 +295,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  	tk->addr = page_address_in_vma(p, vma);
>  	tk->addr_valid = 1;
>  	if (is_zone_device_page(p))
> -		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> +		tk->size_shift =
> +			dev_pagemap_mapping_shift(vma_address(page, vma),
> +						  vma->vm_mm);
>  	else
>  		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>  
> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..61bc9bab931d 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -780,3 +780,37 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  out:
>  	return res;
>  }
> +
> +unsigned long dev_pagemap_mapping_shift(unsigned long address,
> +					struct mm_struct *mm)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset(mm, address);
> +	if (!pgd_present(*pgd))
> +		return 0;
> +	p4d = p4d_offset(pgd, address);
> +	if (!p4d_present(*p4d))
> +		return 0;
> +	pud = pud_offset(p4d, address);
> +	if (!pud_present(*pud))
> +		return 0;
> +	if (pud_devmap(*pud))
> +		return PUD_SHIFT;
> +	pmd = pmd_offset(pud, address);
> +	if (!pmd_present(*pmd))
> +		return 0;
> +	if (pmd_devmap(*pmd))
> +		return PMD_SHIFT;
> +	pte = pte_offset_map(pmd, address);
> +	if (!pte_present(*pte))
> +		return 0;
> +	if (pte_devmap(*pte))
> +		return PAGE_SHIFT;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
> 

Looks good to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
