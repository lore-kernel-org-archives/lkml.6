Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2678423-1524752489-2-3688400166554123102
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524752488; b=vCz0lQVJbbwvCwoGz13TdyXr1XUqzwqHcSMJMe9trltYGq+Www
    nrhqKGHB9wNKxL3bacxyGGXglhoDWzmtI9/kMUZA/wkxohsKQna/dpuU2m/byNJj
    Eu+mlp3Zc7CRqINgxC7KjzOFTdX4Zr1f0KTmsUQ5sl+t2hlWgjM7wWGCGWCIv2l2
    UG+1hwrikN6/EWEBJbrPDjfSta4so8K9yt9srRHjz/nm938TRigyC9DE+ZQkaaeT
    yvqKmFv20oToyMJfxVxR3Ley6CQy4w7X0QThZ+VZK8OX2b2jC+TVF4rdcTBx3Pi7
    2I0nef2fLzMRkm+AbZSkzoMJXeKaLZ1qy75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524752488; bh=NJKAuRG9ci6Uk8zZrPuI8bBUulOoCq
    E65ou6Hzqv3Sw=; b=PkiZwoY0p/syGu0k/CUSkw2dgU6Xl/Z02kYr5w+ra2e5H+
    +Dngcav0/1tl93GxW+2XoOEjr+V9boMEjmxS/FlCJ04pjhds+aguC3HNG6El7Vkd
    8zykb/LBio87xCvpSIYM+iOt38ZPx1tPKJTVqKIH+Aupninsyd7vk6qjjgUtY6J7
    8S6js5icimXgPnVWUpdIv8WLMHbuciDbH5QUAZPGh+fUbCTjIZEGUtSde/yZm7yH
    AkPQdhJfGR8z4/BOTGfFlEckbPnawxjdcuVrCGO5brrYnuVK5yBZfnVa7tDzfyI0
    rh9rRNucNi5RQAwj/yO6Q0iofxtzRkWIidRoqNcg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=DNOHagHY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=DNOHagHY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNJYPSIsh0fUGSe3P13PkXXuTJ/9nigJXbJ48lgGA43n+TdiJJUvAk1R+CUrXvrYWoaeJGhpZ719yeNJivUzyieQR+buKKmuKIbgd2ou0mMsS3kJ9rH
    GxCgRwQO8ls8H3+ymrTgragB5uwYmK7rur7eSvG5JOQhj4BO7rjeJgidwie26vFjfEYj+EN03EI24S8iXEclRmzk4XfsZUS2CmYA6UUFGOnHkDf9XoXJXLpN
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ErGtf2ZWZXZoqN4hRzUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756535AbeDZOTc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 10:19:32 -0400
Received: from 8bytes.org ([81.169.241.247]:51914 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756431AbeDZOT2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 10:19:28 -0400
Date: Thu, 26 Apr 2018 16:19:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        catalin.marinas@arm.com, guohanjun@huawei.com, will.deacon@arm.com,
        wxf.wang@hisilicon.com, willy@infradead.org,
        cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180426141926.GN15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314180155.19492-3-toshi.kani@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Toshi, Andrew,

this patch(-set) is broken in several ways, please see below.

On Wed, Mar 14, 2018 at 12:01:55PM -0600, Toshi Kani wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> clear a given pud/pmd entry and free up lower level page table(s).
> Address range associated with the pud/pmd entry must have been purged
> by INVLPG.

An INVLPG before actually unmapping the page is useless, as other cores
or even speculative instruction execution can bring the TLB entry back
before the code actually unmaps the page.

>  int pud_free_pmd_page(pud_t *pud)
>  {
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
> +			return 0;
> +
> +	pud_clear(pud);

TLB flush needed here, before the page is freed.

> +	free_page((unsigned long)pmd);
> +
> +	return 1;
>  }
>  
>  /**
> @@ -724,6 +739,15 @@ int pud_free_pmd_page(pud_t *pud)
>   */
>  int pmd_free_pte_page(pmd_t *pmd)
>  {
> -	return pmd_none(*pmd);
> +	pte_t *pte;
> +
> +	if (pmd_none(*pmd))
> +		return 1;
> +
> +	pte = (pte_t *)pmd_page_vaddr(*pmd);
> +	pmd_clear(pmd);

Same here, TLB flush needed.

Further this needs synchronization with other page-tables in the system
when the kernel PMDs are not shared between processes. In x86-32 with
PAE this causes a BUG_ON() being triggered at arch/x86/mm/fault.c:268
because the page-tables are not correctly synchronized.

> +	free_page((unsigned long)pte);
> +
> +	return 1;
>  }
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
