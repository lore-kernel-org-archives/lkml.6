Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC91C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B06214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cK9TZZfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B06214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLDDWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:22:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53926 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:22:16 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so13090866ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 19:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX08F6z4cZRXNjp4nEcD/dtG5NQRhpM7OXWOHS/has8=;
        b=cK9TZZfOMgr2zvz/A4QcGm1OYLCKSePvN6cobfT71f1Uk3eBqZOoAgofhpitiPHxls
         2JwiVvmXqq2od6s8eTMCJMLYl/XdEvKcR1Qlvs9UXdXcXCi08+DlxQ6sz/gqqpxnvqJ3
         /PBHBLKVRPnFB0AYZlnGiay8MSfzNy6ggwhVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX08F6z4cZRXNjp4nEcD/dtG5NQRhpM7OXWOHS/has8=;
        b=DXTHqiu1xADt9OqvxOoBPzBEnV1nJ4F3kCJECtnw2WtoXki6F1CfYmPXd2hEp3Cpqg
         7GsrFFprdjzMgXDlkeqXnNCluXqLgjOhF0B3SN8kPOQU0jAxEOehjDggc6wEZla2eXel
         ZmtYGLFsxkONJfXRpNifj52LGSz85cMCaG8XK17zDol1dKDQNherJajeHGlZOeOCBsdn
         6DT36eahRT3ZvtubixpNLxpPBO+qQtXJg9wdmRxGTLo4OxvS5V2EFx73qO69CEaBkiBp
         3Pc7npg5ocxhxte7jQT9RZUZSv6smj0iQ3fcpLsgXZ7BrC0Xd32tvQR2XUaAuf1OFPJf
         5+EA==
X-Gm-Message-State: AA+aEWahT/rz5nRZsO3KjZxONHWrQqEnu98UpmK2qUrciaPi76u+GRPg
        iEv7OwK3IF5l8vgJDXWT7ZsyoyYaqnppcQDITu6C7g==
X-Google-Smtp-Source: AFSGD/Uzy65+nJULX5kVGe/paRAaSYW9A70IavysAd+FS819S5dmnbgo/P/nWrIf7t7iVUQSmuL0V+UrMo3uWPju3Ts=
X-Received: by 2002:a02:5618:: with SMTP id o24mr17673376jab.111.1543893735587;
 Mon, 03 Dec 2018 19:22:15 -0800 (PST)
MIME-Version: 1.0
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
 <1542088829-19790-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com>
In-Reply-To: <CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 4 Dec 2018 08:52:04 +0530
Message-ID: <CALxhOnggoJ8Ds-0AXxg5Tfa7QwccqjWExKuYRuNv+Km1FTVj1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] m68k: add system call table generation support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Geert,

On Sun, 2 Dec 2018 at 19:27, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > The system call tables are in different format in all
> > architecture and it will be difficult to manually add,
> > modify or delete the syscall table entries in the res-
> > pective files. To make it easy by keeping a script and
> > which will generate the uapi header and syscall table
> > file. This change will also help to unify the implemen-
> > tation across all architectures.
> >
> > The system call table generation script is added in
> > kernel/syscalls directory which contain the scripts to
> > generate both uapi header file and system call table
> > files. The syscall.tbl will be input for the scripts.
> >
> > syscall.tbl contains the list of available system calls
> > along with system call number and corresponding entry
> > point. Add a new system call in this architecture will
> > be possible by adding new entry in the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > syscallhdr.sh and syscalltbl.sh will generate uapi header
> > unistd_32.h and syscall_table.h files respectively. Both
> > .sh files will parse the content syscall.tbl to generate
> > the header and table files. unistd_32.h will be included
> > by uapi/asm/unistd.h and syscall_table.h is included by
> > kernel/syscall_table.S - the real system call table.
> >
> > ARM, s390 and x86 architecuture does have similar support.
> > I leverage their implementation to come up with a generic
> > solution.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> > @@ -0,0 +1,36 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +in="$1"
> > +out="$2"
> > +my_abis=`echo "($3)" | tr ',' '|'`
> > +prefix="$4"
> > +offset="$5"
> > +
> > +fileguard=_UAPI_ASM_M68K_`basename "$out" | sed \
> > +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > +       printf "#ifndef %s\n" "${fileguard}"
> > +       printf "#define %s\n" "${fileguard}"
> > +       printf "\n"
> > +
> > +       nxt=0
> > +       while read nr abi name entry ; do
> > +               if [ -z "$offset" ]; then
> > +                       printf "#define __NR_%s%s\t%s\n" \
> > +                               "${prefix}" "${name}" "${nr}"
> > +               else
> > +                       printf "#define __NR_%s%s\t(%s + %s)\n" \
> > +                               "${prefix}" "${name}" "${offset}" "${nr}"
> > +               fi
> > +               nxt=$((nr+1))
> > +       done
> > +
> > +       printf "\n"
> > +       printf "#ifdef __KERNEL__\n"
> > +       printf "#define __NR_syscalls\t%s\n" "${nxt}"
> > +       printf "#endif\n"
> > +       printf "\n"
> > +       printf "#endif /* %s */" "${fileguard}"
>
> The above line is lacking a "\n", causing:
>
>     ./arch/m68k/include/generated/uapi/asm/unistd_32.h:370:42:
> warning: no newline at end of file

I was wondering, I haven't seen this warning when I compiled it.

>
> Changing it to:
>
>     printf "#endif /* %s */\n" "${fileguard}"
>
> fixes this.

Yes.

>
> Interestingly, this issue seems to be present on powerpc, parisc, sparc,
> sh, xtensa (and probably more, I gave up looking), too?

I kept the script to generate files *almost* identical. so this will be present
all 10 architecture.

>
> Apart from that, it seems to work fine on m68k.

I have three options here to fix this;
1. I can send v6 by fixing this one.
2. I can post a single patch which add \n in the script.
3. Could you able to add \n in the script.

Please choose one, I can act accordingly.

Thanks
Firoz

>
> > +) > "$out"
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
