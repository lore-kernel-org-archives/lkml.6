Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeCTPem (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:34:42 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38677 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCTPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:34:36 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2KFYNsb005237
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AG47ELvFcS5ILLgf8yTLvdZDkd7Qttn4nOn0FGAeXH8DYBwEDC8V3227j9c3+WJWhkNfW8afM8MeEsE0hADj3voIECk=
MIME-Version: 1.0
In-Reply-To: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Mar 2018 00:33:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR40u3wqM2rF9bWEXNH2TF0i+bwwY9r9PLmKEV_ymt-gg@mail.gmail.com>
Message-ID: <CAK7LNAR40u3wqM2rF9bWEXNH2TF0i+bwwY9r9PLmKEV_ymt-gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] kbuild: remove unnecessary $(subst $(obj)/, , ...)
 in modname-multi
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-19 18:01 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> In the context ...
>
>     $(obj)/%.s: $(src)/%.c FORCE
>             $(call if_changed_dep,cc_s_c)
>
>     $(obj)/%.i: $(src)/%.c FORCE
>             $(call if_changed_dep,cpp_i_c)
>
>     $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>             $(call cmd,force_checksrc)
>             $(call if_changed_rule,cc_o_c)
>
>     $(obj)/%.lst: $(src)/%.c FORCE
>             $(call if_changed_dep,cc_lst_c)
>
> '$*' returns the stem of the target (the part of '%'), so $(obj)/ has
> already been ripped off.
>
> $(subst $(obj)/,,$*.o) is the same as $*.o
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>
> Changes in v2: None
>


Series, applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
