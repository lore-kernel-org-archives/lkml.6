Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeCJJJS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:09:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48991 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:09:17 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mike Galbraith <mgalbraith@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sat, 10 Mar 2018 10:09:55 +0100
Message-ID: <4107750.z0gk2rLgKi@aspire.rjw.lan>
In-Reply-To: <1520658091.15339.4.camel@suse.de>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <1520658091.15339.4.camel@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 10, 2018 6:01:31 AM CET Mike Galbraith wrote:
> On Fri, 2018-03-09 at 10:34 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > Thanks a lot for the discussion and testing so far!
> > 
> > This is a total respin of the whole series, so please look at it afresh.
> > Patches 2 and 3 are the most similar to their previous versions, but
> > still they are different enough.
> 
> Respin of testdrive...

Appreciated, thanks!

> i4790 booted nopti nospectre_v2
> 
> 30 sec tbench
> 4.16.0.g1b88acc-master (virgin)
> Throughput 559.279 MB/sec  1 clients  1 procs  max_latency=0.046 ms
> Throughput 997.119 MB/sec  2 clients  2 procs  max_latency=0.246 ms
> Throughput 1693.04 MB/sec  4 clients  4 procs  max_latency=4.309 ms
> Throughput 3597.2 MB/sec  8 clients  8 procs  max_latency=6.760 ms
> Throughput 3474.55 MB/sec  16 clients  16 procs  max_latency=6.743 ms
> 
> 4.16.0.g1b88acc-master (+ v2)
> Throughput 588.929 MB/sec  1 clients  1 procs  max_latency=0.291 ms
> Throughput 1080.93 MB/sec  2 clients  2 procs  max_latency=0.639 ms
> Throughput 1826.3 MB/sec  4 clients  4 procs  max_latency=0.647 ms
> Throughput 3561.01 MB/sec  8 clients  8 procs  max_latency=1.279 ms
> Throughput 3382.98 MB/sec  16 clients  16 procs  max_latency=4.817 ms
> 
> 4.16.0.g1b88acc-master (+ v3)
> Throughput 588.711 MB/sec  1 clients  1 procs  max_latency=0.067 ms
> Throughput 1077.71 MB/sec  2 clients  2 procs  max_latency=0.298 ms

This is a bit better than "raw".  Around 8-9% I'd say.

> Throughput 1803.47 MB/sec  4 clients  4 procs  max_latency=0.667 ms

This one is too, but not as much.

> Throughput 3591.4 MB/sec  8 clients  8 procs  max_latency=4.999 ms
> Throughput 3444.74 MB/sec  16 clients  16 procs  max_latency=1.995 ms

And these are slightly worse, but just slightly.

> 4.16.0.g1b88acc-master (+ my local patches)
> Throughput 722.559 MB/sec  1 clients  1 procs  max_latency=0.087 ms
> Throughput 1208.59 MB/sec  2 clients  2 procs  max_latency=0.289 ms
> Throughput 2071.94 MB/sec  4 clients  4 procs  max_latency=0.654 ms
> Throughput 3784.91 MB/sec  8 clients  8 procs  max_latency=0.974 ms
> Throughput 3644.4 MB/sec  16 clients  16 procs  max_latency=5.620 ms
> 
> turbostat -q -- firefox /root/tmp/video/BigBuckBunny-DivXPlusHD.mkv & sleep 300;killall firefox
> 
>                         PkgWatt
>                               1     2     3
> 4.16.0.g1b88acc-master     6.95  7.03  6.91 (virgin)
> 4.16.0.g1b88acc-master     7.20  7.25  7.26 (+v2)
> 4.16.0.g1b88acc-master     7.04  6.97  7.07 (+v3)
> 4.16.0.g1b88acc-master     6.90  7.06  6.95 (+my patches)
> 
> No change wrt nohz high frequency cross core scheduling overhead, but
> the light load power consumption oddity did go away.

OK

> (btw, don't read anything into max_latency numbers, that's GUI noise)

I see.

Thanks!
