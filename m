Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDEKJO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:09:14 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:39728 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeDEKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:09:12 -0400
X-Google-Smtp-Source: AIpwx4+tAPMPcfsMEIvf3eIT8rwiSVll5o66xsAgnmtS/94NrdWAjWZ6Z4+2Kao1EMGUsYXh2NHVqA==
Date: Thu, 5 Apr 2018 20:08:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: sched_rt_period_timer causing large latencies
Message-ID: <20180405200859.19fceb95@roar.ozlabs.ibm.com>
In-Reply-To: <1522917620.5593.5.camel@gmx.de>
References: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
        <20180405082701.GL4082@hirez.programming.kicks-ass.net>
        <1522917620.5593.5.camel@gmx.de>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Apr 2018 10:40:20 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Thu, 2018-04-05 at 10:27 +0200, Peter Zijlstra wrote:
> > On Thu, Apr 05, 2018 at 09:11:38AM +1000, Nicholas Piggin wrote:  
> > > Hi,
> > > 
> > > I'm seeing some pretty big latencies on a ~idle system when a CPU wakes
> > > out of a nohz idle. Looks like it's due to the taking a lot of remote
> > > locks and cache lines. irqoff trace:  
> > 
> > On RT I think we default RT_RUNTIME_SHARE to false, maybe we should do
> > the same for mainline.  
> 
> Probably.  My very first enterprise encounter with the thing was it NOT
> saving a box from it's not so clever driver due to that.

Well I would think a simpler per-cpu limiter might actually stand a
better chance of saving you there. Or even something attached to the
softlockup watchdog.

I'm still getting a lot of locks coming from sched_rt_period_timer
with RT_RUNTIME_SHARE false, it's just that it's now down to about
NR_CPUS locks rather than 3*NR_CPUS.

Thanks,
Nick
