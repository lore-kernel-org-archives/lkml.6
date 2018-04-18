Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDRPKn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752599AbeDRPKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:10:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5D22178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 11:10:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180418111038.209cc0cc@gandalf.local.home>
In-Reply-To: <20180418150214.z7oyughldrktj6e4@pathway.suse.cz>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
        <20180418102943.5aa0ffc4@gandalf.local.home>
        <20180418150214.z7oyughldrktj6e4@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 17:02:14 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > Calling wake_up_klogd() will grab the rq lock and give us a A-B<->B-A
> > locking order.  
> 
> wake_up_klogd() uses the lockless irq_work_queue(). So it is actually
> safe.

I didn't look at the code. OK then we don't need to worry about that.

> 
> But the name is confusing. We should rename it.

Yes, I would because the old wake_up_klogd() did do a wakeup. Perhaps
we should name it: kick_klogd().

-- Steve
