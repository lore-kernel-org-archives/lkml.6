Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeBMHaa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:30:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933468AbeBMHa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:30:29 -0500
Date: Tue, 13 Feb 2018 15:30:22 +0800
From: Dave Young <dyoung@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180213073022.GA24783@dhcp-128-65.nay.redhat.com>
References: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
 <20180209081604.GE689@jagdpanzerIV>
 <20180209082743.GA14845@dhcp-128-65.nay.redhat.com>
 <20180209084235.GF689@jagdpanzerIV>
 <20180209085116.GB5454@dhcp-128-65.nay.redhat.com>
 <20180209090018.GA7129@dhcp-128-65.nay.redhat.com>
 <20180209091531.GG689@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209091531.GG689@jagdpanzerIV>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/18 at 06:15pm, Sergey Senozhatsky wrote:
> On (02/09/18 17:00), Dave Young wrote:
> [..]
> > >
> > > I'm hesitating to add #ifdef CONFIG_PRINTK in lib/dump_stack.c.
> 
> Agreed.
> 
> > Maybe conditionally build dump_stack.o only when CONFIG_PRINTK is true,
> > but not sure if there are some historic reason this is not done before,
> > will do some testing see if it works.
> > 
> 
> Thanks.
> 
> Was thinking about the same thing - dump_stack() without CONFIG_PRINTK
> doesn't make that much sense anyway. Well, maybe it does in some weird
> case... Need to check. But it seems that we probably can just make the
> dependency, which already exists, explicit.

Did some testing on x86_64 and s390, I did not find any breakage, sent
the V2 just now.

> 
> 	-ss

Thanks
Dave
