Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E463C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E1D21871
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fldnnUgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLXPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:22:26 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:62587 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:22:21 -0500
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wBOFLtYc019269;
        Tue, 25 Dec 2018 00:21:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wBOFLtYc019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545664916;
        bh=hHXKkqg1qrPGiJ/CgXp0pIp6kb1OWkMCmAm9dQsUrOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fldnnUgmpBotdIN/3KJTzHotWtQMOClu5r31aU3UsV2ENj/+38jeVNOb6wlztw3BV
         IzguA6ce5CnprLYFZAz/UgU7s6AZh92QyLDCFlNy2PvSfsepGNazOgDQO0BTDODpL+
         DbFntsTveGfVdDc0z3dS6b70xVvEJzL9Jv+279iQUZRTetBg72eder7tOZRD6vhZs4
         mO2ytor3Gb5CbzSbzmZ2iGDJ1ARWPbAMyznafVWELElkdaPR3l7ZgrDx8MrrXrppjH
         p9wdRRHUQMkJV7Td/RJLpcXE/40//wNxw1EvugK8zUZjeRBKAarebC7Ao8aR4Lbyzv
         BAKicSeJNI9QA==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id w72so2623519vkd.5;
        Mon, 24 Dec 2018 07:21:56 -0800 (PST)
X-Gm-Message-State: AJcUukdz2tPjtsWBS/i93YvBY3EaFZyfizF25KV2nwPzTqxGHTcJctL/
        Qp/QVy+vb8iWMPtLEGaFPcPTpPLtYq15/3FWX+I=
X-Google-Smtp-Source: ALg8bN6ULaZXB3qWu7VKzPIyr4ziCb808mtLkv1PTsD10t/0GRUy1qSIkq7qUV4dYB72FmakMKdFNrh6Pekv/sp9wr4=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr4851763vkb.34.1545664915353;
 Mon, 24 Dec 2018 07:21:55 -0800 (PST)
