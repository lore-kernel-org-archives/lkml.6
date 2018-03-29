Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346592-2-6769718373263893125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346591; b=sXwLcIh8AIPLBc1eKVGJxqF+Cy+oS0cvfzXjtAdeLL0i2J6yK8
    VTovUw66UIWpHZoUYlVpJs05tM8DMuD2EmdYb7LvWisvHtumNG5Vv3JSJvO/YhNb
    H8crmnqn4pnhfoxYqB/5BGoKl1z2LEyT3ih/Z8WUh1NhS2n/PiOqEkEEj+t1tI1L
    zJf649Td+Rg6ri+Pbcn5oz/J0B4HkABUY0hECeNYJRa6xXj0zELa1JLs9nuJVneN
    mzaBNlMqW/flaeNerCB/WZ8Pkz1jKn0P3wmkSnn9KbV2BblUIH5DDZ3X1GbG6TMf
    D4EgsrxkHL0i21+of1PZ29iU6wY3f8Wz0nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346591; bh=qkZF93w3A1MlL2l2EZfAmgUoXsdVHg
    hiW16tIBhiC28=; b=cobNYBrCCsAYlI4ZjqhKR82gDSTA+0Kmp3QT6cl1h0na4M
    Qd0ljgab2KccCkLxXJBYE6byZPbb1mO8jQq21FFfOYlKxGoRMpybPVswYk0p4K/D
    CsDz6C4Igioz+enY93AOahAUfG09hj3hO43bq7ls2WRQ6e3QrORT2eGUP/7gC8zw
    EPcTS/pUNwPesZfeu3XKF5Uei24t0FSFgWJh3zrsSx/FPTfxSKfuT3vazbkvqC6s
    w/4nFVQ1r/F6g/4R+pvUF5dbHc78cgX0Gsa4fgKhMwNfegr60vAEFGtU1qYdyQLV
    48Kkw9ps82XNgbjOsU8q9an1tV6IQDgXxYWUFU6g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPF0iTtjEJyExWxV+vhcyFyEnuuTvLSgSjaL5KTolTq2gDNx7O7hr9QlGZA7nHuSLxvXggiPtobP16JAyaN3AwKrMPwMgjiptjfOm8XyoAmRgZaMCHU7
    /QzPwa1XQWIaP6bTW1Nxpx6OPCu/nfCd87JbQ7g03R6TAhhurH/cFn1ajOIYs1yIMjuHXJwhLWgWx3IP05T0OI+BRkxqoW3L7ngESGm5UydIZPCqyyXUXbed
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Q69f-633ooQ3naWqEAsA:9 a=j6HlFwJUfunXN1o_:21 a=ENTuEwsGzZSbeU8Z:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeC2SDI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:03:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeC2SDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:03:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 36/47] ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()
Date: Thu, 29 Mar 2018 20:00:17 +0200
Message-Id: <20180329175732.343994159@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>


[ Upstream commit 9f62c15f28b0d1d746734666d88a79f08ba1e43e ]

Fix the following slab-out-of-bounds kasan report in
ndisc_fill_redirect_hdr_option when the incoming ipv6 packet is not
linear and the accessed data are not in the linear data region of orig_skb.

[ 1503.122508] ==================================================================
[ 1503.122832] BUG: KASAN: slab-out-of-bounds in ndisc_send_redirect+0x94e/0x990
[ 1503.123036] Read of size 1184 at addr ffff8800298ab6b0 by task netperf/1932

