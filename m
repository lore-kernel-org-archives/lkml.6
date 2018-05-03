Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeECWsQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:48:16 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:41362 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeECWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:48:15 -0400
X-Google-Smtp-Source: AB8JxZqY8JMuV35SRfqgyeF/Zn5NOGDh7+QLEJXF4qj1uIOsXBJ694Tmi+wccbkRjW8sBn1WWKzFeHFCmZBIP3p6CVk=
MIME-Version: 1.0
In-Reply-To: <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com> <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Fri, 4 May 2018 00:48:14 +0200
Message-ID: <CAFkk2KTPiNCWNLncz2KZB66W68YS2H348=bQsgsdqKT1fLRjMw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 10:28 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> Hi,
>
> (with new kconfiglib.py and menuconfig.py)
>
> Thanks for the fixes.
>
> If I use "LC_CTYPE=C.UTF-8" then I get the down arrows in the bottom colored
> bar.  Without that, I get an upside-down T (that is 193, 0xc1, line drawing
> character in the IBM extended character set).
>
> Hm. With LC_CTYPE=C.UTF-8, the upper colored bar prints up arrows.
> Without that, it prints ^^^^^^^^^^^^^^.
> That's nice that it can do either.

The arrows use ACS_U/DARROW from the alternate character set. You get
nice Unicode arrows for those with ncurses/PDCurses, plus "fallbacks"
(strictly speaking the Unicode arrows are fallbacks too).

Unicode text entry is still broken with LC_CTYPE=C, because ncurses
respects it. Having the menuconfig just force C.UTF-8 if it's
available might fix a bunch of problems in practice, even if it feels
a bit iffy to force settings.

Python 3.7 will improve things at least. It converts LC_CTYPE=C into
LC_CTYPE=<some available UTF-8 locale>.

Cleanest would be if all environments sanely defaulted to UTF-8, but
that's not how it is in practice, unfortunately. :)

>
> Being a vim user, I do like the optional navigation keys.
>
> --
> ~Randy

Cheers,
Ulf
