Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D529C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07C32086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6CgFSK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07C32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIHTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:47:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40720 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeIHTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:47:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id x26-v6so14239353lfi.7;
        Sat, 08 Sep 2018 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TP+hlF8grn9PTH3MZmgWyJTGGClsg/su9XUq2tmQ9oM=;
        b=J6CgFSK6KLYUpZG+i8lgNeEcdzKOZEIOtubpwhFpVs23sHFK0UG023Fv14bjKhGbgE
         3Vvs7IDPOYrjFxCq1NX1OLZ1C/FtudPZYSDGnAgy5yl5ytHD4EMCTSyDXMCI52QM3hyl
         RTT20Ont//lgQ4pBZUUZVU6HKvmHBlqulSkTZA5q+fwLYRjkabGcmWVFttkstq3Yf+2z
         kWMu+iInX2EW4Ie4r8+f8jNQK5+lPAlI3s/ANPPpvlUpYwAnwR5ZajswIgNOGn/CGnE3
         GzKBJqbDneX5/tJLEJsmw0zaKPVoEo1gE6nmORzArE8lXnjq5Fl+2OIHvVjFcAbouj0b
         bTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TP+hlF8grn9PTH3MZmgWyJTGGClsg/su9XUq2tmQ9oM=;
        b=hX3zRRq+B2vDyqGrphhvyItSAm8CjhGh2Qu6kUs8ydBk99dt5riqE7r1M4ciFJBtff
         59pqBH4ZpRn3KRJelnMHCDMfRY83u+2AyvlrS1Nt8zO23fWANaX1tx4lccBBCPT5Y3dS
         hLTXcSupYD5NEZk3/XJOv7VPexLLX7R8IqyArit6dWH2wFZ7m41aes28m7/rDHyWIpDS
         jFhv/ZlUS9mymW3ZfeJWBGnupjoYxqUls+r7cd45BkMNXYuy6RgcuHORm45XbPOQmzNI
         Muv6B4rkyHLEAMTn36IFR4moMyRBiikHkg7y8swAxVl8wWAzRB1Be9temQi3M/k6HaRT
         5yUg==
X-Gm-Message-State: APzg51C3FUJLGZaNrUZdGY+u9HiYukFxNfgcxlJobkU6VAyFr6FOR495
        BbRfFIc4ZPMSYmoaiHfogcOiDtuBLwM=
X-Google-Smtp-Source: ANB0VdYz546uIDQ0DLfsTbsFz1Awt/QJuhMFPpz/oDsbTYg1TEx3uGITksGEAGO957oPikgygPNA9w==
X-Received: by 2002:a19:6d12:: with SMTP id i18-v6mr7831117lfc.72.1536418910711;
        Sat, 08 Sep 2018 08:01:50 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id o8-v6sm1757733ljg.39.2018.09.08.08.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 08:01:50 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ethernet: hnae: drop adhoc assert() macros
Date:   Sat,  8 Sep 2018 18:01:42 +0300
Message-Id: <20180908150142.27976-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace assert() with a less misleading test_condition() using WARN()
Drop one check which had bitrotted and didn't compile anymore.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: huangdaode <huangdaode@hisilicon.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/hisilicon/hns/hnae.c     |  7 ++--
 drivers/net/ethernet/hisilicon/hns/hnae.h     | 34 +++++--------------
 .../net/ethernet/hisilicon/hns/hns_ae_adapt.c | 16 ++++-----
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 12 +++----
 4 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
index a051e582d541..bd64e6092e4b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -203,11 +203,12 @@ hnae_init_ring(struct hnae_queue *q, struct hnae_ring *ring, int flags)
 	ring->flags = flags;
 	spin_lock_init(&ring->lock);
 	ring->coal_param = q->handle->coal_param;
-	assert(!ring->desc && !ring->desc_cb && !ring->desc_dma_addr);
+	test_condition(!ring->desc && !ring->desc_cb &&
+		       !ring->desc_dma_addr);
 
 	/* not matter for tx or rx ring, the ntc and ntc start from 0 */
