Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBBB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ZxQMFrdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfAGXo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:44:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37096 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:44:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so1879927oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D9EGV++CycG7TvUl6UMhekXpHqZv4SUzLjFwjqnEQls=;
        b=ZxQMFrdTXws0bMwZU+Uz6fi+qktByqxAn1qXCNuajrG5ez/78Vw/J3Dr8ZB1dl2xAa
         2rAtL2v85KQ6sdCf1Och/8ZDyjayyIDQFDGgmJH0tZLyyd4/9MU0xd2WyNBE2Ddl/+aX
         F4w6b9bYojWiNaFHC6Naz2Z+8kEDZlW6N8Wm/cLVyWxfM1KNo0HOeI83tua8e0R8c0uy
         zZpEEgtKZ9GNcbOi4r//qHCdMcKYvqtsn4cTi7a6InivMcVE+QgMzAC7KrEThwTgVUvx
         OPle7CDP7UPUtea/Zd3ncfML6B4XwhdlQq1hDoeSLosjuQv5CsmBBVDPgGiWhGRwIehn
         iQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D9EGV++CycG7TvUl6UMhekXpHqZv4SUzLjFwjqnEQls=;
        b=tA8YLTdjRbXog0eBpuHSBBVpMaDUlGcNOO+VDudtGgHJyMIyOUekg6hZ0giKHcC+BA
         LiaVwxPpkt4eRMUHaeNyaqs/EbpWKSEXQDJdbUPyPt6MRdwC+yOGfynrH+S01REcqeGv
         qETJPkpfG+plFzGETvya10EmGI3iFCPAViOGqt+mq7MC770v30GJlleHULCVth4rm03o
         cJXAdensCGUO86gTtvbGMKYQ2sAUWmax9lDmb9ZSvwMd40+IAKGWkf0Ht/Pb95VigiQh
         2WelLPeXhLLtdJaYPZxi/k4pZwmQL9XZwwdhONtU9T4yPofkWNPt5hQVhEumBL3oACuL
         6uZQ==
X-Gm-Message-State: AJcUukfsCP2ntzue4qXHe+HxRyj1cwJq4cXOXEZiAeLrsbG/FGgGTHou
        ddKsa5XzrDlyeTWrpQxFzi5gc4Pdm/22flHZm3J22Q==
X-Google-Smtp-Source: ALg8bN4ze38Y9oo7geDutpuaevoV0IN3yoU7r/NOiIJiT3QGnwFLXDrmBJHsThC//Uca7hv4g7zKw0TWRjQEQLQhM+I=
X-Received: by 2002:aca:4155:: with SMTP id o82mr9637613oia.172.1546904666202;
 Mon, 07 Jan 2019 15:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20181210222635.80886-1-trong@android.com> <CAKwvOdkb0_hxwnO2T_F34i-MYN_MJksg973Yu1hfb8HeRCXMMQ@mail.gmail.com>
 <CAKwvOd=0=r7oNVZW6VHNjB8PvMF0Etn6fgRbrFdaQKeKHXyexQ@mail.gmail.com>
 <CANA+-vBcxF7P1C+zddnqshKwMGuCSb97JC-=3==TwFeEGZP05w@mail.gmail.com>
 <1545132839351.85480@accesssoftek.com> <CANA+-vCHXbmor5ha6kew+997CZwftYjxfovdYxhkPHGGj8_DmA@mail.gmail.com>
In-Reply-To: <CANA+-vCHXbmor5ha6kew+997CZwftYjxfovdYxhkPHGGj8_DmA@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 7 Jan 2019 15:44:15 -0800
Message-ID: <CANA+-vCq6-RBAxqZO0yFXm5Vq7qRRzsZbX=OsgcaxasEbZcV6w@mail.gmail.com>
Subject: Re: [RFC PATCH] x86_64: Add "-m elf_i386" when linking i386 object files.
To:     George Rimar <grimar@accesssoftek.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruiu@google.com" <ruiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending as plain text. Sorry.

