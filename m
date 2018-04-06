Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFBKA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeDFBJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:09:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1581D217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Fri, 6 Apr 2018 03:09:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Subject: Re: [PATCH v9 04/10] jiffies: Introduce USER_TICK_USEC and redefine
 TICK_USEC
Message-ID: <20180406010954.GA4400@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <7620417.mBP1cQHt5D@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7620417.mBP1cQHt5D@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:38:34AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since the subsequent changes will need a TICK_USEC definition
> analogous to TICK_NSEC, rename the existing TICK_USEC as
> USER_TICK_USEC, update its users and redefine TICK_USEC
> accordingly.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v8 -> v9: No changes.
> 
> ---
>  drivers/net/ethernet/sfc/mcdi.c |    2 +-
>  include/linux/jiffies.h         |    7 +++++--
>  kernel/time/ntp.c               |    2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/include/linux/jiffies.h
> ===================================================================
> --- linux-pm.orig/include/linux/jiffies.h
> +++ linux-pm/include/linux/jiffies.h
> @@ -62,8 +62,11 @@ extern int register_refined_jiffies(long
>  /* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
>  #define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
>  
> -/* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
> -#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
> +/* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
> +#define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)

Nit: SHIFTED_HZ doesn't seem to exist anymore.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
