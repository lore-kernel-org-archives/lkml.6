Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755223AbeD3RBS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:01:18 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:46635 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755166AbeD3RBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:01:16 -0400
X-Google-Smtp-Source: AB8JxZpF8eTxUdPR5D0RC0kXZzK3cPzhgAxPJPhiaM+R/D0L+ftU+dhq3WV5sCPTClemfX2me39exQWCGmDusddH4zE=
MIME-Version: 1.0
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
In-Reply-To: <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2018 17:01:04 +0000
Message-ID: <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 9:57 AM Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> Although in *practice* we'd have tons of entropy on any modern development
> CPU too, since any new hardware will have the hardware random number
> generation. Some overly cautious person might not trust it, of course.

In fact, maybe that's the right policy. Avoid a boot-time parameter by just
saying

  "if you have hardware random number generation, we can fill entropy
immediately"

No kernel command line needed in practice any more. That's assuming any
kernel developer will have an IvyBridge or newer.

The "I don't trust my hardware" people can still disable that with
"nordrand".

Hmm?

                    Linus
