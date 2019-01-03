Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F4DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D4220578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfACLek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:34:40 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46672 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfACLej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:34:39 -0500
Received: by mail-vs1-f68.google.com with SMTP id n10so20550255vso.13;
        Thu, 03 Jan 2019 03:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGEN9n6vpOtSoS5EptpZmrhAbVElhR+k177Mo1KISio=;
        b=AJEfledgGD5h/197bpUXEA2oW/MqMtrcVpIYnqI6rSgaztz3PdKMAcswKWT51iiOwO
         tXRcPT5Nt26gR+NMcDRqIdlbhW/CJ47CEAaOMluf2EhM+4T9997O5xZrboVBSnSsAkox
         cSw5yUm9WY1MPk99LLTsvk9yowTVxnwNGeD2Wg07BMtBnJbyy8Z2oHoSd3gZKiwcuP4J
         G3XNPGSh2WZvCXBrJ72/NoBwR2zq/asMO4w5tDeNznkM9cmydzpkU/9GQkabLIY9JWWe
         5UaeYEQQyB2oVZj6AC0jCwup5A/3kZS/GBH1IAJEu12CFZvXoh29bZIij5+kmIGGZLsk
         2SBA==
X-Gm-Message-State: AA+aEWarke/IDCtPK0TRsOIswosgSkoCPwAKOVZs8DtGDhyJxS9Pw2V4
        21EDCIO5FMYgX1uN6HWEOwtDBwP41UWu3i6MCDSDSrUF
X-Google-Smtp-Source: AFSGD/UAoNwD8W5NalAoT9nsmVFfQLvFKt+lClljdO67LLPDwOsiCMoSkeRLiPXC8PAKFCTcVz7p/6YkCwNGhAoVmKw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr17067774vsj.11.1546515277324;
 Thu, 03 Jan 2019 03:34:37 -0800 (PST)
MIME-Version: 1.0
References: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Jan 2019 12:34:25 +0100
Message-ID: <CAMuHMdUS5rSmPaA75JEc-D0CKH5DkX6dfzu8n0CYy5O_JVAycg@mail.gmail.com>
Subject: Re: [PATCH] scripts: unify system call table generation scripts
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

Thanks for your patch!

On Wed, Jan 2, 2019 at 3:30 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures.

architectures

>
> In order to reduce the source code across all the
> above architectures, create common ".sh" files and
> keep it in the common directory, script/.
>
> This will be a generic scripts which can use for all

be generic scripts which can be used for all of

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

Currently, all but MIPS have the architecture name included in
the file guard.  Shouldn't that be retained?

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

I think this "\n" should be integrated into the previous printf,
as it terminates the previous output line.

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

Don't you want the architecture name in the file guard here, too?

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

Please add a space after the comma.

> +               t_nxt=$((t_nxt+1))
> +       done
> +       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"

Idem ditto.


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


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
