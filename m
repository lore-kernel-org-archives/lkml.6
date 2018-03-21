Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeCUUck (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:32:40 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36471 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbeCUUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:32:30 -0400
X-Google-Smtp-Source: AG47ELumR1gpDjOEwi9mybjOjAS1Uw6aCpOXQg7E2JzI+Qugupdn4OxwTaixZZz/QiNu5k24Pks+RIiI1lIuh15WwzQ=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Mar 2018 13:32:29 -0700
X-Google-Sender-Auth: w4kaDeqdEJLsWPz8PZQHEv_0A-I
Message-ID: <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
Subject: Re: syzbot dashboard
To: Dmitry Vyukov <dvyukov@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 9:11 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> syzkaller/syzbot dashboard is now live at:
> https://syzkaller.appspot.com

Ok, this may well be the thing that makes syzbot reports useful, if
they point to an external report instead of sending an absolutely huge
illegible email that nobody can read.

That said, I do think it needs some better summarizing still.

For example, landing on that front page and then going "Hmm, let's
look at that first report", I click on that

    [upstream] BUG: corrupted list in remove_wait_queue

thing, and get to

    https://syzkaller.appspot.com/bug?id=c11299b410c0feaf0d861c64bcb3a67a639d17a6

fine. That page itself doesn't actually tell me really anything at all, though.

So I go to the first thing I see, click "log" and I get 6500 lines of
basically line noise.

Ok, so the real thing is under "report", which actually looks pretty legible.

Looking at a few other of those things, I get the same feeling. Can
you put one copy of the "report" in the main page for a bug? I assume
they are all slightly different, but there must be some commonality to
them that you group the syzcaller bugs by, and giving one of those
legible reports (with all the nice filename and line information and
basic register state) would likely be a good thing.

At that point, *if* a report has a reproducer, then sending reminders
to people with "this still happens, here's a link to the syzkaller
page for this report" might be much better received than the old huge
and very-hard-to-read emails.

The reminder might well want to have that legible and short "report"
in it too, so that people can just look at that to tell "is this
relevant for me" particularly if they perhaps already fixed it?

(I only looked at a handful of reports, but the ones I looked at all
seemed reasonable - maybe some are less so?)

           Linus
