Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756730AbeDZVuX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:50:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752962AbeDZVuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:50:22 -0400
Date: Thu, 26 Apr 2018 17:50:20 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: John Stoffel <john@stoffel.org>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal@stoffel.org, eric.dumazet@gmail.com, mst@redhat.com,
        netdev@vger.kernel.org, jasowang@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>, Andrew@stoffel.org,
        David Rientjes <rientjes@google.com>,
        Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, edumazet@google.com
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <23266.8532.619051.784274@quad.stoffel.home>
Message-ID: <alpine.LRH.2.02.1804261726540.13401@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180421144757.GC14610@bombadil.infradead.org> <20180424162906.GM17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804241250350.28995@file01.intranet.prod.int.rdu2.redhat.com> <20180424170349.GQ17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com> <20180424173836.GR17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com> <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>
 <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com> <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com> <1524694663.4100.21.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804251857070.31135@file01.intranet.prod.int.rdu2.redhat.com> <1524697697.4100.23.camel@HansenPartnership.com> <23266.8532.619051.784274@quad.stoffel.home>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2018, John Stoffel wrote:

> >>>>> "James" == James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> 
> James> I may be an atypical developer but I'd rather have a root canal
> James> than browse through menuconfig options.  The way to get people
> James> to learn about new debugging options is to blog about it (or
> James> write an lwn.net article) which google will find the next time
> James> I ask it how I debug XXX.  Google (probably as a service to
> James> humanity) rarely turns up Kconfig options in response to a
> James> query.
> 
> I agree with James here.  Looking at the SLAB vs SLUB Kconfig entries
> tells me *nothing* about why I should pick one or the other, as an
> example.
> 
> John

I see your point - and I think the misunderstanding is this.

This patch is not really helping people to debug existing crashes. It is 
not like "you get a crash" - "you google for some keywords" - "you get a 
page that suggests to turn this option on" - "you turn it on and solve the 
crash".

What this patch really does is that - it makes the kernel deliberately 
crash in a situation when the code violates the specification, but it 
would not crash otherwise or it would crash very rarely. It helps to 
detect specification violations.

If the kernel developer (or tester) doesn't use this option, his buggy 
code won't crash - and if it won't crash, he won't fix the bug or report 
it. How is the user or developer supposed to learn about this option, if 
he gets no crash at all?

Mikulas
