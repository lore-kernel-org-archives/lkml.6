Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA90C6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35357208B4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="USf7IfzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35357208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeGHCbj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:31:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19283 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeGHCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:31:36 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w682V7C6026929;
        Sun, 8 Jul 2018 11:31:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w682V7C6026929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531017068;
        bh=utO+SK3uLQDUWGOLFqZlsAZtGDtkQ14U3qYR9JfhNwc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=USf7IfzHLR9N4WpucWyqWzE161hBrBv0WBRjUMi/In3TxVS6jQR4vwVIItFzUsLuQ
         XE2BPmrxIGRdDYtfagKA3w+RWR8U4nSU/LkGxiGYrocJwxBTMMwdej8Pkod3ilGAyA
         WADV2/g9osby4sjvFZyR12syfS35MPOR81ZHBDWSWLKTgPsf0SK1noLy8x+qSA0WqD
         gM6CmPSsJtJi6wm5oONHmth7DyFO/AwjFPjC/Y0/V/m3dAwgGo5+y8pb3dC37kzAuc
         sO0P22cwcX1IoAfFRlsHH4NlNq+aN928egxL4S7kJfcrHUqgZNB2lZ21yd1+gPuQqg
         ZSOwXdUx1xDXQ==
X-Nifty-SrcIP: [209.85.217.179]
Received: by mail-ua0-f179.google.com with SMTP id y8-v6so9782000uan.3;
        Sat, 07 Jul 2018 19:31:08 -0700 (PDT)
X-Gm-Message-State: APt69E2JZSpaY4pLBRswMYsG/WEtVRbvA6X2Dvqx9ATwsFHFL0BHAQ2M
        E32jPTi2uP71G6oumnY1lp4aYpHNCokSqWVLo4Y=
X-Google-Smtp-Source: AAOMgpfe6FKaKaOJuooodVMyVvQlVv6Uzgc1VwDjCe3O332QxFzkK+PFpbgiOsk1bmJ5t8bfBWpgnAPs/MqZRkB/fXQ=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr9755209uad.82.1531017067145;
 Sat, 07 Jul 2018 19:31:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 19:30:26 -0700 (PDT)
In-Reply-To: <20180707010709.16648-4-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com> <20180707010709.16648-4-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 11:30:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqe2x1_C1Np0L0_rh4LUtb72Og1UkoM-_f6qaz1P4cxw@mail.gmail.com>
Message-ID: <CAK7LNARqe2x1_C1Np0L0_rh4LUtb72Og1UkoM-_f6qaz1P4cxw@mail.gmail.com>
Subject: Re: [PATCH 3/7] treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
To:     Laura Abbott <labbott@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-07 10:07 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> In preparation for enabling command line CFLAGS, re-name HOSTCFLAGS to
> KBUILD_HOSTCFLAGS as the internal use only flags. This should not have any
> visible effects.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  Makefile                   |  4 ++--
>  arch/alpha/boot/Makefile   |  2 +-
>  arch/s390/tools/Makefile   |  4 ++--
>  arch/x86/tools/Makefile    |  4 ++--
>  net/bpfilter/Makefile      |  2 +-
>  samples/bpf/Makefile       | 26 +++++++++++++-------------
>  samples/connector/Makefile |  2 +-
>  samples/hidraw/Makefile    |  2 +-
>  samples/seccomp/Makefile   | 24 ++++++++++++------------
>  samples/statx/Makefile     |  2 +-
>  samples/uhid/Makefile      |  2 +-
>  scripts/Kbuild.include     |  2 +-
>  scripts/Makefile           |  4 ++--
>  scripts/Makefile.host      |  4 ++--
>  scripts/dtc/Makefile       | 24 ++++++++++++------------
>  scripts/genksyms/Makefile  |  4 ++--
>  scripts/kconfig/Makefile   | 12 ++++++------
>  tools/build/Build.include  |  2 +-
>  tools/objtool/Makefile     |  2 +-
>  19 files changed, 64 insertions(+), 64 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d15ac32afbaf..16cab22b1f40 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -359,7 +359,7 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
>
>  HOSTCC       = gcc
>  HOSTCXX      = g++
> -HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
> +KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
>                 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
>  HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
>  HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
> @@ -429,7 +429,7 @@ KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
>  LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>
> -export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
> +export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
>  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
>  export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> diff --git a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
> index 0cbe4c59d3ce..dfccf0195306 100644
> --- a/arch/alpha/boot/Makefile
> +++ b/arch/alpha/boot/Makefile
> @@ -14,7 +14,7 @@ targets               := vmlinux.gz vmlinux \
>                    tools/bootpzh bootloader bootpheader bootpzheader
>  OBJSTRIP       := $(obj)/tools/objstrip
>
> -HOSTCFLAGS     := -Wall -I$(objtree)/usr/include
> +KBUILD_HOSTCFLAGS      := -Wall -I$(objtree)/usr/include
>  BOOTCFLAGS     += -I$(objtree)/$(obj) -I$(srctree)/$(obj)
>
>  # SRM bootable image.  Copy to offset 512 of a partition.
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 48cdac1143a9..40afcebf4e67 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -14,8 +14,8 @@ kapi: $(kapi-hdrs-y)
>  hostprogs-y                += gen_facilities
>  hostprogs-y                += gen_opcode_table
>
> -HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> -HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
> +KBUILD_HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> +KBUILD_HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)


No.
Please keep HOSTCFLAGS_<file>.o as-is.




-- 
Best Regards
Masahiro Yamada
