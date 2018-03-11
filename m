Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeCKKVA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:21:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59192 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeCKKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:20:59 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rik van Riel'" <riel@surriel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sun, 11 Mar 2018 11:21:36 +0100
Message-ID: <1773378.CTekz94moy@aspire.rjw.lan>
In-Reply-To: <001801d3b90c$99232600$cb697200$@net>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <000701d3b889$eadd5340$c097f9c0$@net> <001801d3b90c$99232600$cb697200$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 11, 2018 8:43:02 AM CET Doug Smythies wrote:
> On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
> >On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
> >> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
> >
> ... [snip] ...
> 
> > The information that they often spend more time than a tick
> > period in state 0 in one go *is* relevant, though.
> >
> >
> > That issue can be dealt with in a couple of ways and the patch below is a
> > rather straightforward attempt to do that.  The idea, basically, is to discard
> > the result of governor prediction if the tick has been stopped alread and
> > the predicted idle duration is within the tick range.
> >
> > Please try it on top of the v3 and tell me if you see an improvement.
> 
> It seems pretty good so far.
> See a new line added to the previous graph, "rjwv3plus".
> 
> http://fast.smythies.com/rjwv3plus_100.png

OK, cool!

Below is a respin of the last patch which also prevents shallow states from
being chosen due to interactivity_req when the tick is stopped.

You may also add a poll_idle() fix I've just posted:

https://patchwork.kernel.org/patch/10274595/

on top of this.  It makes quite a bit of a difference for me. :-)

> I'll do another 100% load on one CPU test overnight, this time with
> a trace.

Thanks!
