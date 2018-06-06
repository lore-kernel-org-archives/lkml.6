Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2D5F60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeFFPoN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:44:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42236 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeFFPoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:44:11 -0400
Date: Wed, 6 Jun 2018 16:44:42 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/3] arm64: tlbflush: Introduce
 __flush_tlb_kernel_pgtable
Message-ID: <20180606154442.GF6631@arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528268481-19299-3-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:31:20PM +0530, Chintan Pandya wrote:
> Add an interface to invalidate intermediate page tables
> from TLB for kernel.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index dfc61d7..a4a1901 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -218,6 +218,13 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>  	dsb(ish);
>  }
>  
> +static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
> +{
> +	unsigned long addr = __TLBI_VADDR(kaddr, 0);
> +
> +	__tlbi(vaae1is, addr);
> +	dsb(ish);
> +}
>  #endif

Acked-by: Will Deacon <will.deacon@arm.com>

Will
