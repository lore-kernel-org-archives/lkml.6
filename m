Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeFAJhp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:37:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40306 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeFAJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:37:43 -0400
X-Google-Smtp-Source: ADUXVKJ8E7nKwj61FF81/2e8D4Vz+259hjdN2ONNCpZpef4cgQtssAkcqWOSvlBOncupqHomBLtcDA==
Date: Fri, 1 Jun 2018 18:37:38 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180601093738.GC1841@jagdpanzerIV>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
 <20180531105215.GF477@jagdpanzerIV>
 <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
 <20180601044050.GA5687@jagdpanzerIV>
 <20180601085356.kncuat7epkbtythv@pathway.suse.cz>
 <20180601090942.ek3j4bpbhschljrw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601090942.ek3j4bpbhschljrw@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/01/18 11:09), Petr Mladek wrote:
> > [...]
> > 
> > > So I'd say that most likely the following scenarios can suffer:
> > > 
> > > - NMI comes in, sets loglevel to X, printk-s some data, restores the
> > >   loglevel back to Y
> > > - IRQ comes in [like sysrq, etc] comes in and does the same thing
> > > - software exception comes in and does the same thing [e.g. bust_spinlocks()
> > >   at arch/s390/mm/fault.c]
> 
> I forgot to say that it was a great point and analyze.

Thanks :)

> > My view is:
> > 
> > The race with another printk() (console_lock owner) is much more
> > likely than a race between two CPUs manipulating console_loglevel.
> > 
> > The proposed patch seems to be in the right direction. It is supposed
> > to fix the most likely scenario. We could block it and request full
> > solution but I wonder if it is worth it.
> > 
> > I am personally fine with this partial solution for now. We could
> > always make it better if people meet the other scenarios.
> 
> I am still fine with the partial solution. Well, I will think
> more about it before approving any patch.

Same here. I don't mind the patch and can agree with this partial
solution [may be we are missing more cases?]. Probably will need
a little bit more time.

	-ss
