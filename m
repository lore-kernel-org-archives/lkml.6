Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160886-2-17382167002505661734
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
    1527160886; b=QTzFfcpyPRuUV3mIrsiMj6Zr/9ghqA5S+azTbAu5qpi0XdwcZY
    3g2lkbzTbRAcVIHjXYv6Up7kTP+2u2avyOPqkR/rm5aj35yAfg7IGAokpUz0ADbH
    /4y66fUcXltsljfd5mnzf5XplBGxzchtPWzqsFb1b9beU9NUPvwQS/aMMGG93Jyz
    f54aqHvlc2xttClzzboJmMZGDxkePovt2XNCVfnRBHtXKGasyHSCXJx7SEtyYvMJ
    YBGhPK7fhY7Nav1N1uItE8HSMMvtENpjhTOejI+CZwr3KLyiLUzdA012rI2DD1Wv
    whak+T9DJZc+37WC7677u+BL+LVXeRAWiXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160886; bh=y9D/yla6vsH0LMnFyUIYOMrA+2N2gn
    GqRNaPk5IVDiM=; b=jZWQPHe6vvk7ynqCOoM/RXh2Iry///t5oqhzd2XAdMSdT6
    FcxgnoDmHYBvdealEFttUy69dqzrXXK72U1PPMJckUW5zVk0EuolD1ayvNV9vAFe
    /bDW70q/mT9VaaN3Coa2RgpA+ByVtMeu5Z4YqVDK7s2GHk24csDtZcXq45Q9Qu0t
    jam88dpJC3LXlpyCbyZJYkeajXpDgSRcWuUE8s4w83vHfKjzag7/vekKifjztUND
    pd79QdQGP1CP9LWJjLIH3QkhFzq5eTpVCOmPzXgBblrKdS/EgBVgMWdNpuJUmrtZ
    54wyPUvjc3G2D8WdX8NaZEUbEQAr3g3JNlnp0RIw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=A5eb7z6f x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=A5eb7z6f x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfH7vkzi7Q2hpbtJBk9xgwULDv1ZUKEJwPRGgInmSuyEvNDJPu0PmdXgLEGdAalWoty4tglK8sReSTzM5Sd0oAoXoli+t4WVRJafPY1IYo56EUe5fYV2J
    IB17HcMaGy0AOyb+j1UHlDoFIbAqBIfhrFGglvqjWradvxAJTgwt8GaCwP5/Uxf0qAW5wLrDnIxkhCiSZSXlfZb3Bwb/UiXLuhL0X7WjGpnD84iPFkyFOf9x
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Xzx32ZKeKvyQ6Cy0NA8A:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967883AbeEXJwf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967868AbeEXJw1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 028/165] hv_netvsc: use RCU to fix concurrent rx and queue changes
Date: Thu, 24 May 2018 11:37:14 +0200
Message-Id: <20180524093623.116952569@linuxfoundation.org>
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

[ Commit 02400fcee2542ee334a2394e0d9f6efd969fe782 upstream. ]

The receive processing may continue to happen while the
internal network device state is in RCU grace period.
The internal RNDIS structure is associated with the
internal netvsc_device structure; both have the same
RCU lifetime.

Defer freeing all associated parts until after grace
period.

Fixes: 0cf737808ae7 ("hv_netvsc: netvsc_teardown_gpadl() split")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c       |   17 ++++------------
 drivers/net/hyperv/rndis_filter.c |   39 ++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 34 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -89,6 +89,11 @@ static void free_netvsc_device(struct rc
 		= container_of(head, struct netvsc_device, rcu);
 	int i;
 
+	kfree(nvdev->extension);
+	vfree(nvdev->recv_buf);
+	vfree(nvdev->send_buf);
+	kfree(nvdev->send_section_map);
+
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++)
 		vfree(nvdev->chan_table[i].mrc.slots);
 
@@ -210,12 +215,6 @@ static void netvsc_teardown_gpadl(struct
 		net_device->recv_buf_gpadl_handle = 0;
 	}
 
-	if (net_device->recv_buf) {
-		/* Free up the receive buffer */
-		vfree(net_device->recv_buf);
-		net_device->recv_buf = NULL;
-	}
-
 	if (net_device->send_buf_gpadl_handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
 					   net_device->send_buf_gpadl_handle);
