Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD75C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D219B2177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I8SfAPsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D219B2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeHUU3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:29:31 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57579 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeHUU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:29:30 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7LH8L3x013835
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:08:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7LH8L3x013835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534871302;
        bh=sE+d/keNTxXJ28F/ND7kc66CTb6zNYaYQOZOVcwv9Hk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=I8SfAPsLXB6tRvM4wdjv+CUNvPRn2W7WXVfRfl1aOcOGBn+lOrlQNza0WrPmkJMuq
         Fq3SXcGi1cY1AK2du4PBcCw3/cuUrBj4eHsIqGSTdON4MM3uNBLSh5JWmD1SkaiJqy
         7ZJk7z8fCdnvscaPReAWUA15kQ+GEk9kKf/sYCTO/G/0ZcXBqkfpbT34ndF7QXydb3
         GIHzf8T+70jTyvPKfxHZX51PNWY6CyZImWHiuYNoNWqUCzwoyV1gEUhZ7C39jQp8+W
         xd4/BGLZYdf2aT4Fv112w3+2G/GGe4i4RBnVxgifo24LhSXZvTPpP4Zc9lrsF9skmi
         7pHlXYCB3nbyQ==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id i4-v6so12287650uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:08:22 -0700 (PDT)
X-Gm-Message-State: APzg51Dh+QxBNSe+IcbYEULysBiqRp6VBrE9ie7vXfarHd2veqFIkecr
        W3hC/XOJxZs019e3WQ6eotDPt483XuBwQRN3IhY=
X-Google-Smtp-Source: AA+uWPxBkgcbxCX/kTCTkZMj2PCsNyJXWrcQd+8v0inENKXzrqNTCwVzmcjCOX8SuPCi2fD6nYDQONyyvnhTiEDgHmI=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr3516342uah.135.1534871300928;
 Tue, 21 Aug 2018 10:08:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 10:07:40
 -0700 (PDT)
In-Reply-To: <6b1d5081e2da107537f72125fc595229128b46e6.camel@perches.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com> <6b1d5081e2da107537f72125fc595229128b46e6.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 22 Aug 2018 02:07:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARi-=oJxN7ohkV_eBBZQ-YyyfrZyjxbfqQetD9Fwn46iw@mail.gmail.com>
Message-ID: <CAK7LNARi-=oJxN7ohkV_eBBZQ-YyyfrZyjxbfqQetD9Fwn46iw@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-22 1:33 GMT+09:00 Joe Perches <joe@perches.com>:
> On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
>> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
>> missed the fact that <linux/compiler-gcc.h> is included by Clang
>> as well as by GCC.
>>
>> Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
>> and it looks like GCC 4.2.1.
>>
>>   $ scripts/gcc-version.sh -p clang
>>   040201
>>
>> If you try to build the kernel with Clang, you will get the
>> "Sorry, your compiler is too old - please upgrade it."
>> followed by a bunch of "unknown attribute" warnings.
>>
>> Add !defined(__clang__) to the minimum version check.
>>
>> Also, revive the version test blocks for versions >= 4.2.1
>> in order to disable features not supported by Clang.
>
> What is the minimum clang version required to compile the kernel?
> What features are not supported by the minimum clang version?
>
> On my system, using clang
>
> $ clang -v
> clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>
> and
>
> $ git checkout v4.16 ; make clean ; make CC=clang defconfig ; make CC=clang
> HEAD is now at 0adb32858b0b... Linux 4.16
>
> is successful
>
> but
>
> $ git checkout v4.17 ; make clean ; make CC=clang defconfig ; make CC=clang
> HEAD is now at 29dcea88779c... Linux 4.17
> arch/x86/Makefile:184: *** Compiler lacks asm-goto support..  Stop.
> arch/x86/Makefile:184: *** Compiler lacks asm-goto support..  Stop.
>

You cannot build x86 because asm-goto support is missing in clang.

How about building arm or arm64?

$ make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabihf- defconfig all





-- 
Best Regards
Masahiro Yamada
