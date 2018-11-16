Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A95C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620B2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJShhHlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5620B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbeKPTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:39:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39047 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeKPTjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:39:33 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so33404555itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEus7D/Gzcn4MHetFxsOOXwDjW2JH9JNswgSBlTJ684=;
        b=iJShhHlPjfyY6QIecPHWgyGglj0c/9Ml5E0z41tFGhkHiGQJCP0a4Bn+AWIVf7fNgJ
         VKFYVggYMc3ZGzpT4/hMmKKUsndnOghgbNNmGyAnUdj3TRDVR3frw5tGuIBgFLnsFwXu
         QLemV5iGTs3v7AU3wIwigOEdf0FXUg4JM3YZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEus7D/Gzcn4MHetFxsOOXwDjW2JH9JNswgSBlTJ684=;
        b=jwxR8aS1QmoB8TNqLO2kydsZ+2bb2uA4EcYhUg9ovq8kzn99y54yKhQfFD0g/X+w3D
         530q9qTV3bPGbbotLNTIINZqWBu7M8jp6PCuTGXdpZumPEL1YdTHoNRUmNc0kFxVguxk
         QD4S3r0z0DaSY31aGDTF1Hy4/VZkm7kuq2lZUzm0+h7nz4rcJey75REAh30vx9dWfVY0
         VQvJh/FO14sGKWyt8L1fMqjhe+VJrC4aeNacwKBQtR263/OVMpI2DKRyj6bDbQD/I/WV
         S9Fn+snWn9ocG9CSMvXYf0A+4omo+mgaj0Sr1+3KjF8Rqr6IXF/2gKUEEbDE3V/M6U2j
         q1zg==
X-Gm-Message-State: AGRZ1gLOqqKyBRfWOxB7zi7FjTohrdQVqHxonXBR70cUwSjtUmbkuOdq
        42pDJ7RzQqUhbBV9vI4Q0Su68Z18i5rQ1sCNZePgMQ==
X-Google-Smtp-Source: AJdET5f8mxl/qVQjmBrrIQ/IG+wyNWmOe9Nm4NKitdtDx5YUoBytmqkA7ys+Yy+1DFM0MONEpGQz9xixfpDUw6l5JL0=
X-Received: by 2002:a05:660c:a1a:: with SMTP id e26mr4787652itk.83.1542360483178;
 Fri, 16 Nov 2018 01:28:03 -0800 (PST)
MIME-Version: 1.0
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org> <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
In-Reply-To: <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 16 Nov 2018 14:57:51 +0530
Message-ID: <CALxhOnjQgk8gX-N14H+4VtZhSSDB==NYdt5Y7-ihy6pxa6BPEA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] microblaze: system call table generation support
To:     Michal Simek <monstr@monstr.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Michal,

On Fri, 16 Nov 2018 at 14:01, Michal Simek <monstr@monstr.eu> wrote:
>
> On 13. 11. 18 7:04, Firoz Khan wrote:
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
> >
> > The system call tables are in different format in
> > all architecture. It will be difficult to manually
> > add, modify or delete the system calls in the resp-
> > ective files manually. To make it easy by keeping a
> > script and which'll generate uapi header file and
> > syscall table file.
> >
> > syscall.tbl contains the list of available system
> > calls along with system call number and correspond-
> > ing entry point. Add a new system call in this arch-
> > itecture will be possible by adding new entry in the
> > syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > ARM, s390 and x86 architecuture does exist the sim-
> > ilar support. I leverage their implementation to
> > come up with a generic solution.
> >
> > I have done the same support for work for alpha, ia64,
> > m68k, mips, parisc, powerpc, sh, sparc and xtensa.
> > Below mentioned git repository contains more details
> > about the workflow.
> >
> > https://github.com/frzkhn/system_call_table_generator/
> >
> > Finally, this is the ground work to solve the Y2038
> > issue. We need to add two dozen of system calls to
> > solve Y2038 issue. So this patch series will help to
> > add new system calls easily by adding new entry in
> > the syscall.tbl.
> >
> > changes since v3:
> >  - changed from generic-y to generated-y in Kbuild.
> >
> > changes since v2:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - fixed all mixed indentation issues in syscall.tbl.
> >  - added "comments" in syscall_*.tbl.
> >
> > changes since v1:
> >  - enclosed __NR_sycalls macro with __KERNEL__.
> >  - added missing new line.
>
> next time please also keep this changelog in every patch.

Sure. Basically I haven't came across changelog till a point
where  Geert Uytterhoeven <geert@linux-m68k.org> pointed
out changelog is missing. Thanks Geert :)

>
> >
> > Firoz Khan (3):
> >   microblaze: move __NR_syscalls macro from asm/unistd.h
> >   microblaze: add system call table generation support
> >   microblaze: generate uapi header and system call table files
> >
> >  arch/microblaze/Makefile                      |   3 +
> >  arch/microblaze/include/asm/Kbuild            |   1 +
> >  arch/microblaze/include/asm/unistd.h          |   2 -
> >  arch/microblaze/include/uapi/asm/Kbuild       |   1 +
> >  arch/microblaze/include/uapi/asm/unistd.h     | 407 +------------------------
> >  arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
> >  arch/microblaze/kernel/syscalls/Makefile      |  38 +++
> >  arch/microblaze/kernel/syscalls/syscall.tbl   | 410 ++++++++++++++++++++++++++
> >  arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 +++
> >  arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 ++
> >  10 files changed, 526 insertions(+), 810 deletions(-)
> >  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
> >  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
> >  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
> >  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> >
>
> Looks good now. I have queue it to next. And also asked our team to
> retest everything.

Sounds good!

Thanks
Firoz

>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
>
>
