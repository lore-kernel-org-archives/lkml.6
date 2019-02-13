Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09FC222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391800AbfBMLVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:21:41 -0500
Received: from foss.arm.com ([217.140.101.70]:51984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfBMLVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:21:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9195DA78;
        Wed, 13 Feb 2019 03:21:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4E063F557;
        Wed, 13 Feb 2019 03:21:38 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:21:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Message-ID: <20190213112136.GB22119@lakrids.cambridge.arm.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-2-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213094831.7292-2-peng.fan@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:37:29AM +0000, Peng Fan wrote:
> The empty zero page has been moved to bss area by
> commit 5227cfa71f9e ("arm64: mm: place empty_zero_page in bss"),
> and it alreay added "dsb     ishst" in head.S to make sure the empty
> zero page visible to PTW.
> 
> There is no code to reflect the comment, so remove it.

The comment below refers to the memory pointed to by ptr, which is
zeroed by the memset. The comment does not refer to the generic
empty_zero_page.

This comment is correct, and should stay. Please drop this patch.

Thanks,
Mark.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 065202da3ad2..f61fa7c8fd2e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -113,10 +113,6 @@ static phys_addr_t __init early_pgtable_alloc(void)
>  
>  	memset(ptr, 0, PAGE_SIZE);
>  
> -	/*
> -	 * Implicit barriers also ensure the zeroed page is visible to the page
> -	 * table walker
> -	 */
>  	pte_clear_fixmap();
>  
>  	return phys;
> -- 
> 2.16.4
> 
