Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCUM3T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:29:19 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:19166 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeCUM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:29:17 -0400
Date: Wed, 21 Mar 2018 17:58:08 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: David Laight <David.Laight@ACULAB.COM>
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
Message-ID: <20180321122807.GB3245@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com>
 <5f43882155104f50bbd2e5cf63d432f2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f43882155104f50bbd2e5cf63d432f2@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 03/20/18, 2018 at 20:10:19 +0530, David Laight wrote:
> From: Rahul Lakkireddy
> > Sent: 20 March 2018 13:32
> ...
> > On High Availability Server, the logs of the failing system must be
> > collected as quickly as possible.  So, we're concerned with the amount
> > of time taken to collect our large on-chip memory.  We see improvement
> > in doing 256-bit reads at a time.
> 
> Two other options:
> 
> 1) Get the device to DMA into host memory.
> 

Unfortunately, our device doesn't support doing DMA of on-chip memory.

> 2) Use mmap() (and vm_iomap_memory() in your driver) to get direct
>    userspace access to the (I assume) PCIe memory space.
>    You can then use whatever copy instructions the cpu has.
>    (Just don't use memcpy().)
> 

We also need to collect this in kernel space i.e. from crash recovery
kernel.

Thanks,
Rahul
