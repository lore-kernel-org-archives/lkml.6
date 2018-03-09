Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238303-1520555080-2-12207154546450966138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520555079; b=FFuKIqtc2kC4eaPlEZ5oJzfAiJNy/RtySAUs9pzRHCSI4Po
    gcCvuyjX9jeFlIKJ0Hd9i/QldlhwH0VN+51DDK4Wp2rmUsIp+wqd2dqtJkj4QxDR
    ySisU3H3OIxGNM/WcQNgDi5taAxGe9r1UyrkFS9OPsdhFxCk5nFfHIitrTaV+4h9
    CxdTVyiQG2dhh9w3UXqW+KbA8TZCTx6L7Su8lsb+PvarrG9dsVYLUrCVPsD1k0vL
    2y3+op1efd/dKb58oi+G1CD79NQdIqVkCyN//R1lwnnb6O6bbKEPu+a3p7mijw1G
    AqPu5e6Ilt92oWSDl0dBqn0n0pze5Hl3qOJ0E9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520555079; bh=5ZmxmYFHUum3Gzqdd3GQqOnhqbisawGFmOoig7
    7L1xw=; b=lUhqaRg83QYbSA0c/AHGkf/4nE9uAVZUM2OMITxCY/5higiXg4qy3d
    2Trvi4Zf/M6Ea11hPuBwsCEoFs9MF+fiTxRi3SMPnIj4XdzewnWEb8J0udRm1yR+
    FqfbOt62fHPD3UC9f80/znHFeKYWS/8xfb64FT0W6/aZ00kD7bjHO/VxAiDveRPi
    tnS0NPqXrC0qg9qqQzhm0a9xLrxyJ+ToPUC+16kvFvYhS1UcywFCaX/GPwVxftyr
    AJsHT893Won1Ba+pJ2RBnPrOdaZKZbPnC6YMB/kbRmWHUsufEo5IdvOyd2CoPXUC
    PS19X7keX4zoEV0U4cAa7k0vJdS4vzRw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=T80vAwsG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=qlcZQ98C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NHtXXFSG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=T80vAwsG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=qlcZQ98C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NHtXXFSG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeCIAYg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 19:24:36 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:39529 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeCIAYf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 19:24:35 -0500
X-Google-Smtp-Source: AG47ELugagSl7ovVbVqY0qysLGV93vTS7Up3FgXsdzBqdDGmu5G+cGPcIo6LTORbqEO1aTUWOaqryB4jWFzEYfAMwy8=
MIME-Version: 1.0
In-Reply-To: <20180306013457.1955486-1-ast@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 16:24:33 -0800
X-Google-Sender-Auth: aIOr8Qz1UaZpjfYrP1eNJiouIHY
Message-ID: <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

How is this not marked [RFC]? :)

On Mon, Mar 5, 2018 at 5:34 PM, Alexei Starovoitov <ast@kernel.org> wrote:
> As the first step in development of bpfilter project [1] the request_module()
> code is extended to allow user mode helpers to be invoked. Idea is that
> user mode helpers are built as part of the kernel build and installed as
> traditional kernel modules with .ko file extension into distro specified
> location, such that from a distribution point of view, they are no different
> than regular kernel modules. Thus, allow request_module() logic to load such
> user mode helper (umh) modules via:
>
>   request_module("foo") ->
>     call_umh("modprobe foo") ->
>       sys_finit_module(FD of /lib/modules/.../foo.ko) ->
>         call_umh(struct file)

Yikes. This means autoloaded artbitrary exec() now, instead of
autoloading just loading arbitrary modules? That seems extremely bad.
This just extends all the problems we've had with defining security
boundaries with modules out to umh too. I would need some major
convincing that this can be made safe.

It's easy for container to trigger arbitrary module loading, so if it
can find/use a similar one of the bugs we've seen in the past to
redirect the module loading we don't just get new module-created
attack surface added to the kernel, but we again get arbitrary ELF
running in the root ns (not in the container). And in the insane case
of a container with CAP_SYS_MODULE, this is a trivial escape without
even needing to build a special kernel module: the root ns, running
with all privileges runs an arbitrary ELF.

