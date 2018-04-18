Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeDRVRC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:17:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36110 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeDRVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:16:59 -0400
X-Google-Smtp-Source: AIpwx4+F6hGtJA9GDXCdsjKpT4CIzE/Hi0oeWFgsVnjoxOVIwuocAWGqLTfBQlEmYCOHi/BXS1uBXg==
Subject: Re: WARNING: suspicious RCU usage in fib6_info_alloc
To: David Ahern <dsahern@gmail.com>,
        syzbot <syzbot+2add39b05179b31f912f@syzkaller.appspotmail.com>,
        christian.brauner@ubuntu.com, davem@davemloft.net, fw@strlen.de,
        jbenc@redhat.com, ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, mschiffer@universe-factory.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
References: <0000000000004366bc056a25c4f3@google.com>
 <3096e146-ee1d-d3f8-e900-8aa70cb54d00@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9d36c34f-c71f-5c97-0183-9d6da993e877@gmail.com>
Date: Wed, 18 Apr 2018 14:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3096e146-ee1d-d3f8-e900-8aa70cb54d00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2018 02:04 PM, David Ahern wrote:
> On 4/18/18 3:02 PM, syzbot wrote:
>> stack backtrace:
>> CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 4.16.0+ #5
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Workqueue: ipv6_addrconf addrconf_dad_work
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4592
>>  ___might_sleep+0x2e7/0x320 kernel/sched/core.c:6153
>>  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
>>  slab_pre_alloc_hook mm/slab.h:421 [inline]
>>  slab_alloc mm/slab.c:3378 [inline]
>>  kmem_cache_alloc_trace+0x2bc/0x780 mm/slab.c:3618
>>  kmalloc include/linux/slab.h:512 [inline]
>>  kzalloc include/linux/slab.h:701 [inline]
>>  fib6_info_alloc+0xbb/0x280 net/ipv6/ip6_fib.c:152
>>  ip6_route_info_create+0x7bf/0x3240 net/ipv6/route.c:2891
>>  ip6_route_add+0x23/0xb0 net/ipv6/route.c:3030
>>  addrconf_prefix_route.isra.47+0x4f7/0x6f0 net/ipv6/addrconf.c:2347
>>  __ipv6_ifa_notify+0x591/0xa00 net/ipv6/addrconf.c:5620
> 
> Eric is faster than the robot ;-)

Not really ;)

> 
> Patch is queued up; will send later today.
> 

David, I simply looked at the report before allowing the bot to send it ;)

I determined the bug was added recently, and warned you about it.

Thanks !
