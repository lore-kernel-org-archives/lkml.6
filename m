Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992793-1525122354-2-12576127572123554482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525122354; b=Hn+8Z1VIPkOjiyxlF7giEDjsWMDUw1TP1EQ1sqzWqh6Sr/GSde
    4AkVQ8GAxUzmT8sqzQWc85FmAHobMorePHtkRonlMOYChmAKpL+U1e80U93TZT3P
    JbYOYGIy6ov5YOjZHTGawo5b4bnWVdQ9JEIJlo9KVZV4kRkSML5uCJdsirZprjCj
    DWvxOGhxBE+KuVaxX8BGuQ1JR77WOkJZcTNWjn9VxCSZ8G2iOAUO3bCrRBGObuDm
    8jK1qcWJ9W8BOHnihaTenqhHpWiJTJAy/nQxEZmmvKycf0f0A6GINk4bsK5L2I5K
    96jtXGUosUp1eO0GRmyLUpPjb7vObasp+JTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:in-reply-to:references
    :content-type:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525122354; bh=h46RxqpI5+c5mJo9Jt6cch3Esm3jV5x0Xalzd0+s9Iw=; b=
    IDo70aDw5ZDCJ025S7twK+crMfPX0PTi1gl+9WvP81XqkBNQlefB1L/f1Tld/pqC
    aGmELBV4LqNnPFd8zIDJZSzy/d0mTcsdmdneww4vg1NalmmYF6WdK9dTp5s4f45i
    WNY5jkCtLnt4kxlsxyoW5cln0DdPmxT6NUb4wH8bG/EHDPxTbIAGWlRch0d4F+KL
    T3FicayVn/a016nm8n1zaxzEr6xiA1/Iidj2cEsS1DDdVoH+n1jJTGf/p5uzIji9
    bDyfJXN/TMH/sF7fLdvcpUcUXZLXZXdxrN57YboGj0lFk7XUCvliNvf4g8+RVLsF
    UEsperRTbqtpvXrvQukILw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkPNCZwN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkPNCZwN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOIN8P4ldHF149B+BFaduQ65riEO0r/tfgUA0M5UPQsfUVyICY1rP1bvTL117IVbsHGJIOiBR4jF8Wk1Zxsqsd13kotn+tiSgGOcAUv2GqTiC1Vhg3wm
    bLJ95gNDItQrZhDB/RTGbvQa/oYYbBHepoy0zGh3ELJv9p22tjEjaYZviL6wxtI3fjtWw1TzmhyqKPNGD9oiblFI7w8u46MT6VKY1OH3K0UE7Q7Xz0Ry0G5J
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=HO5iXwqbJkv3iYM9twsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755397AbeD3VFa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:05:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48497 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755115AbeD3VDA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:03:00 -0400
X-ME-Sender: <xms:hITnWqzAt8LO92HZ_2wk3gbzLiNcea6ccBd9pjoIocsKI9zD89EMyg>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/6] xen-netfront: copy response out of shared buffer before accessing it
Date: Mon, 30 Apr 2018 23:01:46 +0200
Message-Id: <98a855dceb47dbebd9c87e024084f14a5cb127f7.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Make local copy of the response, otherwise backend might modify it while
frontend is already processing it - leading to time of check / time of
use issue.

This is complementary to XSA155.

