Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703402089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CUoK7gUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703402089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeKQNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:47:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44585 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:47:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so26722484wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 19:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K01oj53zY//Z0BA80/gE8gjl/cTB0oPYwPs29CSClPw=;
        b=CUoK7gUenFo/tJNt/12HhRjGpDK6/uHBZX5B6Z6AyXrIQ6MW95+P/N3DWrd8bAkmsd
         xWavXJ26GyLdJiuGv8MlHvyJHRujV1e4OzKpqDe6+zvmTdviOlQfsXfdDaWd8C0bzzEF
         vz/b/Tui7UTqhui5avmj9WNBKnLdLBRfBupEr5edZcwzomep8cdX4GXYOCcmqYoLAGoc
         8+5h71EIWOAnFJzZdww0guIFi5G6x+8TlL1VegvmD7W+NSl7y6SpRj3MmZbpIsgHePBg
         tla0XrdJ24ZgoMTHnlAc/GeCNdpzcsIqQ28RKfHt+9tAH0ECjV/nzU/F8k2+gxrW65r3
         dHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K01oj53zY//Z0BA80/gE8gjl/cTB0oPYwPs29CSClPw=;
        b=PkR1kS6ANYpxFeN1HvV2cTtOEk1rvVB9/FPras09Dl/8mObGasDR0wlVKNSgRseyNi
         ekvIwXTOwT8Q5sjqNAYegd7GvGxoe/hINTrlXkLs5MgfzJj74QOiDfhU+betmmEYp8za
         Y0pNm35bmcw6spwueyIMwyI+qsWudQVM1L7up0tKxr8FVoBav93cOpSVX2PytVa37HsJ
         bHC3KqYon6T8DBugwMEi6CReSu7Gh4pElbuo2p0Ec4wdPcSQr/3gHj5xjsMQEK/bpDBN
         NOHTTw4nCApnUmfjcRoXcFHgl6gObKPVLs3brOkJ5+9FrRB8lZnOoeRY61LOQv6KyL/U
         qHqQ==
X-Gm-Message-State: AA+aEWZ0zGTSp5tmJ1TDFFYuaZqoL2q+R23p1af9EBMBMi3l+9YQj4Ck
        MXA4vDs/wXCD9SjiB8pEnnPQnVq2hXS8UC/+FIzJNKolnL4=
X-Google-Smtp-Source: AFSGD/XxnTQARX9t1ce4Ndk5BLYqP799N5hNqsjBSCQj728hgphFFbLV08Sp7ar5VProQiu+fFK+4lFnS9I+jxd/oqE=
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr6794233wrv.187.1542425535592;
 Fri, 16 Nov 2018 19:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20181112055515.20341-1-anup@brainfault.org> <mhng-4c0df18a-5f01-4260-b3c9-3e4b8cce829b@palmer-si-x1c4>
