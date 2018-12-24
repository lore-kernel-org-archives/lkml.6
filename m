Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D6FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B0721773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGjf+Msj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeLXFTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 00:19:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38634 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeLXFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 00:19:00 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so14077105ith.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 21:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTO+iFapKycw8LXxhWPSoaeNUpIXXF2j8h+GKpEFVlg=;
        b=VGjf+MsjIrlu9wL3ms3pflyDPI3wnRSqluS6yyZqFQRSUffaITrQlZZ+SKBzt+g316
         bIJYV05HA8UlBCMOqwYRJliEchNFFO2RKqW0syyXxMB4BKppBmfeyvTxG2oSKhewLkPk
         EvPy16xTFaX5M9kEQVFhIjZjeJeIeNVMA4Vgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTO+iFapKycw8LXxhWPSoaeNUpIXXF2j8h+GKpEFVlg=;
        b=Rt/2TxWLf1KUQ4aIDnlKyO8cM4D/V3dDhb7hks52ZOrKQMpZcwjxl+r39j53Fg8tIE
         KTSm6T/mAEd71blxq2V//4DSdYsUpySJuiM8vRuK4HS64CgTvdyH0IAZLl6CSDgojCfd
         xIb7kePuEjfn78+3BWAVt3VaPYlJCbMIo2XCyCmyInE12u6/4gAGoxF0vP1geHGnop8y
         BkCc1L2qM0vhbUau6JAchqyOwTwDA04B6W0PkilqOYqlcBiI/+A2iDO62Z+LUCFrRozd
         bakv5mEvZX1SVf7c5jgVo8dp8LqsBAZKnKLYEUCLkYdhayQyy6HgKHPDKaNuqmxibhih
         q66A==
X-Gm-Message-State: AJcUukdeC1Eht+XYUrjFHupyepT6FZjzjwaopZTlaZUp6jenDDrDqwyx
        DlR+A4fTU141k264aS0cl/RCo0s33sPJagCFfF0r1Q==
X-Google-Smtp-Source: ALg8bN586OyuKHkbmBRvB6xE1DNKrqznhgCVKWUsq1RgiPm+4ui0Eh6vPjjD+4xzILcNF86/30216aS06Ge1YXqHZ/k=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr7290173iti.166.1545628738904;
 Sun, 23 Dec 2018 21:18:58 -0800 (PST)
MIME-Version: 1.0
References: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org> <43N38M4cw7z9sNJ@ozlabs.org>
In-Reply-To: <43N38M4cw7z9sNJ@ozlabs.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 24 Dec 2018 10:48:50 +0530
Message-ID: <CALxhOnhfPbMBXcTP1eT3OTv7ZTQ4OKHOEJxq9coPX6Si39umqQ@mail.gmail.com>
Subject: Re: [v6,1/5] powerpc: add __NR_syscalls along with NR_syscalls
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 at 18:58, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
>
> On Mon, 2018-12-17 at 10:40:32 UTC, Firoz Khan wrote:
> > NR_syscalls macro holds the number of system call exist
> > in powerpc architecture. We have to change the value of
> > NR_syscalls, if we add or delete a system call.
> >
> > One of the patch in this patch series has a script which
> > will generate a uapi header based on syscall.tbl file.
> > The syscall.tbl file contains the number of system call
> > information. So we have two option to update NR_syscalls
> > value.
> >
> > 1. Update NR_syscalls in asm/unistd.h manually by count-
> >    ing the no.of system calls. No need to update NR_sys-
> >    calls until we either add a new system call or delete
> >    existing system call.
> >
> > 2. We can keep this feature in above mentioned script,
> >    that will count the number of syscalls and keep it in
> >    a generated file. In this case we don't need to expli-
> >    citly update NR_syscalls in asm/unistd.h file.
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with NR_syscalls asm/unistd.h. The macro __NR_syscalls
> > also added for making the name convention same across all
> > architecture. While __NR_syscalls isn't strictly part of
> > the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Series applied to powerpc next, thanks.

Thanks Micheal!

Firoz

>
> https://git.kernel.org/powerpc/c/8a19eeeab66dfdd7c67bc8e3048ac0
>
> cheers