As it stands, I have to NAK this. At the very least, you need to solve
the execution environment problems here: the ELF should run with no
greater privileges than what loaded the module, and very importantly,
must not be allowed to bypass these checks through autoloading. What
_triggered_ the autoload must be the environment, not the "modprobe",
since that's running with full privileges. Basically, we need to fix
module autoloading first, or at least a significant subset of the
problems: https://lkml.org/lkml/2017/11/27/754

> Such approach enables kernel to delegate functionality traditionally done
> by kernel modules into user space processes (either root or !root) and
> reduces security attack surface of such new code, meaning in case of
> potential bugs only the umh would crash but not the kernel. Another
> advantage coming with that would be that bpfilter.ko can be debugged and
> tested out of user space as well (e.g. opening the possibility to run
> all clang sanitizers, fuzzers or test suites for checking translation).
> Also, such architecture makes the kernel/user boundary very precise:
> control plane is done by the user space while data plane stays in the kernel.
>
> It's easy to distinguish "umh module" from traditional kernel module:
>
> $ readelf -h bld/net/bpfilter/bpfilter.ko|grep Type
>   Type:                              EXEC (Executable file)

As Andy asked earlier, why not DYN too to catch PIE executables? Seems
like forcing the userspace helper to be non-PIE would defeat some of
the userspace defenses in use in most distros.

