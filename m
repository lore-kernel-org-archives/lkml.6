Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B90C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9C82152E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Z1zNyd3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9C82152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHZFrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 01:47:35 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:37671 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeHZFrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 01:47:35 -0400
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com [209.85.213.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7Q26P45029881;
        Sun, 26 Aug 2018 11:06:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7Q26P45029881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535249186;
        bh=ekYIqTw0WViuXiSJxcysUsEsdxW24/MIqdY5yedEIpQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Z1zNyd3Q1YGhv8yCztcV6hB9XvXJRCxxF1ebui5GDZqMXgYN+mevQUoZPAVkmTZS5
         thZY/GT+kr+u5ZJw/nDXRhhTuMrpVWaBqK5OhHf/Rz5Wu4gqdsbyV9ncYdTM3zwSn0
         IcdgzgBkvO9tgXVAiK0ByeOz9pZTy1EB8LybUNPgGA+LI2xQ1sfj9+JP5IM58z5tRH
         pjA5Wji7GSlAsj/4p0t8UC96XGRxNEsTnDlRHr4u1HOoPWWND+u9f17ZCbFYuk8dgq
         PWbM/w55GKp0Qnu0nUA6AIEgBvjFu6ejLpMd37G7EghuvT0L+PORv6pc9bZ+EQNc2U
         20EROGXH8IKCg==
X-Nifty-SrcIP: [209.85.213.47]
Received: by mail-vk0-f47.google.com with SMTP id b78-v6so6022836vka.12;
        Sat, 25 Aug 2018 19:06:25 -0700 (PDT)
X-Gm-Message-State: APzg51BZDk/xNkoVrGq4nGCumn2D5sppGYlkXPYQUXnGtaPKQqYOuIhl
        UpGNugvuQQkiSYbcZxl4p1o1brkn82XPktORAoU=
X-Google-Smtp-Source: ANB0VdYZRrRibxlI/cRQziq6OVkYoGqkECa90pFFlaMEBhVaZNOqOlSBhxEGnn0C+fl1l1l/r7cTdQUnN8HZl3YFHoI=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr4827732vka.140.1535249184406;
 Sat, 25 Aug 2018 19:06:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 19:05:43
 -0700 (PDT)
In-Reply-To: <20180821215524.23040-7-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org> <20180821215524.23040-7-robh@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 26 Aug 2018 11:05:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
Message-ID: <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
Subject: Re: [PATCH 6/8] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


2018-08-22 6:55 GMT+09:00 Rob Herring <robh@kernel.org>:
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-mips@linux-mips.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Makefile                 | 30 ++++++++++++++++++++++++++++++
>  arch/arc/Makefile        |  6 ------
>  arch/arm/Makefile        | 20 +-------------------
>  arch/arm64/Makefile      | 17 +----------------
>  arch/c6x/Makefile        |  2 --
>  arch/h8300/Makefile      | 11 +----------
>  arch/microblaze/Makefile |  4 +---
>  arch/mips/Makefile       | 15 +--------------
>  arch/nds32/Makefile      |  2 +-
>  arch/nios2/Makefile      |  7 -------
>  arch/nios2/boot/Makefile |  4 ----
>  arch/powerpc/Makefile    |  3 ---
>  arch/xtensa/Makefile     | 12 +-----------
>  scripts/Makefile         |  1 -
>  scripts/Makefile.lib     |  2 +-
>  15 files changed, 38 insertions(+), 98 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c13f8b85ba60..6d89e673f192 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1212,6 +1212,30 @@ kselftest-merge:
>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
> +# ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +dtstree := $(wildcard arch/$(SRCARCH)/boot/dts)
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +
> +%.dtb %.dtb.S %.dtb.o: | dtc

I think the pipe operator is unnecessary
because Kbuild will descend to $(dtstree) anyway.


> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +
> +PHONY += dtbs
> +dtbs: | dtc

Ditto.


> +       $(Q)$(MAKE) $(build)=$(dtstree)
> +
> +dtbs_install: dtbs
> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> +
> +all: dtbs
> +
> +dtc:
> +       $(Q)$(MAKE) $(build)=scripts/dtc
> +
> +endif
> +


arch/*/boot/dts/ are not only directories that
require dtc.


$ find  drivers/  -name '*.dts'
drivers/staging/mt7621-dts/gbpc1.dts
drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dts
drivers/of/unittest-data/overlay_12.dts
drivers/of/unittest-data/overlay.dts
drivers/of/unittest-data/overlay_5.dts
drivers/of/unittest-data/overlay_bad_symbol.dts
drivers/of/unittest-data/overlay_1.dts
drivers/of/unittest-data/overlay_bad_phandle.dts
drivers/of/unittest-data/overlay_2.dts
drivers/of/unittest-data/overlay_15.dts
drivers/of/unittest-data/overlay_10.dts
drivers/of/unittest-data/testcases.dts
drivers/of/unittest-data/overlay_6.dts
drivers/of/unittest-data/overlay_13.dts
drivers/of/unittest-data/overlay_4.dts
drivers/of/unittest-data/overlay_9.dts
drivers/of/unittest-data/overlay_3.dts
drivers/of/unittest-data/overlay_8.dts
drivers/of/unittest-data/overlay_7.dts
drivers/of/unittest-data/overlay_11.dts
drivers/of/unittest-data/overlay_0.dts
drivers/of/unittest-data/overlay_base.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts





dtc must be built before descending into any directory.





$ git clean -f -x
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  defconfig
drivers/gpu/drm/rcar-du/
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'multi_v7_defconfig'
#
# configuration written to .config
#
scripts/kconfig/conf  --syncconfig Kconfig
  CC      kernel/bounds.s
  CC      arch/arm/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
<stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented [-Wcpp]
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/sortextable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  CC      drivers/gpu/drm/rcar-du/rcar_lvds.o
  AR      drivers/gpu/drm/rcar-du/built-in.a
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_crtc.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_drv.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_encoder.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_group.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_kms.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_plane.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_of.o
make[2]: *** No rule to make target
'drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb', needed by
'drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S'.  Stop.
Makefile:1721: recipe for target 'drivers/gpu/drm/rcar-du/' failed
make[1]: *** [drivers/gpu/drm/rcar-du/] Error 2
Makefile:286: recipe for target '__build_one_by_one' failed
make: *** [__build_one_by_one] Error 2








> diff --git a/scripts/Makefile b/scripts/Makefile
> index 61affa300d25..a716a6b10954 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -39,7 +39,6 @@ build_unifdef: $(obj)/unifdef
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-y                     += mod
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> -subdir-$(CONFIG_DTC)         += dtc
>  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
>
>  # Let clean descend into subdirs


You need to 'dtc' here to clean-up scripts/dtc by "make mrproper".

subdir- += basic kconfig package gcc-plugins dtc







-- 
Best Regards
Masahiro Yamada
