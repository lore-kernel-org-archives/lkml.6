Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9DDECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FB320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bBcds/bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FB320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeGXC6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:58:15 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57387 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388194AbeGXC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:58:15 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6O1rpFs018121;
        Tue, 24 Jul 2018 10:53:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6O1rpFs018121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532397232;
        bh=25e/lUVi4dIfiYkaijNjq2BDmzhdApeV+iiBSeICS9M=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bBcds/blSebruz3Qwpg5xhbbFICFpUa2Q5VFCnsQhRmTM6+mzn/+uYSQkAv9YAyzf
         /oudGyUp/HbWtqsXdyHH/hVAICZF2KfAIUzflu5hQ76E5iB5tQdfYeVGUJ4mRXLAYu
         lDRVFJprNKp6koANiGXhbuKLSy2laLAvro2zzfugsftCqIBnvlwwmkgZIvCqVvkxhH
         vWSXZPyr07NNqFNoTEoqwlr1ydGdS6lkqrm/3iUdGr/bpdi4VyMsS1ufDNCt2Dr+CE
         Rly/25issAiLbYmJZdN8lyoHaJyyiatTatjLBhcJcaX47ygHPAvFXerR05HyySweG2
         O2yG+xa7SAjQQ==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id l143-v6so1301832vke.1;
        Mon, 23 Jul 2018 18:53:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlFaSMx0eIzksexhHIHjUFzIqFxC19O8Vppdeb35AUc6CMQfxbQQ
        VaN5R/HDp5uivrBjwT4u0mDRM/ObyNthRfWAfu0=
X-Google-Smtp-Source: AAOMgpeV7ZOUduFoi7UEwkwrsm5hFtn0FCRxwJm3gWEq537T80a3pm+9JnRfIY4yJwhUMU4xxYXsNQSeSWvG5Eb2vec=
X-Received: by 2002:a1f:df42:: with SMTP id w63-v6mr9577527vkg.135.1532397230920;
 Mon, 23 Jul 2018 18:53:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 18:53:10
 -0700 (PDT)
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com> <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 24 Jul 2018 10:53:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7NE5ZOm1ojCK3Y5LthwDfm5OiEGYMcZC8Pkm2_YkKbQ@mail.gmail.com>
Message-ID: <CAK7LNAS7NE5ZOm1ojCK3Y5LthwDfm5OiEGYMcZC8Pkm2_YkKbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Ping?


2018-07-03 10:22 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
>
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/microblaze/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..7333036 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
>  ifdef CONFIG_CPU_BIG_ENDIAN
>  KBUILD_CFLAGS += -mbig-endian
>  KBUILD_AFLAGS += -mbig-endian
> -LD += -EB
> +LDFLAGS += -EB
>  else
>  KBUILD_CFLAGS += -mlittle-endian
>  KBUILD_AFLAGS += -mlittle-endian
> -LD += -EL
> +LDFLAGS += -EL
>  endif
>
>  CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
