Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423D8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E3521477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="dJo5xTQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTMCDS23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3521477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJRL7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:59:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44305 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727584AbeJRL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:58:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BF59A22233;
        Thu, 18 Oct 2018 00:00:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Oct 2018 00:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=y9KHK0HGrrupkrJM1GnVbUClpB+HH16FyBbsBf9MdAQ=; b=dJo5x
        TQx+WsdRe+Q1GZEAs1tlVJWOkKLVsd3eq22Xpw+5wBs99MBXSR/9wco/LqX7yMgY
        Xn28mO9sF7lV7h+7OsippYZCMJknTDAA1x8KK91KkwRfuWPDUKchqSSZHUX+edUx
        afGU171Nportcwibw1DmPiwhd0upDVJsEj8OFCvQuCPBBg1WenPQixLyBos46R0/
        8lokAaCSoI0wCKQCh2DRbZnTFg2itQelhQCHBgWkvY8tUwFQ5pBq+fd5gelnMups
        cseOoh43IgagkzzpWmhjw5y8yEBJ+VZ4TF9IChc8+K7pvsUp2EIJsWJvNgKY3UU6
        uZMviRjzdEv4K4rjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=y9KHK0HGrrupkrJM1GnVbUClpB+HH16FyBbsBf9MdAQ=; b=mTMCDS23
        7a1BTEfU7od+7Bbr7THa2QtXPUvyjqv8H9240LKRCRwc0+eDCrqkQlgbfvIq2rC4
        tWZ4jyvZUtgpPRIhZ7QivgLlQSZKQKpSwdqBxfisWqGQgykluAGDmPF69eGm9+vP
        VtGDN0IKaMwXs7DeXTnCDjP8sLKls/ybkG9vdy5+kEYkJRfAuLi0LQAJFmtf65OK
        47cN9wgeYDpb8cvhFG2zX2M8WzyareFRXZ1Ls5Sgc6pHXf481whSYLjMC8cZ5HkB
        6oh2OTJlg26IMBONKLbKYoIPQgqORcr180ofNAOBTiXUPbMeFQQMGu7/JatRKT9J
        8+k3zQEt+MI2Ig==
X-ME-Sender: <xms:RAXIW_VeM2aF81YPMO-7jAwChdE9BDPhBFAN7ealRxh1ufjhKfZbCg>
X-ME-Proxy: <xmx:RAXIW3ctvVLzLE9yReQ8EXlCBE4ky3gY7L3FoEQRSFiw2xcUVDNJCw>
    <xmx:RAXIW0MGSLDMqsAE869BkZcKcUI0tYI93t4yfLwBM9hgiLz6RkQgtQ>
    <xmx:RAXIW1jq-BGdyyho_-tcIPDwHMTWznsxSeWtTkpvIT9LheWbyLes4Q>
    <xmx:RAXIW33lxnu5U2RsZGhddTXsHnX22DKaQ7U8lLAlSfJK8IHwZhKr3Q>
    <xmx:RAXIW_g5Wwhugzaj4O7wCGQUsEyzMMLZevWLN9SdukXSDLE7mXXoxQ>
    <xmx:RAXIW4KMRtnV9YiO_3pnbmTQODuQRj70Wv8Z4CirRnqqp8sVnSV4bA>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8ADD4102D7;
        Thu, 18 Oct 2018 00:00:01 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 5/6] net/ncsi: Reset channel state in ncsi_start_dev()
Date:   Thu, 18 Oct 2018 14:59:16 +1100
Message-Id: <20181018035917.19413-6-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
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
 net/ncsi/internal.h     |  2 ++
 net/ncsi/ncsi-manage.c  | 59 +++++++++++++++++++++++++++++++++++++----
 net/ncsi/ncsi-netlink.c | 10 +++----
 3 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 592e3cd40728..ed68ca677e41 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -279,6 +279,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
 #define NCSI_DEV_HWA		2            /* Enabled HW arbitration     */
 #define NCSI_DEV_RESHUFFLE	4
+#define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 #if IS_ENABLED(CONFIG_IPV6)
 	unsigned int        inet6_addr_num;  /* Number of IPv6 addresses   */
@@ -333,6 +334,7 @@ extern spinlock_t ncsi_dev_lock;
 	list_for_each_entry_rcu(nc, &np->channels, node)
 
 /* Resources */
+int ncsi_reset_dev(struct ncsi_dev *nd);
 void ncsi_start_channel_monitor(struct ncsi_channel *nc);
 void ncsi_stop_channel_monitor(struct ncsi_channel *nc);
 struct ncsi_channel *ncsi_find_channel(struct ncsi_package *np,
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 632caeea672f..af23e2cc6c1d 100644
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
@@ -1472,7 +1474,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return 0;
 	}
 
-	return ncsi_choose_active_channel(nd);
+	return ncsi_reset_dev(nd);
 }
 EXPORT_SYMBOL_GPL(ncsi_start_dev);
 
@@ -1485,7 +1487,10 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
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
@@ -1493,7 +1498,6 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 			spin_lock_irqsave(&nc->lock, flags);
 			chained = !list_empty(&nc->link);
 			old_state = nc->state;
-			nc->state = NCSI_CHANNEL_INACTIVE;
 			spin_unlock_irqrestore(&nc->lock, flags);
 
 			WARN_ON_ONCE(chained ||
@@ -1506,6 +1510,51 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 }
 EXPORT_SYMBOL_GPL(ncsi_stop_dev);
 
+int ncsi_reset_dev(struct ncsi_dev *nd)
+{
+	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_channel *nc, *active;
+	struct ncsi_package *np;
+	unsigned long flags;
+	bool enabled;
+	int state;
+
+	active = NULL;
+	NCSI_FOR_EACH_PACKAGE(ndp, np) {
+		NCSI_FOR_EACH_CHANNEL(np, nc) {
+			spin_lock_irqsave(&nc->lock, flags);
+			enabled = nc->monitor.enabled;
+			state = nc->state;
+			spin_unlock_irqrestore(&nc->lock, flags);
+
+			if (enabled)
+				ncsi_stop_channel_monitor(nc);
+			if (state == NCSI_CHANNEL_ACTIVE) {
+				active = nc;
+				break;
+			}
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

