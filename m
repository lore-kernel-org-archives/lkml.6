Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEEEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6D721473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PLTvcstW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6D721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeHTVmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:42:21 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:39307 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHTVmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:42:20 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 17:42:18 EDT
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7KIPWh9002008;
        Tue, 21 Aug 2018 03:25:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7KIPWh9002008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534789533;
        bh=l7hZypD3JeUZUgstw0b2KnUCA1ccne6Ft+3q/ZjFcfI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PLTvcstWibnylDOgBfeErUzWMKruIGIYwBKfQRV8+SiBuNL9s+SGPTwAFfJZUkq0A
         w/PjvI0RqhPaoQbfi4LwWrLfurNJZCeO0f4La53/2yeBJlE2SbMp1uz/7jt96yD3mn
         xJIMvGDdyEN7D28Kw/RE+lJ6/IE9Pc96w01+yjwlErFnMz3GeWmnU3GFwD2IDQ3Txj
         zcUcwfBHmgYND8vnLsZ1kBI+LF2AqsS4Xvzdi5JEftX08pzgQXRoF/cwMxg2Ty3Vit
         eRazJA/d+obUcnh9s1Gk9fD/kmboq4ogjBSp9HMqyGfgWvhPB4/BYLVKEsVEnhMvTN
         oWYmfrawXISBA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id u11-v6so10279260uan.13;
        Mon, 20 Aug 2018 11:25:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlGZg/iCscsNFAy8Szp2Khc1hWBPIpcWjRFWmC38FLT45mLzIUdw
        sgLEQXsYjrA33A4KXGTWOjaHCbDvvhxyOJVFnX0=
X-Google-Smtp-Source: AA+uWPw54ohp9I8xgn9BzGVcSwDcgJYLrz+0MxCIBeHw9Ux964wejrKC36kt7YaFIkTH8DLgqYL8KJQz0hsS2w1OQIE=
X-Received: by 2002:ab0:30ce:: with SMTP id c14-v6mr30889680uam.58.1534789531457;
 Mon, 20 Aug 2018 11:25:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 11:24:51
 -0700 (PDT)
In-Reply-To: <20180806183329.qditzzemevdafcwb@unicorn.suse.cz>
References: <20180627143705.5a1fed1c@kitsune.suse.cz> <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz> <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
 <20180806183329.qditzzemevdafcwb@unicorn.suse.cz>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 03:24:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkq39NqFGEa+x6kpS9rwE7pSA36L++SUc9gwccgfySDQ@mail.gmail.com>
Message-ID: <CAK7LNASkq39NqFGEa+x6kpS9rwE7pSA36L++SUc9gwccgfySDQ@mail.gmail.com>
Subject: Re: due to kconfig changes kernel config file is no longer sufficient
 for configuring the kernel
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Jeff Mahoney <jeffm@suse.com>,
        "Peter Zijlstra," <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-07 3:33 GMT+09:00 Michal Kubecek <mkubecek@suse.cz>:
> On Mon, Jul 30, 2018 at 05:02:42PM +0900, Masahiro Yamada wrote:
>>
>> For exmaple 'make ARCH=arm config' will create the config suitable
>> only for ARM architecture.
>> Then, you need to do 'make ARCH=arm' to build the kernel.
>>
>> If it is tedious to give 'ARCH=arm' to every make command,
>> you can do 'export ARCH=arm' in your shell.
>>
>> Again, this is the behavior we have for a long time.
>
> Actually, this no longer works reliably. For example, when I run
>
>   ARCH=powerpc make oldconfig
>
> with our ppc64le config on x86_64 system, I get different result than
> when I run it on an actual ppc64le system (or when using a ppc64le cross
> compiler on x86_64).


This is because you used different compilers.


> Since .config started to mix user configuration and build environment
> capabilities, maintaining distribution configs became real pain. And
> it's getting progressively worse.

This is improvement requested by Linus Torvalds.

Prior to the change, the user configuration in the .config
did not reflect what you get.
Even if you enable CONFIG_FOO=y,
it might be silently disabled by $(call cc-option, ...) in Makefile
if the feature is not supported by the compiler.


By moving the compiler evaluation to the Kconfig phase,
the .config matches to what you get.



> Michal Kubecek
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
