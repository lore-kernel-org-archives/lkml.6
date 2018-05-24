Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155529-2-12713360285258653171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155528; b=i3en/s2Jn+CvEFVMHCl14AF/Ad1mz9ZruLznBuBSCTNUVHxLpQ
    LLD7f04fCb9Gdnjx1ObaIPic2s3Kzv9is3Lqs3/wW2p6Xvas/O1jLA1xa3+ExV95
    lQwJsCiEuemL9CRJofzwBP2SeRsCCEvDAZL6vIPDz+eKpAFZ4QcZgqp7XbtOCvtM
    AQ1R1BFHmUDzuXPI/ijGTpLD7P+q4TD62RRJcdIncKqhdMUxHtOnIAtZ+qcBvDC5
    AYp7BHSOStoRoUhM7V85LO3srOZNSIC7mgDTx20O5RNOvIB8nkUaz4eVtHyQYWsv
    Fvztx4kwWhkhSLeqhCTglYgwAxyIv7Wb9LmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155528; bh=OKcWu7AsyAjuoFv58Pngt/iUG/wuGV
    J9ZtCt677/I6U=; b=dMdluLOE45779B+UGqzz/7JNVrPF81021fi8ivxeDd3Pk7
    LAcTKD0vAscUa+3Wih8h3DadKKC4/I06cKSsPpL8DczwJv/CIj2kh0P1oRKeX9cC
    h8xTvlsjunfA+d9uCHG8tVmshybvrJBp1BJaMSUa2te8qPFh/8zqZxGjbF8fMHbD
    1Kyf+9adtJ75bKo4AeRysXd27Z1KFdxyDIc3yAwbNHBa7cKPVrBaPHuXvXeEAFMv
    JFF3lW5u6bzgFWxeRqAFIcK3fOE73F+hecsAHgekC+TN6XX/fNyCExuZ6uKc5dfV
    eBTVVac9K7cWP5Mp+R0HuOztrIv1uelxxFRCy+xw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ry5jRRTf x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ry5jRRTf x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfD7TV3rlMRLVIOZJF7bTuLeQRCn2/5/70V0BBeJn0vovYLNI+Gs7aPzjW8XZ/suMCfWaCZXFud5b3wE2ziwIzIxqZY0q6I65151GcnHkU6j7NFHFKHdv
    oA4zinG61Zti9lQo+LSJY7stwlaLIsJJL9CzURgsp0dd6TR83+OK4TZg2K3+DYof01i/qzD3pEKolkVaoSS9e1+vfwVs1D995uTxYo6m42wG1doYu+ZG/OaO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=62wfaGjYPj81BWov6xQA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967289AbeEXJwF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967806AbeEXJwA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 019/165] hv_netvsc: empty current transmit aggregation if flow blocked
Date: Thu, 24 May 2018 11:37:05 +0200
Message-Id: <20180524093622.762630373@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit cfd8afd986cdb59ea9adac873c5082498a1eb7c0 upstream. ]

If the transmit queue is known full, then don't keep aggregating
data. And the cp_partial flag which indicates that the current
aggregation buffer is full can be folded in to avoid more
conditionals.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h   |    2 +-
 drivers/net/hyperv/netvsc.c       |   36 +++++++++++++++++++++---------------
 drivers/net/hyperv/netvsc_drv.c   |    2 +-
 drivers/net/hyperv/rndis_filter.c |    3 +--
 4 files changed, 24 insertions(+), 19 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -192,7 +192,7 @@ struct netvsc_device *netvsc_device_add(
 					const struct netvsc_device_info *info);
 int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_idx);
 void netvsc_device_remove(struct hv_device *device);
