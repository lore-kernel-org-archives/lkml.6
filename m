Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A94C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A9520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez5rBDSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A9520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeLJFfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:35:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35444 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJFfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:35:50 -0500
Received: by mail-io1-f65.google.com with SMTP id i1so5772867ioo.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyuVfvb26P8ZMNwG5n6KgBSm/N4J7JQEuRs6FzEIp5c=;
        b=ez5rBDSaz0wZlhmjTWZB3HshExaGIHE+HgIb6PEvARi//vUyHo8sQTQvRu+WiIZpjn
         944h+z0/h3WUChlXesm4ew49TMFx72Rdo7kB5SUyfSJiqfehcB3PxPF0gPv1O/AiiQlx
         7vrxhmcteuvxwMpBL1BURnT2GDjaU+6AfPxVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyuVfvb26P8ZMNwG5n6KgBSm/N4J7JQEuRs6FzEIp5c=;
        b=tiAx5n+Vt+sWn+eTEcKV891mMaZZpaKaIlq/PQ8HBLfJPj9pJ5HzHJFm34nQ4ZRQso
         +ddKIF5pl2Cg6O/Nf4yf8hxaFK/CSd00MvaRFEqpE7/flKPmm7m73sFje+ON9BDisuvC
         RMosbCG6gFzpHa0J2efjqtnHa21MeScHC2oB9a+ENb3GOmCj1FSNhfBMGeHerrTvxIUu
         a1mU4ryYmliB/VeAox+o36EIBylcUyoHJETMSvhNHS+ghtrf2WRiuh4nwuarO1hBHWbH
         Qh+NjsD/P0r12ydPLFyRr0WeIlWthE9vjUMy8RRd5VXvOPo6PJK18pyBsezM0OAPwDeB
         okog==
X-Gm-Message-State: AA+aEWbI6mP693mkSO7d44CJOeO6Hzkn+buBUiOoglb4k3nxjlDJj0jh
        O2rO2ODIaSNVQwjDsAuvQEAQju/UU3osTq8YyGd3Tg==
X-Google-Smtp-Source: AFSGD/Vd9pugAzzxSsJ/JrIMGqfTbX/SXm/QDQKYTrHXtpoez1RnU8Ajd2ft9Xzi4rQCdz8L121S5m1h4OYf2UC9thg=
X-Received: by 2002:a6b:4106:: with SMTP id n6mr8643353ioa.171.1544420149542;
 Sun, 09 Dec 2018 21:35:49 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 10 Dec 2018 11:05:38 +0530
Message-ID: <CALxhOninHsCiB7puVOkU3i6W9gfhGqAA6EDT0kAEC9ZqMZPh7w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] mips: system call table generation support
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
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

Hi Paul,

On Thu, 6 Dec 2018 at 10:49, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in
> the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>
> I have done the same support for work for alpha,
> ia64, m68k, microblaze, parisc, powerpc, sh, sparc,
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>
> Changes since v3:
>  - rearranged the patches for '64' to 'n64' conver-
>    sion.
>  - moved the unistd_nr_*.h files to asm/unistd.h
>  - modified the *.sh files.

Please review this patch series and queue it for linux-next.

Thanks
Firoz

>
> Changes since v2:
>  - fixed __NR_syscalls assign issue.
>
> Changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>  - changed from generic-y to generated-y in Kbuild.
>
> Firoz Khan (7):
>   mips: add __NR_syscalls along with __NR_Linux_syscalls
>   mips: remove unused macros
>   mips: rename macros and files from '64' to 'n64'
>   mips: add +1 to __NR_syscalls in uapi header
>   mips: remove syscall table entries
>   mips: add system call table generation support
>   mips: generate uapi header and system call table files
>
>  arch/mips/Makefile                        |    3 +
>  arch/mips/include/asm/Kbuild              |    4 +
>  arch/mips/include/asm/asm.h               |    6 +-
>  arch/mips/include/asm/fpregdef.h          |    4 +-
>  arch/mips/include/asm/fw/arc/hinv.h       |    2 +-
>  arch/mips/include/asm/regdef.h            |    4 +-
>  arch/mips/include/asm/sigcontext.h        |    4 +-
>  arch/mips/include/asm/unistd.h            |   11 +-
>  arch/mips/include/uapi/asm/Kbuild         |    6 +
>  arch/mips/include/uapi/asm/fcntl.h        |    2 +-
>  arch/mips/include/uapi/asm/reg.h          |    4 +-
>  arch/mips/include/uapi/asm/sgidefs.h      |    2 +-
>  arch/mips/include/uapi/asm/sigcontext.h   |    4 +-
>  arch/mips/include/uapi/asm/stat.h         |    4 +-
>  arch/mips/include/uapi/asm/statfs.h       |    4 +-
>  arch/mips/include/uapi/asm/unistd.h       | 1069 +----------------------------
>  arch/mips/kernel/Makefile                 |    2 +-
>  arch/mips/kernel/ftrace.c                 |    8 +-
>  arch/mips/kernel/scall32-o32.S            |  391 +----------
>  arch/mips/kernel/scall64-64.S             |  444 ------------
>  arch/mips/kernel/scall64-n32.S            |  341 +--------
>  arch/mips/kernel/scall64-n64.S            |  117 ++++
>  arch/mips/kernel/scall64-o32.S            |  379 +---------
>  arch/mips/kernel/syscalls/Makefile        |   96 +++
>  arch/mips/kernel/syscalls/syscall_n32.tbl |  343 +++++++++
>  arch/mips/kernel/syscalls/syscall_n64.tbl |  339 +++++++++
>  arch/mips/kernel/syscalls/syscall_o32.tbl |  382 +++++++++++
>  arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
>  arch/mips/kernel/syscalls/syscallnr.sh    |   28 +
>  arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
>  arch/mips/kvm/entry.c                     |    4 +-
>  arch/mips/vdso/vdso.h                     |    2 +-
>  arch/mips/vdso/vdso.lds.S                 |    2 +-
>  33 files changed, 1450 insertions(+), 2634 deletions(-)
>  delete mode 100644 arch/mips/kernel/scall64-64.S
>  create mode 100644 arch/mips/kernel/scall64-n64.S
>  create mode 100644 arch/mips/kernel/syscalls/Makefile
>  create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
>  create mode 100644 arch/mips/kernel/syscalls/syscall_n64.tbl
>  create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
>  create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
>  create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh
>
> --
> 1.9.1
>
