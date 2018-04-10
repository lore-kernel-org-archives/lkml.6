Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeDJHFe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:05:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56503 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeDJHFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:05:33 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pm tree
Date: Tue, 10 Apr 2018 09:05:39 +0200
Message-ID: <1542592.dfSYS5dp5n@aspire.rjw.lan>
In-Reply-To: <20180409112438.6832432f@canb.auug.org.au>
References: <20180409112438.6832432f@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 9, 2018 3:24:38 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/QL=OZEguM./+7xhHdQruHaV
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Rafael,
> 
> After merging the pm tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
> kernel/time/tick-sched.c:1162:3: warning: 'now' may be used uninitialized i=
> n this function [-Wmaybe-uninitialized]
>    __tick_nohz_idle_restart_tick(ts, now);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/time/tick-sched.c:1146:10: note: 'now' was declared here
>   ktime_t now;
>           ^~~
> 
> This appears to be a false positive.
> 
> And another in the x86_64 allmodconfig build:
> 
> kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
> kernel/time/tick-sched.c:538:2: warning: 'now' may be used uninitialized in=
>  this function [-Wmaybe-uninitialized]
>   update_ts_time_stats(smp_processor_id(), ts, now, NULL);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/time/tick-sched.c:1146:10: note: 'now' was declared here
>   ktime_t now;
>           ^~~
> 
> also looks like a false positive.

Yes, they are false positives AFAICS.

Cheers,
Rafael
