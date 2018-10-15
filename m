Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF9C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25303204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25303204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeJON17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:27:59 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48815 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJON17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:27:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gBvfr-0008QU-UU; Sun, 14 Oct 2018 23:44:15 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gBvfn-0004P2-M6; Sun, 14 Oct 2018 23:44:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     tip-bot for Dave Hansen <tipbot@zytor.com>
Cc:     linux-tip-commits@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, jannh@google.com,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        luto@kernel.org
References: <20180928160223.9C4F6440@viggo.jf.intel.com>
        <tip-aa37c51b9421d66f7931c5fdcb9ce80c450974be@git.kernel.org>
Date:   Mon, 15 Oct 2018 00:43:57 -0500
In-Reply-To: <tip-aa37c51b9421d66f7931c5fdcb9ce80c450974be@git.kernel.org>
        (tip-bot for Dave Hansen's message of "Tue, 9 Oct 2018 08:03:12
        -0700")
Message-ID: <87k1mjpxwi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gBvfn-0004P2-M6;;;mid=<87k1mjpxwi.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+B1G6K3ElIn/Fxkebubq/QgkpD7+PjUK8=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [tip:x86/mm] x86/mm: Break out user address space handling
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tip-bot for Dave Hansen <tipbot@zytor.com> writes:

> Commit-ID:  aa37c51b9421d66f7931c5fdcb9ce80c450974be
> Gitweb:     https://git.kernel.org/tip/aa37c51b9421d66f7931c5fdcb9ce80c450974be
> Author:     Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate: Fri, 28 Sep 2018 09:02:23 -0700
> Committer:  Peter Zijlstra <peterz@infradead.org>
> CommitDate: Tue, 9 Oct 2018 16:51:15 +0200
>
> x86/mm: Break out user address space handling
>
> The last patch broke out kernel address space handing into its own
> helper.  Now, do the same for user address space handling.
>
> Cc: x86@kernel.org
> Cc: Jann Horn <jannh@google.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180928160223.9C4F6440@viggo.jf.intel.com
> ---
>  arch/x86/mm/fault.c | 47 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index c7e32f453852..0d1f5d39fc63 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -966,6 +966,7 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
>  }
>  
> +/* Handle faults in the kernel portion of the address space */
                           ^^^^^^
I believe you mean the __user__ portion of the address space.
Given that the call chain is:

do_user_addr_fault
   handle_mm_fault
      do_sigbus      

>  static void
>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  	  u32 *pkey, unsigned int fault)
> @@ -1254,14 +1255,11 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  }
>  NOKPROBE_SYMBOL(do_kern_addr_fault);
>  
> -/*
> - * This routine handles page faults.  It determines the address,
> - * and the problem, and then passes it off to one of the appropriate
> - * routines.
> - */
> -static noinline void
> -__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
> -		unsigned long address)
> +/* Handle faults in the user portion of the address space */
> +static inline
> +void do_user_addr_fault(struct pt_regs *regs,
> +			unsigned long hw_error_code,
> +			unsigned long address)
>  {
>  	unsigned long sw_error_code;
>  	struct vm_area_struct *vma;
> @@ -1274,17 +1272,6 @@ __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  	tsk = current;
>  	mm = tsk->mm;
>  
> -	prefetchw(&mm->mmap_sem);
> -
> -	if (unlikely(kmmio_fault(regs, address)))
> -		return;
> -
> -	/* Was the fault on kernel-controlled part of the address space? */
> -	if (unlikely(fault_in_kernel_space(address))) {
> -		do_kern_addr_fault(regs, hw_error_code, address);
> -		return;
> -	}
> -
>  	/* kprobes don't want to hook the spurious faults: */
>  	if (unlikely(kprobes_fault(regs)))
>  		return;
> @@ -1488,6 +1475,28 @@ good_area:
>  
>  	check_v8086_mode(regs, address, tsk);
>  }
> +NOKPROBE_SYMBOL(do_user_addr_fault);
> +
> +/*
> + * This routine handles page faults.  It determines the address,
> + * and the problem, and then passes it off to one of the appropriate
> + * routines.
> + */
> +static noinline void
> +__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
> +		unsigned long address)
> +{
> +	prefetchw(&current->mm->mmap_sem);
> +
> +	if (unlikely(kmmio_fault(regs, address)))
> +		return;
> +
> +	/* Was the fault on kernel-controlled part of the address space? */
> +	if (unlikely(fault_in_kernel_space(address)))
> +		do_kern_addr_fault(regs, hw_error_code, address);
> +	else
> +		do_user_addr_fault(regs, hw_error_code, address);
> +}
>  NOKPROBE_SYMBOL(__do_page_fault);
>  
>  static nokprobe_inline void

Eric
