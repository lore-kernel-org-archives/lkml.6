Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeDYXAh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:00:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752661AbeDYXAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:00:33 -0400
Date: Wed, 25 Apr 2018 19:00:30 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: David Rientjes <rientjes@google.com>, dm-devel@redhat.com,
        eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org,
        jasowang@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        edumazet@google.com, Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <1524694663.4100.21.camel@HansenPartnership.com>
Message-ID: <alpine.LRH.2.02.1804251857070.31135@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180421144757.GC14610@bombadil.infradead.org>  <alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com>  <20180423151545.GU17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804232003100.2299@file01.intranet.prod.int.rdu2.redhat.com>
  <20180424125121.GA17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804241142340.15660@file01.intranet.prod.int.rdu2.redhat.com>  <20180424162906.GM17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804241250350.28995@file01.intranet.prod.int.rdu2.redhat.com>
 <20180424170349.GQ17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com>  <20180424173836.GR17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
 <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>  <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com>  <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>  <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <1524694663.4100.21.camel@HansenPartnership.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-1907632136-1524697231=:31135"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1907632136-1524697231=:31135
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 25 Apr 2018, James Bottomley wrote:

> > > Do we really need the new config option?  This could just be
> > > manually  tunable via fault injection IIUC.
> > 
> > We do, because we want to enable it in RHEL and Fedora debugging
> > kernels, so that it will be tested by the users.
> > 
> > The users won't use some extra magic kernel options or debugfs files.
> 
> If it can be enabled via a tunable, then the distro can turn it on
> without the user having to do anything.  If you want to present the
> user with a different boot option, you can (just have the tunable set
> on the command line), but being tunable driven means that you don't
> have to choose that option, you could automatically enable it under a
> range of circumstances.  I think most sane distributions would want
> that flexibility.
> 
> Kconfig proliferation, conversely, is a bit of a nightmare from both
> the user and the tester's point of view, so we're trying to avoid it
> unless absolutely necessary.
> 
> James

BTW. even developers who compile their own kernel should have this enabled 
by a CONFIG option - because if the developer sees the option when 
browsing through menuconfig, he may enable it. If he doesn't see the 
option, he won't even know that such an option exists.

Mikulas
--185206533-1907632136-1524697231=:31135--
