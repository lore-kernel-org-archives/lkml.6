Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8746C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94B2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="REy2laeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfAUV4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:56:48 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:41656 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfAUV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:56:48 -0500
Received: from mailhost.synopsys.com (dc8-mailhost.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5E21410C18DA;
        Mon, 21 Jan 2019 13:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548107807; bh=UAzc6nNqDgY+buiqoXpv2TpdXL/mkNrIoaMhzYSEToU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=REy2laeubv9Msc8oQgWgRV34KqtjFwr0UmwyHfqdaDuZzOoCglj5forBOsJif6eAW
         urNpTDVoByiEO0YF4w4DUIuPcU9jLW9poGawNbshROhsdSudkzQM+Aq1Wk+1Tjjcv7
         aSp8HyE03QFuISADB7/8Ijb+qf9ZAo4ezLq93oVdJgr9sp36vsoh3hdYUa39IHu0LS
         fE6uj+WOHuV/rP+H1egPrkHOTxZcFLGoItcROZ0f0V8q4nXVyVsukp7E5isaoyiYqN
         RcXmgT5wAG9Xt0rpTvY8b42LekNi02kFrva9txnU/U0J/Q0f5SPcZpkEHWsgsdyfpV
         9qKj8jZva1kPw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4FB78A008A;
        Mon, 21 Jan 2019 21:56:47 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 13:56:33 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Jan 2019 03:26:34 +0530
Received: from [10.10.161.70] (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Jan 2019 03:26:34 +0530
Subject: Re: [PATCH] ARC: prevent showing irrelevant exception info in signal
 message
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <20190121170735.5511-1-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <82e89101-423f-9937-f093-a24697dba7d7@synopsys.com>
Date:   Mon, 21 Jan 2019 13:56:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121170735.5511-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 9:07 AM, Eugeniy Paltsev wrote:
> We process signals in the end of syscall/exception handler.
> If the signal is fatal we print register's content using
> show_regs function. show_regs() also prints information about
> last exception happened.
> 
> In case of multicore system we can catch the situation when we
> will print wrong information about exception. See the example:
> ______________________________
> CPU-0: started to handle page fault
> CPU-1: sent signal to process, which is executed on CPU-0
> CPU-0: ended page fault handle. Started to process signal before
>        returnig to userspace. Process signal, which is send from
>        CPU-0. As th signal is fatal we call show_regs().
>        show_regs() will show information about last exception
>        which is *page fault* (instead of "trap" which is used for
>        signals and happened on CPU-0)
> 
> So we will get message like this:
>    # ./waitpid02
>   potentially unexpected fatal signal 8.
>   Path: /home/waitpid02
>   CPU: 0 PID: 100 Comm: waitpid02 Not tainted 4.10.0-rc4 #2
>   task: 9f11c200 task.stack: 9f3ae000
> 
>   [ECR   ]: 0x00050200 => Invalid Write @ 0x00000000 by insn @ 0x000123ec
>   [EFA   ]: 0x00000000
>   [BLINK ]: 0x123ea
>   [ERET  ]: 0x123ec
>     @off 0x123ec in [/home/waitpid02]
>     VMA: 0x00010000 to 0x00016000
>   [STAT32]: 0x80080882 : IE U
>   BTA: 0x000123ea  SP: 0x5ffd3db0  FP: 0x00000000
>   LPS: 0x20031684 LPE: 0x2003169a LPC: 0x00000006
>   [-----other-info-----]
> 
> This message is confusing because it show information about page fault
> ( [ECR   ]: 0x00050200 => Invalid Write ) which is absolutely irrelevant
> to signal.
> 
> This situation was reproduced with waitpid02 LTP test.
> _____________________________
> 
> So remove printing information about exceptions from show_regs()
> to avoid confusing messages. Print information about exceptions
> only in required places instead of show_regs()

That is fine, but as I mentioned in your last posting, this is still not complete.
If printing reg file confuses us in case of termination by signal from some other
task, I don't see how just leaving out the exception regs, but still printing rest
of the reg file is the complete solution. It is still bogus and any fixes to that
effect are band aids.

> 
> Now we don't print information about exceptions if signal is simply
> send by another userspace app. So in case of waitpid02 we will print
> next message:

So all we are skipping is the decoding of ECR as you seem to be printing the raw
value anyways.

> _____________________________
>    # ./waitpid02
>   potentially unexpected fatal signal 8.
>   Path: /root/waitpid02
>   CPU: 2 PID: 105 Comm: waitpid02 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #17
>   [ECR   ]: 0x00050100
>   [EFA   ]: 0x00000000
>   [BLINK ]: 0x20001486
>   [-----other-info-----]
> _____________________________
> 
> This patch fix
> STAR 9001146055: waitpid02: Invalid Write @ 0x00000000 by insn @ 0x000123ec
> 
> NOTE:
> To be more clear I give examples of different faults (signal-based,
> userspace/kernelspace exception-based) with different values of
> "/proc/sys/kernel/print-fatal-signals" option.
> 
> 0) NULL pointer access from user space, print-fatal-signals == 1:
> ------------>8---------------
>  # ./arc_hell
> Exception: arc_hell[103]: at 0x2003a35c [off 0x2e35c in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
>   ECR: 0x00050100 => Invalid Read @ 0x00000000 by insn @ 0x2003a35c
> potentially unexpected fatal signal 11.
> Path: /root/arc_hell
> CPU: 1 PID: 103 Comm: arc_hell Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #17
> [ECR   ]: 0x00050100

So we are printing the ECR twice. Sorry this approach is not going to work.


> [EFA   ]: 0x00000000
> [BLINK ]: 0x20039ef8
> [ERET  ]: 0x2003a35c
...
> 
> Segmentation fault
> ------------>8---------------
> 
> 1) NULL pointer access from user space, print-fatal-signals == 0:
> ------------>8---------------
>  # ./arc_hell
> Exception: arc_hell[107]: at 0x2003a35c [off 0x2e35c in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
>   ECR: 0x00050100 => Invalid Read @ 0x00000000 by insn @ 0x2003a35c
> Segmentation fault
> ------------>8---------------
> 
> 2) Process killed by signal (waitpid02 test), print-fatal-signals == 1:
> ------------>8---------------
>  # ./waitpid02
> potentially unexpected fatal signal 8.
> Path: /root/waitpid02
> CPU: 2 PID: 105 Comm: waitpid02 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #17
> [ECR   ]: 0x00050100
> [EFA   ]: 0x00000000
> [BLINK ]: 0x20001486
> [ERET  ]: 0x2000146c
> [STAT32]: 0x80080082 : IE U
> BTA: 0x20000fc4  SP: 0x5fa21d64  FP: 0x00000000
> LPS: 0x200524a0 LPE: 0x200524b6 LPC: 0x00000006
> r00: 0x2000c0dc r01: 0x00000018 r02: 0x0001159a
> r03: 0x00000001 r04: 0x00000000 r05: 0x00000045
> r06: 0x0000004e r07: 0x01010101 r08: 0x000000dc
> r09: 0x200a31e0 r10: 0x20003a5c r11: 0x20004038
> r12: 0x20001486 r13: 0x20004174 r14: 0x07ca2bc0
> r15: 0x20004078 r16: 0x00000000 r17: 0x20004038
> r18: 0x00000001 r19: 0x00000000 r20: 0x0001159a
> r21: 0x00000001 r22: 0x00000000 r23: 0x00000004
> r24: 0x2000d1fc r25: 0x20004cd0

This is the part I really object to. We should not print any register when they
are not relevant. Not decoding the ECR is not enough IMO.


> ------------>8---------------
> 
> 3) Process killed by signal (waitpid02 test), print-fatal-signals == 0:
> ------------>8---------------
>  # ./waitpid02

