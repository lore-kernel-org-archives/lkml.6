Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeDYW4y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:56:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753774AbeDYW4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:56:50 -0400
Date: Wed, 25 Apr 2018 18:56:49 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: David Rientjes <rientjes@google.com>
cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        dm-devel@redhat.com, eric.dumazet@gmail.com, mst@redhat.com,
        netdev@vger.kernel.org, jasowang@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, edumazet@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <alpine.DEB.2.21.1804251546240.58229@chino.kir.corp.google.com>
Message-ID: <alpine.LRH.2.02.1804251853460.31135@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180421144757.GC14610@bombadil.infradead.org>  <alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com>  <20180423151545.GU17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804232003100.2299@file01.intranet.prod.int.rdu2.redhat.com>
 <20180424170349.GQ17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com>  <20180424173836.GR17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
 <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>  <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com>  <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>  <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <1524694663.4100.21.camel@HansenPartnership.com> <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.21.1804251546240.58229@chino.kir.corp.google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Apr 2018, David Rientjes wrote:

> On Wed, 25 Apr 2018, Mikulas Patocka wrote:
> 
> > You need to enable it on boot. Enabling it when the kernel starts to 
> > execute userspace code is already too late (because you would miss 
> > kvmalloc calls in the kernel boot path).
> 
> Is your motivation that since kvmalloc() never falls back to vmalloc() on 
> boot because fragmentation is not be an issue at boot that we should catch 
> bugs where it would matter if it had fallen back?  If we are worrying 
> about falling back to vmalloc before even initscripts have run I think we 
> have bigger problems.

The same driver can be compiled directly into the kernel or be loaded as a 
module. If the user (or the person preparing distro kernel) compiles the 
driver directly into the kernel, kvmalloc should be tested on that driver, 
because a different user or distribution can compile that driver as a 
module.

Mikulas
