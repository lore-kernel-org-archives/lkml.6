Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FD0246F6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FD0246F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933737AbeGDHrG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:47:06 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45179 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeGDHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:47:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id z4-v6so2882787uao.12;
        Wed, 04 Jul 2018 00:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVTr7Th+QTiRgkGsHqTxeEgO+9PIje9iaqmScSuq8RY=;
        b=ru/DR4Fv7IGILhaOx9HvkvMyVg/ItiY9ZHjcoQY/B9lScLZj2XlY3SVBtAJTB+/2aW
         iTsxPk5RSKmkxGTFuh708RzW/VDfN6SvOO7Nx0uYpwGVPXxGkGNV7wspAfUGTRq7wX8e
         gTaxjEXFmmGK1FouC6Klf+kU7sgkZxHuVdIyf5JhsKFTeM/a3KgaBl3xV//cP8S64Nnh
         DsEMTrTTYp579p3NgkmlzLbC0QfE0nTcPPSxMV8MVJwvZWd9o+oBAHQ2zJvc85QvstLq
         WZPeXvpuzKTdEudNqUNHIS3RWeOfPF4rQt85IoBUspnWES3rl7XHrXIeeiz11BY/YBtj
         tNqw==
X-Gm-Message-State: APt69E3vvDYLuj92NlVf1FKCgJZrLaDoaIQ6I983GRE+lEdzo9eMUzeA
        Pq8DqVAgJ3deXuggrRU6ZDy8UfoiJlG07hqCplc=
X-Google-Smtp-Source: AAOMgpfcamyYhlk7yrz6TdC94s/NIzHYert6LYcApGCN7jvq+uVOsFNSiv/DGFoBNYkrQfOh8yXgPKK8SwwMGCFM1YA=
X-Received: by 2002:ab0:25d6:: with SMTP id y22-v6mr552447uan.33.1530690424488;
 Wed, 04 Jul 2018 00:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180703155328.GA18299@arbeit> <CAHp75VcQmUPCqzteHs=EaA5h-ABAQ=GWuLVRGWL3meMKZBJ-iQ@mail.gmail.com>
 <20180704024112.GB9015@1wt.eu>
In-Reply-To: <20180704024112.GB9015@1wt.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Jul 2018 09:46:53 +0200
Message-ID: <CAMuHMdUKpF=x-Se=9sKqiaWCr3YqPH1XOxK-sR=gvQ8uZBOnbg@mail.gmail.com>
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ben Whitten <ben.whitten@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Wed, Jul 4, 2018 at 4:41 AM Willy Tarreau <w@1wt.eu> wrote:
> On Tue, Jul 03, 2018 at 09:43:06PM +0300, Andy Shevchenko wrote:
> > > +       {'a', ".-"},
> > > +       {'b', "-..."},

> >
> > Do you expect this to be changed somehow?
> > Otherwise we might just to keep two char arrays of alphas and digits
> > in an order of ascii appearance.
> >
> > In the code something like
> >
> > ch = tolower(x);
> > if (isalpha(ch))
> >  code = alphas[ch - 'a'];
> > else if (isdigit(ch))
> >  code = digits[ch - '0'];
> > else
> >  code = unknown;
> >
> > > +       {0, NULL},
> >
> > And this will gone, you just provide it with known size,
>
> Well, in this case it's even possible to go further and avoid storing
> 36 strings. Indeed, no representation is longer than 5 symbols, so you
> can use 5 bits for the encoding (0=".", 1="-") and 3 bits for the
> length, it gives you a single byte per character instead of a pointer
> to a string plus 6 chars. Then in order to make it readable, 5 macros

Hehe, https://lkml.org/lkml/2018/6/28/544 ;-)

> can be provided to emit the code :
>
> #define MORSE1(a,b)       (1 | ((a)<<3))
> #define MORSE2(a,b)       (2 | ((a)<<3)|((b)<<4))
> #define MORSE3(a,b,c)     (3 | ((a)<<3)|((b)<<4)|((c)<<5))
> #define MORSE4(a,b,c,d)   (4 | ((a)<<3)|((b)<<4)|((c)<<5)|((d)<<6))
> #define MORSE5(a,b,c,d,e) (5 | ((a)<<3)|((b)<<4)|((c)<<5)|((d)<<6)|((e)<<7))
>
> Then all chars may be defined like this :
>
>     ['a'] = MORSE2(0,1),
>     ['b'] = MORSE4(1,0,0,0),
>     ['c'] = MORSE4(1,0,1,0),
>     ['d'] = MORSE3(1,0,0),
>     ['e'] = MORSE1(0),

Nice!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
