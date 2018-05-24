Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156120-2-11154185653910977444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156119; b=Td+swpS8qmLVhVa3FPZzeUf5XWovgm0cA63EXr1A8XwZWuRY5u
    36eTrAii2MArNsCfidVjHMnUzt6geRN6o7qyFRHGA2z1G0+/xHtAupWxpZ2UCZ4j
    MS/ZsiosRg1bT8ie8QORg7PmhuvEA4lAp6Kiegn2Rzxq8hSl7m5HSW8YrkixTyFO
    Wsehv65u850kgJylglEVsDhxLE82jY0k/GuuVEgn76e+mcqP2kAFQeEGDomYghGf
    tq7AIM00JcfVJ6VU7xN0sx0zqUN4nfFqKhBVi1vHBtiaLYj7Soon1BBnVe6XD74M
    a1WKmb+LzQXeMVg8VBjN3P3ge5pBJSHRK4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156119; bh=S9+Ux+XvpDpd0q+WaSWEnXsOhoi9N/
    puml5FzPFyeXc=; b=bTj2vIBFviPuTU/Iny1p8SVyCZ74Q+U8eEKwjRUU9VdEUl
    LG6mIkpY4se9+bvdwFbEsA3DtJG0PSBSHcvFVudv/5w2DuKrZ7wSBzZloU6fdJYd
    t+5ynPQKA38ngD+axBqNryMgwbe1dOrg3eZ28ZN9UffkUEAV5UmDBPMAVcmuYRjQ
    PXGkRt/Q0jdzaM86+J25uJloeaIY4qNu/8FUY+V5tWYAPfTMv9ulXVS2ShJfZ5PW
    DFUgGsH8SNSsXNM7JA1JWqtN95liI467A9D+B7gLEQZGz5MziyRXBvwXvxTs9ioY
    qa3UyxsQcHIBn5oXPKiYCPQFKGhV3LjtCimXfbOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=OBovfHP9 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=OBovfHP9 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEIrxUemhUcU8CFKFcC9ZokaRpHzZ9mL1rG46QUfRX01JYpV3/VxHa4sZd9diLFd/ZrbCaukXtnUUunt5AR9DUIgxHchN5PZXZJynaVFG22uwwbdo/tX
    h501cjsbCPYVJf2I16VK5G7O3UIJwVkg9D+rHbnCByRSWdAM8HRYdfOg3vyBJ81vybLpVV2LeIvGjXHJB8CJRIzJl4NjegFoD96nyrsJYxSfm1MfC6bFuhL3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=d3Y_q1sgordjIHV3K1wA:9 a=XcTEiRlGo-NizCi0:21 a=q5Bf8ntqb4n8o-8A:21
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030996AbeEXKBz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030973AbeEXKBv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 022/161] net: ip6_gre: Request headroom in __gre6_xmit()
Date: Thu, 24 May 2018 11:37:27 +0200
Message-Id: <20180524093020.994916891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 01b8d064d58b4c1f0eff47f8fe8a8508cb3b3840 ]

__gre6_xmit() pushes GRE headers before handing over to ip6_tnl_xmit()
for generic IP-in-IP processing. However it doesn't make sure that there
is enough headroom to push the header to. That can lead to the panic
cited below. (Reproducer below that).

Fix by requesting either needed_headroom if already primed, or just the
bare minimum needed for the header otherwise.

