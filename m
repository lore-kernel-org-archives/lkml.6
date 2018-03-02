Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427978AbeCBPzL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:55:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:45106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425921AbeCBPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:54:58 -0500
Date: Fri, 2 Mar 2018 16:54:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
References: <20180302160732.12691fbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302160732.12691fbc@canb.auug.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-02 16:07:32, Stephen Rothwell wrote:
> Hi Petr,
> 
> After merging the printk tree, today's linux-next build (bfin
> BF518F-EZBRD_defconfig) failed like this:
> 
> lib/dump_stack.o: In function `dump_stack':
> lib/dump_stack.c:122: multiple definition of `dump_stack'
> arch/blackfin/kernel/dumpstack.o:arch/blackfin/kernel/dumpstack.c:166: first defined here
> 
> Presumably caused by commit
> 
>   8040af489957 ("printk: move dump stack related code to lib/dump_stack.c")

I could confirm that it is caused by this commit. I have temporary
removed it from printk.git.

> (Though it is not immediately obvious why.)

It is a mistery to me. The error appears when I move any of
dump_stack_print_info() or show_regs_print_info() function
definitions from kernel/printk/printk.c to lib/dump_stack.c.
All the other changes seems unrelated.

The thing is that we basically do not touch dump_stack() definition
by that patch.

> This fails all the blackfin builds.  nds32 (a new architecture) also
> has a dump_stack function.

Good to know!

Best Regards,
Petr
