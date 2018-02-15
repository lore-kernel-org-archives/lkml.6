Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967643AbeBOK5k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:57:40 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39203 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966589AbeBOK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:57:39 -0500
X-Google-Smtp-Source: AH8x226spq7Ykn7oALZmTth1iSyekUI90Hj3yWXa15b19VP2b3mrjPYoP83OZcIWdIrIRxSyzkVgAMS5hF/FIPImdvM=
MIME-Version: 1.0
In-Reply-To: <db968c03-f471-0ab5-2dba-74a567d2f6d1@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
 <20180210092003.GA20377@1wt.eu> <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
 <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com> <db968c03-f471-0ab5-2dba-74a567d2f6d1@robertabel.eu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2018 12:57:36 +0200
Message-ID: <CAHp75Vd1u0RxzE7WR444p0n+yutErp6OJUrqm1za=JcY0C=+ig@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Robert Abel <rabel@robertabel.eu>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 1:17 AM, Robert Abel <rabel@robertabel.eu> wrote:
> On 13 Feb 2018 14:36, Andy Shevchenko wrote:
>> I understand that we have a huge and hopefully nice library in the
>> kernel, but the question still the same, what prevents a developer or
>> maintainer to look at it from time to time?
>>
>> For, I dare to say, ages we have hex_to_bin() and hex2bin().
>> Can we use it?
>
> hex_to_bin look fine to me, although personally I'm not a big fan of its
> use of tolower.

Let's duplicate then over and over?

> The current parser implementation is much more lenient than hex2bin,
> however. hex2bin won't parse strings containing illegal characters
> (which are currently skipped) or hexadecimal strings with an odd number
> of digits (which are currently allowed and the final digit will be ignored).

Can you point to the documentation where user can easily (w/o reading
the code) get how it suppose to be?

Besides that, I'm a fan of making things cleaner and stricter.
Allowing garbage in the middle of hex digits is making odd and
unflexible interface.

> I noticed the only part of the code that does make use of library
> functions, parsing x and y coordinates using kstrtoul, is broken.
> Apparently it used to use simple_strtoul, which worked and then got
> replaced.

By which commit?

> So apparently looking over the kernel lib from time to time
> can also do some harm ;)

Disagree. The careless (semi-)automated patches and / or negligent
review make this so.
See Markus Elfting phenomena. He dumbly doing routine work w/o paying
attention to the details and breaking things. That's why half of
maintainers already banned him.

> Patch incoming :)

Can you Cc me?

-- 
With Best Regards,
Andy Shevchenko
