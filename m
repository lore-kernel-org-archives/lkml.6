Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32AAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9299720661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8MmLPf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9299720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDVYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:24:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36972 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeIDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:24:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so1965318pgo.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQFf6taefzciWoDofkCtPEp2enzeEeaQ6FbWpo2Wb7s=;
        b=A8MmLPf0aCuQJhQBJUhtzZp8pByHeRt6REV5hw5BaFvo0YGP6RgrZXGk9J1asReWk7
         TvnFJkRDMAcKkNnUKvE28bgrr0Enz2U5DidxCDhmbHZ/xLJNxKcjfUsFItzGmJdSQ6gt
         aX5coPyZwi+FyZIp5Jspm4++bTsDVHOyEfiErQptlWxwvnRqmtvFrfOmG65EgnFguSJP
         lGWc5KhzqdGzMZnoMKvIKxiH2eoPzW3ZXgDRDhJlFuXGy9NQMoEjcPlGafbO+HsY+geS
         nNSH+ceRuS10659WM3osiN2oZuRth8WqUH3eOumEdZg7SQw7Pd6pNLJegfbzllMmiZMZ
         Q2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQFf6taefzciWoDofkCtPEp2enzeEeaQ6FbWpo2Wb7s=;
        b=C9jPon5BnvGU9/zOvxETD6TDNApRmHxQCNp6Bhd5/+8fNuw1hK8wxczw/mVo3QaTGT
         T5hmNT7qXhXJGi+DFCknw28PYzKJ97ePrFmZTfliC4oIzQ+w9NSHND5lVDQcXLXHTUNG
         xyiFCJWpowSCyvOkfLgn1jbhdgWffs9gFlCQyj9yHBDj9u7q4UDjIJCkpveWjpRU8ZXv
         0rDU+TQDvCkVci95QvEQ3UzuNh894uCPkLwT5myuyXv4HZ+9FjYJrHNT/iB9AljhtT+f
         v1sCPfuWT6R0uyvIV1I5K9M2PkE04GBD+VOh0w8bjWTb8wBhKrF75giF09X8arBEcYSy
         uA8A==
X-Gm-Message-State: APzg51DD1WXP75+pCk0mBZPhjws4MucvTxFAECFGl6sN0muqbwVcHcLm
        XQAN+nxl8cXyv8DGsSC21f7RE2Jv8NKZAiHf21bggVDe6QM=
X-Google-Smtp-Source: ANB0VdbfK4jhlKNgiBStDr/mOkpVbR3ZPIILAx0yD24hf0EiBRcwmUhEdnvJdSuGmSznlu7uGO7BBBohH2wEQGoCyEw=
X-Received: by 2002:a62:d1b:: with SMTP id v27-v6mr34964668pfi.87.1536080302642;
 Tue, 04 Sep 2018 09:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com> <20180903203316.16183-11-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-11-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 4 Sep 2018 09:58:11 -0700
Message-ID: <CAKwvOdk_yMOCGbEWcZH4aPP6ShS4DtSg0Qo6AnU-2+4WKu+Mqw@mail.gmail.com>
Subject: Re: [PATCH 10/12] Compiler Attributes: KENTRY used twice the "used" attribute
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        luc.vanoostenryck@gmail.com, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        joe@perches.com, asmadeus@codewreck.org,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 1:34 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 4030a2940d6b..17ee9165ca51 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>         extern typeof(sym) sym;                                 \
>         static const unsigned long __kentry_##sym               \
>         __used                                                  \
> -       __attribute__((__section__("___kentry" "+" #sym ), used))       \
> +       __attribute__((__section__("___kentry" "+" #sym )))     \
>         = (unsigned long)&sym;
>  #endif
>
> --
> 2.17.1
>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