-int netvsc_send(struct net_device_context *ndc,
+int netvsc_send(struct net_device *net,
 		struct hv_netvsc_packet *packet,
 		struct rndis_message *rndis_msg,
 		struct hv_page_buffer *page_buffer,
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -700,13 +700,13 @@ static u32 netvsc_get_next_send_section(
 	return NETVSC_INVALID_INDEX;
 }
 
-static u32 netvsc_copy_to_send_buf(struct netvsc_device *net_device,
-				   unsigned int section_index,
-				   u32 pend_size,
-				   struct hv_netvsc_packet *packet,
-				   struct rndis_message *rndis_msg,
-				   struct hv_page_buffer *pb,
-				   struct sk_buff *skb)
+static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
+				    unsigned int section_index,
+				    u32 pend_size,
+				    struct hv_netvsc_packet *packet,
+				    struct rndis_message *rndis_msg,
+				    struct hv_page_buffer *pb,
+				    bool xmit_more)
 {
 	char *start = net_device->send_buf;
 	char *dest = start + (section_index * net_device->send_section_size)
@@ -719,7 +719,8 @@ static u32 netvsc_copy_to_send_buf(struc
 		packet->page_buf_cnt;
 
 	/* Add padding */
-	if (skb->xmit_more && remain && !packet->cp_partial) {
+	remain = packet->total_data_buflen & (net_device->pkt_align - 1);
+	if (xmit_more && remain) {
 		padding = net_device->pkt_align - remain;
 		rndis_msg->msg_len += padding;
 		packet->total_data_buflen += padding;
@@ -739,8 +740,6 @@ static u32 netvsc_copy_to_send_buf(struc
 		memset(dest, 0, padding);
 		msg_size += padding;
 	}
-
-	return msg_size;
 }
 
 static inline int netvsc_send_pkt(
@@ -828,12 +827,13 @@ static inline void move_pkt_msd(struct h
 }
 
 /* RCU already held by caller */
-int netvsc_send(struct net_device_context *ndev_ctx,
+int netvsc_send(struct net_device *ndev,
 		struct hv_netvsc_packet *packet,
 		struct rndis_message *rndis_msg,
 		struct hv_page_buffer *pb,
 		struct sk_buff *skb)
 {
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	struct netvsc_device *net_device
 		= rcu_dereference_bh(ndev_ctx->nvdev);
 	struct hv_device *device = ndev_ctx->device_ctx;
@@ -844,8 +844,7 @@ int netvsc_send(struct net_device_contex
 	struct multi_send_data *msdp;
 	struct hv_netvsc_packet *msd_send = NULL, *cur_send = NULL;
 	struct sk_buff *msd_skb = NULL;
-	bool try_batch;
-	bool xmit_more = (skb != NULL) ? skb->xmit_more : false;
+	bool try_batch, xmit_more;
 
 	/* If device is rescinded, return error and packet will get dropped. */
 	if (unlikely(!net_device || net_device->destroy))
@@ -896,10 +895,17 @@ int netvsc_send(struct net_device_contex
 		}
 	}
 
+	/* Keep aggregating only if stack says more data is coming
+	 * and not doing mixed modes send and not flow blocked
+	 */
+	xmit_more = skb->xmit_more &&
+		!packet->cp_partial &&
+		!netif_xmit_stopped(netdev_get_tx_queue(ndev, packet->q_idx));
+
 	if (section_index != NETVSC_INVALID_INDEX) {
 		netvsc_copy_to_send_buf(net_device,
 					section_index, msd_len,
-					packet, rndis_msg, pb, skb);
+					packet, rndis_msg, pb, xmit_more);
 
 		packet->send_buf_index = section_index;
 
@@ -919,7 +925,7 @@ int netvsc_send(struct net_device_contex
 		if (msdp->skb)
 			dev_consume_skb_any(msdp->skb);
 
-		if (xmit_more && !packet->cp_partial) {
+		if (xmit_more) {
 			msdp->skb = skb;
 			msdp->pkt = packet;
 			msdp->count++;
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -614,7 +614,7 @@ static int netvsc_start_xmit(struct sk_b
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
-	ret = netvsc_send(net_device_ctx, packet, rndis_msg, pb, skb);
+	ret = netvsc_send(net, packet, rndis_msg, pb, skb);
 	if (likely(ret == 0))
 		return NETDEV_TX_OK;
 
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -217,7 +217,6 @@ static int rndis_filter_send_request(str
 	struct hv_netvsc_packet *packet;
 	struct hv_page_buffer page_buf[2];
 	struct hv_page_buffer *pb = page_buf;
-	struct net_device_context *net_device_ctx = netdev_priv(dev->ndev);
 	int ret;
 
 	/* Setup the packet to send it */
@@ -245,7 +244,7 @@ static int rndis_filter_send_request(str
 	}
 
 	rcu_read_lock_bh();
-	ret = netvsc_send(net_device_ctx, packet, NULL, pb, NULL);
+	ret = netvsc_send(dev->ndev, packet, NULL, pb, NULL);
 	rcu_read_unlock_bh();
 
 	return ret;
