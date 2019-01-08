Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2378CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61362070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eo58r4fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfAHUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:46:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45354 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfAHUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:46:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so2230399pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LusyIAyjb0RJtn/ST8iJUYesxIhGya7nyXVh7SKbByQ=;
        b=eo58r4fhxqIBQvHyNhUfYczeSbuFV5vCUPXwL8b2YZgr4w06DW5Dci6B4nSH7Cvs7m
         8uH0cif6ucn4e4TTIbyC+M1EVWALhiQzwxlfhr1KtkqU68MFRXjgof8HsPftqNvYZzzf
         eKljH1yjFpgbiwU8tBgBGjY74gUOIVEhbRt7tcqZft7VNvNsJlarU9B/Gveek2ycQgYy
         jHsRcRTwr/mCtATXX9mtbNe/FD6WZaD6b0kK5/LlW7zW1IxhjAeaeRktHnzWlHguvS3F
         dUZdaTHRsMNkyF8XJolOTOOQKgNYCnR1gN+dnMC36yENMY8B2G95n3TYeXeFsN3yJ8t1
         u8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LusyIAyjb0RJtn/ST8iJUYesxIhGya7nyXVh7SKbByQ=;
        b=aHPttxNfz+A+RzMmBJzS2YaxXo5TkQASAvOo5gJIrwzymSBofxlNInWnGXvDF/HLJH
         RbKzuFqwoiMWADKwBhcKMZej/o57JiNCue+fNNGkaCynmFcjBWf5sKUkog8tdRQJOCR8
         g61O8Llf5qtwmNjQEl5TmZ083BK/o6Ta06YPspWim9ZYGrKEi7PZKLcqkPYT0nMjh1+D
         vEfk7JIjAHKMXMFtSLhSGjsRrO1NdvMwpNDSGOJeWUHiEvr+KrHRHsuCivvszOlagWeb
         k1l9YiravN6DaceLa2a+9ttetk4LtaiUfaP/YeX2gLv3L8HIZ+dwek3G4RxLYNyLD38s
         5smA==
X-Gm-Message-State: AJcUukcB3/O+Ahpof0jH/5yh0sNAp3iq2DOT41kmHGXd5gJyquV1RkeQ
        mSSjOw0Mppi4TUHsJwEwqFEebuItQYRzXtp6w1E0qQ==
X-Google-Smtp-Source: ALg8bN7Y40WSHIUv36xMPIajhFMJlubfdLGYcYdtUymkHGbHMPSfaQlrNzTX7LAPLJqLqFtwkXi7KgRmTv51U6/erSo=
X-Received: by 2002:a62:2c81:: with SMTP id s123mr3191929pfs.174.1546980388107;
 Tue, 08 Jan 2019 12:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20181210222635.80886-1-trong@android.com> <CAKwvOdkb0_hxwnO2T_F34i-MYN_MJksg973Yu1hfb8HeRCXMMQ@mail.gmail.com>
 <CAKwvOd=0=r7oNVZW6VHNjB8PvMF0Etn6fgRbrFdaQKeKHXyexQ@mail.gmail.com>
 <CANA+-vBcxF7P1C+zddnqshKwMGuCSb97JC-=3==TwFeEGZP05w@mail.gmail.com>
 <1545132839351.85480@accesssoftek.com> <CANA+-vCHXbmor5ha6kew+997CZwftYjxfovdYxhkPHGGj8_DmA@mail.gmail.com>
 <CANA+-vCq6-RBAxqZO0yFXm5Vq7qRRzsZbX=OsgcaxasEbZcV6w@mail.gmail.com>
In-Reply-To: <CANA+-vCq6-RBAxqZO0yFXm5Vq7qRRzsZbX=OsgcaxasEbZcV6w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jan 2019 12:46:16 -0800
Message-ID: <CAKwvOd=5QTE=cwkvgfxsUnv4A1dQcZDyiM=PWGCh7_uAd1vwKA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86_64: Add "-m elf_i386" when linking i386 object files.
To:     "bp@alien8.de" <bp@alien8.de>
Cc:     George Rimar <grimar@accesssoftek.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruiu@google.com" <ruiu@google.com>, Tri Vo <trong@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 7, 2019 at 3:11 PM Tri Vo <trong@android.com> wrote:
> >
> > Hello, hope everyone's had great holidays.
> > Could someone review at this patch?

