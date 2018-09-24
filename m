Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987CCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F0120989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQhsfjuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F0120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIXKIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:08:46 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33312 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeIXKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:08:46 -0400
Received: by mail-yb1-f193.google.com with SMTP id z18-v6so1342280ybr.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjraxmgS3juKce3gVM4oU4Xsgd36f7YoNRzAoz5CYdU=;
        b=eQhsfjuJTVS3RERnEy9d7dBPOR0egJTRZSKiTLxio5qSJSUcdYngTBsCPr33xEWd9z
         N7GjgZ3Hw45+F5a/eav9PqNmItLKOwqjTyJwtTjuAFRg6uY0GEgcX3Q/j6EEa0EaZtRC
         JMIFCkpL930zZH7iE3f2onz9iIEwa9p4DuZDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjraxmgS3juKce3gVM4oU4Xsgd36f7YoNRzAoz5CYdU=;
        b=SpHNoRb869jr3Kekj13bpW3BuM0gzW1zcHFjha9a/xEz3w04OMV2UUVm0ktgedNFuo
         IZpMAR+azV9FO8MUGkP85c5fTo951hXnGPHbYC6lUedO9T/EYhtHTd7LoHxrPHuAIUVl
         ZxXYQ+6VZi5icM5PL9Phn/92LDfPAKDE+9mTX2UOT6pIQzk2AsfdQQpkef154WWV5ziM
         hwu+j+5ZAd006EZgUFt7sv0OlH3sI1vKwiUW10YoUpnN5ooBhN+kCdLBjb0bvd/fx0K/
         2iuPDBso9H1BN8sw/j8qe0nQCkmi8w/EjhonFIKCrmans7v3NjNb+xZcB8dcGX3Y6TdB
         UI+g==
X-Gm-Message-State: ABuFfoiozP7XlYGNco4XigXVZH3qJBvo9/knlWsqcuigVEM8y7l83Iep
        WMkhZpVm/otIl8lMYaZ7g9yvCtZBems1a5X67gQmyg==
X-Google-Smtp-Source: ACcGV62ellNONjLHEMH1kUnhY4Z0l5iB51zE+0TugCl+OZjX4gw13GcU2owuJTwxfYRL42yI7C/XuiOm2C21S6BT4mU=
X-Received: by 2002:a25:6ed5:: with SMTP id j204-v6mr3271346ybc.223.1537762118623;
 Sun, 23 Sep 2018 21:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <b42ac34f-ab67-5d5c-1d6f-354af40773d8@linux-m68k.org>
In-Reply-To: <b42ac34f-ab67-5d5c-1d6f-354af40773d8@linux-m68k.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 24 Sep 2018 09:38:27 +0530
Message-ID: <CALxhOnjwrjuZjDnymesqe1Wj=8=YvEwW5wTjLnOHcfzLaFBK4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] System call table generation support
To:     gerg@linux-m68k.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
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

Hi Greg,

On Mon, 24 Sep 2018 at 06:38, Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On 21/09/18 01:06, Firoz Khan wrote:
> > The purpose of this patch series is:
> > 1. We can easily add/modify/delete system call by changing entry
> > in syscall.tbl file. No need to manually edit many files.
> >
> > 2. It is easy to unify the system call implementation across all
> > the architectures.
> >
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
> >          - System call number.
> >          - ABI.
> >          - System call name.
> >          - Entry point name.
> >          - Compat entry name, if required.
> >
> > ARM, s390 and x86 architecuture does exist the similar support. I
> > leverage their implementation to come up with a generic solution.
> >
> > I have done the same support for work for alpha, microblaze, sparc,
> > mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending
> > the patch for one architecuture for review. Below mentioned git
> > repository contains more details.
> > Git repo:- https://github.com/frzkhn/system_call_table_generator/
> >
> > Added an extra patch to keep __IGNORE* entries in asm/unistd.h.
> >
> > Finally, this is the ground work for solving the Y2038 issue. We
> > need to add/change two dozen of system calls to solve Y2038 issue.
> > So this patch series will help to easily modify from existing
> > system call to Y2038 compatible system calls.
> >
> > Firoz Khan (5):
> >    m68k: Rename system call table file name
> >    m68k: Replace NR_syscalls macro from asm/unistd.h
> >    m68k: Added system call table generation support
> >    m68k: uapi header and system call table file generation
> >    m68k: added __IGNORE* entries in asm/unistd.h
>
> Built and tested on a couple of m68k/ColdFire targets,
> m520x (no MMU) and m5475 (with MMU). Load and run on real hardware,
> no problems found. So for m68knommu/ColdFire:

Thanks for your support!

Philippe De Muyter shared one comment. I have to include that change in the
patch series. BTW I can post version 3 patch series within couple of days.

It would be great if someone can review this patches now and share
your comments.
So I can include it in the next version.

- Firoz

>
> Tested-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Regards
> Greg
>
>
> >   arch/m68k/Makefile                      |   3 +
> >   arch/m68k/include/asm/Kbuild            |   1 +
> >   arch/m68k/include/asm/unistd.h          |  10 +-
> >   arch/m68k/include/uapi/asm/Kbuild       |   1 +
> >   arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
> >   arch/m68k/kernel/Makefile               |   2 +-
> >   arch/m68k/kernel/syscall_table.S        |  14 ++
> >   arch/m68k/kernel/syscalls/Makefile      |  37 +++
> >   arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
> >   arch/m68k/kernel/syscalls/syscallhdr.sh |  39 ++++
> >   arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
> >   arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
> >   12 files changed, 502 insertions(+), 790 deletions(-)
> >   create mode 100644 arch/m68k/kernel/syscall_table.S
> >   create mode 100644 arch/m68k/kernel/syscalls/Makefile
> >   create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
> >   create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
> >   create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
> >   delete mode 100644 arch/m68k/kernel/syscalltable.S
> >
