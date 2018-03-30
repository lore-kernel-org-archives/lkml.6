Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393950-2-6732852386728240592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393949; b=Awi+FGBiVPQoD7KgNxZsGSOfCmuL4dJVw+oFZMSLcWzd+zXuZY
    VRZ9LtasnO/ROQf6l3uGogQ9oEiF2sFwuA5vfBalkQwNKpy53ovzKZundRn8LcFs
    2qsrGDud5sR3Kng7cC9Ah98o+otZehW3YVrUkYhnrTolWRfWVgRpGwcYyFBWZQGc
    Hu56qp16wEIsVC68dNorf5Cja1j8jnHadGwpXsvfgt70W9w6iKSot56ivNOtmpSM
    0N/MIXACpRkwTf7qum05W7wp6zTcMXhudRBu5zn59UrMQ5hLuVHIi0sa3by2fKs5
    rXmcD8muQJkpcIkaja9MLTdsTAmYJQC7pETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393949; bh=ynbyS
    cCNWiJwspfUTWwJwTmiNJcdgavhiyMCJM5D/oo=; b=CtuvOWc3gifwQC3Ox9NYq
    jbX5DRUzAyY36PMWLO8u+ZlVGaspZEC3ZZkvySE7HoZl+is6lPH/xK+Zp5jptimb
    j5vZNXtytZuzjL4KaF8HOrmnmymiBs+FtmH34EsEm5VIPIX07a9xb4Xgpit2Yohs
    O3BoUAxj6MAFis7ZBk91Pl/VW7u2MceW43RetfBZ6QzTGuq/rJF6JIlcRliieE4l
    12CKAjDrQ2P5MNG4ycXPDXSVT6v8sGs3XKOB2dGPEE6KQT/IRN9rKulIa7WuO1xV
    gnjiqRRgB5u8160zfRZpBLsPZ54bzns3n6UpBAIzGhH0L0UGaqdExQDvuKVY34mB
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCdo6YEMcz7NTB3rvYvMKNB3sjm2+h6UoWG2+ktuTK2YWiyIvZqG76UAmTeDRdgAff8tKBXhuO9Hw+bOApg9k9ctU38Vs2OoCVYyhY6qI3bdW8sDUPyO
    UBDR1lSX8ZLhOvO5HLHF2wH0IVNylTyyKi5KKyHX0ttVqCoysaTD/2VmyphDXpXE+B6/B8h7mdUvAUCKcdbvHgktvwI/2E0I7TT7IzkVvjAbGe3fSju62TYC
    J5wEGfZSQFrxkKcp8SzcHg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=WViqsyEikia18ScypdwA:9 a=qGk6-U9juxUtcDam:21 a=PMFspyTolO56ygH5:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 71/72] staging: ks7010: Remove 'eth_addr' field from 'struct
 ks_wlan_private'.
