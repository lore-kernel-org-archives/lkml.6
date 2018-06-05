Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeFEAIz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 20:08:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:45305 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeFEAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 20:08:53 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5508dvO012237
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: ADUXVKIoNMggRyxcRZoPgEcAJ4oFc+shY7TIbAtVJn0pnppksxD45dlDO8qmRW2K5uNxAnpQgEz6DQ6/KP+ipiIjpjk=
MIME-Version: 1.0
In-Reply-To: <dbd4d0dc92ba45dcae81cbab8ab8ba29@agner.ch>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <1527499328-13213-25-git-send-email-yamada.masahiro@socionext.com> <dbd4d0dc92ba45dcae81cbab8ab8ba29@agner.ch>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 5 Jun 2018 09:07:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ9t-eRRb_mYunEAocaYksOTr=4sw+pExhMd9AvMx+zOw@mail.gmail.com>
Message-ID: <CAK7LNAQ9t-eRRb_mYunEAocaYksOTr=4sw+pExhMd9AvMx+zOw@mail.gmail.com>
Subject: Re: [PATCH v5 24/31] kconfig: add CC_IS_GCC and GCC_VERSION
To: Stefan Agner <stefan@agner.ch>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kbuild-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

2018-06-05 6:49 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> Hi Masahiro,
>
> On 28.05.2018 11:22, Masahiro Yamada wrote:
>> This will be useful to specify the required compiler version,
>> like this:
>>
>> config FOO
>>         bool "Use Foo"
>>         depends on GCC_VERSION >= 40800
>>         help
>>           This feature requires GCC 4.8 or newer.
>>
>
> I tried using CC_IS_GCC today while using clang. It seems that it is set
> to y despite I am using CC=clang.
>
> .config looks like this after config:
>
> ...
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=40201
> CONFIG_CC_IS_CLANG=y
> CONFIG_CLANG_VERSION=60000
> ...
>
>
> I am using clang 6.0.0 on Arch Linux, which seems to return a version
> when using gcc-version.sh:
> ./scripts/gcc-version.sh clang | sed 's/^0*//'
> 402
>
> I guess that should not be the case?
>


What will 'clang --version' print on your machine?
