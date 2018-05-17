Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeEQOXh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:23:37 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48237 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeEQOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:23:35 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4HENLbF003773
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AB8JxZqGJZiEuYD0UJfMepPAo8m6/GydSP/ZDQ0d+hx/I25mfytHAwcm8sREch8v2a52OJ3anbDI9gPQr6XmWjtGMzs=
MIME-Version: 1.0
In-Reply-To: <20180517175156.4c4246f6@roar.ozlabs.ibm.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <20180517175156.4c4246f6@roar.ozlabs.ibm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 17 May 2018 23:22:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZaQK6xojz7GHEb1+-aHckJnR=tA=HJXiQaJ3AwypM-g@mail.gmail.com>
Message-ID: <CAK7LNARZaQK6xojz7GHEb1+-aHckJnR=tA=HJXiQaJ3AwypM-g@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] kconfig: move compiler capability tests to Kconfig
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-17 16:51 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> On Thu, 17 May 2018 15:16:39 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> [Introduction]
>>
>> The motivation of this work is to move the compiler option tests to
>> Kconfig from Makefile.  A number of kernel features require the
>> compiler support.  Enabling such features blindly in Kconfig ends up
>> with a lot of nasty build-time testing in Makefiles.  If a chosen
>> feature turns out unsupported by the compiler, what the build system
>> can do is either to disable it (silently!) or to forcibly break the
>> build, despite Kconfig has let the user to enable it.  By moving the
>> compiler capability tests to Kconfig, Kconfig entries will be visible
>> only when they are available.
>>
>> [Major Changes in V4]
>
> Do you have a git tree for v4? I can test it with the powerpc patches.
>
> The new scripting capability in kconfig has allowed us to already
> improve the config process on powerpc:
>
> https://marc.info/?l=linuxppc-embedded&m=152648110727868&w=2
>
> I'm sure there's more clever things we can do with it but I haven't
> had time to think about it yet. One thing that comes to mind is that
> It might be nice to show the option as disabled, then the user could
> upgrade their compiler to get the options they want.
>
> Anyway v3 worked fine for me, the documentation is really nice, I
> could implement the above patch without any problem despite being a
> kbuild dummy. Thanks for the series, ack from me.


For easier review and test,
I pushed v4 to the following branch:


git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kconfig-shell-v4


-- 
Best Regards
Masahiro Yamada
