Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910A020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POkysWcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910A020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeKTCX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:23:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35854 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbeKTCX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:23:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so18052276vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fs1LfmnQGpMgqHt/doF7eI0wqc9xNNN2CG3Cn4Hf1fg=;
        b=POkysWcWXvCdFn96HhMk6dwlWLycXtVFKRZcxCB4biLoBxTdereLXOEXaNrBx62XLa
         H+TXt9JdNHm4WRDqDfybmVMRdHqf6mwLFFtXh4y3m6nbf1HlN59Ym6c/m/HRSeUrjjwB
         dKY+5ZsPV9JGSpTQQZQMLlsnhc0oWvIIsZ1OmlOpbWM8cDe70ZuW0rDb39u30F3De0IW
         D30ehzcg01wIZaoBtxZFcWo4kwpyHLjOLJbszjiKe1wv9IUjRiYrXvnu4g5nOSk/C+zl
         ow1DTNU18mZPTvkx9utqyGH5Phcp4cK6liKHwGv5BBjMlh+lWiJ6jxz5PUoOl2uw3aIr
         wvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fs1LfmnQGpMgqHt/doF7eI0wqc9xNNN2CG3Cn4Hf1fg=;
        b=tLmBlRGjv80tzaoEbR2u4nKrHXzAeR1GIkstAUSQVAJgN6oS1AAD8XIQcAn4E+Nddx
         O3G2/l7cQ8/qTrG9LsiAfBW3HT+OaNRudJ/cqMmHkDTj2xcoOcIRmtIMVJZhAzAq84/6
         1rEYt7gA3brQLMznx6Pb0LSzd27CqZBjSEw7v9qpcKjXT7NPf0ILOBYlyBNkLSfNT8PH
         rUnSQV7cRMFkaGXKcdb0qFh8LQCJvPaBPz4/gsJ/EOiC2NORLDIKhy+nX1mmoel5gBDk
         dmTSi+O6s5Vs8n8mz/lpMB7LDO1W1b4OAg0Ysr5AcNL+wuCLoXV6ICVlNotFOrpckgNU
         e5NA==
X-Gm-Message-State: AGRZ1gJPEyCSRvVQIIvcfaDWHoIRclNmhyte2UqaJGLz++SoVVXAHJ8n
        4VLylQUFNuI7XXBzdSDbHY1JkHmxxvJ2+2KodYQc0A==
X-Google-Smtp-Source: AJdET5feoroS4a0iow/IBjl2Vl3fNHRAvbYi6EtoLftRtkyX65c6sHPJl+uhOX8/H5+kytxyoEej4+tqs2gRQrq87e8=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr9531407vsc.171.1542643165359;
 Mon, 19 Nov 2018 07:59:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 07:59:24
 -0800 (PST)
