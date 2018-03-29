Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346966-2-9596917519285192929
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
    1522346965; b=V9o5MJzFA+DxdMDbuhTRX8DETVQe1POtXevbEhQlYonpvNcE4m
    nqwB0KdWTdbTi7OyIVGH9fBaRzcmIZrv6mImy9c6qeM9F3+pjCpPhyeIjh6/CGri
    Y8Oj370pVFCK4CV/H/7pBf11GtZp2LG4CyvfOPOAYN9d8jH5wUH7Pj0Bst050oI3
    O7rLlKumOsejsmjrxCuYvuwAqIGVxYr88ud0L3YDxW6kOMy6DiYq+zMMwFBpmNk2
    ErOFXThKf+tuYuCGPCvSMirCxYqZ9zELngqvguNMcMcpbPLG9qwIMaZbMoUvUaoH
    25cP+gQ/f44QDATDOijfz+VsGQv8EMAG47sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346965; bh=b9rBhmGodGWR0IUm/7/Va1Dr/4sg/O
    HtcAGYyXuQX6c=; b=F26sy4tct1RLay6kOfhjN4Z6J54i18sX/+qwn7yG/JkWsf
    RJ4RMFNdWj2cZAaZtlqJQCbPs5Xj8ODLe9pMPOlnSfKqSCYu6o7kd66nTTFoyqKR
    qNPEtfsz4hSVu+WzZagMSLI2vEOxM4VINxcI2sX3KP0Fw+NIEXrcwpbROvJTS31n
    eFVsgeMLMMRjlab/S5ZWHgfY3q+bPKRS+SHJS0dvY5hCPAw7/xso7aL1Z/wnF+x3
    cW+cHMeSSzngEkL9z/m9dxHQdwiSm9U0IhHn+jRtDcYCq134mhP5t66yZ6z96jJm
    t9QfbvjLCDWLun6WQg7QVUD2E1TVGl8k8CZoPeTw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfMEHCITAM6kKOLx1w26x1uZFjpgY+C6odHvNqCTbXsitxGTbG1JyJg+s/gSPvBQq4pr/USC6cJj1cJ3qzjWZR7DoEGWj2uVN2wkzsuCikfNU/H7pWQgV
    Lu6cl7Vpr8mSEGIDQZpffxMYdhlE+ckIOtvw6bvcCbLc8pIba6rTQQEP0i8OVFEyqv01gp5y4l/Xi7c4NAJi6WpbN2nYvlkWsEDrcc7TWd8kMNCaDbWI/IaS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=uHxRW4g1Worn-nSmixsA:9
    a=y9_ts17jaSkH_6mj:21 a=A8nZr1-LtZStosO9:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeC2SIa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:08:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754306AbeC2SI1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:08:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 20/20] net: systemport: Rewrite __bcm_sysport_tx_reclaim()
Date: Thu, 29 Mar 2018 20:00:56 +0200
Message-Id: <20180329175742.888986849@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
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

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 484d802d0f2f29c335563fcac2a8facf174a1bbc ]

There is no need for complex checking between the last consumed index
and current consumed index, a simple subtraction will do.

This also eliminates the possibility of a permanent transmit queue stall
under the following conditions:

- one CPU bursts ring->size worth of traffic (up to 256 buffers), to the
  point where we run out of free descriptors, so we stop the transmit
  queue at the end of bcm_sysport_xmit()

- because of our locking, we have the transmit process disable
  interrupts which means we can be blocking the TX reclamation process

- when TX reclamation finally runs, we will be computing the difference
  between ring->c_index (last consumed index by SW) and what the HW
  reports through its register

- this register is masked with (ring->size - 1) = 0xff, which will lead
  to stripping the upper bits of the index (register is 16-bits wide)

- we will be computing last_tx_cn as 0, which means there is no work to
  be done, and we never wake-up the transmit queue, leaving it
  permanently disabled

A practical example is e.g: ring->c_index aka last_c_index = 12, we
pushed 256 entries, HW consumer index = 268, we mask it with 0xff = 12,
so last_tx_cn == 0, nothing happens.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |   33 +++++++++++++----------------
 drivers/net/ethernet/broadcom/bcmsysport.h |    2 -
 2 files changed, 16 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -729,37 +729,33 @@ static unsigned int __bcm_sysport_tx_rec
 					     struct bcm_sysport_tx_ring *ring)
 {
 	struct net_device *ndev = priv->netdev;
-	unsigned int c_index, last_c_index, last_tx_cn, num_tx_cbs;
 	unsigned int pkts_compl = 0, bytes_compl = 0;
+	unsigned int txbds_processed = 0;
 	struct bcm_sysport_cb *cb;
+	unsigned int txbds_ready;
+	unsigned int c_index;
 	u32 hw_ind;
 
 	/* Compute how many descriptors have been processed since last call */
 	hw_ind = tdma_readl(priv, TDMA_DESC_RING_PROD_CONS_INDEX(ring->index));
 	c_index = (hw_ind >> RING_CONS_INDEX_SHIFT) & RING_CONS_INDEX_MASK;
-	ring->p_index = (hw_ind & RING_PROD_INDEX_MASK);
-
-	last_c_index = ring->c_index;
-	num_tx_cbs = ring->size;
-
-	c_index &= (num_tx_cbs - 1);
-
-	if (c_index >= last_c_index)
-		last_tx_cn = c_index - last_c_index;
-	else
-		last_tx_cn = num_tx_cbs - last_c_index + c_index;
+	txbds_ready = (c_index - ring->c_index) & RING_CONS_INDEX_MASK;
 
 	netif_dbg(priv, tx_done, ndev,
-		  "ring=%d c_index=%d last_tx_cn=%d last_c_index=%d\n",
-		  ring->index, c_index, last_tx_cn, last_c_index);
+		  "ring=%d old_c_index=%u c_index=%u txbds_ready=%u\n",
+		  ring->index, ring->c_index, c_index, txbds_ready);
 
-	while (last_tx_cn-- > 0) {
-		cb = ring->cbs + last_c_index;
+	while (txbds_processed < txbds_ready) {
+		cb = &ring->cbs[ring->clean_index];
 		bcm_sysport_tx_reclaim_one(priv, cb, &bytes_compl, &pkts_compl);
 
 		ring->desc_count++;
-		last_c_index++;
-		last_c_index &= (num_tx_cbs - 1);
+		txbds_processed++;
+
+		if (likely(ring->clean_index < ring->size - 1))
+			ring->clean_index++;
+		else
+			ring->clean_index = 0;
 	}
 
 	ring->c_index = c_index;
@@ -1229,6 +1225,7 @@ static int bcm_sysport_init_tx_ring(stru
 	netif_napi_add(priv->netdev, &ring->napi, bcm_sysport_tx_poll, 64);
 	ring->index = index;
 	ring->size = size;
+	ring->clean_index = 0;
 	ring->alloc_size = ring->size;
 	ring->desc_cpu = p;
 	ring->desc_count = ring->size;
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -638,7 +638,7 @@ struct bcm_sysport_tx_ring {
 	unsigned int	desc_count;	/* Number of descriptors */
 	unsigned int	curr_desc;	/* Current descriptor */
 	unsigned int	c_index;	/* Last consumer index */
-	unsigned int	p_index;	/* Current producer index */
+	unsigned int	clean_index;	/* Current clean index */
 	struct bcm_sysport_cb *cbs;	/* Transmit control blocks */
 	struct dma_desc	*desc_cpu;	/* CPU view of the descriptor */
 	struct bcm_sysport_priv *priv;	/* private context backpointer */
