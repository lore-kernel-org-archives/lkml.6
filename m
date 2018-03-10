Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeCJUKk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 15:10:40 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33228 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeCJUKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 15:10:38 -0500
X-Google-Smtp-Source: AG47ELsem3M9SexRUNGy0lesZinSFtZJZtvYtHDJpKgajfNzp9iKGZbFsPv2kfTEZPnfpBxI+4XemA==
Date: Sat, 10 Mar 2018 21:10:33 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
Message-ID: <20180310201033.GA1173@kmp-mobile.hq.kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl>
 <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au>
 <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
 <20180305231650.GA25693@fury>
 <CAHp75VeB6PjacT4V_gsVOYCvJJK2fT3Oi6HONHdqJyCn+CeWNw@mail.gmail.com>
 <20180306205920.GA786@kmp-mobile.hq.kempniu.pl>
 <CAHp75VeOO8tBYWuVbm+2pFB0QeCsW7EoGhzPUY_7q+4bYKb4PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeOO8tBYWuVbm+2pFB0QeCsW7EoGhzPUY_7q+4bYKb4PQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > #define OP_GET_CAPS     0x0
> > #define OP_GET_EVENTS   0x1
> > #define OP_SET          0x1
> > #define OP_GET          0x2
> > #define OP_GET_EXT      0x4
> > #define OP_SET_EXT      0x5
> 
> This one looks pretty much okay (logical pairs IIUC).

Sadly, no, these are not logical pairs.  But maybe this is a reasonable
compromise anyway:

  - OP_GET_CAPS seems to be consistent between different functions; it
    is an operation which returns a bitfield describing given model's
    "capabilities" in a certain area (LEDs, buttons, etc.),

  - some functions expose only OP_GET_CAPS, OP_SET, and OP_GET,

  - some functions expose only OP_GET_CAPS and OP_GET_EVENTS,

  - some function expose OP_GET_CAPS, OP_GET_EVENTS, OP_GET_EXT and
    OP_SET_EXT (but not OP_SET or OP_GET, probably because 0x1 is
    already "taken" by OP_GET_EVENTS).

So, given the above, does this layout look reasonable to you (at least
somewhat) or would you rather see these constants shuffled around in
some other way?

-- 
Best regards,
Michał Kępień
