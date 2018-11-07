Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAD2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EAD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeKHIry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:47:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:19827 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbeKHIry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 15:15:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,477,1534834800"; 
   d="scan'208";a="277994037"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.144]) ([10.54.74.144])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2018 15:15:13 -0800
Subject: Re: [Patch v4 17/18] x86/speculation: Update SPEC_CTRL MSRs of remote
 CPUs
To:     Waiman Long <longman@redhat.com>,
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
 <e726103b-7689-d9bc-4f39-98ca4b57ec2b@redhat.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2aff26cb-e85e-29c5-cc85-eb12480f03fc@linux.intel.com>
Date:   Wed, 7 Nov 2018 15:15:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <e726103b-7689-d9bc-4f39-98ca4b57ec2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 10:33 AM, Waiman Long wrote:
> On 11/06/2018 07:18 PM, Tim Chen wrote:
>> Thomas,
>>
>>>>> 2) Add _TIF_UPDATE_SPEC_CTRL to the SYSCALL_EXIT_WORK_FLAGS and handle it
>>>>>    in the slow work path.
>>>> There can be tasks that don't do any syscalls, and it seems like we can
>>>> have MSRs getting out of sync?
>>> Setting the TIF flag directly in a remote task is wrong. It needs to be
>>> handled when the _TIF_UPDATE_SPEC_CTRL is evaluated, i.e. the information
>>> needs to be stored process wide e.g. in task->mm.
>>>
>>> But yes, if the remote task runs in user space forever, it won't
>>> help. Though the point is that dumpable is usually set when the process
>>> starts, so it's probably mostly a theoretical issue.
>>>
>> I took a crack to implement what you suggested to update
>> remote task's flag and remote SPEC_CTRL MSR on the syscall exit slow path.
>>
>> This looks reasobale?
>>
>> Tim
>>
>>
>> ------------
>>
>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> index 3b2490b..614594a 100644
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -216,7 +216,7 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
>>  
>>  #define SYSCALL_EXIT_WORK_FLAGS				\
>>  	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
>> -	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
>> +	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT | _TIF_UPDATE_SPEC_CTRL)
>>  
>>  static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
>>  {
>> @@ -227,6 +227,8 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
>>  	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
>>  		trace_sys_exit(regs, regs->ax);
>>  
>> +	if (cached_flags & _TIF_UPDATE_SPEC_CTRL)
>> +		spec_ctrl_do_pending_update();
>>  	/*
>>  	 * If TIF_SYSCALL_EMU is set, we only get here because of
>>  	 * TIF_SINGLESTEP (i.e. this is PTRACE_SYSEMU_SINGLESTEP).
>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>> index c59a6c4..f124597 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -276,6 +276,8 @@ static inline void indirect_branch_prediction_barrier(void)
>>  	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
>>  }
>>  
>> +void spec_ctrl_do_pending_update(void);
>> +
>>  /* The Intel SPEC CTRL MSR base value cache */
>>  extern u64 x86_spec_ctrl_base;
>>  
>> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
>> index 4f6a7a9..b78db59 100644
>> --- a/arch/x86/include/asm/thread_info.h
>> +++ b/arch/x86/include/asm/thread_info.h
>> @@ -97,6 +97,7 @@ struct thread_info {
>>  #define TIF_USER_RETURN_NOTIFY	14	/* Notify kernel of userspace return */
>>  #define TIF_PATCH_PENDING	15	/* Pending live patching update */
>>  #define TIF_FSCHECK		16	/* Check FS is USER_DS on return */
>> +#define TIF_UPDATE_SPEC_CTRL	17	/* Pending update of speculation control */
>>  
>>  /* Task status */
>>  #define TIF_UPROBE		18	/* Breakpointed or singlestepping */
>> @@ -131,6 +132,7 @@ struct thread_info {
>>  #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
>>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>>  #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
>> +#define _TIF_UPDATE_SPEC_CTRL	(1 << TIF_UPDATE_SPEC_CTRL)
>>  
>>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>>  #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 4c15c86..d82d3f8 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -14,6 +14,8 @@
>>  #include <linux/module.h>
>>  #include <linux/nospec.h>
>>  #include <linux/prctl.h>
>> +#include <linux/sched/coredump.h>
>> +#include <linux/sched/signal.h>
>>  
>>  #include <asm/spec-ctrl.h>
>>  #include <asm/cmdline.h>
>> @@ -770,6 +772,69 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
>>  	return 0;
>>  }
>>  
>> +static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
>> +{
>> +	bool update = false;
>> +
>> +	if (stibp_on)
>> +		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
>> +	else
>> +		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
>> +
>> +	if (tsk == current && update)
>> +		speculation_ctrl_update_current();
>> +}
>> +
>> +void spec_ctrl_do_pending_update(void)
>> +{
>> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
>> +		return;
>> +
>> +	if (!current->mm)
>> +		return;
>> +
>> +	if (get_dumpable(current->mm) != SUID_DUMP_USER)
>> +		set_tsk_thread_flag(current, TIF_STIBP);
>> +	else
>> +		clear_tsk_thread_flag(current, TIF_STIBP);
>> +
>> +	clear_tsk_thread_flag(current, TIF_UPDATE_SPEC_CTRL);
>> +	speculation_ctrl_update_current();
>> +}
>> + 
>> +int arch_update_spec_ctrl_restriction(struct task_struct *task)
>> +{
>> +	unsigned long flags;
>> +	struct task_struct *t;
>> +	bool stibp_on = false;
>> +
>> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
>> +		return 0;
>> +
>> +	if (!task->mm)
>> +		return -EINVAL;
>> +
>> +	if (!lock_task_sighand(task, &flags))
>> +		return -ESRCH;
>> +
>> +	if (get_dumpable(task->mm) != SUID_DUMP_USER)
>> +		stibp_on = true;
>> +
>> +	for_each_thread(task, t) {
>> +		if (task_cpu(task) == smp_processor_id())
>> +			set_task_stibp(task, stibp_on);
> 
> I think "t" is the iterator, not "task". BTW, a thread is on the same
> CPU doesn't mean it is running. Should you just check "(t == current)" here?

Ah yes, should be t.  t==current is checked in set_task_stibp.

Tim

> 
>> +		else if (test_tsk_thread_flag(task, TIF_STIBP) != stibp_on) 
>> +			set_tsk_thread_flag(task, TIF_UPDATE_SPEC_CTRL);
>> +	}
>> +
>> +	unlock_task_sighand(task, &flags);
>> +	return 0;
>> +}
>> +
>>  int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>>  			     unsigned long ctrl)
>>  {
> 
> Cheers,
> Longman
> 

