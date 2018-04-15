Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeDOPDf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 11:03:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45789 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeDOPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 11:03:31 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w3FF3F3G009865
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: AIpwx4/GoEM1oqFo2ZyvpnMqSdCkIx5xMbLlMTqTtPjaqJEAICv1W0dG2IqCCmND8E5VeckHalipYFm3bVjXJdUU/14=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KRTan6BLJEtLaa+6eFhTEQOJqDkQaKpKtVwd8iCvLuFMw@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-21-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KRTan6BLJEtLaa+6eFhTEQOJqDkQaKpKtVwd8iCvLuFMw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 16 Apr 2018 00:02:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkwhBZGsUbg29vB3L8U2dKvV0i0CFYKgXrGuVk65bjaQ@mail.gmail.com>
Message-ID: <CAK7LNARkwhBZGsUbg29vB3L8U2dKvV0i0CFYKgXrGuVk65bjaQ@mail.gmail.com>
Subject: Re: [PATCH 20/30] kconfig: add basic helper macros to scripts/Kconfig.include
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-15 16:41 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Fri, Apr 13, 2018 at 7:06 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Kconfig got text processing tools like we see in Make.  Add Kconfig
>> helper macros to scripts/Kconfig.include like we collect Makefile
>> macros in scripts/Kbuild.include.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>
>> Changes in v3:
>>   - Move helpers to scripts/Kconfig.include
>>
>> Changes in v2: None
>>
>>  Kconfig                 |  2 ++
>>  MAINTAINERS             |  1 +
>>  scripts/Kconfig.include | 17 +++++++++++++++++
>>  3 files changed, 20 insertions(+)
>>  create mode 100644 scripts/Kconfig.include
>>
>> diff --git a/Kconfig b/Kconfig
>> index 5b55d87..a90d9f9 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -7,4 +7,6 @@ mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
>>
>>  comment "Compiler: $(CC_VERSION_TEXT)"
>>
>> +source "scripts/Kconfig.include"
>> +
>>  source "arch/$(SRCARCH)/Kconfig"
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b9dab38..d962f4a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7624,6 +7624,7 @@ L:        linux-kbuild@vger.kernel.org
>>  S:     Maintained
>>  F:     Documentation/kbuild/kconfig*
>>  F:     scripts/kconfig/
>> +F:     scripts/Kconfig.include
>>
>>  KDUMP
>>  M:     Dave Young <dyoung@redhat.com>
>> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
>> new file mode 100644
>> index 0000000..cac7a81
>> --- /dev/null
>> +++ b/scripts/Kconfig.include
>> @@ -0,0 +1,17 @@
>> +# Kconfig helper macros
>> +
>> +# Convenient variables
>> +comma   := ,
>> +quote   := "
>> +squote  := '
>> +empty   :=
>> +space   := $(empty) $(empty)
>> +
>> +# y if the command exits with 0, n otherwise
>> +success = $(shell ($(1)) >/dev/null 2>&1 && echo y || echo n)
>
> '{ $(1); }' might work here, to avoid the extra subshell.
>
> Shaves 20-30% off the runtime here in a silly
> system("(true) >/dev/null 2>&1 && echo y || echo n") vs.
> system("{ true; } >/dev/null 2>&1 && echo y || echo n")
> comparison.


You are right.   Will do so in the next version.






-- 
Best Regards
Masahiro Yamada
