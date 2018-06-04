Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1747117-1528124719-5-9324141080201685237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528124719; b=kwGgfx97W/wF4KHi2mSgdUZgNPrd+X0OZ9SX0wn/XgIkyiQnhq
    dGKeHhdvp94rHPuCPn1cD4L2OzUswWsen6x3tJiQ2RG8tI2cLlt9LOdyv0Almnvj
    oCLLPt6I+bCvVrhKLJxx65MiuKrbjswf3MYminEgtq20DuU66l3+HfDWvB0BylnY
    p0lbT5O5jVa/D999RNEeRlBpw8vnyjBT5IGJ0QMxKTMIbYOWwnJZ3nPjCjYX+tEG
    +/nQSjO/hFOCnWo+LPgc4cTKmRNNfDmHMKfRF71FCFpyYEUkMGsYc1Tv4AM/ynjK
    /JuBx88etzIuTmdsjg0ikItvmXDwvehFONoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528124719; bh=R6DwJiQ1DWWzJf0OWhO0mVQXziOUpzVoGDOq/ALtg/
    w=; b=lm+Fk8lP+HMm2t8E68klNgNgBB0n7cmhUOybskNVmLg2FgxjeIAZr/8F+E
    tCenOm0fxXGipX6XJ95f1P3gE6g7Lpw6+zjuGHXgoXD7Za8+n9xOqyepWvdnwTTY
    P08Itk5cUCxHOAcQQTHhWCiOMNl66e9OjfPvdBKPazvdzLs1Ee8B5rXP+rqx5B49
    /BhYxc9HqwU1jmrVV/mgSAFdlrYHxJrn7c/OhuNN9sVAM0i7xyJjmFoOmHFP5By4
    oZf7JfNpW6SXMAsv/2T1Gn2ncTGo3hi/RyUcRHONGtUrM2R6Iy38ie4tEcV1FzIv
    WBwUUSyUKBz7PNpyeLWL+FP4aR7w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=YeQhrz+q
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=fikbbWOg;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=YeQhrz+q
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=fikbbWOg;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPKF9BSeV5XYOl1S5Qgo1R1kOziwUcFyhnJukJfsuXzv6mdWWTlLfLB7qcheoxM3HZ3VBcPCJb9WF7gn8paHj36JbyVGtq166gsZb+TgeOCLxs3xqmUE
    u5ENYilS+EIB9XMIIZD3XOp2nIqcFgol2LiZe88UT2X+pI0OAc2lCKENfH/653wBqUWs3xdkjv2iuWXReXa1G9kIGZduu/QgKxwztSNooBdqt17H2uzM7k9s
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=UuJk-RVmY5M8E13IMfUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeFDPFQ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:05:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42178 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbeFDPFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:05:12 -0400
X-Google-Smtp-Source: ADUXVKJfoezpsdV4nWLBx7hzrFavejK++C93zKKbXPtCAJl2tp3eRE66wE2BKwZ7LbLILiEMRgs3DwHjlxPL/qxzNGs=
MIME-Version: 1.0
In-Reply-To: <152720686035.9073.17015443936296474540.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720686035.9073.17015443936296474540.stgit@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Jun 2018 17:05:09 +0200
X-Google-Sender-Auth: zhBh2907v2XYGvg-zYgwArgu6Qw
Message-ID: <CAK8P3a1QMrvMqLdg6OxKDSXz2wEceVMJ2-S9tJZETzk5oFcTCw@mail.gmail.com>
Subject: Re: [PATCH 21/32] VFS: Implement fsmount() to effect a pre-configured
 mount [ver #8]
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 25, 2018 at 2:07 AM, David Howells <dhowells@redhat.com> wrote:
> Provide a system call by which a filesystem opened with fsopen() and
> configured by a series of writes can be mounted:
>
>         int ret = fsmount(int fsfd, int dfd, const char *path,
>                           unsigned int at_flags, unsigned int flags);
>

> +/*
> + * Create a kernel mount representation for a new, prepared superblock
> + * (specified by fs_fd) and attach to an O_PATH-class file descriptor.
> + */
> +SYSCALL_DEFINE5(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags,
> +               void *, spare_4, void *, spare_5)

> +++ b/include/linux/syscalls.h
> @@ -898,6 +898,8 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
>                           unsigned mask, struct statx __user *buffer);
>  asmlinkage long sys_fsopen(const char *fs_name, unsigned int flags,
>                            void *reserved3, void *reserved4, void *reserved5);
> +asmlinkage long sys_fsmount(int fsfd, int dfd, const char *path, unsigned int at_flags,
> +                           unsigned int flags);
>

The prototype in the header doesn't match the one in the implementation,
which should cause a compile-time error, at least if syscalls.h is included
in namespace.c

Do you have a particular use case in mind for the spare_4/spare_5 arguments?
If not, we can probably skip them. If we end up needing them after all, we can
always add a new syscall entry point, or use one of the flag bits to
decide whether
the additional arguments are valid or not.

> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -435,3 +435,4 @@ COND_SYSCALL(setuid16);
>
>  /* fd-based mount */
>  COND_SYSCALL(sys_fsopen);
> +COND_SYSCALL(sys_fsmount);

This should only be needed if the syscall is optional, which it doesn't
seem to be (same for the other ones here).

       Arnd
