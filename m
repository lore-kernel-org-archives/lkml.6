Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeCUM2W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:28:22 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:42093 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeCUM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:28:19 -0400
Date: Wed, 21 Mar 2018 17:57:09 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Message-ID: <20180321122708.GA3245@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com>
 <CAHp75VdTPzTK-MgrqU0N43YaNrwpN4pq8PwKAkcFQ-y_n6ez2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdTPzTK-MgrqU0N43YaNrwpN4pq8PwKAkcFQ-y_n6ez2A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 03/20/18, 2018 at 19:14:46 +0530, Andy Shevchenko wrote:
> On Tue, Mar 20, 2018 at 3:32 PM, Rahul Lakkireddy
> <rahul.lakkireddy@chelsio.com> wrote:
> > On Monday, March 03/19/18, 2018 at 20:13:10 +0530, Thomas Gleixner wrote:
> >> On Mon, 19 Mar 2018, Rahul Lakkireddy wrote:
> 
> >> Aside of that I very much doubt that this is faster than 4 consecutive
> >> 64bit reads/writes as you have the full overhead of
> >> kernel_fpu_begin()/end() for each access.
> >>
> >> You did not provide any numbers for this so its even harder to
> >> determine.
> >>
> >
> > Sorry about that.  Here are the numbers with and without this series.
> >
> > When reading up to 2 GB on-chip memory via MMIO, the time taken:
> >
> > Without Series        With Series
> > (64-bit read)         (256-bit read)
> >
> > 52 seconds            26 seconds
> >
> > As can be seen, we see good improvement with doing 256-bits at a
> > time.
> 
> But this is kinda synthetic test, right?
> If you run in a normal use case where kernel not only collecting logs,
> but doing something else, especially with frequent userspace
> interaction, would be trend the same?
> 

We see same improvement when collecting logs while running
heavy IO with iozone.

Thanks,
Rahul
