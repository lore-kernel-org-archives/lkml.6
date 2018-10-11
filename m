Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76416C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D67220841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP3Wf0Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D67220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeJKNkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:40:10 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41684 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeJKNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:40:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id 135-v6so3149773ywo.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IAGnemiCYDs+EjrC0YpT7FA/BVh+qvrJekxWsHwIaQ=;
        b=RP3Wf0TeIWRjOSZJfT0cvxky3R9FS4WTtPSPmyQBTrM0/XpFl2wEk1ka5RXs6fuv4y
         KrQbEk3545xxw7xu0ngBtUfIZNq9A/PF1U90PQxS+4i8sYWKB424OP4QtwaqrrrcmAJt
         14B78AOw95miiiZksGezdM03DixhRTNOPniEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IAGnemiCYDs+EjrC0YpT7FA/BVh+qvrJekxWsHwIaQ=;
        b=MDcsHiVCNQaXhOx5IRwsJgZZblieVoomXpWE+k2ZZg+Z1CxcexHWYgTLEJFWQjUyME
         ky7IyCAhC4X/0SwFCgH/KuD5FdxWy4EcDPhCXBfe8CDXhE87SrldSdEW44OwibPhu3Av
         LPS3RlqXbb11YRbOKkpz4VUJUWkOfEHh9vQR0OCUrK8uCP5KscYmEwSqzYiYuhPvxink
         VJ+SHaAS6/a8NyonR3LfOC5V7jr2p3dV1kr8HhKswFaJq0h/daMj25RwO8yN+6p+6ZBk
         PSoqa+i/PunHj4K0diyNk0EXVsZrsOZdNc6enDhi5llbI6vSVFY4VYlxvVloR0PAuw/6
         HTlQ==
X-Gm-Message-State: ABuFfoiXDC9KGQJpAsXwVuJCZfKJJGg5W35jaYFPz2F5ustQXDduTedS
        dQT7yMzJH9OdwvUAaIJMvCSWMOs+mXClpuyo3R6sHw==
X-Google-Smtp-Source: ACcGV620OataGhheFj+qU6sEBXkHGNVoTRKjIxkhGAJZawWGGqyXLAX1TSuL0Q+k4M3yIMz8cwanuj5Hi5VR2FclWLA=
X-Received: by 2002:a81:9849:: with SMTP id p70-v6mr103220ywg.175.1539238464979;
 Wed, 10 Oct 2018 23:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org> <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
In-Reply-To: <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 11 Oct 2018 11:44:13 +0530
Message-ID: <CALxhOnhcP==cGqMQvtrZ9GiNWGB69hz4G0n0kocBtd9NpDthCg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file generation
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo fixed!

On Thu, 11 Oct 2018 at 11:40, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Hi Helge,
>
> On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:
> >
> > * Firoz Khan <firoz.khan@linaro.org>:
> > > System call table generation script must be run to generate
> > > unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> > > will have changes which will invokes the script.
> > >
> > > This patch will generate unistd_32/64.h and syscall_table_
> > > 32/64/c32.h files by the syscall table generation script
> > > invoked by arch/parisc/Makefile and the generated files against
> > > the removed files will be identical.
> > >
> > > The generated uapi header file will be included in uapi/asm/
> > > unistd_32/64.h and generated system call table support file will
> > > be included by arch/sparc/kernel/syscall_table_32/64.S file.
> > >
> > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > > ---
> > >  arch/parisc/Makefile                  |   4 +
> > >  arch/parisc/include/asm/Kbuild        |   3 +
> > >  arch/parisc/include/uapi/asm/Kbuild   |   2 +
> > >  arch/parisc/include/uapi/asm/unistd.h | 373 +--------------------------
> > >  arch/parisc/kernel/syscall.S          |  12 +-
> > >  arch/parisc/kernel/syscall_table.S    | 459 ----------------------------------
> >
> >
> > Can we please get rid of those two new files:
>
> Yes, we don't need those files some of the architecture and other
> architecture does have same/similar files. That's why I added below
Yes, we don't need those files some of the architecture does have ...

> files, so every architecture implementation looks same.
>
> I feel it is better to remove these files.
> Arnd, Do u have any comment on this?
>
> Thanks
> Firoz
>
> >
> > >  arch/parisc/kernel/syscall_table_32.S |  13 +
> > >  arch/parisc/kernel/syscall_table_64.S |  20 ++
> >
> > Both are not needed (at least on parisc) if you apply the following
> > patch on top of your patch series.
> > This patch finally fixes the 64-bit kernel on parisc (tested on real
> > hardware).
> >
> > Helge
> >
> > diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
> > index 2523b83b88d8..45cddeeb968f 100644
> > --- a/arch/parisc/kernel/syscall.S
> > +++ b/arch/parisc/kernel/syscall.S
> > @@ -923,10 +923,20 @@ ENTRY(lws_table)
> >  END(lws_table)
> >         /* End of lws table */
> >
> > -#include "syscall_table_32.S"
> > +#define __SYSCALL(nr, entry, nargs) ASM_ULONG_INSN entry
> > +
> > +ENTRY(sys_call_table)
> > +#if defined(CONFIG_64BIT)
> > +#include <asm/syscall_table_c32.h>     /* compat syscalls */
> > +#else
> > +#include <asm/syscall_table_32.h>      /* 32-bit native syscalls */
> > +#endif
> > +END(sys_call_table)
> > +
> >  #ifdef CONFIG_64BIT
> > -#define SYSCALL_TABLE_64BIT
> > -#include "syscall_table_64.S"
> > +ENTRY(sys_call_table64)
> > +#include <asm/syscall_table_64.h>      /* 64-bit native syscalls */
> > +END(sys_call_table64)
> >  #endif
> >
> >         /*
