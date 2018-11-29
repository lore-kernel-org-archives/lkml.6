Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0397205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsEkL5eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0397205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeK2UCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:02:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35052 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2UCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:02:39 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so965401ioc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAy6oYWLLsvR/uh2rWMxT22Wr2gvtTAfEiRU4+Hmd9M=;
        b=PsEkL5eM+KaTcysGFBKsjShY4Uy4IyqJaJfJqJ2IRDQZ6UqnGDGQ/zk4G6Q+gvWukb
         //bGxuK02ZRQDsYRhLcFT3v3XN6YNIa4sIUGh9aRt8tfiiF/j6XTF8p9129kCG4G7cvv
         KZuddgloQTFXErxieOtTNTNVKA9g5Mfz+ywPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAy6oYWLLsvR/uh2rWMxT22Wr2gvtTAfEiRU4+Hmd9M=;
        b=Z9GHThjJhbPqTd2/RfrdlN3cV6Nrtj2RksALRCBBkJ7Zv410VsmJ1THvaPy+i2vXT0
         BbUl2Yn1uFAnGjDdsOFiioRFmU9JLCR+GLGG9OxgU/CVbOTrvq9oysA2R6WEb1KgDWYf
         6e2LnAzrr9eBJIxkci3SrPkwD0c30zgOUV4+oHusokSlJi8uiZWDco7zGocjVYuXi2i+
         QKROTKjb4ITfhjUVKxDCuYTLlq7eCAExa0FgS0Dv0sfcvlgCB7Z91BkQLjDp9uYebEGB
         ju5ygztCGqEs5H4Z4fv12ALSSjFX2P0WJe8QQNJ6m7mFmWAHlCLt4Qk7d/OvQhkCAeYc
         xvXg==
X-Gm-Message-State: AA+aEWaLYBDqtVWc+a4bQM/p3tSuWaHdsnOkKLBn73q1G4XZ6hksjPc1
        iyV6yl4vogLVi3nxOdekfDEX5/DuxmZsiHxsigsl4A==
X-Google-Smtp-Source: AFSGD/VfppFULoNEayvOLkNI947XdpeIu5dyf4q9EDSgwSA+dp1DLLXIzfWov6QNGmWZjIcL88mFGRDPAMDFNoH99v8=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr436564ioc.119.1543481880086;
 Thu, 29 Nov 2018 00:58:00 -0800 (PST)
MIME-Version: 1.0
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 29 Nov 2018 14:27:48 +0530
Message-ID: <CALxhOniXc5ePTXkGjiUZxrDQPqu3FyOGH=SR=2eP947JHLBk9Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] powerpc: system call table generation support
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        sathnaga@linux.vnet.ibm.com
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ sathnaga@linux.vnet.ibm.com

On Thu, 29 Nov 2018 at 09:57, Firoz Khan <firoz.khan@linaro.org> wrote:
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
>         - spu entry name, if required.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>
> I have done the same support for work for alpha,
> ia64, m68k, microblaze, mips, parisc, sh, sparc,
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in the
> syscall.tbl.
>
> changes since v2:
>  - modified/optimized the syscall.tbl to avoid duplicate
>    for the spu entries.
>  - updated the syscalltbl.sh to meet the above point.
>
> changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>  - changed from generic-y to generated-y in Kbuild.
>
> Firoz Khan (4):
>   powerpc: add __NR_syscalls along with NR_syscalls
>   powerpc: move macro definition from asm/systbl.h
>   powerpc: add system call table generation support
>   powerpc: generate uapi header and system call table files
>
>  arch/powerpc/Makefile                       |   3 +
>  arch/powerpc/include/asm/Kbuild             |   4 +
>  arch/powerpc/include/asm/systbl.h           | 396 --------------------------
>  arch/powerpc/include/asm/unistd.h           |   3 +-
>  arch/powerpc/include/uapi/asm/Kbuild        |   2 +
>  arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
>  arch/powerpc/kernel/Makefile                |  10 -
>  arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  36 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
>  arch/powerpc/kernel/systbl.S                |  37 +--
>  arch/powerpc/kernel/systbl_chk.c            |  60 ----
>  arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
>  14 files changed, 591 insertions(+), 892 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/systbl.h
>  create mode 100644 arch/powerpc/kernel/syscalls/Makefile
>  create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
>  delete mode 100644 arch/powerpc/kernel/systbl_chk.c
>
> --
> 1.9.1
>
