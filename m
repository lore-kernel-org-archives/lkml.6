Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A4EC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AA3207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="cpzu2vEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whPgpVvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AA3207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeJXGRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:17:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38615 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeJXGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:17:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A2CE621C8E;
        Tue, 23 Oct 2018 17:52:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Oct 2018 17:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=fWTxBs6k4AqiwFJb2gle5UXsFDZuO6bhZhDMuNav5Po=; b=cpzu2
        vEpTdxoJrW6hdaxYlBztILVlCTVQ2dz8D5m4oX+kL+1Wasa/CIDjFcS6ZNi9SsF8
        cpN1Pd45j27RawN+DKtE9836uluBbYwJ1zHJsBiT38u/EeGKOcmYKKksOLwrDruX
        X7ivjppGHtXIalXEH59say7yV+igZb7pNhpZsAG49r+9hXo1ZGZ4gXU1OrHmF+OK
        H3kYw2oyMm37DEqDHywyiISgjB6efZsE3MyWvrbS4U4k1OgrSC7d7TsO+eXaHA8Z
        gFMYOqCRSKEOaEWXDuucXZsvrRyADp4G9YHIWCSdEouljrlioeVjfeTXB1rWkyve
        YkoRMqwBM76tV81Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fWTxBs6k4AqiwFJb2gle5UXsFDZuO6bhZhDMuNav5Po=; b=whPgpVvw
        OSRxpOIIY4tokL4sOCssrThUBW1VmIuh4IU4oWxAuCwHN9B+ekgzLnJ9HIn6PBLt
        rsB19xPoWkOVmRf21cfV5g72cDotZWpvnO1pEP2vUjakZJeHQfFWZAZXQV4klM0j
        A7AHPseU/5OKyT3Qvblv8q38ptJJsUOUeCZj3y1v0l58lLMNrsDlcUsmhK5+am9Z
        77T1M178T2BTe32Ci4WeP+fVKACxpz8Wet3v8ZkdVj8Dy/Twxf92YYWc/04rpWPn
        AOsSvVULwv2oPyLmbogFh3iDPy0rkbJzon3OQzsB26hnSWJ2sW01Sy3q1b3B4QSk
        k8NXGtcYl82Ttw==
X-ME-Sender: <xms:JpjPW8k5Yq79WLuWrcby1f27itOvrpT91J1j4tSVC-RiSAwKGWxjFA>
X-ME-Proxy: <xmx:JpjPWxPzPQTA9UBXOrnZEnVGgrPEAxM8eUgn8Z2wlq6zmV5BXeZKkg>
    <xmx:JpjPW3AE_XPUE2-wNTuP1sfRfHFg5z07wamZPTZNbj7NNT2sgeGkAA>
    <xmx:JpjPW4d3pTWaUMS-pcf-uJV4PIefbRnSKIuZflXyKGn_K9Qfw1tZtg>
    <xmx:JpjPWxj_EKUYad_Tx5FVKLnougE5uEx7y7Mq6IRWXTRMlDbr5O4z1Q>
    <xmx:JpjPW-PpO2Iyu6ert4BBO-fXnZn2HY4jcosZDQDyYqXwTYBW4YfYyg>
    <xmx:JpjPW9hZJH6UdWBx4A_LOiqmTSDKoGaaXpt0G_d-gQLEXhgUR5UCog>
