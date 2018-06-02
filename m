Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeFBHkw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 03:40:52 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:29236 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeFBHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 03:40:49 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w527eR7a008447
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: ADUXVKLkLRkAqBUmeHI85u5yAnaA9A7NIu5xeg8xwBc1A+64ILFB4m8XHKfNzjdHhBN6dQIR/jR+G1XkuDgDiCoVzy4=
MIME-Version: 1.0
In-Reply-To: <20180531041835.GA15842@flashbox>
References: <20180531041835.GA15842@flashbox>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 2 Jun 2018 16:39:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjg0Hh+3KcyXx0F4ieFzVwaoDJrk+3YA3xHAKT+vD8fQ@mail.gmail.com>
Message-ID: <CAK7LNARjg0Hh+3KcyXx0F4ieFzVwaoDJrk+3YA3xHAKT+vD8fQ@mail.gmail.com>
Subject: Re: Kconfig warnings with GCC 8.1.0
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w527fDBQ007804

Hi.


2018-05-31 13:18 GMT+09:00 Nathan Chancellor <natechancellor@gmail.com>:
> Hi everyone,
>
> My apologies if this has already been reported in some capacity, I
> searched the mailing list and patchwork but I didn't see anything.


I think you are the first reporter.


> With GCC 8.1.0, I am starting to see the following warnings from
> Kconfig:
>
>   CC    scripts/kconfig/zconf.tab.c
>   LEX     scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
> In file included from scripts/kconfig/zconf.tab.c:2496:
> scripts/kconfig/confdata.c: In function ‘conf_write’:
> scripts/kconfig/confdata.c:748:22: warning: ‘%s’ directive writing likely 7 or more bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
>   sprintf(newname, "%s%s", dirname, basename);
>                       ^~
> scripts/kconfig/confdata.c:748:19: note: assuming directive output of 7 bytes
>   sprintf(newname, "%s%s", dirname, basename);
>                    ^~~~~~
> scripts/kconfig/confdata.c:748:2: note: ‘sprintf’ output 1 or more bytes (assuming 4104) into a destination of size 4097
>   sprintf(newname, "%s%s", dirname, basename);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> scripts/kconfig/confdata.c:751:23: warning: ‘.tmpconfig.’ directive writing 11 bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
>    sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
>                        ^~~~~~~~~~~
> scripts/kconfig/confdata.c:751:3: note: ‘sprintf’ output between 13 and 4119 bytes into a destination of size 4097
>    sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTLD  scripts/kconfig/conf
>
> I am not sure if this is a false positive or not, otherwise I would have
> sent a patch. I tested on the latest linux-next with Masahiro's for-next
> branch, currently at commit 57282f7da50c ("Merge branch 'kconfig' into
> for-next").


I think these are legitimate warnings.

A patch is welcome.



-- 
Best Regards
Masahiro Yamada
