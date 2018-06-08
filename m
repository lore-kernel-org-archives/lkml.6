Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nKDQCrFEGlu3BQAAmS7hNA
	; Fri, 08 Jun 2018 08:57:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 53A18608C8; Fri,  8 Jun 2018 08:57:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTAdupVf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8FEFC607A4;
	Fri,  8 Jun 2018 08:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FEFC607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeFHI5N (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:57:13 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35289 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeFHI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:57:09 -0400
Received: by mail-ua0-f196.google.com with SMTP id s13-v6so4949606uad.2;
        Fri, 08 Jun 2018 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dNwv5UCTFoHmjNaGlxWj7DZXWL5saowvS0MX539AhAE=;
        b=aTAdupVfMcyDbT2u2IpMG6spoqoadP22l8a2+cJqmtHbG4PIed5TvWofjiCsFM6luY
         2rUwRGv63QYov1GSFVgT8Vv9dBmWkGO21dxTi9znEvM4PaC30NVaJi2vCnB7tJXMMQYR
         eRp+0ivaMZfdsavLRZjioOGOBL2jqC4/oB1VTvkZnKxlCmvtX9NRjIAa5CJ7TQUSn0mS
         +HNqMK7tsyELAN2Wsx4yF41h9GCPPeHOKN5uFZpLMcP46GVOV4s2SRAPS+j14RB4bWmc
         Kd4r2Hqf4kwOPXxojLzm2PpHL+cLIvQxEntPmYPuoYczY4rV++/Q5cnpP+de5FKKNHW1
         NbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dNwv5UCTFoHmjNaGlxWj7DZXWL5saowvS0MX539AhAE=;
        b=BEepdTJ0xSnPKtPxyuVmXo2pae/f9UNJ9cx/seqND5euwG6I9G0eB4P+cIdXLhrHbj
         /y4KB1xR2MWiUgmcHQZ0Nuyywjgac0VxkjDZbKGsP11mEPxX00n8PhjaZBPmn+/g5QUc
         g3Zxb7X8eLiKMvN6yDTf7Aly0GH/vJLrU87Q5sciUYEAlPmjIzw6Fgy8exufz7fha1Ha
         Qgp3CJwU2vf9VJVJp/0vR/HLRkAHX5KAKDOfguXnJUHPtu2FECPrnztu2QWcAIhu0VjJ
         NaffdaocnfOyJ1shsUcAgHb7tvD1Q85l/0gEYDkddEiJnz/pxgrfJB7cpeK49MkajA4T
         JjBw==
X-Gm-Message-State: APt69E2aOcEsBhTus5ROeFJQjkhxcikILD3UXyEXM9KYrAgiOB0YTq0j
        JGYxhiBtS8sJdmaH5xGZdVKVQ9mHjVHrp3xFHtM=
X-Google-Smtp-Source: ADUXVKKDbuwugyx+3wj/rCcsh6Sx37iiuo3CcmZ9fqqKIXJehwBd0rXuiNJJAHiCKlUVV7Twjdwjr6F5UDCMfv8L+7k=
X-Received: by 2002:ab0:48e1:: with SMTP id y30-v6mr3583535uac.180.1528448228281;
 Fri, 08 Jun 2018 01:57:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:57:07 -0700 (PDT)
In-Reply-To: <20180528153222.2037158-1-arnd@arndb.de>
References: <20180528153222.2037158-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Jun 2018 10:57:07 +0200
X-Google-Sender-Auth: BWnB_qLUXXQWdPb_PxrjJmRAhtU
Message-ID: <CAMuHMdXy0uHXaGkFBh9_tr2VzmJF+8KtraTuFHJwcmqhcHs4Dg@mail.gmail.com>
Subject: Re: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Alexei,

On Mon, May 28, 2018 at 5:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When build testing across architectures, I run into a build error on
> all targets other than X86:
>
> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objdump: net/bpfilter/bpfilter_umh: File format not recognized
> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy:net/bpfilter/bpfilter_umh.o: Invalid bfd target
>
> The problem is that 'hostprogs' get built with 'gcc' rather than
> '$(CROSS_COMPILE)gcc', and my default gcc (as most people's) targets x86.
>
> To work around it, adding an X86 dependency gets randconfigs building
> again on my box.
>
> Clearly, this is not a good solution, since it should actually work fine
> when building native kernels on other architectures but that is now
> disabled, while cross building an x86 kernel on another host is still
> broken after my patch.
>
> What we probably want here is to try out if the compiler is able to build
> executables for the target architecture and not build the helper otherwise,
> at least when compile-testing. No idea how to do that though.

So that was done in commit 819dd92b9c0bc7bc ("bpfilter: switch to CC
from HOSTCC"), but it is not sufficient:

      GEN net/bpfilter/bpfilter_umh.o
    Usage: m68k-linux-gnu-objcopy [option(s)] in-file [out-file]
     Copies a binary file, possibly transforming it in the process
     The options are:
    [...]

net/bpfilter/Makefile:29: recipe for target 'net/bpfilter/bpfilter_umh.o' failed
make[5]: *** [net/bpfilter/bpfilter_umh.o] Error 1

> --- a/net/bpfilter/Kconfig
> +++ b/net/bpfilter/Kconfig
> @@ -9,6 +9,7 @@ menuconfig BPFILTER
>  if BPFILTER
>  config BPFILTER_UMH
>         tristate "bpfilter kernel module with user mode helper"
> +       depends on X86 # actually depends on native builds

No, (currently) it does depend on X86, due to its use of:

    $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT)

with CONFIG_OUTPUT_FORMAT being defined on X86 only...

>         default m
>         help
>           This builds bpfilter kernel module with embedded user mode helper

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
