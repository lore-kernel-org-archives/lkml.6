Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeCGLtD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:49:03 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46747 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeCGLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:49:01 -0500
X-Google-Smtp-Source: AG47ELvf6seV6zY/i8bnnCmTeOvDv7sJEZjGsEp1I0pDCjVbgudyC/2f3TEVl9ufn4Stq4Y92Iu6rg==
Date: Wed, 7 Mar 2018 20:48:56 +0900
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
Message-ID: <20180307114845.GA894@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV>
 <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV>
 <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/18 11:57), Arnd Bergmann wrote:
[..]
> >> Originally I planned to wait a few more releases, but the last maintainer
> >> has commented that he will now send a patch for immediate removal,
> >> so 4.17 is almost certain at this point.
> >
> > Would be great to get it removed as soon as possible then. Otherwise we
> > will get broken blackfin build errors from Stephen (or would need to hold
> > off Dave's patch).
> 
> You could also add a patch to your tree that removes the blackfin
> dump_stack() function, or we could ask Stephen and the other
> people operating build bots to stop building blackfin right now
> (they will have to do that anyway once the arch gets removed).

OK. Petr, Stephen, what would be your preference?

> Since lib/dump_stack.c is mandatory then, I would suggest making it
> obj-y and moving it out of lib/ into kernel/printk/.

Totally agree on obj-y. And tend to agree on moving lib/dump_stack to
kernel/printk. lib/dump_stack depends on CONFIG_PRINTK and is partially
in printk.h. So it _mostly_ seems like the right place after all.

	-ss
