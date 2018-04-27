Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840873-2-7881659347222146348
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
    1524840872; b=ICq9jg2ffuc/HzF02SMsf2qQ46YDLZqKHQ7V6ywf86F5KewQh3
    xXEYqzS/C+wNGsw3VLmxPv6EYXdTWOooMHn8kHJcUkxhmHw1EemGJIYFI2uDAM4x
    zoYI+ydG5JnNKUzlf1xGObEaftocZBlJ8nDMLDtmaJMv3xtj4eqQ2FOHNRwQ3juW
    hznctndNx+gtCyw5G7VuExwyPFLBO+EJScBGGOmq6VHsLHr0Lydk3bu/d4j8w4Lb
    Zv8hpVTauz+AqiBMo8r0o0Xjyg+ZudDqPULrd6oCGsWbOrdmdDmtrcSIq+w2j8o6
    sZgOtLBTGmM4VnyUuIhflotB4QqGkl8Dkx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840872; bh=uQOYyHi926NXbhHe2E5hlW+JRAwUgy
    p7dhmpcjsG6F0=; b=HLMcMWPpCBp7YOZBmSSkxwuV4kN6TZATqCxOg7Z3grqc+N
    9wnvL07QFucEU+WzXeuONghc6j3ptlOrynqYDA2M5h/fS6KvcH+qPbLanSNyQK/O
    kZ+BME9fhZJ56X0ZLbYMCmXxa2DwnvYJaKhWwRlXswBMGs4FMUpta4BWrhh5ZxWG
    nfPHurHI48EqwZwUAKW3ti+2PrnkTSG4LnqruI7gUgXarxRlYBU8CdIIts4O+7nq
    vuxic1FI+8SxYAKRQy7zdtNjoDrsMYRky0AOSCP1P7+nNeShqk/L/JLMZ0RK1/Rb
    ucvY9PlNAGg9+ZV95aKivgYcEay7LptV0o75qDFg==
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
X-CM-Envelope: MS4wfOMr1lTW5P/ToQrudVQbemPIEvClZx+omIznRac5uqW9gFKPBGVb6a/jWFKj8mDNNA3nXfZyp7lAFoyE19r+PXJlCBgR48BpIS8VHU4M2V7UYmXadDPu
    1bhc4ioSgeUQCcTywatJzbUzWCrBQQH5V22h12A+rfFkVyO/ylyEMK1gSJQz9VunA6ublFAz8O5iM37vVVUuZ7E+8tocghJOFk+Jds1Xk8H12rSLTrGcKrjo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=RwcygAIasFXKqbgU6yQA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934178AbeD0OGr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933854AbeD0OGp (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:06:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED0921890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 25/80] vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi
Date: Fri, 27 Apr 2018 15:58:18 +0200
Message-Id: <20180427135734.236387567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>


[ Upstream commit 7ce2367254e84753bceb07327aaf5c953cfce117 ]

Syzkaller spotted an old bug which leads to reading skb beyond tail by 4
bytes on vlan tagged packets.
This is caused because skb_vlan_tagged_multi() did not check
skb_headlen.

BUG: KMSAN: uninit-value in eth_type_vlan include/linux/if_vlan.h:283 [inline]
BUG: KMSAN: uninit-value in skb_vlan_tagged_multi include/linux/if_vlan.h:656 [inline]
BUG: KMSAN: uninit-value in vlan_features_check include/linux/if_vlan.h:672 [inline]
BUG: KMSAN: uninit-value in dflt_features_check net/core/dev.c:2949 [inline]
BUG: KMSAN: uninit-value in netif_skb_features+0xd1b/0xdc0 net/core/dev.c:3009
CPU: 1 PID: 3582 Comm: syzkaller435149 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  eth_type_vlan include/linux/if_vlan.h:283 [inline]
  skb_vlan_tagged_multi include/linux/if_vlan.h:656 [inline]
  vlan_features_check include/linux/if_vlan.h:672 [inline]
  dflt_features_check net/core/dev.c:2949 [inline]
  netif_skb_features+0xd1b/0xdc0 net/core/dev.c:3009
  validate_xmit_skb+0x89/0x1320 net/core/dev.c:3084
  __dev_queue_xmit+0x1cb2/0x2b60 net/core/dev.c:3549
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x7c57/0x8a10 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43ffa9
RSP: 002b:00007fff2cff3948 EFLAGS: 00000217 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043ffa9
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018d0
R13: 0000000000401960 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
  packet_snd net/packet/af_packet.c:2894 [inline]
  packet_sendmsg+0x6444/0x8a10 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 58e998c6d239 ("offloading: Force software GSO for multiple vlan tags.")
Reported-and-tested-by: syzbot+0bbe42c764feafa82c5a@syzkaller.appspotmail.com
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/if_vlan.h |    7 +++++--
 net/core/dev.c          |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -584,7 +584,7 @@ static inline bool skb_vlan_tagged(const
  * Returns true if the skb is tagged with multiple vlan headers, regardless
  * of whether it is hardware accelerated or not.
  */
-static inline bool skb_vlan_tagged_multi(const struct sk_buff *skb)
+static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
 {
 	__be16 protocol = skb->protocol;
 
@@ -594,6 +594,9 @@ static inline bool skb_vlan_tagged_multi
 		if (likely(!eth_type_vlan(protocol)))
 			return false;
 
+		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN)))
+			return false;
+
 		veh = (struct vlan_ethhdr *)skb->data;
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
@@ -611,7 +614,7 @@ static inline bool skb_vlan_tagged_multi
  *
  * Returns features without unsafe ones if the skb has multiple tags.
  */
-static inline netdev_features_t vlan_features_check(const struct sk_buff *skb,
+static inline netdev_features_t vlan_features_check(struct sk_buff *skb,
 						    netdev_features_t features)
 {
 	if (skb_vlan_tagged_multi(skb)) {
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2903,7 +2903,7 @@ netdev_features_t passthru_features_chec
 }
 EXPORT_SYMBOL(passthru_features_check);
 
-static netdev_features_t dflt_features_check(const struct sk_buff *skb,
+static netdev_features_t dflt_features_check(struct sk_buff *skb,
 					     struct net_device *dev,
 					     netdev_features_t features)
 {
