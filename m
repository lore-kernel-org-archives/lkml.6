Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D5320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l63QAS/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfAOBZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:25:22 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34893 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfAOBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:25:21 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0F1PDlx001322
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:25:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0F1PDlx001322
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547515514;
        bh=3TMrVr8XzzhVg7OecSYysVOeaVbCFz498698XpGCwYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l63QAS/ONOO2WzaDF7ELajOXLbhASeDMfAaP61AS4VzJo2sMzFG3RPvbvaCFE7SW+
         CrYuQWsr8/DnhRsyt9J2ckBPoVkbilZXGJq4o56H6q2ESqYHlmoRIlZcKX53HrCLHK
         tZFI1dc+58OAizg7V+BPvFmrhTbHjdidZm5wbI5gH0m9aRI987Nxd6s4xIkSQ5pgwh
         rht0zRAsq0sU6N1dwIOUQ5AyH/sB61frneWQbEi6ZU1li/HKrx72ZTpQf9zh77Jf1P
         WU82P2FiP09GzLGPU4sQTtShyyHHNpfPbxrrZKrrmwImsjr7zy1DXUJ9N8PXX+vQ2N
         zCu7gu+Bj1yIA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id n13so689959vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:25:13 -0800 (PST)
X-Gm-Message-State: AJcUukfyKjT7Y0GmurW3D+bhSo/JtmdbN66cmUrd5AKGBSCxs8vnZLJP
        X1tssi8MBwFdyrCn2vcklVg12NCtUSLTpOZy2xg=
X-Google-Smtp-Source: ALg8bN4iY8RvK6NfoFbi43BCUOH1q27b3Kq/y85RHgMDVHcEgPh/fNnldeg7s4vJvRQvPvoaTjygyXD0nPAxrlTKdo8=
X-Received: by 2002:a67:385a:: with SMTP id f87mr561436vsa.179.1547515512615;
 Mon, 14 Jan 2019 17:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20190114210426.177543-1-trong@android.com> <20190114210426.177543-5-trong@android.com>
In-Reply-To: <20190114210426.177543-5-trong@android.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 15 Jan 2019 10:24:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQe5CUhvvyMDfS2t+Y+t9B5SwUOah6V==9Ds+HR2SL5nQ@mail.gmail.com>
Message-ID: <CAK7LNAQe5CUhvvyMDfS2t+Y+t9B5SwUOah6V==9Ds+HR2SL5nQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
To:     Tri Vo <trong@android.com>
Cc:     oberpar@linux.ibm.com, ghackmann@android.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 6:07 AM Tri Vo <trong@android.com> wrote:
>
> Clang gcov format is only supported by Clang compiler, and Clang
> compiler only supports Clang format.


If so, what is the point of putting GCOV_FORMAT_CLANG into the
choice menu?


You can choose the format only when you are using GCC.

I think the following is more sensible:


if GCOV_KERNEL

config GCOV_PROFILE_ALL
         ....


choice
        prompt "Specify GCOV format for GCC"
        depends on CC_IS_GCC
        ...

config GCOV_FORMAT_3_4
        bool "GCC 3.4 format"
        depends on GCC_VERSION < 40700
        ...

config GCOV_FORMAT_4_7
        bool "GCC 4.7 format"
        ...

endchoice


config GCOV_FORMAT_CLANG
         def_bool CC_IS_CLANG

endif





Or, you can delete GCOV_FORMAT_CLANG
if you write the Makefile like follows:



obj-y := base.o fs.o
obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
obj-$(CONFIG_CC_IS_CLANG)     += clang.o






> We set gcov format to depend on which compiler (GCC or Clang) is used.
>
> Automatic format detection behavior is preserved because:
> If GCC is used, one of the GCC gcov formats is selected.
> If Clang is used, Clang gcov format is selected.
>
> Signed-off-by: Tri Vo <trong@android.com>
> ---
>  kernel/gcov/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index eb428e570923..37ec551d4039 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -60,6 +60,8 @@ choice
>         In such a case, change this option to adjust the format used in the
>         kernel accordingly.
>
> +       Select Clang gcov format if building with Clang compiler.
> +
>  config GCOV_FORMAT_3_4
>         bool "GCC 3.4 format"
>         depends on CC_IS_GCC && GCC_VERSION < 40700
> @@ -68,11 +70,13 @@ config GCOV_FORMAT_3_4
>
>  config GCOV_FORMAT_4_7
>         bool "GCC 4.7 format"
> +       depends on CC_IS_GCC
>         ---help---
>         Select this option to use the format defined by GCC 4.7.
>
>  config GCOV_FORMAT_CLANG
>         bool "Clang format"
> +       depends on CC_IS_CLANG
>         ---help---
>         Select this option to use the format defined by Clang.
>
> --
> 2.20.1.97.g81188d93c3-goog
>


-- 
Best Regards
Masahiro Yamada
