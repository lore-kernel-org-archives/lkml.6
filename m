Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326259-2-18056143206966345734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326258; b=Cku/ir1QMDW9hj43rtw3Yiwbpig4NHk3bsrT4E01qStCi+w
    TCpDb7ZZLDDVvqzWapOvVc1/Aostr2IlB00o+RwAxQ2Jfo5rkF6uYNUx4tjmS/Pw
    f/EyXPJcD3tdzbgL+bUSQOb+9lDOYTgpaZFgXEs7TPCppI8znrqdzQe9IpCOK2tg
    8vIxvWNFnCceK+ILQ1i9zstnwN9UKCfcfg5rIlYYWafO9JDVz2pXoXhuyNMuUaz7
    DoKUPcrS7Mgd4niOmOKe4N0AA6LI1dbTptCWPnwWstfJKXzxCrP/ob6oeZtmTiX5
    G2yxwGEEARYizDJwJP77gj/XmziyqmC8WBaM0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326258; bh=rlcBzeJdX+0T2jrB+gB
    32fbwG7AdVug1isCBI0EibQ0=; b=IHR46I1M5huEQ6NyjKxJ57ipwRqCUXLMp9h
    ePigMn+tL4s1NhhuU3F8ZyD47fy5Zo1QQn/K18HbeKhiNTHonUD1+GR08I37ie/8
    usSnQxM2XMltbvRU0EfkjcOq0eNWfXkN86YpCzczJdz8flBxsBoFWsduy2sZM0Ix
    pfTTAtBNcXZ25mGWYGv7r9s4oTASjTlpBng6jIiFGIZZp5jtE99Jg7sOvoG7ddxB
    rE3s/s5vKXJ7dNPDDEScd2unJ8/ZGeWi7FijHvkojh9j7/srfdD9REJbAbGl3z4u
    VkPc+OtnrJadOZ87YlWFE6jHYh/xjeaRelemeVX8yxJ4/iQlAZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeBKFRf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:17:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41357 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752575AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tom Parkin" <tparkin@katalix.com>,
        "David S. Miller" <davem@davemloft.net>,
        "James Chapman" <jchapman@katalix.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.819702711@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 16/79] l2tp: push all ppp pseudowire shutdown through
 .release handler
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Parkin <tparkin@katalix.com>

commit cf2f5c886a209377daefd5d2ba0bcd49c3887813 upstream.

If userspace deletes a ppp pseudowire using the netlink API, either by
directly deleting the session or by deleting the tunnel that contains the
session, we need to tear down the corresponding pppox channel.

Rather than trying to manage two pppox unbind codepaths, switch the netlink
and l2tp_core session_close handlers to close via. the l2tp_ppp socket
.release handler.

Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 53 ++++++++++-------------------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -95,6 +95,7 @@
 #include <net/ip.h>
 #include <net/udp.h>
 #include <net/xfrm.h>
+#include <net/inet_common.h>
 
 #include <asm/byteorder.h>
 #include <linux/atomic.h>
@@ -460,34 +461,16 @@ static void pppol2tp_session_close(struc
 {
 	struct pppol2tp_session *ps = l2tp_session_priv(session);
 	struct sock *sk = ps->sock;
-	struct sk_buff *skb;
+	struct socket *sock = sk->sk_socket;
 
 	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
 
-	if (session->session_id == 0)
-		goto out;
-
-	if (sk != NULL) {
-		lock_sock(sk);
-
-		if (sk->sk_state & (PPPOX_CONNECTED | PPPOX_BOUND)) {
-			pppox_unbind_sock(sk);
-			sk->sk_state = PPPOX_DEAD;
-			sk->sk_state_change(sk);
-		}
-
-		/* Purge any queued data */
-		skb_queue_purge(&sk->sk_receive_queue);
-		skb_queue_purge(&sk->sk_write_queue);
-		while ((skb = skb_dequeue(&session->reorder_q))) {
-			kfree_skb(skb);
-			sock_put(sk);
-		}
 
-		release_sock(sk);
+	if (sock) {
+		inet_shutdown(sock, 2);
+		/* Don't let the session go away before our socket does */
+		l2tp_session_inc_refcount(session);
 	}
-
-out:
 	return;
 }
 
@@ -538,16 +521,12 @@ static int pppol2tp_release(struct socke
 	session = pppol2tp_sock_to_session(sk);
 
 	/* Purge any queued data */
-	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
 	if (session != NULL) {
-		struct sk_buff *skb;
-		while ((skb = skb_dequeue(&session->reorder_q))) {
-			kfree_skb(skb);
-			sock_put(sk);
-		}
+		l2tp_session_queue_purge(session);
 		sock_put(sk);
 	}
+	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_write_queue);
 
 	release_sock(sk);
 
@@ -872,18 +851,6 @@ out:
 	return error;
 }
 
-/* Called when deleting sessions via the netlink interface.
- */
-static int pppol2tp_session_delete(struct l2tp_session *session)
-{
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-
-	if (ps->sock == NULL)
-		l2tp_session_dec_refcount(session);
-
-	return 0;
-}
-
 #endif /* CONFIG_L2TP_V3 */
 
 /* getname() support.
@@ -1801,7 +1768,7 @@ static const struct pppox_proto pppol2tp
 
 static const struct l2tp_nl_cmd_ops pppol2tp_nl_cmd_ops = {
 	.session_create	= pppol2tp_session_create,
-	.session_delete	= pppol2tp_session_delete,
+	.session_delete	= l2tp_session_delete,
 };
 
 #endif /* CONFIG_L2TP_V3 */
