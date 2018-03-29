Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302756-2-467866758211222466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302755; b=Yn1GOTz9uzuSR4gMIcHQd1mY9+dIPVlZmgrSW9/I4Nzq5Yg
    Pdl1vBEkNKop+cIgQBKuW1tOI9KMfd8rC40UuBs3cWFpMPUT4acFklX6o+mIdKai
    8PzMrFPEI/TLaGKj42X3ZYvmB9wGqoYVLmJJFBZzH3YSNZcTpOm38IixcsFKN9ke
    GTf2IDRjFHF0sBxS4r12c7J5ANdTfdiqYsIwSVEWU8YiyKFSmDLVzP9mhole3LnT
    cdrThB5auLXRnXBA7E4a9iV4//jOSK9rUII25ff7i61GIPdXHwh0NEDTCI45JlBP
    0BqhxL0PVxvb7jCS6NcJpjh29MNDM7py7Z7AVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302755; bh=9
    sbmqyBS/CWRKnBrdy2vqWXuPwXWFLPegGByGqyNsAE=; b=qIlF9cjky3pySX4na
    ZpTloTB7Vkw2Ooz6CVfBgLm+iOShOPziJOxtRUlJIBBIMM7IJw5WWNNOuOd/1eqW
    LNoBAHeKHD2IFmPbh6q91ockEe52WRlacq/RMRxIS1wD0s79Ior9SwTp4bBV8LyE
    DO+8+iRQ+zvVx7DGVejGLIlU1rxWcci8zS5w68iUSkAdMRr3GiBPp4JCQLXZlBuw
    qsN6G39pPmXYZyG32f+yrxw1fFyud2QYU2gXMyfy5lhiDMHZjHIbqm05qJc0uzom
    UrzSEKe4kRfOa1gbFY7ftBY6vQsqeI7dCJdHNv2q4VVEjT2f1Vv7vks2TxXu2XtA
    dvTKQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNOAW8RhIvTjQsiO6d/fShccJI9aLTN0wixnJunUnjucfWLAms1YLEsIM96rWhhGSuzCwRYj2kL0o0/u+dkWmiEafEJ5+T8TkIvNn9xaQDWfZaNdUVQD
    JWJfFXxagAaSwqARjIekiiP9Om2Uj/O4fCFttYdA3EEB9ES9w+Yr4IWNK/a8auHyTvFlZAd2i8VxQyeDIz4XHCIxycoTIVYJti90YhDzKPu6jje3+ijE9MSM
    /lNKEaV+BZB9caiUYqpcdQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=WViqsyEikia18ScypdwA:9 a=qGk6-U9juxUtcDam:21 a=PMFspyTolO56ygH5:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 8/9] staging: ks7010: Remove 'eth_addr' field from 'struct
 ks_wlan_private'.
Date: Wed, 28 Mar 2018 22:51:51 -0700
Message-Id: <20180329055152.13059-8-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Czb1dI8F3D50oJrJ9FWrIZ+RFWgN/coAdBssaQuuMEWhvhFbT4Z
 Sn+ZXQIsYvWqGgJR7G1sPuufh/9PiJKkiSMoc6938QDsYABa1/GSfda3iF/jHRgLJ9mb4s3
 UtkSL7gDXKiLOXwyu1fa8YpOApbhz4OBwnZpK/eTTMtft9l25PQzKxWwU/1BJlDm246WFgx
 eiGiC8xELaLH9WmyOhdbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+GxKkPXd/Po=:TNK/Y+TYufM+PVf6DlYPA+
 1RAuEMBRvmqNqEU5mUsoiPloq92JcjPV7THZHTq1LxTpkdUoHjpX+ZrvgC1bEoYLsJNvxcB0d
 WErVibKUyrzML6tt8MkJqV0rlRDM8FfZhUND38N8uyR9C/S65Glr5z/tEG8q1ewqXtot/nfh2
 gyiMSUF8Dr4+XjO1tE5R2r1k91ucu24QvmTihp6dDRDuTZbJoLZzWI33nmJIfbC5ghwGsa+0/
 EXisW2yP/3VOJyX/3O53elmFgvyXRus+wS9OBExwk5n1hjA8BoXLjs7FCG6Wp2VQ2q+3FmN3a
 y96JHBVc1KrScH6JsAILzUN2bghuIcEN1nif8Qs+ZsoIOB9hvHATuolqyeh4Ighj3bkDsuJYg
 /Gsyv0XnGBBqb+3FOdmiAUc3yoP7KuTbV0j+2A8PPV4LGxvt+wmv8kPZiyMbOMxZkJmrbfouI
 xKDUuc0kQiN/RUz0NWSD7uYsdJzq31N0PrZgS/8s3yQdMCBRHBIMNfldTicNhiMPJDaEYsrcz
 lc695Sti6HFHIzpjrRVrLI++u+I13IgJ7PgnyoPN1+r67GIbv/YGfYeIiunFC/Po/g6fWBEEo
 XFPZ3RvKfTxXkjOU0R+rGETiutDO5HN6MT8OPwF8TxO1ExXkbE1E6ImWOB2vSKFGTlPIAhekQ
 5LmC3dbgQqndsSlBTjyqiWdHNM5sU+DrXBxM4DmJPN/VjNRE9cPLzsTGMUZJ/eXvIrckCqIuZ
 jM3JaMOodb3gfBiJsS5yxVou5P5Bh7MlJDkwfA==
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
index a4020eeaac18..7bb0a6dffe61 100644
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
index 999a929b8083..3a717100a284 100644
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
index d1296008dbf9..e1a74566b351 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2765,11 +2765,10 @@ int ks_wlan_set_mac_address(struct net_device *dev, void *addr)
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
 
@@ -2900,7 +2899,7 @@ int ks_wlan_net_start(struct net_device *dev)
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
