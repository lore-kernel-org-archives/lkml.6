Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F8C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rswUT8KV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeJXHKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:10:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:10:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so3428832wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JN1ntBK7pOKR2EidxWRrYtL2nFqpv4y1p4ZBZeaLSEg=;
        b=rswUT8KVTCz6MjHeeEVe9nSwviM4b15DxczHdcizNsg5vH+L3ojhHGR0x/NgghOtt4
         EsNOaZgQ8ZNOcng3ufWZG2S+YUL8/52Sb5Ch21jRXlX7PR+zM5wt6CNXG/xinUOjWt71
         UeWgntIinn6frNRMvmUBi0DP0+4TMs5uFgqRwP4+HCseSXZqH8r7vJEMljTyaMie6940
         rtqdjpzxKHwV3IzyKWZenpbicR5XxNqiqkPHRxXlgqepawIHOM/s2Yg+h4IiW9VOSLCf
         dGwljfPz6/a5DwjNmAF9cQTgZZXdx3xim4uNTsNDxWhmib3hoFTlfX4VtuGntp9cQV6E
         qb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JN1ntBK7pOKR2EidxWRrYtL2nFqpv4y1p4ZBZeaLSEg=;
        b=KXpKaQHTYc3AUZYLv5CFoiQLUqnGd7XHabAeBylBDkbQmDFRkww50UjVYdQ5LCLP+c
         mzRWfGO30CxLgOUycmYc1s4MmL+42CZrsN36LgyFgwo+MU6crCS+R5SXpTcNgNgJ/SgK
         NA1wbucgr/ijG2LgJpVYf+XlJqQgxyeXA2/bn2xmzc7doG5KiCXj0Wpzw26YIulx2z1P
         SCJw4DHyhWnrkpKJovsg6FsIb7eoA+KqpvVgsuDg15ccD6BpV0Dd6UCJyVbVjxdESnxw
         EQ3HI2UiLz6+uAIBryLnHkCy9UEPCuNO94IbagaZX8FLqBffHv0zbiX/3crQ7Sf/HX+W
         4kYQ==
X-Gm-Message-State: AGRZ1gL1aOHEqAb7DD2CGOVfWzIiFWF6aCkwd1xUUHl4uHxPUOVl//b8
        c4Pcio/Ycth0HeJ47Zlx4Jc=
X-Google-Smtp-Source: AJdET5fXP13ferTadCeakJqtG5nVKULYzus5cD8v1pXDnxIYPQj9XtTVm7y/D1lKFrHV2sAFH3aO4w==
X-Received: by 2002:adf:9b84:: with SMTP id d4-v6mr163708wrc.240.1540334678461;
        Tue, 23 Oct 2018 15:44:38 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y141-v6sm755474wme.10.2018.10.23.15.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 15:44:37 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:44:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     hpa@zytor.com, namit@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH RFC] x86: Don't include '-Wa,-' when building with Clang
Message-ID: <20181023224435.GA7163@flashbox>
References: <20181023003725.21463-1-natechancellor@gmail.com>
 <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com>
 <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com>
 <96ffedd2-a19d-95de-45fd-3a83025dd48a@zytor.com>
 <20181023215811.GA10771@flashbox>
 <CAKwvOd=-i0cVWuZaLQt5PQ11pa+gXaJCD_c6g9OTWwf79OS9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=-i0cVWuZaLQt5PQ11pa+gXaJCD_c6g9OTWwf79OS9Sw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 03:08:53PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 23, 2018 at 2:58 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 01:01:22PM -0700, H. Peter Anvin wrote:
> > > On 10/23/18 11:40, Nick Desaulniers wrote:
> > > > On Mon, Oct 22, 2018 at 10:11 PM Nadav Amit <namit@vmware.com> wrote:
> > > >>
> > > >> at 5:37 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >>
> > > >> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
> > > >> inline assembly code to work around asm() related GCC inlining bugs")
> > > >> added this flag to KBUILD_CFLAGS, where it works perfectly fine with
> > > >> GCC. However, when building with Clang, all of the object files compile
> > > >> fine but the build hangs indefinitely at init/main.o, right before the
> > > >> linking stage. Don't include this flag when building with Clang.
> > > >>
> > > >> The kernel builds and boots to a shell in QEMU with both GCC and Clang
> > > >> with this patch applied.
> > > >>
> > > >> Link: https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F213&amp;data=02%7C01%7Cnamit%40vmware.com%7C871daebc2ca44947d28d08d638811fb5%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636758524579997650&amp;sdata=shuxW81QRrO3TSqbgf462wgZYdLeAKeQEdGRxmnUX30%3D&amp;reserved=0
> > > >> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > >> ---
> > > >>
> > > >> The reason this patch is labeled RFC is while I can verify that this
> > > >> fixes the issue, I'm not entirely sure why the '-Wa,-' works for GCC
> > > >> and not Clang. I looked into what the flag means and I couldn't really
> > > >> find anything so I just assume it's taking input from stdin? The issue
> > > >> could stem from how GCC forks gas versus how Clang does it. If this
> > > >> isn't of concern and the maintainers are happy with this patch as is,
> > > >> feel free to take it.
> > > >>
> > >
> > > Perhaps someone could actually, you know, time the build and see how
> > > much -pipe actually matters, if at all?
> > >
> > >       -hpa
> > >
> >
> > Thank you for the suggestion! With the attached diff for removing
> > '-pipe' and 'make -j1' with defconfig (just to make sure any variance
> > would stand out), here are my results:
> >
> > -pipe (GCC):
> >
> > real    15m55.202s
> > user    14m17.748s
> > sys     1m47.496s
> >
> > No -pipe (GCC):
> >
> > real    16m4.430s
> > user    14m16.277s
> > sys     1m46.604s
> >
> > -pipe (Clang):
> >
> > real    21m26.016s
> > user    19m21.722s
> > sys     2m2.606s
> >
> > No -pipe (Clang):
> >
> > real    21m27.822s
> > user    19m22.092s
> > sys     2m4.151s
> 
> Looks like Clang eats `-pipe`:
> https://github.com/llvm-mirror/clang/blob/391667a023f79287f9c40868f34f08c161555556/lib/Driver/Driver.cpp#L962
> commit r110007 has the log:
>     Driver: Start ripping out support for -pipe, which is worthless
> and complicates
>     too many other things.
> 

In that case, we can either keep this change (I'll resend with the
explanation that Clang doesn't respect -pipe) or we can just rip out
-pipe for GCC too. Here are three separate results for GCC with my
normal jobs flag:

-pipe (GCC):

real    3m40.813s
real    3m44.449s
real    3m39.648s

No -pipe (GCC):

real    3m38.492s
real    3m38.335s
real    3m38.975s

Practically no variance.

Thanks,
Nathan

> >
> > Certainly seems like -pipe doesn't make a ton of difference. If this is
> > a better fix, I am happy to draft up a proper commit message and send
> > it out for review.
> >
> > ==================================================
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 73f4831283ac..672c689c1faa 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
> >  KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
> >  endif
> >
> > -# Speed up the build
> > -KBUILD_CFLAGS += -pipe
> >  # Workaround for a gcc prelease that unfortunately was shipped in a suse release
> >  KBUILD_CFLAGS += -Wno-sign-compare
> >  #
> > @@ -239,7 +237,7 @@ archheaders:
> >  archmacros:
> >         $(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
> >
> > -ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
> > +ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
> >  export ASM_MACRO_FLAGS
> >  KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
