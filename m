Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeCIJu6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:50:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:56287 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbeCIJu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:50:57 -0500
Date: Fri, 9 Mar 2018 10:50:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180309095054.vrngc6fz7wo3hd4x@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV>
 <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV>
 <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
 <20180307114845.GA894@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307114845.GA894@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-03-07 20:48:56, Sergey Senozhatsky wrote:
> On (03/07/18 11:57), Arnd Bergmann wrote:
> > Since lib/dump_stack.c is mandatory then, I would suggest making it
> > obj-y and moving it out of lib/ into kernel/printk/.
> 
> Totally agree on obj-y. And tend to agree on moving lib/dump_stack to
> kernel/printk. lib/dump_stack depends on CONFIG_PRINTK and is partially
> in printk.h. So it _mostly_ seems like the right place after all.

I agree that we should define dump_stack.o as obj-y. Also it makes
sense to move it to kernel/printk/. As Sergey said: it depends on
CONFIG_PRINTK and is in printk.h.

Steven, do you agree or would you suggest another location?
It was you who suggested to move the several functions from printk.c
to dump_stack.c. IMHO, the motivation was to fix responsibilities
(maintainer-ship) of this stuff. This will not really happen if
we move the file to printk directory.

Best Regards,
Petr
