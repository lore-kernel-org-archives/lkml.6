Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D70C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B67620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="oNXSAPEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B67620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeLLTtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:49:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36632 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeLLTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:49:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so18854261otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLMq55J2CWN4XXAKy3D74O5Gl2Sszmh4ie5QklnSFnk=;
        b=oNXSAPEgdilUWtQ+xvDyB/MWYmhhbu4JWZHVSJ9sO4HePhCQ232hNMP1tbWx6fqcaz
         7ErPLVi/z3eqmt/tLClmioz2vG/Tr/1GbDSjPj+Pt5HuCv8Ikf0+AVe7B4FDfyzjC7qU
         vKkCjnjz/I1x2ETtr62Xp4DPe/7xG744QQtpZwXIQR5FH4Kq7uObB4G6ofM7qeZg5bUB
         yi06WqYkkWBaAf0jtPCE/4rVBeNUhRpy1GSQjauPx6f/Cy8/NqNf61MwE/0SDBT9thpm
         DpbS8Jsrbww9B1Iitf5sCpGAAiLNgkRPDSgq4jTjsV4zQ1h5mNYrtztmbfzaxJKmkmdo
         FpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLMq55J2CWN4XXAKy3D74O5Gl2Sszmh4ie5QklnSFnk=;
        b=amFaE1VVUa8+gAY4tg1JmLlU749dwAC0Wg9wpzDiKbuJ/3OevHkoelMnTMOJBNz7AN
         OgkcgRVQ/fGFwbuuT63P/CAmQcb25VNpCFZ0DDqVIfaCqHNawI3uMZ9mhvbzYMwcVOle
         ToCRVP8Ej8lMYsQ5zxg1WbL1lqbtw2MN10Sty4VFWC68asBxpXifKS9531uMCJUSZWZ7
         hyHOh7JMVpezsS6G4vkdvohgWgoA3jrEhEK1Cs1bALLiU+gcCUwhFy8Rlm/fEQfS4EOv
         nHLW8KKq1feQDc7QSmVxKm6dbureSYbtWq8psWRKTvYgz2oh4hs3m9CgY787yUHv0s/w
         9Y+Q==
X-Gm-Message-State: AA+aEWZVJ//h+pCFOsLbCJM9WpqZl5E5Fv1lHqpsrzJQE+POP144rKr4
        AfoDRZlc7RQKND13vKlXkjnwVL892HKPYAdd8f/LvQ==
X-Google-Smtp-Source: AFSGD/Vrb2io0oyCO0t0Ly1QhBJgHLU0qvvAJPrwjquLqLG+JaSIz0tTVITqRWLno3rv2vcUE2WQAyV+4ufuYv7BsqI=
X-Received: by 2002:a9d:477:: with SMTP id 110mr15914421otc.346.1544644142840;
 Wed, 12 Dec 2018 11:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20181210222635.80886-1-trong@android.com> <CAKwvOdkb0_hxwnO2T_F34i-MYN_MJksg973Yu1hfb8HeRCXMMQ@mail.gmail.com>
 <CAKwvOd=0=r7oNVZW6VHNjB8PvMF0Etn6fgRbrFdaQKeKHXyexQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=0=r7oNVZW6VHNjB8PvMF0Etn6fgRbrFdaQKeKHXyexQ@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 12 Dec 2018 11:48:51 -0800
