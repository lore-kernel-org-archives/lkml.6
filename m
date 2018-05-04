Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeEDAFu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:05:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeEDAFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:05:49 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
 <CAFkk2KTPiNCWNLncz2KZB66W68YS2H348=bQsgsdqKT1fLRjMw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e646e4d-4d3d-a81e-83e3-59875b425ea8@infradead.org>
Date: Thu, 3 May 2018 17:05:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTPiNCWNLncz2KZB66W68YS2H348=bQsgsdqKT1fLRjMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 03:48 PM, Ulf Magnusson wrote:
> On Thu, May 3, 2018 at 10:28 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> Hi,
>>
>> (with new kconfiglib.py and menuconfig.py)
>>
>> Thanks for the fixes.
>>
>> If I use "LC_CTYPE=C.UTF-8" then I get the down arrows in the bottom colored
>> bar.  Without that, I get an upside-down T (that is 193, 0xc1, line drawing
>> character in the IBM extended character set).
>>
>> Hm. With LC_CTYPE=C.UTF-8, the upper colored bar prints up arrows.
>> Without that, it prints ^^^^^^^^^^^^^^.
>> That's nice that it can do either.
> 
> The arrows use ACS_U/DARROW from the alternate character set. You get
> nice Unicode arrows for those with ncurses/PDCurses, plus "fallbacks"
> (strictly speaking the Unicode arrows are fallbacks too).

Too bad it doesn't use "vvvvvvvvvvvvvv" for the down-arrow fallbacks.
Instead of that funky IBM PC line drawing stub.

> Unicode text entry is still broken with LC_CTYPE=C, because ncurses
> respects it. Having the menuconfig just force C.UTF-8 if it's
> available might fix a bunch of problems in practice, even if it feels
> a bit iffy to force settings.
> 
> Python 3.7 will improve things at least. It converts LC_CTYPE=C into
> LC_CTYPE=<some available UTF-8 locale>.
> 
> Cleanest would be if all environments sanely defaulted to UTF-8, but
> that's not how it is in practice, unfortunately. :)

thanks,
-- 
~Randy
