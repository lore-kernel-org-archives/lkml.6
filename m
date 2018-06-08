Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vjbhHZ88GluoOgAAmS7hNA
	; Fri, 08 Jun 2018 08:23:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 708D5607E4; Fri,  8 Jun 2018 08:23:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3tuVFkd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C33F760590;
	Fri,  8 Jun 2018 08:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C33F760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeFHIX0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:23:26 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37229 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeFHIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:22:43 -0400
Received: by mail-ua0-f196.google.com with SMTP id i3-v6so8338239uad.4;
        Fri, 08 Jun 2018 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LUoCfABQXykEbDmg8Afn9uUe1pvrxvO4FI6fSj57kzM=;
        b=k3tuVFkd7GSD9TZwIbpiqTOfGPf2DjpVKAeYelM8E+dxvoIB1OPr6bPsj8owBj4Brp
         gv1qW7ACJEj50Xk8lOdvXVgL2HeO2NP8pqTRhM6JPtPORaiilBS3Al/uUt/ZdZ/ux7cZ
         oh4frNiBJ4cUXQdnWnjdT2fDT2fMa9aizt8fe8heRgSv7uGuKq7o4GzP0fR1Lwq1gWI9
         1E++lk+zJEEmhQF2LDpm+90jRoYQuwVJZcF5861QKJlFwLR/E67f2kHbCzJPemudvrf/
         JAKwqpfbTiXsMW9kebnzNKFtnJIe+BE4nzOTN86MTn7VybMmNA7nl/voRkcB3e6Khn66
         71YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LUoCfABQXykEbDmg8Afn9uUe1pvrxvO4FI6fSj57kzM=;
        b=hwNpSdERIbRUKk5Pbqc5/Z94Lm4JWaKupMvGJHpyDsReG080W4n3JqRhJ6eXPkyXoE
         ct41qAms0yNPcdJGUZ0TQEX4ZsojrIDAJiCuQR6BBPeDj6KJHkXQUS3fS3cypkLD3ai3
         q1mH5AM1dT/cpeQFjhNNg+raZgsg8LQkr6Sjg52NWC/ZSAvdcxbEMvI9nTw+nx/CN0Uc
         /n6FZHLGNmgRFT/OlKArUZPwhQRZrT6vRolfSuOGZpCnC8ekdg9HZejSOP8RdYzEqNBT
         G6Hx79MhMeK2N6EHa6UkOQdUlR6qa3wqpwxzhTNJghADmZb+oNqDlLdifdKJrZaSwEXG
         Nm1w==
X-Gm-Message-State: APt69E3f05zHDThFhno+yLx+W47ceo3XI73Lg1gG3ADtNNx2FP3PZXsz
        CuTw7nSlHzzo6ETunRBdOBLJpt8RmEQ3h7yUqqI=
X-Google-Smtp-Source: ADUXVKK5KmtrTauqDWEYM10rUw+dKYnQbIPG5NhMe21kFLzrshTsgV9zwXtKGotfwqlUdqz5IFu1/1n8UuUOc8qSQzg=
X-Received: by 2002:ab0:48e1:: with SMTP id y30-v6mr3524068uac.180.1528446162295;
 Fri, 08 Jun 2018 01:22:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:22:41 -0700 (PDT)
In-Reply-To: <CAK7LNAR5f+ZU+W9hUZJW+78rATsUjmgSnq31f-iZkMgPEhaoBw@mail.gmail.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <1527499328-13213-22-git-send-email-yamada.masahiro@socionext.com>
 <CAMuHMdUDCtnyqydZan9Q-+hOQacWGJrrMbw4LshjYSjn2=yBjw@mail.gmail.com>
 <CAK7LNAQxS7xkqja2J5FNkRfhCtQpeKqJVsQXFggQrJT6cL_2Cw@mail.gmail.com> <CAK7LNAR5f+ZU+W9hUZJW+78rATsUjmgSnq31f-iZkMgPEhaoBw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Jun 2018 10:22:41 +0200
X-Google-Sender-Auth: y7szswoaj74IrePhqmJO2ls-dPs
Message-ID: <CAMuHMdV9U1-3NsojpAZROAJsKSyun=RzFt6CqGAHwW3KHqi5kA@mail.gmail.com>
Subject: Re: [PATCH v5 21/31] kconfig: show compiler version text in the top comment
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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

Hi Yamada-san,

On Fri, Jun 8, 2018 at 9:04 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-06-07 17:58 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2018-06-07 17:42 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>>> On Mon, May 28, 2018 at 11:21 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> The kernel configuration phase is now tightly coupled with the compiler
>>>> in use.  It will be nice to show the compiler information in Kconfig.

[...]

>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>
>>> This is now commit 21c54b774744719c ("kconfig: show compiler version text
>>> in the top comment") upstream.
>>>
>>> This commit broke cross-compilation for me:
>>>
>>>     $ make ARCH=m68k
>>>     scripts/kconfig/conf  --syncconfig Kconfig
>>>     scripts/kconfig/conf  --syncconfig Kconfig
>>>     scripts/kconfig/conf  --syncconfig Kconfig
>>>     scripts/kconfig/conf  --syncconfig Kconfig
>>>     ...
>>>
>>> with O=:
>>>
>>>       GEN     ./Makefile
>>>      scripts/kconfig/conf  --syncconfig Kconfig
>>>       GEN     ./Makefile
>>>     scripts/kconfig/conf  --syncconfig Kconfig
>>>       GEN     ./Makefile
>>>     scripts/kconfig/conf  --syncconfig Kconfig
>>>       GEN     ./Makefile
>>>     ...
>>>
>>> .config gained (both with/without O=):
>>>
>>>     #
>>>     # Compiler: gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>>>     #
>>>
>>> which is definitely wrong when cross-compiling for m68k.
>>>
>>> Reverting the commit, and fixing up the conflicts, fixes the issue for me
>>>
>>> Do you have a clue?
>>> Thanks!
>>
>>
>> Agh, I missed the case where CROSS_COMPILE is
>> set by arch/$(SRCARCH)/Makefile.
>>
>>
>> I will fix it.  Thanks for the report!
>
> I posted a patch.
> https://patchwork.kernel.org/patch/10453685/
>
> I hope it will fix your problem.

Yes it has. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
