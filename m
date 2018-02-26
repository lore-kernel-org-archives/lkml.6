Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeBZXG5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:06:57 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45021 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeBZXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:06:56 -0500
X-Google-Smtp-Source: AG47ELvvSDaWv7f9OI63ONb6VRUHcZVLKToCkgVcK6+ONr5vaiszuCjXtdShOiFxxnPbtlm3SICrP1SvHq5y8rnU2sw=
MIME-Version: 1.0
In-Reply-To: <48023798-595d-2a09-6f0c-2834ebefdd68@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
 <CAHp75Vcrx2rLDsJduWx75Wa57yTRqtQ1dqZMkCGv64K0bOYLiQ@mail.gmail.com> <48023798-595d-2a09-6f0c-2834ebefdd68@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2018 00:06:34 +0100
Message-ID: <CANiq72kAgGRqnteiPd4JQZ7WXthq_5hbZmojVHFKx49K6H8vXQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Robert Abel <rabel@robertabel.eu>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:38 PM, Robert Abel <rabel@robertabel.eu> wrote:
> Hi Andy, Hi Miguel,
>
> On 26 Feb 2018 12:44, Andy Shevchenko wrote:
>> Can we avoid yoda style of programming?
> On 26 Feb 2018 17:49, Miguel Ojeda wrote:
>> Please do not change the style of the code w.r.t to the rest of the
>> file, which writes tests with the non-lvalue on the right-hand side
>> and do not compare against '\0'. Same for the rest.
>
> I am actually a fan of yoda-style programming, although its value is
> diminished with modern IDEs, which we all use, right?

The issue here is the consistency with the rest of the file (and with
the vast majority of the kernel as well), not with the style in
itself. If every single developer would write patches in their own
style, everything would be a mess, so I can't accept a patch like
that, sorry.

In any case, most compilers warn in case of assignment (Wparentheses,
which is on by default for the kernel), no need for a fancy IDE for
this particular thing. :-)

>
> On 26 Feb 2018 17:54, Miguel Ojeda wrote:
>> On Mon, Feb 26, 2018 at 12:44 PM, Andy Shevchenko
>>> Perhaps instead of dancing around kstrtox() better to switch to
>>> simple_strtoul() ?
>>
>> It seems deprecated:
>>
>> /* Obsolete, do not use.  Use kstrto<foo> instead */
>> extern unsigned long simple_strtoul(const char *,char **,unsigned int);
>
> I thought the whole point was that simple_strtoul is deprecated and on
> the kill list? Isn't that kind of against the whole argument of
> re-inventing the wheel?

It is not about reinventing the wheel or not. Any internal kernel
interface can change at any point -- which happens usually whenever
someone comes up with a better way of doing things and others agree,
specially if the benefits outweigh the risks/costs.

> If using simple_strtoul is an option, it might be best to bring it back
> and not touch the buffer at all.

It isn't an option for me as a maintainer (unless there is really,
really no better way of doing it), as long as we don't first agree
(i.e. the kernel) what is obsoleted or not.

Cheers,
Miguel

>
> Regards,
>
> Robert
