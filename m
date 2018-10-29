Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04BFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FB32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgUSjv2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FB32084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeJ2MZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:25:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45074 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbeJ2MZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:25:03 -0400
Received: by mail-io1-f65.google.com with SMTP id p83-v6so4056830iod.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrhvkBo5ZKnk4/O4sfkDr3vs9gwKOxwlrsNh7k7vl4w=;
        b=dgUSjv2PCW6B83yNOop+fG7DUZcWgIB+ftKt1ny78iD7JFuS1vx+4Pa6Hv2g/GTvAf
         J0qJFeAZsICbCFIlr0ajqLn6ryOs0ZCpf4mPVTWdvNu/72xK/VF6FXWbcv+A8t6tMRZh
         RF9N2EE9nLR1Fz/Z7y8Txue5/MArzdPzHVfh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrhvkBo5ZKnk4/O4sfkDr3vs9gwKOxwlrsNh7k7vl4w=;
        b=Xr1UOfI4HD1lk9EoHBLZ+DqBKjtCICOhqEvHXl+FpVaqbf/saB5L8BRz66TWo67Igq
         q0vbZL2aTYhrHnCRPzYNDMA1sjScGPHBFszVF43o6Ixdy0XIlGXzw/N1HROmRtNwIJFU
         alBQ5r73ien2o3wzZ8wDJrPIJz0B74FbisSwFHc4zPW1samS+uaFWNX+GkQzTTqhZQjl
         okhTl/l5UhEHxPtYhGTi4XT85OIPUL85KBmLFIY0t/puh60U1PQlf76l+chxiDwgJsTa
         TspSEQl17xHbWydLdvvvJ4xDFVs9hFatDl2X8GRSdVWQuEaMA3FNbx+5MedWlrED6Otm
         EkXA==
X-Gm-Message-State: AGRZ1gIQ+4mw4UNACUqz6eVAua3eqFVlY9X7FF0OKIN9gah2nqer+UjN
        6lQ3S+KwR2p4Jlw7wPeQwybxAuRaij/yumYuGP5SdA==
X-Google-Smtp-Source: AJdET5f3V+kICpxod72n5WC/bA3wJ01XLoDTkCU+s9S2I9ii2M2hH4LfqGW+pgXHywCerT9qHJOnB811lx3tY/C4UNs=
X-Received: by 2002:a6b:6904:: with SMTP id e4-v6mr7057835ioc.119.1540784291528;
 Sun, 28 Oct 2018 20:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org> <CAMuHMdXPR7WgPe5nPh3Lcc6FDxTNDYyOmV1oKU=BLcS2H7MPgA@mail.gmail.com>
In-Reply-To: <CAMuHMdXPR7WgPe5nPh3Lcc6FDxTNDYyOmV1oKU=BLcS2H7MPgA@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 29 Oct 2018 09:08:00 +0530
Message-ID: <CALxhOng9DaF9ZkUGQW9=tzaPmoiG9NzhhaWXqPDr7RwUTf0c0A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] m68k: system call table generation support
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

On Sat, 27 Oct 2018 at 20:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Fri, Oct 26, 2018 at 7:06 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > The purpose of this patch series is, we can easily add/modify/delete
> > system call table support by changing entry in syscall.tbl file
> > instead of manually changing many files. The other goal is to unify
> > the system call table generation support implementation across all
> > the architectures.
> >
> > The system call tables are in different format in all architecture.
> > It will be difficult to manually add, modify or delete the system
> > calls in the respective files manually. To make it easy by keeping
> > a script and which'll generate uapi header file and syscall table
> > file.
> >
> > syscall.tbl contains the list of available system calls along with
> > system call number and corresponding entry point. Add a new system
> > call in this architecture will be possible by adding new entry in
> > the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > ARM, s390 and x86 architecuture does exist the similar support. I
> > leverage their implementation to come up with a generic solution.
> >
> > I have done the same support for work for alpha, ia64, microblaze,
> > mips, parisc, powerpc, sh, sparc, and xtensa. Below mentioned git
> > repository contains more details.
> > Git repo:- https://github.com/frzkhn/system_call_table_generator/
> >
> > Finally, this is the ground work to solve the Y2038 issue. We need
> > to add two dozen of system calls to solve Y2038 issue. So this patch
> > series will help to add new system calls easily by adding new entry
> > in the syscall.tbl.
>
> Thanks for the update!
>
> Can you please tell the audience what has been changed in v4?

Sure.
- I added the comments in syscall.tbl and solved mixed (space and tab)
  indentation.
- Modified the scripts (syscalltbl.sh and syscallhdr.sh) as per the feedback
  provided by Arnd, Finn Thain, Eugene Syromiatnikov and Rolf Eike Beer.

Eg:-
 - echo options are not portable; changed to printf
 - "let" is a bash extension; changed posix-conformant expression.
 - Finally I optimized the script and solved mixed indentation.

>
> When posting a new version of a patch or patch series, it is a good
> idea to include a changelog in the cover letter and/or patches.

Sure, will do!

Thanks
Firoz

>
> Thanks!
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
