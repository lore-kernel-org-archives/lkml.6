Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5205FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451921479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfACTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:49:12 -0500
Received: from smtp1.cloudbase.it ([46.107.15.2]:64928 "EHLO
        smtp1.cloudbase.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfACTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:49:12 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 14:49:11 EST
Received: from avladu1.cloudbase.it (unknown [89.46.161.178])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.cloudbase.it (Postfix) with ESMTPSA id 47D1F50834;
        Thu,  3 Jan 2019 20:50:06 +0200 (EET)
From:   Adrian Vladu <avladu@cloudbasesolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Alessandro Pilotti" <apilotti@cloudbasesolutions.com>
Subject: [PATCH] hv_netvsc: fix typos in code comments
Date:   Thu,  3 Jan 2019 19:43:08 +0000
Message-Id: <20190103194308.4217-1-avladu@cloudbasesolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all typos from hyperv netvsc code comments.

Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Alessandro Pilotti" <apilotti@cloudbasesolutions.com>
---
 drivers/net/hyperv/hyperv_net.h   | 2 +-
 drivers/net/hyperv/netvsc.c       | 2 +-
 drivers/net/hyperv/netvsc_drv.c   | 6 +++---
 drivers/net/hyperv/rndis_filter.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index ef6f766f6389..eabed1dd9606 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1177,7 +1177,7 @@ enum ndis_per_pkt_info_type {
 
 enum rndis_per_pkt_info_interal_type {
 	RNDIS_PKTINFO_ID = 1,
-	/* Add more memebers here */
+	/* Add more members here */
 
 	RNDIS_PKTINFO_MAX
 };
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 922054c1d544..9a3ad94aa4dc 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1331,7 +1331,7 @@ void netvsc_channel_cb(void *context)
 	prefetch(hv_get_ring_buffer(rbi) + rbi->priv_read_index);
 
 	if (napi_schedule_prep(&nvchan->napi)) {
-		/* disable interupts from host */
+		/* disable interrupts from host */
 		hv_begin_read(rbi);
 
 		__napi_schedule_irqoff(&nvchan->napi);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 91ed15ea5883..d1a7ea76aa88 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -370,7 +370,7 @@ static u32 fill_pg_buf(struct page *page, u32 offset, u32 len,
 {
 	int j = 0;
 
-	/* Deal with compund pages by ignoring unused part
+	/* Deal with compound pages by ignoring unused part
 	 * of the page.
 	 */
 	page += (offset >> PAGE_SHIFT);
@@ -2088,7 +2088,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
 		return NOTIFY_DONE;
 
-	/* if syntihetic interface is a different namespace,
+	/* if synthetic interface is a different namespace,
 	 * then move the VF to that namespace; join will be
 	 * done again in that context.
 	 */
@@ -2236,7 +2236,7 @@ static int netvsc_probe(struct hv_device *dev,
 	 * netvsc_probe() can't get rtnl lock and as a result vmbus_onoffer()
 	 * -> ... -> device_add() -> ... -> __device_attach() can't get
 	 * the device lock, so all the subchannels can't be processed --
-	 * finally netvsc_subchan_work() hangs for ever.
+	 * finally netvsc_subchan_work() hangs forever.
 	 */
 	rtnl_lock();
 
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 8b537a049c1e..40fda5c441e0 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1161,7 +1161,7 @@ int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev)
 	wait_event(nvdev->subchan_open,
 		   atomic_read(&nvdev->open_chn) == nvdev->num_chn);
 
-	/* ignore failues from setting rss parameters, still have channels */
+	/* ignore failures from setting rss parameters, still have channels */
 	rndis_filter_set_rss_param(rdev, netvsc_hash_key);
 
 	netif_set_real_num_tx_queues(ndev, nvdev->num_chn);
-- 
2.17.1

