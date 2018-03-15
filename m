Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3865743-1521099578-2-17246976662481868242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521099577; b=ZI9z4EZQzo0P36K5FPkzWA7qitYNj8Ft8x3W9NK2hoLTbLV
    HTgs1L+Rf2wjAbQga8sPy3bdUaewzxe4PprZYh9uT9HJ2TpnxZrh7GrO3CZkGu8L
    yJMH0Gq3xfFsTsHKcr1CnzRh1Fh6R/Iq7FTe+UgVPBF1Pe035NpZBtC5c98AxUp4
    VNuH0J9DQ1hPTXQeQ6jcMwXj6yLwwUDJaq0m6ZEiaLxO5COAQeNsquBgGP4DGh9x
    KNGVnfQlR6Z4qwioRqxZAYhpV1YKwnXsKSQRidfgbMBOgRViaiFiHyEGYPj2FR74
    2IUrmPonnYuLMYlT4cDaPNLrjIqKTKzlRwrsFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521099577; bh=BRlg1JX7zgQoBm1Rlwlnadnt2t4Rx8DI7ISKGntCIRQ=; b=i
    WPASQieTZmqR2uwQC89cBk/NF/PVV0NbOWOXdrXGTSVb8u/8X9S0XqepYv2Zb2AH
    dY7m5XswmtmIL9BDNphdWUW0RTxaq5F3ROsGTLJDqrffST44qFeCm5vjRmHByQGo
    MXMUFl8xUgF66rT18CL2N6y05LJDx615w4/+qFzxqykXVBSi+hgo1HoJ/5WLESqT
    MCXFOKkAnidGsgTszW/8iEeXtw/Ua6aVmzpQUiqi2s/IbltFr0TnV7lktdW87Wqp
    MQ5NWf7jU1JcWu8vpuxk78kIlfnATYYyzBkYrjKSIqs1ltaqEnGspUFLemzIKnkt
    pZ3DyhP4jdLp703LWZCAg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=EGnk003K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=jfF9NOJW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=EGnk003K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=jfF9NOJW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750729AbeCOHjg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 03:39:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeCOHjf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 03:39:35 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4B27603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
To: Toshi Kani <toshi.kani@hpe.com>, mhocko@suse.com,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bp@suse.de, catalin.marinas@arm.com
Cc: x86@kernel.org, wxf.wang@hisilicon.com, guohanjun@huawei.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <14cb9fdf-25de-6519-2200-43f585b64cdd@codeaurora.org>
Date: Thu, 15 Mar 2018 13:09:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314180155.19492-3-toshi.kani@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/14/2018 11:31 PM, Toshi Kani wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> clear a given pud/pmd entry and free up lower level page table(s).
> Address range associated with the pud/pmd entry must have been purged
> by INVLPG.
> 
> fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> ---
>   arch/x86/mm/pgtable.c |   28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 1eed7ed518e6..34cda7e0551b 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -712,7 +712,22 @@ int pmd_clear_huge(pmd_t *pmd)
>    */
>   int pud_free_pmd_page(pud_t *pud)
>   {
> -	return pud_none(*pud);
> +	pmd_t *pmd;
> +	int i;
> +
> +	if (pud_none(*pud))
> +		return 1;
> +
> +	pmd = (pmd_t *)pud_page_vaddr(*pud);
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++)
> +		if (!pmd_free_pte_page(&pmd[i]))

This is forced action and no optional. Also, pmd_free_pte_page()
doesn't return 0 in any case. So, you may remove _if_ ?

> +			return 0;
> +
> +	pud_clear(pud);
> +	free_page((unsigned long)pmd);
> +
> +	return 1;
>   }
>   
>   /**
> @@ -724,6 +739,15 @@ int pud_free_pmd_page(pud_t *pud)
>    */
>   int pmd_free_pte_page(pmd_t *pmd)
>   {
> -	return pmd_none(*pmd);
> +	pte_t *pte;
> +
> +	if (pmd_none(*pmd))

This should also check if pmd is already huge. Same for pud ?

> +		return 1;
> +
> +	pte = (pte_t *)pmd_page_vaddr(*pmd);
> +	pmd_clear(pmd);
> +	free_page((unsigned long)pte);
> +
> +	return 1;
>   }
>   #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