[ 1503.123220] CPU: 0 PID: 1932 Comm: netperf Not tainted 4.16.0-rc2+ #124
[ 1503.123347] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[ 1503.123527] Call Trace:
[ 1503.123579]  <IRQ>
[ 1503.123638]  print_address_description+0x6e/0x280
[ 1503.123849]  kasan_report+0x233/0x350
[ 1503.123946]  memcpy+0x1f/0x50
[ 1503.124037]  ndisc_send_redirect+0x94e/0x990
[ 1503.125150]  ip6_forward+0x1242/0x13b0
[...]
[ 1503.153890] Allocated by task 1932:
[ 1503.153982]  kasan_kmalloc+0x9f/0xd0
[ 1503.154074]  __kmalloc_track_caller+0xb5/0x160
[ 1503.154198]  __kmalloc_reserve.isra.41+0x24/0x70
[ 1503.154324]  __alloc_skb+0x130/0x3e0
[ 1503.154415]  sctp_packet_transmit+0x21a/0x1810
[ 1503.154533]  sctp_outq_flush+0xc14/0x1db0
[ 1503.154624]  sctp_do_sm+0x34e/0x2740
[ 1503.154715]  sctp_primitive_SEND+0x57/0x70
[ 1503.154807]  sctp_sendmsg+0xaa6/0x1b10
[ 1503.154897]  sock_sendmsg+0x68/0x80
[ 1503.154987]  ___sys_sendmsg+0x431/0x4b0
[ 1503.155078]  __sys_sendmsg+0xa4/0x130
[ 1503.155168]  do_syscall_64+0x171/0x3f0
[ 1503.155259]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[ 1503.155436] Freed by task 1932:
[ 1503.155527]  __kasan_slab_free+0x134/0x180
[ 1503.155618]  kfree+0xbc/0x180
[ 1503.155709]  skb_release_data+0x27f/0x2c0
[ 1503.155800]  consume_skb+0x94/0xe0
[ 1503.155889]  sctp_chunk_put+0x1aa/0x1f0
[ 1503.155979]  sctp_inq_pop+0x2f8/0x6e0
[ 1503.156070]  sctp_assoc_bh_rcv+0x6a/0x230
[ 1503.156164]  sctp_inq_push+0x117/0x150
[ 1503.156255]  sctp_backlog_rcv+0xdf/0x4a0
[ 1503.156346]  __release_sock+0x142/0x250
[ 1503.156436]  release_sock+0x80/0x180
[ 1503.156526]  sctp_sendmsg+0xbb0/0x1b10
[ 1503.156617]  sock_sendmsg+0x68/0x80
[ 1503.156708]  ___sys_sendmsg+0x431/0x4b0
[ 1503.156799]  __sys_sendmsg+0xa4/0x130
[ 1503.156889]  do_syscall_64+0x171/0x3f0
[ 1503.156980]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[ 1503.157158] The buggy address belongs to the object at ffff8800298ab600
                which belongs to the cache kmalloc-1024 of size 1024
[ 1503.157444] The buggy address is located 176 bytes inside of
                1024-byte region [ffff8800298ab600, ffff8800298aba00)
[ 1503.157702] The buggy address belongs to the page:
[ 1503.157820] page:ffffea0000a62a00 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
[ 1503.158053] flags: 0x4000000000008100(slab|head)
[ 1503.158171] raw: 4000000000008100 0000000000000000 0000000000000000 00000001800e000e
[ 1503.158350] raw: dead000000000100 dead000000000200 ffff880036002600 0000000000000000
[ 1503.158523] page dumped because: kasan: bad access detected

[ 1503.158698] Memory state around the buggy address:
[ 1503.158816]  ffff8800298ab900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1503.158988]  ffff8800298ab980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1503.159165] >ffff8800298aba00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1503.159338]                    ^
[ 1503.159436]  ffff8800298aba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1503.159610]  ffff8800298abb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1503.159785] ==================================================================
[ 1503.159964] Disabling lock debugging due to kernel taint

The test scenario to trigger the issue consists of 4 devices:
- H0: data sender, connected to LAN0
- H1: data receiver, connected to LAN1
- GW0 and GW1: routers between LAN0 and LAN1. Both of them have an
  ethernet connection on LAN0 and LAN1
On H{0,1} set GW0 as default gateway while on GW0 set GW1 as next hop for
data from LAN0 to LAN1.
Moreover create an ip6ip6 tunnel between H0 and H1 and send 3 concurrent
data streams (TCP/UDP/SCTP) from H0 to H1 through ip6ip6 tunnel (send
buffer size is set to 16K). While data streams are active flush the route
cache on HA multiple times.
I have not been able to identify a given commit that introduced the issue
since, using the reproducer described above, the kasan report has been
triggered from 4.14 and I have not gone back further.

Reported-by: Jianlin Shi <jishi@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1554,7 +1554,8 @@ static void ndisc_fill_redirect_hdr_opti
 	*(opt++) = (rd_len >> 3);
 	opt += 6;
 
-	memcpy(opt, ipv6_hdr(orig_skb), rd_len - 8);
+	skb_copy_bits(orig_skb, skb_network_offset(orig_skb), opt,
+		      rd_len - 8);
 }
 
 void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
