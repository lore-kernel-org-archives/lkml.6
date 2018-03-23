Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCWUum (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:50:42 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36335 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:50:40 -0400
X-Google-Smtp-Source: AG47ELu7SVRv8CGSOagy705KOKoVogbExrxiyXZU1BUPD8EfE+fjewlB9MqOf2JR5WRb2WzaSvqqJAh4Y/UgD8IMeiI=
MIME-Version: 1.0
In-Reply-To: <20180323201634.GA16350@gmail.com>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
 <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
 <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com> <20180323201634.GA16350@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Mar 2018 13:50:39 -0700
X-Google-Sender-Auth: Ubd8lAYnPDl5yDLVASCKdMWucYA
Message-ID: <CA+55aFwZpMB=VUTCNUgc4dcCEy9_T4iE0R0pAfDets=zDFJunQ@mail.gmail.com>
Subject: Re: syzbot dashboard
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 1:16 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
>
> A compromise could be to remove the raw.log from the emails, and send the config
> in 'defconfig' format rather than the full config

I really don't think the config is very legible, and isn't something
that people will look at to judge whether it's intrresting or not.
It's still "many hundreds of lines of line noise"

And it shouldn't really be part of the consideration whether a bug is
really worth looking at or not anyway, although *after* you've found
the bug as a developer, you may decide "ok, that configuration isn't
valid, so I should just disallow it in Kconfig". But that's still a
bugfix.

So I think the config can stay purely on the web (for when you go "so
how do I *reproduce* this?") along with the actual reproducer and the
full logs.

I'd rather make the emails be small and legible, and contain the
minimum amount of information.

Because I really do *not* need a few hundred emails from some
automated source that each have a roughly thousand-line config
attachements.

An email with 50 lines of THE ACTUAL DECODED OOPS? Sure. That's
critical information. That doesn't make me go "why does this stupid
bot spew garbage at me"?

              Linus
