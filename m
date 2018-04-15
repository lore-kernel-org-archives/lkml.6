Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeDOJlW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:41:22 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35523 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeDOJlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:41:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3F9f17T021587
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: AIpwx49OpxdQsVZ+5fwRJk1lwGKw+O8inLaJ+YoYT01BgeWEOjZoD8aMkeChgb8rx96eh3snx1AiDii62jYQt7Orb0E=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLt4xoxXTw83-npD4WmumPzSC9WnbOkkDoR=VYa5R4rYw@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-22-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jLt4xoxXTw83-npD4WmumPzSC9WnbOkkDoR=VYa5R4rYw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 15 Apr 2018 18:40:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATM=7b_KReRZ8MqhiLPfP_itaxOW-17zHZpzSn_AOgThw@mail.gmail.com>
Message-ID: <CAK7LNATM=7b_KReRZ8MqhiLPfP_itaxOW-17zHZpzSn_AOgThw@mail.gmail.com>
Subject: Re: [PATCH 21/30] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-14 1:41 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Thu, Apr 12, 2018 at 10:06 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> +stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
>> +stackp-flags-$(CONFIG_CC_STACKPROTECTOR)          := -fstack-protector
>> +stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)   := -fstack-protector-strong
>> +
>> +KBUILD_CFLAGS += $(stackp-flags-y)
>
> So, technically, this works just fine. I wonder if it has an overly
> confusing result, in that the compiler under normal situations will
> see:
>
> gcc ... -fno-stack-protector -fstack-protector -fstack-protector-strong ...


Kees, you are wrong.

Look at my code closely.

I used := operator instead of +=.

$(stackp-flags-y) contains only one flag at most.



> How about something like this instead:
>
> ifdef CONFIG_CC_STACKPROTECTOR_STRONG
> KBUILD_CFLAGS += -fstack-protector-strong
> else
> ifdef CONFIG_CC_STACKPROTECTOR
> KBUILD_CFLAGS += -fstack-protector
> else
> KBUILD_CFLAGS += -fno-stack-protector
> endif
> endif
>

My code is much cleaner, and working fine.



-- 
Best Regards
Masahiro Yamada
