Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032073AbeBNXSB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:18:01 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:40456 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031971AbeBNXR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:17:59 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.22.39) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20180209235012.4993-1-rabel@robertabel.eu>
 <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
 <20180210092003.GA20377@1wt.eu>
 <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
 <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <db968c03-f471-0ab5-2dba-74a567d2f6d1@robertabel.eu>
Date: Thu, 15 Feb 2018 00:17:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20180214231758.5400.16872@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Feb 2018 14:36, Andy Shevchenko wrote:
> I understand that we have a huge and hopefully nice library in the
> kernel, but the question still the same, what prevents a developer or
> maintainer to look at it from time to time?
> 
> For, I dare to say, ages we have hex_to_bin() and hex2bin().
> Can we use it?

hex_to_bin look fine to me, although personally I'm not a big fan of its
use of tolower.

The current parser implementation is much more lenient than hex2bin,
however. hex2bin won't parse strings containing illegal characters
(which are currently skipped) or hexadecimal strings with an odd number
of digits (which are currently allowed and the final digit will be ignored).

I noticed the only part of the code that does make use of library
functions, parsing x and y coordinates using kstrtoul, is broken.
Apparently it used to use simple_strtoul, which worked and then got
replaced. So apparently looking over the kernel lib from time to time
can also do some harm ;)
Patch incoming :)

Regards,

Robert
