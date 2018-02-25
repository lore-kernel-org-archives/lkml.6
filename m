Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeBYXeZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:34:25 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:34707 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeBYXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:34:23 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.101.1) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20180209235012.4993-1-rabel@robertabel.eu>
 <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
 <20180210092003.GA20377@1wt.eu>
 <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
 <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com>
 <db968c03-f471-0ab5-2dba-74a567d2f6d1@robertabel.eu>
 <CAHp75Vd1u0RxzE7WR444p0n+yutErp6OJUrqm1za=JcY0C=+ig@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
Date: Mon, 26 Feb 2018 00:34:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd1u0RxzE7WR444p0n+yutErp6OJUrqm1za=JcY0C=+ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20180225233421.30277.38554@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 15 Feb 2018 11:57, Andy Shevchenko wrote:
> On Thu, Feb 15, 2018 at 1:17 AM, Robert Abel <rabel@robertabel.eu> wrote:
>> hex_to_bin look fine to me, although personally I'm not a big fan of its
>> use of tolower.
> 
> Let's duplicate then over and over?

I was speaking more generally about performance here. There is a reason
for kstrtox.c:57
(https://elixir.bootlin.com/linux/v4.14.7/source/lib/kstrtox.c#L57)
> unsigned int lc = c | 0x20; /* don't tolower() this line */

> Can you point to the documentation where user can easily (w/o reading
> the code) get how it suppose to be?

Unfortunately not. I read the code myself to know how it is supposed to
work. That's definitely a gap in documentation.

> On Thu, Feb 15, 2018 at 1:17 AM, Robert Abel <rabel@robertabel.eu> wrote:
>> I noticed the only part of the code that does make use of library
>> functions, parsing x and y coordinates using kstrtoul, is broken.
>> Apparently it used to use simple_strtoul, which worked and then got
>> replaced.
> By which commit?

129957069e6af42a6e021d90679c56662c95f7e1
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=129957069e6af42a6e021d90679c56662c95f7e1)

I'll try to answer to this email with relevant patches for charlcd.c.

Regards,

Robert
