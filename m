Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F779ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB70220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mvf2PJzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB70220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeIRWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:50:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40352 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbeIRWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:50:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so1351920pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCHpPDM/qklcyagtyYZfheQsrV08LWx/22ph8TNlGNY=;
        b=Mvf2PJzZMJFJKj4KhAg9A6vIsHaWFw+ZZOOi5q91mfM1o3hyFUrNnL0OavC1afXgFm
         lmnGnmYVIPCGmKaW1fHRit+TDxYMB5kN6++RUKziDt1PI9BtopRoXvmjrDYUkcw4IuCi
         i82LeVwJLeO5QZdzOtsxugNckjnBnQynh8eEBX1Ipp0A56HBiW4+0vUyBklBO9NDWlU9
         d8iqd7Uey5t8DI/RazBQNSk4NE56AFs8D95sCvMplizOMyvgPcRoXSVQUdyJKvyJguKD
         PyeAq1rgCRLQdva6TEZcJ7N+0AH9douuXrmZZX5ojg5k6EDXnddYc9AEGxJT79ZZrqxb
         EGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCHpPDM/qklcyagtyYZfheQsrV08LWx/22ph8TNlGNY=;
        b=F1bwpKt93YqSCHBsxYfnYWIKdm8MGW3UUDLnttLk2VJ+KheIs/vxFtOhMeA2gkMw3R
         C/7g1qpWuK4PwJzP/3LIVN6D+lJmM/3BmEi9R16N1wqyKo5EiOSTSLTn3vVoPxE3by0k
         65WmzncsQTJDiLWFrbvw5RAMPveCYZSKCkdSTbxCybmV4mZ4PUS4D9uUq/afAMa6cOxj
         AhxMuJKv2oxzXtcMW4U8X/lncdJqEub/HRkjEfGW6Y6GO4BUqznQgTPk1Alutxk7aLMo
         Of1QqH0hjB347o1SO2pdZLKydBi5A0rIC7h0TwlZwwpCuVPEi87mxL/miiUTZvWp5xoj
         EUVA==
X-Gm-Message-State: APzg51Cu3KX60S1IXSJ4xPb0cwtdSHlDrhnQ8ivrW/cZ16qr6KPzOsRk
        70ejpIxim2rGOeHUD1Avpt9BV1jztbXVuiqVwzVXTQ==
X-Google-Smtp-Source: ANB0VdaZqpDRSeTfmL36STcfeijVlWShx1JDkfOIt6t/V3/KgCJiCOqJNhSKZVBSyJxvPGxLY/79wukW1NpVIOZbrdE=
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr31659624pfa.93.1537290986976;
 Tue, 18 Sep 2018 10:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180918023157.23951-1-stefan@agner.ch>
In-Reply-To: <20180918023157.23951-1-stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Sep 2018 10:16:15 -0700
Message-ID: <CAKwvOd=CRw+5T6Us-Pw+t02PYWFEh=SM49C+28x7_oH+hcPOzQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: allow to use GCC toolchain not in Clang search path
To:     Stefan Agner <stefan@agner.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 7:32 PM Stefan Agner <stefan@agner.ch> wrote:
>
> When using a GCC cross toolchain which is not in a compiled in
> Clang search path, Clang reverts to the system assembler and
> linker. This leads to assembler or linker errors, depending on
> which tool is first used for a given architecture.
>
> It seems that Clang is not searching $PATH for a matching
> assembler or linker.

Yes, Clang uses what's called a sysroot, which is meant to be more
hygenic than $PATH, IIUC.  This is surprising to folks familiar with
$PATH, but really helps include the correct headers and use the
correct toolchain when cross compiling, at the cost of freedom to put
the cross toolchain wherever in the filesystem. (this is my
understanding of sysroot, I just learned about it yesterday, so take
this with a grain of salt).

>
> Make sure that Clang picks up the correct assembler or linker by
> passing the cross compilers bin directory as search path.
>
> This allows to use Clang provided by distributions with GCC
> toolchains not in /usr/bin.

IIUC, its just utilities in binutils we're using (as, bfd.ld,
objcopy), not GCC, but maybe that's just being pedantic.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/78
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Nick, I removed your Reviewed-by since I had to change variable
> assignment slightly...

Yes, thank you, that's the right thing to do.

>
>  Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4d5c883a98e5..d5de2db4b549 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,13 +495,15 @@ endif
>  ifeq ($(cc-name),clang)
>  ifneq ($(CROSS_COMPILE),)
>  CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> -GCC_TOOLCHAIN  := $(realpath $(dir $(shell which $(LD)))/..)
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> +CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)

Yep: https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-b-dir

> +GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> +KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> +KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
>  KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
>  endif
> --
> 2.19.0
>

Thanks for this patch Stefan.
Reviewed-and-tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
