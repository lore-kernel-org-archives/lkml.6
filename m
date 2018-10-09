Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4327D2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="wqq5cJDQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqP8ote2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4327D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJILNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:13:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45505 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725759AbeJILNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:13:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E9B1821C76;
        Mon,  8 Oct 2018 23:58:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Oct 2018 23:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=ftQltx70yJ/DT
        jOY7RVtZyySOLca6zFJcOXdF1KijlI=; b=wqq5cJDQG0BoAkVBzs+nlkUoRhWVL
        GD5qfC89AGHe2o1FGjd0V01spqx9gyzbX9Esr2wSISpLVgM6HKdFmoiAi/nMjpf+
        aRGxlAxMVzm9oYl1eTSJHogjviKohwzLTl7tzRGq54yLewgrL9iUtv6f+IpR48wR
        j7hfmdxQLSUL/o39xZOm1tMF7LBULJ3U9a/g7AefVHCvccsoSi9uKlqAtZDMw8Sk
        RrOHV0KfrmCOxPeePihLMNl2I98qr5vqTJAUoxVNuUCuUvaDidegm/136xSOW/nv
        fX95Vok0QkoCKlYYgGqhRVUgebEOQ/ZBUu0nq2Hkd+ZX7b/HhVCLcJzfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ftQltx70yJ/DTjOY7
        RVtZyySOLca6zFJcOXdF1KijlI=; b=mqP8ote22iN4Ff2bAAMzS4fl8sZD79iu/
        dfoAvq0H/dveTCObH+gdBKZxbVdHTuw6dmeOSE6mrMR4Os7cxqQagLSObc3SjVRM
        sNRFECwJ57dbisr2Mv+XvW9riUHi6vJ0Yc/+UbGaAjG/X+eor/ETj0H3PB0oae1C
        5fd3L+DD3aTNifxYdhGe3o2snRDtm2BZ8StFEfyUvbojHUbKmsY64pflt1gncecj
        e2L+bwN/zwrwISD6vWxKEv3d4YCQD4Ewqw6xUlkVCHp8yaKfaS1fc10/xxbjyGy2
        gMl9pCgqMyUbLEXRLT1t7Kf4fnb0gK52EBAQRC5wf1DRTO/5MVncA==
X-ME-Sender: <xms:fie8W9dsBLEk02LxuvAZRKTG8RH60XJWmKDrP8zW8AaNGOecplk76Q>
X-ME-Proxy: <xmx:fie8W8fJdfpQI7-1-fTQ_wpMdIA467koXsXAO5gWuS8oPqULdvKv6Q>
    <xmx:fie8W8L8vTTk9ngmmHYXOgrjjtTJRZReW5hlkLHlbTxUVBeDAulDUg>
    <xmx:fie8W1FomU6kZL83tcu5vQdsrrfq3CZtyDfKbDE6cezH9MlDv-5zNg>
    <xmx:fie8W-obTlFcMAsOYYLFT79_NIptBoc-4xvCFE9qTzozlxXiTdGo6A>
    <xmx:fie8W2TRok7ouK6Pa0herLN0xI0fdO5rJ70k0re4xQ-7InwATy0UzA>
    <xmx:fye8WxN8wFHR9aCDRZnTLDuzC9MN601EjrJhv1z4fKlvBpMGvQrj-g>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2322AE435E;
        Mon,  8 Oct 2018 23:58:51 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Justin.Lee1@Dell.com
Subject: [RFC PATCH 1/2] net/ncsi: Don't enable all channels when HWA available
Date:   Tue,  9 Oct 2018 14:58:14 +1100
Message-Id: <20181009035815.5246-1-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NCSI hardware arbitration allows multiple packages to be enabled at once
and share the same wiring. If the NCSI driver recognises that HWA is
available it unconditionally enables all packages and channels; but that
is a configuration decision rather than something required by HWA.
Additionally the current implementation will not failover on link events
which can cause connectivity to be lost unless the interface is manually
bounced.

