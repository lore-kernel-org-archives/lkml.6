Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F561C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB4D20898
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLr0Y2YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB4D20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeH0QUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:20:01 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40706 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeH0QUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:20:01 -0400
Received: by mail-qk0-f196.google.com with SMTP id c126-v6so10285581qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mm9v3rGqpv+WqJ4eKDTChqcvr4Supg83/5ClkypsLlQ=;
        b=DLr0Y2YKU5jtosHKsc+Dd+VFsToxHPojz8qeTsxE0BgQ7XVCzJ297jfhG2rAm3+6GY
         EvKa55IIaWXMmwJFgtc/uCFJkUI847KNeWuLRPD3WTacnPRq3YGeTpN/yAz5pMqOqYLu
         oc8MBVZvLAHoC6UL06+Wu/JAGzR0NEhdDjJmsu/Mx7FXkAZYbW8LR81NoBrzyTNiebzA
         vcdWhTaOn8H4NQMzy93JEfr7h1W/7HCjvBAccTXZyPbCmg1d/fG4K/E86V6dx/wVX3vQ
         /zVuHD8nEoT48vmbSz0kpn8vuuXIja4GKZenyJ40c++OnLnErWNp8H1mt4azHRjT5+l8
         83pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mm9v3rGqpv+WqJ4eKDTChqcvr4Supg83/5ClkypsLlQ=;
        b=eSbxyGDaNn5dYUTClkBjZUImeOMAWHLeaEcpR0FO6jMmV5mPR7F1QpRnKagJYtgE/b
         Lm6SUYDvwLHFzn3oYwCMFfpqXSkVnjRbE6zCkFQ/+44WX87C5nfa1MLxKLTmODH1msA/
         evduxIcMUeNnB3XNfKxqriEltYyjRo2h/VNOm7kZfXrmXdwAfqGMlZlfGfOdIUO1QsUS
         bsa1wJGTzFrwuxQZJ9MF6RanaQOQVN6SrEtGxb01oAn1SbuMRF7J688VIl0FS5wxf0pR
         TmtFoD0cExX+7a5DkrelFdTmfRmlLYlF19SM3ngdODSmsk2+dSOSt9Rjv7eT15x8mmNZ
         OP1g==
X-Gm-Message-State: APzg51Ab4CxqdzuvUFmLzFtUcK2vnw3KGssPPoFTO2buyJAZzIgxhpK4
        v02KBDJ5U0OnMPNWAsiX0idtRmSX8cgrOmzYctOCmOhuzyc=
X-Google-Smtp-Source: ANB0VdaKocLZzcBMLnYvqGezhlV5ReF6r7ar4bP9sIdUAf8nhKe6AudLyATWnLH/Vwye02T2W7hFFbF2jafl4NQ1Rao=
X-Received: by 2002:a37:6888:: with SMTP id d130-v6mr13058562qkc.192.1535373212635;
 Mon, 27 Aug 2018 05:33:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 05:33:12
 -0700 (PDT)
In-Reply-To: <6c81222980f0f81732726b405df6dbf2b8f98844.camel@perches.com>
References: <20180826175748.GA29525@gmail.com> <6c81222980f0f81732726b405df6dbf2b8f98844.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 27 Aug 2018 14:33:12 +0200
Message-ID: <CANiq72n=WrLWD1-hq2z1gNPJViRoLvveq9xfw6Ndnj0S4Mp3eg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: Use feature checking instead
 of version checks for attributes
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sun, Aug 26, 2018 at 8:50 PM, Joe Perches <joe@perches.com> wrote:
> On Sun, 2018-08-26 at 19:57 +0200, Miguel Ojeda wrote:
>> Instead of using version checks per-compiler to define (or not) each attribute,
>> use __has_attribute to test for them, following the cleanup started with
>> commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>
> Very nice.  Thank you Miguel.

Thanks!

>
> trivia:
>
> I believe the alphabetic sorting of the required attributes
> makes reading by use a bit difficult and I would prefer that
> various required attributes are sorted by logical use instead.
>
> ie:  keep noinline and __always_inline together,
>      keep __used and __always_unused together,
>      etc...
>
>

Both ways are fine with me --- I sorted them as an attempt to avoid
the file evolving into a mess again in the upcoming years :-)

Half-joking: it may also be a good way to avoid people "guessing" what
the attributes do by name and, instead, consulting the docs (either
the compiler's, or a Doc/ file maybe).

Cheers,
Miguel