In-Reply-To: <mhng-4c0df18a-5f01-4260-b3c9-3e4b8cce829b@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 17 Nov 2018 09:02:04 +0530
Message-ID: <CAAhSdy3+w7xQ9=VdqvKa7HZX3FbcAbu4nJ0zXSKi9-4U0_2cNQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Build flat and compressed kernel images
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 2:43 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sun, 11 Nov 2018 21:55:15 PST (-0800), anup@brainfault.org wrote:
> > This patch extends Linux RISC-V build system to build and install:
> > Image - Flat uncompressed kernel image
> > Image.gz - Flat and GZip compressed kernel image
> >
> > Quiet a few bootloaders (such as Uboot, UEFI, etc) are capable of
> > booting flat and compressed kernel images. In case of Uboot, booting
> > Image or Image.gz is achieved using bootm command.
> >
> > The flat and uncompressed kernel image (i.e. Image) is very useful
> > in pre-silicon developent and testing because we can create back-door
> > HEX files for RAM on FPGAs from Image.
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > ---
> >  arch/riscv/Makefile             | 15 ++++++++-
> >  arch/riscv/boot/.gitignore      |  2 ++
> >  arch/riscv/boot/Makefile        | 33 ++++++++++++++++++
> >  arch/riscv/boot/install.sh      | 60 +++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/head.S        | 10 ++++++
> >  arch/riscv/kernel/vmlinux.lds.S |  2 +-
> >  6 files changed, 120 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/boot/.gitignore
> >  create mode 100644 arch/riscv/boot/Makefile
> >  create mode 100644 arch/riscv/boot/install.sh
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index d10146197533..d117a60362eb 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -71,10 +71,23 @@ KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> >  # arch specific predefines for sparse
> >  CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
> >
> > +# Default target when executing plain make
> > +boot         := arch/riscv/boot
> > +KBUILD_IMAGE := $(boot)/Image.gz
> > +
> >  head-y := arch/riscv/kernel/head.o
> >
> >  core-y += arch/riscv/kernel/ arch/riscv/mm/
> >
> >  libs-y += arch/riscv/lib/
> >
> > -all: vmlinux
> > +all: Image.gz
> > +
> > +Image: vmlinux
> > +     $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> > +
> > +Image.%: Image
> > +     $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> > +
> > +zinstall install:
> > +     $(Q)$(MAKE) $(build)=$(boot) $@
> > diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
> > new file mode 100644
> > index 000000000000..8dab0bb6ae66
> > --- /dev/null
> > +++ b/arch/riscv/boot/.gitignore
> > @@ -0,0 +1,2 @@
> > +Image
> > +Image.gz
> > diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> > new file mode 100644
> > index 000000000000..0990a9fdbe5d
> > --- /dev/null
> > +++ b/arch/riscv/boot/Makefile
> > @@ -0,0 +1,33 @@
> > +#
> > +# arch/riscv/boot/Makefile
> > +#
> > +# This file is included by the global makefile so that you can add your own
> > +# architecture-specific flags and dependencies.
> > +#
> > +# This file is subject to the terms and conditions of the GNU General Public
> > +# License.  See the file "COPYING" in the main directory of this archive
> > +# for more details.
> > +#
> > +# Copyright (C) 2018, Anup Patel.
> > +# Author: Anup Patel <anup@brainfault.org>
> > +#
> > +# Based on the ia64 and arm64 boot/Makefile.
> > +#
> > +
> > +OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
> > +
> > +targets := Image
> > +
> > +$(obj)/Image: vmlinux FORCE
> > +     $(call if_changed,objcopy)
> > +
> > +$(obj)/Image.gz: $(obj)/Image FORCE
> > +     $(call if_changed,gzip)
> > +
> > +install:
> > +     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> > +     $(obj)/Image System.map "$(INSTALL_PATH)"
> > +
> > +zinstall:
> > +     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> > +     $(obj)/Image.gz System.map "$(INSTALL_PATH)"
> > diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
> > new file mode 100644
> > index 000000000000..18c39159c0ff
> > --- /dev/null
> > +++ b/arch/riscv/boot/install.sh
> > @@ -0,0 +1,60 @@
> > +#!/bin/sh
> > +#
> > +# arch/riscv/boot/install.sh
> > +#
> > +# This file is subject to the terms and conditions of the GNU General Public
> > +# License.  See the file "COPYING" in the main directory of this archive
> > +# for more details.
> > +#
> > +# Copyright (C) 1995 by Linus Torvalds
> > +#
> > +# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> > +# Adapted from code in arch/i386/boot/install.sh by Russell King
> > +#
> > +# "make install" script for the RISC-V Linux port
> > +#
> > +# Arguments:
> > +#   $1 - kernel version
> > +#   $2 - kernel image file
> > +#   $3 - kernel map file
> > +#   $4 - default install path (blank if root directory)
> > +#
> > +
> > +verify () {
> > +     if [ ! -f "$1" ]; then
> > +             echo ""                                                   1>&2
> > +             echo " *** Missing file: $1"                              1>&2
> > +             echo ' *** You need to run "make" before "make install".' 1>&2
> > +             echo ""                                                   1>&2
> > +             exit 1
> > +     fi
> > +}
> > +
> > +# Make sure the files actually exist
> > +verify "$2"
> > +verify "$3"
> > +
> > +# User may have a custom install script
> > +if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> > +if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> > +
> > +if [ "$(basename $2)" = "Image.gz" ]; then
> > +# Compressed install
> > +  echo "Installing compressed kernel"
> > +  base=vmlinuz
> > +else
> > +# Normal install
> > +  echo "Installing normal kernel"
> > +  base=vmlinux
> > +fi
> > +
> > +if [ -f $4/$base-$1 ]; then
> > +  mv $4/$base-$1 $4/$base-$1.old
> > +fi
> > +cat $2 > $4/$base-$1
> > +
> > +# Install system map file
> > +if [ -f $4/System.map-$1 ]; then
> > +  mv $4/System.map-$1 $4/System.map-$1.old
> > +fi
> > +cp $3 $4/System.map-$1
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 711190d473d4..fe884cd69abd 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -44,6 +44,16 @@ ENTRY(_start)
> >       amoadd.w a3, a2, (a3)
> >       bnez a3, .Lsecondary_start
> >
> > +     /* Clear BSS for flat non-ELF images */
> > +     la a3, __bss_start
> > +     la a4, __bss_stop
> > +     ble a4, a3, clear_bss_done
> > +clear_bss:
> > +     REG_S zero, (a3)
> > +     add a3, a3, RISCV_SZPTR
> > +     blt a3, a4, clear_bss
> > +clear_bss_done:
> > +
> >       /* Save hart ID and DTB physical address */
> >       mv s0, a0
> >       mv s1, a1
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index ece84991609c..65df1dfdc303 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -74,7 +74,7 @@ SECTIONS
> >               *(.sbss*)
> >       }
> >
> > -     BSS_SECTION(0, 0, 0)
> > +     BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>
> What does this do?

If bootloader is loading vmlinux ELF then it will take care of
zeroing BSS and SBSS section.

If we have FLAT image then the head.S has to zero-out BSS
and SBSS on boot HART. The secondary/non-boot HART
don't need to clear BSS and SBSS.

Now with BSS_SECTION(0, 0, 0), there is no alignment
constraint on start of BSS and SBSS section so the BSS
zeroing code in head.S has handle unaligned BSS and
SBSS (i.e. not aligned to XLEN / 8 bytes). To simplify, I have
made BSS and SBSS start as page aligned and put a simple
assembly code in head.S to zero-out BSS and SBSS.

Of course, we can also use BSS_SECTION(16, 16, 0)
but I thought of avoiding magic values and made it
page aligned (like few other architectures).

>
> >
> >       EXCEPTION_TABLE(0x10)
> >       NOTES
>
> Thanks!  I'm going to target this for the RCs as well: it's technically a new
> feature, but it seems pretty safe -- assuming the BSS_SECTION change can be
> explained to me :)

Thanks,
Anup