@@ -230,12 +229,6 @@ static void netvsc_teardown_gpadl(struct
 		}
 		net_device->send_buf_gpadl_handle = 0;
 	}
-	if (net_device->send_buf) {
-		/* Free up the send buffer */
-		vfree(net_device->send_buf);
-		net_device->send_buf = NULL;
-	}
-	kfree(net_device->send_section_map);
 }
 
 int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_idx)
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -266,13 +266,23 @@ static void rndis_set_link_state(struct
 	}
 }
 
-static void rndis_filter_receive_response(struct rndis_device *dev,
-				       struct rndis_message *resp)
+static void rndis_filter_receive_response(struct net_device *ndev,
+					  struct netvsc_device *nvdev,
+					  const struct rndis_message *resp)
 {
+	struct rndis_device *dev = nvdev->extension;
 	struct rndis_request *request = NULL;
 	bool found = false;
 	unsigned long flags;
-	struct net_device *ndev = dev->ndev;
+
+	/* This should never happen, it means control message
+	 * response received after device removed.
+	 */
+	if (dev->state == RNDIS_DEV_UNINITIALIZED) {
+		netdev_err(ndev,
+			   "got rndis message uninitialized\n");
+		return;
+	}
 
 	spin_lock_irqsave(&dev->request_lock, flags);
 	list_for_each_entry(request, &dev->req_list, list_ent) {
@@ -353,7 +363,7 @@ static inline void *rndis_get_ppi(struct
 }
 
 static int rndis_filter_receive_data(struct net_device *ndev,
-				     struct rndis_device *dev,
+				     struct netvsc_device *nvdev,
 				     struct rndis_message *msg,
 				     struct vmbus_channel *channel,
 				     void *data, u32 data_buflen)
@@ -373,7 +383,7 @@ static int rndis_filter_receive_data(str
 	 * should be the data packet size plus the trailer padding size
 	 */
 	if (unlikely(data_buflen < rndis_pkt->data_len)) {
-		netdev_err(dev->ndev, "rndis message buffer "
+		netdev_err(ndev, "rndis message buffer "
 			   "overflow detected (got %u, min %u)"
 			   "...dropping this message!\n",
 			   data_buflen, rndis_pkt->data_len);
@@ -401,34 +411,20 @@ int rndis_filter_receive(struct net_devi
 			 void *data, u32 buflen)
 {
 	struct net_device_context *net_device_ctx = netdev_priv(ndev);
-	struct rndis_device *rndis_dev = net_dev->extension;
 	struct rndis_message *rndis_msg = data;
 
-	/* Make sure the rndis device state is initialized */
-	if (unlikely(!rndis_dev)) {
-		netif_err(net_device_ctx, rx_err, ndev,
-			  "got rndis message but no rndis device!\n");
-		return NVSP_STAT_FAIL;
-	}
-
-	if (unlikely(rndis_dev->state == RNDIS_DEV_UNINITIALIZED)) {
-		netif_err(net_device_ctx, rx_err, ndev,
-			  "got rndis message uninitialized\n");
-		return NVSP_STAT_FAIL;
-	}
-
 	if (netif_msg_rx_status(net_device_ctx))
 		dump_rndis_message(dev, rndis_msg);
 
 	switch (rndis_msg->ndis_msg_type) {
 	case RNDIS_MSG_PACKET:
-		return rndis_filter_receive_data(ndev, rndis_dev, rndis_msg,
+		return rndis_filter_receive_data(ndev, net_dev, rndis_msg,
 						 channel, data, buflen);
 	case RNDIS_MSG_INIT_C:
 	case RNDIS_MSG_QUERY_C:
 	case RNDIS_MSG_SET_C:
 		/* completion msgs */
-		rndis_filter_receive_response(rndis_dev, rndis_msg);
+		rndis_filter_receive_response(ndev, net_dev, rndis_msg);
 		break;
 
 	case RNDIS_MSG_INDICATE:
@@ -1349,7 +1345,6 @@ void rndis_filter_device_remove(struct h
 	net_dev->extension = NULL;
 
 	netvsc_device_remove(dev);
-	kfree(rndis_dev);
 }
 
 int rndis_filter_open(struct netvsc_device *nvdev)
