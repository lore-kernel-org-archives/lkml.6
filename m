Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825B3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE8216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBE8216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeI1CgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:36:15 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:58447 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeI1CgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:36:14 -0400
X-EEMSG-check-008: 774101184|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,312,1534809600"; 
   d="scan'208";a="774101184"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2018 20:16:11 +0000
X-IronPort-AV: E=Sophos;i="5.54,312,1534809600"; 
   d="scan'208";a="16306471"
IronPort-PHdr: =?us-ascii?q?9a23=3Akb4ybRzsSpotk2HXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u0SKvad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym1askDZox/DBJb3sGZbNIWbZkLfnY7?=
 =?us-ascii?q?l971RQyA0pzdBQ/5hUEK0OIOrvWk/ts9zVFgM5MwOww+foE9h90oIeWWSSAq?=
 =?us-ascii?q?+FKqPStlmI5uMgIuWWeYAapi73K+I56P72kX85hVgdcLGs3ZsWbnC4EfNmLl?=
 =?us-ascii?q?6DYXXyn9gBEX0FvhYkQOP2j12CVCZZZ2yuUKIk+jE7FIWmAJ/bRo+znLyOwj?=
 =?us-ascii?q?27H5xNa2BHDFCMH23oeJ+ZVPgSci2dP9VtkjseVbiuU4Uhzw2htBfmy7p7Ke?=
 =?us-ascii?q?rZ4i8YtYrk1Nh04u3cjhYy+iJvAsSHzW6CUmF0kXkURzMswK9/pkl9wE+Z0a?=
 =?us-ascii?q?dkm/xYCcBT5/RRXwggL5Hc1fB1BMr0WgLOYNiEU0ymTcu7DjExVN0x38UCbF?=
 =?us-ascii?q?p6G9WnlhrDxTalA6cJl7yXA5w56r/T3nb0J8dz0HvJzqwhgEMnQ8tIM22qnL?=
 =?us-ascii?q?Jw9w/JC47UkEWTj7yqergE3C7R6GeDynKDs1tbUANrVaXFXHYfZlbZrNjj50?=
 =?us-ascii?q?PCSaOuBqojMgdb1cGCLa5KYMXzjVpaXPfjJMjeY2WplmesBBaIw6mAY5bwd2?=
 =?us-ascii?q?oB3CXSFk4EnhsX/XaHMwg+Gyigr3jfDDxoCVLgfUfs/fNip3O8S08+1xuKYF?=
 =?us-ascii?q?F517qp5h4VguSRRO8J0bIfpiggqy94HE2h0NLWEdWAugRhfKFCbtMn+1pH1G?=
 =?us-ascii?q?TZtxBjMZykNaxtmlkecwFvtUP0yxp3EplAkdQtrH4yyApyKKSY0E5Odj+B3p?=
 =?us-ascii?q?D/JKfXKm/s8xCrcKPWxF7e38iM+qsV6/Q3tU/jvAe3GUom6Xln1MNV03SE7J?=
 =?us-ascii?q?XQEAUSSY7xUlow9xViqLDXYSgw6pjX1XJyK6m0tCHN29YzCOsi0BagcIQXDK?=
 =?us-ascii?q?TRNg7oEoU5ANOvLuViz1qobRUfFONf7qg5O4WhbfTQnOaXPOFllSnuomBK4Z?=
 =?us-ascii?q?B731jEozZzTv7g25cD3u2C2Q2GR3HwgQHl+uHxlocMQDYWGGOlgXzhBYheYY?=
 =?us-ascii?q?VocIoLAHvoKMqykJE2v5PxVmQQxl+hA0gawsbhLQKfc1HnzyVR00oNqHCqkC?=
 =?us-ascii?q?f+yCZ7xXVhjK2E3GT2xOXnfh0KJ2ADEGt6ilbpK4+5p8oXUEihc04ikx7zoQ?=
 =?us-ascii?q?7TwaRBqa03BnPYSEFHciz3ZzVrW7G7v7yNbuZV5Z8ouDkRW+O5NxTSAIH6pB?=
 =?us-ascii?q?ca1D74Ei8W6Dkldj3g8sH1gBlloGuYJWR0qjzSfodtxkGbrPXaSf8Z/T4LSS?=
 =?us-ascii?q?8w3TDULly9OcS5u9SSi5rH9Ou5UjTlHqFSdGHAzY6G/H+n5GgsClu0n/21st?=
 =?us-ascii?q?nmFxUqly79y9RuEy7PqUC4KsPQ3KSzLOxjc1MsTHT18MdrUMkqmYIriYBWwn?=
 =?us-ascii?q?Maj4ib+XcduWb1Ldhfn6n5aSxeayQMxovu/AX92EBlZkmMzob9W2TVltBtfP?=
 =?us-ascii?q?Gmc2gW3WQ79MkMB6CKuu8X1RBpq0a1+FqCKcN2mS0QnL53siYX?=