-	assert(ring->next_to_use == 0);
-	assert(ring->next_to_clean == 0);
+	test_condition(ring->next_to_use == 0);
+	test_condition(ring->next_to_clean == 0);
 
 	ring->desc_cb = kcalloc(ring->desc_num, sizeof(ring->desc_cb[0]),
 			GFP_KERNEL);
diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index 08a750fb60c4..47dec7590079 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -43,23 +43,9 @@
 #define HNAE_DEFAULT_DEVICE_DESCR "Hisilicon Network Subsystem"
 
 #ifdef DEBUG
-
-#ifndef assert
-#define assert(expr) \
-do { \
-	if (!(expr)) { \
-		pr_err("Assertion failed! %s, %s, %s, line %d\n", \
-			   #expr, __FILE__, __func__, __LINE__); \
-	} \
-} while (0)
-#endif
-
+#define test_condition(expr) WARN_ON_ONCE(!(expr))
 #else
-
-#ifndef assert
-#define assert(expr)
-#endif
-
+#define test_condition(expr)
 #endif
 
 #define AE_VERSION_1 ('6' << 16 | '6' << 8 | '0')
@@ -314,16 +300,16 @@ enum hns_desc_type {
 	DESC_TYPE_PAGE,
 };
 
-#define assert_is_ring_idx(ring, idx) \
-	assert((idx) >= 0 && (idx) < (ring)->desc_num)
+#define is_ring_idx(ring, idx) \
+	test_condition((idx) >= 0 && (idx) < (ring)->desc_num)
 
 /* the distance between [begin, end) in a ring buffer
  * note: there is a unuse slot between the begin and the end
  */
 static inline int ring_dist(struct hnae_ring *ring, int begin, int end)
 {
-	assert_is_ring_idx(ring, begin);
-	assert_is_ring_idx(ring, end);
+	is_ring_idx(ring, begin);
+	is_ring_idx(ring, end);
 
 	return (end - begin + ring->desc_num) % ring->desc_num;
 }
@@ -336,8 +322,8 @@ static inline int ring_space(struct hnae_ring *ring)
 
 static inline int is_ring_empty(struct hnae_ring *ring)
 {
-	assert_is_ring_idx(ring, ring->next_to_use);
-	assert_is_ring_idx(ring, ring->next_to_clean);
+	is_ring_idx(ring, ring->next_to_use);
+	is_ring_idx(ring, ring->next_to_clean);
 
 	return ring->next_to_use == ring->next_to_clean;
 }
@@ -592,10 +578,6 @@ int hnae_reinit_handle(struct hnae_handle *handle);
 #define hnae_queue_xmit(q, buf_num) writel_relaxed(buf_num, \
 	(q)->tx_ring.io_base + RCB_REG_TAIL)
 
