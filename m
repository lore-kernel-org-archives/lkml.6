Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756650AbeDZO3I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:29:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756459AbeDZO2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:28:51 -0400
Date: Thu, 26 Apr 2018 10:28:45 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Michal Hocko <mhocko@kernel.org>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Rientjes <rientjes@google.com>, dm-devel@redhat.com,
        eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org,
        jasowang@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, edumazet@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <20180426125817.GO17484@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180424170349.GQ17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com> <20180424173836.GR17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
 <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org> <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com> <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <1524694663.4100.21.camel@HansenPartnership.com> <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com> <20180426125817.GO17484@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2018, Michal Hocko wrote:

> On Wed 25-04-18 18:42:57, Mikulas Patocka wrote:
> > 
> > 
> > On Wed, 25 Apr 2018, James Bottomley wrote:
> [...]
> > > Kconfig proliferation, conversely, is a bit of a nightmare from both
> > > the user and the tester's point of view, so we're trying to avoid it
> > > unless absolutely necessary.
> > > 
> > > James
> > 
> > I already offered that we don't need to introduce a new kernel option and 
> > we can bind this feature to any other kernel option, that is enabled in 
> > the debug kernel, for example CONFIG_DEBUG_SG. Michal said no and he said 
> > that he wants a new kernel option instead.
> 
> Just for the record. I didn't say I _want_ a config option. Do not
> misinterpret my words. I've said that a config option would be
> acceptable if there is no way to deliver the functionality via kernel
> package automatically. You haven't provided any argument that would
> explain why the kernel package cannot add a boot option. Maybe there are
> some but I do not see them right now.

AFAIK Grub doesn't load per-kernel options from a per-kernel file. Even if 
we hacked grub scripts to add this option, other distributions won't.

Mikulas
