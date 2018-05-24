Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527161063-2-16359852838513633202
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
    1527161062; b=emU2o7bTcIWi2v0VlOkk/lJlmX4O/qhduZjXP0DuX8ZGkUzPQi
    wbBE8Hjgs1JXYypvW40/RFTHwKkh2YhkUWjiuiXnzhhUtqfw/NzqVUacC6TV1pq3
    Sv1tZlvvTOxrtUrOepKHA6UxXaJUBbrVLzHMEJ8ew3BWkh0rrMfwxkALiTJjqAnv
    j2rEepJUZPRhAuGn/gFlN1KWLyOkBdj2lNpZG+ZvxC7aGzpierOPlmmoO2/5GMyS
    Af3hJM+NQorsqY9TzDjp2q1c7nu+Di3lsngcuKxd+60LPJphiND89EHYf38CN//L
    SNaNdW5/3a5jjcS/TnYJdB5X4efTCT5TFEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161062; bh=HWv/S1yt6eQ8Vy9MF7uDAZVDH5F/4h
    KCwBqeaqi3IK4=; b=emHs83yzr1GjG1DixWhSHe9ivZIDFEIbB1BVf+WEACv4TB
    ewXRbScxvM7IHJWy7B8wlkWjRl2M/1mZsPtmvIkmEsgS+iTPLJj0j4QCTdurL6LI
    9Nrc9qhK64t31lyhnYB+IRjFry2coSOgP9Y51eFyDi4u4KxCjMwmvCN7aYaKR65F
    pa+zKs22n4mZPhthSsPvP/IxTFA7CbapvohAcyic7/KbsdXjLmw2zfRClsL4I2Od
    +Au4kLwAqWn5S8BZF7fS3U2sL96UpwmNGENWBzsHw1bOSURStEw24BktcvkAhQGX
    bT91bukQdvL5L4c4VW0Epp1zBkN5zVu/v/ZNDYWg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=OUFgHwEw x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=OUFgHwEw x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJqOXC0VGYJk8kNnt30v9N6HoXsEQ+5kozHU3HaWqwARmntB+eWE0hNUTNmVJW5Yz5YSeeZuRFFwFmPTMRIHmC6hEac3Rju+hCNpZEF+pWzDs/diJcvv
    s/cUPUTMF16igh8abMIgniCyRjbmLVmWy6uKHXJhyvPAXyC+ZsHl8xNCSl7hkl5LKTuePEY6INukCO4f/fjeLSlQ7I5Vbg022OsNC2BNjSfhwHkwG53Er5xt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=QajOumooQADo7j-3xnMA:9 a=vqCnpg8MiOxEDaTm:21 a=kDKQYnJ4kqjeRjQc:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967590AbeEXLYJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967440AbeEXJv5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 018/165] hv_netvsc: preserve hw_features on mtu/channels/ringparam changes
Date: Thu, 24 May 2018 11:37:04 +0200
Message-Id: <20180524093622.719368142@linuxfoundation.org>
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Commit aefd80e874e98a864915df5b7d90824a4340b450 upstream. ]

rndis_filter_device_add() is called both from netvsc_probe() when we
initially create the device and from set channels/mtu/ringparam
routines where we basically remove the device and add it back.

hw_features is reset in rndis_filter_device_add() and filled with
host data. However, we lose all additional flags which are set outside
of the driver, e.g. register_netdevice() adds NETIF_F_SOFT_FEATURES and
many others.

Unfortunately, calls to rndis_{query_hwcaps(), _set_offload_params()}
calls cannot be avoided on every RNDIS reset: host expects us to set
required features explicitly. Moreover, in theory hardware capabilities
can change and we need to reflect the change in hw_features.

