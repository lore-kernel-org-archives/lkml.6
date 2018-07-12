Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13152208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHHv63U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13152208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGLMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:41:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44526 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbeGLMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:41:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so21255382ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+FuTNi+l1doNKxoG8pOM1DgUpaAvIaOLBdgyLEjmUrI=;
        b=MHHv63U3YX1e6QXensTId6WIblkaMTyNwLEGg+BysvYglnKRsMThy8c+oKmFvijBsg
         hOwdZogTBpq4Z0Zz6YKELwocYv2Z5uj4qkpuac6V/+W3Wgv4z3Vl0j6Nn+L2RepA06Ds
         aa2JsqjPexmoUFHt/qe+2XIHr+kA4DQKnwCs2HBOEioKCrcYMV4GTCjb1IxV/bZGocxl
         eS56P6LLRsQnFyKZ3ItdumZXCFfmEOC48AscXcAbMEm6ZzjPxmlAfnKQAysAwIfybsp5
         D79Gdx29DVco9vAbhyT7FzsEl/VKHB9DcutbhI6835K2z4BsbmolI4soNiZIveyZDAos
         8a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+FuTNi+l1doNKxoG8pOM1DgUpaAvIaOLBdgyLEjmUrI=;
        b=NS2eO5OREpXQWJjBg2fGtpoy4Hp67VzPxcPvQKYJ9/GFTABPpV+4uUP0VQy21evvOI
         3KCO7TwDp6KDLwuLi59qonQizQQ5gV0pUKCLG04CA8yKYPd45lIh8zgaLNws5GmzxM5P
         op2ZalUk6FYyZ8w4cbfjJefkrvut3aWRSVba3ncpUu0vYlkzP/hP3uzBvNxKnBm1Ljmw
         9brsAw8HcQLWKOCdYKrtK/Y7M1U0QH7S2GYEQ4sAuTMMhRtv9kz3wC14XEs4YzlvOqLm
         GwpNdOEMyO11/Xnc+Gcsrp0QRo/gHe9rrGggckOD5e88xHUpNUqj1tKQKwQP3jDJBVnZ
         v8EA==
X-Gm-Message-State: AOUpUlGg448v8pwRkfuKPk6kiNdrQkQanju5D2DSWNeirkfXB01Kq0kC
        8bLFWSWctvgLPepS6kH7cghU2/5a5wtrcxy/PDA=
X-Google-Smtp-Source: AAOMgpcBNfQDpOJejTLH4wjWmBEgbnGBUap0Bv9u5ExGDRylOSgzXqv/QyT6ZfdFDt+Rb1IhoyCdTjf38/yVs1ZM7Ps=
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr523609lje.41.1531398704986;
 Thu, 12 Jul 2018 05:31:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 05:31:43
 -0700 (PDT)
In-Reply-To: <20180712083258.GE8802@infradead.org>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com> <20180705222110.GA5698@infradead.org>
 <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com>
 <CAK8P3a2L9z+Ok1Wd0=5F=Xt7nvqL6be+AS++F3rZzByN+a+9QA@mail.gmail.com> <20180712083258.GE8802@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 14:31:43 +0200
X-Google-Sender-Auth: 9nmxyc8DYRfS5SnZdOCnQVko6Cw
Message-ID: <CAK8P3a2fh7OD2pFDDkBpbzqLugUpNbUZP-w-uH-FZtbAWg8jMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:32 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jul 06, 2018 at 01:42:46PM +0200, Arnd Bergmann wrote:
>> We can also rename all the compat syscalls that are now shared
>> with 32-bit, e.g. using sys_waitid_time32() instead of
>> compat_sys_waitid(), and that would be consistent with the
>> new _time64() naming that we are introducing for some of them.
>
> Yes, please.  You'll need to touch the syscall tables anyway to refer to
> some new name, so it really isn't that much more work.

Ok. The downside is that we probably have to change the existing
architectures using those compat syscalls together, with one patch
renaming them in x86, powerpc, s390, mips, sparc and parisc, but
at least that is a fairly simple rename.

