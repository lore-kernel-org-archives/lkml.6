Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833919-2-8661143594896844817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833918; b=oyWiVVWF1IlJbjwu3Z9uMYdB/6Za6KG/SluemF6idRH3Q5e
    bYgxM6D1Ciwu45QX1RUZOHye78ngAUG6ZWCs3gEE+j66h2asMAGaewwiuoWo0PFJ
    mO0IWcC00nasWN+UUrwu6n5u/Dndm3B9GpdY5bwrHAH+zW+OlQp5WHYOnNniEOdn
    0WlEMXR+Rpc9aImlKARlNmCQC8Iy3UyfPgywBgNKtbpTF8E0niX3Bk+UpQUYmcF4
    +8V4CgrA4FBG/bBJXc7OsmDSCwkPjPrcdvAXWQK9A5DN3xzQZRj8dGrLESIb1hUc
    mgUmwpwLmblpeb0oTN+XpWP97+nQVQW7boFmXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833918; bh=zvS/b25yPtYxItPjp47
    6mzJ9wscTDFaeUMjr8iAQ5/c=; b=Zw88KE5kYsTV8MjZCrOUMczt3oUp49ONZXl
    XSJVmYEwafVxYhuh3+LNfYdMGPABMG1PxwnDmTWP91kqmCJUSwHbVlcGy2JOahvO
    od0CWo679IVKszzNLaHOEhf5PkMS3xrU3jGEaoFRU8mmFp8G7JEqg8i2pYGuYz7V
    LWLz0LucLWbZ46QAfyXmnSlHiB/9nrku5uzQ0Gdai7NYtdwB/bQeyNm6CNtKYahx
    ArHfIfa3fKprwE7VioePofZhbScuyYpPts3IKng2U+2zEz6PV6w2mitVye5RnXBb
    KuglFlGzC+uliQX69dbFsEp2JDXdGXBRtQupZD0F1Vg3wrlUS6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeB1QFR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34875 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934460AbeB1QFQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Erez Shitrit" <erezsh@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Alex Vesker" <valex@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.812578439@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 156/254] IB/ipoib: Fix race condition in neigh creation
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Erez Shitrit <erezsh@mellanox.com>

commit 16ba3defb8bd01a9464ba4820a487f5b196b455b upstream.

When using enhanced mode for IPoIB, two threads may execute xmit in
parallel to two different TX queues while the target is the same.
In this case, both of them will add the same neighbor to the path's
neigh link list and we might see the following message:

  list_add double add: new=ffff88024767a348, prev=ffff88024767a348...
  WARNING: lib/list_debug.c:31__list_add_valid+0x4e/0x70
  ipoib_start_xmit+0x477/0x680 [ib_ipoib]
  dev_hard_start_xmit+0xb9/0x3e0
  sch_direct_xmit+0xf9/0x250
  __qdisc_run+0x176/0x5d0
  __dev_queue_xmit+0x1f5/0xb10
  __dev_queue_xmit+0x55/0xb10

Analysis:
Two SKB are scheduled to be transmitted from two cores.
In ipoib_start_xmit, both gets NULL when calling ipoib_neigh_get.
Two calls to neigh_add_path are made. One thread takes the spin-lock
and calls ipoib_neigh_alloc which creates the neigh structure,
then (after the __path_find) the neigh is added to the path's neigh
link list. When the second thread enters the critical section it also
calls ipoib_neigh_alloc but in this case it gets the already allocated
ipoib_neigh structure, which is already linked to the path's neigh
link list and adds it again to the list. Which beside of triggering
the list, it creates a loop in the linked list. This loop leads to
endless loop inside path_rec_completion.

Solution:
Check list_empty(&neigh->list) before adding to the list.
Add a similar fix in "ipoib_multicast.c::ipoib_mcast_send"

Fixes: b63b70d87741 ('IPoIB: Use a private hash table for path lookup in xmit path')
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      | 25 ++++++++++++++++++-------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |  5 ++++-
 2 files changed, 22 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -615,8 +615,8 @@ static int path_rec_start(struct net_dev
 	return 0;
 }
 
-static void neigh_add_path(struct sk_buff *skb, u8 *daddr,
-			   struct net_device *dev)
+static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
+					  struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_path *path;
@@ -629,7 +629,15 @@ static void neigh_add_path(struct sk_buf
 		spin_unlock_irqrestore(&priv->lock, flags);
 		++dev->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
-		return;
+		return NULL;
+	}
+
+	/* To avoid race condition, make sure that the
+	 * neigh will be added only once.
+	 */
+	if (unlikely(!list_empty(&neigh->list))) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return neigh;
 	}
 
 	path = __path_find(dev, daddr + 4);
@@ -665,7 +673,7 @@ static void neigh_add_path(struct sk_buf
 			spin_unlock_irqrestore(&priv->lock, flags);
 			ipoib_send(dev, skb, path->ah, IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  = NULL;
@@ -678,7 +686,7 @@ static void neigh_add_path(struct sk_buf
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
 
 err_path:
 	ipoib_neigh_free(neigh);
@@ -688,6 +696,8 @@ err_drop:
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
 
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -784,8 +794,9 @@ static int ipoib_start_xmit(struct sk_bu
 	case htons(ETH_P_TIPC):
 		neigh = ipoib_neigh_get(dev, cb->hwaddr);
 		if (unlikely(!neigh)) {
-			neigh_add_path(skb, cb->hwaddr, dev);
-			return NETDEV_TX_OK;
+			neigh = neigh_add_path(skb, cb->hwaddr, dev);
+			if (likely(!neigh))
+				return NETDEV_TX_OK;
 		}
 		break;
 	case htons(ETH_P_ARP):
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -728,7 +728,10 @@ out:
 		spin_lock_irqsave(&priv->lock, flags);
 		if (!neigh) {
 			neigh = ipoib_neigh_alloc(daddr, dev);
-			if (neigh) {
+			/* Make sure that the neigh will be added only
+			 * once to mcast list.
+			 */
+			if (neigh && list_empty(&neigh->list)) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah	= mcast->ah;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
