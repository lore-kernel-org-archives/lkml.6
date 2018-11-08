Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3DCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8120857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="xEFK3WIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYtnPJpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C8120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeKHMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:23:03 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53437 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbeKHMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:23:02 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B038A21D0A;
        Wed,  7 Nov 2018 21:49:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Nov 2018 21:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=/Lm5hAOYIwQggI1uWf7opl5tV0z883DyOSIzLaTI5Q4=; b=xEFK3
        WINbJjCm/aMF4uG3xrvRt4S75xaNpp5L/0uoJfQkxMRn3Mpp7cTf8qw9Mq19wJIw
        uk7DeA3vu+NPWvhWTFVZThfItGmFoJTSpB/t/1jvHZ6H9LMKk4iR5eFENwN+Ep71
        v3YcI4HKFoYymCWe8oP1nz8lgTTx3zeZR+uZjlHFv/DKX3GGBGYej0fg5pPXjBFO
        xE0sRy1JH3lf0NjANazbb2uV/RdCuR6co34q6Rp0XvkVGDPxO4LRgorAW+Lw03HP
        TZa+yMzo3X2IXSeeGLCD271jl9RTN4mSB71CCcanO2CybJRUj4WCWjGd5ybgLszX
        1w19kWtVlU+rLE8NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=/Lm5hAOYIwQggI1uWf7opl5tV0z883DyOSIzLaTI5Q4=; b=sYtnPJpg
        87uPbfkNfxEcJO+/6MD426yNJJ0zzlJJARxszY60gUw3SoBPs3DQC+Ez7/850ygt
        nPa8+4a1iyipbMjFJqbSa/3pLK9QhuGsHAWiNQRi0XFLcZomLN+rfTCwXe3KJmBE
        f4Kn8sQHrnEhc3AIx3vmIrZ7ghAQzxE0Appm3u1wouDP9p05c98V8wiRwtgx0BI1
        GzkicsI2eHJcCKUABHn1XdpsA4H9IOQxCOU/HIGt1764Ts1o2ZjFwUYkbLH5jsaO
        XbnIMW0XDl5sIKXBa6en1/CkTJfLScT9EDZsupcw9V2SNwhobn6+ZkHykkj5WFA/
        Hel1uqeTQpLoww==
X-ME-Sender: <xms:SqTjW7Rty8ZnD-QbPlkuodtCjCDp7rchFHiG52L-wMC9rdxfDlKFlw>
X-ME-Proxy: <xmx:SqTjW9nKpAKZOM3Jk7lmvhJGFiH0wC8LRzG5wlx5vZL7F-5c2nyMWw>
    <xmx:SqTjW5BKvpAvL7cgbG9Uxv4gw2KXhN8SlVvg3M1euVWtABilrtli9Q>
    <xmx:SqTjW1donVw29TG_qMFJSWcM7dpo3ndxgZ9TYNXn6oL_tEjCMura2g>
    <xmx:SqTjW8IUvmYtVikvWfTxVYwXo0Hk0fpaFUtkFHOy4CAHEDYWAv1uwQ>
    <xmx:SqTjWwcOBYLN1b1wT9JNIQe0QG_qSin0dYyUNekn8ByhXh5LtS1YfA>
    <xmx:SqTjW_9rDI_UzhUcCtLewJnqYxAqDiW4Fn-btYUDIt9qOtsh_aQORQ>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 389DE102E4;
        Wed,  7 Nov 2018 21:49:43 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v3 5/6] net/ncsi: Reset channel state in ncsi_start_dev()
Date:   Thu,  8 Nov 2018 13:49:08 +1100
Message-Id: <20181108024909.9897-6-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108024909.9897-1-sam@mendozajonas.com>
References: <20181108024909.9897-1-sam@mendozajonas.com>
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
 net/ncsi/internal.h     |  2 +
 net/ncsi/ncsi-manage.c  | 98 ++++++++++++++++++++++++++++++++++++++---
 net/ncsi/ncsi-netlink.c | 12 ++---
 3 files changed, 101 insertions(+), 11 deletions(-)

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
index b9de5b78c4e9..4b07f5701186 100644
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
@@ -897,6 +899,16 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 	case ncsi_dev_state_config_done:
 		netdev_dbg(ndp->ndev.dev, "NCSI: channel %u config done\n",
 			   nc->id);
+		if (ndp->flags & NCSI_DEV_RESET) {
+			/* A reset event happened during config, start it now */
+			spin_lock_irqsave(&nc->lock, flags);
+			nc->reconfigure_needed = false;
+			spin_unlock_irqrestore(&nc->lock, flags);
+			nd->state = ncsi_dev_state_functional;
+			ncsi_reset_dev(nd);
+			break;
+		}
+
 		spin_lock_irqsave(&nc->lock, flags);
 		if (nc->reconfigure_needed) {
 			/* This channel's configuration has been updated
@@ -1554,7 +1566,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return 0;
 	}
 
-	return ncsi_choose_active_channel(ndp);
+	return ncsi_reset_dev(nd);
 }
 EXPORT_SYMBOL_GPL(ncsi_start_dev);
 
@@ -1567,7 +1579,10 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
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
@@ -1575,7 +1590,6 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 			spin_lock_irqsave(&nc->lock, flags);
 			chained = !list_empty(&nc->link);
 			old_state = nc->state;
-			nc->state = NCSI_CHANNEL_INACTIVE;
 			spin_unlock_irqrestore(&nc->lock, flags);
 
 			WARN_ON_ONCE(chained ||
@@ -1588,6 +1602,80 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
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

