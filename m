Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vhIdNrkqGlt8HQAAmS7hNA
	; Fri, 08 Jun 2018 07:05:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BCA536089E; Fri,  8 Jun 2018 07:05:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XPhKEMqs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5B0B6601C3;
	Fri,  8 Jun 2018 07:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B0B6601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeFHHF0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:05:26 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:55009 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeFHHFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:05:23 -0400
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com [209.85.217.171]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5875GbI016134;
        Fri, 8 Jun 2018 16:05:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5875GbI016134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528441517;
        bh=Iim/hvEk6SUMUm4EpSSRY/yFf9WjF+25JvqsSfbmWGk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=XPhKEMqsIavUf5as7Kfxpxsnwg/frZTtgu4KJrMaTSiK2IDj/gfu7RkZ9LuoPcA8M
         aGqjlg8Uirq1uXoK1V2wQvQQ1J7Q0DEi1VNZLORLHD9efjIuzy/KE5k0qkbvH1TbMM
         bqH20seDVYTsb/DSKQcDK4KqT8X1Ssd85cEebr84R+peslPUg3f+30thjI6NZnKBa7
         nQkVJ7j9edLJZkOfPB4V4DGgc30SRIZ9a3I2T/CoRd2NPEQ7bHBP9nGWC3jWB+oGkK
         xiDpFNzLl+w06w7cbVaajocfMIgTPQ7fCXuZr5MxnHV8DMsYIbrqCEarsSvfgWyYlu
         Oi6b1mz24EpIw==
X-Nifty-SrcIP: [209.85.217.171]
Received: by mail-ua0-f171.google.com with SMTP id c23-v6so8219210uan.3;
        Fri, 08 Jun 2018 00:05:16 -0700 (PDT)
X-Gm-Message-State: APt69E0Zm0B9ijVTcYIaVqVMsjeiW/WeLv/yA35WLWls2SvM8wduGmwL
        ey+z5M7m0AYJ4f6LXwyUHQp/VMnvMFdiW4O0gUA=
X-Google-Smtp-Source: ADUXVKIgN14FKphlNPaQLTFoxFlhkOaK1LMHxH8NFR4DmJQb9V8GE52tgGF7T6QZ4jAZC+3V8a4HfInhjCSxNE7eccM=
X-Received: by 2002:ab0:7089:: with SMTP id m9-v6mr3329230ual.141.1528441515784;
 Fri, 08 Jun 2018 00:05:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:04:35 -0700 (PDT)
In-Reply-To: <CAK7LNAQxS7xkqja2J5FNkRfhCtQpeKqJVsQXFggQrJT6cL_2Cw@mail.gmail.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <1527499328-13213-22-git-send-email-yamada.masahiro@socionext.com>
 <CAMuHMdUDCtnyqydZan9Q-+hOQacWGJrrMbw4LshjYSjn2=yBjw@mail.gmail.com> <CAK7LNAQxS7xkqja2J5FNkRfhCtQpeKqJVsQXFggQrJT6cL_2Cw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 8 Jun 2018 16:04:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5f+ZU+W9hUZJW+78rATsUjmgSnq31f-iZkMgPEhaoBw@mail.gmail.com>
Message-ID: <CAK7LNAR5f+ZU+W9hUZJW+78rATsUjmgSnq31f-iZkMgPEhaoBw@mail.gmail.com>
Subject: Re: [PATCH v5 21/31] kconfig: show compiler version text in the top comment
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,


2018-06-07 17:58 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Geert,
>
>
> 2018-06-07 17:42 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> Hi Yamada-san,
>>
>> On Mon, May 28, 2018 at 11:21 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> The kernel configuration phase is now tightly coupled with the compiler
>>> in use.  It will be nice to show the compiler information in Kconfig.
>>>
>>> The compiler information will be displayed like this:
>>>
>>>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- config
>>>   scripts/kconfig/conf  --oldaskconfig Kconfig
>>>   *
>>>   * Linux/arm64 4.16.0-rc1 Kernel Configuration
>>>   *
>>>   *
>>>   * Compiler: aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
>>>   *
>>>   *
>>>   * General setup
>>>   *
>>>   Compile also drivers which will not load (COMPILE_TEST) [N/y/?]
>>>
>>> If you use GUI methods such as menuconfig, it will be displayed in the
>>> top menu.
>>>
>>> This is simply implemented by using the 'comment' statement.  So, it
>>> will be saved into the .config file as well.
>>>
>>> This commit has a very important meaning.  If the compiler is upgraded,
>>> Kconfig must be re-run since different compilers have different sets
>>> of supported options.
>>>
>>> All referenced environments are written to include/config/auto.conf.cmd
>>> so that any environment change triggers syncconfig, and prompt the user
>>> to input new values if needed.
>>>
>>> With this commit, something like follows will be added to
>>> include/config/auto.conf.cmd
>>>
>>>   ifneq "$(CC_VERSION_TEXT)" "aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011"
>>>   include/config/auto.conf: FORCE
>>>   endif
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> This is now commit 21c54b774744719c ("kconfig: show compiler version text
>> in the top comment") upstream.
>>
>> This commit broke cross-compilation for me:
>>
>>     $ make ARCH=m68k
>>     scripts/kconfig/conf  --syncconfig Kconfig
>>     scripts/kconfig/conf  --syncconfig Kconfig
>>     scripts/kconfig/conf  --syncconfig Kconfig
>>     scripts/kconfig/conf  --syncconfig Kconfig
>>     ...
>>
>> with O=:
>>
>>       GEN     ./Makefile
>>      scripts/kconfig/conf  --syncconfig Kconfig
>>       GEN     ./Makefile
>>     scripts/kconfig/conf  --syncconfig Kconfig
>>       GEN     ./Makefile
>>     scripts/kconfig/conf  --syncconfig Kconfig
>>       GEN     ./Makefile
>>     ...
>>
>> .config gained (both with/without O=):
>>
>>     #
>>     # Compiler: gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>>     #
>>
>> which is definitely wrong when cross-compiling for m68k.
>>
>> Reverting the commit, and fixing up the conflicts, fixes the issue for me
>>
>> Do you have a clue?
>> Thanks!
>
>
> Agh, I missed the case where CROSS_COMPILE is
> set by arch/$(SRCARCH)/Makefile.
>
>
> I will fix it.  Thanks for the report!


I posted a patch.
https://patchwork.kernel.org/patch/10453685/

I hope it will fix your problem.


Thanks,

-- 
Best Regards
Masahiro Yamada