-#ifndef assert
-#define assert(cond)
-#endif
-
 static inline int hnae_reserve_buffer_map(struct hnae_ring *ring,
 					  struct hnae_desc_cb *cb)
 {
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index b52029e26d15..6ff391ccdd7a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -264,7 +264,7 @@ static int hns_ae_set_multicast_one(struct hnae_handle *handle, void *addr)
 	struct hns_mac_cb *mac_cb = hns_get_mac_cb(handle);
 	u8 port_num;
 
-	assert(mac_cb);
+	test_condition(mac_cb);
 
 	if (mac_cb->mac_type != HNAE_PORT_SERVICE)
 		return 0;
@@ -494,7 +494,7 @@ static void hns_ae_get_pauseparam(struct hnae_handle *handle,
 
 static int hns_ae_set_autoneg(struct hnae_handle *handle, u8 enable)
 {
-	assert(handle);
+	test_condition(handle);
 
 	return hns_mac_set_autoneg(hns_get_mac_cb(handle), enable);
 }
@@ -511,7 +511,7 @@ static int hns_ae_get_autoneg(struct hnae_handle *handle)
 {
 	u32     auto_neg;
 
-	assert(handle);
+	test_condition(handle);
 
 	hns_mac_get_autoneg(hns_get_mac_cb(handle), &auto_neg);
 
@@ -618,7 +618,7 @@ static void hns_ae_get_coalesce_range(struct hnae_handle *handle,
 {
 	struct dsaf_device *dsaf_dev;
 
-	assert(handle);
+	test_condition(handle);
 
 	dsaf_dev = hns_ae_get_dsaf_dev(handle->dev);
 
@@ -767,7 +767,7 @@ static void hns_ae_get_strings(struct hnae_handle *handle,
 	u8 *p = data;
 	struct	hnae_vf_cb *vf_cb;
 
-	assert(handle);
+	test_condition(handle);
 
 	vf_cb = hns_ae_get_vf_cb(handle);
 	port = vf_cb->port_index;
@@ -795,7 +795,7 @@ static int hns_ae_get_sset_count(struct hnae_handle *handle, int stringset)
 	struct hns_mac_cb *mac_cb;
 	struct dsaf_device *dsaf_dev = hns_ae_get_dsaf_dev(handle->dev);
 
-	assert(handle);
+	test_condition(handle);
 
 	mac_cb = hns_get_mac_cb(handle);
 
@@ -839,7 +839,7 @@ static void hns_ae_update_led_status(struct hnae_handle *handle)
 {
 	struct hns_mac_cb *mac_cb;
 
-	assert(handle);
+	test_condition(handle);
 	mac_cb = hns_get_mac_cb(handle);
 	if (mac_cb->media_type != HNAE_MEDIA_TYPE_FIBER)
 		return;
@@ -852,7 +852,7 @@ static int hns_ae_cpld_set_led_id(struct hnae_handle *handle,
 {
 	struct hns_mac_cb *mac_cb;
 
-	assert(handle);
+	test_condition(handle);
 
 	mac_cb = hns_get_mac_cb(handle);
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index f56855e63c96..8ba0d44742d1 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -366,7 +366,7 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 	ndev->stats.tx_packets++;
 
 	wmb(); /* commit all data before submit */
-	assert(skb->queue_mapping < priv->ae_handle->q_num);
+	test_condition(skb->queue_mapping < priv->ae_handle->q_num);
 	hnae_queue_xmit(priv->ae_handle->qs[skb->queue_mapping], buf_num);
 	ring->stats.tx_pkts++;
 	ring->stats.tx_bytes += skb->len;
@@ -937,9 +937,9 @@ static int is_valid_clean_head(struct hnae_ring *ring, int h)
 	if (unlikely(h > ring->desc_num))
 		return 0;
 
-	assert(u > 0 && u < ring->desc_num);
-	assert(c > 0 && c < ring->desc_num);
-	assert(u != c && h != c); /* must be checked before call this func */
+	test_condition(u > 0 && u < ring->desc_num);
+	test_condition(c > 0 && c < ring->desc_num);
+	test_condition(u != c && h != c); /* must be checked before call this func */
 
 	return u > c ? (h > c && h <= u) : (h > c || h <= u);
 }
@@ -1515,8 +1515,6 @@ static netdev_tx_t hns_nic_net_xmit(struct sk_buff *skb,
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 
-	assert(skb->queue_mapping < ndev->ae_handle->q_num);
-
 	return hns_nic_net_xmit_hw(ndev, skb,
 				   &tx_ring_data(priv, skb->queue_mapping));
 }
@@ -2249,7 +2247,7 @@ static int hns_nic_notifier_action(struct notifier_block *nb,
 	struct hns_nic_priv *priv =
 		container_of(nb, struct hns_nic_priv, notifier_block);
 
-	assert(action == HNAE_AE_REGISTER);
+	test_condition(action == HNAE_AE_REGISTER);
 
 	if (!hns_nic_try_get_ae(priv->netdev)) {
 		hnae_unregister_notifier(&priv->notifier_block);
-- 
2.17.1

