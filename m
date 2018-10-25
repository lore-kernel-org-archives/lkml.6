Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC42075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ePHL/mmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACC42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeJZFgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:36:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45548 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJZFgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:36:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id n5-v6so6943820wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDl9tuLjrc5aO/xWHsA1eJ2QMDOIODaJdJyMWgsmf5Y=;
        b=ePHL/mmuAgPXJgnbLsyesnGMr6AErgUyRrxtmuq70KtYnTzTq1w/5JW2md6UlqMxvW
         RWe/nTaDfx++fhqFJKRBH8cVwnZuf/Y6pgflh2o1zdSs5W+bColy0TAZdLe+cApl2ApP
         +lWSyc/o6TLAY4WQhtXNHNDFVI6pU3apg1GilJRxCU5b/Umh5flvA8b3+Exc8PNf03Xe
         ws/WPDXO8apJqmpKhXP7upNvKVKEgwNBxrJ8awTatqG7rAZaiZVvUxQNm7fNxV4itB2C
         oiNrVX092EjZ0/5GLqsgq1HA/sQQuBQ+4KXtEL5IReWMVMCvWp7qVqrie/sH0KwZhP+t
         NH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDl9tuLjrc5aO/xWHsA1eJ2QMDOIODaJdJyMWgsmf5Y=;
        b=LTWjSo+yuIgSKKgZ01f2x6EUbTMWiAq7g8AHxTKRpHhSq3r7PAKC4ooyzZPfyAL5at
         RlNaFD0/6aQkM7XhclnhklMqmD1j0pI4sDHkooJNl6nv3fNxzFmRfhEQvnevMY9FG0Pr
         WoW3zGLIyO3Ohfq2i/fNnp9cx5vfUx+o+wiEIBlKiC5rCazyVoN6tPMOYitg0SJqiM2B
         JjZIJM96KCpUaHpR/pOi+aJP2BmRZ9YC/9dDUwihEXHe9rxopjegWJ7MvOCiDNk3a7xW
         aibN7dt1lA0N3YNwDE4k0pG4DxKJZ3FRjqFkEDupnrTDreajUACH9fw3mK55NB5av8wD
         Q0ew==
X-Gm-Message-State: AGRZ1gJi965r52PLkNY6u4z2hwnd1axOAao34npwCXAMYKN1QkjKVv2T
        LSkoUkLs2Js5LVLcvKHoJk7GDpjuejPr81I9zEhghQ==
X-Google-Smtp-Source: AJdET5cFYw+O9EtSYg1VYD312vAgeMKx1dg7ibljP+sGxhCdIiBzlnHdCDbbgxVVu/UNtVDdIjOeNkZmB12a9AfR2v8=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr3507907wrb.283.1540501351994;
 Thu, 25 Oct 2018 14:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-3-palmer@sifive.com>
 <CAGXu5jJ7gmVXZE+iksW99c6bHEV2rSOG+boQDRGmMSDa9HOh_A@mail.gmail.com>
In-Reply-To: <CAGXu5jJ7gmVXZE+iksW99c6bHEV2rSOG+boQDRGmMSDa9HOh_A@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 25 Oct 2018 14:02:20 -0700
Message-ID: <CALCETrUSvugnh1JiLgn49c4_dw6F8bXiO52jdqiAKEn-CgzoXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
To:     Kees Cook <keescook@chromium.org>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, Will Drewry <wad@chromium.org>,
        wesley@sifive.com, David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>,
        linux-audit@redhat.com, david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 24, 2018 at 1:40 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> > From: "Wesley W. Terpstra" <wesley@sifive.com>
> >
> > This is a fairly straight-forward implementation of seccomp for RISC-V
> > systems.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  arch/riscv/Kconfig                   | 18 ++++++++++++++++++
> >  arch/riscv/include/asm/seccomp.h     | 10 ++++++++++
> >  arch/riscv/include/asm/syscall.h     |  6 ++++++
> >  arch/riscv/include/asm/thread_info.h |  1 +
> >  include/uapi/linux/audit.h           |  1 +
> >  5 files changed, 36 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/seccomp.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index a344980287a5..28abe47602a1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -28,6 +28,7 @@ config RISCV
> >         select GENERIC_STRNLEN_USER
> >         select GENERIC_SMP_IDLE_THREAD
> >         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
> > +       select HAVE_ARCH_SECCOMP_FILTER
>
> I think this patch is missing most of the actual seccomp glue?
>
> config HAVE_ARCH_SECCOMP_FILTER
>         bool
>         help
>           An arch should select this symbol if it provides all of these things:
>           - syscall_get_arch()
>           - syscall_get_arguments()
>           - syscall_rollback()
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
>           - secure_computing is called from a ptrace_event()-safe context
>           - secure_computing return value is checked and a return value of -1
>             results in the system call being skipped immediately.
>           - seccomp syscall wired up
>
> I only see syscall_get_arch(). Nothing is using TIF_SECCOMP (I'd
> expect a masked check in entry.S -- it seems like tracepoints are
> getting missed too? I see it handled in ptrace.c but not checked in
> entry.S?) There's no checking for seccomp in ptrace.c, etc.

Hi RISC-V people:

I strongly, strongly suggest that you rewrite your asm to work the way
that x86's does: have a function called prepare_exit_to_usermode() and
make it work more or less like x86's.  Doing all the exit work in asm
like you are is just setting you up for a world of pain.

--Andy