Cc: stable@vger.kernel.org
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/net/xen-netfront.c | 51 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 4dd0668..dc99763 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -387,13 +387,13 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
 		rmb(); /* Ensure we see responses up to 'rp'. */
 
 		for (cons = queue->tx.rsp_cons; cons != prod; cons++) {
-			struct xen_netif_tx_response *txrsp;
+			struct xen_netif_tx_response txrsp;
 
-			txrsp = RING_GET_RESPONSE(&queue->tx, cons);
-			if (txrsp->status == XEN_NETIF_RSP_NULL)
+			RING_COPY_RESPONSE(&queue->tx, cons, &txrsp);
+			if (txrsp.status == XEN_NETIF_RSP_NULL)
 				continue;
 
-			id  = txrsp->id;
+			id  = txrsp.id;
 			skb = queue->tx_skbs[id].skb;
 			if (unlikely(gnttab_query_foreign_access(
 				queue->grant_tx_ref[id]) != 0)) {
@@ -741,7 +741,7 @@ static int xennet_get_extras(struct netfront_queue *queue,
 			     RING_IDX rp)
 
 {
-	struct xen_netif_extra_info *extra;
+	struct xen_netif_extra_info extra;
 	struct device *dev = &queue->info->netdev->dev;
 	RING_IDX cons = queue->rx.rsp_cons;
 	int err = 0;
@@ -757,24 +757,23 @@ static int xennet_get_extras(struct netfront_queue *queue,
 			break;
 		}
 
-		extra = (struct xen_netif_extra_info *)
-			RING_GET_RESPONSE(&queue->rx, ++cons);
+		RING_COPY_RESPONSE(&queue->rx, ++cons, &extra);
 
-		if (unlikely(!extra->type ||
-			     extra->type >= XEN_NETIF_EXTRA_TYPE_MAX)) {
+		if (unlikely(!extra.type ||
+			     extra.type >= XEN_NETIF_EXTRA_TYPE_MAX)) {
 			if (net_ratelimit())
 				dev_warn(dev, "Invalid extra type: %d\n",
-					extra->type);
+					extra.type);
 			err = -EINVAL;
 		} else {
-			memcpy(&extras[extra->type - 1], extra,
-			       sizeof(*extra));
+			memcpy(&extras[extra.type - 1], &extra,
+			       sizeof(extra));
 		}
 
 		skb = xennet_get_rx_skb(queue, cons);
 		ref = xennet_get_rx_ref(queue, cons);
 		xennet_move_rx_slot(queue, skb, ref);
-	} while (extra->flags & XEN_NETIF_EXTRA_FLAG_MORE);
+	} while (extra.flags & XEN_NETIF_EXTRA_FLAG_MORE);
 
 	queue->rx.rsp_cons = cons;
 	return err;
@@ -784,28 +783,28 @@ static int xennet_get_responses(struct netfront_queue *queue,
 				struct netfront_rx_info *rinfo, RING_IDX rp,
 				struct sk_buff_head *list)
 {
-	struct xen_netif_rx_response *rx = &rinfo->rx;
+	struct xen_netif_rx_response rx = rinfo->rx;
 	struct xen_netif_extra_info *extras = rinfo->extras;
 	struct device *dev = &queue->info->netdev->dev;
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *skb = xennet_get_rx_skb(queue, cons);
 	grant_ref_t ref = xennet_get_rx_ref(queue, cons);
-	int max = MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD);
+	int max = MAX_SKB_FRAGS + (rx.status <= RX_COPY_THRESHOLD);
 	int slots = 1;
 	int err = 0;
 	unsigned long ret;
 
-	if (rx->flags & XEN_NETRXF_extra_info) {
+	if (rx.flags & XEN_NETRXF_extra_info) {
 		err = xennet_get_extras(queue, extras, rp);
 		cons = queue->rx.rsp_cons;
 	}
 
 	for (;;) {
-		if (unlikely(rx->status < 0 ||
-			     rx->offset + rx->status > XEN_PAGE_SIZE)) {
+		if (unlikely(rx.status < 0 ||
+			     rx.offset + rx.status > XEN_PAGE_SIZE)) {
 			if (net_ratelimit())
 				dev_warn(dev, "rx->offset: %u, size: %d\n",
-					 rx->offset, rx->status);
+					 rx.offset, rx.status);
 			xennet_move_rx_slot(queue, skb, ref);
 			err = -EINVAL;
 			goto next;
@@ -819,7 +818,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 		if (ref == GRANT_INVALID_REF) {
 			if (net_ratelimit())
 				dev_warn(dev, "Bad rx response id %d.\n",
-					 rx->id);
+					 rx.id);
 			err = -EINVAL;
 			goto next;
 		}
@@ -832,7 +831,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 		__skb_queue_tail(list, skb);
 
 next:
-		if (!(rx->flags & XEN_NETRXF_more_data))
+		if (!(rx.flags & XEN_NETRXF_more_data))
 			break;
 
 		if (cons + slots == rp) {
@@ -842,7 +841,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 			break;
 		}
 
-		rx = RING_GET_RESPONSE(&queue->rx, cons + slots);
+		RING_COPY_RESPONSE(&queue->rx, cons + slots, &rx);
 		skb = xennet_get_rx_skb(queue, cons + slots);
 		ref = xennet_get_rx_ref(queue, cons + slots);
 		slots++;
@@ -898,9 +897,9 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
 	struct sk_buff *nskb;
 
 	while ((nskb = __skb_dequeue(list))) {
-		struct xen_netif_rx_response *rx =
-			RING_GET_RESPONSE(&queue->rx, ++cons);
+		struct xen_netif_rx_response rx;
 		skb_frag_t *nfrag = &skb_shinfo(nskb)->frags[0];
+		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
 
 		if (shinfo->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
@@ -911,7 +910,7 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
 		BUG_ON(shinfo->nr_frags >= MAX_SKB_FRAGS);
 
 		skb_add_rx_frag(skb, shinfo->nr_frags, skb_frag_page(nfrag),
-				rx->offset, rx->status, PAGE_SIZE);
+				rx.offset, rx.status, PAGE_SIZE);
 
 		skb_shinfo(nskb)->nr_frags = 0;
 		kfree_skb(nskb);
@@ -1007,7 +1006,7 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 	i = queue->rx.rsp_cons;
 	work_done = 0;
 	while ((i != rp) && (work_done < budget)) {
-		memcpy(rx, RING_GET_RESPONSE(&queue->rx, i), sizeof(*rx));
+		RING_COPY_RESPONSE(&queue->rx, i, rx);
 		memset(extras, 0, sizeof(rinfo.extras));
 
 		err = xennet_get_responses(queue, &rinfo, rp, &tmpq);
-- 
git-series 0.9.1
