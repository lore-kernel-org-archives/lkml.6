Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935161AbeCENaA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:30:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:43824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935036AbeCEN37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:29:59 -0500
Date: Mon, 5 Mar 2018 14:29:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180305132956.mc4l3evgf6swqcuo@pathway.suse.cz>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
 <20180304130151.GA483@tigerII.localdomain>
 <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
 <20180304104324.6bbbaa53@gandalf.local.home>
 <32058cbd-7d09-4316-afd9-c2f031a2a406.qixuan.wu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32058cbd-7d09-4316-afd9-c2f031a2a406.qixuan.wu@linux.alibaba.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-05 14:56:59, Qixuan.Wu wrote:
> Hi Steve,  
> 
> On Sun, 04 Mar 2018 23:43:23 +0800
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Yes, people keep bringing up this scenario.
> > It would require a single burst of printks to all CPUs. And then no
> > more printks after that. The last one will end up printing the entire
> > buffer out the slow console. The thing is, this is a bounded time, and
> > no printk will print more than one full buffer worth.
> 
> > If this is a worry, then set the timeouts for the lockup detection to
> > be longer than the time it takes to print one full buffer with the
> > slowest console.
> 
> Thanks for your information and suggestion. We will think of backport 
> the code as per the workload, or recently, maybe we will think of disable 
> ttyS0 console just for the printk. 

Please, share the log if you still see a soft/hard lockups with the 4
commits (console waiter logic). It would help to improve the solution.

We need some justification to make the printk code more complicated.
Also many possible solutions might improve some scenarios and make
worse some others. Therefore we need data to make decisions.

Best Regards,
Petr
