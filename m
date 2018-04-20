Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1692876-1524232394-2-5971427314764454533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524232393; b=vulAzqBFZZJ+lofvPMhxD9Cx50AZnWOh80FARGP7Tf9PQM++64
    WIBKOWp+DAyxC2iq+NjNL+kFnriWvG7Fg9pppSY8QYVSC0HDdg8DZHqKaDVRZ3Tm
    2XfFmXNPxyT1B9ntuqGkKEq/XNwt1jOdObXdIed+l7ZCC7VHutpUcSekcOrkK0qZ
    B2srLy4W4uqm41Q4PohF7vLUhP5TJsNZE5QSNnsndp6tPlCFpXZ/SyOSOmTE61D1
    2/Fu6SnBraXbaVsDIGfqn53mCw05spPADN1SHZeqnTPrzZAQiaBky+glxmA0xuoF
    lBrGl7WFFXiUIE0BMVTWvSGfOlZlXuuvp15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:reply-to:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type
    :sender:list-id; s=fm2; t=1524232393; bh=WkzCoDQr2LgEEY/VlEAKYAm
    L9GoWZ5T0Ux8T7CXBreI=; b=YvSt7K7r8enincvjlC6yKiOT90URmeOlmERCvGM
    0tUUgpA3Sj8i1N/Ql+KO5KiaKgdsrxKlS1utDSD20Mj5/icUgrE5eMAkq1p8Gbch
    pEgmqTtKyvhyERlDBWQGrFNJMe62+xUkl4bgycGZ2QxPZjuUVQ+fWGZZjceB5NoW
    himLJloK9slAeVenPc2n9oSNN24L89bnb3Xl9J3WY3orF6hOfmlY8KbftDfp/hbG
    gRnnR2e/t9Ku+zAys75MT8+ruTcW7WPrvtYHO9wfryK6LrJxyrZBiNTNIzv4gYu/
    FC4mpbfT7oq+wyRxef8BhWNAOFFxs9zcy7s5kndNAatgBXA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ky5q1DgT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rkZTgAR3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ky5q1DgT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rkZTgAR3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOzdsC4tLde4uDtZOOz/lXX9L0KC3LZ9PRcpmvkcEybgOgwzwG545ZWIQkcfLk/CssC+qdA6KTEkfdzyY4Iyww47rtaW76sktL0q6GCfk3rONIHjDzHp
    4tS+jZmu54sMx3JzknKGZ+p9nq2H8CaN1OTI0+lJ5liepnWIT6MxBNG0/OPwrkFNStgpAYjqgMD2zTBPChNGtQ1nYCSZTwUpmYiSXUL7yPAML7RDo8JGm5NK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=D7sYCfmIVtwA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=u9HXFIT4rO8A:10 a=Kd1tUaAdevIA:10 a=Twlkf-z8AAAA:8
    a=VwQbUJbxAAAA:8 a=LcDn_IacU_b8vFglI0YA:9 a=iNsWlpvon8Md7GxM:21
    a=1D3MSQC_yNqDnXaP:21 a=QEXdDO2ut3YA:10 a=Kgqpz72HzxEA:10
    a=-74SuR6ZdpOK_LpdRCUo:22 a=AjGcO6oz07-iQ99wixmX:22 a=8QWqhq0DWzMMWCF4mjpb:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755289AbeDTNxM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 09:53:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44978 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755105AbeDTNxH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 09:53:07 -0400
X-Google-Smtp-Source: AIpwx49jyll5my2GriVtLebDvaIpwBLMgHssYfaN8K8ujlJuaj//ldjMG0YrdHb83vCykbhLtL7QnY98YGCcxq5b+jE=
MIME-Version: 1.0
Reply-To: noloader@gmail.com
In-Reply-To: <20180420130346.3178914-1-arnd@arndb.de>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de>
From: Jeffrey Walton <noloader@gmail.com>
Date: Fri, 20 Apr 2018 09:53:05 -0400
Message-ID: <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ebiederm@xmission.com,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mips@linux-mips.org,
        jhogan@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Schepler <dschepler@gmail.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

One comment here:

> +#if !defined(__x86_64__) || !defined(__ilp32__)
>  #include <asm-generic/msgbuf.h>
> +#else

I understand there's some progress having Clang compile the kernel.
Clang treats __ILP32__ and friends differently than GCC. I believe
ILP32 shows up just about everywhere there are 32-bit ints, longs and
pointers. You might find it on Aarch64 or you might find it on MIPS64
when using Clang.

I think that means this may be a little suspicious:

    > +#if !defined(__x86_64__) || !defined(__ilp32__)

I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
devs insisted they were within their purview. Also see
https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.

Sorry about the top-post. I just wanted to pick out that one piece.

Jeff

