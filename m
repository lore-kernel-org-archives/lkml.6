Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2345C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0320989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="khq4LEQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB0320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIXKOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:14:09 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36931 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbeIXKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:14:09 -0400
Received: by mail-yb1-f195.google.com with SMTP id b3-v6so6692605yba.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7//bqKE84Z2MviYncmM13zh3BW1/jAQtQzq3NNsTVxo=;
        b=khq4LEQHtfv4GMfwtzdCovL14xHq4in0QdRvgKulp7hYkM5gwF7YzPOvhAtIiBdZPZ
         5wYBGxnBLreskANN+fAmC5dxnHyaBFN1CGDQrLTLBNtrhN55oOQBCoiaKU+TX2/xDDwZ
         VHOkgiL1S9QBsMWQsnrbVwytNxobGT05Rf8PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7//bqKE84Z2MviYncmM13zh3BW1/jAQtQzq3NNsTVxo=;
        b=Lu0Vj8EJHmwRB5Rp2vMa26colPfOEfJN+UzdnAGDO0m+XlQG97zeRXOAYq/Q4K1R7L
         Rv0rh9HWZwUYfloTteiilvhA4HlIHbiF+MGCevW0JurDwJwv2YZdIb3UM/vnu995v0Cb
         NP10wfYejXqZKdmfKGQqccETWGTjxeUmOGy2ExNi8kOOZAfumWfhWX/fLB3W1q9mKdgu
         wrHtZTOOSdg0hFAUX/jJzO5qpL/NRzzsjVrf769AyBe0PE/YEhhPFGVbYwMnFB3F3S9w
         iNALiODb9hqmH6wnslDs4ix5rlSqPwmJ7zTmdMQiqvZuT/hr2MV/LXDgplxWOiERiWqO
         lhGQ==
X-Gm-Message-State: ABuFfojk+sQJgEvnqbtDTXibsBq2EA4cX+x3veyOvhvOP74J4r6sJR5I
        y7R2IuTTC3DlvKixldz7pD5r+2MSD0+dXkc9KpHCFDz9
X-Google-Smtp-Source: ACcGV61YSi6wEc2Ly3GdM0ZFQ1nJmAvg6JDYevZDceWI/LL4qp0dSoscuslpsE/zvkok3g+7XLqi5eYZ+TRjWBtfoHc=
X-Received: by 2002:a25:a063:: with SMTP id x90-v6mr4017196ybh.174.1537762440611;
 Sun, 23 Sep 2018 21:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org> <844186da-0900-3c50-31f4-8600581b5675@gmx.de>
In-Reply-To: <844186da-0900-3c50-31f4-8600581b5675@gmx.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 24 Sep 2018 09:43:49 +0530
Message-ID: <CALxhOnhrV0LSecZUdFghkpsTFhymo+kdC0dkzSNjp-NpeSE+_w@mail.gmail.com>
Subject: Re: [PATCH 0/4] System call table generation support
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Mon, 24 Sep 2018 at 01:18, Helge Deller <deller@gmx.de> wrote:
>
> Hi Firoz,
>
> On 14.09.2018 10:26, Firoz Khan wrote:
> > The purpose of this patch series is:
> > 1. We can easily add/modify/delete system call by changing entry
> > in syscall.tbl file. No need to manually edit many files.
> >
> > 2. It is easy to unify the system call implementation across all
> > the architectures.
>
> I like the idea.
>
> > The system call tables are in different format in all architecture
> > and it will be difficult to manually add or modify the system calls
> > in the respective files manually. To make it easy by keeping a script
> > and which'll generate the header file and syscall table file so this
> > change will unify them across all architectures.
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
> >         - Compat entry name, if required.
> >
> > ARM, s390 and x86 architecuture does exist the similar support. I
> > leverage their implementation to come up with a generic solution.
> >
> > I have done the same support for work for alpha, m68k, microblaze,
> > ia64, mips, powerpc, sh, sparc, and xtensa. But I started sending
> > the patch for one architecuture for review. Below mentioned git
> > repository contains more details.
> > Git repo:- https://github.com/frzkhn/system_call_table_generator/
> >
> > Finally, this is the ground work for solving the Y2038 issue. We
> > need to add/change two dozen of system calls to solve Y2038 issue.
> > So this patch series will help to easily modify from existing
> > system call to Y2038 compatible system calls.
> >
> > I started working system call table generation on 4.17-rc1. I used
> > marcin's script - https://github.com/hrw/syscalls-table to generate
> > the syscall.tbl file. And this will be the input to the system call
> > table generation script. But there are couple system call got add
> > in the latest rc release. If run Marcin's script on latest release,
> > It will generate a new syscall.tbl. But I still use the old file -
> > syscall.tbl and once all review got over I'll update syscall.tbl
> > alone w.r.to the tip of the kernel. The impact of this thing, few
> > of the system call won't work.
> >
> > Firoz Khan (4):
> >   parisc: Move __IGNORE* entries to non uapi header
> >   parisc: Replace __NR_Linux_syscalls macro with __NR_syscalls
> >   parisc: Add system call table generation support
> >   parisc: uapi header and system call table file generation
> >
> >  arch/parisc/Makefile                       |   4 +
> >  arch/parisc/include/asm/Kbuild             |   3 +
> >  arch/parisc/include/asm/unistd.h           |   8 +
> >  arch/parisc/include/uapi/asm/Kbuild        |   2 +
> >  arch/parisc/include/uapi/asm/unistd.h      | 377 +----------------------
> >  arch/parisc/kernel/syscall.S               |  14 +-
> >  arch/parisc/kernel/syscall_table.S         | 459 -----------------------------
> >  arch/parisc/kernel/syscall_table_32.S      |  11 +
> >  arch/parisc/kernel/syscall_table_64.S      |  19 ++
> >  arch/parisc/kernel/syscalls/Makefile       |  52 ++++
> >  arch/parisc/kernel/syscalls/syscall_32.tbl | 358 ++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscall_64.tbl | 357 ++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscallhdr.sh  |  38 +++
> >  arch/parisc/kernel/syscalls/syscalltbl.sh  |  36 +++
> >  14 files changed, 896 insertions(+), 842 deletions(-)
> >  delete mode 100644 arch/parisc/kernel/syscall_table.S
> >  create mode 100644 arch/parisc/kernel/syscall_table_32.S
> >  create mode 100644 arch/parisc/kernel/syscall_table_64.S
> >  create mode 100644 arch/parisc/kernel/syscalls/Makefile
> >  create mode 100644 arch/parisc/kernel/syscalls/syscall_32.tbl
> >  create mode 100644 arch/parisc/kernel/syscalls/syscall_64.tbl
> >  create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
> >  create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
>
> Your parisc patches don't apply any longer.
> If you update them (with the feedback given by others), I'm happy
> to test your patch again on parisc.

Sure. Thanks for your support!
I planned to post few other things within couple of days.
Hopefully I can update parisc patches this week!

- Firoz

>
> Helge
