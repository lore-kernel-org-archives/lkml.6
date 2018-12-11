Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFC7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CB12054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544506519;
	bh=g3KDrDiAaULb1z7soFbb46MmIwpSDGWDocdcY4xEPhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tjx9tawk2jN2TEct2Z783XznDlbB6/tV1Nl0Algx3JHZaETo/pq83fnKnir6RMbZG
	 n7p4mdNvXAS4Bt7/NHxY8EURzzTHXia/SfRtuFU6Nfnz+cpfOIcefG91x0M0IusP/x
	 f06hV8NcYjPCyXKHg975RSjrbJWXySFUKsnrv2Wo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CB12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeLKFfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbeLKFfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:35:17 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F147220880
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544506516;
        bh=g3KDrDiAaULb1z7soFbb46MmIwpSDGWDocdcY4xEPhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1B7Ta/D2o/pnGRhJUSDH2ZvGgAn4FLTcQxWIEXVfPCxgrVL1tQyho5jrYp/OMp2Zn
         0pNkt8se8+tkjVPsxbmBCq0uWtnDlMA9pOUkoqmt4wZT1QPFvKQf75yfA46Cmg1byh
         Lq0tOpoQblwAH1w8bF9JlWporb9OPYe73R8AisZg=
Received: by mail-wm1-f51.google.com with SMTP id a18so839529wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 21:35:15 -0800 (PST)
X-Gm-Message-State: AA+aEWbRJK9ZpYNUhncGzL99462EMqlJWnTF/bbjbWlCtYYZQoHNgX85
        yeklFUYGwPb3LI3mfaQppIf2vPz3Y/hXNbiM0I+wJQ==
X-Google-Smtp-Source: AFSGD/X5orrRJ4DddOrDsfl4pAUhKlGkb1Ln/4cYs4pmZYAjse6STAFium3e7+sqmPmjG7MvyyYWYeZaLAxqtDXxNNE=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr868410wmh.83.1544506514298;
 Mon, 10 Dec 2018 21:35:14 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAMe9rOp0m5sn59AsD2F2i2Ad2tb7ufPU1mMg-vUOfh+TnGMeaw@mail.gmail.com>
In-Reply-To: <CAMe9rOp0m5sn59AsD2F2i2Ad2tb7ufPU1mMg-vUOfh+TnGMeaw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Dec 2018 21:35:02 -0800
X-Gmail-Original-Message-ID: <CALCETrU5xw61=me1YcTO3VPzjNEZahMPpi-20-oiSGs+CHcj4g@mail.gmail.com>
Message-ID: <CALCETrU5xw61=me1YcTO3VPzjNEZahMPpi-20-oiSGs+CHcj4g@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     "H. J. Lu" <hjl.tools@gmail.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Rich Felker <dalias@libc.org>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:15 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Hi all-
> >
> > I'm seriously considering sending a patch to remove x32 support from
> > upstream Linux.  Here are some problems with it:
> >
> > 1. It's not entirely clear that it has users.  As far as I know, it's
> > supported on Gentoo and Debian, and the Debian popcon graph for x32
> > has been falling off dramatically.  I don't think that any enterprise
> > distro has ever supported x32.
>
> I have been posting x32 GCC results for years:
>
> https://gcc.gnu.org/ml/gcc-testresults/2018-12/msg01358.html

Right.  My question wasn't whether x32 had developers -- it was
whether it had users.  If the only users are a small handful of people
who keep the toolchain and working and some people who benchmark it,
then I think the case for keeping it in upstream Linux is a bit weak.

>
> > 2. The way that system calls work is very strange.  Most syscalls on
> > x32 enter through their *native* (i.e. not COMPAT_SYSCALL_DEFINE)
> > entry point, and this is intentional.  For example, adjtimex() uses
> > the native entry, not the compat entry, because x32's struct timex
> > matches the x86_64 layout.  But a handful of syscalls have separate
>
> This becomes less an issue with 64-bit time_t.
>
> > entry points -- these are the syscalls starting at 512.  These enter
> > throuh the COMPAT_SYSCALL_DEFINE entry points.
> >
> > The x32 syscalls that are *not* in the 512 range violate all semblance
> > of kernel syscall convention.  In the syscall handlers,
> > in_compat_syscall() returns true, but the COMPAT_SYSCALL_DEFINE entry
> > is not invoked.   This is nutty and risks breaking things when people
> > refactor their syscall implementations.  And no one tests these
> > things.  Similarly, if someone calls any of the syscalls below 512 but
> > sets bit 31 in RAX, then the native entry will be called with
> > in_compat_set().
> >
> > Conversely, if you call a syscall in the 512 range with bit 31
> > *clear*, then the compat entry is set with in_compat_syscall()
> > *clear*.  This is also nutty.
>
> This is to share syscalls between LP64 and ILP32 (x32) in x86-64 kernel.
>

I tried to understand what's going on.  As far as I can tell, most of
the magic is the fact that __kernel_long_t and __kernel_ulong_t are
64-bit as seen by x32 user code.  This means that a decent number of
uapi structures are the same on x32 and x86_64.  Syscalls that only
use structures like this should route to the x86_64 entry points.  But
the implementation is still highly dubious -- in_compat_syscall() will
be *true* in such system calls, which means that, if someone changes:

SYSCALL_DEFINE1(some_func, struct some_struct __user *, ptr)
{
  /* x32 goes here, but it's entirely non-obvious unless you read the
x86 syscall table */
  native impl;
}

COMPAT_SYSCALL_DEFINE1(some_func, struct compat_some_struct __user *, ptr)
{
  compat impl;
}

to the Obviously Equivalent (tm):

SYSCALL_DEFINE1(some_func, struct some_struct __user *, ptr)
{
  struct some_struct kernel_val;
  if (in_compat_syscall()) {
    get_compat_some_struct(&kernel_val, ptr);
  } else {
    copy_from_user(&kernel_val, ptr, sizeof(struct some_struct));
  }
  do the work;
}

then x32 breaks.

And I don't even know how x32 is supposed to support some hypothetical
syscall like this:

long sys_nasty(struct adjtimex *a, struct iovec *b);

where one argument has x32 and x86_64 matching but the other has x32
and x86_32 matching.

This whole thing seems extremely fragile.
