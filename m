Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EA4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881FE223C8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="upQbFKhW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDvAQz1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881FE223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbeKPPDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:03:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46741 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbeKPPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:03:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 41AC421F39;
        Thu, 15 Nov 2018 23:53:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Nov 2018 23:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=VOVf31uHrYzZn3aitBBNEUHKsaL1uTPCG+lyUHd7SKY=; b=upQbF
        KhWQp200YH0AUYo1ISyxuWgIeW815eXdYWGPRrm8dMjMw+abOa+f5zm4N+6ZsDXE
        3BeG9tUXijXdxjL4tzpph8UqCA778J82baHYXruVk+0Pw8uAsqX5T42kq9FGzyo7
        5QU5HQ9GvvhhB7UWL+0lf4vPUBhWzIbqkgEv6JTfs8m30KqBUOkdK8RnLQXpwLgC
        UI3gpYeY52nOFPCVD/9ScyRWXGJv1yDWSPSgbTmqR8DQlAnsUVC39G16936Z03ic
        7cq12lVonsgF6M2vRQlbFtBpH1H1zR2nf6xpemx9UVDpwCr93kui+koLGTzMyC3G
        GWaVyxLREPwNXie9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VOVf31uHrYzZn3aitBBNEUHKsaL1uTPCG+lyUHd7SKY=; b=eDvAQz1Z
        uN8zkcM54J/SiKg+//60CEjBeOF8Y4MzrM3s79dbnRR8DqH7Ep/NwH/JLQB9qgJX
        ts21TWwdXEKCX0B9nqLSj2p6Wmy0xTb1M5rimEEBFmzBqoGAk8UJ0CulSQE77fbw
        jc/shOsQigYqsU1MRiH/klUdo22FIf/CZdzuq2t4g4w7jnXuiY1+p56IQIEgnzuI
        UT3451FzOB2ScPuB5qrcuJlkf3ZbtjSu5l1+7rITrH1yxmuujlAPyHYJyZ29AE6t
        tnmdwDresK8Hj7M3IGkKsIW7Zs+nPras09PqSmJdCjF/waAcM2e+xQRRErC0azT9
        lJZE1P2zYQtdBg==
X-ME-Sender: <xms:LE3uWxE9GpnFV9Nqh_R4aC7MT4TmwKJBk4CX1dY5IgGsjxJciufwyg>
X-ME-Proxy: <xmx:LE3uWzEMZi4yVTq_HB9qbB7MN8nCa9KgFdOG6cVpl1mt6wZVV5OZZA>
    <xmx:LE3uWxmraNd2QbdiT7bC5JyFTBk_kdJ1ZSTrV__6hy4dp8DlHyjXdQ>
    <xmx:LE3uWyOtZ8V3wikLlFvtE8InBqjXkG8Lcsa2RRabkbljoInU0mQDGQ>
    <xmx:LE3uW0EsGvzepGDv0t9OQGZ1X4A1x-tgwxgNHrU9itriZLQ_jL8AxA>
    <xmx:LE3uW2vPEymEUsVWXzn9uplTEDS4ax4XAIACEQRw2eqd-4yIg4jbQA>
    <xmx:LE3uW1amuXjb9fOQNotItPVsj7_-ixLvyO57448hb59u0FfOTS-cOg>
Received: from v4.ibm.com (unknown [1.144.189.168])
        by mail.messagingengine.com (Postfix) with ESMTPA id 453D6E407B;
        Thu, 15 Nov 2018 23:52:54 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v4 5/6] net/ncsi: Reset channel state in ncsi_start_dev()
Date:   Fri, 16 Nov 2018 15:51:58 +1100
Message-Id: <20181116045159.4980-6-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116045159.4980-1-sam@mendozajonas.com>
References: <20181116045159.4980-1-sam@mendozajonas.com>
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
 net/ncsi/internal.h     |   2 +
 net/ncsi/ncsi-manage.c  | 111 +++++++++++++++++++++++++++++++++++++---
 net/ncsi/ncsi-netlink.c |  12 ++---
 3 files changed, 113 insertions(+), 12 deletions(-)

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
index b9de5b78c4e9..c814ce9bb3de 100644
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
@@ -898,6 +900,16 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		netdev_dbg(ndp->ndev.dev, "NCSI: channel %u config done\n",
 			   nc->id);
 		spin_lock_irqsave(&nc->lock, flags);
