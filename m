Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDNVTN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 17:19:13 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:61168 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751732AbeDNVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 17:19:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,451,1517871600";
   d="scan'208";a="322881597"
Date: Sat, 14 Apr 2018 23:19:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
cc: Julia Lawall <julia.lawall@lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
In-Reply-To: <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1804142315300.2750@hadrien>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>   <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>   <20180410123305.GF4082@hirez.programming.kicks-ass.net>   <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>  
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>   <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>   <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>   <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>  
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>   <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>  <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>  <alpine.DEB.2.20.1804120816130.3559@hadrien>
 <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2018, Joe Perches wrote:

> On Thu, 2018-04-12 at 08:22 +0200, Julia Lawall wrote:
> > On Wed, 11 Apr 2018, Joe Perches wrote:
> > > On Wed, 2018-04-11 at 09:29 -0700, Andrew Morton wrote:
> > > > We already have some 500 bools-in-structs
> > >
> > > I got at least triple that only in include/
> > > so I expect there are at probably an order
> > > of magnitude more than 500 in the kernel.
> > >
> > > I suppose some cocci script could count the
> > > actual number of instances.  A regex can not.
> >
> > I got 12667.
>
> Could you please post the cocci script?
>
> > I'm not sure to understand the issue.  Will using a bitfield help if there
> > are no other bitfields in the structure?
>
> IMO, not really.
>
> The primary issue is described by Linus here:
> https://lkml.org/lkml/2017/11/21/384
>
> I personally do not find a significant issue with
> uncontrolled sizes of bool in kernel structs as
> all of the kernel structs are transitory and not
> written out to storage.
>
> I suppose bool bitfields are also OK, but for the
> RMW required.
>
> Using unsigned int :1 bitfield instead of bool :1
> has the negative of truncation so that the uint
> has to be set with !! instead of a simple assign.

At least with gcc 5.4.0, a number of structures become larger with
unsigned int :1. bool:1 seems to mostly solve this problem.  The structure
ichx_desc, defined in drivers/gpio/gpio-ich.c seems to become larger with
both approaches.

julia