Boris,
I assume Tri meant to post this to you in the To: line?  I'm happy
with this patch, and am happy to add my reviewed by tag (in addition
to my tested-by below), but I think Tri meant to ask you.  WDYT?

> >
> > On Tue, Dec 18, 2018 at 3:39 AM George Rimar <grimar@accesssoftek.com> =
wrote:
> >>
> >> Added Rui, an LLD code owner.
> >>
> >> This patch contains the approach we discussed earlier during LLD devel=
opment when
> >> faced this issue first time (and as a result of the discussion,
> >> the same fix was suggested: https://bugzilla.kernel.org/show_bug.cgi?i=
d=3D194091#c0),
> >> so I think it is fine.
> >>
> >> Best regards,
> >> George | Developer | Access Softek, Inc
> >>
> >> ________________________________________
> >> =D0=9E=D1=82: Tri Vo <trong@android.com>
> >> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 12 =D0=
=B4=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2018 =D0=B3. 22:48
> >> =D0=9A=D0=BE=D0=BC=D1=83: Nick Desaulniers
> >> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: bp@alien8.de; x86@kernel.org; tglx@lin=
utronix.de; mingo@redhat.com; George Rimar; Dmitry Golovin; Bill Wendling; =
hpa@zytor.com; linux-kernel@vger.kernel.org
> >> =D0=A2=D0=B5=D0=BC=D0=B0: Re: [RFC PATCH] x86_64: Add "-m elf_i386" wh=
en linking i386 object files.
> >>
> >> CAUTION: This email originated from outside of the organization. Do no=
t click links or open attachments unless you recognize the sender and know =
the content is safe.
> >>
> >> Adding appropriate people, lists.
> >> On Tue, Dec 11, 2018 at 1:07 PM Nick Desaulniers
> >> <ndesaulniers@google.com> wrote:
> >> >
> >> > On Mon, Dec 10, 2018 at 2:50 PM Nick Desaulniers
> >> > <ndesaulniers@google.com> wrote:
> >> > >
> >> > > On Mon, Dec 10, 2018 at 2:26 PM Tri Vo <trong@android.com> wrote:
> >> > > >
> >> > > > From: George Rimar <grimar@accesssoftek.com>
> >> > > >
> >> > > > Linux kernel uses OUTPUT_FORMAT in it's linker scripts. Most of =
the time
> >> > > > -m option is passed to the linker with correct architecture, but
> >> > > > sometimes (at least for x86_64) the -m option contradicts OUTPUT=
_FORMAT
> >> > > > directive. Specifically, arch/x86/boot and arch/x86/realmode/rm =
modules
> >> > > > have i386 object files, but are linked with -m elf_x86_64 linker=
 flag
> >> > > > when building for x86_64.
> >> > > >
> >> > > > BFD and Gold linkers are OK with this, but lld fails:
> >> > > > ld.lld: error: arch/x86/realmode/rm/header.o is incompatible wit=
h elf_x86_64
> >> > > >
> >> > > > Suggested fix: just add correct -m after incorrect one (it overr=
ides
> >> > > > it), so the linker invocation looks like this: ld -m elf_x86_64 =
-z
> >> > > > max-page-size=3D0x200000 -m elf_i386 --emit-relocs -T realmode.l=
ds
> >> > > > header.o trampoline_64.o stack.o reboot.o -o realmode.elf (it wi=
ll also
> >> > > > work with GNU ld, because it supports OUTPUT_FORMAT and just ign=
ores -m
> >> > > > options if this directive is in the linker script).
> >> > > >
> >> > > > Tested by building x86_64 kernel with GNU gcc/ld toolchain and b=
ooting
> >> > > > it in QEMU.
> >> > > >
> >> > > > Suggested-by: Dmitry Golovin <dima@golovin.in>
> >> > > > Signed-off-by: Tri Vo <trong@android.com>
> >> > > > Tested-by: Tri Vo <trong@android.com>
> >> > >
> >> > > This fixes the following linkage error I observe when linking an x=
86
> >> > > kernel with LLD:
> >> > >
> >> > > ```
> >> > >   LD      arch/x86/realmode/rm/realmode.elf
> >> > > ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with =
elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/trampoline_64.o is incompatibl=
e
> >> > > with elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/stack.o is incompatible with e=
lf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/reboot.o is incompatible with =
elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/wakeup_asm.o is incompatible w=
ith elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/wakemain.o is incompatible wit=
h elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/video-mode.o is incompatible w=
ith elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/copy.o is incompatible with el=
f_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/bioscall.o is incompatible wit=
h elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/regs.o is incompatible with el=
f_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/video-vga.o is incompatible wi=
th elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/video-vesa.o is incompatible w=
ith elf_x86_64
> >> > > ld.lld: error: arch/x86/realmode/rm/video-bios.o is incompatible w=
ith elf_x86_64
> >> > > arch/x86/realmode/rm/Makefile:55: recipe for target
> >> > > 'arch/x86/realmode/rm/realmode.elf' failed
> >> > > ```
> >> > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >> > >
> >> > > Looks like we still have a few other (unrelated) issues to track d=
own
> >> > > with LLD, but this gets us one step closer.
> >> > >
> >> > > Thanks for sending this, Tri!
> >> >
> >> > Just some additional thoughts on this:
> >> >
> >> > The kernel is adding -m elf_x86_64 to the linker command line
> >> > parameters, but then relying on binutils tie-breaking-behavior by
> >> > specifying a different architecture via linker script. So it's
> >> > ambiguous which arch the kernel is trying to link for, and the kerne=
l
> >> > gets lucky/relies on the way ld.bfd happens to resolve this ambiguit=
y
> >> > without warning. An alternative fix may be to just filter out/remove
> >> > the -m elf_x86_64 for this target's linker flags.
> >> >
> >> > >
> >> > > > ---
> >> > > >  arch/x86/boot/Makefile        | 2 +-
> >> > > >  arch/x86/realmode/rm/Makefile | 2 +-
> >> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >> > > >
> >> > > > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> >> > > > index 9b5adae9cc40..e2839b5c246c 100644
> >> > > > --- a/arch/x86/boot/Makefile
> >> > > > +++ b/arch/x86/boot/Makefile
> >> > > > @@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux =
FORCE
> >> > > >  AFLAGS_header.o +=3D -I$(objtree)/$(obj)
> >> > > >  $(obj)/header.o: $(obj)/zoffset.h
> >> > > >
> >> > > > -LDFLAGS_setup.elf      :=3D -T
> >> > > > +LDFLAGS_setup.elf      :=3D -m elf_i386 -T
> >> > > >  $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
> >> > > >         $(call if_changed,ld)
> >> > > >
> >> > > > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/r=
m/Makefile
> >> > > > index 4463fa72db94..96cb20de08af 100644
> >> > > > --- a/arch/x86/realmode/rm/Makefile
> >> > > > +++ b/arch/x86/realmode/rm/Makefile
> >> > > > @@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
> >> > > >  targets +=3D realmode.lds
> >> > > >  $(obj)/realmode.lds: $(obj)/pasyms.h
> >> > > >
> >> > > > -LDFLAGS_realmode.elf :=3D --emit-relocs -T
> >> > > > +LDFLAGS_realmode.elf :=3D -m elf_i386 --emit-relocs -T
> >> > > >  CPPFLAGS_realmode.lds +=3D -P -C -I$(objtree)/$(obj)
> >> > > >
> >> > > >  targets +=3D realmode.elf
> >> > > > --
> >> > > > 2.20.0.rc2.403.gdbc3b29805-goog

--=20
Thanks,
~Nick Desaulniers
