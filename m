Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162393-2-10546057066348102001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162392; b=UiOG4mXxiwji2QVj2/L325zm30lvJNGavWZF3NIbridbinpVj3
    OMxr29EobtH243AV2wCigocTwgE2jj0DJ5Gar6/7O6AC2RGtHff3qlrPMXwJt7ii
    fo1NGN7nTnwknBel83uvgOU/2pynUl1eRAONmX5DDd07Lf58N8UDrX40CP7Ke+c6
    qJzKjWI2L8DRYnRxlgaa9sSB4aW/Uh/5NII6oiMO5OYtrMiJZ1oOaNpgDpNrni/u
    GzxdUnMS+b7K3EgAE9Tj2HLpFHFd7jG4hzdFTyk5KQBcPkGeCgz3BD+sPvrvkRZo
    PEBPzWBfHLsCC5T4XBfaYM5VmuZ+8mEoaF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162392; bh=WQq/zLzq2EQ0jSdJiP37sJTzHyjelj
    HrMjloBEm/ezA=; b=Wk16Mey/3s0KBjNXYb4AIUeOumpBGWRmfdpTlZqnNoVV1t
    mHV4CNrq7RIwnNRhRat1MrJy5hO1br32o54lNpyAUqp9GTaqJ/YFZpgpSXpQ9VNX
    qUGtlk3H6RkeO7mW2xA6Rp/7uXNIO5BxQvnJrBLhIfLwCi+v8OHH/OyJ6947BOgR
    jXv5ryhbn3AAeiif5/sEGILzZfk/TJPm/7nj6M36HU1CMwJzpVCODul8LSyC5HZJ
    OnGha9yzrZV1LYlrzBFbypxxncj8TM5hefsVDvWNVgE+BB8vsPGb2sVcS5Dn7FEn
    JYbXu6PkhJ+Ftm7nrAVvMW7s9rMKxHl7yJwpcMLA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NI+OLoJX x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NI+OLoJX x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI4BsZvDRCYsFJqkfqgZX3i6g5MY4qYV01crUynA2enrbJ5zvPVuY6vKlR6kYDZ+smbwHkOHFJaf7oG5KvkIH+DQ3tExAqFygWPQ0vfao2xtRzIPLZpV
    kvaLGnxy4PTwJgKWIoeCxF1s63sXhrI7FKXNsNnHnwyqjLtbjPEvqa/u9NHCAANPe3QrnYOsssz4wVJTn3uyWzJoWxXI85ezfDA5JnwmsiTDel5EzJIZY228
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=QqqX_mwiMbC-zsVjBVcA:9 a=0H1iuUAU-0PhFHOX:21 a=kHhCiEMo-YytB8L6:21
    a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967131AbeEXLqT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967116AbeEXJru (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Craig Gallek <kraig@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 04/96] sock_diag: fix use-after-free read in __sk_free
Date: Thu, 24 May 2018 11:37:47 +0200
Message-Id: <20180524093605.889047107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9709020c86f6bf8439ca3effc58cfca49a5de192 ]

We must not call sock_diag_has_destroy_listeners(sk) on a socket
that has no reference on net structure.

BUG: KASAN: use-after-free in sock_diag_has_destroy_listeners include/linux/sock_diag.h:75 [inline]
BUG: KASAN: use-after-free in __sk_free+0x329/0x340 net/core/sock.c:1609
Read of size 8 at addr ffff88018a02e3a0 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.17.0-rc5+ #54
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
 sock_diag_has_destroy_listeners include/linux/sock_diag.h:75 [inline]
 __sk_free+0x329/0x340 net/core/sock.c:1609
 sk_free+0x42/0x50 net/core/sock.c:1623
 sock_put include/net/sock.h:1664 [inline]
 reqsk_free include/net/request_sock.h:116 [inline]
 reqsk_put include/net/request_sock.h:124 [inline]
 inet_csk_reqsk_queue_drop_and_put net/ipv4/inet_connection_sock.c:672 [inline]
 reqsk_timer_handler+0xe27/0x10e0 net/ipv4/inet_connection_sock.c:739
 call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
 expire_timers kernel/time/timer.c:1363 [inline]
 __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
 run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
 __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
 invoke_softirq kernel/softirq.c:365 [inline]
 irq_exit+0x1d1/0x200 kernel/softirq.c:405
 exiting_irq arch/x86/include/asm/apic.h:525 [inline]
 smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
 </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
RSP: 0018:ffff8801d9ae7c38 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffff1003b35cf8a RCX: 0000000000000000
RDX: 1ffffffff11a30d0 RSI: 0000000000000001 RDI: ffffffff88d18680
RBP: ffff8801d9ae7c38 R08: ffffed003b5e46c3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8801d9ae7cf0 R14: ffffffff897bef20 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
 default_idle+0xc2/0x440 arch/x86/kernel/process.c:354
 arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:345
 default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x395/0x560 kernel/sched/idle.c:262
 cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
 start_secondary+0x426/0x5b0 arch/x86/kernel/smpboot.c:269
 secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

Allocated by task 4557:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
 kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
 kmem_cache_zalloc include/linux/slab.h:691 [inline]
 net_alloc net/core/net_namespace.c:383 [inline]
 copy_net_ns+0x159/0x4c0 net/core/net_namespace.c:423
 create_new_namespaces+0x69d/0x8f0 kernel/nsproxy.c:107
 unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
 ksys_unshare+0x708/0xf90 kernel/fork.c:2408
 __do_sys_unshare kernel/fork.c:2476 [inline]
 __se_sys_unshare kernel/fork.c:2474 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:2474
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 69:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
 net_free net/core/net_namespace.c:399 [inline]
 net_drop_ns.part.14+0x11a/0x130 net/core/net_namespace.c:406
 net_drop_ns net/core/net_namespace.c:405 [inline]
 cleanup_net+0x6a1/0xb20 net/core/net_namespace.c:541
 process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
 worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
 kthread+0x345/0x410 kernel/kthread.c:240
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the object at ffff88018a02c140
 which belongs to the cache net_namespace of size 8832
The buggy address is located 8800 bytes inside of
 8832-byte region [ffff88018a02c140, ffff88018a02e3c0)
The buggy address belongs to the page:
page:ffffea0006280b00 count:1 mapcount:0 mapping:ffff88018a02c140 index:0x0 compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff88018a02c140 0000000000000000 0000000100000001
raw: ffffea00062a1320 ffffea0006268020 ffff8801d9bdde40 0000000000000000
page dumped because: kasan: bad access detected

Fixes: b922622ec6ef ("sock_diag: don't broadcast kernel sockets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Craig Gallek <kraig@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1457,7 +1457,7 @@ void sk_destruct(struct sock *sk)
 
 static void __sk_free(struct sock *sk)
 {
-	if (unlikely(sock_diag_has_destroy_listeners(sk) && sk->sk_net_refcnt))
+	if (unlikely(sk->sk_net_refcnt && sock_diag_has_destroy_listeners(sk)))
 		sock_diag_broadcast_destroy(sk);
 	else
 		sk_destruct(sk);