Reset net->hw_features bits according to host data in
rndis_netdev_set_hwcaps(), clear corresponding feature bits
from net->features in case some features went missing (will never happen
in real life I guess but let's be consistent).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h   |    4 +
 drivers/net/hyperv/netvsc_drv.c   |    2 
 drivers/net/hyperv/rndis_filter.c |  136 +++++++++++++++++++++-----------------
 3 files changed, 83 insertions(+), 59 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -659,6 +659,10 @@ struct nvsp_message {
 #define NETVSC_RECEIVE_BUFFER_ID		0xcafe
 #define NETVSC_SEND_BUFFER_ID			0
 
+#define NETVSC_SUPPORTED_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | \
+				      NETIF_F_TSO | NETIF_F_IPV6_CSUM | \
+				      NETIF_F_TSO6)
+
 #define VRSS_SEND_TAB_SIZE 16  /* must be power of 2 */
 #define VRSS_CHANNEL_MAX 64
 #define VRSS_CHANNEL_DEFAULT 8
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1956,7 +1956,7 @@ static int netvsc_probe(struct hv_device
 
 	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
 
-	/* hw_features computed in rndis_filter_device_add */
+	/* hw_features computed in rndis_netdev_set_hwcaps() */
 	net->features = net->hw_features |
 		NETIF_F_HIGHDMA | NETIF_F_SG |
 		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1131,69 +1131,20 @@ unlock:
 	rtnl_unlock();
 }
 
-struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
-				      struct netvsc_device_info *device_info)
+static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
+				   struct netvsc_device *nvdev)
 {
-	struct net_device *net = hv_get_drvdata(dev);
+	struct net_device *net = rndis_device->ndev;
 	struct net_device_context *net_device_ctx = netdev_priv(net);
-	struct netvsc_device *net_device;
-	struct rndis_device *rndis_device;
 	struct ndis_offload hwcaps;
 	struct ndis_offload_params offloads;
-	struct ndis_recv_scale_cap rsscap;
-	u32 rsscap_size = sizeof(struct ndis_recv_scale_cap);
 	unsigned int gso_max_size = GSO_MAX_SIZE;
-	u32 mtu, size;
-	const struct cpumask *node_cpu_mask;
-	u32 num_possible_rss_qs;
-	int i, ret;
-
-	rndis_device = get_rndis_device();
-	if (!rndis_device)
-		return ERR_PTR(-ENODEV);
-
-	/*
-	 * Let the inner driver handle this first to create the netvsc channel
-	 * NOTE! Once the channel is created, we may get a receive callback
-	 * (RndisFilterOnReceive()) before this call is completed
-	 */
-	net_device = netvsc_device_add(dev, device_info);
-	if (IS_ERR(net_device)) {
-		kfree(rndis_device);
-		return net_device;
-	}
-
-	/* Initialize the rndis device */
-	net_device->max_chn = 1;
-	net_device->num_chn = 1;
-
-	net_device->extension = rndis_device;
-	rndis_device->ndev = net;
-
-	/* Send the rndis initialization message */
-	ret = rndis_filter_init_device(rndis_device, net_device);
-	if (ret != 0)
-		goto err_dev_remv;
-
-	/* Get the MTU from the host */
-	size = sizeof(u32);
-	ret = rndis_filter_query_device(rndis_device, net_device,
-					RNDIS_OID_GEN_MAXIMUM_FRAME_SIZE,
-					&mtu, &size);
-	if (ret == 0 && size == sizeof(u32) && mtu < net->mtu)
-		net->mtu = mtu;
-
-	/* Get the mac address */
-	ret = rndis_filter_query_device_mac(rndis_device, net_device);
-	if (ret != 0)
-		goto err_dev_remv;
-
-	memcpy(device_info->mac_adr, rndis_device->hw_mac_adr, ETH_ALEN);
+	int ret;
 
 	/* Find HW offload capabilities */
-	ret = rndis_query_hwcaps(rndis_device, net_device, &hwcaps);
+	ret = rndis_query_hwcaps(rndis_device, nvdev, &hwcaps);
 	if (ret != 0)
-		goto err_dev_remv;
+		return ret;
 
 	/* A value of zero means "no change"; now turn on what we want. */
 	memset(&offloads, 0, sizeof(struct ndis_offload_params));
@@ -1201,8 +1152,12 @@ struct netvsc_device *rndis_filter_devic
 	/* Linux does not care about IP checksum, always does in kernel */
 	offloads.ip_v4_csum = NDIS_OFFLOAD_PARAMETERS_TX_RX_DISABLED;
 
+	/* Reset previously set hw_features flags */
+	net->hw_features &= ~NETVSC_SUPPORTED_HW_FEATURES;
+	net_device_ctx->tx_checksum_mask = 0;
+
 	/* Compute tx offload settings based on hw capabilities */
-	net->hw_features = NETIF_F_RXCSUM;
+	net->hw_features |= NETIF_F_RXCSUM;
 
 	if ((hwcaps.csum.ip4_txcsum & NDIS_TXCSUM_ALL_TCP4) == NDIS_TXCSUM_ALL_TCP4) {
 		/* Can checksum TCP */
@@ -1246,10 +1201,75 @@ struct netvsc_device *rndis_filter_devic
 		}
 	}
 
