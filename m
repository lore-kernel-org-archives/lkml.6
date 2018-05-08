Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeEHQ7S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:59:18 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35970 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeEHQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:59:16 -0400
X-Google-Smtp-Source: AB8JxZq0Es7awOZy5TX6IweHeeicbD5jgCRoUpSNWzKz/zc6/ruHC33vebS/u7a6nIixL0U3ipqLDUTB2sxsY1N1jt0=
MIME-Version: 1.0
In-Reply-To: <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com> <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 8 May 2018 18:59:15 +0200
Message-ID: <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've added incremental search for jumping directly to a symbol now.
Regular expressions are supported as well.

Some screenshots below:

https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png

The last screenshot shows how things might look after you jump to a
symbol. The jumped-to symbol wasn't visible in this case, so show-all
mode was turned on automatically.

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

It now automatically tries to convert LC_CTYPE to a UTF-8 locale if it
is set to the C locale, similar to what PEP 538 does. I took the list
of locales to try from the CPython implementation.

That will save a bunch of pain in practice.

Cheers,
Ulf