[  158.576725] kernel BUG at net/core/skbuff.c:104!
[  158.581510] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  158.587174] Modules linked in: act_mirred cls_matchall ip6_gre ip6_tunnel tunnel6 gre sch_ingress vrf veth x86_pkg_temp_thermal mlx_platform nfsd e1000e leds_mlxcpld
[  158.602268] CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.17.0-rc4-net_master-custom-139 #10
[  158.610938] Hardware name: Mellanox Technologies Ltd. "MSN2410-CB2F"/"SA000874", BIOS 4.6.5 03/08/2016
[  158.620426] RIP: 0010:skb_panic+0xc3/0x100
[  158.624586] RSP: 0018:ffff8801d3f27110 EFLAGS: 00010286
[  158.629882] RAX: 0000000000000082 RBX: ffff8801c02cc040 RCX: 0000000000000000
[  158.637127] RDX: 0000000000000082 RSI: dffffc0000000000 RDI: ffffed003a7e4e18
[  158.644366] RBP: ffff8801bfec8020 R08: ffffed003aabce19 R09: ffffed003aabce19
[  158.651574] R10: 000000000000000b R11: ffffed003aabce18 R12: ffff8801c364de66
[  158.658786] R13: 000000000000002c R14: 00000000000000c0 R15: ffff8801c364de68
[  158.666007] FS:  0000000000000000(0000) GS:ffff8801d5400000(0000) knlGS:0000000000000000
[  158.674212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.680036] CR2: 00007f4b3702dcd0 CR3: 0000000003228002 CR4: 00000000001606e0
[  158.687228] Call Trace:
[  158.689752]  ? __gre6_xmit+0x246/0xd80 [ip6_gre]
[  158.694475]  ? __gre6_xmit+0x246/0xd80 [ip6_gre]
[  158.699141]  skb_push+0x78/0x90
[  158.702344]  __gre6_xmit+0x246/0xd80 [ip6_gre]
[  158.706872]  ip6gre_tunnel_xmit+0x3bc/0x610 [ip6_gre]
[  158.711992]  ? __gre6_xmit+0xd80/0xd80 [ip6_gre]
[  158.716668]  ? debug_check_no_locks_freed+0x210/0x210
[  158.721761]  ? print_irqtrace_events+0x120/0x120
[  158.726461]  ? sched_clock_cpu+0x18/0x210
[  158.730572]  ? sched_clock_cpu+0x18/0x210
[  158.734692]  ? cyc2ns_read_end+0x10/0x10
[  158.738705]  ? skb_network_protocol+0x76/0x200
[  158.743216]  ? netif_skb_features+0x1b2/0x550
[  158.747648]  dev_hard_start_xmit+0x137/0x770
[  158.752010]  sch_direct_xmit+0x2ef/0x5d0
[  158.755992]  ? pfifo_fast_dequeue+0x3fa/0x670
[  158.760460]  ? pfifo_fast_change_tx_queue_len+0x810/0x810
[  158.765975]  ? __lock_is_held+0xa0/0x160
[  158.770002]  __qdisc_run+0x39e/0xfc0
[  158.773673]  ? _raw_spin_unlock+0x29/0x40
[  158.777781]  ? pfifo_fast_enqueue+0x24b/0x3e0
[  158.782191]  ? sch_direct_xmit+0x5d0/0x5d0
[  158.786372]  ? pfifo_fast_dequeue+0x670/0x670
[  158.790818]  ? __dev_queue_xmit+0x172/0x1770
[  158.795195]  ? preempt_count_sub+0xf/0xd0
[  158.799313]  __dev_queue_xmit+0x410/0x1770
[  158.803512]  ? ___slab_alloc+0x605/0x930
[  158.807525]  ? ___slab_alloc+0x605/0x930
[  158.811540]  ? memcpy+0x34/0x50
[  158.814768]  ? netdev_pick_tx+0x1c0/0x1c0
[  158.818895]  ? __skb_clone+0x2fd/0x3d0
[  158.822712]  ? __copy_skb_header+0x270/0x270
[  158.827079]  ? rcu_read_lock_sched_held+0x93/0xa0
[  158.831903]  ? kmem_cache_alloc+0x344/0x4d0
[  158.836199]  ? skb_clone+0x123/0x230
[  158.839869]  ? skb_split+0x820/0x820
[  158.843521]  ? tcf_mirred+0x554/0x930 [act_mirred]
[  158.848407]  tcf_mirred+0x554/0x930 [act_mirred]
[  158.853104]  ? tcf_mirred_act_wants_ingress.part.2+0x10/0x10 [act_mirred]
[  158.860005]  ? __lock_acquire+0x706/0x26e0
[  158.864162]  ? mark_lock+0x13d/0xb40
[  158.867832]  tcf_action_exec+0xcf/0x2a0
[  158.871736]  tcf_classify+0xfa/0x340
[  158.875402]  __netif_receive_skb_core+0x8e1/0x1c60
[  158.880334]  ? nf_ingress+0x500/0x500
[  158.884059]  ? process_backlog+0x347/0x4b0
[  158.888241]  ? lock_acquire+0xd8/0x320
[  158.892050]  ? process_backlog+0x1b6/0x4b0
[  158.896228]  ? process_backlog+0xc2/0x4b0
[  158.900291]  process_backlog+0xc2/0x4b0
[  158.904210]  net_rx_action+0x5cc/0x980
[  158.908047]  ? napi_complete_done+0x2c0/0x2c0
[  158.912525]  ? rcu_read_unlock+0x80/0x80
[  158.916534]  ? __lock_is_held+0x34/0x160
[  158.920541]  __do_softirq+0x1d4/0x9d2
[  158.924308]  ? trace_event_raw_event_irq_handler_exit+0x140/0x140
[  158.930515]  run_ksoftirqd+0x1d/0x40
[  158.934152]  smpboot_thread_fn+0x32b/0x690
[  158.938299]  ? sort_range+0x20/0x20
[  158.941842]  ? preempt_count_sub+0xf/0xd0
[  158.945940]  ? schedule+0x5b/0x140
[  158.949412]  kthread+0x206/0x300
[  158.952689]  ? sort_range+0x20/0x20
[  158.956249]  ? kthread_stop+0x570/0x570
[  158.960164]  ret_from_fork+0x3a/0x50
[  158.963823] Code: 14 3e ff 8b 4b 78 55 4d 89 f9 41 56 41 55 48 c7 c7 a0 cf db 82 41 54 44 8b 44 24 2c 48 8b 54 24 30 48 8b 74 24 20 e8 16 94 13 ff <0f> 0b 48 c7 c7 60 8e 1f 85 48 83 c4 20 e8 55 ef a6 ff 89 74 24
[  158.983235] RIP: skb_panic+0xc3/0x100 RSP: ffff8801d3f27110
[  158.988935] ---[ end trace 5af56ee845aa6cc8 ]---
[  158.993641] Kernel panic - not syncing: Fatal exception in interrupt
[  159.000176] Kernel Offset: disabled
[  159.003767] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Reproducer:

	ip link add h1 type veth peer name swp1
	ip link add h3 type veth peer name swp3

	ip link set dev h1 up
	ip address add 192.0.2.1/28 dev h1

	ip link add dev vh3 type vrf table 20
	ip link set dev h3 master vh3
	ip link set dev vh3 up
	ip link set dev h3 up

	ip link set dev swp3 up
	ip address add dev swp3 2001:db8:2::1/64

	ip link set dev swp1 up
	tc qdisc add dev swp1 clsact

	ip link add name gt6 type ip6gretap \
		local 2001:db8:2::1 remote 2001:db8:2::2
	ip link set dev gt6 up

	sleep 1

	tc filter add dev swp1 ingress pref 1000 matchall skip_hw \
		action mirred egress mirror dev gt6
	ping -I h1 192.0.2.2

Fixes: c12b395a4664 ("gre: Support GRE over IPv6")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -701,6 +701,9 @@ static netdev_tx_t __gre6_xmit(struct sk
 	if (tunnel->parms.o_flags & TUNNEL_SEQ)
 		tunnel->o_seqno++;
 
+	if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
+		return -ENOMEM;
+
 	/* Push GRE header. */
 	protocol = (dev->type == ARPHRD_ETHER) ? htons(ETH_P_TEB) : proto;
 
