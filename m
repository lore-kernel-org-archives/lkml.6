Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDSBRe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:17:34 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:41978 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSBRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:17:33 -0400
X-Google-Smtp-Source: AIpwx48HW9pb8wWVqoz30AUrJ4XKsXvewptamU53zVdGv6+0yBYA0X4I8j254XqJAsuoVcpeoaZIMQ==
Date: Thu, 19 Apr 2018 10:17:28 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180419011728.GA2700@jagdpanzerIV>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
 <20180418102943.5aa0ffc4@gandalf.local.home>
 <20180418150214.z7oyughldrktj6e4@pathway.suse.cz>
 <20180418111038.209cc0cc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418111038.209cc0cc@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/18/18 11:10), Steven Rostedt wrote:
> 
> > > Calling wake_up_klogd() will grab the rq lock and give us a A-B<->B-A
> > > locking order.  
> > 
> > wake_up_klogd() uses the lockless irq_work_queue(). So it is actually
> > safe.
> 
> I didn't look at the code. OK then we don't need to worry about that.

OK.

> > 
> > But the name is confusing. We should rename it.
> 
> Yes, I would because the old wake_up_klogd() did do a wakeup. Perhaps
> we should name it: kick_klogd().

Agreed.

	-ss
