Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FDgpLq92GlsVZAAAmS7hNA
	; Fri, 08 Jun 2018 12:29:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0AD78608BA; Fri,  8 Jun 2018 12:29:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8V6NSL1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68886606FA;
	Fri,  8 Jun 2018 12:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68886606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeFHM3k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:29:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41211 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeFHM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:29:38 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so19778781lfa.8;
        Fri, 08 Jun 2018 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CExVpsBKFlsJ3vlrRafg6ObeTjR62HPpf44UBNaUy0E=;
        b=H8V6NSL1Zi3QckkuLaP/o9KOyvMHqvw2EoL1tJbNcCTY62J0lWtV+b8bSRFzcmpw3A
         NvW1x0u0SRuVAZYper+0cL0z1773oPtrR3ehzwIt6NWqmad24tmsKtx+N5RtvkorSn+f
         r/KITb7mG+2lEoAz/AQCC7zDf0ww6bU66MI/FBaOhRs+hi46My50Ko0fAI/N/TZpypp/
         j3y9ADH6s7r3FwSiZFjaObg6FiAJdDTrnEcjYfwkaoTiNKkQg6VPE2G4i0u9xNqimXKi
         IG+iSLP1pWn3KIOqVghe8Yqk6wY6MylDHLUIctlTlyLwIz0GQzFudLA81eFHWJSvMaqJ
         XHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=CExVpsBKFlsJ3vlrRafg6ObeTjR62HPpf44UBNaUy0E=;
        b=fOw1l2vvey2Jl+/YKYKrZTg4OBhPu0CBygNUiJPp6jxEyiDbysuJ7RLiKiow9BSy9O
         XiSNZms98HGEOhGZCxKM7WzXNvdrikdb92ojgfsIh5vSq0cmRO6zNHiM/LpU5xmFITOh
         U13ZU+vf4SW4hq1SqUafrGgAjbzpJ17+jwu8xnTUiDxZD7m+r8UNlhXVkHJu0tB3ihbC
         keddILIMf9C4g7UtaY/rihugVZwdC5sYcqDdg8RMccljL3CZQnG8wEA4Vlo/GBD38Ind
         pI0fHf56rgkTplG89Mab8CVH/HyugdX1YNua5feo3ecVYLbPgIF18JT/rPnmoxufSykQ
         haiw==
X-Gm-Message-State: APt69E1LPcuItzCWxadVexoOQLyffpG/1gfXcRxp1zql3Z+N6NGpVWl5
        rIyeC5L89JKvFCbroPQMWR6Px7YYUNfMpoAQIAw=
X-Google-Smtp-Source: ADUXVKJ6sNj8CB8aPdIN7CodLUwFht/FkC3kw4fyzmo4c+9yjTN+6BOwqtIuQ1mgkLYCLdLX5zEWF7y8mlr7UKysaqs=
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr4320251ljh.1.1528460976426;
 Fri, 08 Jun 2018 05:29:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:b87:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 05:29:35 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <20180608112826.GA7484@andrea>
References: <20180607204927.219329-1-ndesaulniers@google.com>
 <20180607204927.219329-2-ndesaulniers@google.com> <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
 <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com> <20180608112826.GA7484@andrea>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 8 Jun 2018 14:29:35 +0200
Message-ID: <CA+icZUV0uJEDj0Y0rMNCp0tUTgv0wN-CL-Uynuoni0D4oUZJow@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>, mawilcox@microsoft.com,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, Brijesh Singh <brijesh.singh@amd.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 1:28 PM, Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
> On Fri, Jun 08, 2018 at 12:04:36PM +0200, Sedat Dilek wrote:
>> On Fri, Jun 8, 2018 at 9:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thu, Jun 7, 2018 at 10:49 PM, Nick Desaulniers
>> > <ndesaulniers@google.com> wrote:
>> >> Functions marked extern inline do not emit an externally visible
>> >> function when the gnu89 C standard is used. Some KBUILD Makefiles
>> >> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
>> >> an explicit C standard specified, the default is gnu11. Since c99, the
>> >> semantics of extern inline have changed such that an externally visible
>> >> function is always emitted. This can lead to multiple definition errors
>> >> of extern inline functions at link time of compilation units whose build
>> >> files have removed an explicit C standard compiler flag for users of GCC
>> >> 5.1+ or Clang.
>> >>
>> >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> >> Suggested-by: H. Peter Anvin <hpa@zytor.com>
>> >> Suggested-by: Joe Perches <joe@perches.com>
>> >
>> > I suspect this will break Geert's gcc-4.1.2, which I think doesn't have that
>> > attribute yet (4.1.3 or higher have it according to the documentation.
>> >
>> > It wouldn't be hard to work around that if we want to keep that version
>> > working, or we could decide that it's time to officially stop supporting
>> > that version, but we should probably decide on one or the other.
>> >
>>
>> Good point.
>> What is the minimum requirement of GCC version currently?
>
> Good question ;-)  (I recently had the impression that
> Documentation/process/changes.rst was making fun of me ;-)
>
>
>> AFAICS x86/asm-goto support requires GCC >= 4.5?
>>
>> Just FYI...
>> ...saw the last days in upstream commits that kbuild/kconfig for
>> 4.18-rc1 offers possibilities to check for cc-version dependencies.
>
> Good to know!  Mind retrieving/sharing the commit id(s)
> or links to the corresponding discussion on LKML?
>

Sorry, it is not yet in Linus upstream. see [1].

Documentation: kconfig: add recommended way to describe compiler support
kconfig: add CC_IS_CLANG and CLANG_VERSION
kconfig: add CC_IS_GCC and GCC_VERSION

- sed@ -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kbuild
