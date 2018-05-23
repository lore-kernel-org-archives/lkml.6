Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-25873-1527076938-2-14717997759729703806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527076935; b=LjIEbJ5PdSfogel7OdifK4M/uDKTtXiNz1zXn1KTfubi9ha4LS
    dEPuPzfT66RXVTIE3OD7zuQSghIeMcr8YJzl9V2yLOJBnShQNLCEBDO+1TN5FiZO
    C0xVg6KkLkGE1bj8Sk19RLAts5abakT/ZZyuIBImVvXbPTsT9GRtAQY2Is66c0Yk
    A18lHg3f9ZpwxkVK+UkJ6wDhREjmTtdbayEv53WGB+rxjFRKnWTPsS8hMFUGAjlO
    Wai5ehrS5QNaTXWNd6Tal59rYCYs6GctSfB3VcPS1ZlKN8SmQYeFkcvN/7IqLIIy
    WFnN759Ou+gsdT8E6v0j4G5f78hKI7uizgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527076935; bh=hXlQg6tPTooRfNX9GORzlTOar+xTbP
    YcmwvoHoBr5No=; b=U1tUbGclhVmkPTxZTBtXMN19vTZBjLQjTqikSzsi8QplJe
    pgrI6dlZbKIMvWuQ/nyRaFyi8qqveK3V9Xr/UujZido7MZCkQ4p03K/uoBGvh7Vk
    oy4kog0NRKU1UIvHNz1oKjbCt+FcXM4ibPxuYPALjb+kjAzHxPfMo8D3mEmQmr4R
    uOK/Yw0F2erzZnbTFWn8W5FShXsgTdULsyOqazFcWRuZcVY10qEgGoZ0WCfHx+CZ
    h+odArbo4ZCPy2QQuxXm5XlLkaPAIDtaWlgzaPK58ETvD/qY3xctatIPW4zsAVya
    dO/MFA5n433IMUA4fXbCjkP+yinXn38b/3KME6tQ==
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
X-CM-Envelope: MS4wfNVrqOrnO9zTRZ35fyQHeQnEBKvgVaLH9YE3JBTpEycQbAOUhXpH4758HSwvWOGNzFvUjVgj7LRSlrnfbAXEKVZLEy4qJ2ixeB/LoMHV/aRI/DrQlMWL
    m6t/059AJkC34gevExJC8P6yHCNKdLNK7xmHSt3VkrQXV/TGq4eTY35lxImZ4NMn19RhvJuzsgmHRu+nJI9bUUyEVTyj9n5Bh/Bxt7k+RNJ5J4AjNsSqlbJG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=4F3XlSywcUUva-EzvioA:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbeEWMCN (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 08:02:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932544AbeEWMCM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 May 2018 08:02:12 -0400
Date: Wed, 23 May 2018 13:02:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] arm64: Use update{,_tsk}_thread_flag()
Message-ID: <20180523120239.GE26965@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
 <1524135528-28561-4-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524135528-28561-4-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 11:58:45AM +0100, Dave Martin wrote:
> This patch uses the new update_thread_flag() helpers to simplify a
> couple of if () set; else clear; constructs.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 87a3536..0c4e7e0 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -618,10 +618,8 @@ int sve_set_vector_length(struct task_struct *task,
>  	task->thread.sve_vl = vl;
>  
>  out:
> -	if (flags & PR_SVE_VL_INHERIT)
> -		set_tsk_thread_flag(task, TIF_SVE_VL_INHERIT);
> -	else
> -		clear_tsk_thread_flag(task, TIF_SVE_VL_INHERIT);
> +	update_tsk_thread_flag(task, TIF_SVE_VL_INHERIT,
> +			       flags & PR_SVE_VL_INHERIT);
>  
>  	return 0;
>  }
> @@ -902,7 +900,7 @@ void fpsimd_thread_switch(struct task_struct *next)
>  	if (current->mm)
>  		task_fpsimd_save();
>  
> -	if (next->mm) {
> +	if (next->mm)
>  		/*
>  		 * If we are switching to a task whose most recent userland
>  		 * FPSIMD state is already in the registers of *this* cpu,
> @@ -910,13 +908,10 @@ void fpsimd_thread_switch(struct task_struct *next)
>  		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
>  		 * upon the next return to userland.
>  		 */
> -		if (__this_cpu_read(fpsimd_last_state.st) ==
> -			&next->thread.uw.fpsimd_state
> -		    && next->thread.fpsimd_cpu == smp_processor_id())
> -			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
> -		else
> -			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
> -	}
> +		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
> +			__this_cpu_read(fpsimd_last_state.st) !=
> +				&next->thread.uw.fpsimd_state ||
> +			next->thread.fpsimd_cpu != smp_processor_id());

This will conflict with some patches in-flight from a chap called Dave
Martin ;)

Other than that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
