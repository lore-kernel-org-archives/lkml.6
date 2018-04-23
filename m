Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755565AbeDWPKK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:10:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40188 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755435AbeDWPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:10:06 -0400
X-Google-Smtp-Source: AIpwx4/yMRH+8R2qoIosFvkaQjuwVRHAgIG+MMQ+1xhZsR2Grx2ASblX0cDAW+c9wdpfJj85UqaJXA==
Subject: Re: WARNING: suspicious RCU usage in rt6_check_expired
To: Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+2422c9e35796659d2273@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009f23ab056a7fc243@google.com>
 <a0eb8d30-0f76-fad2-e9fa-5de92f59b2ff@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <a73fcd37-b8f9-a340-7874-e83350b61879@gmail.com>
Date: Mon, 23 Apr 2018 09:10:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a0eb8d30-0f76-fad2-e9fa-5de92f59b2ff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/18 7:31 AM, Eric Dumazet wrote:
>> stack backtrace:
>> CPU: 1 PID: 25958 Comm: syz-executor7 Not tainted 4.16.0+ #11
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4592
>>  rt6_check_expired+0x38b/0x3e0 net/ipv6/route.c:410
>>  ip6_negative_advice+0x67/0xc0 net/ipv6/route.c:2204
>>  dst_negative_advice include/net/sock.h:1786 [inline]
>>  sock_setsockopt+0x138f/0x1fe0 net/core/sock.c:1051
>>  __sys_setsockopt+0x2df/0x390 net/socket.c:1899
>>  SYSC_setsockopt net/socket.c:1914 [inline]
>>  SyS_setsockopt+0x34/0x50 net/socket.c:1911
>>  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7

...

> 
> Added in commit a68886a691804d3f6d479ebf6825480fbafb6a00
> ("net/ipv6: Make from in rt6_info rcu protected")
> 

I missed the rcu_read_lock for this path. Will send a patch.
