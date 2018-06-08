Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6wbtAC5PGlvgCAAAmS7hNA
	; Fri, 08 Jun 2018 09:41:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C1C0F605A5; Fri,  8 Jun 2018 09:41:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFyZAG+f"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EB6A60275;
	Fri,  8 Jun 2018 09:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EB6A60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeFHJk6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:40:58 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44654 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeFHJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:40:56 -0400
Received: by mail-ua0-f196.google.com with SMTP id f30-v6so8465293uab.11;
        Fri, 08 Jun 2018 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nsL6jM9rnzz3CN/qLMtM2b3bzQjC8AniyX1qowaSuHc=;
        b=MFyZAG+fkr4311+vEotQNFx9PhOMncA9DFz1q4ZFYoWjvQrgIdScWb2rXvS0+feIdA
         4chMbk3ygUb0hkhz3g0Dl94G3MWYxN4MTvJBgsm+BZpKFg70IdVZeYHMNYWHBD3ZdVFD
         c958U2xjrfZA6PZRjGJTkeiSn27AFnzi4ucuilOW2NqRV55f8ayzQPi2ZtXXAjmS5zSV
         mSfFCTrIKMQZ4TxB+tjtzPZoHZvjQr9IS9Kn4p+69ZDQDY2VTmEGQ1yaIO2vjW9qVyX/
         xFMSdsLt+90mnUFcmERfq+91AhW2ccFIuB049ukPqdqBEguw/DdQPcbZ5aJ8Zrtsd+Ht
         y9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nsL6jM9rnzz3CN/qLMtM2b3bzQjC8AniyX1qowaSuHc=;
        b=pMuLK/PiJVfZglFGj4XiJ8FmmWllHu0l4Qt8gmNBU9RAp/qa0vdcl+8NhlNWuVvCxP
         cqF5kU7YtWTfzDdMyBtY5Fkwq9yAaRC4POi/pS44dYsjPxOfBnFrrNS7l80sLSxaJKqB
         aBsR2S19w4ve2GOgqYW0U+9UF3nk/IyBgXG4MIXyWUg41b3koQSOkIv30103cukwp5MZ
         MXxmxE8rJikeR2Lt2gy8k3u++jRBnZaIjcWD2oKXKuYtYPF2yn32IDNHlR/VxcLwQb/s
         jNrc0Yc4yUA61MOXssGMHxNa7TOKg8e2iWERBYaCy6mu4OwrYsnMrEHPWCiq0sCjOQOY
         eZlg==
X-Gm-Message-State: APt69E1Ti/wwHVdmO6vtda1Yla6RxurHhg7hWe5AFGAXJQa8YGi+3Bwf
        qtKcABeO/orbBgB53OuWcXpp97eXVoWCtuwThmw=
X-Google-Smtp-Source: ADUXVKIyAW+vGC7UXcEbM5ggpMXLhWwdPjKLS5xbHnddBGHBNDoClnNrTghAIZFTsv63IWwBUqW4kxaBCwiIMCKkGCU=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr3658820uae.12.1528450855006;
 Fri, 08 Jun 2018 02:40:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 02:40:54 -0700 (PDT)
In-Reply-To: <8c0f8cc4-b919-9b69-4144-fd216253aa24@iogearbox.net>
References: <20180528153222.2037158-1-arnd@arndb.de> <CAMuHMdXy0uHXaGkFBh9_tr2VzmJF+8KtraTuFHJwcmqhcHs4Dg@mail.gmail.com>
 <8c0f8cc4-b919-9b69-4144-fd216253aa24@iogearbox.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Jun 2018 11:40:54 +0200
X-Google-Sender-Auth: dK16CqOEA1Fc4-ostBUn9mrYwwM
Message-ID: <CAMuHMdVaiWxU83H8X11q0izK3ULrfaaOvU1mMuHT-cE0CZ0tUg@mail.gmail.com>
Subject: Re: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Jun 8, 2018 at 11:33 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/08/2018 10:57 AM, Geert Uytterhoeven wrote:
>> On Mon, May 28, 2018 at 5:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> When build testing across architectures, I run into a build error on
>>> all targets other than X86:
>>>
>>> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objdump: net/bpfilter/bpfilter_umh: File format not recognized
>>> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy:net/bpfilter/bpfilter_umh.o: Invalid bfd target
>>>
>>> The problem is that 'hostprogs' get built with 'gcc' rather than
>>> '$(CROSS_COMPILE)gcc', and my default gcc (as most people's) targets x86.
>>>
>>> To work around it, adding an X86 dependency gets randconfigs building
>>> again on my box.
>>>
>>> Clearly, this is not a good solution, since it should actually work fine
>>> when building native kernels on other architectures but that is now
>>> disabled, while cross building an x86 kernel on another host is still
>>> broken after my patch.
>>>
>>> What we probably want here is to try out if the compiler is able to build
>>> executables for the target architecture and not build the helper otherwise,
>>> at least when compile-testing. No idea how to do that though.
>>
>> So that was done in commit 819dd92b9c0bc7bc ("bpfilter: switch to CC
>> from HOSTCC"), but it is not sufficient:
>>
>>       GEN net/bpfilter/bpfilter_umh.o
>>     Usage: m68k-linux-gnu-objcopy [option(s)] in-file [out-file]
>>      Copies a binary file, possibly transforming it in the process
>>      The options are:
>>     [...]
>>
>> net/bpfilter/Makefile:29: recipe for target 'net/bpfilter/bpfilter_umh.o' failed
>> make[5]: *** [net/bpfilter/bpfilter_umh.o] Error 1
>>
>>> --- a/net/bpfilter/Kconfig
>>> +++ b/net/bpfilter/Kconfig
>>> @@ -9,6 +9,7 @@ menuconfig BPFILTER
>>>  if BPFILTER
>>>  config BPFILTER_UMH
>>>         tristate "bpfilter kernel module with user mode helper"
>>> +       depends on X86 # actually depends on native builds
>>
>> No, (currently) it does depend on X86, due to its use of:
>>
>>     $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT)
>>
>> with CONFIG_OUTPUT_FORMAT being defined on X86 only...
>
> That hard dependency should have been fixed with the following patch in -net tree:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=8d97ca6b6755bf7ef57d323642ca9ee80d689782

Thanks, confirmed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
