Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755619AbeDWPKY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:10:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755435AbeDWPKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:10:20 -0400
Date: Mon, 23 Apr 2018 09:10:15 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        eric.dumazet@gmail.com, edumazet@google.com, bhutchings@solarflare.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dm-devel@redhat.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
Message-ID: <20180423151015.GT17484@dhcp22.suse.cz>
References: <20180418.134651.2225112489265654270.davem@davemloft.net>
 <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
 <20180420130852.GC16083@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804201635180.25408@file01.intranet.prod.int.rdu2.redhat.com>
 <20180420210200.GH10788@bombadil.infradead.org>
 <alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com>
 <20180421144757.GC14610@bombadil.infradead.org>
 <20180422130356.GG17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804231006440.22488@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804231006440.22488@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-04-18 10:24:02, Mikulas Patocka wrote:
[...]

I am not going to comment on your continuous accusations. We can discuss
patches but general rants make very limited sense.
 
> > > > I already said that we can change it from CONFIG_DEBUG_VM to 
> > > > CONFIG_DEBUG_SG - or to whatever other option you may want, just to make 
> > > > sure that it is enabled in distro debug kernels by default.
> > > 
> > > Yes, and I think that's the right idea.  So send a v2 and ignore the
> > > replies that are clearly relating to an earlier version of the patch.
> > > Not everybody reads every mail in the thread before responding to one they
> > > find interesting.  Yes, ideally, one would, but sometimes one doesn't.
> > 
> > And look here. This is yet another ad-hoc idea. We have many users of
> > kvmalloc which have no relation to SG, yet you are going to control
> > their behavior by CONFIG_DEBUG_SG? No way! (yeah evil again)
> 
> Why aren't you constructive and pick up pick up the CONFIG flag?

Because config doesn't make that much of a sense. You do not want a
permanent vmalloc fallback unconditionally. Debugging option which
changes the behavior completely is not useful IMNHO. Besides that who is
going to enable it?

> > Really, we have a fault injection framework and this sounds like
> > something to hook in there.
> 
> The testing people won't set it up. They install the "kernel-debug" 
> package and run the tests in it.
> 
> If you introduce a hidden option that no one knows about, no one will use 
> it.

then make sure people know about it. Fuzzers already do test fault
injections.
-- 
Michal Hocko
SUSE Labs