> $ readelf -h bld/net/ipv4/netfilter/iptable_filter.ko |grep Type
>   Type:                              REL (Relocatable file)
>
> Since umh can crash, can be oom-ed by the kernel, killed by admin,
> the subsystem that uses them (like bpfilter) need to manage life
> time of umh on its own, so module infra doesn't do any accounting
> of them. They don't appear in "lsmod" and cannot be "rmmod".
> Multiple request_module("umh") will load multiple umh.ko processes.
>
> Similar to kernel modules the kernel will be tainted if "umh module"
> has invalid signature.
>
> [1] https://lwn.net/Articles/747551/
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  fs/exec.c               | 40 +++++++++++++++++++++++++++++++---------
>  include/linux/binfmts.h |  1 +
>  include/linux/umh.h     |  3 +++
>  kernel/module.c         | 43 ++++++++++++++++++++++++++++++++++++++-----
>  kernel/umh.c            | 24 +++++++++++++++++++++---
>  5 files changed, 94 insertions(+), 17 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 7eb8d21bcab9..0483c438de7d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1691,14 +1691,13 @@ static int exec_binprm(struct linux_binprm *bprm)
>  /*
>   * sys_execve() executes a new program.
>   */
> -static int do_execveat_common(int fd, struct filename *filename,
> -                             struct user_arg_ptr argv,
> -                             struct user_arg_ptr envp,
> -                             int flags)
> +static int __do_execve_file(int fd, struct filename *filename,
> +                           struct user_arg_ptr argv,
> +                           struct user_arg_ptr envp,
> +                           int flags, struct file *file)
>  {
>         char *pathbuf = NULL;
>         struct linux_binprm *bprm;
> -       struct file *file;
>         struct files_struct *displaced;
>         int retval;
>
> @@ -1737,7 +1736,8 @@ static int do_execveat_common(int fd, struct filename *filename,
>         check_unsafe_exec(bprm);
>         current->in_execve = 1;
>
> -       file = do_open_execat(fd, filename, flags);
> +       if (!file)
> +               file = do_open_execat(fd, filename, flags);
>         retval = PTR_ERR(file);
>         if (IS_ERR(file))
>                 goto out_unmark;
> @@ -1745,7 +1745,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>         sched_exec();
>
>         bprm->file = file;
> -       if (fd == AT_FDCWD || filename->name[0] == '/') {
> +       if (!filename) {
> +               bprm->filename = "/dev/null";
> +       } else if (fd == AT_FDCWD || filename->name[0] == '/') {
>                 bprm->filename = filename->name;
>         } else {
>                 if (filename->name[0] == '\0')
> @@ -1811,7 +1813,8 @@ static int do_execveat_common(int fd, struct filename *filename,
>         task_numa_free(current);
>         free_bprm(bprm);
>         kfree(pathbuf);
> -       putname(filename);
> +       if (filename)
> +               putname(filename);
>         if (displaced)
>                 put_files_struct(displaced);
>         return retval;
> @@ -1834,10 +1837,29 @@ static int do_execveat_common(int fd, struct filename *filename,
>         if (displaced)
>                 reset_files_struct(displaced);
>  out_ret:
> -       putname(filename);
> +       if (filename)
> +               putname(filename);
>         return retval;
>  }
>
> +static int do_execveat_common(int fd, struct filename *filename,
> +                             struct user_arg_ptr argv,
> +                             struct user_arg_ptr envp,
> +                             int flags)
> +{
> +       struct file *file = NULL;
> +
> +       return __do_execve_file(fd, filename, argv, envp, flags, file);
> +}
> +
> +int do_execve_file(struct file *file, void *__argv, void *__envp)
> +{
> +       struct user_arg_ptr argv = { .ptr.native = __argv };
> +       struct user_arg_ptr envp = { .ptr.native = __envp };
> +
> +       return __do_execve_file(AT_FDCWD, NULL, argv, envp, 0, file);
> +}

The exec.c changes should be split into a separate patch. Something
feels incorrectly refactored here, though. Passing all three of fd,
filename, and file to __do_execve_file() seems wrong; perhaps the fd
to file handling needs to happen externally in what you have here as
do_execveat_common()? The resulting __do_execve_file() has repeated
conditionals on filename... maybe what I object to is being able to
pass a NULL filename at all. The filename can be (painfully)
reconstructed from the struct file.

> [...]
> diff --git a/kernel/module.c b/kernel/module.c
> index ad2d420024f6..6cfa35795741 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> [...]
> @@ -3870,14 +3896,21 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>                       |MODULE_INIT_IGNORE_VERMAGIC))
>                 return -EINVAL;
>
> -       err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
> -                                      READING_MODULE);
> +       f = fdget(fd);
> +       if (!f.file)
> +               return -EBADF;
> +
> +       err = kernel_read_file(f.file, &hdr, &size, INT_MAX, READING_MODULE);

For the LSM subsystem, I think this should also get it's own enum
kernel_read_file_id. This is really no longer a kernel module...

>         if (err)
> -               return err;
> +               goto out;
>         info.hdr = hdr;
>         info.len = size;
> +       info.file = f.file;
>
> -       return load_module(&info, uargs, flags);
> +       err = load_module(&info, uargs, flags);
> +out:
> +       fdput(f);
> +       return err;
>  }
>
>  static inline int within(unsigned long addr, void *start, unsigned long size)
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 18e5fa4b0e71..4361c694bdb1 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -97,9 +97,13 @@ static int call_usermodehelper_exec_async(void *data)
>
>         commit_creds(new);
>
> -       retval = do_execve(getname_kernel(sub_info->path),
> -                          (const char __user *const __user *)sub_info->argv,
> -                          (const char __user *const __user *)sub_info->envp);
> +       if (sub_info->file)
> +               retval = do_execve_file(sub_info->file,
> +                                       sub_info->argv, sub_info->envp);
> +       else
> +               retval = do_execve(getname_kernel(sub_info->path),
> +                                  (const char __user *const __user *)sub_info->argv,
> +                                  (const char __user *const __user *)sub_info->envp);
>  out:
>         sub_info->retval = retval;
>         /*
> @@ -393,6 +397,20 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
>  }
>  EXPORT_SYMBOL(call_usermodehelper_setup);
>
> +struct subprocess_info *call_usermodehelper_setup_file(struct file *file)
> +{
> +       struct subprocess_info *sub_info;
> +
> +       sub_info = kzalloc(sizeof(struct subprocess_info), GFP_KERNEL);
> +       if (!sub_info)
> +               return NULL;
> +
> +       INIT_WORK(&sub_info->work, call_usermodehelper_exec_work);
> +       sub_info->path = "/dev/null";
> +       sub_info->file = file;

This use of "/dev/null" here and in execve is just wrong. It _does_
have a path and filename...

Anyway, interesting idea. I think it _can_ work, it just needs much
much more careful security boundaries and to solve our autoloading
exposures too.

-Kees

-- 
Kees Cook
Pixel Security