On Fri, Apr 20, 2018 at 9:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> A bugfix broke the x32 shmid64_ds and msqid64_ds data structure layout
> (as seen from user space)  a few years ago: Originally, __BITS_PER_LONG
> was defined as 64 on x32, so we did not have padding after the 64-bit
> __kernel_time_t fields, After __BITS_PER_LONG got changed to 32,
> applications would observe extra padding.
>
> In other parts of the uapi headers we seem to have a mix of those
> expecting either 32 or 64 on x32 applications, so we can't easily revert
> the path that broke these two structures.
>
> Instead, this patch decouples x32 from the other architectures and moves
> it back into arch specific headers, partially reverting the even older
> commit 73a2d096fdf2 ("x86: remove all now-duplicate header files").
>
> It's not clear whether this ever made any difference, since at least
> glibc carries its own (correct) copy of both of these header files,
> so possibly no application has ever observed the definitions here.
>
> There are other UAPI interfaces that depend on __BITS_PER_LONG and
> that might suffer from the same problem on x32, but I have not tried to
> analyse them in enough detail to be sure. If anyone still cares about x32,
> that may be a useful thing to do.
>
> Fixes: f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32 builds")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This came out of the y2038 ipc syscall series but can be applied
> and backported independently.
> ---
>  arch/x86/include/uapi/asm/msgbuf.h | 29 +++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/shmbuf.h | 40 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
> index 809134c644a6..5f1604961e6d 100644
> --- a/arch/x86/include/uapi/asm/msgbuf.h
> +++ b/arch/x86/include/uapi/asm/msgbuf.h
> @@ -1 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __ASM_X64_MSGBUF_H
> +#define __ASM_X64_MSGBUF_H
> +
> +#if !defined(__x86_64__) || !defined(__ilp32__)
>  #include <asm-generic/msgbuf.h>
> +#else
> +/*
> + * The msqid64_ds structure for x86 architecture with x32 ABI.
> + *
> + * On x86-32 and x86-64 we can just use the generic definition, but
> + * x32 uses the same binary layout as x86_64, which is differnet
> + * from other 32-bit architectures.
> + */
> +
> +struct msqid64_ds {
> +       struct ipc64_perm msg_perm;
> +       __kernel_time_t msg_stime;      /* last msgsnd time */
> +       __kernel_time_t msg_rtime;      /* last msgrcv time */
> +       __kernel_time_t msg_ctime;      /* last change time */
> +       __kernel_ulong_t msg_cbytes;    /* current number of bytes on queue */
> +       __kernel_ulong_t msg_qnum;      /* number of messages in queue */
> +       __kernel_ulong_t msg_qbytes;    /* max number of bytes on queue */
> +       __kernel_pid_t msg_lspid;       /* pid of last msgsnd */
> +       __kernel_pid_t msg_lrpid;       /* last receive pid */
> +       __kernel_ulong_t __unused4;
> +       __kernel_ulong_t __unused5;
> +};
> +
> +#endif /* __ASM_GENERIC_MSGBUF_H */
> diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
> index 83c05fc2de38..cdd7eec878fa 100644
> --- a/arch/x86/include/uapi/asm/shmbuf.h
> +++ b/arch/x86/include/uapi/asm/shmbuf.h
> @@ -1 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __ASM_X86_SHMBUF_H
> +#define __ASM_X86_SHMBUF_H
> +
> +#if !defined(__x86_64__) || !defined(__ilp32__)
>  #include <asm-generic/shmbuf.h>
> +#else
> +/*
> + * The shmid64_ds structure for x86 architecture with x32 ABI.
> + *
> + * On x86-32 and x86-64 we can just use the generic definition, but
> + * x32 uses the same binary layout as x86_64, which is differnet
> + * from other 32-bit architectures.
> + */
> +
> +struct shmid64_ds {
> +       struct ipc64_perm       shm_perm;       /* operation perms */
> +       size_t                  shm_segsz;      /* size of segment (bytes) */
> +       __kernel_time_t         shm_atime;      /* last attach time */
> +       __kernel_time_t         shm_dtime;      /* last detach time */
> +       __kernel_time_t         shm_ctime;      /* last change time */
> +       __kernel_pid_t          shm_cpid;       /* pid of creator */
> +       __kernel_pid_t          shm_lpid;       /* pid of last operator */
> +       __kernel_ulong_t        shm_nattch;     /* no. of current attaches */
> +       __kernel_ulong_t        __unused4;
> +       __kernel_ulong_t        __unused5;
> +};
> +
> +struct shminfo64 {
> +       __kernel_ulong_t        shmmax;
> +       __kernel_ulong_t        shmmin;
> +       __kernel_ulong_t        shmmni;
> +       __kernel_ulong_t        shmseg;
> +       __kernel_ulong_t        shmall;
> +       __kernel_ulong_t        __unused1;
> +       __kernel_ulong_t        __unused2;
> +       __kernel_ulong_t        __unused3;
> +       __kernel_ulong_t        __unused4;
> +};
> +
> +#endif /* __ASM_X86_SHMBUF_H */
