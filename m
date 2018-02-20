Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227+auaKKbBP6ES3A6yEVeq26umi3uVk4KY+5UnwCjqrX0d2KMjy1xma8NYHFX+5uBKmEzNa
ARC-Seal: i=1; a=rsa-sha256; t=1519139967; cv=none;
        d=google.com; s=arc-20160816;
        b=qIBNi8kjhYMm1L532fxM6MqP/nnEmUXuWUfQv/vx/EQqbYZbBgUUyMi4fa2gV8LxQ0
         CJqp190MsVVl8h1VbDTkLAFmkcfQD7TLX955x1hXmO433kavjQqQZq72DaV3G0+3B80c
         ATZy9gmtsiVNyzYYRI32KjPU9nPQELeFSVGqblxBYJcTNe2NfZoFyZxtLguNX7Drlmr8
         oEd6rZKckKgMF1G+Y5U/jMPW6RtZ8ZSTSREvGCnFz4KDGLgP6YSremRBpYVHR1HDCD9y
         /F6ONj5BLwium3c6oeSQgeYRRoKeuA7fGRC/ojSsyJr+E9/lTz2XYyFMIsGoItxevCN9
         5l5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=V3yE0lrE2kciOaBhmemzNNS8uxQ98XOWvd5V9BPNeBo=;
        b=AujXT/zhxl/ZzRcwU4z6myCmMbN0B1KWVD9p13cPaAGdzqdZ8kcRjXbs1z9XSCwEFn
         Yu9tEihZY8N05C/Ohqdk8anDzEVzwEZHTHc862tx6zgMPo8OcPet2yErISP+XoK9k9bJ
         aiM393+MNMEaYj/x0/Vbv6G7rR+pYATy6dTvmt0bN3xIDQNfKuw31kJkG2XMbS5HqYtr
         NZnRngcCV5vBMYn4Rp2q+8SB95HnWS6sCSrzQYf+ZQDgzKumWRqHogLV/S8mi3z/KOZj
         lz1NrIEbF4x6oQc+0gec9xqwl21cMK68Z1JsiWl0iPZo2XUyQi+9V9pF0iy0J+IedTrV
         oSkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=sQnt8Pdy;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=sQnt8Pdy;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1KFIqgD017056
X-Nifty-SrcIP: [209.85.217.171]
MIME-Version: 1.0
In-Reply-To: <20180219092245.26404-1-richard@nod.at>
References: <20180219092245.26404-1-richard@nod.at>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 00:18:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLQnWFO+qA94ifX8Gv1vMxGE-BOEhh1x2P-_mMUWRbAw@mail.gmail.com>
Message-ID: <CAK7LNASLQnWFO+qA94ifX8Gv1vMxGE-BOEhh1x2P-_mMUWRbAw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
To: Richard Weinberger <richard@nod.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at,
        kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>,
        Nicolas Pitre <nico@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592933711007401788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-19 18:22 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Don't source the kernel config file in shell scripts.
> The config file is not a shell script and often imported from untrusted
> sources.
> What could possible go wrong? ;-)


Please enumerate your real problems.


