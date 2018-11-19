Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1841EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB95920817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcWIpwIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB95920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeKSPa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:30:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41732 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeKSPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:30:58 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so9444171ioc.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 21:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHoz7/mmqMJ5RXC85qTDqZ7vp2xuTJPd+gTzOToOizA=;
        b=DcWIpwIElIGiEYooxf5xTnzwJ1qMofw/6AtcA6ip4yX7YP2tx5JtZs/lNGXsgZnIz6
         xZYTHsKE2c9gUEe1nejX3VwYzk3/2R3PqrBgUnlEoMy0hlE9pCCbbJUPaZvMED0X4NFH
         O1YaCpgd51k1C5beTS8JWTxb5CeV9Aphu7YVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHoz7/mmqMJ5RXC85qTDqZ7vp2xuTJPd+gTzOToOizA=;
        b=UeSj3oq/zL2fcqAyCUcrYP1E+L3oINC8ImI4n9E8cwBK2LYck16hS6QuPFT9tPXwLj
         hUjq8BIB8GW4K6KuMKW7Z06Txl54kqdugxOREwi1/f5uh3nsFESarILINVNO5LtOTi46
         KoizdsOCbk6Zz0mDt5zQ9R320uoOdJQyC4zY7IfzP8y4XQxyEq2pBK4tTjGNYacqJe1G
         78vtSXxhHkCJXuO3/uF6PK/PiYmN0PndU4S5LzmFgH2mma7xjU29a6XwFXf8n+YOJr0u
         I3vi5faf/n+ip0FFTr0fAHk01BEi4kwfzk+4WBHqx0Kp9CNQsgzpSu/R32bct2aCcUKW
         WxjA==
X-Gm-Message-State: AA+aEWY24CKU7wjkXbdCghZUTSkyWCsbT99gkGgI24uQMrWvuAm4nBBM
        nNDMgnlXlVKGONm3WjydNFqFM1GEoVk3jqh9XOIhcQ==
X-Google-Smtp-Source: AFSGD/VaVMsjnlOSK+H97ZV4xlLxd8fnER3SZaGBQOh9z2tLg3EOP+0Dd2MrU/Lz5GtKrlrd2jqjr+4hP8G5hQTw40A=
X-Received: by 2002:a6b:bc04:: with SMTP id m4-v6mr12841785iof.171.1542604109872;
 Sun, 18 Nov 2018 21:08:29 -0800 (PST)
MIME-Version: 1.0
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 19 Nov 2018 10:38:20 +0530
Message-ID: <CALxhOnis61eCGyS22e0_s5PLOimsNX+mhgMa_-enLWQ=EarBfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
To:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
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

On Wed, 14 Nov 2018 at 10:02, Firoz Khan <firoz.khan@linaro.org> wrote:
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
>
> Please note, this support is only available for 32-bit
> kernel, not 64-bit kernel. As I came across the 64-bit
> kernel is not active for long time.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to come
> up with a generic solution.
>
> I have done the same support for work for alpha, ia64,
> m68k, microblaze, mips, parisc, powerpc, sparc, and
> xtensa. Below mentioned git repository contains more
> details about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to solve
> Y2038 issue. So this patch series will help to add new
> system calls easily by adding new entry in the syscall-
> .tbl.
>
> Changes since v2:
>  - changed from generic-y to generated-y in Kbuild.
>
> Changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall.tbl.
>
> Firoz Khan (3):
>   sh: add __NR_syscalls along with NR_syscalls
>   sh: add system call table generation support
>   sh: generate uapi header and syscall table header files

Gentle reminder!

Could someone review this patch series. I haven't received any
feedback till now.

FYI, this support is only available for 32-bit kernel, not 64-bit
kernel. As I came across the 64-bit kernel is not active for long time.

Thanks
Firoz

>
>  arch/sh/Makefile                      |   3 +
>  arch/sh/include/asm/Kbuild            |   1 +
>  arch/sh/include/asm/unistd.h          |   2 +
>  arch/sh/include/uapi/asm/Kbuild       |   1 +
>  arch/sh/include/uapi/asm/unistd_32.h  |   4 +-
>  arch/sh/include/uapi/asm/unistd_64.h  |   4 +-
>  arch/sh/kernel/syscalls/Makefile      |  38 ++++
>  arch/sh/kernel/syscalls/syscall.tbl   | 392 ++++++++++++++++++++++++++++++++++
>  arch/sh/kernel/syscalls/syscallhdr.sh |  36 ++++
>  arch/sh/kernel/syscalls/syscalltbl.sh |  32 +++
>  arch/sh/kernel/syscalls_32.S          | 387 +--------------------------------
>  11 files changed, 514 insertions(+), 386 deletions(-)
>  create mode 100644 arch/sh/kernel/syscalls/Makefile
>  create mode 100644 arch/sh/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh
>
> --
> 1.9.1
>
