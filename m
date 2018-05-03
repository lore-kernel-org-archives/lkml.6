Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeECRkz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:40:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751007AbeECRku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:40:50 -0400
Date: Thu, 3 May 2018 13:40:48 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: John Stoffel <john@stoffel.org>
cc: Andrew@stoffel.org, dm-devel@redhat.com, eric.dumazet@gmail.com,
        mst@redhat.com, netdev@vger.kernel.org, jasowang@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Hocko <mhocko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal@stoffel.org, edumazet@google.com, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <23273.48986.516559.317965@quad.stoffel.home>
Message-ID: <alpine.LRH.2.02.1805031333050.28479@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180421144757.GC14610@bombadil.infradead.org> <20180424173836.GR17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com> <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>
 <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com> <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com> <1524694663.4100.21.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804251857070.31135@file01.intranet.prod.int.rdu2.redhat.com> <1524697697.4100.23.camel@HansenPartnership.com> <23266.8532.619051.784274@quad.stoffel.home> <alpine.LRH.2.02.1804261726540.13401@file01.intranet.prod.int.rdu2.redhat.com>
 <23271.24580.695738.853532@quad.stoffel.home> <alpine.LRH.2.02.1804301622480.4454@file01.intranet.prod.int.rdu2.redhat.com> <23273.48986.516559.317965@quad.stoffel.home>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 May 2018, John Stoffel wrote:

> You miss my point, which is that there's no explanation of what the
> difference is between SLAB and SLUB and which I should choose.  The
> same goes here.  If the KConfig option doesn't give useful info, it's
> useless.

So what, we could write explamantion of that option.

> >> Now I also think that Linus has the right idea to not just sprinkle 
> >> BUG_ONs into the code, just dump and oops and keep going if you can.  
> >> If it's a filesystem or a device, turn it read only so that people 
> >> notice right away.
> 
> Mikulas> This vmalloc fallback is similar to
> Mikulas> CONFIG_DEBUG_KOBJECT_RELEASE.  CONFIG_DEBUG_KOBJECT_RELEASE
> Mikulas> changes the behavior of kobject_put in order to cause
> Mikulas> deliberate crashes (that wouldn't happen otherwise) in
> Mikulas> drivers that misuse kobject_put. In the same sense, we want
> Mikulas> to cause deliberate crashes (that wouldn't happen otherwise)
> Mikulas> in drivers that misuse kvmalloc.
> 
> Mikulas> The crashes will only happen in debugging kernels, not in
> Mikulas> production kernels.
> 
> Says you.  What about people or distros that enable it
> unconditionally?  They're going to get all kinds of reports and then
> turn it off again.  Crashing the system isn't the answer here.  

I've made that kvmalloc bug too (in the function 
dm_integrity_free_journal_scatterlist). I'd much rather like if the kernel 
crashed (because then - I would fix the bug). The kernel didn't crash and 
the bug sneaked into the official linux tree, where may be causing random 
crashes for other users.

Mikulas