In-Reply-To: <20181119103241.5229-3-christian@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 07:59:24 -0800
Message-ID: <CAKOZueshQ2DAwUYp+dLpmfYG6FtvCqeRQxH41SjNS+WqY3e0Fw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:32 AM, Christian Brauner <christian@brauner.io> wrote:
> The kill() syscall operates on process identifiers. After a process has
> exited its pid can be reused by another process. If a caller sends a signal
> to a reused pid it will end up signaling the wrong process. This issue has
> often surfaced and there has been a push [1] to address this problem.
>
> A prior patch has introduced the ability to get a file descriptor
> referencing struct pid by opening /proc/<pid>. This guarantees a stable
> handle on a process which can be used to send signals to the referenced
> process. Discussion has shown that a dedicated syscall is preferable over
> ioctl()s. Thus, the  new syscall procfd_signal() is introduced to solve
> this problem. It operates on a process file descriptor.
> The syscall takes an additional siginfo_t and flags argument. If siginfo_t
> is NULL then procfd_signal() behaves like kill() if it is not NULL it
> behaves like rt_sigqueueinfo.
> The flags argument is added to allow for future extensions of this syscall.
> It currently needs to be passed as 0.
>
> With this patch a process can be killed via:
>
>  #define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <signal.h>
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <unistd.h>
>
>  int main(int argc, char *argv[])
>  {
>          int ret;
>          char buf[1000];
>
>          if (argc < 2)
>                  exit(EXIT_FAILURE);
>
>          ret = snprintf(buf, sizeof(buf), "/proc/%s", argv[1]);
>          if (ret < 0)
>                  exit(EXIT_FAILURE);
>
>          int fd = open(buf, O_DIRECTORY | O_CLOEXEC);
>          if (fd < 0) {
>                  printf("%s - Failed to open \"%s\"\n", strerror(errno), buf);
>                  exit(EXIT_FAILURE);
>          }
>
>          ret = syscall(__NR_procfd_signal, fd, SIGKILL, NULL, 0);
>          if (ret < 0) {
>                  printf("Failed to send SIGKILL \"%s\"\n", strerror(errno));
>                  close(fd);
>                  exit(EXIT_FAILURE);
>          }
>
>          close(fd);
>
>          exit(EXIT_SUCCESS);
>  }
>
> [1]: https://lkml.org/lkml/2018/11/18/130
>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> Changelog:
> v1:
> - patch introduced
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  fs/proc/base.c                         |  6 ++
>  include/linux/proc_fs.h                |  1 +
>  include/linux/syscalls.h               |  2 +
>  kernel/signal.c                        | 76 ++++++++++++++++++++++++--
>  6 files changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 3cf7b533b3d1..e637eab883e9 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -398,3 +398,4 @@
>  384    i386    arch_prctl              sys_arch_prctl                  __ia32_compat_sys_arch_prctl
>  385    i386    io_pgetevents           sys_io_pgetevents               __ia32_compat_sys_io_pgetevents
>  386    i386    rseq                    sys_rseq                        __ia32_sys_rseq
> +387    i386    procfd_signal           sys_procfd_signal               __ia32_sys_procfd_signal
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f0b1709a5ffb..e95f6741ab42 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,7 @@
>  332    common  statx                   __x64_sys_statx
>  333    common  io_pgetevents           __x64_sys_io_pgetevents
>  334    common  rseq                    __x64_sys_rseq
> +335    common  procfd_signal           __x64_sys_procfd_signal
>
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6365a4fea314..a12c9de92bd0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3055,6 +3055,12 @@ static const struct file_operations proc_tgid_base_operations = {
>         .release        = proc_tgid_release,
>  };
>
> +bool proc_is_procfd(const struct file *file)
> +{
> +       return d_is_dir(file->f_path.dentry) &&
> +              (file->f_op == &proc_tgid_base_operations);
> +}
> +
>  static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
>  {
>         return proc_pident_lookup(dir, dentry,
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index d0e1f1522a78..2d53a47fba34 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -73,6 +73,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
>                                                     int (*show)(struct seq_file *, void *),
>                                                     proc_write_t write,
>                                                     void *data);
> +extern bool proc_is_procfd(const struct file *file);
>
>  #else /* CONFIG_PROC_FS */
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2ac3d13a915b..a5ca8cb84566 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -907,6 +907,8 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
>                           unsigned mask, struct statx __user *buffer);
>  asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
>                          int flags, uint32_t sig);
> +asmlinkage long sys_procfd_signal(int fd, int sig, siginfo_t __user *info,
> +                                 int flags);
>
>  /*
>   * Architecture-specific system calls
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9a32bc2088c9..e8a8929de710 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -19,7 +19,9 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/proc_fs.h>
>  #include <linux/tty.h>
>  #include <linux/binfmts.h>
>  #include <linux/coredump.h>
> @@ -3286,6 +3288,16 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
>  }
>  #endif
>
> +static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
> +{
> +       clear_siginfo(info);
> +       info->si_signo = sig;
> +       info->si_errno = 0;
> +       info->si_code = SI_USER;
> +       info->si_pid = task_tgid_vnr(current);
> +       info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
> +}
> +
>  /**
>   *  sys_kill - send a signal to a process
>   *  @pid: the PID of the process
> @@ -3295,16 +3307,68 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
>  {
>         struct kernel_siginfo info;
>
> -       clear_siginfo(&info);
> -       info.si_signo = sig;
> -       info.si_errno = 0;
> -       info.si_code = SI_USER;
> -       info.si_pid = task_tgid_vnr(current);
> -       info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> +       prepare_kill_siginfo(sig, &info);
>
>         return kill_something_info(sig, &info, pid);
>  }
>
> +/**
> + *  sys_procfd_signal - send a signal to a process through a process file
> + *                      descriptor
> + *  @fd: the file descriptor of the process
> + *  @sig: signal to be sent
> + *  @info: the signal info
> + *  @flags: future flags to be passed
> + */
> +SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user *, info,
> +               int, flags)
> +{
> +       int ret;
> +       struct pid *pid;
> +       kernel_siginfo_t kinfo;
> +       struct fd f;
> +
> +       /* Enforce flags be set to 0 until we add an extension. */
> +       if (flags)
> +               return -EINVAL;
> +
> +       f = fdget_raw(fd);
> +       if (!f.file)
> +               return -EBADF;
> +
> +       ret = -EINVAL;
> +       /* Is this a process file descriptor? */
> +       if (!proc_is_procfd(f.file))
> +               goto err;
> +
> +       pid = f.file->private_data;

You never addressed my comment on the previous patch about your use of
private_data here. Why can't you use the struct pid reference that's
already in the inode?
