Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66154C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3242173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE5K04Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGXMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:12:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44384 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:12:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so1166993lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0I4TjkmJopDC8x5iojCng3SWoajxog3ipDWpHmVrWM=;
        b=jE5K04XzmYAx9iKMvPlr5okEnuqaRjlhptUBoj2+YL9i3t1X/Co+7FJ1rKxIbocZBP
         kcVzQh4eQfBoBjknkaJveo8cQZszRDsCiBt/ub68SXvscqhGCld9hMHuslU+sC6CA03i
         dq53UB2ENxbaF+eGa7v1xRlpG9jAxen2zS24svaayTCvgZEfFAYD7V6cjeDvOnnQVdED
         RRp/naeZqDl5TAf0nhJRIq/7Z4bpnAj7+S/Gt4NwaKUKVc71GSH6AaDzfjXxMVx7GlCH
         SWpBlY9wzWtCbT2wXnKuW8jiB90sjsqyOn8WaXy6L0aYQE0MgfbKQDKmdpw8F9H5def5
         LkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0I4TjkmJopDC8x5iojCng3SWoajxog3ipDWpHmVrWM=;
        b=lvAog8bt9FSciwBl4pEQrQsUuamATL7RzY/ZZsZNO8vEZ7ML9cELtNQDKPVqvkudfR
         OEKupWoOCEMMFLnAIO1pP7kPyP89soHDyKu3fLhRIqCgHON3PAWA9y7VBYiVoWGjWjL/
         6SvGT79D5gl8YBhWbRa8IzP/NnDqAl6/ZQzbMrLvXTfZH6a6I9Y6ki1FYqh97CMcMMpU
         4lxRtYlf0PeAgbk87SA0qH3DPjsH/GflV97M1nRi2oWfQDwD13biMa/c0GBnIztGlVck
         qr23Rgr/63baJL+aJm0wiojeZtyGAl1wPpBlIeL1Pog8PI3TM0BJ2auO2J2GTye2cjbG
         V2IQ==
X-Gm-Message-State: AHQUAuaO9V5/xUuADrQkbM/2ZCCk2GJ5bE28X+0QmFFb53LmnOd0w+eV
        wDi3JGXpcdIE7s8NdMiiB7NzrW7Q+AOQoYCreBE=
X-Google-Smtp-Source: AHgI3IZoPpr978ql1erFzwlBd9LNy7ON0bcx7r0p47eR1YYpsQLkgM58o1wFKzb9lxQu5dcfE9iyvDzWTwKy1r4tUrU=
X-Received: by 2002:a19:194e:: with SMTP id 75mr11549214lfz.114.1549581163593;
 Thu, 07 Feb 2019 15:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20190207225531.19219-1-alistair.francis@wdc.com> <CAEn-LTrQtL3+MQSDKQmBBx4PJGox4r5yEyHxh35VVd_D4dg0Dg@mail.gmail.com>
In-Reply-To: <CAEn-LTrQtL3+MQSDKQmBBx4PJGox4r5yEyHxh35VVd_D4dg0Dg@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 7 Feb 2019 15:12:02 -0800
Message-ID: <CAKmqyKPj5fCQR_sVWDkkMmo28=GEpJ71VcvA+nZb0YzTd0J+Ug@mail.gmail.com>
Subject: Re: [PATCH] riscv: Partially revert "Remove stat64 family from
 default syscall set"
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        zongbox@gmail.com
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 3:04 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 11:56 PM Alistair Francis
> <Alistair.Francis@wdc.com> wrote:
> >
> > To fix systemd/sysVinit crashes enable __ARCH_WANT_STAT64.
> >
> > systemd failed to start with this error for 32-bit RISC-V:
> > [    2.833864] Run /sbin/init as init process
> > /sbin/init: error while loading shared libraries: libsystemd-shared-239.so: cannot stat shared object: Error 38
> > [    2.933593] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> > [    2.934120] CPU: 0 PID: 1 Comm: init Not tainted 5.0.0-rc4-yoctodev-standard #1
> > [    2.934589] Call Trace:
> > [    2.934919] [<c0048a30>] walk_stackframe+0x0/0xa0
> > [    2.935243] [<c0048c14>] show_stack+0x28/0x32
> > [    2.935518] [<c05fa418>] dump_stack+0x68/0x88
> > [    2.935788] [<c004de48>] panic+0xf0/0x252
> > [    2.936041] [<c0051780>] do_exit+0x7de/0x7fc
> > [    2.936387] [<c00517f4>] do_group_exit+0x2a/0x82
> > [    2.936674] [<c005185e>] __wake_up_parent+0x0/0x22
> > [    2.936982] [<c00475fa>] ret_from_syscall+0x0/0xe
> > [    2.937673] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00 ]---
> >
> > sysVinit had a similar problem as well. By enabling __ARCH_WANT_STAT64
> > for 32-bit RISC-V the problem disapears and 32-bit RISC-V is able to
> > boot.
>
> Hi,
>
> This is expected change for riscv32. More details here:
> http://lists.infradead.org/pipermail/linux-riscv/2018-November/002062.html

Thanks for the explanation.

+ Zong

Do you know what the statx implementation is in the 32-bit RISC-V
glibc submission?

Alistair

>
> david
>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > This was tested with this fork of glibc to enable 32-bit RISC-V support:
> > https://github.com/riscv/riscv-glibc/tree/riscv-glibc-2.29
> > commit: 04fdd476160a55792a75375ba2bf56c761f811c2
> >
> > I'm not sure if this is a glibc problem or a kernel problem, but this
> > commit caused the breakage between the 4.19 and 4.20 kernel so I'm
> > sending out a patch. Let me know your thoughts
> >
> > arch/riscv/include/uapi/asm/unistd.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> > index 1f3bd3ebbb0d..031b7d78e11c 100644
> > --- a/arch/riscv/include/uapi/asm/unistd.h
> > +++ b/arch/riscv/include/uapi/asm/unistd.h
> > @@ -20,6 +20,9 @@
> >  #endif /* __LP64__ */
> >
> >  #include <asm-generic/unistd.h>
> > +#if __BITS_PER_LONG == 32
> > +#define __ARCH_WANT_STAT64
> > +#endif
> >
> >  /*
> >   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
