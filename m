Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-990257-1522874190-2-14423072940316325163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522874189; b=pl7yQn5ue4BaE9nmwPKAkQHviKfBbJhxON+AAqdrqXOHeeuOJK
    TvcW9SULstuL7e53oT+bkI5EZ/4u5+N8jFvX8JXlzyKN+PBB37MYvLNStlAGWIfB
    YCvoCNtPlFgnn7Q0uxMOvj9rHnV2nj0W8tGgOOm0Vl7kxpVpDY/n3dO8bkikCLlN
    8O35KJyvi7Hp2+hTahf8wizUafWr0Ub8QTC3A9RPj5+zx2KAHSpYPo3MqwQMVILZ
    JtIhZp1Zq2MiSxMCNWKoTdakrGzTph0Y1rM1+s63qBe474gc3VQLca1KjebdKfkj
    yW6P0vaxKlIu6mCMzoCGfQ0OQCs5aXJiF5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522874189;
    bh=GlvP9lbNe2OppPQ7mOQEtAqjxoi/XcXZUkVox2G1omE=; b=QEyMJeylBKWP
    Yxk4ilDOcUWFSvyu1CujDFyALCazsarF9T5CjReZmmU/Lr7eh3IOGt3FMUp3NdBj
    YU2MTZotbtwiZygiDUNp9oniTZYNQNayofOrJPvdyjbbEBko6YshqlkXsI/uOdj3
    Y5X+J67adHUL8LVz8I6FcwsDBO0HAS7U490+YH51AS7Y4DVjABKobmypnzGvaoWM
    nJQmgxlsuBVOHWIcB9xPZayb2T0ZNUR+jVBdrOr1UcIN1012nJwiXah4jM8WNbLv
    EKWATtpmv3zl3DK55Cag6VnNvy78iTMVHCv3AAg0gBShpqKQDPJtGWXfxEbqPr0A
    Hlutz1nBug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=OcynzSk6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=OcynzSk6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPLH0ykzALwOtg7KhQvdQmuf/Y5eOLuFcetRnhatFI649daznLyO7SJ0kkXIDnePhSzEvdNMPFIyDO5dOl5/n+zftd/IDftqeMZFwf2C8U01bIIAEsTN
    4TB6cgkrpiz5l8ceM6mqeUtUX88O8XvbR3U/m4HSjW2gFKUMtbe7/CkRg97laZzRkTJLb3pMZQtfqkD1ryL29fXcA0U2E0v1GxGnciMoT2tAF8Xj+IB99AEl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=6R7veym_AAAA:8 a=VwQbUJbxAAAA:8 a=abp08bwvNFGguF1ZFzQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=ILCOIF4F_8SzUMnO7jNM:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeDDUg2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 16:36:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34160 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeDDUg1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 16:36:27 -0400
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
Date: Wed, 4 Apr 2018 13:31:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <152286911105.615669.14053871624892399807.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=45 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040198
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
> Each process have different pids, one for each pid namespace it belongs.
> When interaction happens within single pid-ns translation isn't required.
> More complicated scenarios needs special handling.
>
> For example:
> - reading pid-files or logs written inside container with pid namespace
> - attaching with ptrace to tasks from different pid namespace
> - passing pids across pid namespaces in any kind of API
>
> Currently there are several interfaces that could be used here:
>
> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.
>
> Pids for nested Pid namespaces are shown in file /proc/[pid]/status.
> In some cases conversion pid -> vpid could be easily done using this
> information, but backward translation requires scanning all tasks.
>
> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
> into pid namespace, this expose process and could be insecure.
>
> This patch adds new syscall for converting pids between pid namespaces:
>
> pid_t translate_pid(pid_t pid, int source_type, int source,
>                                 int target_type, int target);
>
> @source_type and @target_type defines type of following arguments:
>
> TRANSLATE_PID_CURRENT_PIDNS  - current pid namespace, argument is unused
> TRANSLATE_PID_TASK_PIDNS     - task pid-ns, argument is task pid

