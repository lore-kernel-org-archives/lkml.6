Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeDYWti (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:49:38 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:39317 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbeDYWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:49:36 -0400
X-Google-Smtp-Source: AB8JxZrJIwmmZjoIpRStKwCEBi4xLuwwY7GqwI92GxO9CCsQICEchm1hykAUIqTq0HTf5KeMFvEHow==
Date: Wed, 25 Apr 2018 15:49:34 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Mikulas Patocka <mpatocka@redhat.com>
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
In-Reply-To: <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.21.1804251546240.58229@chino.kir.corp.google.com>
References: <20180421144757.GC14610@bombadil.infradead.org>  <alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com>  <20180423151545.GU17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804232003100.2299@file01.intranet.prod.int.rdu2.redhat.com>
 <20180424170349.GQ17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com>  <20180424173836.GR17484@dhcp22.suse.cz>  <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
 <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>  <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com>  <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>  <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <1524694663.4100.21.camel@HansenPartnership.com> <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Mikulas Patocka wrote:

> You need to enable it on boot. Enabling it when the kernel starts to 
> execute userspace code is already too late (because you would miss 
> kvmalloc calls in the kernel boot path).
> 

Is your motivation that since kvmalloc() never falls back to vmalloc() on 
boot because fragmentation is not be an issue at boot that we should catch 
bugs where it would matter if it had fallen back?  If we are worrying 
about falling back to vmalloc before even initscripts have run I think we 
have bigger problems.