+	/* In case some hw_features disappeared we need to remove them from
+	 * net->features list as they're no longer supported.
+	 */
+	net->features &= ~NETVSC_SUPPORTED_HW_FEATURES | net->hw_features;
+
 	netif_set_gso_max_size(net, gso_max_size);
 
-	ret = rndis_filter_set_offload_params(net, net_device, &offloads);
-	if (ret)
+	ret = rndis_filter_set_offload_params(net, nvdev, &offloads);
+
+	return ret;
+}
+
+struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
+				      struct netvsc_device_info *device_info)
+{
+	struct net_device *net = hv_get_drvdata(dev);
+	struct netvsc_device *net_device;
+	struct rndis_device *rndis_device;
+	struct ndis_recv_scale_cap rsscap;
+	u32 rsscap_size = sizeof(struct ndis_recv_scale_cap);
+	u32 mtu, size;
+	const struct cpumask *node_cpu_mask;
+	u32 num_possible_rss_qs;
+	int i, ret;
+
+	rndis_device = get_rndis_device();
+	if (!rndis_device)
+		return ERR_PTR(-ENODEV);
+
+	/* Let the inner driver handle this first to create the netvsc channel
+	 * NOTE! Once the channel is created, we may get a receive callback
+	 * (RndisFilterOnReceive()) before this call is completed
+	 */
+	net_device = netvsc_device_add(dev, device_info);
+	if (IS_ERR(net_device)) {
+		kfree(rndis_device);
+		return net_device;
+	}
+
+	/* Initialize the rndis device */
+	net_device->max_chn = 1;
+	net_device->num_chn = 1;
+
+	net_device->extension = rndis_device;
+	rndis_device->ndev = net;
+
+	/* Send the rndis initialization message */
+	ret = rndis_filter_init_device(rndis_device, net_device);
+	if (ret != 0)
+		goto err_dev_remv;
+
+	/* Get the MTU from the host */
+	size = sizeof(u32);
+	ret = rndis_filter_query_device(rndis_device, net_device,
+					RNDIS_OID_GEN_MAXIMUM_FRAME_SIZE,
+					&mtu, &size);
+	if (ret == 0 && size == sizeof(u32) && mtu < net->mtu)
+		net->mtu = mtu;
+
+	/* Get the mac address */
+	ret = rndis_filter_query_device_mac(rndis_device, net_device);
+	if (ret != 0)
+		goto err_dev_remv;
+
+	memcpy(device_info->mac_adr, rndis_device->hw_mac_adr, ETH_ALEN);
+
+	/* Query and set hardware capabilities */
+	ret = rndis_netdev_set_hwcaps(rndis_device, net_device);
+	if (ret != 0)
 		goto err_dev_remv;
 
 	rndis_filter_query_device_link_status(rndis_device, net_device);
