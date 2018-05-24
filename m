Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527158339-2-15482839276728181402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158338; b=Oi6WKfhSWNuCVPXIbDV9Xln3L5AHu418ij6rIooIoRQNfVG8PC
    HviU2EYO/VqBlS1C/kS652I4oQRLJFhMwpfOV+KpSVW7BbM2Qm7ps0tebSZjsmF7
    Y/q0kneD8WcnZUgOlbtdnrWUD84dx+8APUrPKpuymShR7QHSPIPqo7Rcbg5D8kyL
    FWPvUU3xO3ZVnBfBMqg1Q5QtSWEP9Z3LlDR1kZzRDkAoOZ4Ldw5LsFmE2cuTyHW2
    Kz5OqlNHt6wSGLkzmhT93gQAQCzLkZS6RLb57HwL0bOLToKwxeWHCNk8SZkM0eUR
    iSuyP+az/30mhyKRh09tlZFdeY3g1tG6yVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158338; bh=6/E2q7MfU/LE92XeHwGulAXqolDL8L
    iG9JCT/M6l7TI=; b=ITcvONwi14HLZPO8OGyY8L9p4N2PXtqavTv3XeosUp8VLc
    +YfQItMsL5hnpGCSp5hXlK3JNUkmdVknKS9b5EsX95tp+kcoakX4rxNkCW5qnG7K
    AOSboR24zyli18Ehp02XYEKwp6QpaW0HcXbCF+9XT3wFCe8f5tCUjWl9f+xJg86s
    5WafLeQxxflSkavvl8GtTZWUtUD1qJzBojXEU4urc10uAZEu1w4XnAW0fsQdVZsF
    dsxyqdZYrvdHW9Xfmz/cJoVDek4b9zSVMCByT9k8NZJTd83xc9PkZp9Syky0GIE6
    fuKEmkxRcJ5ErXa1fodNPNXooSe0j0tp54d4QAig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=c0u2hcQ7 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=c0u2hcQ7 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPz4/OHiW0QKy7DwhfWaUJCtOsU/LpXSy/DnoAojRZzoz2yUHX4Bk9nkgle2KXz27FvyVr87umj4OFsaAO37a5NlChO2TvLaW0pw3Lt11ptvBhgCM4sl
    XtH8svGT1hjKedrGZ6WAVI1oITKI63z8h+DtsMBhpjU1jLGBDc+NGfjvCx9ig+XIG/DvqnMknmB79b+lIGw9FcfLPhjZReHR7pIB4WLKAVtqfz3ETFq2rAe1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=WqbeYhDGwNIA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=n1rLoM6Erc86D7DhvdUA:9 a=5tAtST23eQunkvOv:21 a=bZC6vUk9IdDC86ea:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968312AbeEXKio (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030520AbeEXJ7b (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, tedheadster <tedheadster@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 018/161] 3c59x: convert to generic DMA API
Date: Thu, 24 May 2018 11:37:23 +0200
Message-Id: <20180524093020.557989470@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 55c82617c3e82210b7471e9334e8fc5df6a9961f ]

This driver supports EISA devices in addition to PCI devices, and relied
on the legacy behavior of the pci_dma* shims to pass on a NULL pointer
to the DMA API, and the DMA API being able to handle that.  When the
NULL forwarding broke the EISA support got broken.  Fix this by converting
to the DMA API instead of the legacy PCI shims.

