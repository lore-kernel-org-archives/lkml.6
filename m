Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160699-5-1342258650038327733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160698; b=Ut9+ARrp2cGHHNgLboZaJzSfBwvDdQtIt8W7xE+ULES9uo2UGS
    Ta27j5GWher39pun3IurbHwaWnCwomYuhCznqmgfaxU0MRmhxBmmPB/wWre4v/1N
    28KDUzalTtyeXLNFzbA6I0dyXjjsGsEbQxUQQyeOGIL8ZeAQJ3Fq5/Q0SGPYLZeQ
    +UVU8qwS7NOxsjAcp0oF4Ml9mbTcoelPR5BaB04dZPbfNA1yoTsAuyCkC1jnIXpe
    eppJeQMm0cM3OIdTxN/vqvL52fCeUVrTi4PPtie+/jRUMwhbFuoXQORw8SdgAjYZ
    bcFwXqFnqPWO93fLQvF1CIQSa5eWcKpkSsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160698; bh=7bNEAih6Y5oA3SwpXzjnERLsYq5+RC
    yoQ2QBj+GZGcU=; b=K9d59U4H9QZ06U4Q0okpXS0jalHrIb3eRQUT8ctbZ/TL3G
    72KS2bDnsMu2ImvrBfLLUHJpQcz0ZO8oN0Drlelb2P4tgDdxDKOfo6J9D1VArtqq
    PPFmxBlVTIblw67ZSLoRzIUCv5C8QzY3ZS8vQjVF47fYy0m/1YNItGAW1+KCEcWc
    LncNwcSl8VxY7bTvJKfHJ9+3NiKGDyykgYztx5l+eW+tbr/mDk3KtebhhTFGIe9a
    0girLJKsykd5S4GrHihXTt/kFun/XQVvywvTmFFMC/moSasgThJSCK8w9f0PBHQC
    5pOzrBC0NkPFtublfUq91UUgiHSGHoHHvZSBLoRA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=vfN0c9Xz x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=vfN0c9Xz x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCmhVP9xvtth1F4RVI9nJ0GIsiqDYPV9dR/CiMhAS9BgN6OdJ4XxBPBSVr/89O4Ys0/38/V161tpEafDeW787HwJfMaZ89K51UKIHJe/ozDLTGFXQEK5
    TdduOkr2cEaWLxmZG5uoQKElxAhK5SEvLl/U+4N1h/70N/yeeiOKdRNqwemUipQPALADG4cemzAENJIKwESQLU2sf69bWyH+nGBnzjlkvuHB6Te52UiVwJc0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=eh1Yez-EAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=LoKIxZYthUmQywgMGB8A:9
    a=PY7N7o555R9iwnc5:21 a=qVN8UthSnBHTMF7z:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968051AbeEXLSP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967533AbeEXJxN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Regis Duchesne <hpreg@vmware.com>,
        Ronak Doshi <doshir@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 011/165] vmxnet3: use DMA memory barriers where required
Date: Thu, 24 May 2018 11:36:57 +0200
Message-Id: <20180524093622.429612346@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: "hpreg@vmware.com" <hpreg@vmware.com>

[ Upstream commit f3002c1374fb2367c9d8dbb28852791ef90d2bac ]

The gen bits must be read first from (resp. written last to) DMA memory.
The proper way to enforce this on Linux is to call dma_rmb() (resp.
dma_wmb()).

Signed-off-by: Regis Duchesne <hpreg@vmware.com>
Acked-by: Ronak Doshi <doshir@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -369,6 +369,11 @@ vmxnet3_tq_tx_complete(struct vmxnet3_tx
 
 	gdesc = tq->comp_ring.base + tq->comp_ring.next2proc;
 	while (VMXNET3_TCD_GET_GEN(&gdesc->tcd) == tq->comp_ring.gen) {
+		/* Prevent any &gdesc->tcd field from being (speculatively)
+		 * read before (&gdesc->tcd)->gen is read.
+		 */
+		dma_rmb();
+
 		completed += vmxnet3_unmap_pkt(VMXNET3_TCD_GET_TXIDX(
 					       &gdesc->tcd), tq, adapter->pdev,
 					       adapter);
@@ -1099,6 +1104,11 @@ vmxnet3_tq_xmit(struct sk_buff *skb, str
 		gdesc->txd.tci = skb_vlan_tag_get(skb);
 	}
 
+	/* Ensure that the write to (&gdesc->txd)->gen will be observed after
+	 * all other writes to &gdesc->txd.
+	 */
+	dma_wmb();
+
 	/* finally flips the GEN bit of the SOP desc. */
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
@@ -1286,6 +1296,12 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 			 */
 			break;
 		}
+
+		/* Prevent any rcd field from being (speculatively) read before
+		 * rcd->gen is read.
+		 */
+		dma_rmb();
+
 		BUG_ON(rcd->rqID != rq->qid && rcd->rqID != rq->qid2 &&
 		       rcd->rqID != rq->dataRingQid);
 		idx = rcd->rxdIdx;
@@ -1515,6 +1531,12 @@ rcd_done:
 		ring->next2comp = idx;
 		num_to_alloc = vmxnet3_cmd_ring_desc_avail(ring);
 		ring = rq->rx_ring + ring_idx;
+
+		/* Ensure that the writes to rxd->gen bits will be observed
+		 * after all other writes to rxd objects.
+		 */
+		dma_wmb();
+
 		while (num_to_alloc) {
 			vmxnet3_getRxDesc(rxd, &ring->base[ring->next2fill].rxd,
 					  &rxCmdDesc);
