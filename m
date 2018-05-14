Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280815-2-2179409913402804909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280814; b=iVbQaIwnu9pjGQwxG93FW+0+1ekX4W3IZr4DSaVvY1Bb3oF8Ot
    NJzkFkVTTYmD9A/6RI+B/rhlZ8DSakN8Qm4lMyfT7whg1y5f5gshUN68IqK2WIx5
    Nt32TNF48DmDfCOydK51VXi2EDPf8gwg4zWH5u51ntRx1M3ZMXLztiXOiWCKiPsa
    87G+FlPefUJQXy9sWuOaHhOFUOtDf4NQOHXpfUI75P2E1kjmOuglsbRiULEd+Ja5
    oWx7FzvRRlgp58iQMJtAn6JNCgnQheqwVE8mSGFXv5Ul2IiEgYe6FmhXkuX+DauX
    CoUPbG99cBtjHeov4pUxKes5O0H+WD/Z8Guw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526280814; bh=mfDGVyRgc+tJzRxPuepTEv8PL0StRZ
    q9JsdiGX2I59Q=; b=BX9kBUYWnRVXslAHkJ9SHWScFHz6P7YGGCJY+tDy7m3NEc
    Z6hL0t8r1WTs9raxTD3y/Al2djEXWcgsaI+iuKxs8PhN1b8CMRqsgXzG5V4jFRP5
    zbKEK/ACnZL/nv8CpfSwrHSbiA6AS33rCslbV68WOArFIlvOWVSrZbHE2ZW5UmfD
    X50xlwuGNkw3e4AIg0ugtfT8B28si9PXy4UgEUimhgeEALjIQNwPpalwM/dyYYf/
    8bMi/nNs5w6R/XEPe99rFXHVwn4O+TBC6YVbzFqzUJbt6oW5cBQx5B2+HwWlCP6X
    VqkgVIONNlOiE/UeVi9Zo7sEoljRaQIe7Ikuk8jg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EbGIjatS x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=EbGIjatS x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfE0iPHiwx8z6W/rHA8HAH/j1SHgpuQnntA/61ZNXrmevGA+XOcP6dHo9mqe6QFJoss+1wu554uWpZhkhqbA8YnelkVuAsKPXMVeIN9+9OM7vyRoLVAAC
    OjKK9mC85xtC36IORiQlNXzYQ+lXvkk4RiWNgJL2wCwE5wAzzqh858BjS7omkdsVTnhglcUlr+3+LRem/pMULslgTwZ/FyjO2pnz5OTuUaSfT+s1GXDRCBDU
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=AaPt5mWiS82UEVLK3LQA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeENGx3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbeENGxW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:53:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 37/56] dccp: initialize ireq->ir_mark
Date: Mon, 14 May 2018 08:48:42 +0200
Message-Id: <20180514064758.326853590@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b855ff827476adbdc2259e9895681d82b7b26065 upstream.

syzbot reported an uninit-value read of skb->mark in iptable_mangle_hook()

Thanks to the nice report, I tracked the problem to dccp not caring
of ireq->ir_mark for passive sessions.

