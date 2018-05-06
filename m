Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800236-1525644195-2-18288413266814931439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525644194; b=WPlAwidpBHzTOJsriXBo6q69kxJ6V264viXmDLj+6XdX0XcHnU
    l/JgTVZysGoei8K1bPN5eQMS618M/AGoFlz0/RMRnIxk7Ibp0UsmVRZ6CSFOTAlg
    tPp/0WywOPy4vn8KbsYp342QhjjV+T/74oDFG/xsV5wJov22NYQuqpxNd/fybz3F
    QKRmjB0EP1HxvBuk3ZdWYbvZmPjx2t3zDK98N32h13r5IGaykpQVx6X8OBwM5zlz
    6cB46Jvccq/75TLgxhxx/m6r3bmDe9F7DGhio8+cyTzcBNcQ9AivK9k+cnrSevv1
    pE0qoU1/jZV48pZSXmBSph4/W6+xNJOOQNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525644194; bh=131Gc
    Ob28duXhrDEHZ9pPPGFvRHxbTExxKEglYe+Cuo=; b=k0mRa9TvpYsjV0MUuiDZ8
    aNmETZjrKDglWG+ayNVWw7EmB5oC86OeVhJjputbWCQ1ZMQ+3qFHL/Ghrx7ZXl+b
    o8Cy3jLReIO5MnAfhAu+Gsvl8oXQGsDVPZSBLja13lAECVfMaKO+PEs0hn8ri1cO
    YnigCqSfenn0DnFgVhYn6ARQx90UoE2qFuJfjjWwbtmM4KtaRG6fiAmL7D1M1+kU
    6y94YiAPec8S1UqjrNsux84oWG3Yhgjm+sJFR00bmw8XqBH4cYNsE4Q9nl3YbCHn
    6TTvSk1u5NzUTTFkLnXTY6dn6PrfWKrgjIl1N3IHQ90Y7WxKPgTc9b96ikRVKLqo
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Y1N3zDRM x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KUfC1TpE;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Y1N3zDRM x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KUfC1TpE;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHUSshtEbZUscnrjWCQMf/7lWwUN9wbyLzt6He7JZzB+WiF9jgGjUhfzI/iK8SRaOW5SJtgCkCLpEzo6fAoj4KYN8JYW51f20MCAdjhXrF+frhLDD8Op
    Le3R+QXOcWsUPCCQBJAMKGhdH836QUe66/oCQCx1e8G2RoqOZOmMa3OP18Q3stHzuLYReys1z2RU5dljdfduE+Qx8Bz14uYPzbJ2Fcv0GSmJN5CvEtkmaz2r
    TFvVsA2YicYyes6bUQUrkA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=vw-cejXWSG0FWo1D87gA:9 a=33cqxYCK0J4wa9zF:21
    a=cJtQEgNSau4BC3K3:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrFthNF4pzEwdj8JwUJJNiKleD/2BMIMkIq2+b40ksmokMhef6wMQoEbfWwofmSmAJwlePNUw==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 7/7] staging: ks7010: Move from bool to int in structs
Date: Sun,  6 May 2018 15:03:04 -0700
Message-Id: <20180506220304.13040-7-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506220304.13040-1-natechancellor@gmail.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch.pl warnings.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c   | 4 ++--
 drivers/staging/ks7010/ks_wlan.h     | 4 ++--
 drivers/staging/ks7010/ks_wlan_net.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 628171091786..43090922daff 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -475,7 +475,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	case DOT11_MAC_ADDRESS:
 		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
 		ether_addr_copy(priv->eth_addr, priv->rxp);
-		priv->mac_address_valid = true;
+		priv->mac_address_valid = 1;
 		ether_addr_copy(dev->dev_addr, priv->eth_addr);
 		netdev_info(dev, "MAC ADDRESS = %pM\n", priv->eth_addr);
 		break;
@@ -582,7 +582,7 @@ void hostif_mib_set_confirm(struct ks_wlan_private *priv)
 		hostif_sme_enqueue(priv, SME_MULTICAST_CONFIRM);
 		break;
 	case LOCAL_CURRENTADDRESS:
-		priv->mac_address_valid = true;
+		priv->mac_address_valid = 1;
 		break;
 	case DOT11_RSN_CONFIG_MULTICAST_CIPHER:
 		hostif_sme_enqueue(priv, SME_RSN_MCAST_CONFIRM);
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 5070af86115f..ffe0e80277c9 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -411,7 +411,7 @@ struct ks_wlan_private {
 	unsigned int need_commit;	/* for ioctl */
 
 	/* DeviceIoControl */
-	bool is_device_open;
+	int is_device_open;
 	atomic_t event_count;
 	atomic_t rec_count;
 	int dev_count;
@@ -423,7 +423,7 @@ struct ks_wlan_private {
 	unsigned char firmware_version[128 + 1];
 	int version_size;
 
-	bool mac_address_valid;	/* Mac Address Status */
+	int mac_address_valid;	/* Mac Address Status */
 
 	int dev_state;
 
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 0c83d6fe270f..30c03f5d0ec1 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2504,7 +2504,7 @@ int ks_wlan_set_mac_address(struct net_device *dev, void *addr)
 	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
 	memcpy(priv->eth_addr, mac_addr->sa_data, ETH_ALEN);
 
-	priv->mac_address_valid = false;
+	priv->mac_address_valid = 0;
 	hostif_sme_enqueue(priv, SME_MACADDRESS_SET_REQUEST);
 	netdev_info(dev, "ks_wlan:  MAC ADDRESS = %pM\n", priv->eth_addr);
 	return 0;
@@ -2627,8 +2627,8 @@ int ks_wlan_net_start(struct net_device *dev)
 	/* int rc; */
 
 	priv = netdev_priv(dev);
-	priv->mac_address_valid = false;
-	priv->is_device_open = true;
+	priv->mac_address_valid = 0;
+	priv->is_device_open = 1;
 	priv->need_commit = 0;
 	/* phy information update timer */
 	atomic_set(&update_phyinfo, 0);
@@ -2652,7 +2652,7 @@ int ks_wlan_net_stop(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
-	priv->is_device_open = false;
+	priv->is_device_open = 0;
 	del_timer_sync(&update_phyinfo_timer);
 
 	if (netif_running(dev))
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
