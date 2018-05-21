Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbeEUFjz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 01:39:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43907 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEUFjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 01:39:53 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4L5dTTo015658
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AB8JxZrDEf8M8e1qPeAvS1XyJqgxCdTmKqiVjFAtTpbpZBdLbTJOxdQxHkMbMgmXlRQ8ScLDCXU/037j0xCXkh96sso=
MIME-Version: 1.0
In-Reply-To: <20180520143933.GA9826@ravnborg.org>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-6-git-send-email-yamada.masahiro@socionext.com> <20180520143933.GA9826@ravnborg.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 21 May 2018 14:38:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATr+qHfjpYaj2h2-AcMUFozeyRDETjtJcp4kd8=DEk5dw@mail.gmail.com>
Message-ID: <CAK7LNATr+qHfjpYaj2h2-AcMUFozeyRDETjtJcp4kd8=DEk5dw@mail.gmail.com>
Subject: Re: [PATCH v4 05/31] kconfig: remove string expansion for mainmenu
 after yyparse()
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-20 23:39 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:

>> @@ -544,10 +530,10 @@ void conf_parse(const char *name)
>>       if (!modules_sym)
>>               modules_sym = sym_find( "n" );
>>
>> -     tmp = rootmenu.prompt->text;
>> -     rootmenu.prompt->text = _(rootmenu.prompt->text);
>> -     rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
>> -     free((char*)tmp);
>> +     if (!menu_has_prompt(&rootmenu)) {
>> +             current_entry = &rootmenu;
>> +             menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
>
> Could this be something less specific?
> To help the other users of kconfig out is the wild.
>
> For example:
>
>         menu_add_prompt(P_MENU, _("Main menu"), NULL);


OK, but this should be done as a separate work.

I am keeping the current string "Linux Kernel Configuration"



> Note, the added _() to make the text translateable.
>

Hmm, I just wonder how much helpful gettext things are...

Rather, it looks maintenance burden to me.
Once we add messages, it is difficult to change.


-- 
Best Regards
Masahiro Yamada