Retain basic HWA support but remove the separate configuration path to
enable all channels, leaving this to be handled by a later
implementation.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-aen.c    |  3 +--
 net/ncsi/ncsi-manage.c | 51 +++++++-----------------------------------
 2 files changed, 9 insertions(+), 45 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 25e483e8278b..65f47a648be3 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -86,8 +86,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	    !(state == NCSI_CHANNEL_ACTIVE && !(data & 0x1)))
 		return 0;
 
-	if (!(ndp->flags & NCSI_DEV_HWA) &&
-	    state == NCSI_CHANNEL_ACTIVE)
+	if (state == NCSI_CHANNEL_ACTIVE)
 		ndp->flags |= NCSI_DEV_RESHUFFLE;
 
 	ncsi_stop_channel_monitor(nc);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 091284760d21..665bee25ec44 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -112,10 +112,8 @@ static void ncsi_channel_monitor(struct timer_list *t)
 	default:
 		netdev_err(ndp->ndev.dev, "NCSI Channel %d timed out!\n",
 			   nc->id);
-		if (!(ndp->flags & NCSI_DEV_HWA)) {
-			ncsi_report_link(ndp, true);
-			ndp->flags |= NCSI_DEV_RESHUFFLE;
-		}
+		ncsi_report_link(ndp, true);
+		ndp->flags |= NCSI_DEV_RESHUFFLE;
 
 		ncsi_stop_channel_monitor(nc);
 
@@ -952,35 +950,6 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
 	return false;
 }
 
-static int ncsi_enable_hwa(struct ncsi_dev_priv *ndp)
-{
-	struct ncsi_package *np;
-	struct ncsi_channel *nc;
-	unsigned long flags;
-
-	/* Move all available channels to processing queue */
-	spin_lock_irqsave(&ndp->lock, flags);
-	NCSI_FOR_EACH_PACKAGE(ndp, np) {
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			WARN_ON_ONCE(nc->state != NCSI_CHANNEL_INACTIVE ||
-				     !list_empty(&nc->link));
-			ncsi_stop_channel_monitor(nc);
-			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
-		}
-	}
-	spin_unlock_irqrestore(&ndp->lock, flags);
-
-	/* We can have no channels in extremely case */
-	if (list_empty(&ndp->channel_queue)) {
-		netdev_err(ndp->ndev.dev,
-			   "NCSI: No available channels for HWA\n");
-		ncsi_report_link(ndp, false);
-		return -ENOENT;
-	}
-
-	return ncsi_process_next_channel(ndp);
-}
-
 static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
@@ -1047,6 +1016,10 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 			ndp->active_package = list_next_entry(
 				ndp->active_package, node);
 
+		/* Check for HWA support */
+		if (ncsi_check_hwa(ndp))
+			netdev_info(ndp->ndev.dev, "NCSI: HWA available\n");
+
 		/* All available packages and channels are enumerated. The
 		 * enumeration happens for once when the NCSI interface is
 		 * started. So we need continue to start the interface after
@@ -1058,10 +1031,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		 */
 		if (!ndp->active_package) {
 			ndp->flags |= NCSI_DEV_PROBED;
-			if (ncsi_check_hwa(ndp))
-				ncsi_enable_hwa(ndp);
-			else
-				ncsi_choose_active_channel(ndp);
+			ncsi_choose_active_channel(ndp);
 			return;
 		}
 
@@ -1506,12 +1476,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return 0;
 	}
 
-	if (ndp->flags & NCSI_DEV_HWA) {
-		netdev_info(ndp->ndev.dev, "NCSI: Enabling HWA mode\n");
-		ret = ncsi_enable_hwa(ndp);
-	} else {
-		ret = ncsi_choose_active_channel(ndp);
-	}
+	ret = ncsi_choose_active_channel(ndp);
 
 	return ret;
 }
-- 
2.19.0

