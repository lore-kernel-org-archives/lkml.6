Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613A8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0D2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcWCXRhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED0D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeKGUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:15:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46262 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:15:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id q5so14298632otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5d2sZmArluhobQqxaA/yYKQnmCmIhPyJnd73IUvKZvs=;
        b=qcWCXRhNFqra5eSKHEGVNR76q5Mk5vIjjPXZ8J2XvfNfq0TSMVqhabJNJGtfbTEIJt
         IWn7WHYXayi11Nq8N/UNFgX5TBdzemN3pYiNhSPn5ILYFnb6U9BagkLZMC9hWLEPvOzf
         prhxde3xSvytNcppJ4iOGREmKmPOoX1wU9G34ORrCV1F8mgsmhg5CwTCOtW4+jvRxZqq
         fmOuPGBz9nIBPkGDk/c5Y4IDQOS4B6jvNrwpqe/OQL1bA8WMtDa31K66ehfzSa4IzWMA
         OXIZue3b8IkxXRyfpvYPvtbswlVzujwk/I8zr5Gcv8aJnUph4RI44vadEkQlOxjBsLc3
         AfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5d2sZmArluhobQqxaA/yYKQnmCmIhPyJnd73IUvKZvs=;
        b=J6dH+6BW3oAUY52VLyujPAFA1964CyUGCpC9c+MV6ewtSTYVCMEx02gsXTvGB49PXj
         APmSn89A07GxlnGwFriRHffc0fuvCcU9BpSPqpkoM5KIYrbpkxhacuNQ/ZeF7aWemqny
         Zq3XbTKvfRPlaSAr8deAi5FPCUUrnCHybQFy4N5s5bMR/vMMEELQQDCWd1xfgIttWVKQ
         dlH0Q3MwknxfF+Oydsbq/a12W5qGmp2nTfHldnBeppUB5qBuVZXQvbVmU8OaeYwtQhL6
         o2ez5Q29dB0plvPwiHSPMegzQrKNSZYnRuAtZTlO0dkmqyFl4858ppFABNREWotoWp9k
         pmgw==
X-Gm-Message-State: AGRZ1gLIwT/JjeFsEWTD8JRN45M01UJptAIx+mR/8nHY2BmHw7hqC59N
        +H24jTOAUnbzGNowv/UHrjxms4sjn2iofSahASk=
X-Google-Smtp-Source: AJdET5c038ooSHvbDaMKGdwg7KTWkzu82ulEFj6Cxzqax0F3IAgtHQYDI8JaMoGi0jhxzCs6Kji0VL0DBu0pxwCSnqc=
X-Received: by 2002:a9d:6315:: with SMTP id q21mr782901otk.174.1541587565520;
 Wed, 07 Nov 2018 02:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
 <CAHC9VhSaGo0BmX5AsTcnppiVz2Lz8BFkjRA0jg_uuPix3Ziiog@mail.gmail.com> <CAEn-LTqQgQkA1XyihEg0MpADLPQADf3Ej2noUp29UtbcEaf0RA@mail.gmail.com>
In-Reply-To: <CAEn-LTqQgQkA1XyihEg0MpADLPQADf3Ej2noUp29UtbcEaf0RA@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Wed, 7 Nov 2018 11:45:53 +0100
Message-ID: <CAEn-LTqizbzTkbE3vvdxKsb-cHOWbRStOZaNfNo5sNuC5LhxMQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: add audit support
To:     Paul Moore <paul@paul-moore.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:25 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> On Tue, Nov 6, 2018 at 9:06 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Oct 29, 2018 at 6:49 AM David Abdurachmanov
> > <david.abdurachmanov@gmail.com> wrote:
> > > This patchset adds system call audit support on riscv (riscv32 &
> > > riscv64).
> > >
> > > The pachset was prepared on top of v4.19 tag.
> > >
> > > audit-userspace changes were submitted. See:
> > > https://github.com/linux-audit/audit-userspace/pull/73
> > >
> > > Tested the following manually:
> > > - auditctl (checked several different example rules from internet)
> > > - aulast
> > > - aulastlog
> > > - ausearch
> > > - ausyscall
> > > - aureport
> > > - autrace (compared some syscalls to strace: order and return
> > >   value/input arguments seem to be correct)
> > > - /proc/self/loginuid (required by DNF [package manager])
> > >
> > > I looked into audit-testsuite and with some adjustments results are:
> > >
> > > Failed 4/14 test programs. 19/88 subtests failed.
> >
> > I realize that the test suite failures are likely not due to your
> > code, but rather shortcomings in the test suite itself, but I think it
> > is important to resolve these problems before we commit the kernel
> > changes.

I did some extra work this evening (well, after midnight) and I am passing
all bits I would expect to pass.

Test Summary Report
-------------------
syscall_socketcall/test (Wstat: 0 Tests: 3 Failed: 3)
  Failed tests:  1-3
Files=3D14, Tests=3D88, 107 wallclock secs ( 1.07 usr  0.38 sys + 58.77
cusr 19.32 csys =3D 79.54 CPU)
Result: FAIL
Failed 1/14 test programs. 3/88 subtests failed.

The only failing test now is syscall_socketcall, which is not supported on
riscv and others.

From man page:

On a some architectures-for example, x86-64 and ARM=E2=80=94there is no
       socketcall() system call; instead socket(2), accept(2), bind(2), and
       so on really are implemented as separate system calls.

Then I redone syscall_socketcall test to fit new 64-bit arches. It still
mostly checks the same thing, but uses different syscall. Instead of
socketcall(SYS_CONNECT, ..) we check for connect(..). This will not
generate SOCKETCALL record, thus instead check for SYSCALL
record where syscall=3Dconnect.

All is here: https://github.com/davidlt/audit-testsuite/commits/riscv64

With that:

Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  Fedora

exec_execve/test ......... ok
exec_name/test ........... ok
file_create/test ......... ok
file_delete/test ......... ok
file_rename/test ......... ok
filter_exclude/test ...... ok
filter_sessionid/test .... ok
login_tty/test ........... ok
lost_reset/test .......... ok
netfilter_pkt/test ....... ok
syscalls_file/test ....... ok
syscall_module/test ...... ok
syscall_socketcall/test .. ok
user_msg/test ............ ok
All tests successful.
Files=3D14, Tests=3D88, 123 wallclock secs ( 1.26 usr  0.59 sys + 70.85
cusr 22.60 csys =3D 95.30 CPU)
Result: PASS

Same audit kernel patch and libaudit, nothing changed here.

Hopefully this allows to move forward as I would love to have
audit & seccomp in the next kernel version (and thus Fedora).

Thanks,
david