X-IPAS-Result: =?us-ascii?q?A2ARAAANOa1b/wHyM5BbGwEBAQEDAQEBBwMBAQGBUYFkK?=
 =?us-ascii?q?oFlKIN0iBWMfwEBAQEGgQgteIdzjWeBejYBhEAChAchNBgBAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCNSQBgl4BAQEBAyMEEUEQCw4HAwICJgICVwYBDAYCAQGCXj+BdQ2IW5sqe?=
 =?us-ascii?q?zOEAQF1hRaBC4hBgTIXeYEHgRIngjY1h3+CVwKIJw8VhXl3jVYJiU6GWgYXg?=
 =?us-ascii?q?UeHXYYWllw4gVUrCAIYCCEPgyeCJRcRagECjGQBUSMwAQF5AQGNNAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Sep 2018 20:16:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RKFw7f008413;
        Thu, 27 Sep 2018 16:15:58 -0400
Subject: Re: [PATCH v7 1/3] x86/speculation: apply IBPB more strictly to avoid
 cross-process data leak
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <nycvar.YFH.7.76.1809251431260.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7f9e1a22-37a8-db88-ffc0-91961174ced4@tycho.nsa.gov>
Date:   Thu, 27 Sep 2018 16:18:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 08:38 AM, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Currently, we are issuing IBPB only in cases when switching into a non-dumpable
> process, the rationale being to protect such 'important and security sensitive'
> processess (such as GPG) from data leak into a different userspace process via
> spectre v2.
> 
> This is however completely insufficient to provide proper userspace-to-userpace
> spectrev2 protection, as any process can poison branch buffers before being
> scheduled out, and the newly scheduled process immediately becomes spectrev2
> victim.
> 
> In order to minimize the performance impact (for usecases that do require
> spectrev2 protection), issue the barrier only in cases when switching between
> processess where the victim can't be ptraced by the potential attacker (as in
> such cases, the attacker doesn't have to bother with branch buffers at all).
> 
> [ tglx@linutronix.de: split up PTRACE_MODE_NOACCESS_CHK into PTRACE_MODE_SCHED and
>    PTRACE_MODE_IBPB to be able to do ptrace() context tracking reasonably
>    fine-grained ]
> 
> Fixes: 18bf3c3ea8 ("x86/speculation: Use Indirect Branch Prediction Barrier in context switch")
> Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>   arch/x86/mm/tlb.c      | 31 ++++++++++++++++++++-----------
>   include/linux/ptrace.h | 21 +++++++++++++++++++--
>   kernel/ptrace.c        | 10 ++++++++++
>   3 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index e96b99eb800c..073b8df349a0 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -7,6 +7,7 @@
>   #include <linux/export.h>
>   #include <linux/cpu.h>
>   #include <linux/debugfs.h>
> +#include <linux/ptrace.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/mmu_context.h>
> @@ -180,6 +181,19 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
>   	}
>   }
>   
> +static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
> +{
> +	/*
> +	 * Check if the current (previous) task has access to the memory
> +	 * of the @tsk (next) task. If access is denied, make sure to
> +	 * issue a IBPB to stop user->user Spectre-v2 attacks.
> +	 *
> +	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
> +	 */
> +	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> +		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));