Fixes: 4167b2ad ("PCI: Remove NULL device handling from PCI DMA API")
Reported-by: tedheadster <tedheadster@gmail.com>
Tested-by: tedheadster <tedheadster@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/3com/3c59x.c |  104 ++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1212,9 +1212,9 @@ static int vortex_probe1(struct device *
 	vp->mii.reg_num_mask = 0x1f;
 
 	/* Makes sure rings are at least 16 byte aligned. */
-	vp->rx_ring = pci_alloc_consistent(pdev, sizeof(struct boom_rx_desc) * RX_RING_SIZE
+	vp->rx_ring = dma_alloc_coherent(gendev, sizeof(struct boom_rx_desc) * RX_RING_SIZE
 					   + sizeof(struct boom_tx_desc) * TX_RING_SIZE,
-					   &vp->rx_ring_dma);
+					   &vp->rx_ring_dma, GFP_KERNEL);
 	retval = -ENOMEM;
 	if (!vp->rx_ring)
 		goto free_device;
@@ -1476,11 +1476,10 @@ static int vortex_probe1(struct device *
 		return 0;
 
 free_ring:
-	pci_free_consistent(pdev,
-						sizeof(struct boom_rx_desc) * RX_RING_SIZE
-							+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
-						vp->rx_ring,
-						vp->rx_ring_dma);
+	dma_free_coherent(&pdev->dev,
+		sizeof(struct boom_rx_desc) * RX_RING_SIZE +
+		sizeof(struct boom_tx_desc) * TX_RING_SIZE,
+		vp->rx_ring, vp->rx_ring_dma);
 free_device:
 	free_netdev(dev);
 	pr_err(PFX "vortex_probe1 fails.  Returns %d\n", retval);
@@ -1751,9 +1750,9 @@ vortex_open(struct net_device *dev)
 				break;			/* Bad news!  */
 
 			skb_reserve(skb, NET_IP_ALIGN);	/* Align IP on 16 byte boundaries */
-			dma = pci_map_single(VORTEX_PCI(vp), skb->data,
-					     PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
-			if (dma_mapping_error(&VORTEX_PCI(vp)->dev, dma))
+			dma = dma_map_single(vp->gendev, skb->data,
+					     PKT_BUF_SZ, DMA_FROM_DEVICE);
+			if (dma_mapping_error(vp->gendev, dma))
 				break;
 			vp->rx_ring[i].addr = cpu_to_le32(dma);
 		}
@@ -2067,9 +2066,9 @@ vortex_start_xmit(struct sk_buff *skb, s
 	if (vp->bus_master) {
 		/* Set the bus-master controller to transfer the packet. */
 		int len = (skb->len + 3) & ~3;
-		vp->tx_skb_dma = pci_map_single(VORTEX_PCI(vp), skb->data, len,
-						PCI_DMA_TODEVICE);
-		if (dma_mapping_error(&VORTEX_PCI(vp)->dev, vp->tx_skb_dma)) {
+		vp->tx_skb_dma = dma_map_single(vp->gendev, skb->data, len,
+						DMA_TO_DEVICE);
+		if (dma_mapping_error(vp->gendev, vp->tx_skb_dma)) {
 			dev_kfree_skb_any(skb);
 			dev->stats.tx_dropped++;
 			return NETDEV_TX_OK;
@@ -2168,9 +2167,9 @@ boomerang_start_xmit(struct sk_buff *skb
 			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum | AddUDPChksum);
 
 	if (!skb_shinfo(skb)->nr_frags) {
-		dma_addr = pci_map_single(VORTEX_PCI(vp), skb->data, skb->len,
-					  PCI_DMA_TODEVICE);
-		if (dma_mapping_error(&VORTEX_PCI(vp)->dev, dma_addr))
+		dma_addr = dma_map_single(vp->gendev, skb->data, skb->len,
+					  DMA_TO_DEVICE);
+		if (dma_mapping_error(vp->gendev, dma_addr))
 			goto out_dma_err;
 
 		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(dma_addr);
@@ -2178,9 +2177,9 @@ boomerang_start_xmit(struct sk_buff *skb
 	} else {
 		int i;
 
-		dma_addr = pci_map_single(VORTEX_PCI(vp), skb->data,
-					  skb_headlen(skb), PCI_DMA_TODEVICE);
-		if (dma_mapping_error(&VORTEX_PCI(vp)->dev, dma_addr))
+		dma_addr = dma_map_single(vp->gendev, skb->data,
+					  skb_headlen(skb), DMA_TO_DEVICE);
+		if (dma_mapping_error(vp->gendev, dma_addr))
 			goto out_dma_err;
 
 		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(dma_addr);
@@ -2189,21 +2188,21 @@ boomerang_start_xmit(struct sk_buff *skb
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-			dma_addr = skb_frag_dma_map(&VORTEX_PCI(vp)->dev, frag,
+			dma_addr = skb_frag_dma_map(vp->gendev, frag,
 						    0,
 						    frag->size,
 						    DMA_TO_DEVICE);
-			if (dma_mapping_error(&VORTEX_PCI(vp)->dev, dma_addr)) {
+			if (dma_mapping_error(vp->gendev, dma_addr)) {
 				for(i = i-1; i >= 0; i--)
-					dma_unmap_page(&VORTEX_PCI(vp)->dev,
+					dma_unmap_page(vp->gendev,
 						       le32_to_cpu(vp->tx_ring[entry].frag[i+1].addr),
 						       le32_to_cpu(vp->tx_ring[entry].frag[i+1].length),
 						       DMA_TO_DEVICE);
 
-				pci_unmap_single(VORTEX_PCI(vp),
+				dma_unmap_single(vp->gendev,
 						 le32_to_cpu(vp->tx_ring[entry].frag[0].addr),
 						 le32_to_cpu(vp->tx_ring[entry].frag[0].length),
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 
 				goto out_dma_err;
 			}
@@ -2218,8 +2217,8 @@ boomerang_start_xmit(struct sk_buff *skb
 		}
 	}
 #else
-	dma_addr = pci_map_single(VORTEX_PCI(vp), skb->data, skb->len, PCI_DMA_TODEVICE);
-	if (dma_mapping_error(&VORTEX_PCI(vp)->dev, dma_addr))
+	dma_addr = dma_map_single(vp->gendev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(vp->gendev, dma_addr))
 		goto out_dma_err;
 	vp->tx_ring[entry].addr = cpu_to_le32(dma_addr);
 	vp->tx_ring[entry].length = cpu_to_le32(skb->len | LAST_FRAG);
@@ -2254,7 +2253,7 @@ boomerang_start_xmit(struct sk_buff *skb
 out:
 	return NETDEV_TX_OK;
 out_dma_err:
-	dev_err(&VORTEX_PCI(vp)->dev, "Error mapping dma buffer\n");
+	dev_err(vp->gendev, "Error mapping dma buffer\n");
 	goto out;
 }
 
@@ -2322,7 +2321,7 @@ vortex_interrupt(int irq, void *dev_id)
 		if (status & DMADone) {
 			if (ioread16(ioaddr + Wn7_MasterStatus) & 0x1000) {
 				iowrite16(0x1000, ioaddr + Wn7_MasterStatus); /* Ack the event. */
-				pci_unmap_single(VORTEX_PCI(vp), vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, PCI_DMA_TODEVICE);
+				dma_unmap_single(vp->gendev, vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, DMA_TO_DEVICE);
 				pkts_compl++;
 				bytes_compl += vp->tx_skb->len;
 				dev_kfree_skb_irq(vp->tx_skb); /* Release the transferred buffer */
@@ -2459,19 +2458,19 @@ boomerang_interrupt(int irq, void *dev_i
 					struct sk_buff *skb = vp->tx_skbuff[entry];
 #if DO_ZEROCOPY
 					int i;
-					pci_unmap_single(VORTEX_PCI(vp),
+					dma_unmap_single(vp->gendev,
 							le32_to_cpu(vp->tx_ring[entry].frag[0].addr),
 							le32_to_cpu(vp->tx_ring[entry].frag[0].length)&0xFFF,
-							PCI_DMA_TODEVICE);
+							DMA_TO_DEVICE);
 
 					for (i=1; i<=skb_shinfo(skb)->nr_frags; i++)
-							pci_unmap_page(VORTEX_PCI(vp),
+							dma_unmap_page(vp->gendev,
 											 le32_to_cpu(vp->tx_ring[entry].frag[i].addr),
 											 le32_to_cpu(vp->tx_ring[entry].frag[i].length)&0xFFF,
-											 PCI_DMA_TODEVICE);
+											 DMA_TO_DEVICE);
 #else
-					pci_unmap_single(VORTEX_PCI(vp),
-						le32_to_cpu(vp->tx_ring[entry].addr), skb->len, PCI_DMA_TODEVICE);
+					dma_unmap_single(vp->gendev,
+						le32_to_cpu(vp->tx_ring[entry].addr), skb->len, DMA_TO_DEVICE);
 #endif
 					pkts_compl++;
 					bytes_compl += skb->len;
@@ -2561,14 +2560,14 @@ static int vortex_rx(struct net_device *
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				if (vp->bus_master &&
 					! (ioread16(ioaddr + Wn7_MasterStatus) & 0x8000)) {
-					dma_addr_t dma = pci_map_single(VORTEX_PCI(vp), skb_put(skb, pkt_len),
-									   pkt_len, PCI_DMA_FROMDEVICE);
+					dma_addr_t dma = dma_map_single(vp->gendev, skb_put(skb, pkt_len),
+									   pkt_len, DMA_FROM_DEVICE);
 					iowrite32(dma, ioaddr + Wn7_MasterAddr);
 					iowrite16((skb->len + 3) & ~3, ioaddr + Wn7_MasterLen);
 					iowrite16(StartDMAUp, ioaddr + EL3_CMD);
 					while (ioread16(ioaddr + Wn7_MasterStatus) & 0x8000)
 						;
-					pci_unmap_single(VORTEX_PCI(vp), dma, pkt_len, PCI_DMA_FROMDEVICE);
+					dma_unmap_single(vp->gendev, dma, pkt_len, DMA_FROM_DEVICE);
 				} else {
 					ioread32_rep(ioaddr + RX_FIFO,
 					             skb_put(skb, pkt_len),
@@ -2635,11 +2634,11 @@ boomerang_rx(struct net_device *dev)
 			if (pkt_len < rx_copybreak &&
 			    (skb = netdev_alloc_skb(dev, pkt_len + 2)) != NULL) {
 				skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-				pci_dma_sync_single_for_cpu(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				dma_sync_single_for_cpu(vp->gendev, dma, PKT_BUF_SZ, DMA_FROM_DEVICE);
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				skb_put_data(skb, vp->rx_skbuff[entry]->data,
 					     pkt_len);
-				pci_dma_sync_single_for_device(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				dma_sync_single_for_device(vp->gendev, dma, PKT_BUF_SZ, DMA_FROM_DEVICE);
 				vp->rx_copy++;
 			} else {
 				/* Pre-allocate the replacement skb.  If it or its
@@ -2651,9 +2650,9 @@ boomerang_rx(struct net_device *dev)
 					dev->stats.rx_dropped++;
 					goto clear_complete;
 				}
-				newdma = pci_map_single(VORTEX_PCI(vp), newskb->data,
-							PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
-				if (dma_mapping_error(&VORTEX_PCI(vp)->dev, newdma)) {
+				newdma = dma_map_single(vp->gendev, newskb->data,
+							PKT_BUF_SZ, DMA_FROM_DEVICE);
+				if (dma_mapping_error(vp->gendev, newdma)) {
 					dev->stats.rx_dropped++;
 					consume_skb(newskb);
 					goto clear_complete;
@@ -2664,7 +2663,7 @@ boomerang_rx(struct net_device *dev)
 				vp->rx_skbuff[entry] = newskb;
 				vp->rx_ring[entry].addr = cpu_to_le32(newdma);
 				skb_put(skb, pkt_len);
-				pci_unmap_single(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				dma_unmap_single(vp->gendev, dma, PKT_BUF_SZ, DMA_FROM_DEVICE);
 				vp->rx_nocopy++;
 			}
 			skb->protocol = eth_type_trans(skb, dev);
@@ -2761,8 +2760,8 @@ vortex_close(struct net_device *dev)
 	if (vp->full_bus_master_rx) { /* Free Boomerang bus master Rx buffers. */
 		for (i = 0; i < RX_RING_SIZE; i++)
 			if (vp->rx_skbuff[i]) {
-				pci_unmap_single(	VORTEX_PCI(vp), le32_to_cpu(vp->rx_ring[i].addr),
-									PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				dma_unmap_single(vp->gendev, le32_to_cpu(vp->rx_ring[i].addr),
+									PKT_BUF_SZ, DMA_FROM_DEVICE);
 				dev_kfree_skb(vp->rx_skbuff[i]);
 				vp->rx_skbuff[i] = NULL;
 			}
@@ -2775,12 +2774,12 @@ vortex_close(struct net_device *dev)
 				int k;
 
 				for (k=0; k<=skb_shinfo(skb)->nr_frags; k++)
-						pci_unmap_single(VORTEX_PCI(vp),
+						dma_unmap_single(vp->gendev,
 										 le32_to_cpu(vp->tx_ring[i].frag[k].addr),
 										 le32_to_cpu(vp->tx_ring[i].frag[k].length)&0xFFF,
-										 PCI_DMA_TODEVICE);
+										 DMA_TO_DEVICE);
 #else
-				pci_unmap_single(VORTEX_PCI(vp), le32_to_cpu(vp->tx_ring[i].addr), skb->len, PCI_DMA_TODEVICE);
+				dma_unmap_single(vp->gendev, le32_to_cpu(vp->tx_ring[i].addr), skb->len, DMA_TO_DEVICE);
 #endif
 				dev_kfree_skb(skb);
 				vp->tx_skbuff[i] = NULL;
@@ -3288,11 +3287,10 @@ static void vortex_remove_one(struct pci
 
 	pci_iounmap(pdev, vp->ioaddr);
 
-	pci_free_consistent(pdev,
-						sizeof(struct boom_rx_desc) * RX_RING_SIZE
-							+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
-						vp->rx_ring,
-						vp->rx_ring_dma);
+	dma_free_coherent(&pdev->dev,
+			sizeof(struct boom_rx_desc) * RX_RING_SIZE +
+			sizeof(struct boom_tx_desc) * TX_RING_SIZE,
+			vp->rx_ring, vp->rx_ring_dma);
 
 	pci_release_regions(pdev);
 
