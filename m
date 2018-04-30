Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754899AbeD3QcF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:32:05 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35108 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbeD3QcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:32:04 -0400
X-Google-Smtp-Source: AB8JxZo9LBSV+p09gIeRmMvr8fjuovUyfRODQkCFrYfo2ckynvjQSb8qLAFgkLmJd6iQWMdmXXvXCE+ATxk4C2mo1nE=
MIME-Version: 1.0
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de> <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
In-Reply-To: <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2018 16:31:52 +0000
Message-ID: <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Kees Cook <keescook@chromium.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 9:11 AM Kees Cook <keescook@chromium.org> wrote:

> I (or other folks?) had proposed this before, but, AIUI, Linus remains
> opposed.

Yeah, I hate this, because it will make people paper over their problems by
just booting with that option.

I think it should just be fixed.

Is there really any reason why trace buffers have to be dumped so early
that the entropy hasn't even taken yet?

And if we really want a command line option, can we make that still hash
the pointer, just force the entropy early. That way kernel developers that
test that command line option are still testing the *hashing*, they just
are missing the good entropy.

                 Linus
