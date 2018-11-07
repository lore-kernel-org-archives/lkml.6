Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9FEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC4820862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC4820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeKHEEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:04:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbeKHEEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:04:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7672881138;
        Wed,  7 Nov 2018 18:33:10 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69DA61001F4C;
        Wed,  7 Nov 2018 18:33:08 +0000 (UTC)
Subject: Re: [Patch v4 17/18] x86/speculation: Update SPEC_CTRL MSRs of remote
 CPUs
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
 <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com>
 <alpine.DEB.2.21.1811042042060.10744@nanos.tec.linutronix.de>
 <ea646842-bd32-3615-bf38-27b568a2d81e@linux.intel.com>
 <alpine.DEB.2.21.1811052326040.1659@nanos.tec.linutronix.de>
 <81398b26-e1c3-aac3-b44a-2a0982ae74e0@linux.intel.com>
 <alpine.DEB.2.21.1811060139090.1659@nanos.tec.linutronix.de>
 <e41a9d15-f667-ebb5-3fbb-91f14ae034a3@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <e726103b-7689-d9bc-4f39-98ca4b57ec2b@redhat.com>
Date:   Wed, 7 Nov 2018 13:33:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e41a9d15-f667-ebb5-3fbb-91f14ae034a3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 07 Nov 2018 18:33:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 07:18 PM, Tim Chen wrote:
> Thomas,
>
>>>> 2) Add _TIF_UPDATE_SPEC_CTRL to the SYSCALL_EXIT_WORK_FLAGS and handle it
>>>>    in the slow work path.
>>> There can be tasks that don't do any syscalls, and it seems like we can
>>> have MSRs getting out of sync?
>> Setting the TIF flag directly in a remote task is wrong. It needs to be
>> handled when the _TIF_UPDATE_SPEC_CTRL is evaluated, i.e. the information
>> needs to be stored process wide e.g. in task->mm.
>>
>> But yes, if the remote task runs in user space forever, it won't
>> help. Though the point is that dumpable is usually set when the process
>> starts, so it's probably mostly a theoretical issue.
>>
> I took a crack to implement what you suggested to update
> remote task's flag and remote SPEC_CTRL MSR on the syscall exit slow path.
>
> This looks reasobale?
>
> Tim
>
>
> ------------
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 3b2490b..614594a 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -216,7 +216,7 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
>  
>  #define SYSCALL_EXIT_WORK_FLAGS				\
>  	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
> -	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
> +	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT | _TIF_UPDATE_SPEC_CTRL)
>  
>  static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
>  {
> @@ -227,6 +227,8 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
>  	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
>  		trace_sys_exit(regs, regs->ax);
>  
> +	if (cached_flags & _TIF_UPDATE_SPEC_CTRL)
> +		spec_ctrl_do_pending_update();
>  	/*
>  	 * If TIF_SYSCALL_EMU is set, we only get here because of
>  	 * TIF_SINGLESTEP (i.e. this is PTRACE_SYSEMU_SINGLESTEP).
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index c59a6c4..f124597 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -276,6 +276,8 @@ static inline void indirect_branch_prediction_barrier(void)
>  	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
>  }
>  
> +void spec_ctrl_do_pending_update(void);
> +
>  /* The Intel SPEC CTRL MSR base value cache */
>  extern u64 x86_spec_ctrl_base;
>  
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 4f6a7a9..b78db59 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -97,6 +97,7 @@ struct thread_info {
>  #define TIF_USER_RETURN_NOTIFY	14	/* Notify kernel of userspace return */
>  #define TIF_PATCH_PENDING	15	/* Pending live patching update */
>  #define TIF_FSCHECK		16	/* Check FS is USER_DS on return */
> +#define TIF_UPDATE_SPEC_CTRL	17	/* Pending update of speculation control */
>  
>  /* Task status */
>  #define TIF_UPROBE		18	/* Breakpointed or singlestepping */
> @@ -131,6 +132,7 @@ struct thread_info {
>  #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>  #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
> +#define _TIF_UPDATE_SPEC_CTRL	(1 << TIF_UPDATE_SPEC_CTRL)
>  
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 4c15c86..d82d3f8 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  #include <linux/nospec.h>
>  #include <linux/prctl.h>
> +#include <linux/sched/coredump.h>
> +#include <linux/sched/signal.h>
>  
>  #include <asm/spec-ctrl.h>
>  #include <asm/cmdline.h>
> @@ -770,6 +772,69 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
>  	return 0;
>  }
>  
> +static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
> +{
> +	bool update = false;
> +
> +	if (stibp_on)
> +		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
> +	else
> +		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
> +
> +	if (tsk == current && update)
> +		speculation_ctrl_update_current();
> +}
> +
> +void spec_ctrl_do_pending_update(void)
> +{
> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
> +		return;
> +
> +	if (!current->mm)
> +		return;
> +
> +	if (get_dumpable(current->mm) != SUID_DUMP_USER)
> +		set_tsk_thread_flag(current, TIF_STIBP);
> +	else
> +		clear_tsk_thread_flag(current, TIF_STIBP);
> +
> +	clear_tsk_thread_flag(current, TIF_UPDATE_SPEC_CTRL);
> +	speculation_ctrl_update_current();
> +}
> + 
> +int arch_update_spec_ctrl_restriction(struct task_struct *task)
> +{
> +	unsigned long flags;
> +	struct task_struct *t;
> +	bool stibp_on = false;
> +
> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
> +		return 0;
> +
> +	if (!task->mm)
> +		return -EINVAL;
> +
> +	if (!lock_task_sighand(task, &flags))
> +		return -ESRCH;
> +
> +	if (get_dumpable(task->mm) != SUID_DUMP_USER)
> +		stibp_on = true;
> +
> +	for_each_thread(task, t) {
> +		if (task_cpu(task) == smp_processor_id())
> +			set_task_stibp(task, stibp_on);

I think "t" is the iterator, not "task". BTW, a thread is on the same
CPU doesn't mean it is running. Should you just check "(t == current)" here?

> +		else if (test_tsk_thread_flag(task, TIF_STIBP) != stibp_on) 
> +			set_tsk_thread_flag(task, TIF_UPDATE_SPEC_CTRL);
> +	}
> +
> +	unlock_task_sighand(task, &flags);
> +	return 0;
> +}
> +
>  int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>  			     unsigned long ctrl)
>  {

Cheers,
Longman

