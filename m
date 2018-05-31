Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbeEaMVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:21:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46885 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754197AbeEaMVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:21:14 -0400
Date: Thu, 31 May 2018 14:21:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
 <20180531105215.GF477@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531105215.GF477@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-31 19:52:15, Sergey Senozhatsky wrote:
> On (05/31/18 15:49), Maninder Singh wrote:
> > 
> > This patch make sure printing of log if loglevel at time of storing
> > log is greater than current console loglevel.
> > 
> > @why
> > In case of async printk, printk thread can miss logs because it checks
> > current log level at time of console_unlock.
> 
> Upstream printk has no printing kthread. And we also run
> printk()->console_unlock() with disabled preemption.

Yes, the comment was wrong but the problem is real. The console
handling is asynchronous even without the kthread. The current
console_lock owner is responsible for handling messages also
from other CPUs.

Best Regards,
Petr
