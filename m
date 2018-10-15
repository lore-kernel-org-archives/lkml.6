Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58893C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AAA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLeuSbVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AAA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJOLzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:55:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37965 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:55:47 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so7053793ywa.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZzrzM/P11tNpQwuxr0Ej844ilk67duvnJg3EHaHzFo=;
        b=aLeuSbVLzw6nm4lRFutITNaLMtO5YPaRnp8SOBSSGXoRxV8fP5EXpj1JkgkdScLE63
         Nc2a3g1CWK6Jps/dYYSiYsW2ASZsSm0scGlt++0LHTaymbu+5sAnOTUqTM8bsas+gPTp
         D6oOK1Ql67QCnVQzC6gqsmAC3V3Ha0METuTuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZzrzM/P11tNpQwuxr0Ej844ilk67duvnJg3EHaHzFo=;
        b=GaQjDoLyvBifwDhTJkKz9g55/UiBz2j1bpNTJ3ZC2nOfcjdLebtJSdMMU0tAvcgReg
         WTdMHUeqqugP0IuS+PbZhTcAX4wKuEBSIhSKRaK/YBJQPoGW1CnFQzhzpYxoMpJDFDll
         g/FleefIPPr3I8OEzocoytgR+IA73n/8PtQBxla5wXMXxTqG2jy2+jZkWLRdGHVHnCpS
         jbBz58lS60Ao+GZXnmdaHSrhA2LgEJPNvIU8a4aXMUXi66ynS3F7OV3RkWDHqlzaxfxQ
         j4/PRUGZ0YxStu9rn2lI+9QzKdPHQqTpC/I9nBSbIitkofo2mSVfxTmP4PGp2BLD88Ol
         zlIg==
X-Gm-Message-State: ABuFfohq+nkcvQRhIyXmwlQJxu9hb+g6gIK9y3m4IE0zttGnSP4bt5Q7
        GNI7dr55UrZ93USJ0TQBmPDvIFE5/VPMSSypMp/frg==
X-Google-Smtp-Source: ACcGV63gu1cBMfEGKHnqI9GaSceSE6mWO5lyged0cUWyXjuUqudmjKcZi3V11903Ou8KWk+bzay4wto2EAGhbUz8nFc=
X-Received: by 2002:a81:5f86:: with SMTP id t128-v6mr8641300ywb.84.1539576741828;
 Sun, 14 Oct 2018 21:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
 <1538397477-4003-4-git-send-email-firoz.khan@linaro.org> <alpine.LNX.2.21.1810020843320.10@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1810020843320.10@nippy.intranet>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 15 Oct 2018 09:42:10 +0530
Message-ID: <CALxhOnhzKeax4fC2yibSU38+7JDgA6MearVTbF=CU+4cQGakHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] m68k: add system call table generation support
To:     fthain@telegraphics.com.au
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

Hi Finn,

On Tue, 2 Oct 2018 at 04:22, Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Mon, 1 Oct 2018, Firoz Khan wrote:
>
> > --- /dev/null
> > +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/sh
>
> That's not accurate. These are bash scripts, not Bourne shell.
>
> If you run 'checkbashisms', you'll see that a few small changes are needed
> in order to gain standards compliance and portability.

Sure.

>
> Some untested suggestions:
>
> diff --git a/arch/m68k/kernel/syscalls/syscallhdr.sh b/arch/m68k/kernel/syscalls/syscallhdr.sh
> index e0e3108cfc7f..9811f82848e6 100644
> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -18,17 +18,17 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>      nxt=0
>      while read nr abi name entry ; do
>         if [ -z "$offset" ]; then
> -           echo -e "#define __NR_${prefix}${name}\t$nr"
> +           echo "#define __NR_${prefix}${name} $nr"
>         else
> -           echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> +           echo "#define __NR_${prefix}${name} ($offset + $nr)"
>         fi
>         nxt=$nr
> -       let nxt=nxt+1
> +       nxt=$((nxt+1))
>      done
>
>      echo ""
>      echo "#ifdef __KERNEL__"
> -    echo -e "#define __NR_syscalls\t$nxt"
> +    echo "#define __NR_syscalls        $nxt"
>      echo "#endif"
>      echo ""
>      echo "#endif /* ${fileguard} */"
> diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
> index d2635dea4e96..89ab047097ce 100644
> --- a/arch/m68k/kernel/syscalls/syscalltbl.sh
> +++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
> @@ -13,7 +13,7 @@ emit() {
>
>      while [ $nxt -lt $nr ]; do
>         echo "__SYSCALL($nxt, sys_ni_syscall, )"
> -       let nxt=nxt+1
> +       nxt=$((nxt+1))
>      done
>
>      echo "__SYSCALL($nr, $entry, )"
> @@ -29,6 +29,6 @@ grep '^[0-9]' "$in" | sort -n | (
>      while read nr abi name entry ; do
>         emit $nxt $nr $entry
>         nxt=$nr
> -        let nxt=nxt+1
> +        nxt=$((nxt+1))
>      done
>  ) > "$out"

Thanks for your comments! I'll have a look into it.

Firoz
>
> --
