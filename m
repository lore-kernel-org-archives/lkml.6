Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeB0PVr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:21:47 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33839 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbeB0PVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:21:46 -0500
X-Google-Smtp-Source: AG47ELtecHeTKovno3HQpl+ZIWjwelBtCkCqY3A6tBMJ52Z7QJHiya6UPq5hvQULOLKyFcabHFdENwEO72cxbaMqIfA=
MIME-Version: 1.0
In-Reply-To: <1519731651.10722.224.camel@linux.intel.com>
References: <20180226175532.70556-1-andriy.shevchenko@linux.intel.com>
 <CANiq72nsPasAxZBkHW0fNcTMj3Vp_QdT3VABs9-mHKe4RHS9KA@mail.gmail.com> <1519731651.10722.224.camel@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2018 16:21:25 +0100
Message-ID: <CANiq72nC7C4Hhc0Q2aP_oRqWGuY6pujvB5oYW7RvRjyG+V8+9w@mail.gmail.com>
Subject: Re: [PATCH v1] kernel.h: Update comment about simple_strto<foo>() functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 12:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2018-02-26 at 23:31 +0100, Miguel Ojeda wrote:
>> On Mon, Feb 26, 2018 at 6:55 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > There were discussions in the past about use cases for
>> > simple_strto<foo>() functions and in some rare cases they have a
>> > benefit
>> > on kstrto<foo>() ones.
>> >
>> > Update a comment to reduce confusing about special use cases.
>> >
>> > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>
>> I am not sure we should just go back to the old ones, though.
>
> I didn't tell that we should.
> The niche of kstrto*() and simple_strto*() is different.

I meant that I am not sure that we should just re-allow the old ones
(i.e. I didn't mean that you meant to remove the kstrto*() ones :-).

>
>>  Maybe it
>> is better to create a new set of kstrto*_inplace() or some other name,
>> safer than the old ones and following kstrto*()'s interface regarding
>> returned errors, overflow checking, etc. There are two variations that
>> can be useful:
>>
>>   * A strict version taking a (start, end) range or (start, size) pair
>> which contains the number to be converted. If there is any problem
>> parsing it (e.g. invalid characters, extra characters, ...), fail.
>>
>>   * A less strict version taking an extra end pointer (or size
>> parameter) which is not allowed to be surpassed, and any non-digit
>> character means successful stop.
>
> Send a patch, we will discuss that for sure.
>
>> The old behavior (simple_*()) can still be achieved (almost) with the
>> second version with an "infinite" end pointer if one really needs it.
>
>> In any case, if you want to go forward with the old ones, we would
>> also have to change the comments inside lib/vsprintf.c and possibly
>> checkpatch :-)
>
> Feel free to amend.
>
> I actually didn't get your position here. You rather going to keep ugly
> code in your subsystem because of "official" comment than do it in more
> cleaner, but old fashion way.

I am not going to keep ugly code (why would you say so? It is not even
accepted yet); but I am not adding calls to deprecated functions
either. If those functions shouldn't be deprecated, fine; but *that*
is what should be discussed/changed. Adding new calls to functions
that were deprecated years ago (and currently are in HEAD) does not
help anybody.

>
> Btw, you can still weakly (based on power of base) detect an overflow by
> checking a returned pointer from simple_strto*().

Sure, but fixing that interface is precisely one of the reasons
simple_strto*() were deprecated to begin with.

Cheers,
Miguel

>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