MIME-Version: 1.0
References: <1545361961-31990-1-git-send-email-yamada.masahiro@socionext.com> <1545361961-31990-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545361961-31990-3-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 25 Dec 2018 00:21:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVfUvb=kiDjt7d90N1G3xcCNXQhQPz_bOhYKshW59tbQ@mail.gmail.com>
Message-ID: <CAK7LNASVfUvb=kiDjt7d90N1G3xcCNXQhQPz_bOhYKshW59tbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] firmware: rewrite Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 5:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Clean up the Makefile. Equivalent *.gen.S files are produced.
>
>  - Use filechk to remove ugly wordsize_deps
>
>  - Get FWNAME, FWSTR, ASM_WORD, ASM_ALIGN, and PROGBITS out of the
>    recipe for readability
>
>  - Move mkdir into the recipe
>
>  - Clean up generated directories by 'make clean'
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> For this patch to work correctly,
> the following prerequisite is necessary:
>
> https://patchwork.kernel.org/patch/10707461/
>
> So, I will queue this series to kbuild tree.
>
> BTW, my next plan is to move firmware/ to
> more relevant place, for example,
> drivers/base/firmware_loader/builtin.
>
>
>  firmware/Makefile | 89 ++++++++++++++++++++++---------------------------------
>  1 file changed, 35 insertions(+), 54 deletions(-)
>
> diff --git a/firmware/Makefile b/firmware/Makefile
> index 2964138..18d1c84 100644
> --- a/firmware/Makefile
> +++ b/firmware/Makefile
> @@ -1,61 +1,42 @@
>  # SPDX-License-Identifier: GPL-2.0
> -#
> -# kbuild file for firmware/
> -#
>
> -# Create $(fwabs) from $(CONFIG_EXTRA_FIRMWARE_DIR) -- if it doesn't have a
> +# Create $(fwdir) from $(CONFIG_EXTRA_FIRMWARE_DIR) -- if it doesn't have a
>  # leading /, it's relative to $(srctree).
>  fwdir := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE_DIR))
> -fwabs := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
> -
> -fw-external-y := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE))
> -
> -quiet_cmd_fwbin = MK_FW   $@
> -      cmd_fwbin = FWNAME="$(patsubst firmware/%.gen.S,%,$@)";               \
> -                 FWSTR="$(subst /,_,$(subst .,_,$(subst -,_,$(patsubst      \
> -                               firmware/%.gen.S,%,$@))))";                  \
> -                 ASM_WORD=$(if $(CONFIG_64BIT),.quad,.long);                \
> -                 ASM_ALIGN=$(if $(CONFIG_64BIT),3,2);                       \
> -                 PROGBITS=$(if $(CONFIG_ARM),%,@)progbits;                  \
> -                 echo "/* Generated by firmware/Makefile */"           > $@;\
> -                 echo "    .section .rodata"                           >>$@;\
> -                 echo "    .p2align $${ASM_ALIGN}"                     >>$@;\
> -                 echo "_fw_$${FWSTR}_bin:"                             >>$@;\
> -                 echo "    .incbin \"$(2)\""                           >>$@;\
> -                 echo "_fw_end:"                                       >>$@;\
> -                 echo "   .section .rodata.str,\"aMS\",$${PROGBITS},1" >>$@;\
> -                 echo "    .p2align $${ASM_ALIGN}"                     >>$@;\
> -                 echo "_fw_$${FWSTR}_name:"                            >>$@;\
> -                 echo "    .string \"$$FWNAME\""                       >>$@;\
> -                 echo "    .section .builtin_fw,\"a\",$${PROGBITS}"    >>$@;\
> -                 echo "    .p2align $${ASM_ALIGN}"                     >>$@;\
> -                 echo "    $${ASM_WORD} _fw_$${FWSTR}_name"            >>$@;\
> -                 echo "    $${ASM_WORD} _fw_$${FWSTR}_bin"             >>$@;\
> -                 echo "    $${ASM_WORD} _fw_end - _fw_$${FWSTR}_bin"   >>$@;
> -
> -# One of these files will change, or come into existence, whenever
> -# the configuration changes between 32-bit and 64-bit. The .S files
> -# need to change when that happens.
> -wordsize_deps := $(wildcard include/config/64bit.h include/config/32bit.h \
> -               include/config/ppc32.h include/config/ppc64.h \
> -               include/config/superh32.h include/config/superh64.h \
> -               include/config/x86_32.h include/config/x86_64.h \
> -               firmware/Makefile)
> -
> -$(patsubst %,$(obj)/%.gen.S, $(fw-external-y)): %: $(wordsize_deps) \
> -               include/config/extra/firmware/dir.h
> -       $(call cmd,fwbin,$(fwabs)/$(patsubst $(obj)/%.gen.S,%,$@))
> +fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
> +
> +obj-y  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
> +
> +FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
> +FWSTR     = $(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME))))
> +ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
> +ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
> +PROGBITS  = $(if $(CONFIG_ARM),%,@)progbits
> +
> +filechk_fwbin = { \
> +       echo "/* Generated by $(src)/Makefile */"               ;\
> +       echo "    .section .rodata"                             ;\
> +       echo "    .p2align $(ASM_ALIGN)"                        ;\
> +       echo "_fw_$(FWSTR)_bin:"                                ;\
> +       echo "    .incbin \"$(fwdir)/$(FWNAME)\""               ;\
> +       echo "_fw_end:"                                         ;\
> +       echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"   ;\
> +       echo "    .p2align $(ASM_ALIGN)"                        ;\
> +       echo "_fw_$(FWSTR)_name:"                               ;\
> +       echo "    .string \"$(FWNAME)\""                        ;\
> +       echo "    .section .builtin_fw,\"a\",$(PROGBITS)"       ;\
> +       echo "    .p2align $(ASM_ALIGN)"                        ;\
> +       echo "    $(ASM_WORD) _fw_$(FWSTR)_name"                ;\
> +       echo "    $(ASM_WORD) _fw_$(FWSTR)_bin"                 ;\
> +       echo "    $(ASM_WORD) _fw_end - _fw_$(FWSTR)_bin"       ;\
> +}
> +
> +$(obj)/%.gen.S: FORCE
> +       @mkdir -p $(dir $@)


Removed this line because filechk creates the directory automatically.

Then, applied to linux-kbuild.


> +       $(call filechk,fwbin)
>
>  # The .o files depend on the binaries directly; the .S files don't.
> -$(patsubst %,$(obj)/%.gen.o, $(fw-external-y)): $(obj)/%.gen.o: $(fwdir)/%
> -
> -obj-y                           += $(patsubst %,%.gen.o, $(fw-external-y))
> -
> -ifeq ($(KBUILD_SRC),)
> -# Makefile.build only creates subdirectories for O= builds, but external
> -# firmware might live outside the kernel source tree
> -_dummy := $(foreach d,$(addprefix $(obj)/,$(dir $(fw-external-y))), $(shell [ -d $(d) ] || mkdir -p $(d)))
> -endif
> +$(addprefix $(obj)/, $(obj-y)): $(obj)/%.gen.o: $(fwdir)/%
>
> -targets := $(patsubst $(obj)/%,%, \
> -                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
> +targets := $(shell cd $(obj) && find * -name '*.gen.S')
> +clean-dirs := $(shell cd $(obj) && find * -maxdepth 0 -type d)
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
