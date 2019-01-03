Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF62C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3072073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4c8QWv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfACLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:35:10 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35764 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfACLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:35:09 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so42306127itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlErxfKTv2SbJMpGLa1PyKEj4C9pXXCOHh54jBDCiZ4=;
        b=J4c8QWv3iz4G9g60Hx1iVunp81ed/7dBzqmFS/WbL2mZQuMfTW1f6uTzx2BSKn6/5W
         n8Lt7DG3dET5TslNSw5ry/CfpDuZacYBVjz+XuC/z7/FUbIaTYPJlk979oc0RJ1QRXcC
         c5cT9XWxvfbLVRg10qmXGXfOnVkPcsH8CyUFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlErxfKTv2SbJMpGLa1PyKEj4C9pXXCOHh54jBDCiZ4=;
        b=D7Mx4jCrl6MSbksHlRwCcWRMaFTIViaBorV9B0yWHaWAF+w8Fnmbt/wwC9BGtlAeMk
         FnJ2A4eNgOpySbXdJ9Jl3PPvc/08ybqhMC77npyX2avyef4wfZbXyZb4fPCK46Ut9QGO
         AxSnEHPoN9XO1W9VP2/I/BROmBVqCXduuxxNXCt/c/SGeLGId59LKt7GDwuL7q6mtSvM
         U/9ZBhX28/QptlbyyANFc2iztoEl98N9DbGDW8ZJIxAoJ9s4Nf/2xBIIaMXT/eypxn+p
         Q030ctPtj3/LTsRHmbv58d60qAsXOeWSS1koEqA1DlVKAvJEqWoSwQYGY2FohftrQcVA
         bbTQ==
X-Gm-Message-State: AJcUukcBR3/S+EpziOArRtEIblDmNrSnS5/WkbAdiTiNp3PG4u79ijf2
        26UalZz09MD2za2K+VcGV0hZyUdIePCFi88F3oJbaQ==
X-Google-Smtp-Source: ALg8bN7GkuLB0uQfOE93mYlFJ/kAf0cTBwK4aDv/iNWrXH2uieTVRhki811Va2dHisk9Pjdom0JKeKx/KnCoMi1HuLw=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr28307916iti.166.1546515308589;
 Thu, 03 Jan 2019 03:35:08 -0800 (PST)
MIME-Version: 1.0
References: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 3 Jan 2019 17:04:57 +0530
Message-ID: <CALxhOnjz3Qd-a0OWMDV9ShfPOUB8gNB5Ltp9HGZi01mauaxkuw@mail.gmail.com>
Subject: Re: [PATCH] scripts: unify system call table generation scripts
To:     Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Henderson <rth@twiddle.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
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

++ adding more folks I closely worked with :)


On Wed, 2 Jan 2019 at 19:59, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures.
>
> In order to reduce the source code across all the
> above architectures, create common ".sh" files and
> keep it in the common directory, script/.
>
> This will be a generic scripts which can use for all
> the above architectures.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  scripts/syscallhdr.sh | 37 +++++++++++++++++++++++++++++++++++++
>  scripts/syscallnr.sh  | 32 ++++++++++++++++++++++++++++++++
>  scripts/syscalltbl.sh | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 scripts/syscallhdr.sh
>  create mode 100644 scripts/syscallnr.sh
>  create mode 100644 scripts/syscalltbl.sh
>
> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> new file mode 100644
> index 0000000..d03fe3d
> --- /dev/null
> +++ b/scripts/syscallhdr.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_`basename "$out" | sed \
> +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       printf "#ifndef %s\n" "${fileguard}"
> +       printf "#define %s\n" "${fileguard}"
> +       printf "\n"
> +
> +       nxt=0
> +       while read nr abi name entry compat ; do
> +               if [ -z "$offset" ]; then
> +                       printf "#define __NR_%s%s\t%s\n" \
> +                               "${prefix}" "${name}" "${nr}"
> +               else
> +                       printf "#define __NR_%s%s\t(%s + %s)\n" \
> +                               "${prefix}" "${name}" "${offset}" "${nr}"
> +               fi
> +               nxt=$((nr+1))
> +       done
> +
> +       printf "\n"
> +       printf "#ifdef __KERNEL__\n"
> +       printf "#define __NR_syscalls\t%s\n" "${nxt}"
> +       printf "#endif\n"
> +       printf "\n"
> +       printf "#endif /* %s */" "${fileguard}"
> +       printf "\n"
> +) > "$out"
> diff --git a/scripts/syscallnr.sh b/scripts/syscallnr.sh
> new file mode 100644
> index 0000000..8cf33fa
> --- /dev/null
> +++ b/scripts/syscallnr.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_`basename "$out" | sed \
> +       -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +       -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       printf "#ifndef %s\n" "${fileguard}"
> +       printf "#define %s\n" "${fileguard}"
> +       printf "\n"
> +
> +       nxt=0
> +       while read nr abi name entry compat ; do
> +               nxt=$((nr+1))
> +       done
> +
> +       if [ ! -z "$prefix" ]; then
> +               printf "#define __NR_%s_Linux_syscalls\t%s\n" "${prefix}" "${nxt}"
> +               if [ ! -z "$offset" ]; then
> +                       printf "#define __NR_%s_Linux\t%s\n" "${prefix}" "${offset}"
> +               fi
> +       fi
> +       printf "\n"
> +       printf "#endif /* %s */" "${fileguard}"
> +       printf "\n"
> +) > "$out"
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> new file mode 100644
> index 0000000..f60f762
> --- /dev/null
> +++ b/scripts/syscalltbl.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +my_abi="$4"
> +offset="$5"
> +
> +emit() {
> +       t_nxt="$1"
> +       t_nr="$2"
> +       t_entry="$3"
> +
> +       while [ $t_nxt -lt $t_nr ]; do
> +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
> +               t_nxt=$((t_nxt+1))
> +       done
> +       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
> +}
> +
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +       nxt=0
> +       if [ -z "$offset" ]; then
> +               offset=0
> +       fi
> +
> +       while read nr abi name entry compat ; do
> +               if [ "$my_abi" = "c32" -o "$my_abi" = "64_o32" ] &&
> +                       [ ! -z "$compat" ]; then
> +                       emit $((nxt+offset)) $((nr+offset)) $compat
> +               else
> +                       emit $((nxt+offset)) $((nr+offset)) $entry
> +               fi
> +               nxt=$((nr+1))
> +       done
> +) > "$out"
> --
> 1.9.1
>
