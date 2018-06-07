Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N9LWF+nzGFuPMwAAmS7hNA
	; Thu, 07 Jun 2018 08:59:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10F4E607F7; Thu,  7 Jun 2018 08:59:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WMlkfQam"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 14702607DC;
	Thu,  7 Jun 2018 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14702607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeFGI7h (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:59:37 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:42130 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeFGI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:59:34 -0400
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w578xEbV011808;
        Thu, 7 Jun 2018 17:59:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w578xEbV011808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528361955;
        bh=PMun8LeXcvRDtaXhOv+ym+V2ir92E9BiC4F6onHIoU0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WMlkfQamkBm5jR/A8/spdogLPyyNrUgUenx2a0hTzb70ddhB9KQEkXL/ALAQVurg8
         ld8tjzWxjxIS8gXsoZyHH3jGAryfPKxn+hO3rvG9+KbuvHs8I5nyNRcQGhNQtw3WUy
         G9l9sZTA90KkJYmZr289TrfYLP6QMSYWFhBZtN/EHhjxzfZtuIr3jWK4CuYedmcpx/
         b1+z564S1SQRt0GUFgbAMRXVbKXdPKv7DF/lKCjTduq7r8MjAetgZ8CtxSXk5becEg
         04kZLw61YE0a569gNVN+WqAxDa1KGB8IBGzze9RLUFcPDrGnCn00zMN1t95PQu31dk
         cPjfppknlaPAA==
X-Nifty-SrcIP: [209.85.217.181]
Received: by mail-ua0-f181.google.com with SMTP id z16-v6so5969032uaz.10;
        Thu, 07 Jun 2018 01:59:15 -0700 (PDT)
X-Gm-Message-State: APt69E36U8dFkdCmYCgyJEj0d1pOMgyGLSDeqx6/vQ2rTn71rlUT9M+F
        MaER70GrCOQ35NUY/VH1boFITcUdePuVIXkinP0=
X-Google-Smtp-Source: ADUXVKLRw+GLpS0uOl+wB6K0UZXaf9Xl02X7lR8FdF2folrgUXKYwU7HU35+2mAHPIszQdr+4uYz27aiY3hN/P5Pj6E=
X-Received: by 2002:ab0:1048:: with SMTP id g8-v6mr569127uab.52.1528361953976;
 Thu, 07 Jun 2018 01:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 01:58:33 -0700 (PDT)
In-Reply-To: <CAMuHMdUDCtnyqydZan9Q-+hOQacWGJrrMbw4LshjYSjn2=yBjw@mail.gmail.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <1527499328-13213-22-git-send-email-yamada.masahiro@socionext.com> <CAMuHMdUDCtnyqydZan9Q-+hOQacWGJrrMbw4LshjYSjn2=yBjw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 7 Jun 2018 17:58:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxS7xkqja2J5FNkRfhCtQpeKqJVsQXFggQrJT6cL_2Cw@mail.gmail.com>
Message-ID: <CAK7LNAQxS7xkqja2J5FNkRfhCtQpeKqJVsQXFggQrJT6cL_2Cw@mail.gmail.com>
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


2018-06-07 17:42 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Mon, May 28, 2018 at 11:21 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> The kernel configuration phase is now tightly coupled with the compiler
>> in use.  It will be nice to show the compiler information in Kconfig.
>>
>> The compiler information will be displayed like this:
>>
>>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- config
>>   scripts/kconfig/conf  --oldaskconfig Kconfig
>>   *
>>   * Linux/arm64 4.16.0-rc1 Kernel Configuration
>>   *
>>   *
>>   * Compiler: aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
>>   *
>>   *
>>   * General setup
>>   *
>>   Compile also drivers which will not load (COMPILE_TEST) [N/y/?]
>>
>> If you use GUI methods such as menuconfig, it will be displayed in the
>> top menu.
>>
>> This is simply implemented by using the 'comment' statement.  So, it
>> will be saved into the .config file as well.
>>
>> This commit has a very important meaning.  If the compiler is upgraded,
>> Kconfig must be re-run since different compilers have different sets
>> of supported options.
>>
>> All referenced environments are written to include/config/auto.conf.cmd
>> so that any environment change triggers syncconfig, and prompt the user
>> to input new values if needed.
>>
>> With this commit, something like follows will be added to
>> include/config/auto.conf.cmd
>>
>>   ifneq "$(CC_VERSION_TEXT)" "aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011"
>>   include/config/auto.conf: FORCE
>>   endif
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> This is now commit 21c54b774744719c ("kconfig: show compiler version text
> in the top comment") upstream.
>
> This commit broke cross-compilation for me:
>
>     $ make ARCH=m68k
>     scripts/kconfig/conf  --syncconfig Kconfig
>     scripts/kconfig/conf  --syncconfig Kconfig
>     scripts/kconfig/conf  --syncconfig Kconfig
>     scripts/kconfig/conf  --syncconfig Kconfig
>     ...
>
> with O=:
>
>       GEN     ./Makefile
>      scripts/kconfig/conf  --syncconfig Kconfig
>       GEN     ./Makefile
>     scripts/kconfig/conf  --syncconfig Kconfig
>       GEN     ./Makefile
>     scripts/kconfig/conf  --syncconfig Kconfig
>       GEN     ./Makefile
>     ...
>
> .config gained (both with/without O=):
>
>     #
>     # Compiler: gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>     #
>
> which is definitely wrong when cross-compiling for m68k.
>
> Reverting the commit, and fixing up the conflicts, fixes the issue for me
>
> Do you have a clue?
> Thanks!


Agh, I missed the case where CROSS_COMPILE is
set by arch/$(SRCARCH)/Makefile.


I will fix it.  Thanks for the report!






-- 
Best Regards
Masahiro Yamada
