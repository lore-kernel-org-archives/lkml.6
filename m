Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeDCMgI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:36:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49739 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932104AbeDCMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:36:06 -0400
Date: Tue, 3 Apr 2018 14:35:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Vesker <valex@mellanox.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180403123556.GA31740@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
 <20180330151129.GG28244@lunn.ch>
 <20180402091232.GE3313@nanopsycho>
 <0d106ece-4669-389d-da30-63a630ca625c@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d106ece-4669-389d-da30-63a630ca625c@mellanox.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 08:43:27AM +0300, Alex Vesker wrote:
> 
> 
> On 4/2/2018 12:12 PM, Jiri Pirko wrote:
> >Fri, Mar 30, 2018 at 05:11:29PM CEST, andrew@lunn.ch wrote:
> >>>Please see:
> >>>http://patchwork.ozlabs.org/project/netdev/list/?series=36524
> >>>
> >>>I bevieve that the solution in the patchset could be used for
> >>>your usecase too.
> >>Hi Jiri
> >>
> >>https://lkml.org/lkml/2018/3/20/436
> >>
> >>How well does this API work for a 2Gbyte snapshot?
> >Ccing Alex who did the tests.
> 
> I didn't check the performance for such a large snapshot.
> From my measurement it takes 0.09s for 1 MB of data this means
> about ~3m.

I was not really thinking about performance. More about how well does
the system work when you ask the kernel for 2GB of RAM to put a
snapshot into? And given your current design, you need another 2GB
buffer for the driver to use before calling this new API.

So i'm asking, how well does this API scale?

I think you need to remove the need for a second buffer in the
driver. Either the driver allocates the buffer and hands it over, or
your core code allocates the buffer and gives it to the driver to
fill. Maybe look at what makes most sense for the crash dump code?

      Andrew
