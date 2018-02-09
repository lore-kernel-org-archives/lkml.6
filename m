Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeBIJA1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:00:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750778AbeBIJA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:00:26 -0500
Date: Fri, 9 Feb 2018 17:00:18 +0800
From: Dave Young <dyoung@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180209090018.GA7129@dhcp-128-65.nay.redhat.com>
References: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
 <20180209081604.GE689@jagdpanzerIV>
 <20180209082743.GA14845@dhcp-128-65.nay.redhat.com>
 <20180209084235.GF689@jagdpanzerIV>
 <20180209085116.GB5454@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209085116.GB5454@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/18 at 04:51pm, Dave Young wrote:
> On 02/09/18 at 05:42pm, Sergey Senozhatsky wrote:
> > On (02/09/18 16:27), Dave Young wrote:
> > > > Seems that those functions are still defined in printk header.
> > > > Did you test !CONFIG_PRINTK build?
> > 
> > Apparently dump_stack(void) is also in printk.h
> > 
> > extern asmlinkage void dump_stack(void) __cold;
> > 
> > so it's "OK" to keep those functions in printk.h, I guess. I thought
> > that dump_stack() had its own header file...
> 
> It has not unfortunately..  The build failed because we have dummy
> functions in printk.h and redefined in lib/dump_stack.c.  I'm hesitating
> to add #ifdef CONFIG_PRINTK in lib/dump_stack.c.

Maybe conditionally build dump_stack.o only when CONFIG_PRINTK is true,
but not sure if there are some historic reason this is not done before,
will do some testing see if it works.

> 
> > 
> > > !CONFIG_PRINTK will use the dummy functions in printk.h, I did not test
> > > the build, doing it now to double confirm..
> > 
> > Not sure. Please test.
> > 
> > 	-ss
> 
> Thanks
> Dave