> Instead, read config file line by line and access config entries using a bash
> array.
>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Arnaud Lacombe <lacombar@gmail.com>
> Cc: Nick Bowler <nbowler@elliptictech.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Fixes: 23121ca2b56b ("kbuild: create/adjust generated/autoksyms.h")
> Fixes: 1f2bfbd00e46 ("kbuild: link of vmlinux moved to a script")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Changes since v1:
>  - Fixed out of tree build
> ---
>  scripts/adjust_autoksyms.sh | 13 +++----------
>  scripts/importkconf.sh      | 14 ++++++++++++++
>  scripts/link-vmlinux.sh     | 23 ++++++++---------------
>  3 files changed, 25 insertions(+), 25 deletions(-)
>  create mode 100755 scripts/importkconf.sh
>
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index 513da1a4a2da..b72a8a0bf08a 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -39,14 +39,7 @@ case "$KBUILD_VERBOSE" in
>  esac
>
>  # We need access to CONFIG_ symbols
> -case "${KCONFIG_CONFIG}" in
> -*/*)
> -       . "${KCONFIG_CONFIG}"
> -       ;;
> -*)
> -       # Force using a file from the current directory
> -       . "./${KCONFIG_CONFIG}"
> -esac
> +. ${KBUILD_SRC}/scripts/importkconf.sh
>
>  # In case it doesn't exist yet...
>  if [ -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
> @@ -62,14 +55,14 @@ EOT
>  [ "$(ls -A "$MODVERDIR")" ] &&
>  sed -ns -e '3{s/ /\n/g;/^$/!p;}' "$MODVERDIR"/*.mod | sort -u |
>  while read sym; do
> -       if [ -n "$CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX" ]; then
> +       if [ -n "${KERNEL_CONFIG[CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX]}" ]; then
>                 sym="${sym#_}"
>         fi
>         echo "#define __KSYM_${sym} 1"
>  done >> "$new_ksyms_file"
>
>  # Special case for modversions (see modpost.c)
> -if [ -n "$CONFIG_MODVERSIONS" ]; then
> +if [ -n "${KERNEL_CONFIG[CONFIG_MODVERSIONS]}" ]; then
>         echo "#define __KSYM_module_layout 1" >> "$new_ksyms_file"
>  fi
>
> diff --git a/scripts/importkconf.sh b/scripts/importkconf.sh
> new file mode 100755
> index 000000000000..755a9a2e9c65
> --- /dev/null
> +++ b/scripts/importkconf.sh
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +#
> +# helper script which reads all kconfig keys from the kernel .config file into
> +# a bash associative array.
> +# By testing ${KERNEL_CONFIG[CONFIG_FOO_BAR]} shell scripts can check whether
> +# CONFIG_FOO_BAR is set in .config or not.
> +#
> +
> +declare -A KERNEL_CONFIG
> +
> +for cfg_ent in $(awk -F= '/^CONFIG_[A-Z0-9_]+=/{print $1}' < ${KCONFIG_CONFIG})
> +do
> +       KERNEL_CONFIG[${cfg_ent}]="$cfg_ent"
> +done
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index c0d129d7f430..f48231f16c2f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -55,7 +55,7 @@ info()
>  #
>  archive_builtin()
>  {
> -       if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> +       if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
>                 info AR built-in.o
>                 rm -f built-in.o;
>                 ${AR} rcsTP${KBUILD_ARFLAGS} built-in.o                 \
> @@ -70,7 +70,7 @@ modpost_link()
>  {
>         local objects
>
> -       if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> +       if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
>                 objects="--whole-archive                                \
>                         built-in.o                                      \
>                         --no-whole-archive                              \
> @@ -96,7 +96,7 @@ vmlinux_link()
>         local objects
>
>         if [ "${SRCARCH}" != "um" ]; then
> -               if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> +               if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
>                         objects="--whole-archive                        \
>                                 built-in.o                              \
>                                 --no-whole-archive                      \
> @@ -116,7 +116,7 @@ vmlinux_link()
>                 ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}             \
>                         -T ${lds} ${objects}
>         else
> -               if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> +               if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
>                         objects="-Wl,--whole-archive                    \
>                                 built-in.o                              \
>                                 -Wl,--no-whole-archive                  \
> @@ -226,14 +226,7 @@ if [ "$1" = "clean" ]; then
>  fi
>
>  # We need access to CONFIG_ symbols
> -case "${KCONFIG_CONFIG}" in
> -*/*)
> -       . "${KCONFIG_CONFIG}"
> -       ;;
> -*)
> -       # Force using a file from the current directory
> -       . "./${KCONFIG_CONFIG}"
> -esac
> +. ${KBUILD_SRC}/scripts/importkconf.sh
>
>  # Update version
>  info GEN .version
> @@ -259,7 +252,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
>
>  kallsymso=""
>  kallsyms_vmlinux=""
> -if [ -n "${CONFIG_KALLSYMS}" ]; then
> +if [ -n "${KERNEL_CONFIG[CONFIG_KALLSYMS]}" ]; then
>
>         # kallsyms support
>         # Generate section listing all symbols and add it into vmlinux
> @@ -312,7 +305,7 @@ fi
>  info LD vmlinux
>  vmlinux_link "${kallsymso}" vmlinux
>
> -if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
> +if [ -n "${KERNEL_CONFIG[CONFIG_BUILDTIME_EXTABLE_SORT]}" ]; then
>         info SORTEX vmlinux
>         sortextable vmlinux
>  fi
> @@ -321,7 +314,7 @@ info SYSMAP System.map
>  mksysmap vmlinux System.map
>
>  # step a (see comment above)
> -if [ -n "${CONFIG_KALLSYMS}" ]; then
> +if [ -n "${KERNEL_CONFIG[CONFIG_KALLSYMS]}" ]; then
>         mksysmap ${kallsyms_vmlinux} .tmp_System.map
>
>         if ! cmp -s System.map .tmp_System.map; then
> --
> 2.13.6
>



-- 
Best Regards
Masahiro Yamada