Date: Fri, 30 Mar 2018 00:08:35 -0700
Message-Id: <20180330070842.25224-72-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:/96/ck1mZTLpOHBD9PmOxDy+th6rdmc2ECMTLk5aJjNVTL0RLBf
 pieP3QahKrrQ1Phui81kRXggrUK2rBbbWukcWnK0wWk5z/LSIaQ/BiHOZQe54+oxnqbYoAu
 V0QhIgAmY8FTHl79h1ikc9DYoS+U37OaWP3QUOLQPpBeYWgn0zG5LeUPJpP7X/gu/nGEaNw
 lZQzxOiSr72oWbq5+rOKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AO4gmf9DY+g=:buc2Clv+OYJi70edFBY9Vb
 0UXptBBiVkORuNLGi+pw232CwGt0SYCr9PWxGevEOlyW5BLqDXoKs5qx18u/53HBOnvor2bY1
 gJn/MDZn9f52jxkDKyOW4M4PIx5UdNLVqfeSn2cDKCNyj+Rb9xoazMYysVeOptJiJmh/4JE1X
 BrMrlFItJJkTuaHaI1kfL2xVp2R53aPdWfrp7cDl6NbWKoEEXs9TUL63dV2+RNzosaNIAgARB
 WowWX3GRWFXqmHy8Dytkezg7OlTEyGJ7c1vZjpdm1w2oLiZXkZHRMdEhHY7+JdKVzc8cKvtSQ
 Jc4OCkzOZVa0gTTf76UqDGyF6nM4popp0hAEGr5/UsNqOk/cMVKxNkfm2RpQnYtW1liOnsKVM
 lQ0SPIk0HLpDDQu3cLReUA9cz/WHDZKD2ixY+zdWZOEU0ygiv7sSKB5ZwWtQiLTBtuIf/Xmgw
 fokdEsiHEtgKUoWKbRqirH13ZVFYTeklFFn3eD7B/atc4MRbTWX7u6rjt0Dhc9wlJNw9Gaulz
 F2aXCeym3yPNWY6a584bKmJqNFLWRHQZluIHCoKypNyFCmpakBnvwfcjyBJoETmuSkP1bwjRF
 u5Zj67pvDzzphjS61RVrj8uSsFbKFC78en/OqY1Qeh732g0A1WcHLOa/xYsttvxm8+xRZx0aO
 QU2PFJjlWfgHO9T6jlxeW/gp72yUNfIbyd4MCnPRemUIBHoHDFksKX9TXAb1WWY5A7cYI2PPx
 lHHzR7YoranRG/PC3yKOKvx/jmwfNevopc0Lug==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ethernet address of the network device is already stored in the
