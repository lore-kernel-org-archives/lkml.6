Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeCVJqJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:46:09 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:42012 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeCVJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:46:05 -0400
X-Google-Smtp-Source: AG47ELvBJg3ET9HBQDc/aryKloDaMUVE+g0GMzsagHjefKcKx6XgLIcejEZcDFSx2kCq8Pweprfn2afy31v8d+lk/QU=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
 <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 22 Mar 2018 10:45:43 +0100
Message-ID: <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
Subject: Re: syzbot dashboard
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 9:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 21, 2018 at 9:11 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> syzkaller/syzbot dashboard is now live at:
>> https://syzkaller.appspot.com
>
> Ok, this may well be the thing that makes syzbot reports useful, if
> they point to an external report instead of sending an absolutely huge
> illegible email that nobody can read.

The dashboard was initially meant to be used only for internal
monitoring (communication with kernel developers over emails) and I am
too close to the project to see obvious stuff. So thanks for the
feedback!

Do you mean to replace all attachments in syzbot emails with links to
web dashboard content?
I've heard opinions both ways (including "I am not clicking on any
external links, include all content in the email"). So we need to
decide. Provided that lots of email clients seem to inline
attachments, rather than show them as separate files, I am leaning
towards providing just links. Then emails can be short and tidy. Also
will solve the problem of "I don't see original attachments in your
forwarded email".


> That said, I do think it needs some better summarizing still.
>
> For example, landing on that front page and then going "Hmm, let's
> look at that first report", I click on that
>
>     [upstream] BUG: corrupted list in remove_wait_queue
>
> thing, and get to
>
>     https://syzkaller.appspot.com/bug?id=c11299b410c0feaf0d861c64bcb3a67a639d17a6
>
> fine. That page itself doesn't actually tell me really anything at all, though.
>
> So I go to the first thing I see, click "log" and I get 6500 lines of
> basically line noise.
>
> Ok, so the real thing is under "report", which actually looks pretty legible.
>
> Looking at a few other of those things, I get the same feeling. Can
> you put one copy of the "report" in the main page for a bug? I assume
> they are all slightly different, but there must be some commonality to
> them that you group the syzcaller bugs by, and giving one of those
> legible reports (with all the nice filename and line information and
> basic register state) would likely be a good thing.

This is now done and deployed, the page show a sample crash at the top:
https://syzkaller.appspot.com/bug?id=c11299b410c0feaf0d861c64bcb3a67a639d17a6


> At that point, *if* a report has a reproducer, then sending reminders
> to people with "this still happens, here's a link to the syzkaller
> page for this report" might be much better received than the old huge
> and very-hard-to-read emails.


Now with your blessing we will do reminders :)
Not sure what should be periodicity, though. Obviously less frequent
than once per day. But probably more frequent than once per release.

For the bugs *without* reproducers, now we know precisely that lots of
them are fixable. For bugs *with* reproducers fix rate is 76%, but for
bugs *without* reproducers it's only down to 66% and more than 100
bugs were fixed without reproducers. So it can make sense to do
reminders for them later too.


> The reminder might well want to have that legible and short "report"
> in it too, so that people can just look at that to tell "is this
> relevant for me" particularly if they perhaps already fixed it?
>
> (I only looked at a handful of reports, but the ones I looked at all
> seemed reasonable - maybe some are less so?)

There is some, small fraction of unreasonable crashes. Part of them is
due to induced crashes after silent memory corruptions. But one can
reply with "#syz invalid" to a syzbot email, and such reports will go
off the dashboard.
