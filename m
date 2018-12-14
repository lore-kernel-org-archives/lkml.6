Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E42206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dheCeQMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbeLNS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:29:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32997 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbeLNS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:29:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so3235094pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94PkNb+JX0EV/T70vl+nXFd2wxyEz64GUa3UmqIQoE4=;
        b=dheCeQMq32SFRTXKjKNykVnFjCdRYnJE5vxvpF/4k9nEuK0V39AoLLcnTpIs3ov2u7
         uq1fFZ0Z/zQIvSy4aGC+Hqd2qC/pbe8d8ShylaSYl085x2mafwqmjgAMNTPOY95HiEux
         xvr7Bgnrd/EQ5QShlcsbIGbz+g90C5jzpHzt0eKbqFVvoAJ6vPW5AWGAoK/TlVb6HIv4
         BLmhBcrwzuqigB+OhhTlzG73LkEG8pF7+EKdpnnL4YLuhZfSkxlTW7lc2iDuN2riZOhn
         XPa4n6sbM8hNnO6NBCr2kaThqM5HPhJMWQHDWhmoCaghE8Fk6pNYnuoW9Wdk+fXvsW/n
         tAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94PkNb+JX0EV/T70vl+nXFd2wxyEz64GUa3UmqIQoE4=;
        b=tDvw90UYHnfbDhPsZJ0uCbBLsYsLfr2gI68F80n4HXvwfAJFAuWvptS/VGJSTTYuB8
         3obO5Fhhh2V1AyT0t0kJ7vBouhqawERmQvkmbhy6AeWGZBhPLUJmDJbetPiWpqTaf6Og
         XNYHGeKA4+mB5Hm5jn39HsZZkWA/5eP9QT8vBuvjsy4gpZ3f45vhLkL7p5MLrECCVMnn
         i03jYRTsWM17qlZOG9tofikmNd0DFnX27s5MvMbo1KFS9L0zTnkuogO6N3Cqq92RPlAj
         D7jAYLkgT6k1tDHAXoxMhYyJvtbymA6jOdPLpu9n27PivRx22xc135EQNxT7soXi0ILO
         WrjQ==
X-Gm-Message-State: AA+aEWb1FSnrSMlp8vEXoY+NV7qLiQEJ3dStYGLjL3QrfWlV0qQjY3v0
        q8qlXOxdVuvbQz+mOw70yphtAsmld2VlD3tiScbXlMEh1+w=
X-Google-Smtp-Source: AFSGD/VeAhtsmcvIdM9/a7gTjCwJ3Y53rBFxILP+pYOXavZ+KuynSZIwlwasbYbveQxtwpmdoZEsDmG8WKCmtBRn6q8=
X-Received: by 2002:a65:4683:: with SMTP id h3mr3472130pgr.225.1544812153247;
 Fri, 14 Dec 2018 10:29:13 -0800 (PST)
MIME-Version: 1.0
References: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Dec 2018 10:29:02 -0800
Message-ID: <CAKwvOdk9GVtaChCg0LhjyzY5zrqc3+cDdUpF-ui_+s8ZXzZ=Vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add -fno-PIE flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:06 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This flag is documented in the GCC 4.6 manual, and recognized by
> Clang as well. Let's rip off the cc-option switch.

The oldest GCC build that godbolt has (4.1) even recognizes it.
https://godbolt.org/z/buDBUr
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Makefile | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f2c3423..3bbc16a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -422,9 +422,9 @@ LINUXINCLUDE    := \
>                 -I$(objtree)/include \
>                 $(USERINCLUDE)
>
> -KBUILD_AFLAGS   := -D__ASSEMBLY__
> +KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
>  KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> -                  -fno-strict-aliasing -fno-common -fshort-wchar \
> +                  -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
>                    -Werror-implicit-function-declaration \
>                    -Wno-format-security \
>                    -std=gnu89
> @@ -510,9 +510,6 @@ RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc
>  export RETPOLINE_CFLAGS
>  export RETPOLINE_VDSO_CFLAGS
>
> -KBUILD_CFLAGS  += $(call cc-option,-fno-PIE)
> -KBUILD_AFLAGS  += $(call cc-option,-fno-PIE)
> -
>  # check for 'asm goto'
>  ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
>    CC_HAVE_ASM_GOTO := 1
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
