Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756184AbeEAQwI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:52:08 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:55636 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbeEAQwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:52:07 -0400
X-Google-Smtp-Source: AB8JxZol3Ia/6F3eSdQr5wsdW0pjJzh9ak7GDcE067Zg8lh8Oh5ltbXNpqD0NPopw8gW8CqWWIxhSoyEG2VzA9+cTlg=
MIME-Version: 1.0
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
 <20180501134020.fonel3x6plea5xdt@treble> <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
 <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com> <8E8FD6A0-DA57-4523-A16F-C68167C2B5ED@vmware.com>
In-Reply-To: <8E8FD6A0-DA57-4523-A16F-C68167C2B5ED@vmware.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 May 2018 16:51:56 +0000
Message-ID: <CA+55aFwowsU8wVN9AY4qWdY+LBf7iW1BNBZfwpfxuOE36iiNbQ@mail.gmail.com>
Subject: Re: Suboptimal inline heuristics due to non-code sections
To: namit@vmware.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41GqFpj017976

On Tue, May 1, 2018 at 9:46 AM Nadav Amit <namit@vmware.com> wrote:

> My bad. It’s not the new-line. Let me do some more digging.

 From the gcc docs:

   Some targets require that GCC track the size of each instruction used
   in order to generate correct code.  Because the final length of the
   code produced by an @code{asm} statement is only known by the
   assembler, GCC must make an estimate as to how big it will be.  It
   does this by counting the number of instructions in the pattern of the
   @code{asm} and multiplying that by the length of the longest
   instruction supported by that processor.  (When working out the number
   of instructions, it assumes that any occurrence of a newline or of
   whatever statement separator character is supported by the assembler --
   typically @samp{;} --- indicates the end of an instruction.)

so it probably counts newlines and semicolons to estimate the size.

                 Linus
