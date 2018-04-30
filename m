Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbeD3Qlj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754613AbeD3Qli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:41:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6A522BDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 30 Apr 2018 12:41:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>
Subject: Re: Hashed pointer issues
Message-ID: <20180430124135.0cce92e3@gandalf.local.home>
In-Reply-To: <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
        <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
        <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 16:31:52 +0000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 30, 2018 at 9:11 AM Kees Cook <keescook@chromium.org> wrote:
> 
> > I (or other folks?) had proposed this before, but, AIUI, Linus remains
> > opposed.  
> 
> Yeah, I hate this, because it will make people paper over their problems by
> just booting with that option.
> 
> I think it should just be fixed.
> 
> Is there really any reason why trace buffers have to be dumped so early
> that the entropy hasn't even taken yet?

In this case, an RCU stall was triggering and a "dump on oops" would
dump the trace buffers, (before entropy was established).

> 
> And if we really want a command line option, can we make that still hash
> the pointer, just force the entropy early. That way kernel developers that
> test that command line option are still testing the *hashing*, they just
> are missing the good entropy.
> 

That may work too. Even with bad entropy, pointers at start up are hard
to come by, and I can't see a hacker being able to use them as it only
happens once during boot.

-- Steve
