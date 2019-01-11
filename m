Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C05E218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h003NySW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfAKT1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:27:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36513 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfAKT1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:27:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so7182116plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ll451p/Iu/EmZHdBNk6yQvD4s7NmZUzr0N4onrkI94=;
        b=h003NySWd8/s9/sHj5lIOvTi+RaR39tyXKWRHK1o31NT+SpGAcqGh56xrZ56D7ZQgr
         yIXWMEBxD3oDN7IIiIhdJD0BzLzk0SNUqyRyqc/1s9TBYT/Nrm8oGaFr+Ci+Ge4kEpEB
         c5aSyqES4F6vGgvAzvweIa1oQ13TSuuMMONx2bIMlgMUx1KZDsnDc5/1A3/9MiQWxEl+
         Su8kiCjHYt+5xc8SLQbss6Y/pIwOH2aNmQ+tsbxu208FjHtp04mtdaM1JpN2Tq657AVD
         oJpBVmrdPkZcLqaBjeiCYjYUZHwINgXETvHwoGSCZF8PZTPhQEuO52Og0twTIvSerW7j
         eSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ll451p/Iu/EmZHdBNk6yQvD4s7NmZUzr0N4onrkI94=;
        b=kAmyTY/OK6ROdh6reDE5dMwq3YQ0abuobXWDsyYZV0m9hSUN18e0oko1QAJuBEE+UX
         DLug8tgCT5dcKMNim9y5MjPz2uDoIqFj4rtG56r1aNwVDiUXACwQMDPzu31iHdaanJ1S
         6cHYdxq2Gys2x53WVrGnBKzvOEOG1w5hNrfoeyEcNRBoG5iIjq8tS3A8sNPXvz/kkvs2
         seLemGa6G24HYxAXIPgjvAsqq1lvl4NdWr1rlXSJ0tZv4T8H9l05yGoevZ8a8aSf4SHy
         CQ3EJK+Awtu6oCymvLFUb8REbqwkhZG4tCV3hPbsVyNrytcn10CPuxYdvi+nje+1N53h
         byFg==
X-Gm-Message-State: AJcUukfsF7sWW4Necnf/ZrBnGvjfqwBiWiLTceqh7KeB7m4CPWY7xOtl
        /JC6Ng5JWd1ooCcHy3zOjCcQ0VcX/j/zt7iV5ExnZw==
X-Google-Smtp-Source: ALg8bN6xlBmUls9yUcNaKMw5eTM+qIKv3nQM65QMKeXpXR4mHEKV3VQYhD55sKUzZSaQeicoRPUpFAmTh3vkGtvY+x0=
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr16343983pln.229.1547234863613;
 Fri, 11 Jan 2019 11:27:43 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdnr1=Q=mL-P2icMTP8do3CVH+KF8564fKmpK_OshKxKwg@mail.gmail.com>
 <20190111191420.47731-1-trong@android.com>
In-Reply-To: <20190111191420.47731-1-trong@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Jan 2019 11:27:31 -0800
Message-ID: <CAKwvOdkR=1AzePbuFBcCW32shAK_cvR1iPiTGqHF=7MRH_oAjA@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64: Add "-m elf_i386" when linking i386 object files.
To:     Tri Vo <trong@android.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        George Rimar <grimar@accesssoftek.com>,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Michael Matz <matz@suse.de>,
        Rui Ueyama <ruiu@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:14 AM Tri Vo <trong@android.com> wrote:
>
> From: George Rimar <grimar@accesssoftek.com>
>
> Linux kernel uses OUTPUT_FORMAT in it's linker scripts. Most of the time
> -m option is passed to the linker with correct architecture, but
> sometimes (at least for x86_64) the -m option contradicts OUTPUT_FORMAT
> directive. Specifically, arch/x86/boot and arch/x86/realmode/rm modules
> have i386 object files, but are linked with -m elf_x86_64 linker flag
> when building for x86_64.
>
> "man ld" doesn't explicitly state any tie-breakers between -m and
> OUTPUT_FORMAT. BFD and Gold linkers override -m value with
> OUTPUT_FORMAT. But LLVM lld has a different behavior. When supplied with
> contradicting -m and OUTPUT_FORMAT values it fails with the following
> error message:
>
>   ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with elf_x86_64
>
> Suggested fix: just add correct -m after incorrect one (it overrides
> it), so the linker invocation looks like this: ld -m elf_x86_64 -z
> max-page-size=0x200000 -m elf_i386 --emit-relocs -T realmode.lds
> header.o trampoline_64.o stack.o reboot.o -o realmode.elf
>
> This is not a functional change for GNU ld, because (although not
> explicitly documented) it already overrides -m EMULATION with
> OUTPUT_FORMAT.
>
> Tested by building x86_64 kernel with GNU gcc/ld toolchain and booting
> it in QEMU.
>
> Suggested-by: Dmitry Golovin <dima@golovin.in>
> Signed-off-by: Georgii Rymar <grimar@accesssoftek.com>

misspelled, and you may carry forward my tested by tag from v1.

> Signed-off-by: Tri Vo <trong@android.com>
> Tested-by: Tri Vo <trong@android.com>
> ---

So when making a change, you can put any text below this `---`
delimiter.  For LKML, it's common practice to put something like:
v1 -> v2: updated commit message
That helps code review so reviewers know what to expect "inter-diff"
when eyeballing patch files.  Internally when using gerrit, it will
highlight inter-version diffs (ie. what changed between v2 and v3 of a
patch), but since we do things the hard way on LKML, this can help a
lot.  After `git format-patch ...`, I usually add such a comment to
the patch file in vim before sending.

>  arch/x86/boot/Makefile        | 2 +-
>  arch/x86/realmode/rm/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9b5adae9cc40..e2839b5c246c 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
>  AFLAGS_header.o += -I$(objtree)/$(obj)
>  $(obj)/header.o: $(obj)/zoffset.h
>
> -LDFLAGS_setup.elf      := -T
> +LDFLAGS_setup.elf      := -m elf_i386 -T
>  $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
>         $(call if_changed,ld)
>
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 4463fa72db94..96cb20de08af 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
>  targets += realmode.lds
>  $(obj)/realmode.lds: $(obj)/pasyms.h
>
> -LDFLAGS_realmode.elf := --emit-relocs -T
> +LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
>  CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
>
>  targets += realmode.elf
> --
> 2.20.1.97.g81188d93c3-goog
>


-- 
Thanks,
~Nick Desaulniers