On Mon, Jan 7, 2019 at 3:11 PM Tri Vo <trong@android.com> wrote:
>
> Hello, hope everyone's had great holidays.
> Could someone review at this patch?
>
> On Tue, Dec 18, 2018 at 3:39 AM George Rimar <grimar@accesssoftek.com> wr=
ote:
>>
>> Added Rui, an LLD code owner.
>>
>> This patch contains the approach we discussed earlier during LLD develop=
ment when
>> faced this issue first time (and as a result of the discussion,
>> the same fix was suggested: https://bugzilla.kernel.org/show_bug.cgi?id=
=3D194091#c0),
>> so I think it is fine.
>>
>> Best regards,
>> George | Developer | Access Softek, Inc
>>
>> ________________________________________
>> =D0=9E=D1=82: Tri Vo <trong@android.com>
>> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 12 =D0=B4=
=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2018 =D0=B3. 22:48
>> =D0=9A=D0=BE=D0=BC=D1=83: Nick Desaulniers
>> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: bp@alien8.de; x86@kernel.org; tglx@linut=
ronix.de; mingo@redhat.com; George Rimar; Dmitry Golovin; Bill Wendling; hp=
a@zytor.com; linux-kernel@vger.kernel.org
>> =D0=A2=D0=B5=D0=BC=D0=B0: Re: [RFC PATCH] x86_64: Add "-m elf_i386" when=
 linking i386 object files.
>>
>> CAUTION: This email originated from outside of the organization. Do not =
click links or open attachments unless you recognize the sender and know th=
e content is safe.
>>
>> Adding appropriate people, lists.
>> On Tue, Dec 11, 2018 at 1:07 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>> >
>> > On Mon, Dec 10, 2018 at 2:50 PM Nick Desaulniers
>> > <ndesaulniers@google.com> wrote:
>> > >
>> > > On Mon, Dec 10, 2018 at 2:26 PM Tri Vo <trong@android.com> wrote:
>> > > >
>> > > > From: George Rimar <grimar@accesssoftek.com>
>> > > >
>> > > > Linux kernel uses OUTPUT_FORMAT in it's linker scripts. Most of th=
e time
>> > > > -m option is passed to the linker with correct architecture, but
>> > > > sometimes (at least for x86_64) the -m option contradicts OUTPUT_F=
ORMAT
>> > > > directive. Specifically, arch/x86/boot and arch/x86/realmode/rm mo=
dules
>> > > > have i386 object files, but are linked with -m elf_x86_64 linker f=
lag
>> > > > when building for x86_64.
>> > > >
>> > > > BFD and Gold linkers are OK with this, but lld fails:
>> > > > ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with =
elf_x86_64
>> > > >
>> > > > Suggested fix: just add correct -m after incorrect one (it overrid=
es
>> > > > it), so the linker invocation looks like this: ld -m elf_x86_64 -z
>> > > > max-page-size=3D0x200000 -m elf_i386 --emit-relocs -T realmode.lds
>> > > > header.o trampoline_64.o stack.o reboot.o -o realmode.elf (it will=
 also
>> > > > work with GNU ld, because it supports OUTPUT_FORMAT and just ignor=
es -m
>> > > > options if this directive is in the linker script).
>> > > >
>> > > > Tested by building x86_64 kernel with GNU gcc/ld toolchain and boo=
ting
>> > > > it in QEMU.
>> > > >
>> > > > Suggested-by: Dmitry Golovin <dima@golovin.in>
>> > > > Signed-off-by: Tri Vo <trong@android.com>
>> > > > Tested-by: Tri Vo <trong@android.com>
>> > >
>> > > This fixes the following linkage error I observe when linking an x86
>> > > kernel with LLD:
>> > >
>> > > ```
>> > >   LD      arch/x86/realmode/rm/realmode.elf
>> > > ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with el=
f_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/trampoline_64.o is incompatible
>> > > with elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/stack.o is incompatible with elf=
_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/reboot.o is incompatible with el=
f_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/wakeup_asm.o is incompatible wit=
h elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/wakemain.o is incompatible with =
elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/video-mode.o is incompatible wit=
h elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/copy.o is incompatible with elf_=
x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/bioscall.o is incompatible with =
elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/regs.o is incompatible with elf_=
x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/video-vga.o is incompatible with=
 elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/video-vesa.o is incompatible wit=
h elf_x86_64
>> > > ld.lld: error: arch/x86/realmode/rm/video-bios.o is incompatible wit=
h elf_x86_64
>> > > arch/x86/realmode/rm/Makefile:55: recipe for target
>> > > 'arch/x86/realmode/rm/realmode.elf' failed
>> > > ```
>> > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>> > >
>> > > Looks like we still have a few other (unrelated) issues to track dow=
n
>> > > with LLD, but this gets us one step closer.
>> > >
>> > > Thanks for sending this, Tri!
>> >
>> > Just some additional thoughts on this:
>> >
>> > The kernel is adding -m elf_x86_64 to the linker command line
>> > parameters, but then relying on binutils tie-breaking-behavior by
>> > specifying a different architecture via linker script. So it's
>> > ambiguous which arch the kernel is trying to link for, and the kernel
>> > gets lucky/relies on the way ld.bfd happens to resolve this ambiguity
>> > without warning. An alternative fix may be to just filter out/remove
>> > the -m elf_x86_64 for this target's linker flags.
>> >
>> > >
>> > > > ---
>> > > >  arch/x86/boot/Makefile        | 2 +-
>> > > >  arch/x86/realmode/rm/Makefile | 2 +-
>> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
>> > > >
>> > > > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>> > > > index 9b5adae9cc40..e2839b5c246c 100644
>> > > > --- a/arch/x86/boot/Makefile
>> > > > +++ b/arch/x86/boot/Makefile
>> > > > @@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FO=
RCE
>> > > >  AFLAGS_header.o +=3D -I$(objtree)/$(obj)
>> > > >  $(obj)/header.o: $(obj)/zoffset.h
>> > > >
>> > > > -LDFLAGS_setup.elf      :=3D -T
>> > > > +LDFLAGS_setup.elf      :=3D -m elf_i386 -T
>> > > >  $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
>> > > >         $(call if_changed,ld)
>> > > >
>> > > > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/=
Makefile
>> > > > index 4463fa72db94..96cb20de08af 100644
>> > > > --- a/arch/x86/realmode/rm/Makefile
>> > > > +++ b/arch/x86/realmode/rm/Makefile
>> > > > @@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
>> > > >  targets +=3D realmode.lds
>> > > >  $(obj)/realmode.lds: $(obj)/pasyms.h
>> > > >
>> > > > -LDFLAGS_realmode.elf :=3D --emit-relocs -T
>> > > > +LDFLAGS_realmode.elf :=3D -m elf_i386 --emit-relocs -T
>> > > >  CPPFLAGS_realmode.lds +=3D -P -C -I$(objtree)/$(obj)
>> > > >
>> > > >  targets +=3D realmode.elf
>> > > > --
>> > > > 2.20.0.rc2.403.gdbc3b29805-goog
>> > > >
>> > >
>> > >
>> > > --
>> > > Thanks,
>> > > ~Nick Desaulniers
>> >
>> >
>> >
>> > --
>> > Thanks,
>> > ~Nick Desaulniers
