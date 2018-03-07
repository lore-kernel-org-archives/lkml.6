Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeCGCVe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:21:34 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39381 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeCGCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:21:33 -0500
X-Google-Smtp-Source: AG47ELs5XiwVDnvBb5HaOuikqvAETY+k+L1cZxguf2FKhR5IrRvhTk2xs81CUJmd3lNlkQLhjHrerQ==
Date: Wed, 7 Mar 2018 11:21:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180307022127.GB802@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On (03/06/18 14:27), Arnd Bergmann wrote:
[..]
> As we are now removing blackfin, based on the latest discussion, this
> part should no longer be necessary.

When is this going to happen? 4.17?

[..]
> nds32 currently only exists in linux-next, not in the mainline kernel.
> If it's the only architecture that does something different from everyone
> else, I think we should change nds32.
> 
> I looked at the nds32 show_stack() implementation now and it
> seems to me that it is completely unnecessary, as the implementation
> from lib/dump_stack.c does basically the same thing (by calling
> show_stack(NULL, NULL)).

Interesting point. I'll leave it to nds32 maintainers.
OTOH blackfin is still in linux-next, so I assume we need
that __weak dump_stack() for the time being.

[..]
> > +asmlinkage __weak __visible void dump_stack(void)
> >  {
> >         __dump_stack();
> >  }
> 
> Weak symbols are generally discouraged in the kernel. We have
> them in a couple of places, but I find them rather confusing as they
> make it harder to figure out what is actually going on.

Honestly, I kind of find __weak less confusing than EXPORT_SYMBOL(dump_stack)
in 3 different places. __weak hints that the symbol likely will be overridden
somewhere, while EXPORT_SYMBOL() does not (at least not to me). Dunno.

	-ss
