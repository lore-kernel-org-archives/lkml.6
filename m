Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCLJ14 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:27:56 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46137 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:27:54 -0400
X-Google-Smtp-Source: AG47ELuuc1eCca+ZJXmTRQe4P/3KsK2v0GqRoIhZBg3fFoouAd4Hi0/doxk1mQRtTVI4VgJAIe9n/SqtSHv0qaMZS8o=
MIME-Version: 1.0
In-Reply-To: <20180310201033.GA1173@kmp-mobile.hq.kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl> <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au> <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
 <20180305231650.GA25693@fury> <CAHp75VeB6PjacT4V_gsVOYCvJJK2fT3Oi6HONHdqJyCn+CeWNw@mail.gmail.com>
 <20180306205920.GA786@kmp-mobile.hq.kempniu.pl> <CAHp75VeOO8tBYWuVbm+2pFB0QeCsW7EoGhzPUY_7q+4bYKb4PQ@mail.gmail.com>
 <20180310201033.GA1173@kmp-mobile.hq.kempniu.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Mar 2018 11:27:52 +0200
Message-ID: <CAHp75Vf693BSDOw4WFDYpo35BmxaHJ8_7EXhQrAZiS_OkLRDTw@mail.gmail.com>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2C9S248003723

On Sat, Mar 10, 2018 at 10:10 PM, Michał Kępień <kernel@kempniu.pl> wrote:
>> > #define OP_GET_CAPS     0x0
>> > #define OP_GET_EVENTS   0x1
>> > #define OP_SET          0x1
>> > #define OP_GET          0x2
>> > #define OP_GET_EXT      0x4
>> > #define OP_SET_EXT      0x5
>>
>> This one looks pretty much okay (logical pairs IIUC).
>
> Sadly, no, these are not logical pairs.  But maybe this is a reasonable
> compromise anyway:
>
>   - OP_GET_CAPS seems to be consistent between different functions; it
>     is an operation which returns a bitfield describing given model's
>     "capabilities" in a certain area (LEDs, buttons, etc.),
>
>   - some functions expose only OP_GET_CAPS, OP_SET, and OP_GET,
>
>   - some functions expose only OP_GET_CAPS and OP_GET_EVENTS,
>
>   - some function expose OP_GET_CAPS, OP_GET_EVENTS, OP_GET_EXT and
>     OP_SET_EXT (but not OP_SET or OP_GET, probably because 0x1 is
>     already "taken" by OP_GET_EVENTS).

Interesting.
Does it mean there is no logic between functions on the same platform
and what they are expose?

May be those sets might be groupped by what kind of functions expose them?

> So, given the above, does this layout look reasonable to you (at least
> somewhat) or would you rather see these constants shuffled around in
> some other way?

If no other way is feasible right now, the above is okay to me.

-- 
With Best Regards,
Andy Shevchenko