Would there be any safe way to perform the ptrace check earlier at a 
point where the locking constraints are less severe, and just pass down 
the result to this code?  Possibly just defaulting to enabling IBPB for 
safety if something changed in the interim that would invalidate the 
earlier ptrace check?  Probably not possible, but I thought I'd ask as 
it would avoid the need to skip both the ptrace_has_cap check and the 
LSM hook, and would reduce the critical section.

> +}
> +
>   void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   			struct task_struct *tsk)
>   {
> @@ -262,18 +276,13 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   		 * one process from doing Spectre-v2 attacks on another.
>   		 *
>   		 * As an optimization, flush indirect branches only when
> -		 * switching into processes that disable dumping. This
> -		 * protects high value processes like gpg, without having
> -		 * too high performance overhead. IBPB is *expensive*!
> -		 *
> -		 * This will not flush branches when switching into kernel
> -		 * threads. It will also not flush if we switch to idle
> -		 * thread and back to the same process. It will flush if we
> -		 * switch to a different non-dumpable process.
> +		 * switching into a processes that can't be ptrace by the
> +		 * current one (as in such case, attacker has much more
> +		 * convenient way how to tamper with the next process than
> +		 * branch buffer poisoning).
>   		 */
> -		if (tsk && tsk->mm &&
> -		    tsk->mm->context.ctx_id != last_ctx_id &&
> -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> +		if (static_cpu_has(X86_FEATURE_USE_IBPB) &&
> +				ibpb_needed(tsk, last_ctx_id))
>   			indirect_branch_prediction_barrier();
>   
>   		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index 4f36431c380b..e5e5ef513df3 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -62,14 +62,17 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
>   #define PTRACE_MODE_READ	0x01
>   #define PTRACE_MODE_ATTACH	0x02
>   #define PTRACE_MODE_NOAUDIT	0x04
> -#define PTRACE_MODE_FSCREDS 0x08
> -#define PTRACE_MODE_REALCREDS 0x10
> +#define PTRACE_MODE_FSCREDS	0x08
> +#define PTRACE_MODE_REALCREDS	0x10
> +#define PTRACE_MODE_SCHED	0x20
> +#define PTRACE_MODE_IBPB	0x40
>   
>   /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
>   #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
>   #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
>   #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
>   #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_REALCREDS)
> +#define PTRACE_MODE_SPEC_IBPB (PTRACE_MODE_ATTACH_REALCREDS | PTRACE_MODE_IBPB)
>   
>   /**
>    * ptrace_may_access - check whether the caller is permitted to access
> @@ -87,6 +90,20 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
>    */
>   extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
>   
> +/**
> + * ptrace_may_access - check whether the caller is permitted to access

s/ptrace_may_access/ptrace_may_access_sched/

> + * a target task.
> + * @task: target task
> + * @mode: selects type of access and caller credentials
> + *
> + * Returns true on success, false on denial.
> + *
> + * Similar to ptrace_may_access(). Only to be called from context switch
> + * code. Does not call into audit and the regular LSM hooks due to locking
> + * constraints.

Pardon my ignorance, but can you clarify exactly what are the locking 
constraints for any code that might be called now or in the future from 
ptrace_may_access_sched().  What's permissible?  rcu_read_lock()?

> + */
> +extern bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode);
> +
>   static inline int ptrace_reparented(struct task_struct *child)
>   {
>   	return !same_thread_group(child->real_parent, child->parent);
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 21fec73d45d4..99cfddde6a55 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -261,6 +261,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>   
>   static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
>   {
> +	if (mode & PTRACE_MODE_SCHED)
> +		return false;
> +
>   	if (mode & PTRACE_MODE_NOAUDIT)
>   		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
>   	else
> @@ -328,9 +331,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>   	     !ptrace_has_cap(mm->user_ns, mode)))
>   	    return -EPERM;
>   
> +	if (mode & PTRACE_MODE_SCHED)
> +		return 0;
>   	return security_ptrace_access_check(task, mode);
>   }
>   
> +bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
> +{
> +	return __ptrace_may_access(task, mode | PTRACE_MODE_SCHED);
> +}
> +
>   bool ptrace_may_access(struct task_struct *task, unsigned int mode)
>   {
>   	int err;
> 

