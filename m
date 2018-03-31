Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/rR6QkKlFRMkSTPIRlQfAo+8eK1jbgMNcXYoauIjkCUwGxC0UCZoJJ06bezMXusRuzMS2J
ARC-Seal: i=1; a=rsa-sha256; t=1522476623; cv=none;
        d=google.com; s=arc-20160816;
        b=p0T3LkFBOtyuKgmwdv9SLATd8Qcov6K6Q89Axlo2N5ziHkG3gVQhi9bqqY9xjAPcwu
         Chk/pSvqATCucJ4vgQssk2sDgyJyLzqlHt7ddl3uoIZIHtUcgeSlgUWRjLCwk68auMYs
         zjshqVeHVAdd59Nz4856nzMgUjaNGwg7SqCv+iQ6mqga9KB17iKoxcPmSwyM/9QuUIOU
         lqQ+m9CXKpu9rcdr249VUYVVs5M/1Rwp5WZBWAMyHX3hMSyCExuQYXmqeuhmBMjilfKZ
         KFL6C7KVNkcz+PQ8w6T+m6avJ0fyuXI4D6EW9Qia6m+gtylGKHROi5N6CJZkuJLnFYdY
         8DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=zxrzo0hAlJaep/Qbo03IliABX62+t3O78Nul44RqLQQ=;
        b=HvIneBaGii6D6kIwcB2U6qEL4cnnFiydfgbhIoruyUb+z8QW/QGwRFKDLF1EmkzV6m
         SuAWSKXtF2VGYLP5qG3padFK+bS5x2DCmuUbqB22cPAmykzqnQaG+LI1UESLUa7g8COF
         kjBDJ2wE8ccPwt7w41a9aXpIbdAGPvZlKTLsaUFrBxL15DzkUmVlxn1ztUkp6cYr0PTL
         yy5BUT1PpDYYyClWbqwmf40VLiFiir3AUGGap5blZeweXxvzAhqlzMo1XYHVryv+i7pf
         O9TZHxrLkiUzXKAzWZWfZV1BtLwfXm2vnFJLnEcak3VKNR86Rc5uKT8PVpD+lm/d5j5K
         yLFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 68/75] staging: ks7010: Replace manual array copy with ether_addr_copy().
Date: Fri, 30 Mar 2018 23:08:48 -0700
Message-Id: <20180331060855.9452-68-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Z5NBRnrFt4ia88h8DGECJWx1551bHxbdePpzmf4W9koXt+3nCwG
 gqAT1x1TYpw4Xx6/WVavGutV0+3l7Ba083u3j/rSNALKYwbVxVCbGrbnEMdl762W5rvgc9A
 FBKcZpJ//RX3fcJCvmh6CcwR3rzeYQK7YvP8hOGHpKGmjHNx9EdU/KjwvI4T2dm5BbfDah1
 BdK+1LBu9R4u+afrfDpkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MAPIeVDJSbY=:qRdCydD9e8dUZyikb5Dduo
 nYO7Bv3kJpBpNhyyPpweIXJy/0zOHYV1stLXcqyX2fn3H9kul5fjYkhUwTdpxqTiFHwj6TNKz
 Y5YhY2qrGA3rUt8r3DSgJVctQPaGEOULDzAxFQ2U+3zQm9U6ebhoEbdjE0umXKGJhUm/n3QmK
 m3zAML5LVZFpEAtoXS3EnwDpziY3BDAolxqXHN0q8/OUe5CJwN3v4nHQF1pJ6vNUfTvQtCaZO
 ghHlndfP45mRdgeW829Ce6V0k7lwbw9F2edHMJQMfgFfsrfjntdlGWU4uIkZsN/zTu4u5kCnu
 pIeYncugpTwWO0TClzW1DUUVqYpRbcTecRDDVFcRfz4HxiBS7duDLtyAeE2heQM/xNY0BVfiB
 UpwsWLx9SBxUCQGgHvQWUdLyh6rDp5jMDIyhyggh3mfZq83UZak/uaTWR2TqGLuoKPcsIqlWm
 melrLzRhNNoqO2dhIf8YXbKaRWfNjuIoBUfxdBvmLPxqb4EFP2bqNL+f9/lhPBIYS2ESvFFZs
 NxRqMEZ+RAyeoQ+TePUKn8ydGmorhoXpHMAs0IP2cPsSXwqvujEBw4gPbveypwSX9itp2Envu
 gNoor4w94dJMRO1hKWgX+io5kEX0vFZsDkL92Fmro4h3H7aFE0tjOATD8or1FJnbh40/xQQjq
 0wybC3GLV8YWJBXfJ30fbrYqyLiM8Wu+lSin+Ma29Wqy9sodDIFuuDRyZn4Qkm/TOfLUuIzVg
 HP8rChzTL1xnI74jNhXEIPAYfy3dCBy5mh1ETA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432448143728817?=
X-GMAIL-MSGID: =?utf-8?q?1596432448143728817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copying the dummy HW address into the struct net_device doesn't need
to be done byte by byte; use ether_addr_copy() instead.
Additionally, dev->dev_addr is not eight bytes long.
ether_setup() sets the dev->addr_len to ETH_ALEN (defined as 6)
in the net core code.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 29 +++++++++++------------------
 drivers/staging/ks7010/ks_wlan.h     |  2 --
 drivers/staging/ks7010/ks_wlan_net.c | 13 ++-----------
 3 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 1eff78540683..23c637ef147d 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -388,6 +388,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 static
 void hostif_data_indication(struct ks_wlan_private *priv)
 {
+	struct net_device *dev = priv->net_dev;
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
index 72a52c6f9fd2..35c615433687 100644
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
 
@@ -2884,15 +2883,7 @@ int ks_wlan_net_start(struct net_device *dev)
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
 
 	/* dummy address set */
-	memcpy(priv->eth_addr, dummy_addr, ETH_ALEN);
-	dev->dev_addr[0] = priv->eth_addr[0];
-	dev->dev_addr[1] = priv->eth_addr[1];
-	dev->dev_addr[2] = priv->eth_addr[2];
-	dev->dev_addr[3] = priv->eth_addr[3];
-	dev->dev_addr[4] = priv->eth_addr[4];
-	dev->dev_addr[5] = priv->eth_addr[5];
-	dev->dev_addr[6] = 0x00;
-	dev->dev_addr[7] = 0x00;
+	ether_addr_copy(dev->dev_addr, dummy_addr);
 
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
-- 
2.16.3
