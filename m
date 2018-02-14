Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754663AbeBNInL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:43:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49889 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754578AbeBNInK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:43:10 -0500
Date: Wed, 14 Feb 2018 09:43:08 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dhowells@redhat.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@kernel.org,
        rppt@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: WARNING in kvmalloc_node
Message-ID: <20180214084308.GX3443@dhcp22.suse.cz>
References: <001a1144c4ca5dc9d6056520c7b7@google.com>
 <20180214025533.GA28811@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214025533.GA28811@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-02-18 18:55:33, Matthew Wilcox wrote:
> On Tue, Feb 13, 2018 at 03:59:01PM -0800, syzbot wrote:
[...]
> >  kvmalloc include/linux/mm.h:541 [inline]
> >  kvmalloc_array include/linux/mm.h:557 [inline]
> >  __ptr_ring_init_queue_alloc include/linux/ptr_ring.h:474 [inline]
> >  ptr_ring_init include/linux/ptr_ring.h:492 [inline]
> >  __cpu_map_entry_alloc kernel/bpf/cpumap.c:359 [inline]
> >  cpu_map_update_elem+0x3c3/0x8e0 kernel/bpf/cpumap.c:490
> >  map_update_elem kernel/bpf/syscall.c:698 [inline]
> 
> Blame the BPF people, not the MM people ;-)

Yes. kvmalloc (the vmalloc part) doesn't support GFP_ATOMIC semantic.
-- 
Michal Hocko
SUSE Labs
