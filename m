Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4003728-1526256755-2-15766585093851354608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526256755; b=leukoWYbLMwLtrpqR6mF1gUwFqmlXzItzYWfU2zx/iMOfde2Hz
    qqmJJLbbEObPgzraiL4K0ba2/jjG5z7vffPj5EzIUhcOBjg3C08K0CJdoASC1zFf
    s+YKa59aZo7W5PCz7q22Dk7wD+1YG3gH39plDnJ0LJ2SMGTG0xDwwjM4uP2OS4lW
    s2mDMd9PZBnXK3Z5tv8ip4z0wf9s5QCDC+ym7hzHwHeFTkKwVuJL6A6xaufU1vUS
    Iu0KFnsmA3ffgNpI1/eaqZTs9leeHO/V5vTeSa/clPEFf6/5EdWpaVQiFRbTbq+j
    OCH5ygGctxCuAZn5qWdmyGzWcZeHTU8bW61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526256755; bh=m6pCNBlYzzZiPARzzSASsaecD6fX6CSaUNTrcYGs5J
    s=; b=aAdyZneeHqBggZzKIVs+76FsC1w5oIPhVZzJc1cPzT70QAEoYhe5EHwg1X
    jYHYAnZ5ZFu+mamVKj8IeRgv0D8cLLBaOMynQvzNLG+j61AudzhlYPCwD/C0XpgC
    y3v4+cGeBsyG8qxwXkxuQGQWgxQwJMQMhTPnD64wUBxCg3iG9kCh76lpMZ2ryS0c
    Zyg7tXDyttVgCq0E9SDg3a65bvWdEqKmkIjL6+gqWk+4BCjihwyyuGatpm2WZlRi
    tExasLwldmjMGyytFs596bCBr4yonvHHrj6o3VeSkvZR+SExO3lktbUxlgsS17hz
    rcvRJWZywRQDf6iwuAPYj0qgg/JA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
    header.i=@nifty.com header.b=17W+zfUc x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
      header.i=@nifty.com header.b=17W+zfUc x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAWXfiXGQ7/61aHO5yx7tS57SyFMXF4KOeugQvg2ZLDMk+sGBUmgh1F+yaKgwLRjnia50OQcyS4m48u33HFDWxRmuiZcejJECr3ALn0InPq6+Xc/icRU
    /SczkWKms44GquOgzFLB8UeLPEt+N5AqVRvV0zcAIywA35wAyTRrJuZ7B2KQWJuy7DlLlKHoOjMD7/FkbhRB2ylO3MU5DoUBd57w4ZEV+/taDwfwHdoQY1Pw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=c-n4J4-pAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=6JBxxDstyPuI-dKkIXMA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeENAMd (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 20:12:33 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27335 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeENAMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2018 20:12:33 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w4E0CIGC025627
X-Nifty-SrcIP: [209.85.213.54]
X-Google-Smtp-Source: AB8JxZo/geZJbQcnnp0CtSawE4uWPu1D9IKGjwQQH5xaYKdvI84SGMGiFnVTS/tbCSYS+5Rnoj+Cv1FCSlAnxJk0jg4=
MIME-Version: 1.0
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 14 May 2018 09:11:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRBZjvE3obyLsbeir1r57V1fFmn-dKE68E-8PfscUSRQ@mail.gmail.com>
Message-ID: <CAK7LNARRBZjvE3obyLsbeir1r57V1fFmn-dKE68E-8PfscUSRQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
 and clean-up code
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-09 16:23 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> I got acknowledge to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely.
> (https://lkml.org/lkml/2018/5/5/148)
>
> Several tools can be cleaned-up.
>
> Removing the CONFIG option makes VMLINUX_SYMBOL() no-op,
> so this macro can be removed too.
>
> VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR() are widely used,
> so it will take some time to kill them entirely.
> (I will send other patches later, splitting per-arch)
>
>
>
> Masahiro Yamada (8):
>   modpost: remove symbol prefix support
>   genksyms: remove symbol prefix support
>   kallsyms: remove symbol prefix support
>   depmod.sh: remove symbol prefix support
>   export.h: remove code for prefixing symbols with underscore
>   kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
>   vmlinux.lds.h: remove no-op macro VMLINUX_SYMBOL()
>   checkpatch: remove VMLINUX_SYMBOL() check


Applied to linux-kbuild.


>  Makefile                          |   2 +-
>  arch/Kconfig                      |   6 -
>  include/asm-generic/export.h      |  34 ++---
>  include/asm-generic/vmlinux.lds.h | 289 +++++++++++++++++++-------------------
>  include/linux/export.h            |  16 +--
>  scripts/Makefile.build            |   9 +-
>  scripts/adjust_autoksyms.sh       |   3 -
>  scripts/checkpatch.pl             |  10 --
>  scripts/depmod.sh                 |  21 +--
>  scripts/genksyms/genksyms.c       |  11 +-
>  scripts/kallsyms.c                |  47 ++-----
>  scripts/link-vmlinux.sh           |   4 -
>  scripts/mod/modpost.c             |  30 ++--
>  13 files changed, 188 insertions(+), 294 deletions(-)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
