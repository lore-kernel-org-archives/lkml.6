Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E23920857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPokKagq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E23920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeIJAG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:06:59 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38032 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeIJAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:06:59 -0400
Received: by mail-qt0-f172.google.com with SMTP id x7-v6so21836658qtk.5;
        Sun, 09 Sep 2018 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8IM5HXX9iALCld5TYo2W5XXVQyoI596FJPC67mSYCDs=;
        b=XPokKagqRcIPDXMEn2hQvuTIA8B47TStgaInL/obr3VXQql7Klisk6fBYOx95f83RS
         HnNxddMMnbDykaNgm2jav+7QX5FKYW0d3DZ34msPiO6q+fB4wZXpy02/hrN6Wd/bPdpf
         hQXFSbbqMwyR7IoNu7+C9NHQ7+N9JmFoLKUv8c30uhTfYxz4FoSjLcL0XxG5YEDNNgqQ
         WYMUZ8xqhwLXn48a7yvCuyN9Msjn5sUd4V/eomzFdbbs6uhbLpj5xGfkINGY1MUy8Mu8
         ShMSu3kW1pnT6qUJ2D3kRF5pAVIPGRQPGQXGXpnN+EPo2KQKYBngi2t0Typd3Cm73yUk
         k9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8IM5HXX9iALCld5TYo2W5XXVQyoI596FJPC67mSYCDs=;
        b=oUweI9vunyrq0g0oeUfHU0X4pL8wtAOQmRjM9HZqu/HaRgXRdV/4iDbSpniiTaGPJ1
         3S0bj4d+h4LTFVyTyfvHVR7WUpA8F2KSaXkcCnPYyb82G3Yws5YneXvKpbZGuRmi4kSb
         oIE8US0jX2ikzqNpddDpSRYwteWkTnXn98HM6RgMtIpUFsRyz3J8O/Tql6SO2YmQpc5w
         XFCWkNY6bV4gacth76MOMUwFaaqkPDtCZcEmCOd5mnE5Ein5FbB7BGIto4OjdGNrcR1W
         rH026o9wqeMoC+Bb96sqocd0hObJLajeNs0LjVWVxpeEl9YLHsbDcJCQhNrau8Nc4sMb
         mtGg==
X-Gm-Message-State: APzg51ACHO26kHZ9Ln5lisl7Jb98XeShr0hIZWcnrr8j2QgIrWVtbzbr
        IW2XvvtA9QPtZ4cyG/SqFGUKz27dqdMNwCi10wY=
X-Google-Smtp-Source: ANB0VdbjXWKQLY6nqpOPMGxKQy7GiCJfYRZhs4vyiYTcOCx3zY7XNaJG7COTer4SS8OiCXv3foiN97HVpgWRX4LU/6A=
X-Received: by 2002:a0c:abca:: with SMTP id k10-v6mr12123994qvb.140.1536520578750;
 Sun, 09 Sep 2018 12:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 12:15:58 -0700 (PDT)
In-Reply-To: <20180909121901.5a36d0fd@lwn.net>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
 <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com> <20180909121901.5a36d0fd@lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 21:15:58 +0200
Message-ID: <CANiq72ngDkFUoROFGPL9A=CQ+X5e6R+pfxuBXWx9DWxoryGnTw@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] Compiler Attributes: add Doc/process/programming-language.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Sep 9, 2018 at 8:19 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Sat,  8 Sep 2018 23:24:58 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
>>  Documentation/process/index.rst               |  1 +
>>  .../process/programming-language.rst          | 45 +++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>  create mode 100644 Documentation/process/programming-language.rst
>>
> So I have some overall thoughts on the documentation; my apologies for
> not getting to this until you got to v4...

No problem at all! :-)

>
> 1) I think the document is mistitled.  It's not really about the language
>    that the kernel used, it's about compiler attributes.  So I would make
>    both the name of the document and it introduction reflect that.

The idea here is to create a document explaining the programming
language that the kernel uses (which we hadn't), taking the chance to
describe the attributes (which in a way are extensions to the C
language); in the future expanding it with other (non-attribute)
extensions that we use. Of course, that is not done, but I thought
starting it was a nice idea (meant for people coming from a C
background that do not know the "dialect" used in Linux).

Also other kind of very commonly used macros and functions used
throughout the kernel could be summarized there as a summary for
newcomers (e.g. stuff like `printk`/`pr_*`, `likely`/`unlikely`,
`panic`, `EXPORT_SYMBOL`, `BUG_ON`/`WARN_ON`...), without writing full
documentation there (but pointing to where they are described, either
in the Docs or a source code if not).

What do you think?

>
> 2) This is an ideal opportunity to document what all of those attributes
>    actually mean.  I would guess that is the information many developers

I thought about that, but the issue is that compilers already describe
them: in the case of GCC, all of them are documented; some are in
clang; icc is not well documented --- see the previous threads about
this), so we would be duplicating that information (and it will become
outdated as compilers are released and improve the documentation).
This is the reason why the series removes most of the copy-pasted
documentation from gcc and instead supplies a link for each attribute
compiler_attributes.h to gcc & clang online docs.

>    will come here looking for, and they'll go away frustrated.  The ideal
>    thing to do, IMO, would be do say what each attribute means (rather
>    than just which compilers support it) in a DOC section in the new
>    compiler_attributes.h header, then use RST directives to pull all that
>    information into this document.

Initially my idea was to provide a table with the name and the links
to each compiler docs; so that it could be easily used. However, when
thinking about it, it seems that most people consulting such file
would come from the actual source code, so they would have to move
from there to the Doc/ file; so I did it the other way around (IIRC
Nick also mentioned his preference for keeping them in the source
code).

Now, the idea of keeping them in the header but pulling them to the
RST can be a good idea but I was unsure how to do it best. I took a
look at how other RST files did it (the pull), but I thought (maybe
wrongly) that I wouldn't be able to create a nice table (i.e. instead
it would be a long list of attributes, which most people will not use
-- and in my idea of a document describing all the extensions, it
would be taking most of the space), so I discarded it. I am not sure
about the future goals for the Docs/, so excuse me if I have the
completely wrong idea, but in a way, in the current state, I see the
kernel docs as articles/chapters/book on high-level concepts about the
kernel, rather than a technical reference (i.e. the source code with a
better formatting).

Thanks a lot for reviewing!

Cheers,
Miguel