For the tables that are used on native 32-bit architectures
(asm-generic, arm, m68k, microblaze, mips, parisc, powerpc,
sh, sparc, x86 and xtensa), I'd still prefer following the plan of
changing them one architecture at a time in a separate patch,
but hopefully all in the same merge window.

>> Completely separating them from the compat code
>> would add further complexity though, as some of the
>> system calls take another argument that is different
>> between 32-bit and 64-bit kernels, in particular
>> pselect6, ppoll, io_pgetevents, recvmmsg, and waitid.
>
> Why would that create further complexity?  IFF those calls need compat
> work other than the time structures you will need additional variants of
> them anyway.  If the only compat handling is the time structures they
> will stay the same independent of the name.

Right now, each of the five syscalls has three variants in the current
implementation, e.g.

/* new native call using 64-bit time_t */
SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
                struct __kernel_timespec __user *, tsp, const sigset_t
__user *, sigmask,
                size_t, sigsetsize)
...

/* handler for 32-bit time_t, both native and compat */
#ifdef CONFIG_COMPAT_32BIT_TIME
#ifndef CONFIG_COMPAT
/* ugly redirect to native types on 32-bit kernels */
#define compat_get_fd_set get_fd_set
#define compat_set_fd_set set_fd_set
#define compat_sigset_t sigset_t
#endif /* !CONFIG_COMPAT
COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
        unsigned int,  nfds, struct compat_timespec __user *, tsp,
        const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
...
#endif /* CONFIG_COMPAT_32BIT_TIME */

/* compat handler for 64-bit time_t on 64-bit kernel */
#ifdef CONFIG_COMPAT
COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
        unsigned int,  nfds, struct __kernel_timespec __user *, tsp,
        const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
...
#endif

Avoiding that set of #defines as you suggest would definitely
make it cleaner, but then we need to have four variants instead
of three:

/* old native call using 32-bit time_t */
#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined (CONFIG_64BIT)
SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
                struct __kernel_old_timespec __user *, tsp, const
sigset_t __user *, sigmask,
                size_t, sigsetsize)
...
#endif

/* new native call using 64-bit time_t */
SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
                struct __kernel_timespec __user *, tsp, const sigset_t
__user *, sigmask,
                size_t, sigsetsize)
...

#ifdef CONFIG_COMPAT
#ifdef CONFIG_COMPAT_32BIT_TIME
/* handler for 32-bit time_t, both native and compat */
COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
        unsigned int,  nfds, struct compat_timespec __user *, tsp,
        const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
...
#endif /* CONFIG_COMPAT_32BIT_TIME */

/* compat handler for 64-bit time_t on 64-bit kernel */
#ifdef CONFIG_COMPAT
COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
        unsigned int,  nfds, struct __kernel_timespec __user *, tsp,
        const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
...
#endif /* CONFIG_COMPAT


I prototyped that approach now and ended up with
(relative to my current tested version):

 fs/aio.c        |  70 ++++++++++++++++------
 fs/select.c     | 181 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/signal.c |  35 ++++++++++-
 net/compat.c    |  31 ++++++++++
 net/socket.c    |  21 ++++---
 5 files changed, 293 insertions(+), 45 deletions(-)

Full diff is at https://pastebin.com/j8USJpLq. I've changed ppoll, pselect6,
recvmmsg, rt_sigtimedwait, and io_pgetevents here; waitid() was already
done with four entry points, which happened to be simpler there either
way. There are now around 270 lines of additional duplicated system call
definitions, but in return the code does make more sense that way. Some of
that duplication (in particular in fs/select.c) can probably be recovered by
rearranging the code. By fully decoupling the 32-bit time handling from
compat mode, we also need yet another timespec variant besides
timespec (long/long), timespec64 (kernel internal s64/long),
__kernel_timespec (uapi s64/s64), and compat_timespec (s32/s32),
or rename all instances of compat_timespec to __kernel_timespec32.

I'm not convinced that one way or another is better here, please let me know
what you think.

       Arnd