I believe using pid to represent the namespace has been already
discussed in V1 of this patch in https://lkml.org/lkml/2015/9/22/1087
after which we moved on to fd based version of this interface.

-Nagarathnam.

> TRANSLATE_PID_FD_PIDNS       - pidns fd, argument is file descriptor
>
> Syscall returns pid in target pid-ns or zero if task have no pid there.
>
> Error codes:
> -EINVAL   - @source or @target couldn't be resolved into pid namespace
> -ESRCH    - task with @pid is not found in @source pid-namespace
>
> Other pid namespaces are referenced either by pid of any process who
> lives inside it or by file descriptor pointing to /proc/[pid]/ns/pid.
> Latter method provides better protection against races but in some
> cases requires CAP_SYS_PTRACE.
>
> Translate_pid could breach pid isolation and return pids from outer pid
> namespaces iff process already has file descriptor pointing to them.
>
>
> Examples:
>
> - get pid in current pid namespace
>
> translate_pid(pid, TRANSLATE_PID_FD_PIDNS, ns_fd,
>                     TRANSLATE_PID_CURRENT_PIDNS, 0)
> or
> translate_pid(pid, TRANSLATE_PID_TASK_PIDNS, ns_pid,
>                     TRANSLATE_PID_CURRENT_PIDNS, 0)
>
> - get pid in other pid namespace
>
> translate_pid(pid, TRANSLATE_PID_CURRENT_PIDNS, 0,
>                     TRANSLATE_PID_FD_PIDNS, ns_fd)
> or
> translate_pid(pid, TRANSLATE_PID_CURRENT_PIDNS, 0,
>                     TRANSLATE_PID_TASK_PIDNS, ns_pid)
>
> - get deepest pid
>
> translate_pid(pid, TRANSLATE_PID_CURRENT_PIDNS, 0,
>                     TRANSLATE_PID_TASK_PIDNS, pid)
>
> - get pid of init task for namespace
>
> translate_pid(1, TRANSLATE_PID_FD_PIDNS, ns_fd,
>                   TRANSLATE_PID_CURRENT_PIDNS, 0)
>
>
> This syscall also could be used for checking topology of pid namespaces:
>
> - ns1 nests inside ns2
>
> translate_pid(1, TRANSLATE_PID_FD_PIDNS, ns1_fd,
>                   TRANSLATE_PID_FD_PIDNS, ns2_fd) > 1
>
> - task1 lives in same pid-namespace as task2
>
> translate_pid(1, TRANSLATE_PID_TASK_PIDNS, task1_pid,
>                   TRANSLATE_PID_TASK_PIDNS, task2_pid) == 1
>
> - task1 is isolated from task2
>
> translate_pid(task1_pid, TRANSLATE_PID_CURRENT_PIDNS, 0,
>                           TRANSLATE_PID_TASK_PIDNS, task2_pid) == 0
>
> - pid is reachable from ns
>
> translate_pid(pid, TRANSLATE_PID_CURRENT_PIDNS, 0,
>                     TRANSLATE_PID_FD_PIDNS, ns_fd) > 0
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>
> ---
>
> v1: https://lkml.org/lkml/2015/9/15/411
> v2: https://lkml.org/lkml/2015/9/24/278
>   * use namespace-fd as second/third argument
>   * add -pid for getting parent pid
>   * move code into kernel/sys.c next to getppid
>   * drop ifdef CONFIG_PID_NS
>   * add generic syscall
> v3: https://lkml.org/lkml/2015/9/28/3
>   * use proc_ns_fdget()
>   * update description
>   * rebase to next-20150925
>   * fix conflict with mlock2
> v4: https://lkml.org/lkml/2017/10/16/852
>   * rename into translate_pid()
>   * remove syscall if CONFIG_PID_NS=n
>   * drop -pid for parent task
>   * drop fget-fdget optimizations
>   * add helper get_pid_ns_by_fd()
>   * wire only into x86
> v5:
>   * rewrite commit message
>   * resolve pidns by task pid or by pidns fd
>   * add arguments source_type and target_type
>
> --- sample tool translate_pid.c ---
>
> #define _GNU_SOURCE
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sched.h>
> #include <fcntl.h>
> #include <err.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
>
> #ifndef SYS_translate_pid
> #ifdef __x86_64__
> #define SYS_translate_pid 333
> #endif
> #endif
>
> #ifndef TRANSLATE_PID_CURRENT_PIDNS
> #define TRANSLATE_PID_CURRENT_PIDNS	0
> #define TRANSLATE_PID_TASK_PIDNS	1
> #define TRANSLATE_PID_FD_PIDNS		2
> #endif
>
> pid_t translate_pid(pid_t pid, int source_type, int source,
> 			       int target_type, int target) {
> 	return syscall(SYS_translate_pid, pid, source_type, source,
> 					       target_type, target);
> }
>
> int main(int argc, char **argv) {
> 	int pid, source, target;
> 	char buf[64];
>
> 	if (argc != 4)
> 		errx(1, "usage: %s <pid> <source> <traget>", argv[0]);
>
> 	pid = atoi(argv[1]);
> 	int source_type, target_type;
> 	source = atoi(argv[2]);
> 	target = atoi(argv[3]);
>
> 	if (source < 0) {
> 		source_type = TRANSLATE_PID_TASK_PIDNS;
> 		source = -source;
> 	} else if (source > 0) {
> 		source_type = TRANSLATE_PID_FD_PIDNS;
> 		sprintf(buf, "/proc/%d/ns/pid", source);
> 		source = open(buf, O_RDONLY);
> 		if (source < 0)
> 			err(2, "open source %s", buf);
> 	} else {
> 		source_type = TRANSLATE_PID_CURRENT_PIDNS;
> 	}
>
> 	if (target < 0) {
> 		target_type = TRANSLATE_PID_TASK_PIDNS;
> 		target = -target;
> 	} else if (target > 0) {
> 		target_type = TRANSLATE_PID_FD_PIDNS;
> 		sprintf(buf, "/proc/%d/ns/pid", target);
> 		target = open(buf, O_RDONLY);
> 		if (target < 0)
> 			err(2, "open target %s", buf);
> 	} else {
> 		target_type = TRANSLATE_PID_CURRENT_PIDNS;
> 	}
>
> 	pid = translate_pid(pid, source_type, source, target_type, target);
> 	if (pid < 0)
> 		err(2, "translate");
>
> 	printf("%d\n", pid);
> 	return 0;
> }
>
> ---
> ---
>   arch/x86/entry/syscalls/syscall_32.tbl |    1 +
>   arch/x86/entry/syscalls/syscall_64.tbl |    1 +
>   include/linux/syscalls.h               |    4 ++
>   include/uapi/linux/sched.h             |    7 ++++
>   kernel/pid_namespace.c                 |   64 ++++++++++++++++++++++++++++++++
>   kernel/sys_ni.c                        |    3 ++
>   6 files changed, 80 insertions(+)
>
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index c58f75b088c5..aef52c709845 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -391,3 +391,4 @@
>   382	i386	pkey_free		sys_pkey_free
>   383	i386	statx			sys_statx
>   384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
> +385	i386	translate_pid		sys_translate_pid
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 5aef183e2f85..1ebdab83c6f4 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -339,6 +339,7 @@
>   330	common	pkey_alloc		sys_pkey_alloc
>   331	common	pkey_free		sys_pkey_free
>   332	common	statx			sys_statx
> +333	common	translate_pid		sys_translate_pid
>   
>   #
>   # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index b961184f597a..d189a1f61160 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -553,6 +553,10 @@ asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
>   /* kernel/printk.c */
>   asmlinkage long sys_syslog(int type, char __user *buf, int len);
>   
> +/* kernel/pid_namespace.c */
> +asmlinkage long sys_translate_pid(pid_t pid, int source_type, int source,
> +				  int target_type, int target);
> +
>   /* kernel/ptrace.c */
>   asmlinkage long sys_ptrace(long request, long pid, unsigned long addr,
>   			   unsigned long data);
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 22627f80063e..7c45fd8d33d7 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -55,4 +55,11 @@
>   			 SCHED_FLAG_RECLAIM		| \
>   			 SCHED_FLAG_DL_OVERRUN)
>   
> +/*
> + * For translate_pid()
> + */
> +#define TRANSLATE_PID_CURRENT_PIDNS	0	/* Current pid namespace */
> +#define TRANSLATE_PID_TASK_PIDNS	1	/* Namespace by task pid */
> +#define TRANSLATE_PID_FD_PIDNS		2	/* Namespace by pidns fd */
> +
>   #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 2a2ac53d8b8b..84c8b47289d5 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -13,6 +13,7 @@
>   #include <linux/user_namespace.h>
>   #include <linux/syscalls.h>
>   #include <linux/cred.h>
> +#include <linux/file.h>
>   #include <linux/err.h>
>   #include <linux/acct.h>
>   #include <linux/slab.h>
> @@ -380,6 +381,69 @@ static void pidns_put(struct ns_common *ns)
>   	put_pid_ns(to_pid_ns(ns));
>   }
>   
> +/* Under rcu_read_lock(). Returns pointer to pid_namespace or NULL. */
> +static struct pid_namespace *resolve_pid_ns(int type, int fd_or_pid)
> +{
> +	struct pid_namespace *current_ns = task_active_pid_ns(current);
> +	struct pid_namespace *pidns = NULL;
> +	struct ns_common *ns;
> +	struct file *file;
> +
> +	switch (type) {
> +	case TRANSLATE_PID_CURRENT_PIDNS:
> +		pidns = current_ns;
> +		break;
> +	case TRANSLATE_PID_TASK_PIDNS:
> +		pidns = ns_of_pid(find_pid_ns(fd_or_pid, current_ns));
> +		break;
> +	case TRANSLATE_PID_FD_PIDNS:
> +		file = proc_ns_fget(fd_or_pid);
> +		if (!IS_ERR(file)) {
> +			ns = get_proc_ns(file_inode(file));
> +			if (ns->ops->type == CLONE_NEWPID)
> +				pidns = to_pid_ns(ns);
> +			fput(file);
> +		}
> +		break;
> +	}
> +
> +	return pidns;
> +}
> +
> +/*
> + * translate_pid - convert pid in source pid-ns into target pid-ns.
> + * @pid:    pid for translation
> + * @source_type: one of TRANSLATE_PID_*
> + * @source: depending on @source_type pid-ns fd, pid, or nothing
> + * @target_type: one of TRANSLATE_PID_*
> + * @target: depending on @target_type pid-ns fd, pid, or nothing
> + *
> + * Returns pid in @target pid-ns, zero if task have no pid there,
> + * or -ESRCH if task with @pid does not found in @source pid-ns,
> + * or -EINVAL if @source or @target couldn't be resolved into pid-ns.
> + */
> +SYSCALL_DEFINE5(translate_pid, pid_t, pid,
> +		int, source_type, int, source,
> +		int, target_type, int, target)
> +{
> +	struct pid_namespace *source_ns, *target_ns;
> +	struct pid *struct_pid;
> +	pid_t result = -EINVAL;
> +
> +	rcu_read_lock();
> +	source_ns = resolve_pid_ns(source_type, source);
> +	if (!source_ns)
> +		goto out;
> +	target_ns = resolve_pid_ns(target_type, target);
> +	if (!target_ns)
> +		goto out;
> +	struct_pid = find_pid_ns(pid, source_ns);
> +	result = struct_pid ? pid_nr_ns(struct_pid, target_ns) : -ESRCH;
> +out:
> +	rcu_read_unlock();
> +	return result;
> +}
> +
>   static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>   {
>   	struct pid_namespace *active = task_active_pid_ns(current);
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 6cafc008f6db..777689bce406 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -146,6 +146,9 @@ COND_SYSCALL(delete_module);
>   /* kernel/printk.c */
>   COND_SYSCALL(syslog);
>   
> +/* kernel/pid_namespace.c */
> +COND_SYSCALL(sys_translate_pid);
> +
>   /* kernel/ptrace.c */
>   
>   /* kernel/sched/core.c */
>

