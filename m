Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ACFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51A520874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLRLyC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:54:02 -0500
Received: from mail.accesssoftek.com ([12.202.173.242]:26810 "EHLO
        mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeLRLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:54:01 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 06:54:00 EST
Received: from vm-mail2k13.accesssoftek.com (172.16.0.242) by
 vm-mail2k13.accesssoftek.com (172.16.0.242) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Tue, 18 Dec 2018 03:38:59 -0800
Received: from vm-mail2k13.accesssoftek.com ([::1]) by
 vm-mail2k13.accesssoftek.com ([::1]) with mapi id 15.00.1395.000; Tue, 18 Dec
 2018 03:38:59 -0800
From:   George Rimar <grimar@accesssoftek.com>
To:     Tri Vo <trong@android.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruiu@google.com" <ruiu@google.com>
Subject: Re: [RFC PATCH] x86_64: Add "-m elf_i386" when linking i386 object
 files.
Thread-Topic: [RFC PATCH] x86_64: Add "-m elf_i386" when linking i386 object
 files.
Thread-Index: AQHUkNdwlIee1pwyXku0mPDK4R60X6V5GfsAgAF1d4CAAXxkgIAIXS6t
Date:   Tue, 18 Dec 2018 11:38:59 +0000
Message-ID: <1545132839351.85480@accesssoftek.com>
References: <20181210222635.80886-1-trong@android.com>
 <CAKwvOdkb0_hxwnO2T_F34i-MYN_MJksg973Yu1hfb8HeRCXMMQ@mail.gmail.com>
 <CAKwvOd=0=r7oNVZW6VHNjB8PvMF0Etn6fgRbrFdaQKeKHXyexQ@mail.gmail.com>,<CANA+-vBcxF7P1C+zddnqshKwMGuCSb97JC-=3==TwFeEGZP05w@mail.gmail.com>
In-Reply-To: <CANA+-vBcxF7P1C+zddnqshKwMGuCSb97JC-=3==TwFeEGZP05w@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [95.174.98.187]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Rui, an LLD code owner.

This patch contains the approach we discussed earlier during LLD development when
faced this issue first time (and as a result of the discussion,
the same fix was suggested: https://bugzilla.kernel.org/show_bug.cgi?id=194091#c0),
so I think it is fine.

Best regards,
George | Developer | Access Softek, Inc

________________________________________
От: Tri Vo <trong@android.com>
Отправлено: 12 декабря 2018 г. 22:48
Кому: Nick Desaulniers
Копия: bp@alien8.de; x86@kernel.org; tglx@linutronix.de; mingo@redhat.com; George Rimar; Dmitry Golovin; Bill Wendling; hpa@zytor.com; linux-kernel@vger.kernel.org
Тема: Re: [RFC PATCH] x86_64: Add "-m elf_i386" when linking i386 object files.

CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.

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
