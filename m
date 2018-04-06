Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDFHUW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:20:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51669 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDFHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:20:21 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 04/10] jiffies: Introduce USER_TICK_USEC and redefine TICK_USEC
Date: Fri, 06 Apr 2018 09:20:31 +0200
Message-ID: <72540493.566rOE4q81@aspire.rjw.lan>
In-Reply-To: <20180406010954.GA4400@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <7620417.mBP1cQHt5D@aspire.rjw.lan> <20180406010954.GA4400@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 6, 2018 3:09:55 AM CEST Frederic Weisbecker wrote:
> On Wed, Apr 04, 2018 at 10:38:34AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Since the subsequent changes will need a TICK_USEC definition
> > analogous to TICK_NSEC, rename the existing TICK_USEC as
> > USER_TICK_USEC, update its users and redefine TICK_USEC
> > accordingly.
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > v8 -> v9: No changes.
> > 
> > ---
> >  drivers/net/ethernet/sfc/mcdi.c |    2 +-
> >  include/linux/jiffies.h         |    7 +++++--
> >  kernel/time/ntp.c               |    2 +-
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > Index: linux-pm/include/linux/jiffies.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/jiffies.h
> > +++ linux-pm/include/linux/jiffies.h
> > @@ -62,8 +62,11 @@ extern int register_refined_jiffies(long
> >  /* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
> >  #define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
> >  
> > -/* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
> > -#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
> > +/* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
> > +#define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
> 
> Nit: SHIFTED_HZ doesn't seem to exist anymore.

Well, fair enough, but that would need to be changed along with the TICK_NSEC
comment IMO.

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
