Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523021156-2-17269062920259217540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021156; b=EbjaI88r31qdpaTjyO9zIqIvCtAeOtDSjar/swvVg5w61P38Y0
    M2lIUeHEEH3sINRHb4dMHggGbd4vUGgEneTZdOteA7p/A+qhbl1RqrLhOmplWHix
    WOC3cUvYVH93/vVZr2awmSuoHSl863iFXBjZujZY3vle0LPN6oMeb0XAiBMDlFpW
    Pd2fUJLaF7vjJP+YpLTWUYQjJRHuR978vvp4a2DZSIpOTmZ3ofLta6VGQwBZNQUm
    DCB5eUpuxCNlsb0va32xFlX46wpgIPmzCutR8bzgwB7DdtlAdznW0ZhY8/wWRm2K
    ooA9o4Hl8tQ0F5hTRGK9sCksApxkCn6JXtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021156; bh=HWjUdLJmq44QFWdnX2ScmK++hl29Yk
    2YytimFqfa4Ok=; b=YID/9foS8xvpaXbEKYxnZx8idKMe3n7FQx18wmHBvjQYT0
    savibM+O3+t6bgJLhwYHG50FW1w42WOgjPNTnffn7SjI+4hDxepZq7VFg9SiZEzn
    HnCCTdQPdeom/FtPDI1gzEf+hvAy6R+nuw7KYII/5rNDWtXjHr76QSkDfTj7vGEM
    x6rl1aGC6QFck/I+9EGdh5pjS+p3gZNTipzDk/vEpmc/UNVqHKq2rPgiYaDdiht6
    KWClhVSMnecu1Py/sMFumY5PvZdB+xXwMYJAwvFssGcRWTAYHXEQe231E3WslOQU
    +DhC6VaLZJ676A4QUm0iUB4RvISuGB2EKb8KxZeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfINfLdaC4oms/koEwUvKt8cz8vNm59LvBtieQ/elISF4vfgcoZQqQwwfuJ6lcWwb3DwkK7JNGySK7m8wib+UCgLT+/QLA9JClzSHMMx4hdvqBr1PwNKL
    r9S75f+icOG5MEntHv+aWdhuJbgu98jvzq4P9j06oil3CilOHFC7NrAy4eR7+ifGvXngP9y2cozuHb+EIddZVXOlbqgNZQIl+C6PnQR2FGwWkL1j3O0wgqgO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Q69f-633ooQ3naWqEAsA:9 a=6AqQRZUNvAiFguO1:21 a=ENTuEwsGzZSbeU8Z:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeDFNZt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:25:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeDFNZp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:25:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 24/93] ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()
Date: Fri,  6 Apr 2018 15:22:53 +0200
Message-Id: <20180406084226.013323236@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1443,7 +1443,8 @@ static void ndisc_fill_redirect_hdr_opti
 	*(opt++) = (rd_len >> 3);
 	opt += 6;
 
-	memcpy(opt, ipv6_hdr(orig_skb), rd_len - 8);
+	skb_copy_bits(orig_skb, skb_network_offset(orig_skb), opt,
+		      rd_len - 8);
 }
 
 void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
