Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCVWUs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:20:48 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:32880 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCVWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:20:47 -0400
X-Google-Smtp-Source: AG47ELvUBu51HOzJbQETZr8TCXJQ9MpI3rr0g0OxP5weYNlGFjbnDV7qt0qoYCUtfZFGVeMjUvTCaNcs0m9Dckr9raQ=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
 <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com> <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 15:20:45 -0700
X-Google-Sender-Auth: 9VvpeaWzFbzOSgre1Xx0RDUJJwg
Message-ID: <CA+55aFyrLE5c0UZQxebfuPzKj4XYkAychwwiZgo0JTN0cZ1ZmQ@mail.gmail.com>
Subject: Re: syzbot dashboard
To: Dmitry Vyukov <dvyukov@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 2:45 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Do you mean to replace all attachments in syzbot emails with links to
> web dashboard content?

Yes. I think the email should contain just the "report" and then a
link to the full information.

That would seem to be a good enough summary to be legible, and
sufficient for a developer to decide "am I intested, and does it look
like I'm the right target".

Of course, any web pointer in an email does mean that a lot of spam
logic will immediately sit up and take notice, and I don't know how
you'll avoid that.

And then if/when a developer says "that looks interesting", following
the one link gets him/her all the actual information.

Honestly, if somebody isn't willing to click on a link, that person
clearly is too lazy to bother with the bug in the first place.

But at the same time, the email does need to have enough information
that you can sanely make that "is it worth it to go click on a link"
or not.

In fact, it should be sufficient information that for an obvious bug,
you don't even really have to click on the link at all.

I do think that that "report" dump is a fairly good approximation of
just that: enough information that a clear bug doesn't even need any
more, but also not so much information that the email report itself
becomes illegible or annoying.

But auto-generated emails are still likely to be an annoyance for
people who get a lot of email (and we all do), so I'd want to make
sure that

 (a) there's some reasonable ratelimiting. No more than once a week
for the same report, for example, and some way for a developer to say
"I'm not the right person for this report".

 (b) only send those emails if there really is enough information: a
good report with a real WARNING or BUG with the whole file and line
number information, _and_ it has been reproduced by the automation
(which hopefully means that there is also a good C reproducer).

but given that, I think it sounds like a good balance between "not too
annoying" and "honestly useful".

Will there be cases when automation does the wrong thing and is
annoying? Yes. Unquestionably. Nothing is perfect. But make the "good
report" succinct and useful enough, and make the false positives rare
enough, and I think people will appreciate it.

And maybe practice then shows some other case that really annoys
people, but that's more an issue of "this may need some tuning" than
anything else.

                Linus
