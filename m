Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A313EC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D6220842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIUx1o8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D6220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeJOMbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:31:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33379 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:31:51 -0400
Received: by mail-yb1-f193.google.com with SMTP id u88-v6so7026172ybi.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urTikZOFC/xFyAZBVpc/2F4KrKfhCiBOGIIT9NNjgt8=;
        b=MIUx1o8CV9bAFvr3xxRfpeHsi59P7DkV1MkqUUi/yH7H6S5vbc3LTrW458jpb9ijOw
         DpIqa76bbE77AdyIRyBjpHPqFHDrquxGb2dMnscAH/VMJiHCdijdvn2wMp6LyNVhxZpE
         B5OPd6NOAi1z2VgXWZ3Y64akP/E0DZXaVIv4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urTikZOFC/xFyAZBVpc/2F4KrKfhCiBOGIIT9NNjgt8=;
        b=kvASgEJQyKq6YBLrS3UNJYHQsHVPg7Sc7Fv9jK5Hhi9sY7kNA4t2LuHbtKAbKUZffI
         7gTCpN7KIzYpjX5S82RQ4JZ9mlz9jYVRoYn3lSYQQwk59ZpNOCrV3nRZiBM/mXwn05OL
         vHvp7g2rNBj9IIlOIIJwnn0XU9YDoVL3sbc3z2tUe6rGVbGAUCaciiJQvfog1+FiBNV2
         +qvZf7J16pKARU5uUuYnCIL2nu1VH/uUeuU6QkpjdzQjcHs0geks+NczkeFgYW75djmr
         cX31QtDkToFtsuPD7qkmMLjKf/woOs5VANyhAYxYXPRHjx0rfQlJ6tnS1xGbgXTAZGng
         vHLg==
X-Gm-Message-State: ABuFfogVxeWmlY4bi2/9M1y0yln54eZCv6ebGZhJYy+h9zqi7MkE+JWb
        iycdikog2YubS32rfP9VaPumnbzdmySr3NbnBvXQlg==
X-Google-Smtp-Source: ACcGV636xAmQtxcqDeKVKSY/1HNxSD4I3SbrwuLXK/E2kT+Wlc9IlXtFS0wIT9+HozbVCzkgrSet2BPCqmnP7cNY6A0=
X-Received: by 2002:a25:b127:: with SMTP id g39-v6mr8047966ybj.483.1539578899252;
 Sun, 14 Oct 2018 21:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org> <c6280818c999449646ec216984f2df9e@sf-tec.de>
In-Reply-To: <c6280818c999449646ec216984f2df9e@sf-tec.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 15 Oct 2018 10:18:07 +0530
Message-ID: <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
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

Hi Rolf,

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

I got this frame work from x86/entry/syscalls;
https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscallhdr.sh
I haven't modified the script but I tune this script to meet my requirements.

Sure, I'll look into this.

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

Is this what you suggested?
-           echo -e "#define __NR_${prefix}${name}\t$nr"
+           echo "#define __NR_${prefix}${name} $nr"

>
> > +     else
> > +         echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> > +     fi
> > +     nxt=$nr
> > +     let nxt=nxt+1
>
> Why do you use let here when you do $(()) calculations at other places?

Yes, will do this.
-        nxt=$nr
-        let nxt=nxt+1
+        nxt=$((nxt+1))

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

Sure!

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

Sure.

>
> > +
> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"
>
> "<<<" is a bash extension and will not work with /bin/sh.

Ohh, ok

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

Sure.

>
> > +        let nxt=nxt+1
>
> Inconsistent indentation.

I'm using emacs editor with default settings. In the actual file, there is no
indentation problem which I found but if I get patch using git format-patch,
it has inconsistent indentation.

No idea. I could find the same problem in other patches also.
Let me use the vi editor to save the file and get the patch.

Thanks
Firoz

>
> > +    done
> > +) > "$out"
>
> Eike