'dev_addr' field of 'struct net_device'.  Since 'struct ks_wlan_private'
keeps a pointer to the driver's 'struct net_device', there is no reason
to duplicate this information in 'struct ks_wlan_private'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 29 +++++++++++------------------
 drivers/staging/ks7010/ks_wlan.h     |  2 --
 drivers/staging/ks7010/ks_wlan_net.c |  5 ++---
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 1eff78540683..3c8a8d0f800c 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -388,6 +388,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 static
 void hostif_data_indication(struct ks_wlan_private *priv)
 {
+	struct net_device * dev = priv->net_dev;
 	unsigned int rx_ind_size;	/* indicate data size */
 	struct sk_buff *skb;
 	unsigned short auth_type;
@@ -411,9 +412,9 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 	eth_proto = ntohs(eth_hdr->h_proto);
 
 	/* source address check */
-	if (memcmp(&priv->eth_addr[0], eth_hdr->h_source, ETH_ALEN) == 0) {
-		netdev_err(priv->net_dev, "invalid : source is own mac address !!\n");
-		netdev_err(priv->net_dev,
+	if (memcmp(dev->dev_addr, eth_hdr->h_source, ETH_ALEN) == 0) {
+		netdev_err(dev, "invalid : source is own mac address !!\n");
+		netdev_err(dev,
 			   "eth_hdrernet->h_dest=%02X:%02X:%02X:%02X:%02X:%02X\n",
 			   eth_hdr->h_source[0], eth_hdr->h_source[1],
 			   eth_hdr->h_source[2], eth_hdr->h_source[3],
@@ -443,7 +444,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 			priv->nstats.rx_dropped++;
 			return;
 		}
-		netdev_dbg(priv->net_dev, "SNAP, rx_ind_size = %d\n",
+		netdev_dbg(dev, "SNAP, rx_ind_size = %d\n",
 			   rx_ind_size);
 
 		size = ETH_ALEN * 2;
@@ -463,7 +464,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 			priv->nstats.rx_dropped++;
 			return;
 		}
-		netdev_dbg(priv->net_dev, "NETBEUI/NetBIOS rx_ind_size=%d\n",
+		netdev_dbg(dev, "NETBEUI/NetBIOS rx_ind_size=%d\n",
 			   rx_ind_size);
 
 		/* 8802/FDDI MAC copy */
@@ -480,7 +481,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 		aa1x_hdr = (struct ieee802_1x_hdr *)(priv->rxp + 14);
 		break;
 	default:	/* other rx data */
-		netdev_err(priv->net_dev, "invalid data format\n");
+		netdev_err(dev, "invalid data format\n");
 		priv->nstats.rx_errors++;
 		return;
 	}
@@ -522,17 +523,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	case DOT11_MAC_ADDRESS:
 		/* MAC address */
 		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
-		memcpy(priv->eth_addr, priv->rxp, ETH_ALEN);
+		memcpy(dev->dev_addr, priv->rxp, ETH_ALEN);
 		priv->mac_address_valid = true;
-		dev->dev_addr[0] = priv->eth_addr[0];
-		dev->dev_addr[1] = priv->eth_addr[1];
-		dev->dev_addr[2] = priv->eth_addr[2];
-		dev->dev_addr[3] = priv->eth_addr[3];
-		dev->dev_addr[4] = priv->eth_addr[4];
-		dev->dev_addr[5] = priv->eth_addr[5];
-		dev->dev_addr[6] = 0x00;
-		dev->dev_addr[7] = 0x00;
-		netdev_info(dev, "MAC ADDRESS = %pM\n", priv->eth_addr);
+		netdev_info(dev, "MAC ADDRESS = %pM\n", dev->dev_addr);
 		break;
 	case DOT11_PRODUCT_VERSION:
 		/* firmware version */
@@ -1111,7 +1104,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 
 	/* skb check */
 	eth = (struct ethhdr *)skb->data;
-	if (memcmp(&priv->eth_addr[0], eth->h_source, ETH_ALEN) != 0) {
+	if (memcmp(priv->net_dev->dev_addr, eth->h_source, ETH_ALEN) != 0) {
 		netdev_err(priv->net_dev, "invalid mac address !!\n");
 		netdev_err(priv->net_dev, "ethernet->h_source=%pM\n", eth->h_source);
 		ret = -ENXIO;
@@ -2167,7 +2160,7 @@ void hostif_sme_execute(struct ks_wlan_private *priv, int event)
 	case SME_MACADDRESS_SET_REQUEST:
 		hostif_mib_set_request(priv, LOCAL_CURRENTADDRESS, ETH_ALEN,
 				       MIB_VALUE_TYPE_OSTRING,
-				       &priv->eth_addr[0]);
+				       priv->net_dev->dev_addr);
 		break;
 	case SME_BSS_SCAN_REQUEST:
 		hostif_bss_scan_request(priv, priv->reg.scan_type,
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index eb0c14e78bd2..012e0fe2b60d 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -421,8 +421,6 @@ struct ks_wlan_private {
 	struct work_struct wakeup_work;
 	int scan_ind_count;
 
-	unsigned char eth_addr[ETH_ALEN];
-
 	struct local_aplist aplist;
 	struct local_ap current_ap;
 	struct power_save_status psstatus;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index e98f6163e724..32515c296ca6 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2749,11 +2749,10 @@ int ks_wlan_set_mac_address(struct net_device *dev, void *addr)
 	if (netif_running(dev))
 		return -EBUSY;
 	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
-	memcpy(priv->eth_addr, mac_addr->sa_data, ETH_ALEN);
 
 	priv->mac_address_valid = false;
 	hostif_sme_enqueue(priv, SME_MACADDRESS_SET_REQUEST);
-	netdev_info(dev, "ks_wlan:  MAC ADDRESS = %pM\n", priv->eth_addr);
+	netdev_info(dev, "ks_wlan:  MAC ADDRESS = %pM\n", dev->dev_addr);
 	return 0;
 }
 
@@ -2884,7 +2883,7 @@ int ks_wlan_net_start(struct net_device *dev)
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
 
 	/* dummy address set */
-	ether_addr_copy(dev->dev_addr, priv->eth_addr);
+	ether_addr_copy(dev->dev_addr, dummy_addr);
 
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
