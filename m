Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCZP02 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:26:28 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26798 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeCZP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:26:27 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2QFQ00L003955
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AG47ELteNauGhX4ff+xuVxZTPVv5L+0JUUgY9QMIVczPtTuhGamLOMhk2x4a8624imo301EU4Qi5unBH3EXYd9KnY2Q=
MIME-Version: 1.0
In-Reply-To: <1521738014-18895-3-git-send-email-yamada.masahiro@socionext.com>
References: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com> <1521738014-18895-3-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Mar 2018 00:25:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASam+Do=PVxjVLYNY5ANw+pC4Rc6RV0Cua+Ac5+i2N6Vw@mail.gmail.com>
Message-ID: <CAK7LNASam+Do=PVxjVLYNY5ANw+pC4Rc6RV0Cua+Ac5+i2N6Vw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kconfig: use yylineno option instead of manual lineno increments
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 2:00 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Tracking the line number by hand is error-prone since we need to make
> sure to increment it in all the \n matching patterns.
>
> If '%option yylineno' is set, flex defines 'yylineno' to contain the
> current line number and automatically updates it each time it reads a
> \n character.  This is much more convenient although the lexer does
> not initializes yylineno, so you need to set it to 1 each time you
> start reading a new file, and restore it you go back to the previous
> file.
>
> I tested this with DEBUG_PARSE, and confirmed the same dump message
> was produced.
>
> I removed the perf-report option.  Otherwise, I see the following
> message:
>   %option yylineno entails a performance penalty ONLY on rules that
>   can match newline characters
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/kconfig.



-- 
Best Regards
Masahiro Yamada
