Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502DFC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07271208B4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZWU+/5oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07271208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeGHCcH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:32:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19846 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeGHCcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:32:05 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w682VpQQ027115;
        Sun, 8 Jul 2018 11:31:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w682VpQQ027115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531017111;
        bh=5qCYEvgr9tBAXQ8KU9aGsdJ4/ZjaCkLjCiHmADdz2UU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZWU+/5oE83zuE72/UJms6komztVju+HuqHkgYlWXMwasBAOuJ00az0bn2h6tJeKi4
         048VCSsY2XoHimssclkwSKax8l4D4aq8IVwIuZ0NTlik5+uxO+Ykve4J/9rK/pEbmw
         jkozFlHOCrUfdgbvHaXtmAWibTfS/zNUZLHMgVuMUpLP+yAur0KKVL+7xJM5KYJx4r
         RN372lC+Jk26D0ashULY9Sj282XzKRFG+471cIzx6IVf7BZIRzU0g+KclcwqM4Ua2U
         Ib1vdh8Ne4Qla20q/21HPhyc2UXDv9OrAXicO/2yKNPW7UnIJetCsNR2Xti9Yypgcj
         dcmPCUPzTpSFg==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id u8-v6so9789487uao.4;
        Sat, 07 Jul 2018 19:31:51 -0700 (PDT)
X-Gm-Message-State: APt69E0ra6fYQ+otcNjH7K7a6PhkVLWhg0MC9fSW3iH1UE1lIraOE7kk
        RIftw1SduoMb5vtTexOwsnpQeLSk87NWxKBY4Lo=
X-Google-Smtp-Source: AAOMgpfmDK0AGHEYkre3tL4ugnQuAlVYR+d7GdKlCu4JUqQlojfcWoWfVgkFbH06yDYOWjQtliPCcCQGfGe2KlLffUc=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr9671770uai.17.1531017110536;
 Sat, 07 Jul 2018 19:31:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 19:31:09 -0700 (PDT)
In-Reply-To: <20180707010709.16648-7-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com> <20180707010709.16648-7-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 11:31:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0QpMLTK3okUtnefq9Y415URPT9Tsuj=ii0-FmLia-1g@mail.gmail.com>
Message-ID: <CAK7LNAS0QpMLTK3okUtnefq9Y415URPT9Tsuj=ii0-FmLia-1g@mail.gmail.com>
Subject: Re: [PATCH 6/7] treewide: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS
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
> In preparation for enabling command line LDLIBS, re-name HOST_LOADLIBES to
> KBUILD_HOSTLDLIBS as the internal use only flags. This should not have any
> visible effects.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  Makefile              |  4 ++--
>  samples/bpf/Makefile  |  2 +-
>  scripts/Makefile.host | 10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 319736b80016..d925af1fb11b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -363,7 +363,7 @@ KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
>                 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
>  KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
>  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
> -HOST_LOADLIBES := $(HOST_LFS_LIBS)
> +KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS)
>
>  # Make variables (CC, etc...)
>  AS             = $(CROSS_COMPILE)as
> @@ -430,7 +430,7 @@ LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
> -export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS HOST_LOADLIBES
> +export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
>  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
>  export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 09f90955412e..c20fb2fa9c37 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -180,7 +180,7 @@ KBUILD_HOSTCFLAGS_trace_event_user.o += -I$(srctree)/tools/lib/bpf/
>  KBUILD_HOSTCFLAGS_sampleip_user.o += -I$(srctree)/tools/lib/bpf/
>  KBUILD_HOSTCFLAGS_task_fd_query_user.o += -I$(srctree)/tools/lib/bpf/
>
> -HOST_LOADLIBES         += $(LIBBPF) -lelf
> +KBUILD_HOSTLDLIBS              += $(LIBBPF) -lelf
>  HOSTLOADLIBES_tracex4          += -lrt
>  HOSTLOADLIBES_trace_output     += -lrt
>  HOSTLOADLIBES_map_perf_test    += -lrt
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 07acf5779f55..7b784413d921 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -85,7 +85,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
>  # host-csingle -> Executable
>  quiet_cmd_host-csingle         = HOSTCC  $@
>        cmd_host-csingle = $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
> -               $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
> +               $(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))
>  $(host-csingle): $(obj)/%: $(src)/%.c FORCE
>         $(call if_changed_dep,host-csingle)
>
> @@ -94,7 +94,7 @@ $(host-csingle): $(obj)/%: $(src)/%.c FORCE
>  quiet_cmd_host-cmulti  = HOSTLD  $@
>        cmd_host-cmulti  = $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
>                           $(addprefix $(obj)/,$($(@F)-objs)) \
> -                         $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
> +                         $(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))


For consistency, please rename
$(HOSTLOADLIBES_$(@F))
to
$(HOSTLDLIBS_$(@F))






-- 
Best Regards
Masahiro Yamada
