Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7778B2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/yrIvSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfABVQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:16:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfABVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:16:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so15696664pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZywrBiFqJyDIip6sqYhzhcNML/BM9AaPA6pqKSbvSE=;
        b=I/yrIvSaEtZfCLNbcIk8xpGvry/RkE1NiGmFvxPFOefODmPHHHoe8yv0Vb1jEIf+f/
         /kF7bMqOppOaIxcsb/nsspuMGznvfbN7lVN+MZgFMsqzd2Q/GH36226FXF3Q0L7MjrCi
         GXvaJFxOgos5KM/lg+HW3GcjrNVW6z0VztX2w3LxH8/AZeTFJ6bOMOdRHy8a3xZgQhL5
         /bCtr3l1gXkXZ84BP5ku2CWC//XsQLlvn1XeBmHuRKNpguetZ9gcLSgIa+Ux8X5DgZcw
         gPCQSHGsVohgEpU29uzL3fc2hzXuiZFyocbjlNc65SLVUEeJ0mm4T23nXWM1vA6s7SIK
         3/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZywrBiFqJyDIip6sqYhzhcNML/BM9AaPA6pqKSbvSE=;
        b=s50tHC+RMSnCBr1qp5n0PvC9RVQbuJr9ZFe943bvqHvnwih3wymgTcdGbae9yAXER0
         eW8ornhZb+vf8NxCCiVHLAA3dV89HVKZGCCt5rhjXhioeLOem6doyXH8Sg3utozGHAM6
         OU2Cgr+Ez3NjQTYuE4ypJW1q0L8RlZFEo1ORXZeny//Q+nyl8FytHYXLdPmBH+x0+sFN
         /gOWpFEmpKAmgF7iOMOHlnv7+5cyAeOBD5kRBOGygIagJnCsSLYl3JXeIQcl0dVQuwzH
         9COrcefMxNqmDZPPYSA7Mi2/AAeLMCY33q7o754o+gbWc5nnJKNpRzMcrQjfs53olBhv
         NK9Q==
X-Gm-Message-State: AJcUukdFZSpEz07cKhVIlsSe6GLE7uGTsAIwnaHPGi0wHs/2otga5gFP
        4Qlw6swau1LkUHCCOgGrArM=
X-Google-Smtp-Source: ALg8bN62QwjS6PQtbTl9cEp4/78fZezg0D5IL28hntDiKcTR4nMBrXWPKOFgzRGGisyWHtg4lDCTWQ==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr14742055pga.202.1546463779698;
        Wed, 02 Jan 2019 13:16:19 -0800 (PST)
Received: from gmail.com ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id k24sm79209167pfj.13.2019.01.02.13.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 13:16:18 -0800 (PST)
Date:   Wed, 2 Jan 2019 13:16:17 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Message-ID: <20190102211616.GA3237@gmail.com>
References: <20190102205939.26231-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20190102205939.26231-1-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello,

The reproducer for this problem is attached to this message.

Below you can find its effect without this fix:

We have one alive process which stucks in
zap_pid_ns_processes:

$ ps axf 
... 
11831 pts/0    S      0:00 [ptrace_pidns] 
11833 pts/0    Zl     0:00  \_ [ptrace_pidns] <defunct> 
 
$ cat /proc/11831/stack  
[<0>] do_wait+0x1fa/0x2c0 
[<0>] kernel_wait4+0x9e/0x150 
[<0>] zap_pid_ns_processes+0x17d/0x270 
[<0>] do_exit+0xa15/0xbd0 
[<0>] do_group_exit+0x47/0xc0 
[<0>] get_signal+0x28c/0x850 
[<0>] do_signal+0x36/0x630 
[<0>] exit_to_usermode_loop+0x62/0xc0 
[<0>] prepare_exit_to_usermode+0xb4/0xe0 
[<0>] retint_user+0x8/0x18 
[<0>] 0xffffffffffffffff 


The child process has two threads which were ptraced by parent:
$ ls  /proc/11833/task/ 
11833  11834 

The parent can't wait the child, becase a thread group isn't empty, but
a thread is in the dead list:

$ cat /proc/1183{1,3,4}/status | grep '\(NSpid\|TracerPid\|State\)' 
State:  S (sleeping) 
TracerPid:      0 
NSpid:  11831   1 
State:  Z (zombie) 
TracerPid:      0 
NSpid:  11833   2 
State:  X (dead) 
TracerPid:      0 
NSpid:  11834   3

On Wed, Jan 02, 2019 at 12:59:39PM -0800, Andrei Vagin wrote:
> Currently, exit_ptrace() adds all ptraced tasks in a dead list, than
> zap_pid_ns_processes() waits all tasks in a current pid ns, and only
> then tasks from the dead list are released.
> 
> zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
> this case, we will have one unkillable process with one or more dead
> children.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  kernel/exit.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0e21e6d21f35..ccaa6f6549ba 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -664,9 +664,6 @@ static void forget_original_parent(struct task_struct *father,
>  {
>  	struct task_struct *p, *t, *reaper;
>  
> -	if (unlikely(!list_empty(&father->ptraced)))
> -		exit_ptrace(father, dead);
> -
>  	/* Can drop and reacquire tasklist_lock */
>  	reaper = find_child_reaper(father);
>  	if (list_empty(&father->children))
> @@ -705,8 +702,18 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	LIST_HEAD(dead);
>  
>  	write_lock_irq(&tasklist_lock);
> -	forget_original_parent(tsk, &dead);
> +	if (unlikely(!list_empty(&tsk->ptraced)))
> +		exit_ptrace(tsk, &dead);
> +	write_unlock_irq(&tasklist_lock);
> +
> +	/* Ptraced tasks have to be released before zap_pid_ns_processes(). */
> +	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
> +		list_del_init(&p->ptrace_entry);
> +		release_task(p);
> +	}
>  
> +	write_lock_irq(&tasklist_lock);
> +	forget_original_parent(tsk, &dead);
>  	if (group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
> -- 
> 2.17.2
> 

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="ptrace_pidns.c"

#define _GNU_SOURCE         /* See feature_test_macros(7) */
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <sys/syscall.h>   /* For SYS_xxx definitions */
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>


int pfd[2];
void *thread_fn()
{
	pid_t tid = syscall(SYS_gettid);
	write(pfd[1], &tid, sizeof(tid));
	sleep(1000);
	return NULL;
}

int main()
{
	pid_t pid, tid, ppid = getpid();
	pthread_t t;

	if (pipe(pfd))
		return 1;

	pid = fork();
	if (pid < 0)
		return 1;
	if (pid == 0) {
		pthread_create(&t, NULL, thread_fn, (void *)(unsigned long)ppid);
		sleep(1000);
		return 0;
	}
	printf("fork: %d\n", pid);

	if (read(pfd[0], &tid, sizeof(tid)) != sizeof(tid))
		return 1;
	printf("thread: %d\n", tid);
	if (ptrace(PTRACE_ATTACH, tid, 0, 0))
		return 1;
	if (wait4(tid, NULL, __WALL, NULL) != tid)
		return 1;
	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
		return 1;
	if (wait4(pid, NULL, __WALL, NULL) != pid)
		return 1;

	kill(pid, SIGKILL);

	*((int *)(0)) = 0xdead;

	return 0;
}

--uAKRQypu60I7Lcqm--