Message-ID: <CANA+-vBcxF7P1C+zddnqshKwMGuCSb97JC-=3==TwFeEGZP05w@mail.gmail.com>
Subject: Re: [RFC PATCH] x86_64: Add "-m elf_i386" when linking i386 object files.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        grimar@accesssoftek.com, Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding appropriate people, lists.
On Tue, Dec 11, 2018 at 1:07 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Dec 10, 2018 at 2:50 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 2:26 PM Tri Vo <trong@android.com> wrote:
> > >
> > > From: George Rimar <grimar@accesssoftek.com>
> > >
> > > Linux kernel uses OUTPUT_FORMAT in it's linker scripts. Most of the time
> > > -m option is passed to the linker with correct architecture, but
> > > sometimes (at least for x86_64) the -m option contradicts OUTPUT_FORMAT
> > > directive. Specifically, arch/x86/boot and arch/x86/realmode/rm modules
> > > have i386 object files, but are linked with -m elf_x86_64 linker flag
> > > when building for x86_64.
> > >
> > > BFD and Gold linkers are OK with this, but lld fails:
> > > ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with elf_x86_64
> > >
> > > Suggested fix: just add correct -m after incorrect one (it overrides
> > > it), so the linker invocation looks like this: ld -m elf_x86_64 -z
> > > max-page-size=0x200000 -m elf_i386 --emit-relocs -T realmode.lds
> > > header.o trampoline_64.o stack.o reboot.o -o realmode.elf (it will also
> > > work with GNU ld, because it supports OUTPUT_FORMAT and just ignores -m
> > > options if this directive is in the linker script).
> > >
> > > Tested by building x86_64 kernel with GNU gcc/ld toolchain and booting
> > > it in QEMU.
> > >
> > > Suggested-by: Dmitry Golovin <dima@golovin.in>
> > > Signed-off-by: Tri Vo <trong@android.com>
> > > Tested-by: Tri Vo <trong@android.com>
> >
> > This fixes the following linkage error I observe when linking an x86
> > kernel with LLD:
> >
> > ```
> >   LD      arch/x86/realmode/rm/realmode.elf
> > ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/trampoline_64.o is incompatible
> > with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/stack.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/reboot.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/wakeup_asm.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/wakemain.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/video-mode.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/copy.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/bioscall.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/regs.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/video-vga.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/video-vesa.o is incompatible with elf_x86_64
> > ld.lld: error: arch/x86/realmode/rm/video-bios.o is incompatible with elf_x86_64
> > arch/x86/realmode/rm/Makefile:55: recipe for target
> > 'arch/x86/realmode/rm/realmode.elf' failed
> > ```
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Looks like we still have a few other (unrelated) issues to track down
> > with LLD, but this gets us one step closer.
> >
> > Thanks for sending this, Tri!
>
> Just some additional thoughts on this:
>
> The kernel is adding -m elf_x86_64 to the linker command line
> parameters, but then relying on binutils tie-breaking-behavior by
> specifying a different architecture via linker script. So it's
> ambiguous which arch the kernel is trying to link for, and the kernel
> gets lucky/relies on the way ld.bfd happens to resolve this ambiguity
> without warning. An alternative fix may be to just filter out/remove
> the -m elf_x86_64 for this target's linker flags.
>
> >
> > > ---
> > >  arch/x86/boot/Makefile        | 2 +-
> > >  arch/x86/realmode/rm/Makefile | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> > > index 9b5adae9cc40..e2839b5c246c 100644
> > > --- a/arch/x86/boot/Makefile
> > > +++ b/arch/x86/boot/Makefile
> > > @@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
> > >  AFLAGS_header.o += -I$(objtree)/$(obj)
> > >  $(obj)/header.o: $(obj)/zoffset.h
> > >
> > > -LDFLAGS_setup.elf      := -T
> > > +LDFLAGS_setup.elf      := -m elf_i386 -T
> > >  $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
> > >         $(call if_changed,ld)
> > >
> > > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> > > index 4463fa72db94..96cb20de08af 100644
> > > --- a/arch/x86/realmode/rm/Makefile
> > > +++ b/arch/x86/realmode/rm/Makefile
> > > @@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
> > >  targets += realmode.lds
> > >  $(obj)/realmode.lds: $(obj)/pasyms.h
> > >
> > > -LDFLAGS_realmode.elf := --emit-relocs -T
> > > +LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
> > >  CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
> > >
> > >  targets += realmode.elf
> > > --
> > > 2.20.0.rc2.403.gdbc3b29805-goog
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
