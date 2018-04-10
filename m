Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523400000-2-4145970712250742575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400000; b=OUvY8Yn4RVATTriRM/EE4hzn9+HFot7jFv9ciFZC5m8utJalVm
    wBJZWU42Kg1TRFT8JpoDB8j62tewnW2Es26xAXlbqMUJ5v9qV4cInId2FtbgbF69
    sSQuWmZt7hgWTro+OGbi3ostkEz6eYSjlq5VWSxQ75dH8KNb1gfVhBNmfrqqzl3C
    c5eYWUNH6tHsdcEhyipGKbkIoETqFsmqQXBtlynrYFHY2A0zxsW4kEuEEs3XdVAC
    p3q++lT7BXfq4msHWv7fB1cDe6T3bEAPrSqcID9+4MHCO1F3zlQGtAnsfnIXbwmT
    0ugphkxppJ4T8uWeCWmRuSrA3BKdN37aWDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400000; bh=CKsQ+MN94Nj8BXJgDUtE1fzB74NwlH
    D8d7f8hNYg7Mo=; b=s0ROZYBXQ836XNdQdTO5R/PBqWSug8dA5qW7nDddB6UUI4
    XZ9I7/c0FkHwsYH3KUDyx9K4AMIxe8vbdwx9tgR17GwO4sARTUHmp9J548uIEwk/
    1Li0yrpOuX0m0UrfCNvSLDtnUnqUwfwnm7LlOpmzG0P+NMaq6EdCEVvvBF+ozsIf
    v9EZix1ZLqRgNUgqRMGNkIvqGAsOGKi/a6nwQS44vA16zrwDsGKl6Cc/zXn9HUmR
    ++kya5qekfPhY1g5U9JQKlm+dYonEDFpEYN+l79WvSk0l+MOGt53/B8BauLjfEKp
    7OPNqdXgbJJQmJTa0KsgVfTjEEfuoxKjbUmosokA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBbxGLXTAeolMLps0668Vq+fOdqF7Br7J+o5+qn2PB0idQEegIy/DJ3eosHptAi7LVRE1nPS7BISJYFt5mFhZqffJ2qIqCqb5QAre0DMLUyRR4W0+tRf
    Y3kFMWGDuKc5kBhTvh7j/8VOI4YWW5cSNzjdyLkF8g3Htj+dXWQbu7f1dmyJaal/lE5r7U+BDkxz0+AamPEwp3+3mEVLHoZhlxS2NHiL2dJwAWMvSqzYZso7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=sngVIByJOSkcrifXhUIA:9
    a=I2IH7lHG2eRa3Y_W:21 a=eqOfKsFLac_xMFF5:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeDJWjy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeDJWjx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 106/138] pptp: remove a buggy dst release in pptp_connect()
Date: Wed, 11 Apr 2018 00:24:56 +0200
Message-Id: <20180410212914.531926969@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit bfacfb457b36911a10140b8cb3ce76a74883ac5a ]

Once dst has been cached in socket via sk_setup_caps(),
it is illegal to call ip_rt_put() (or dst_release()),
since sk_setup_caps() did not change dst refcount.

We can still dereference it since we hold socket lock.

Caugth by syzbot :

BUG: KASAN: use-after-free in atomic_dec_return include/asm-generic/atomic-instrumented.h:198 [inline]
BUG: KASAN: use-after-free in dst_release+0x27/0xa0 net/core/dst.c:185
Write of size 4 at addr ffff8801c54dc040 by task syz-executor4/20088

CPU: 1 PID: 20088 Comm: syz-executor4 Not tainted 4.16.0+ #376
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x1a7/0x27d lib/dump_stack.c:53
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23c/0x360 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
 kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
 atomic_dec_return include/asm-generic/atomic-instrumented.h:198 [inline]
 dst_release+0x27/0xa0 net/core/dst.c:185
 sk_dst_set include/net/sock.h:1812 [inline]
 sk_dst_reset include/net/sock.h:1824 [inline]
 sock_setbindtodevice net/core/sock.c:610 [inline]
 sock_setsockopt+0x431/0x1b20 net/core/sock.c:707
 SYSC_setsockopt net/socket.c:1845 [inline]
 SyS_setsockopt+0x2ff/0x360 net/socket.c:1828
 do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4552d9
RSP: 002b:00007f4878126c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f48781276d4 RCX: 00000000004552d9
RDX: 0000000000000019 RSI: 0000000000000001 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000010 R09: 0000000000000000
R10: 00000000200010c0 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000526 R14: 00000000006fac30 R15: 0000000000000000

Allocated by task 20088:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459 [inline]
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
 kmem_cache_alloc+0x12e/0x760 mm/slab.c:3542
 dst_alloc+0x11f/0x1a0 net/core/dst.c:104
 rt_dst_alloc+0xe9/0x540 net/ipv4/route.c:1520
 __mkroute_output net/ipv4/route.c:2265 [inline]
 ip_route_output_key_hash_rcu+0xa49/0x2c60 net/ipv4/route.c:2493
 ip_route_output_key_hash+0x20b/0x370 net/ipv4/route.c:2322
 __ip_route_output_key include/net/route.h:126 [inline]
 ip_route_output_flow+0x26/0xa0 net/ipv4/route.c:2577
 ip_route_output_ports include/net/route.h:163 [inline]
 pptp_connect+0xa84/0x1170 drivers/net/ppp/pptp.c:453
 SYSC_connect+0x213/0x4a0 net/socket.c:1639
 SyS_connect+0x24/0x30 net/socket.c:1620
 do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 20082:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
 __cache_free mm/slab.c:3486 [inline]
 kmem_cache_free+0x83/0x2a0 mm/slab.c:3744
 dst_destroy+0x266/0x380 net/core/dst.c:140
 dst_destroy_rcu+0x16/0x20 net/core/dst.c:153
 __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
 rcu_do_batch kernel/rcu/tree.c:2675 [inline]
 invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
 __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
 rcu_process_callbacks+0xd6c/0x17b0 kernel/rcu/tree.c:2914
 __do_softirq+0x2d7/0xb85 kernel/softirq.c:285

The buggy address belongs to the object at ffff8801c54dc000
 which belongs to the cache ip_dst_cache of size 168
The buggy address is located 64 bytes inside of
 168-byte region [ffff8801c54dc000, ffff8801c54dc0a8)
The buggy address belongs to the page:
page:ffffea0007153700 count:1 mapcount:0 mapping:ffff8801c54dc000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801c54dc000 0000000000000000 0000000100000010
raw: ffffea0006b34b20 ffffea0006b6c1e0 ffff8801d674a1c0 0000000000000000
page dumped because: kasan: bad access detected

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pptp.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -464,7 +464,6 @@ static int pptp_connect(struct socket *s
 	po->chan.mtu = dst_mtu(&rt->dst);
 	if (!po->chan.mtu)
 		po->chan.mtu = PPP_MRU;
-	ip_rt_put(rt);
 	po->chan.mtu -= PPTP_HEADER_OVERHEAD;
 
 	po->chan.hdrlen = 2 + sizeof(struct pptp_gre_header);