Received: from v4.ibm.com (unknown [158.140.225.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9732102EE;
        Tue, 23 Oct 2018 17:52:35 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v2 5/6] net/ncsi: Reset channel state in ncsi_start_dev()
Date:   Wed, 24 Oct 2018 10:52:00 +1300
Message-Id: <20181023215201.27315-6-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023215201.27315-1-sam@mendozajonas.com>
References: <20181023215201.27315-1-sam@mendozajonas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the NCSI driver is stopped with ncsi_stop_dev() the channel
monitors are stopped and the state set to "inactive". However the
channels are still configured and active from the perspective of the
network controller. We should suspend each active channel but in the
context of ncsi_stop_dev() the transmit queue has been or is about to be
stopped so we won't have time to do so.

Instead when ncsi_start_dev() is called if the NCSI topology has already
been probed then call ncsi_reset_dev() to suspend any channels that were
previously active. This resets the network controller to a known state,
provides an up to date view of channel link state, and makes sure that
mode flags such as NCSI_MODE_TX_ENABLE are properly reset.

In addition to ncsi_start_dev() use ncsi_reset_dev() in ncsi-netlink.c
to update the channel configuration more cleanly.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
v2: Fixed ncsi_channel_is_tx() to consider the state of channels in other
packages.

 net/ncsi/internal.h     |  2 ++
 net/ncsi/ncsi-manage.c  | 57 +++++++++++++++++++++++++++++++++++++----
 net/ncsi/ncsi-netlink.c | 10 +++-----
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ec65778c41f3..bda51cb179fe 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -287,6 +287,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
 #define NCSI_DEV_HWA		2            /* Enabled HW arbitration     */
 #define NCSI_DEV_RESHUFFLE	4
+#define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 #if IS_ENABLED(CONFIG_IPV6)
@@ -342,6 +343,7 @@ extern spinlock_t ncsi_dev_lock;
 	list_for_each_entry_rcu(nc, &np->channels, node)
 
 /* Resources */
+int ncsi_reset_dev(struct ncsi_dev *nd);
 void ncsi_start_channel_monitor(struct ncsi_channel *nc);
 void ncsi_stop_channel_monitor(struct ncsi_channel *nc);
 struct ncsi_channel *ncsi_find_channel(struct ncsi_package *np,
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 014321ad31d3..9bad03e3fa5e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -550,8 +550,10 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 		spin_lock_irqsave(&nc->lock, flags);
 		nc->state = NCSI_CHANNEL_INACTIVE;
 		spin_unlock_irqrestore(&nc->lock, flags);
-		ncsi_process_next_channel(ndp);
-
+		if (ndp->flags & NCSI_DEV_RESET)
+			ncsi_reset_dev(nd);
+		else
+			ncsi_process_next_channel(ndp);
 		break;
 	default:
 		netdev_warn(nd->dev, "Wrong NCSI state 0x%x in suspend\n",
@@ -1554,7 +1556,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return 0;
 	}
 
-	return ncsi_choose_active_channel(nd);
+	return ncsi_reset_dev(nd);
 }
 EXPORT_SYMBOL_GPL(ncsi_start_dev);
 
@@ -1567,7 +1569,10 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 	int old_state;
 	unsigned long flags;
 
-	/* Stop the channel monitor and reset channel's state */
+	/* Stop the channel monitor on any active channels. Don't reset the
+	 * channel state so we know which were active when ncsi_start_dev()
+	 * is next called.
+	 */
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			ncsi_stop_channel_monitor(nc);
@@ -1575,7 +1580,6 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 			spin_lock_irqsave(&nc->lock, flags);
 			chained = !list_empty(&nc->link);
 			old_state = nc->state;
-			nc->state = NCSI_CHANNEL_INACTIVE;
 			spin_unlock_irqrestore(&nc->lock, flags);
 
 			WARN_ON_ONCE(chained ||
@@ -1588,6 +1592,49 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 }
 EXPORT_SYMBOL_GPL(ncsi_stop_dev);
 
+int ncsi_reset_dev(struct ncsi_dev *nd)
+{
+	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_channel *nc, *active;
+	struct ncsi_package *np;
+	unsigned long flags;
+
+	active = NULL;
+	NCSI_FOR_EACH_PACKAGE(ndp, np) {
+		NCSI_FOR_EACH_CHANNEL(np, nc) {
+			spin_lock_irqsave(&nc->lock, flags);
+
+			if (nc->state == NCSI_CHANNEL_ACTIVE) {
+				active = nc;
+				nc->state = NCSI_CHANNEL_INVISIBLE;
+				spin_unlock_irqrestore(&nc->lock, flags);
+				ncsi_stop_channel_monitor(nc);
+				break;
+			}
+
+			spin_unlock_irqrestore(&nc->lock, flags);
+		}
+	}
+
+	if (!active) {
+		/* Done */
+		spin_lock_irqsave(&ndp->lock, flags);
+		ndp->flags &= ~NCSI_DEV_RESET;
+		spin_unlock_irqrestore(&ndp->lock, flags);
+		return ncsi_choose_active_channel(ndp);
+	}
+
+	spin_lock_irqsave(&ndp->lock, flags);
+	ndp->flags |= NCSI_DEV_RESET;
+	ndp->active_channel = active;
+	ndp->active_package = active->package;
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
+	nd->state = ncsi_dev_state_suspend;
+	schedule_work(&ndp->work);
+	return 0;
+}
+
 void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 33314381b4f5..06bb8bc2c798 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -330,9 +330,8 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		    package_id, channel_id,
 		    channel_id == NCSI_RESERVED_CHANNEL ? " (any)" : "");
 
-	/* Bounce the NCSI channel to set changes */
-	ncsi_stop_dev(&ndp->ndev);
-	ncsi_start_dev(&ndp->ndev);
+	/* Update channel configuration */
+	ncsi_reset_dev(&ndp->ndev);
 
 	return 0;
 }
@@ -360,9 +359,8 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	spin_unlock_irqrestore(&ndp->lock, flags);
 	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
 
-	/* Bounce the NCSI channel to set changes */
-	ncsi_stop_dev(&ndp->ndev);
-	ncsi_start_dev(&ndp->ndev);
+	/* Update channel configuration */
+	ncsi_reset_dev(&ndp->ndev);
 
 	return 0;
 }
-- 
2.19.1

