Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeEGGnw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:43:52 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:44633 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeEGGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:43:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w476hbkE021691
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AB8JxZpeFUP5hO7Oka6EAV8//JzXuhI51KSh7aQNzWP0CID+nI33BSifkJ5ZQ21DC94zjDN3jSJtAaABq1KA+qoCdqk=
MIME-Version: 1.0
In-Reply-To: <20180329180112.11055-4-labbott@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com> <20180329180112.11055-4-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 15:42:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARS9ZrN=cUaZJkQQHwNc-nuBc6p0YYRhTgGecDbyiWN6g@mail.gmail.com>
Message-ID: <CAK7LNARS9ZrN=cUaZJkQQHwNc-nuBc6p0YYRhTgGecDbyiWN6g@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 3/3] x86/vdso: Add build salt to the vDSO
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 3:01 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> The vDSO is linked separately from the kernel and modules. Ensure it picks
> up the comment section, if available.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Updated name
> ---
>  arch/x86/entry/vdso/vdso-layout.lds.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
> index acfd5ba7d943..7c78dd39aae8 100644
> --- a/arch/x86/entry/vdso/vdso-layout.lds.S
> +++ b/arch/x86/entry/vdso/vdso-layout.lds.S
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <asm/vdso.h>
> +#include <generated/build-salt.h>
>
>  /*
>   * Linker script for vDSO.  This is an ELF shared object prelinked to
> @@ -95,6 +96,8 @@ SECTIONS
>         .altinstructions        : { *(.altinstructions) }       :text
>         .altinstr_replacement   : { *(.altinstr_replacement) }  :text
>
> +       BUILD_ID_SALT
> +
>         /DISCARD/ : {
>                 *(.discard)
>                 *(.discard.*)
> --
> 2.16.2
>


For consistency, I think '-T scripts/build-salt.lds'
should be passed to cmd_vdso
in arch/x86/entry/vdso/Makefile.




-- 
Best Regards
Masahiro Yamada