BUG: KMSAN: uninit-value in ipt_mangle_out net/ipv4/netfilter/iptable_mangle.c:66 [inline]
BUG: KMSAN: uninit-value in iptable_mangle_hook+0x5e5/0x720 net/ipv4/netfilter/iptable_mangle.c:84
CPU: 0 PID: 5300 Comm: syz-executor3 Not tainted 4.16.0+ #81
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 ipt_mangle_out net/ipv4/netfilter/iptable_mangle.c:66 [inline]
 iptable_mangle_hook+0x5e5/0x720 net/ipv4/netfilter/iptable_mangle.c:84
 nf_hook_entry_hookfn include/linux/netfilter.h:120 [inline]
 nf_hook_slow+0x158/0x3d0 net/netfilter/core.c:483
 nf_hook include/linux/netfilter.h:243 [inline]
 __ip_local_out net/ipv4/ip_output.c:113 [inline]
 ip_local_out net/ipv4/ip_output.c:122 [inline]
 ip_queue_xmit+0x1d21/0x21c0 net/ipv4/ip_output.c:504
 dccp_transmit_skb+0x15eb/0x1900 net/dccp/output.c:142
 dccp_xmit_packet+0x814/0x9e0 net/dccp/output.c:281
 dccp_write_xmit+0x20f/0x480 net/dccp/output.c:363
 dccp_sendmsg+0x12ca/0x12d0 net/dccp/proto.c:818
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
 __sys_sendmsg net/socket.c:2080 [inline]
 SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
 SyS_sendmsg+0x54/0x80 net/socket.c:2087
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x455259
RSP: 002b:00007f1a4473dc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1a4473e6d4 RCX: 0000000000455259
RDX: 0000000000000000 RSI: 0000000020b76fc8 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004f0 R14: 00000000006fa720 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
 __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
 ip_queue_xmit+0x1e35/0x21c0 net/ipv4/ip_output.c:502
 dccp_transmit_skb+0x15eb/0x1900 net/dccp/output.c:142
 dccp_xmit_packet+0x814/0x9e0 net/dccp/output.c:281
 dccp_write_xmit+0x20f/0x480 net/dccp/output.c:363
 dccp_sendmsg+0x12ca/0x12d0 net/dccp/proto.c:818
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
 __sys_sendmsg net/socket.c:2080 [inline]
 SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
 SyS_sendmsg+0x54/0x80 net/socket.c:2087
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
 __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
 inet_csk_clone_lock+0x503/0x580 net/ipv4/inet_connection_sock.c:797
 dccp_create_openreq_child+0x7f/0x890 net/dccp/minisocks.c:92
 dccp_v4_request_recv_sock+0x22c/0xe90 net/dccp/ipv4.c:408
 dccp_v6_request_recv_sock+0x290/0x2000 net/dccp/ipv6.c:414
 dccp_check_req+0x7b9/0x8f0 net/dccp/minisocks.c:197
 dccp_v4_rcv+0x12e4/0x2630 net/dccp/ipv4.c:840
 ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
 dst_input include/net/dst.h:449 [inline]
 ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
 __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 process_backlog+0x62d/0xe20 net/core/dev.c:5307
 napi_poll net/core/dev.c:5705 [inline]
 net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
 __do_softirq+0x56d/0x93d kernel/softirq.c:285
Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmem_cache_alloc+0xaab/0xb90 mm/slub.c:2756
 reqsk_alloc include/net/request_sock.h:88 [inline]
 inet_reqsk_alloc+0xc4/0x7f0 net/ipv4/tcp_input.c:6145
 dccp_v4_conn_request+0x5cc/0x1770 net/dccp/ipv4.c:600
 dccp_v6_conn_request+0x299/0x1880 net/dccp/ipv6.c:317
 dccp_rcv_state_process+0x2ea/0x2410 net/dccp/input.c:612
 dccp_v4_do_rcv+0x229/0x340 net/dccp/ipv4.c:682
 dccp_v6_do_rcv+0x16d/0x1220 net/dccp/ipv6.c:578
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __sk_receive_skb+0x60e/0xf20 net/core/sock.c:513
 dccp_v4_rcv+0x24d4/0x2630 net/dccp/ipv4.c:874
 ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
 dst_input include/net/dst.h:449 [inline]
 ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
 __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 process_backlog+0x62d/0xe20 net/core/dev.c:5307
 napi_poll net/core/dev.c:5705 [inline]
 net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
 __do_softirq+0x56d/0x93d kernel/softirq.c:285

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dccp/ipv4.c |    1 +
 net/dccp/ipv6.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -618,6 +618,7 @@ int dccp_v4_conn_request(struct sock *sk
 	ireq = inet_rsk(req);
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
+	ireq->ir_mark = inet_request_mark(sk, skb);
 	ireq->ireq_family = AF_INET;
 	ireq->ir_iif = sk->sk_bound_dev_if;
 
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -345,6 +345,7 @@ static int dccp_v6_conn_request(struct s
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	ireq->ireq_family = AF_INET6;
+	ireq->ir_mark = inet_request_mark(sk, skb);
 
 	if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
