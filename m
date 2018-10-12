Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D95CC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BEC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaUTNaz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BEC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeJLVaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:30:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34521 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeJLVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:30:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id m129-v6so4986197ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDR8cBCAux9gPq7pPMigmtKG5j3yetuE5TZg3+cnUa8=;
        b=WaUTNaz76TPZi6zwzw4ZK1X/B2IrHxyaC1DEfGT7vq3+Fy0iJmdF6sbrLa9ifdO/KK
         dBeJc/wVz/9TZFbSCF9qRUG+CWIZZraK+UYiDVDRbA1FhmQ7WYf0x9PhZGpi0ZBbolmC
         WGYn8k/g7naKtjNpggkpm0Je3sb37y4lC5jM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDR8cBCAux9gPq7pPMigmtKG5j3yetuE5TZg3+cnUa8=;
        b=gsy5QZep/Sn+Pzzl48j2EIkrHGjsL4GgU+Ub1Pp7yN1EP5Ki8Xjw/XApBcPuApffWg
         R0faNMOgu9FkvvKnqxfdQWOBXADOnKvh4zYqsPLvEUpUcQRwd5tpKTeMpCEBi5BPtkrM
         eQ8eS67XbCJN1DnXJn7WkBT2EOf6edP7cXIXpNc2Q9oCTJgMvjoO3yvAy79Cab0WCdfW
         ByTB9fxOCuOq2wegJoZMo0kcD7j5bY037E3QDHiqQgn22wwKUfxVK6SY89dSwGhLgysC
         4ME2g20w8o9RgKPtqNlTR+pR9dVh/CvjRi2maLapwISbVnNNE7J3VkodLGr8558cxH2C
         4zQg==
X-Gm-Message-State: ABuFfoj3n8IE8sCwCIjyI4z1yiGh36KENXStyz9X6SJUUdEglrOo3UTQ
        r5m0O/XSlcIz7Mr7x5vZTGiPEgo4427CsBUe48+BOg==
X-Google-Smtp-Source: ACcGV628besiVQKgfwFzErPTquB3lD9XVvGMMb0stdIe8ffiBUYtuou+2IrqwUr1FNzsHBp6YkxXGym2589+jQ+AkOI=
X-Received: by 2002:a81:1b85:: with SMTP id b127-v6mr3517264ywb.381.1539352653412;
 Fri, 12 Oct 2018 06:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org> <c6280818c999449646ec216984f2df9e@sf-tec.de>
In-Reply-To: <c6280818c999449646ec216984f2df9e@sf-tec.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 12 Oct 2018 19:27:22 +0530
Message-ID: <CALxhOnggUEkXVVupq0SebJV0StKqbTTCqQtaaao+oQveUFHgbg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
To:     eike-kernel@sf-tec.de
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-parisc-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Rolf,

Thanks for the comments. It will help me to fine tune my scripts!

On Fri, 12 Oct 2018 at 17:37, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>
> Firoz Khan wrote:
>
> > diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh
> > b/arch/parisc/kernel/syscalls/syscallhdr.sh
> > new file mode 100644
> > index 0000000..607d4ca
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +in="$1"
> > +out="$2"
> > +my_abis=`echo "($3)" | tr ',' '|'`
>
> Any reason not to use $() instead of backticks?
>
> > +prefix="$4"
> > +offset="$5"
> > +
> > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > +    echo "#ifndef ${fileguard}"
> > +    echo "#define ${fileguard}"
> > +    echo ""
> > +
> > +    nxt=0
> > +    while read nr abi name entry compat ; do
> > +     if [ -z "$offset" ]; then
> > +         echo -e "#define __NR_${prefix}${name}\t$nr"
>
> This mixed indentation with both tabs and spaces is a bit messy.
>
> > +     else
> > +         echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> > +     fi
> > +     nxt=$nr
> > +     let nxt=nxt+1
>
> Why do you use let here when you do $(()) calculations at other places?
>
> > +    done
> > +
> > +    echo ""
> > +    echo "#ifdef __KERNEL__"
> > +    echo -e "#define __NR_syscalls\t$nxt"
> > +    echo "#endif"
> > +    echo ""
> > +    echo "#endif /* ${fileguard} */"
> > +) > "$out"
> > diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh
> > b/arch/parisc/kernel/syscalls/syscalltbl.sh
> > new file mode 100644
> > index 0000000..04abde7
> > --- /dev/null
> > +++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
> > @@ -0,0 +1,46 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +in="$1"
> > +out="$2"
> > +my_abis=`echo "($3)" | tr ',' '|'`
> > +offset="$4"
> > +
> > +emit() {
> > +    nxt="$1"
> > +    if [ -z "$offset" ]; then
> > +     nr="$2"
> > +    else
> > +     nr="$2"
> > +     nr=$((nr+offset))
>
> This could be one line, no? Or just set offset to 0 if it is empty and
> avoid that if alltogether.
>
> > +    fi
> > +    entry="$3"
> > +
> > +    while [ $nxt -lt $nr ]; do
> > +     echo "__SYSCALL($nxt, sys_ni_syscall, )"
> > +        let nxt=nxt+1
> > +    done
> > +    echo "__SYSCALL($nxt, $entry, )"
> > +}
> > +
> > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > +    if [ -z "$offset" ]; then
> > +     nxt=0
> > +    else
> > +     nxt=$offset
> > +    fi
>
> Another argument for offset=0 as default.
>
> > +
> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"

Here is the logic of identifying the generated script is for compat interface
or not. So systbl_abi_syscall_table_c32 := common,compat,32 in Makefile
will parse the script and check the second string whether this is
"compat" or not.

Other ways are:
1. add an extra flag, that will again add the complexity
2. check if [ ${out: -5} = "c32.h" ], this looks weird

Is there any better way to do the same?

>
> "<<<" is a bash extension and will not work with /bin/sh.
>
> > +    while read nr abi name entry compat ; do
> > +     if [ $my_abi = "compat" ]; then
> > +         if [ -z "$compat" ]; then
> > +             emit $nxt $nr $entry
> > +         else
> > +             emit $nxt $nr $compat
> > +         fi
> > +     else
> > +         emit $nxt $nr $entry
> > +     fi
>
> I would go for a local variable being set to $compat or $entry and
> calling emit at only one place. And there should be only one if with 2
> expressions, no need for 3 branches.
>
> > +        let nxt=nxt+1
>
> Inconsistent indentation.
>
> > +    done
> > +) > "$out"

I'll address rest of the comment soon.

Helge, I can update this patches asap with their comments and we can
perform the
boot test with next version. And thanks for your great support!

Firoz

>
> Eike
