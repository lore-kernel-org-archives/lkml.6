Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2806471-1521067119-2-15428302032970237351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521067119; b=DICsvgxg4y2JQ4jmDLzj0SUizeJqUCTfh3IN3626ie5AERW
    viH4imc0smW9SKvBebFqRHAei0/Eo2QeFbj9FIpt3LXikyoZQXWcMh6CXwmRnVXe
    fP2Cyvhv0FjOhh5ql/QXgcIGRqkNRiG6PTjGjfbybH1Wxk93QcrdA7CN7nuK7ZhP
    gNSVxHFvc8HnyD87Wp0zRC+oM17335H3Cv3EugqrSVYXMpgSc8WRLp3WTuPGoIz8
    e8g3p0R7vR+ZKve92GVuruM9eqcU8s8dBjxo7FG67f2VG2NwuAzWvTWh74kHOB+e
    8DDBb7kPMYmoJXnKgth8hGu2aBDxzdL5+oqvIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521067119; bh=RvkcaMVJoUPVHv0T6cyKEWp2L0GK3EVNHRwaAxdzgQw=; b=J
    bz5zkyWmnw9kBIhHyuhibKcDhnOGnvKW+M2eeZaoSuY+d91UosSm8rLrBELjfN6c
    qimP+oNPHv5pkUiLOUkBFrlCp0p4veDXtwdKO2WQ6P5CoDUlknquFtUbr+DkZXCh
    IVz4QkrbyKEtmGGYqH2FCKcpbYmaIG1C7J444n1mDKXgTszPG08GN+/rRug+dQWr
    ch0N2fWARqR5Nj59CC6MwX8cLxvycR6FPt/cWByxPvKPNdwf/ictoEY+V4JzAgBv
    yefTgEg5pF++oWBMuQs93ZCP0+VQUR016fgHxC3KT7oaqBcVWbOsjpoCkPYyNc7n
    0ZI/zbkmgwqxW7ldN16Hw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeCNWii (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 18:38:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCNWih (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 18:38:37 -0400
Date: Wed, 14 Mar 2018 15:38:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bp@suse.de, catalin.marinas@arm.com,
        guohanjun@huawei.com, will.deacon@arm.com, wxf.wang@hisilicon.com,
        willy@infradead.org, cpandya@codeaurora.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Add interfaces to free unmapped page
 table
Message-Id: <20180314153835.68e75da3fdc18b27ad0e290c@linux-foundation.org>
In-Reply-To: <20180314180155.19492-2-toshi.kani@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
        <20180314180155.19492-2-toshi.kani@hpe.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Mar 2018 12:01:54 -0600 Toshi Kani <toshi.kani@hpe.com> wrote:

> On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
> may create pud/pmd mappings.  Kernel panic was observed on arm64
> systems with Cortex-A75 in the following steps as described by
> Hanjun Guo.
> 
>  1. ioremap a 4K size, valid page table will build,
>  2. iounmap it, pte0 will set to 0;
>  3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>     then set the a new value for pmd;
>  4. pte0 is leaked;
>  5. CPU may meet exception because the old pmd is still in TLB,
>     which will lead to kernel panic.
> 
> This panic is not reproducible on x86.  INVLPG, called from iounmap,
> purges all levels of entries associated with purged address on x86.
> x86 still has memory leak.
> 
> The patch changes the ioremap path to free unmapped page table(s) since
> doing so in the unmap path has the following issues:
> 
>  - The iounmap() path is shared with vunmap().  Since vmap() only
>    supports pte mappings, making vunmap() to free a pte page is an
>    overhead for regular vmap users as they do not need a pte page
>    freed up.
>  - Checking if all entries in a pte page are cleared in the unmap path
>    is racy, and serializing this check is expensive.
>  - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
>    Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
>    purge.
> 
> Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(),
> which clear a given pud/pmd entry and free up a page for the lower
> level entries.
> 
> This patch implements their stub functions on x86 and arm64, which
> work as workaround.
> 

whoops.

--- a/include/asm-generic/pgtable.h~mm-vmalloc-add-interfaces-to-free-unmapped-page-table-fix
+++ a/include/asm-generic/pgtable.h
@@ -1014,7 +1014,7 @@ static inline int pud_free_pmd_page(pud_
 {
 	return 0;
 }
-static inline int pmd_free_pte_page(pud_t *pmd)
+static inline int pmd_free_pte_page(pmd_t *pmd)
 {
 	return 0;
 }
_
