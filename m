Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1121475-1526927390-2-11205631707316557871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526927389; b=aWZg4GuemADAvEBkWDqKA1QdRzC8uK4QZwsfCCAKkXezRxngHA
    Lcqmp9YukFdqX2MAw3fIuwTTeC5V6FjJq9Jwnsrw9D7vWnZNYHIfytrs4zNl7nD/
    mYHj7Rcx6J7XJZhCMRha3ci2zuic3KPpKc3v8QX4WnIY6xnbVSphThPA+bT3GMVC
    C8NIWgY1uNphJ4/1ql2HEdYr8xhiHxMZUhA1ij1zsAZC9xlG8fcil3I+B/cSnvPg
    Nai6ok3imjTrfWPK6QERhQTfMa1jEU/phrXtuE/6sowO27qcg5214jx5iENl2AP8
    9xXXLslLAvSlxwRHtMrHbjwI7kxQPlWM4D5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526927389; bh=4tcWauGKcOWbtERBXJzQo6L14ZsSCh
    /3xyJk+YijsIY=; b=APDvQqNWeiSfydBFm0PmOB7P7YY9WOoR7krpUtO171pG+M
    GRa8Pq81/7WM2xCQClQ+juF8/kwy6VbQE6GouRfKKpKCzex7C7lLdg5njf/ra1Tx
    M9/DDbc8SE/iCBS/K/ZBN+Ap4Io8UgzV6fJzo4tkBx6sQsHrV6xOFXlcpJnnZZJv
    FZunV956Fb8CIdSsMbLV0x/Ff6Qxx2Rs1WC8IKabbKqTVCuXX4W5Gxz6YSQO5Yab
    HCdIbVAjSwCMl9rVk2Xl4JhIa8epp4Z3kRvggf3FVQUYZoX0D0QvUnukogeSe6j2
    iNZJVz4JC8RGjqMhp0sUuxqFi5BCvD6WRnfX7fpA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDwVu4gDRYduZDcAAzkrqmKofbRk0/NvLjGhlFPlx+QVwUxGF90dLLw3/QUYBRNdiWwjuNDQj/FCSdl2LViS4OLY67yWxJEJ+F4ysh4912aYU5ZX88t
    lyYMN634nMmdOQTVCDb5L5UIoiYS/TfVObFzhYVi/+CARwO1C7E9GNO6+7uh/dLm53ddE4U+THdpZf7mP3yIwbS0ItWtFaMjzHuNTTJF7C6nyfe1Js/4NXXT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=-AcA2M35yLkjeoTpAYQA:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeEUS3s (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 14:29:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeEUS3r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 May 2018 14:29:47 -0400
Date: Mon, 21 May 2018 19:30:14 +0100
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, marc.zyngier@arm.com
Subject: Re: [RFC PATCH 02/11] arm64: Move arch-specific prctls out of core
 code
Message-ID: <20180521183014.GD19122@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
 <1526318067-4964-3-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526318067-4964-3-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 06:14:18PM +0100, Dave Martin wrote:
> This patch moves the arm64-specific prctl call implementations out
> of core code and removes redundant boilerplate associated with
> them.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/Kconfig                 |  1 +
>  arch/arm64/include/asm/processor.h |  4 ----
>  arch/arm64/kernel/sys.c            | 15 +++++++++++++++
>  kernel/sys.c                       | 12 ------------
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf49..6b706af 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -123,6 +123,7 @@ config ARM64
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_PRCTL_ARCH
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RCU_TABLE_FREE
>  	select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 7675989..b1d262f 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -244,9 +244,5 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
>  void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
>  void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
>  
> -/* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
> -#define SVE_SET_VL(arg)	sve_set_current_vl(arg)
> -#define SVE_GET_VL()	sve_get_current_vl()
> -
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_PROCESSOR_H */
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index 72981ba..597ff35 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -22,10 +22,12 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/export.h>
> +#include <linux/prctl.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <asm/cpufeature.h>
> +#include <asm/fpsimd.h>
>  
>  asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
>  			 unsigned long prot, unsigned long flags,
> @@ -45,6 +47,19 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
>  	return sys_personality(personality);
>  }
>  
> +int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
> +	       unsigned long arg4, unsigned long arg5)
> +{
> +	switch (option) {
> +	case PR_SVE_SET_VL:
> +		return sve_set_current_vl(arg2);
> +	case PR_SVE_GET_VL:
> +		return sve_get_current_vl();
> +	default:
> +		return -EINVAL;
> +	}
> +}

If we think this might grow, then it might be worth adding a prctl.c to
collect these together. Anyhow:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
