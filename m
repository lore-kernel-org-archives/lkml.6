Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB3FC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E212081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqX2BkXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E212081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeKAXsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:48:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35715 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKAXsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:48:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id v198-v6so14011583oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ROJBiTCOrrNWEaB2yd3gM8xcc+v3yybExje+8J50qM=;
        b=nqX2BkXtgEUYa0Cln3myfH48H27mLXYxJNaQsurlgHK+hIeFH0GMcFgs5ET89VjSpp
         89a+EUPv19mHogehO6ixJvOX4jU/r6A1GhzaSup+fF0aGp37ZfYZVpjil5zCVAk/9RSa
         jA1zhu8+yo/eTYC9vUMOn+jAN+6mfGrbZnkecYcFNbCLCGAhtH0fRJGy2dHf/QwUcJBn
         gAlBBOJ9bDVNJXgS8Kp7aACzRJjVwEysApnNowdcF+K/hRQyMnbsJaEWDZckk1zhR7Cr
         KQv9jE+2P2J1HEE7MvaS0tM3h6hvyRAPbWPQZOyqv94vpvvUADYnrhQ+lB+qLCMJu7w1
         YI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ROJBiTCOrrNWEaB2yd3gM8xcc+v3yybExje+8J50qM=;
        b=mNhYK9GtXMELsu6IWufSMNx1KKEon3wGgMnHSvZBDdVe0jMLKTwO6Blebr3rL/L8zP
         290WUYHrKLzHcMkURHsrqMp7/b2lyAf6P1xsqSOtZJHDcxDchDKnKR1JKiHIOKyYZ/w/
         N0TlYbYAfkrqa61JjcxNh2ZFh0VTyUJA99tPtQHq9NLRf4pRzXxEKB87B4fa2IQ34vo0
         8hD315VIvlq07up9CTO40rNb2Xb/24LMuclpDGJ/Jjl6VekmrvXdt2xwkHMD1jM9UlY6
         nqGbKhZWh/+GX1TYFCapaifgFFQxNTftYAaszxCDAuT340vIbXzWkQXM2Dq6eZi+3Yzt
         /VPQ==
X-Gm-Message-State: AGRZ1gLoDFiJCCEDQDa9WYEygf0RZ0eDjv3AHRRZz8w0Y9VlF4DDNNWI
        gvHYntn0j5hldkTv7njEs3+r+0bZMBzHop6xTUwFsw==
X-Google-Smtp-Source: AJdET5eqVBCadnx4UqA2bD8RZOaKCV6BFE7HwuNbtINOgi+4vFPsxFgUb6wsbHezz2Ir/ZCCcRjFnWNA0ZbeUv/c/LQ=
X-Received: by 2002:aca:c045:: with SMTP id q66-v6mr4640553oif.22.1541083489490;
 Thu, 01 Nov 2018 07:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181010161430.11633-1-laurent@vivier.eu> <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
 <1541041159.4632.6.camel@HansenPartnership.com> <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
 <1541081413.2853.6.camel@HansenPartnership.com>
In-Reply-To: <1541081413.2853.6.camel@HansenPartnership.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Nov 2018 15:44:23 +0100
Message-ID: <CAG48ez2vyk0ki1AMv0G_-3m2Pq8gAkO2yjVjs=3CaJNBP0JChA@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:10 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2018-11-01 at 04:51 +0100, Jann Horn wrote:
> > On Thu, Nov 1, 2018 at 3:59 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
> > > > Hi,
> > > >
> > > > Any comment on this last version?
> > > >
> > > > Any chance to be merged?
> > >
> > > I've got a use case for this:  I went to one of the Graphene talks
> > > in Edinburgh and it struck me that we seem to keep reinventing the
> > > type of sandboxing that qemu-user already does.  However if you
> > > want to do an x86 on x86 sandbox, you can't currently use the
> > > binfmt_misc mechanism because that has you running *every* binary
> > > on the system emulated. Doing it per user namespace fixes this
> > > problem and allows us to at least cut down on all the pointless
> > > duplication.
> >
> > Waaaaaait. What? qemu-user does not do "sandboxing". qemu-user makes
> > your code slower and *LESS* secure. As far as I know, qemu-user is
> > only intended for purposes like development and testing.
>
> Sandboxing is about protecting the cloud service provider (and other
> tenants) from horizontal attack by reducing calls to the shared kernel.
>  I think it's pretty indisputable that full emulation is an effective
> sandbox in that regard.
>
> We can argue for about bugginess vs completeness, but technologically
> qemu-user already has most of the system calls, which seems to be a
> significant problem with other sandboxes.  I also can't dispute it's
> slower, but that's a tradeoff for people to make.

I'm pretty sure you don't understand how qemu-user works.

When the emulated code makes a syscall, QEMU just forwards the syscall
to the native kernel.

QEMU doesn't even prevent you from accessing the address space used by
the emulation logic.

qemu-user is not for sandboxing. qemu-user is not for security.
qemu-user is for running binaries from architecture A on architecture
B, with as much direct access to the kernel's syscall surface as
possible.


An example:

$ cat blah.c
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
int main(void) {
  open("/foo/bar/blah", O_RDONLY);
  char c;
  printf("ptr is %p\n", &c);
  read(1337, &c, 1);
  *(volatile char *)0x13371338;
}
$ aarch64-linux-gnu-gcc -static -o blah blah.c && strace -f qemu-aarch64 ./blah
[...]
[pid 14181] openat(AT_FDCWD, "/foo/bar/blah", O_RDONLY) = -1 ENOENT
(No such file or directory)
[pid 14181] fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 93), ...}) = 0
[pid 14181] write(1, "ptr is 0x40007fff2f\n", 20ptr is 0x40007fff2f
) = 20
[pid 14181] read(1337, 0x40007fff2f, 1) = -1 EBADF (Bad file descriptor)
[pid 14181] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR,
si_addr=0x13371338} ---
[...]
