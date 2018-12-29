Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2810C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6906020866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeL2V5q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:57:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44784 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbeL2V5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:57:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so26462867qte.11;
        Sat, 29 Dec 2018 13:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ei4rDf2o5vhDoh51gyAfX+grGTs30ykQyclfhGAnvuU=;
        b=WXJG53efqBsE2ie8sDtEUY4p7T4r5+jt2dKy5y2c3PfeCkbQBpWFn9kUc5T7reRoSj
         wPcYR0f9HG2mfM+kJVjA5YSn7a8qRWgbuIRX8JRMYTNs0olC1yZMWMElLP8JQXGeczZu
         STJKl6ajeIHZvFDdRWjQxZ1IQEoVQ6bXJWlqTzAqyZUSiCetrN2kap49H+k+3JPBxMcW
         ZPO5UfFlm9Sh+q5MzxWfufqcKDdrOoYmNeKdrHf55lMfHJA5PDvgIFYTRaEB0ctPPFXT
         26urKGEMqBmU53o1z0gsdRKzipCPJ96ZaSCKAP2nIIKPhQY5sshC9yPCjgCwhqVh924X
         WDMQ==
X-Gm-Message-State: AJcUukep56hHoN+8dPlNrIhCcYVVYTxc685G5/gDULWJBErcQmDTAFGG
        BeVG25tMOOd5MuOvFnSV36LVlmqyNgjdxprMWa8=
X-Google-Smtp-Source: ALg8bN7zKH1wAVwrp2XPC1sj4+ngWylVJVnnSjCxSQvOhkbmK5N4QjXESdQfZ50FncUPXk52pqLa/wPqi/+lcYTuKXs=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr3737644qtl.343.1546120663249;
 Sat, 29 Dec 2018 13:57:43 -0800 (PST)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
 <CAMuHMdXPFgp5sLR5-UExEvxNbKSR5H--dk7KMit_XFSFN+1uHw@mail.gmail.com>
 <1996329d875e1ab5b9cd69db187b7037ad3a0d8d.camel@perches.com> <CAMuHMdW1OqswdSRj2DROFST46dLCmMU5=ki2x0FBn8OjJjgLdg@mail.gmail.com>
In-Reply-To: <CAMuHMdW1OqswdSRj2DROFST46dLCmMU5=ki2x0FBn8OjJjgLdg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Dec 2018 22:57:26 +0100
Message-ID: <CAK8P3a2K5m91-KPybKx5EGcMR=3CZDUeUqxe2MeRqg95j9WLeA@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joe Perches <joe@perches.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 3:25 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, Aug 24, 2018 at 12:00 AM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2018-08-23 at 23:52 +0200, Geert Uytterhoeven wrote:
> --- build.log.linux-4.20.0-atari-07795-g835f16c9b68966ff-gcc-4.1.2-20061115-prerelease-Ubuntu-4.1.1-21
> +++ build.log.linux-4.20.0-atari-07767-gc085b9fd60f52a62-gcc-7.3.0-27ubuntu1~18.04
>
> 20 warning regressions:
>   + arch/m68k/atari/config.c: warning: ISO C90 forbids variable length
> array ‘switches’ [-Wvla]:  => 151:2

Ah, so we still have some of these. The warning was only recently added.

>   + arch/m68k/include/asm/cmpxchg.h: warning: value computed is not
> used [-Wunused-value]:  => 79:22, 122:3, 137:3

IIRC this can be avoided using a ({ ... }) type expression.

>   + arch/m68k/include/asm/raw_io.h: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]:  => 20:19, 33:35,
> 26:31, 30:32

The I/O accessors are defined in an unusual way that defeats a lot
of the type checking we normally have. Generally speaking the
memory space operations (readl/ioread32/__raw_readl, ...) should
be inline functions taking a 'const volatile void __iomem *' argument
(non-const for writel), while the I/O space operations should take
an integer port number (16 or 32 bit, depending on how your ISA
or PCI buses work).

Doing that should avoid all the warnings you quote here, but may
introduce warnings about nonportable driver code.

>   + arch/m68k/include/asm/string.h: warning: argument 2 null where
> non-null expected [-Wnonnull]:  => 72:25

This might be a kernel bug.

>   + arch/m68k/kernel/setup_mm.c: warning: #warning Are you building an
> allnoconfig kernel? [-Wcpp]:  => 51:2
>   + arch/m68k/kernel/setup_mm.c: warning: #warning No CPU/platform
> type selected, your kernel will not work! [-Wcpp]:  => 50:2
>   + arch/m68k/mvme147/config.c: warning: #warning check me! [-Wcpp]:  => 150:2
>   + arch/m68k/mvme16x/config.c: warning: #warning check me! [-Wcpp]:  => 397:2

I've removed that kind of warning from other architectures.

>   + arch/m68k/kernel/signal.c: warning: ISO C90 forbids variable
> length array ‘buf’ [-Wvla]:  => 654:3

You can probably pick the maximum here.

>   + drivers/i2c/i2c-core-base.c: warning: ‘ret’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]:  => 235:5

This might come from the new CONFIG_NO_AUTO_INLINE.

>   + drivers/input/joystick/analog.c: warning: #warning Precise timer
> not defined for this architecture. [-Wcpp]:  => 172:2

Maybe add a Kconfig dependency on !M68K?

>   + include/linux/dynamic_debug.h: warning: statement will never be
> executed [-Wswitch-unreachable]:  => 115:19

No idea.

>   + warning: unmet direct dependencies detected for NEED_MULTIPLE_NODES:  => N/A
>   + warning: unmet direct dependencies detected for SND_SOC_QDSP6:  => N/A

Not gcc warnings.

      Arnd
