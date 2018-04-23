Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeDWJ1u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:27:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46635 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbeDWJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:27:46 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Diego Viola <diego.viola@gmail.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, len.brown@intel.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500 CPU (bisect included)
Date: Mon, 23 Apr 2018 11:27:36 +0200
Message-ID: <2120072.1825pzNyX4@aspire.rjw.lan>
In-Reply-To: <20180423091633.GU4064@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com> <20180423091633.GU4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 23, 2018 11:16:33 AM CEST Peter Zijlstra wrote:
> On Sat, Apr 21, 2018 at 11:19:55PM -0300, Diego Viola wrote:
> 
> > The problem only happens *after* resuming from suspend, in normal S0
> > state it never happens.
> 
> What kind of suspend are you doing? s2disk, s2ram ?
> 
> > My machine is a desktop and has a dual core E5500 CPU with 2GB of RAM,
> > I run Arch Linux and I use the i3wm.
> 
> That's a Core2 era chip; does it actually have stable TSC ?
> 
> > aa83c45762a242acce9b35020363225a7b59d7c9 is the first bad commit
> 
> That is most curious; that was supposed to only affect early boot. I'll
> try and figure out of there's some intersection with suspend.

Well, FWIW, I wonder if the flags that were set in init_tsc_clocksource() for
unstable TSC before the above commit may be involved in this somehow.
