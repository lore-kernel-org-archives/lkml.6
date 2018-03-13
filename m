Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeCMSLa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:11:30 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43732 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCMSL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:11:27 -0400
X-Google-Smtp-Source: AG47ELtJKbffJ4YuYDayl99gS6lN4ctKAgoS4ZOUbJKd46FGT9a6dUmzrmq/aJaGIZu2vuAOvtrrlq4c75kmQgbVHFs=
MIME-Version: 1.0
In-Reply-To: <20180313063630.zxebyb7gczeiovyf@gmail.com>
References: <20180301163331.987775783@linutronix.de> <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com>
 <20180313063630.zxebyb7gczeiovyf@gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 13 Mar 2018 11:11:25 -0700
Message-ID: <CALAqxLXJw-QOztJvt1sBSyxDg4NFz5KXmPv3PjF4VEChz20BGA@mail.gmail.com>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:36 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Thu, Mar 1, 2018 at 8:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > This really needs lot of testing, documentation updates and more input from
>> > userspace folks to make a final decision.
>>
>> Honestly, I don't think we'd get the testing this kind of change needs
>> except by just trying it.
>>
>> I'm willing to merge this in the 4.17 merge window, with the
>> understanding that if people end up reporting issues, we may just have
>> to revert it all, and chalk it up to a learning experience - and add
>> the appropriate commentary in the kernel code about exactly what it
>> was that depended on that MONO/BOOT difference.
>>
>> One non-technical thing I would ask: use some other word than
>> "conflate". Maybe just "combine". Or better yet, "unify".
>
> Ok, I have edited all the changelogs accordingly (and also flipped around the
> 'clock MONOTONIC' language to the more readable 'the MONOTONIC clock' variant),
> the resulting titles are (in order):
>
>  72199320d49d: timekeeping: Add the new CLOCK_MONOTONIC_ACTIVE clock
>  d6ed449afdb3: timekeeping: Make the MONOTONIC clock behave like the BOOTTIME clock
>  f2d6fdbfd238: Input: Evdev - unify MONOTONIC and BOOTTIME clock behavior
>  d6c7270e913d: timekeeping: Remove boot time specific code
>  7250a4047aa6: posix-timers: Unify MONOTONIC and BOOTTIME clock behavior
>  127bfa5f4342: hrtimer: Unify MONOTONIC and BOOTTIME clock behavior
>  92af4dcb4e1c: tracing: Unify the "boot" and "mono" tracing clocks
>
> I'll push these out after testing.

I'm still anxious about userspace effects given how much I've seen the
current behavior documented, and wouldn't pushed for this myself (I'm
a worrier), but at least I'm not seeing any failures in initial
testing w/ kselftest so far.

thanks
-john