...
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v3->v4:
>  * Rebase onto last ARC changes.
> 
> Changes v2->v3:
>  * Don't show exception message if the corresponding signal is
>    handled by application (inspired by x86 implementation)
>  * Rebase onto v4.19-rc8
> 
> Changes v1->v2:
>  * Change format of message about exception.
> 
>  arch/arc/include/asm/bug.h     |  1 +
>  arch/arc/kernel/traps.c        |  3 +++
>  arch/arc/kernel/troubleshoot.c | 46 ++++++++++++++++++++++++++++++++----------
>  arch/arc/mm/fault.c            |  9 +++++++++
>  4 files changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
> index 21ec82466d62..b68f7f82f2d8 100644
> --- a/arch/arc/include/asm/bug.h
> +++ b/arch/arc/include/asm/bug.h
> @@ -16,6 +16,7 @@
>  struct task_struct;
>  
>  void show_regs(struct pt_regs *regs);
> +void show_exception_mesg(struct pt_regs *regs);
>  void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);
>  void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
>  			    unsigned long address);
> diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
> index a7fcbc0d3943..b94b13120bff 100644
> --- a/arch/arc/kernel/traps.c
> +++ b/arch/arc/kernel/traps.c
> @@ -50,6 +50,9 @@ unhandled_exception(const char *str, struct pt_regs *regs,
>  
>  		tsk->thread.fault_address = (__force unsigned int)addr;
>  
> +		if (unhandled_signal(tsk, signo))
> +			show_exception_mesg(regs);
> +
>  		force_sig_fault(signo, si_code, addr, tsk);
>  
>  	} else {
> diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
> index 215f515442e0..64e9867a1a65 100644
> --- a/arch/arc/kernel/troubleshoot.c
> +++ b/arch/arc/kernel/troubleshoot.c
> @@ -106,13 +106,13 @@ static void show_faulting_vma(unsigned long address)
>  			if (IS_ERR(nm))
>  				nm = "?";
>  		}
> -		pr_info("    @off 0x%lx in [%s]\n"
> -			"    VMA: 0x%08lx to 0x%08lx\n",
> +
> +		pr_cont("[off 0x%lx in %s, VMA: %08lx:%08lx] ",
>  			vma->vm_start < TASK_UNMAPPED_BASE ?
>  				address : address - vma->vm_start,
>  			nm, vma->vm_start, vma->vm_end);
>  	} else
> -		pr_info("    @No matching VMA found\n");
> +		pr_cont("[No matching VMA found] ");
>  
>  	up_read(&active_mm->mmap_sem);
>  }
> @@ -122,7 +122,7 @@ static void show_ecr_verbose(struct pt_regs *regs)
>  	unsigned int vec, cause_code;
>  	unsigned long address;
>  
> -	pr_info("\n[ECR   ]: 0x%08lx => ", regs->event);
> +	pr_cont("\n  ECR: 0x%08lx => ", regs->event);
>  
>  	/* For Data fault, this is data address not instruction addr */
>  	address = current->thread.fault_address;
> @@ -170,10 +170,37 @@ static void show_ecr_verbose(struct pt_regs *regs)
>  	}
>  }
>  
> +static inline void show_exception_mesg_u(struct pt_regs *regs)
> +{
> +	struct task_struct *tsk = current;
> +
> +	pr_info("Exception: %s[%d]: at %pS ",
> +		tsk->comm, task_pid_nr(tsk), (void *)regs->ret);
> +
> +	show_faulting_vma(regs->ret);
> +
> +	show_ecr_verbose(regs);
> +}
> +
> +static inline void show_exception_mesg_k(struct pt_regs *regs)
> +{
> +	pr_info("Exception: at %pS:", (void *)regs->ret);
> +
> +	show_ecr_verbose(regs);
> +}
> +
>  /************************************************************************
>   *  API called by rest of kernel
>   ***********************************************************************/
>  
> +void show_exception_mesg(struct pt_regs *regs)
> +{
> +	if (user_mode(regs))
> +		show_exception_mesg_u(regs);
> +	else
> +		show_exception_mesg_k(regs);
> +}
> +
>  void show_regs(struct pt_regs *regs)
>  {
>  	struct task_struct *tsk = current;
> @@ -188,15 +215,10 @@ void show_regs(struct pt_regs *regs)
>  	print_task_path_n_nm(tsk);
>  	show_regs_print_info(KERN_INFO);
>  
> -	show_ecr_verbose(regs);
> -
> -	pr_info("[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]: %pS\n",
> -		current->thread.fault_address,
> +	pr_info("[ECR   ]: 0x%08lx\n[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]: %pS\n",
> +		regs->event, current->thread.fault_address,
>  		(void *)regs->blink, (void *)regs->ret);
>  
> -	if (user_mode(regs))
> -		show_faulting_vma(regs->ret); /* faulting code, not data */
> -
>  	pr_info("[STAT32]: 0x%08lx", regs->status32);
>  
>  #define STS_BIT(r, bit)	r->status32 & STATUS_##bit##_MASK ? #bit" " : ""
> @@ -239,6 +261,8 @@ void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
>  	/* Show fault description */
>  	pr_info("\n%s\n", str);
>  
> +	show_exception_mesg(regs);
> +
>  	/* Caller and Callee regs */
>  	show_regs(regs);
>  
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
> index 8df1638259f3..e44b64107adb 100644
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@ -202,7 +202,12 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  	/* User mode accesses just cause a SIGSEGV */
>  	if (user_mode(regs)) {
>  		tsk->thread.fault_address = address;
> +
> +		if (unhandled_signal(tsk, SIGSEGV))
> +			show_exception_mesg(regs);
> +
>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
> +
>  		return;
>  	}
>  
> @@ -237,5 +242,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  		goto no_context;
>  
>  	tsk->thread.fault_address = address;
> +
> +	if (unhandled_signal(tsk, SIGBUS))
> +		show_exception_mesg(regs);
> +
>  	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
>  }
> 

