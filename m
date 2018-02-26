Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeBZWjA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:39:00 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:58344 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeBZWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:38:57 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.26.24) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CAHp75Vcrx2rLDsJduWx75Wa57yTRqtQ1dqZMkCGv64K0bOYLiQ@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <48023798-595d-2a09-6f0c-2834ebefdd68@robertabel.eu>
Date: Mon, 26 Feb 2018 23:38:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcrx2rLDsJduWx75Wa57yTRqtQ1dqZMkCGv64K0bOYLiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20180226223856.9684.27533@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, Hi Miguel,

On 26 Feb 2018 12:44, Andy Shevchenko wrote:
> Can we avoid yoda style of programming?
On 26 Feb 2018 17:49, Miguel Ojeda wrote:
> Please do not change the style of the code w.r.t to the rest of the
> file, which writes tests with the non-lvalue on the right-hand side
> and do not compare against '\0'. Same for the rest.

I am actually a fan of yoda-style programming, although its value is
diminished with modern IDEs, which we all use, right?

On 26 Feb 2018 17:54, Miguel Ojeda wrote:
> On Mon, Feb 26, 2018 at 12:44 PM, Andy Shevchenko
>> Perhaps instead of dancing around kstrtox() better to switch to
>> simple_strtoul() ?
>
> It seems deprecated:
>
> /* Obsolete, do not use.  Use kstrto<foo> instead */
> extern unsigned long simple_strtoul(const char *,char **,unsigned int);

I thought the whole point was that simple_strtoul is deprecated and on
the kill list? Isn't that kind of against the whole argument of
re-inventing the wheel?
If using simple_strtoul is an option, it might be best to bring it back
and not touch the buffer at all.

Regards,

Robert