+		nc->state = NCSI_CHANNEL_ACTIVE;
+
+		if (ndp->flags & NCSI_DEV_RESET) {
+			/* A reset event happened during config, start it now */
+			nc->reconfigure_needed = false;
+			spin_unlock_irqrestore(&nc->lock, flags);
+			ncsi_reset_dev(nd);
+			break;
+		}
+
 		if (nc->reconfigure_needed) {
 			/* This channel's configuration has been updated
 			 * part-way during the config state - start the
@@ -916,7 +928,6 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			break;
 		}
 
-		nc->state = NCSI_CHANNEL_ACTIVE;
 		if (nc->modes[NCSI_MODE_LINK].data[2] & 0x1) {
 			hot_nc = nc;
 		} else {
@@ -1554,7 +1565,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return 0;
 	}
 
-	return ncsi_choose_active_channel(ndp);
+	return ncsi_reset_dev(nd);
 }
 EXPORT_SYMBOL_GPL(ncsi_start_dev);
 
@@ -1567,7 +1578,10 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
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
@@ -1575,7 +1589,6 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 			spin_lock_irqsave(&nc->lock, flags);
 			chained = !list_empty(&nc->link);
 			old_state = nc->state;
-			nc->state = NCSI_CHANNEL_INACTIVE;
 			spin_unlock_irqrestore(&nc->lock, flags);
 
 			WARN_ON_ONCE(chained ||
@@ -1588,6 +1601,92 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 }
 EXPORT_SYMBOL_GPL(ncsi_stop_dev);
 
+int ncsi_reset_dev(struct ncsi_dev *nd)
+{
+	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_channel *nc, *active, *tmp;
+	struct ncsi_package *np;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ndp->lock, flags);
+
+	if (!(ndp->flags & NCSI_DEV_RESET)) {
+		/* Haven't been called yet, check states */
+		switch (nd->state & ncsi_dev_state_major) {
+		case ncsi_dev_state_registered:
+		case ncsi_dev_state_probe:
+			/* Not even probed yet - do nothing */
+			spin_unlock_irqrestore(&ndp->lock, flags);
+			return 0;
+		case ncsi_dev_state_suspend:
+		case ncsi_dev_state_config:
+			/* Wait for the channel to finish its suspend/config
+			 * operation; once it finishes it will check for
+			 * NCSI_DEV_RESET and reset the state.
+			 */
+			ndp->flags |= NCSI_DEV_RESET;
+			spin_unlock_irqrestore(&ndp->lock, flags);
+			return 0;
+		}
+	} else {
+		switch (nd->state) {
+		case ncsi_dev_state_suspend_done:
+		case ncsi_dev_state_config_done:
+		case ncsi_dev_state_functional:
+			/* Ok */
+			break;
+		default:
+			/* Current reset operation happening */
+			spin_unlock_irqrestore(&ndp->lock, flags);
+			return 0;
+		}
+	}
+
+	if (!list_empty(&ndp->channel_queue)) {
+		/* Clear any channel queue we may have interrupted */
+		list_for_each_entry_safe(nc, tmp, &ndp->channel_queue, link)
+			list_del_init(&nc->link);
+	}
+	spin_unlock_irqrestore(&ndp->lock, flags);
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
+		if (active)
+			break;
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
index 33314381b4f5..cde48fe43dba 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -330,9 +330,9 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		    package_id, channel_id,
 		    channel_id == NCSI_RESERVED_CHANNEL ? " (any)" : "");
 
-	/* Bounce the NCSI channel to set changes */
-	ncsi_stop_dev(&ndp->ndev);
-	ncsi_start_dev(&ndp->ndev);
+	/* Update channel configuration */
+	if (!(ndp->flags & NCSI_DEV_RESET))
+		ncsi_reset_dev(&ndp->ndev);
 
 	return 0;
 }
@@ -360,9 +360,9 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	spin_unlock_irqrestore(&ndp->lock, flags);
 	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
 
-	/* Bounce the NCSI channel to set changes */
-	ncsi_stop_dev(&ndp->ndev);
-	ncsi_start_dev(&ndp->ndev);
+	/* Update channel configuration */
+	if (!(ndp->flags & NCSI_DEV_RESET))
+		ncsi_reset_dev(&ndp->ndev);
 
 	return 0;
 }
-- 
2.19.1

