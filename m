Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6765C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5451620857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CzX6JlLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5451620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIFPVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:21:36 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:49819 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIFPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:21:36 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w86AkbF3024289
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 19:46:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w86AkbF3024289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536230798;
        bh=avCLswmm1eKfBBw5ny7RW8Khi9EfwYW60pAKGtyHedE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CzX6JlLfZaH9nL7AW+KBgOR/Fn42SoEdMF0lHz4SBBPJhsP4lP4bRuuSvHp2V1IM4
         hZhEQCFEjC2Do7oeidiX/FcHQJ2BolU01VHoyOyJSmgfJ3mm3bSd0MdFL6AIBw94Q3
         rsETjxemykk1+7h8JV8066UXefpx4sBzRPKVN+NRPqdNqlQrtVDWDBwyph9dbSmbz4
         hhHZMYCKesSIoXN5tktiQ7/Iig9t5LA2BXj4nN2DuGZMxu7SsJtxloh4o5yY5j2z6J
         XaTqvg91gkZkxrjvJ4vgZ0Liiu5Um5Fv+uBYoolo6OZMKlEDT8jo4EeEJlGmNbGZXB
         ANQCKKUQcsenA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id w7-v6so8317238uan.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:46:38 -0700 (PDT)
X-Gm-Message-State: APzg51Csr7nFZ440aHxaEF67kNKhe+V+cQeDL0NRVjNIszZjyr0LDfz0
        IXCSjBObnIiEmOvl1H5r7sFTXdhn5qXWhhwLe0o=
X-Google-Smtp-Source: ANB0VdY77iFx0OagQcaDR6s86ORMMG/ukScxKgm4eIQ7f0xW8Gq/TjghhfkuhPWfr+2FcV7tw3W+Q2mBr79da7T/cBU=
X-Received: by 2002:ab0:4ad7:: with SMTP id t23-v6mr644198uae.35.1536230796948;
 Thu, 06 Sep 2018 03:46:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 03:45:56 -0700 (PDT)
In-Reply-To: <mhng-89887f62-7423-4fcf-9df5-f5777e6644db@palmer-si-x1c4>
References: <1535099634-29439-1-git-send-email-yamada.masahiro@socionext.com> <mhng-89887f62-7423-4fcf-9df5-f5777e6644db@palmer-si-x1c4>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 6 Sep 2018 19:45:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9hb+QarVNtH3t1fA5vitgwztNZm6y3jM+p8FckOez2g@mail.gmail.com>
Message-ID: <CAK7LNAS9hb+QarVNtH3t1fA5vitgwztNZm6y3jM+p8FckOez2g@mail.gmail.com>
Subject: Re: [PATCH] riscv: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

2018-09-06 18:45 GMT+09:00 Palmer Dabbelt <palmer@sifive.com>:
> On Fri, 24 Aug 2018 01:33:53 PDT (-0700), yamada.masahiro@socionext.com
> wrote:
>>
>> This becomes much neater in Kconfig.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/riscv/Kconfig  | 1 +
>>  arch/riscv/Makefile | 2 --
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index a344980..ed81df4 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -112,6 +112,7 @@ config ARCH_RV32I
>>  config ARCH_RV64I
>>         bool "RV64I"
>>         select 64BIT
>> +       select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000
>>         select HAVE_FUNCTION_TRACER
>>         select HAVE_FUNCTION_GRAPH_TRACER
>>         select HAVE_FTRACE_MCOUNT_RECORD
>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> index 61ec424..33700e4 100644
>> --- a/arch/riscv/Makefile
>> +++ b/arch/riscv/Makefile
>> @@ -25,8 +25,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>>
>>         KBUILD_CFLAGS += -mabi=lp64
>>         KBUILD_AFLAGS += -mabi=lp64
>> -
>> -       KBUILD_CFLAGS   += $(call cc-ifversion, -ge, 0500,
>> -DCONFIG_ARCH_SUPPORTS_INT128)
>>
>>         KBUILD_MARCH = rv64im
>>         KBUILD_LDFLAGS += -melf64lriscv
>
>
> FWIW, while there isn't an official RISC-V GCC port that old (IIRC 6 was our
> first version, but it may have been 7) there are out-of-tree ports so I
> think this is OK to leave as it stands.


It is not my point.
I would not argue the minimum GCC version for RISC-V.


My motivation:

[1] Remove (or move to Kconfig)
    $(call cc-ifversion, ...) from Makefile.

    If you test the GCC version in arch/riscv/Makefile,
    scripts/gcc-version.sh  is invoked for every incremental build.


[2] Follow the macro naming convention

    We add CONFIG_ prefix to macros defined in Kconfig.

    I know some CONFIG options are defined in Makefiles,
    but my ultimate goal is to move all CONFIG options to Kconfig.

    See arch/{arm64,x86}/Kconfig that select ARCH_SUPPORTS_INT128



If you think GCC 6 or 7 is the minimum,
please feel free to remove "if GCC_VERSION >= 50000",
but it is not my main interest here
(and it should be done as a separate work).



-- 
Best Regards
Masahiro Yamada
