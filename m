Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeBIKrb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:47:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:33852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeBIKrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:47:31 -0500
Date: Fri, 9 Feb 2018 11:47:29 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180209104729.s5bhatnex3pntwt2@pathway.suse.cz>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180208145307.GA485@tigerII.localdomain>
 <20180208164820.qsotvvywds6z6le4@pathway.suse.cz>
 <20180209032830.GA689@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209032830.GA689@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-09 12:28:30, Sergey Senozhatsky wrote:
> On (02/08/18 17:48), Petr Mladek wrote:
> > Note that we need Tejun's patch for-4.16 because it fixes a potential
> > race introduced by the console waiter logic.
> 
> I understand it. I think I put my Reviewed-by on v1, maybe not...
> Here it is
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

You actually provided Reviewed-by for v1. But I was not sure if
you would agree with the updated commit log and pushing this for-4.16.

OK, I am going to push v2 into for-4.16-rc3 branch. I will push it
to Linus once I am back from vacation. If nobody is against it.


> But can we may be come up with a more general solution? Like the one
> that we discussed above. I've seen some user space klogd lost messages
> reports recently. I assume it was partly caused by that very late
> wakeup that we have.

Sure. A better solution makes sense. I am just not 100% sure about
the exact variant. But it is more or less about details that we
need to settle on.

Best Regards,
Petr
