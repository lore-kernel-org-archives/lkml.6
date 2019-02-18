Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737C1218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="at2CW2W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfBREzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:55:32 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:18501 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBREzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:55:31 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1I4tGjs014460;
        Mon, 18 Feb 2019 13:55:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1I4tGjs014460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550465717;
        bh=/8fb9DxCXw4pkz63E7lkQjXEm5ZgP36Q8aoPdWS1I/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=at2CW2W48FcnXOU7jU8IunniLa/XG7GHTjGDLbuZtJBezvFNcrPqkOqWmIY1dwQkA
         GZGyv7HI/z8J5VnuKQ5NJBZMH2ko0SRYYuZ8nq3I1W4R7tQgkbm0nx5CwcpejL+KyW
         9FGZRKBik0Q0uhGFT96KH3DWIbdwDBBcLwbK4PHjNAboKddmbqfFf1XEKLbgTnpljp
         LnnuHs3XIW7K6KiirpUvQFzLBDPWpPMLAfhgoNs/xW8eYy6e8Olezt8zthkKDVqtUu
         jMUIXdbVWu9CnifQt3AS1f+L9+0MnHl8ViFYfsti+0kAAURhQeCjGfWoVuffkQXjx5
         hEG25SNKxLs1Q==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id v187so1783157vkf.12;
        Sun, 17 Feb 2019 20:55:16 -0800 (PST)
X-Gm-Message-State: AHQUAuaUenigz+6now8CM0O96foO1lL99Z7E+hBxmvc1sEneMBgJDlFj
        jGeKEeRuJAAAMsmFgN4Phn2Mwd2CglVJkj7oVDM=
X-Google-Smtp-Source: AHgI3IYQxb/QEAju+Stcm2S+o930eoFQQrXDucxiKDJJCNo8tsdmAjQe7YbUjR7/qdQSsw45whkzt66yEbuddj0yU2A=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr11086951vkn.0.1550465715769;
 Sun, 17 Feb 2019 20:55:15 -0800 (PST)
MIME-Version: 1.0
References: <1548400703-27945-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548400703-27945-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Feb 2019 13:54:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARf-P0Qjj2ScgQHk2yFw13h7zXk0VCB0MJe3W2ka3s40A@mail.gmail.com>
Message-ID: <CAK7LNARf-P0Qjj2ScgQHk2yFw13h7zXk0VCB0MJe3W2ka3s40A@mail.gmail.com>
Subject: Re: [PATCH] ia64: prefix header search path with $(srctree)/
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 4:21 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>
> I removed some header search paths because I was able to build ia64
> without them.
>
> [1]: https://patchwork.kernel.org/patch/9632347/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


ia64 development is not very active these days.

I will wait for response from the maintainers.

If they are silent, I want to pick up this to my kbuild tree.


Thanks.


>  arch/ia64/sn/kernel/Makefile     | 2 +-
>  arch/ia64/sn/kernel/sn2/Makefile | 2 --
>  arch/ia64/sn/pci/Makefile        | 2 --
>  arch/ia64/sn/pci/pcibr/Makefile  | 2 +-
>  4 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/ia64/sn/kernel/Makefile b/arch/ia64/sn/kernel/Makefile
> index d27df1d..9c349dd 100644
> --- a/arch/ia64/sn/kernel/Makefile
> +++ b/arch/ia64/sn/kernel/Makefile
> @@ -7,7 +7,7 @@
>  # Copyright (C) 1999,2001-2006,2008 Silicon Graphics, Inc.  All Rights Reserved.
>  #
>
> -ccflags-y := -Iarch/ia64/sn/include
> +ccflags-y := -I $(srctree)/arch/ia64/sn/include
>
>  obj-y                          += setup.o bte.o bte_error.o irq.o mca.o idle.o \
>                                    huberror.o io_acpi_init.o io_common.o \
> diff --git a/arch/ia64/sn/kernel/sn2/Makefile b/arch/ia64/sn/kernel/sn2/Makefile
> index 3d09108..170bde4 100644
> --- a/arch/ia64/sn/kernel/sn2/Makefile
> +++ b/arch/ia64/sn/kernel/sn2/Makefile
> @@ -9,7 +9,5 @@
>  # sn2 specific kernel files
>  #
>
> -ccflags-y := -Iarch/ia64/sn/include
> -
>  obj-y += cache.o io.o ptc_deadlock.o sn2_smp.o sn_proc_fs.o \
>          prominfo_proc.o timer.o timer_interrupt.o sn_hwperf.o
> diff --git a/arch/ia64/sn/pci/Makefile b/arch/ia64/sn/pci/Makefile
> index df2a901..321576b 100644
> --- a/arch/ia64/sn/pci/Makefile
> +++ b/arch/ia64/sn/pci/Makefile
> @@ -7,6 +7,4 @@
>  #
>  # Makefile for the sn pci general routines.
>
> -ccflags-y := -Iarch/ia64/sn/include
> -
>  obj-y := pci_dma.o tioca_provider.o tioce_provider.o pcibr/
> diff --git a/arch/ia64/sn/pci/pcibr/Makefile b/arch/ia64/sn/pci/pcibr/Makefile
> index 396bcae..712f6af 100644
> --- a/arch/ia64/sn/pci/pcibr/Makefile
> +++ b/arch/ia64/sn/pci/pcibr/Makefile
> @@ -7,7 +7,7 @@
>  #
>  # Makefile for the sn2 io routines.
>
> -ccflags-y := -Iarch/ia64/sn/include
> +ccflags-y := -I $(srctree)/arch/ia64/sn/include
>
>  obj-y                          +=  pcibr_dma.o pcibr_reg.o \
>                                     pcibr_ate.o pcibr_provider.o
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
