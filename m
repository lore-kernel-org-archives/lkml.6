Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839637-2-18245293712758452788
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
    1524839636; b=TJcx/EquDFBYwY5GYhEYT6cLwUaTvBs+JGosMnVkvPXw/vz8OV
    F0myoGpjTuUVHWBtFEl0P9LaG0GHBXkrZeESHRt1gJGVKsnVN5yHnH02OdqDsaib
    Vh2AvYtGTAlTMrQGy9t27IC2Bo1pFkmgRlFzl833ahv5X5kiGd86gcxcC3RX+VK0
    KZbLaGMeWijUYIZSd2VjZoMD57Nm/+Z03s/m/3CDsLJaB5Me6c6uQp4aWxQzBxtB
    VQKE+ysmVLIsDLcPa0pdGwwRCCeXyN4Zp4RTq0NcclN7z7VI7KCGwqjoGADhND+T
    4VaxqwOrHVus8kwweATAiJQc+vPV2dt9Sugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839636; bh=VnmZ114VlOC1PDw1QmP9P6IxNCR3vP
    nvAmkeosTSTJ4=; b=eK1kM49u08obZiwYJ9wcqvQkHvXfaNFuNxmeyvmj2kra4f
    PS+klL6WH1foI/Hn0epCuxwHbyhiHjy1dVilG0BWQkWLqGJQCEtB697kGojhpxyB
    DaJsuXzDOTJ2G9Ru8rYw5PLC+pWv229i3Lun+bPqPBV9Lk4FzcTvqCxkNJFNuUJT
    jfKiuxphtz/jo0RPU4dFRGx7naMLjS7ANLhBubevX/KzFFaSHIvTItfXWy7JN0/e
    ep+26RlZEKLcrWUf3usj62U30O2T8TQzlH/Az1lZuIOzBUYKhuCvCtSBgmp05EGl
    4aZQZycCFAzqBJaZyeYV0NtdnuNOWcoxVXqkIsOw==
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
X-CM-Envelope: MS4wfM3SHIChLa5ugoxZ3/e3w9uCuyk+RJ3ZOj8gI9qj/Mu3vzVvRu4rUCDlPkr6koaCwCgZptiJJalkv2P31YiuWTlUJWWp3/ImcgwDcT8EdRc616iVa9+G
    28gc3balZHCiIWa8+QTeV3ReoSvs0w8oZIKR0ETrKrQQMVArio+Zdia0jsSbK7w7Msuva+h+6X5A/AYJTBmub4CKpYs2fO4mxhO+i6DOhty/sNuZ7T/j33fj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=10mExzVmZZiaXDS9G5EA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeD0OKO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OKL (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0321864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, DaeRyong Jeong <threeearcat@gmail.com>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 21/81] packet: fix bitfield update race
Date: Fri, 27 Apr 2018 15:58:23 +0200
Message-Id: <20180427135744.454778445@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>


[ Upstream commit a6361f0ca4b25460f2cdf3235ebe8115f622901e ]

Updates to the bitfields in struct packet_sock are not atomic.
Serialize these read-modify-write cycles.

Move po->running into a separate variable. Its writes are protected by
po->bind_lock (except for one startup case at packet_create). Also
replace a textual precondition warning with lockdep annotation.

All others are set only in packet_setsockopt. Serialize these
updates by holding the socket lock. Analogous to other field updates,
also hold the lock when testing whether a ring is active (pg_vec).

Fixes: 8dc419447415 ("[PACKET]: Add optional checksum computation for recvmsg")
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Reported-by: Byoungyoung Lee <byoungyoung@purdue.edu>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   60 +++++++++++++++++++++++++++++++++++--------------
 net/packet/internal.h  |   10 ++++----
 2 files changed, 49 insertions(+), 21 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -329,11 +329,11 @@ static void packet_pick_tx_queue(struct
 	skb_set_queue_mapping(skb, queue_index);
 }
 
-/* register_prot_hook must be invoked with the po->bind_lock held,
+/* __register_prot_hook must be invoked through register_prot_hook
  * or from a context in which asynchronous accesses to the packet
  * socket is not possible (packet_create()).
  */
-static void register_prot_hook(struct sock *sk)
+static void __register_prot_hook(struct sock *sk)
 {
 	struct packet_sock *po = pkt_sk(sk);
 
@@ -348,8 +348,13 @@ static void register_prot_hook(struct so
 	}
 }
 
-/* {,__}unregister_prot_hook() must be invoked with the po->bind_lock
- * held.   If the sync parameter is true, we will temporarily drop
+static void register_prot_hook(struct sock *sk)
+{
+	lockdep_assert_held_once(&pkt_sk(sk)->bind_lock);
+	__register_prot_hook(sk);
+}
+
+/* If the sync parameter is true, we will temporarily drop
  * the po->bind_lock and do a synchronize_net to make sure no
  * asynchronous packet processing paths still refer to the elements
  * of po->prot_hook.  If the sync parameter is false, it is the
@@ -359,6 +364,8 @@ static void __unregister_prot_hook(struc
 {
 	struct packet_sock *po = pkt_sk(sk);
 
+	lockdep_assert_held_once(&po->bind_lock);
+
 	po->running = 0;
 
 	if (po->fanout)
@@ -3252,7 +3259,7 @@ static int packet_create(struct net *net
 
 	if (proto) {
 		po->prot_hook.type = proto;
-		register_prot_hook(sk);
+		__register_prot_hook(sk);
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
@@ -3734,12 +3741,18 @@ packet_setsockopt(struct socket *sock, i
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
-		po->tp_loss = !!val;
-		return 0;
+
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret = -EBUSY;
+		} else {
+			po->tp_loss = !!val;
+			ret = 0;
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_AUXDATA:
 	{
@@ -3750,7 +3763,9 @@ packet_setsockopt(struct socket *sock, i
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
+		lock_sock(sk);
 		po->auxdata = !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3762,7 +3777,9 @@ packet_setsockopt(struct socket *sock, i
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
+		lock_sock(sk);
 		po->origdev = !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3771,15 +3788,20 @@ packet_setsockopt(struct socket *sock, i
 
 		if (sock->type != SOCK_RAW)
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (optlen < sizeof(val))
 			return -EINVAL;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		po->has_vnet_hdr = !!val;
-		return 0;
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret = -EBUSY;
+		} else {
+			po->has_vnet_hdr = !!val;
+			ret = 0;
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_TIMESTAMP:
 	{
@@ -3817,11 +3839,17 @@ packet_setsockopt(struct socket *sock, i
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
-		po->tp_tx_has_off = !!val;
+
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret = -EBUSY;
+		} else {
+			po->tp_tx_has_off = !!val;
+			ret = 0;
+		}
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_QDISC_BYPASS:
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -112,10 +112,12 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
-	unsigned int		running:1,	/* prot_hook is attached*/
-				auxdata:1,
+	unsigned int		running;	/* bind_lock must be held */
+	unsigned int		auxdata:1,	/* writer must hold sock lock */
 				origdev:1,
-				has_vnet_hdr:1;
+				has_vnet_hdr:1,
+				tp_loss:1,
+				tp_tx_has_off:1;
 	int			pressure;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
@@ -125,8 +127,6 @@ struct packet_sock {
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
-	unsigned int		tp_loss:1;
-	unsigned int		tp_tx_has_off:1;
 	unsigned int		tp_tstamp;
 	struct net_device __rcu	*cached_dev;
 	int			(*xmit)(struct sk_buff *skb);
