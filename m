Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967551AbeBNLrq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:47:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967360AbeBNLrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:47:45 -0500
Subject: Re: WARNING in kvmalloc_node
To: Daniel Borkmann <daniel@iogearbox.net>,
        Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dhowells@redhat.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@kernel.org,
        rppt@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        brouer@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <001a1144c4ca5dc9d6056520c7b7@google.com>
 <20180214025533.GA28811@bombadil.infradead.org>
 <20180214084308.GX3443@dhcp22.suse.cz>
 <f3fda93e-b223-3c94-3213-43cad4346716@iogearbox.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <24351362-a099-3317-2b96-8cdc6835eb1e@redhat.com>
Date: Wed, 14 Feb 2018 19:47:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f3fda93e-b223-3c94-3213-43cad4346716@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月14日 17:28, Daniel Borkmann wrote:
> [ +Jason, +Jesper ]
>
> On 02/14/2018 09:43 AM, Michal Hocko wrote:
>> On Tue 13-02-18 18:55:33, Matthew Wilcox wrote:
>>> On Tue, Feb 13, 2018 at 03:59:01PM -0800, syzbot wrote:
>> [...]
>>>>   kvmalloc include/linux/mm.h:541 [inline]
>>>>   kvmalloc_array include/linux/mm.h:557 [inline]
>>>>   __ptr_ring_init_queue_alloc include/linux/ptr_ring.h:474 [inline]
>>>>   ptr_ring_init include/linux/ptr_ring.h:492 [inline]
>>>>   __cpu_map_entry_alloc kernel/bpf/cpumap.c:359 [inline]
>>>>   cpu_map_update_elem+0x3c3/0x8e0 kernel/bpf/cpumap.c:490
>>>>   map_update_elem kernel/bpf/syscall.c:698 [inline]
>>> Blame the BPF people, not the MM people ;-)
> Heh, not really. ;-)
>
>> Yes. kvmalloc (the vmalloc part) doesn't support GFP_ATOMIC semantic.
> Agree, that doesn't work.
>
> Bug was added in commit 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails").
>
> Jason, please take a look at fixing this, thanks!

It looks to me the only solution is to revert that commit.

Will post a patch.

Thanks
