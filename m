Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CBFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJaFw2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:52:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:64138 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeJaFw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 13:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="92481159"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2018 13:57:23 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.174]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 13:57:22 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: RE: [Patch v4 13/18] security: Update security level of a process
 when modifying its dumpability
Thread-Topic: [Patch v4 13/18] security: Update security level of a process
 when modifying its dumpability
Thread-Index: AQHUcIX1hxicXgbmAEOLDSitei16taU4PnJA
Date:   Tue, 30 Oct 2018 20:57:22 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732148DC65@ORSMSX110.amr.corp.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
 <e8b6b10e15653b3b2c5727e935f75142e441f834.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <e8b6b10e15653b3b2c5727e935f75142e441f834.1540923609.git.tim.c.chen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWEwMTEwYTAtNDUzNy00MmUzLTliMmItOGVlMDJhMjFlYWEzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOXdDcVwvMEtFQVFWXC9RVnNYNE1EOFM0RXBzcDQ0M3ZCMk0yK1FIVCtHZk00SkppVFFZQVg5Y2Q3bVk2XC9TT0tKNiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tim Chen [mailto:tim.c.chen@linux.intel.com]
> Sent: Tuesday, October 30, 2018 11:49 AM
> To: Jiri Kosina <jikos@kernel.org>; Thomas Gleixner <tglx@linutronix.de>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>; Tom Lendacky
> <thomas.lendacky@amd.com>; Ingo Molnar <mingo@redhat.com>; Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@redhat.com>;
> Andrea Arcangeli <aarcange@redhat.com>; David Woodhouse
> <dwmw@amazon.co.uk>; Andi Kleen <ak@linux.intel.com>; Hansen, Dave
> <dave.hansen@intel.com>; Schaufler, Casey <casey.schaufler@intel.com>;
> Mallick, Asit K <asit.k.mallick@intel.com>; Arjan van de Ven
> <arjan@linux.intel.com>; Jon Masters <jcm@redhat.com>; Waiman Long
> <longman9394@gmail.com>; linux-kernel@vger.kernel.org; x86@kernel.org

Added LSM mail list to the CC:

> Subject: [Patch v4 13/18] security: Update security level of a process when
> modifying its dumpability

"Level" isn't a good description of security characteristics
as it has been overloaded in too many ways already. More
on that later.

> When a process is made non-dumpable, the action implies a higher level
> of security implicitly as its memory is imposed with access restriction.

How is this "higher level" manifest?

> A call to update_process_security() is added to update security defenses
> according to a process's dumpability and its implied security level.

Can you describe the set of security attributes that are implied by the
process' dumpability? I would think that the dumpability would be an
artifact of these attributes, not the other way around.

> Architecture specific defenses is erected for threads in the process

nit: s/is/are/

> by calling arch_set_security(task, SECURITY_LEVEL_HIGH) or the defenses
> relaxed via arch_set_security(task, SECURITY_LEVEL_NORMAL).  Such defenses
> may incur extra overhead and is reserved for tasks needing high security.

nit: s/is/are/

> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  fs/exec.c                |  2 ++
>  include/linux/security.h |  6 ++++++
>  kernel/cred.c            |  5 ++++-
>  kernel/sys.c             |  1 +
>  security/security.c      | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 1ebf6e5..e70c8a7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1366,6 +1366,8 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	else
>  		set_dumpable(current->mm, SUID_DUMP_USER);
> 
> +	update_process_security(current);
> +
>  	arch_setup_new_exec();
>  	perf_event_exec();
>  	__set_task_comm(current, kbasename(bprm->filename), true);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 75f4156..469d05f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -61,6 +61,12 @@ struct mm_struct;
>  /* LSM Agnostic defines for sb_set_mnt_opts */
>  #define SECURITY_LSM_NATIVE_LABELS	1
> 
> +/* Security level */
> +#define SECURITY_NORMAL	0
> +#define SECURITY_HIGH	1

NAK: "NORMAL" and "HIGH" are meaningless in this context.
If you intend to differentiate between "dumpable" and "undumpable"
you could use those, although I would recommend something that
describes the reason the task is dumpable.

> +
> +extern int update_process_security(struct task_struct *task);
> +
>  struct ctl_table;
>  struct audit_krule;
>  struct user_namespace;
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf0365..0806a74 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -19,6 +19,7 @@
>  #include <linux/security.h>
>  #include <linux/binfmts.h>
>  #include <linux/cn_proc.h>
> +#include <linux/security.h>
> 
>  #if 0
>  #define kdebug(FMT, ...)						\
> @@ -445,8 +446,10 @@ int commit_creds(struct cred *new)
>  	    !uid_eq(old->fsuid, new->fsuid) ||
>  	    !gid_eq(old->fsgid, new->fsgid) ||
>  	    !cred_cap_issubset(old, new)) {
> -		if (task->mm)
> +		if (task->mm) {
>  			set_dumpable(task->mm, suid_dumpable);
> +			update_process_security(task);
> +		}
>  		task->pdeath_signal = 0;
>  		smp_wmb();
>  	}
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cf5c675..c6f179a 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2293,6 +2293,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,
> arg2, unsigned long, arg3,
>  			break;
>  		}
>  		set_dumpable(me->mm, arg2);
> +		update_process_security(me);
>  		break;
> 
>  	case PR_SET_UNALIGN:
> diff --git a/security/security.c b/security/security.c
> index 736e78d..12460f2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,8 @@
>  #include <linux/personality.h>
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
> +#include <linux/coredump.h>
> +#include <linux/sched/signal.h>
>  #include <net/flow.h>
> 
>  #include <trace/events/initcall.h>
> @@ -1353,6 +1355,35 @@ int security_inode_getsecctx(struct inode *inode,
> void **ctx, u32 *ctxlen)
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
> 
> +void __weak arch_set_security(struct task_struct *task,
> +			      unsigned int security_level)
> +{
> +}

This isn't an LSM hook and hence does not belong in this file.
arch_set_security() isn't descriptive, and is in fact a bad choice
as task_struct has a field "security". This function has nothing
to do with the task->security field, which is what I would expect
based on the name.

> +
> +int update_process_security(struct task_struct *task)

Again, this isn't an LSM hook and does not belong in this file.
Also again, "security" isn't descriptive in the name.

> +{
> +	unsigned long flags;
> +	struct task_struct *t;
> +	int security_level;
> +
> +	if (!task->mm)
> +		return -EINVAL;
> +
> +	if (!lock_task_sighand(task, &flags))
> +		return -ESRCH;
> +
> +	if (get_dumpable(task->mm) != SUID_DUMP_USER)
> +		security_level = SECURITY_HIGH;
> +	else
> +		security_level = SECURITY_NORMAL;
> +
> +	for_each_thread(task, t)
> +		arch_set_security(task, security_level);
> +
> +	unlock_task_sighand(task, &flags);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_SECURITY_NETWORK
> 
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, struct
> sock *newsk)
> --
> 2.9.4

