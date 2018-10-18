Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12BECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AE321477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="iW5V6ZF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/uVmzop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AE321477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJRL7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:59:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51245 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727584AbeJRL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:59:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CE9C521FEE;
        Thu, 18 Oct 2018 00:00:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Oct 2018 00:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=uvXXlFBckwLn+Z2XL1dWJXlQVpT+sGJvXafVOPqDLU8=; b=iW5V6
        ZF+rcgbBjtdnYhSez9PKu6seL4wKXsSd08Fj+khZbPpUZ7jJ0ioUy38YakMTH3z7
        Dvo9MOZM2B7Vm/izAmQFVdZ0aSuB7RrvywPjg/fxxZccUlCQuTiE13VoUBXUhleE
        IXyXTwYZb8rViGXsQ0yAfk68S0i2rCMadJ9L2L+nmgpl9mnKV4bAnpLs5/KQuzbI
        r+8snV1nqY3HJNPmJ2GdtWcWy2nl8NGkJb60aWHZAVFJsgl02bYv46MCS5RDnpU5
        r9jAA8mrBIqrHpMJO5KNnGUNtqZaqPWDG8rVWzXod6kNX+LkioYw2cthyjE2mZcL
        0mQ9rq9TVMaQvbBkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=uvXXlFBckwLn+Z2XL1dWJXlQVpT+sGJvXafVOPqDLU8=; b=G/uVmzop
        Zw1SeTelJ6ZIxns1IXkb8bn4xm/WhC9LlV3VSS4Ea0KagSQMejtfkS4eNJh759K7
        qYQ+4fJx7ec8/Nt6lM9UJSnTpzUC6u5E4AQSDH0iyL68Sd/sg02QkAdzxsfeK3Gr
        dRXlUcT0rR5KHGwEmc/0UG30LvvrJYVZFvjFLaIZyqAMk11Wh9jnJbOTcEW0FQYG
        rFw2S+cDSUtueG6RBjT91rostC1UePRstRoOaM4G4piPcPY+vCbsSJhWUy9OX0pS
        Kr3rg1ouWeTSl+ywS91qlTU/wVO/pb3gD9PNSzZpQaHfosKN0ug1fb4Qcw+TPE6Q
        zkLoAzlRNhi9cw==
X-ME-Sender: <xms:RwXIW-pyHirIkdF7SzT7Qald3yshD9Kg5BEHkmDBh13HNr-17um43w>
X-ME-Proxy: <xmx:RwXIW3hTPziW11KLVAkMAbW8VCJyAPJbEiDDiPalr6DZek7OHSBq5Q>
    <xmx:RwXIW5EolschkuDil_PJxrJDUivCFkDISVjAoAMvfh-PCwraV4MZ9A>
    <xmx:RwXIW0HRM_LtwIU6ozLU3r7EDX6m0_poFuzgSo3DcxIX-j2_h9TWxg>
    <xmx:RwXIWx8gK2n7PDlc5aPtmUsy7DRSOl4uvYy_HiqsE8CpvnKIRovAPw>
    <xmx:RwXIW2QeXcD9AggZe5SrlZDm5e6_4sxMqb2fecvGjcPcL3XsenVcWw>
    <xmx:RwXIW79mrWw0H6ayBoE9ZgFFD9ohK99PGioFzkVuC7P0FRTwRTetjw>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id A22F8102DE;
        Thu, 18 Oct 2018 00:00:04 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 6/6] net/ncsi: Configure multi-package, multi-channel modes with failover
Date:   Thu, 18 Oct 2018 14:59:17 +1100
Message-Id: <20181018035917.19413-7-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the ncsi-netlink interface with two new commands and
three new attributes to configure multiple packages and/or channels at
once, and configure specific failover modes.

NCSI_CMD_SET_PACKAGE mask and NCSI_CMD_SET_CHANNEL_MASK set a whitelist
of packages or channels allowed to be configured with the
NCSI_ATTR_PACKAGE_MASK and NCSI_ATTR_CHANNEL_MASK attributes
respectively. If one of these whitelists is set only packages or
channels matching the whitelist are considered for the channel queue in
ncsi_choose_active_channel().

These commands may also use the NCSI_ATTR_MULTI_FLAG to signal that
multiple packages or channels may be configured simultaneously. NCSI
hardware arbitration (HWA) must be available in order to enable
multi-package mode. Multi-channel mode is always available.

If the NCSI_ATTR_CHANNEL_ID attribute is present in the
NCSI_CMD_SET_CHANNEL_MASK command the it sets the preferred channel as
with the NCSI_CMD_SET_INTERFACE command. The combination of preferred
channel and channel whitelist defines a primary channel and the allowed
failover channels.
If the NCSI_ATTR_MULTI_FLAG attribute is also present then the preferred
channel is configured for Tx/Rx and the other channels are enabled only
for Rx.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 include/uapi/linux/ncsi.h |  15 +++
 net/ncsi/internal.h       |  16 ++-
 net/ncsi/ncsi-aen.c       |  49 ++++++--
 net/ncsi/ncsi-manage.c    | 237 ++++++++++++++++++++++++++++++--------
 net/ncsi/ncsi-netlink.c   | 219 ++++++++++++++++++++++++++++++-----
 net/ncsi/ncsi-rsp.c       |   2 +-
 6 files changed, 454 insertions(+), 84 deletions(-)

diff --git a/include/uapi/linux/ncsi.h b/include/uapi/linux/ncsi.h
index 0a26a5576645..a3f87c54fdb3 100644
--- a/include/uapi/linux/ncsi.h
+++ b/include/uapi/linux/ncsi.h
@@ -26,6 +26,12 @@
  * @NCSI_CMD_SEND_CMD: send NC-SI command to network card.
  *	Requires NCSI_ATTR_IFINDEX, NCSI_ATTR_PACKAGE_ID
  *	and NCSI_ATTR_CHANNEL_ID.
+ * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed packages.
+ *	Requires NCSI_ATTR_IFINDEX and NCSI_ATTR_PACKAGE_MASK.
+ * @NCSI_CMD_SET_CHANNEL_MASK: set a whitelist of allowed channels.
+ *	Requires NCSI_ATTR_IFINDEX, NCSI_ATTR_PACKAGE_ID, and
+ *	NCSI_ATTR_CHANNEL_MASK. If NCSI_ATTR_CHANNEL_ID is present it sets
+ *	the primary channel.
  * @NCSI_CMD_MAX: highest command number
  */
 enum ncsi_nl_commands {
@@ -34,6 +40,8 @@ enum ncsi_nl_commands {
 	NCSI_CMD_SET_INTERFACE,
 	NCSI_CMD_CLEAR_INTERFACE,
 	NCSI_CMD_SEND_CMD,
+	NCSI_CMD_SET_PACKAGE_MASK,
+	NCSI_CMD_SET_CHANNEL_MASK,
 
 	__NCSI_CMD_AFTER_LAST,
 	NCSI_CMD_MAX = __NCSI_CMD_AFTER_LAST - 1
@@ -48,6 +56,10 @@ enum ncsi_nl_commands {
  * @NCSI_ATTR_PACKAGE_ID: package ID
  * @NCSI_ATTR_CHANNEL_ID: channel ID
  * @NCSI_ATTR_DATA: command payload
+ * @NCSI_ATTR_MULTI_FLAG: flag to signal that multi-mode should be enabled with
+ *	NCSI_CMD_SET_PACKAGE_MASK or NCSI_CMD_SET_CHANNEL_MASK.
+ * @NCSI_ATTR_PACKAGE_MASK: 32-bit mask of allowed packages.
+ * @NCSI_ATTR_CHANNEL_MASK: 32-bit mask of allowed channels.
  * @NCSI_ATTR_MAX: highest attribute number
  */
 enum ncsi_nl_attrs {
@@ -57,6 +69,9 @@ enum ncsi_nl_attrs {
 	NCSI_ATTR_PACKAGE_ID,
 	NCSI_ATTR_CHANNEL_ID,
 	NCSI_ATTR_DATA,
+	NCSI_ATTR_MULTI_FLAG,
+	NCSI_ATTR_PACKAGE_MASK,
+	NCSI_ATTR_CHANNEL_MASK,
 
 	__NCSI_ATTR_AFTER_LAST,
 	NCSI_ATTR_MAX = __NCSI_ATTR_AFTER_LAST - 1
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ed68ca677e41..44dd2c27ed57 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -215,6 +215,10 @@ struct ncsi_package {
 	unsigned int         channel_num; /* Number of channels     */
 	struct list_head     channels;    /* List of chanels        */
 	struct list_head     node;        /* Form list of packages  */
+
+	bool                 multi_channel; /* Enable multiple channels  */
+	u32                  channel_whitelist; /* Channels to configure */
+	struct ncsi_channel  *preferred_channel; /* Primary channel      */
 };
 
 struct ncsi_request {
@@ -288,8 +292,6 @@ struct ncsi_dev_priv {
 	unsigned int        package_num;     /* Number of packages         */
 	struct list_head    packages;        /* List of packages           */
 	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
-	struct ncsi_package *force_package;  /* Force a specific package   */
-	struct ncsi_channel *force_channel;  /* Force a specific channel   */
 	struct ncsi_request requests[256];   /* Request table              */
 	unsigned int        request_id;      /* Last used request ID       */
 #define NCSI_REQ_START_IDX	1
@@ -302,6 +304,9 @@ struct ncsi_dev_priv {
 	struct list_head    node;            /* Form NCSI device list      */
 #define NCSI_MAX_VLAN_VIDS	15
 	struct list_head    vlan_vids;       /* List of active VLAN IDs */
+
+	bool                multi_package;   /* Enable multiple packages   */
+	u32                 package_whitelist; /* Packages to configure    */
 };
 
 struct ncsi_cmd_arg {
@@ -355,6 +360,13 @@ struct ncsi_request *ncsi_alloc_request(struct ncsi_dev_priv *ndp,
 void ncsi_free_request(struct ncsi_request *nr);
 struct ncsi_dev *ncsi_find_dev(struct net_device *dev);
 int ncsi_process_next_channel(struct ncsi_dev_priv *ndp);
+bool ncsi_channel_has_link(struct ncsi_channel *channel);
+bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
+			  struct ncsi_channel *channel);
+int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
+			   struct ncsi_package *np,
+			   struct ncsi_channel *disable,
+			   struct ncsi_channel *enable);
 
 /* Packet handlers */
 u32 ncsi_calculate_checksum(unsigned char *data, int len);
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 57f77e5d381a..f8d17a0918bd 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -51,7 +51,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 				struct ncsi_aen_pkt_hdr *h)
 {
 	struct ncsi_aen_lsc_pkt *lsc;
-	struct ncsi_channel *nc;
+	struct ncsi_channel *nc, *tmp;
 	struct ncsi_channel_mode *ncm;
 	bool chained;
 	int state;
@@ -92,14 +92,47 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (had_link)
-		ndp->flags |= NCSI_DEV_RESHUFFLE;
-	ncsi_stop_channel_monitor(nc);
-	spin_lock_irqsave(&ndp->lock, flags);
-	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
-	spin_unlock_irqrestore(&ndp->lock, flags);
+	if (!nc->package->multi_channel) {
+		if (had_link)
+			ndp->flags |= NCSI_DEV_RESHUFFLE;
+		ncsi_stop_channel_monitor(nc);
+		spin_lock_irqsave(&ndp->lock, flags);
+		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+		spin_unlock_irqrestore(&ndp->lock, flags);
+		return ncsi_process_next_channel(ndp);
+	}
 
-	return ncsi_process_next_channel(ndp);
+	if (had_link) {
+		ncm = &nc->modes[NCSI_MODE_TX_ENABLE];
+		if (ncsi_channel_is_last(ndp, nc)) {
+			/* No channels left, reconfigure */
+			return ncsi_reset_dev(&ndp->ndev);
+		} else if (ncm->enable) {
+			/* Need to failover Tx channel */
+			ncsi_update_tx_channel(ndp, nc->package, nc, NULL);
+		}
+	} else if (has_link) {
+		if (nc->package->preferred_channel == nc) {
+			/* Return Tx to preferred channel */
+			ncsi_update_tx_channel(ndp, nc->package, NULL, nc);
+		}
+		NCSI_FOR_EACH_CHANNEL(nc->package, tmp) {
+			/* Enable Tx on this channel if the current Tx
+			 * channel is down.
+			 */
+			if (tmp->modes[NCSI_MODE_TX_ENABLE].enable &&
+			    !ncsi_channel_has_link(tmp)) {
+				ncsi_update_tx_channel(ndp, nc->package, NULL,
+						       nc);
+				break;
+			}
+		}
+	}
+
+	/* Leave configured channels active in a multi-channel scenario so
+	 * AEN events are still received.
+	 */
+	return 0;
 }
 
 static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index af23e2cc6c1d..ab812a3efc03 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -28,6 +28,29 @@
 LIST_HEAD(ncsi_dev_list);
 DEFINE_SPINLOCK(ncsi_dev_lock);
 
+bool ncsi_channel_has_link(struct ncsi_channel *channel)
+{
+	return !!(channel->modes[NCSI_MODE_LINK].data[2] & 0x1);
+}
+
+bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
+			  struct ncsi_channel *channel)
+{
+	struct ncsi_package *np;
+	struct ncsi_channel *nc;
+
+	NCSI_FOR_EACH_PACKAGE(ndp, np)
+		NCSI_FOR_EACH_CHANNEL(np, nc) {
+			if (nc == channel)
+				continue;
+			if (nc->state == NCSI_CHANNEL_ACTIVE &&
+			    ncsi_channel_has_link(nc))
+				return false;
+		}
+
+	return true;
+}
+
 static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
@@ -52,7 +75,7 @@ static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 				continue;
 			}
 
-			if (nc->modes[NCSI_MODE_LINK].data[2] & 0x1) {
+			if (ncsi_channel_has_link(nc)) {
 				spin_unlock_irqrestore(&nc->lock, flags);
 				nd->link_up = 1;
 				goto report;
@@ -267,6 +290,7 @@ struct ncsi_package *ncsi_add_package(struct ncsi_dev_priv *ndp,
 	np->ndp = ndp;
 	spin_lock_init(&np->lock);
 	INIT_LIST_HEAD(&np->channels);
+	np->channel_whitelist = UINT_MAX;
 
 	spin_lock_irqsave(&ndp->lock, flags);
 	tmp = ncsi_find_package(ndp, id);
@@ -662,13 +686,117 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	return 0;
 }
 
+/* Determine if a given channel should be the Tx channel */
+static bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp,
+			       struct ncsi_channel *nc)
+{
+	struct ncsi_package *np = nc->package;
+	struct ncsi_channel_mode *ncm;
+	struct ncsi_channel *channel;
+
+	NCSI_FOR_EACH_CHANNEL(np, channel) {
+		ncm = &channel->modes[NCSI_MODE_TX_ENABLE];
+		/* Another channel is already Tx */
+		if (ncm->enable)
+			return false;
+	}
+
+	/* This channel is the preferred channel and has link */
+	if (np->preferred_channel &&
+	    ncsi_channel_has_link(np->preferred_channel))
+		return np->preferred_channel == nc;
+
+	/* This channel has link */
+	if (ncsi_channel_has_link(nc))
+		return true;
+
+	list_for_each_entry_rcu(channel, &ndp->channel_queue, link)
+		if (ncsi_channel_has_link(channel))
+			return false;
+
+	/* No other channel has link; default to this one */
+	return true;
+}
+
+/* Change the active Tx channel in a multi-channel setup */
+int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
+			   struct ncsi_package *np,
+			   struct ncsi_channel *disable,
+			   struct ncsi_channel *enable)
+{
+	struct ncsi_cmd_arg nca;
+	struct ncsi_channel *nc;
+	int ret = 0;
+
+	if (!np->multi_channel)
+		netdev_warn(ndp->ndev.dev,
+			    "NCSI: Trying to update Tx channel in single-channel mode\n");
+	nca.ndp = ndp;
+	nca.package = np->id;
+	nca.req_flags = 0;
+
+	/* Find current channel with Tx enabled */
+	if (!disable) {
+		NCSI_FOR_EACH_CHANNEL(np, nc)
+			if (nc->modes[NCSI_MODE_TX_ENABLE].enable)
+				disable = nc;
+	}
+
+	/* Find a suitable channel for Tx */
+	if (!enable) {
+		if (np->preferred_channel &&
+		    ncsi_channel_has_link(np->preferred_channel)) {
+			enable = np->preferred_channel;
+		} else {
+			NCSI_FOR_EACH_CHANNEL(np, nc) {
+				if (!(np->channel_whitelist & 0x1 << nc->id))
+					continue;
+				if (nc->state != NCSI_CHANNEL_ACTIVE)
+					continue;
+				if (ncsi_channel_has_link(nc)) {
+					enable = nc;
+					break;
+				}
+			}
+		}
+	}
+
+	if (disable == enable)
+		return -1;
+
+	if (!enable)
+		return -1;
+
+	if (disable) {
+		nca.channel = disable->id;
+		nca.type = NCSI_PKT_CMD_DCNT;
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			netdev_err(ndp->ndev.dev,
+				   "Error %d sending DCNT\n",
+				   ret);
+	}
+
+	netdev_info(ndp->ndev.dev, "NCSI: channel %u enables Tx\n", enable->id);
+
+	nca.channel = enable->id;
+	nca.type = NCSI_PKT_CMD_ECNT;
+	ret = ncsi_xmit_cmd(&nca);
+	if (ret)
+		netdev_err(ndp->ndev.dev,
+			   "Error %d sending ECNT\n",
+			   ret);
+
+	return ret;
+}
+
 static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 {
-	struct ncsi_dev *nd = &ndp->ndev;
-	struct net_device *dev = nd->dev;
 	struct ncsi_package *np = ndp->active_package;
 	struct ncsi_channel *nc = ndp->active_channel;
 	struct ncsi_channel *hot_nc = NULL;
+	struct ncsi_dev *nd = &ndp->ndev;
+	struct net_device *dev = nd->dev;
 	struct ncsi_cmd_arg nca;
 	unsigned char index;
 	unsigned long flags;
@@ -774,20 +902,29 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		} else if (nd->state == ncsi_dev_state_config_ebf) {
 			nca.type = NCSI_PKT_CMD_EBF;
 			nca.dwords[0] = nc->caps[NCSI_CAP_BC].cap;
-			nd->state = ncsi_dev_state_config_ecnt;
+			if (ncsi_channel_is_tx(ndp, nc))
+				nd->state = ncsi_dev_state_config_ecnt;
+			else
+				nd->state = ncsi_dev_state_config_ec;
 #if IS_ENABLED(CONFIG_IPV6)
 			if (ndp->inet6_addr_num > 0 &&
 			    (nc->caps[NCSI_CAP_GENERIC].cap &
 			     NCSI_CAP_GENERIC_MC))
 				nd->state = ncsi_dev_state_config_egmf;
-			else
-				nd->state = ncsi_dev_state_config_ecnt;
 		} else if (nd->state == ncsi_dev_state_config_egmf) {
 			nca.type = NCSI_PKT_CMD_EGMF;
 			nca.dwords[0] = nc->caps[NCSI_CAP_MC].cap;
-			nd->state = ncsi_dev_state_config_ecnt;
+			if (ncsi_channel_is_tx(ndp, nc))
+				nd->state = ncsi_dev_state_config_ecnt;
+			else
+				nd->state = ncsi_dev_state_config_ec;
 #endif /* CONFIG_IPV6 */
 		} else if (nd->state == ncsi_dev_state_config_ecnt) {
+			if (np->preferred_channel &&
+			    nc != np->preferred_channel)
+				netdev_info(ndp->ndev.dev,
+					    "NCSI: Tx failed over to channel %u\n",
+					    nc->id);
 			nca.type = NCSI_PKT_CMD_ECNT;
 			nd->state = ncsi_dev_state_config_ec;
 		} else if (nd->state == ncsi_dev_state_config_ec) {
@@ -868,43 +1005,35 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 
 static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 {
-	struct ncsi_package *np, *force_package;
-	struct ncsi_channel *nc, *found, *hot_nc, *force_channel;
+	struct ncsi_channel *nc, *found, *hot_nc;
 	struct ncsi_channel_mode *ncm;
-	unsigned long flags;
+	unsigned long flags, cflags;
+	struct ncsi_package *np;
+	bool with_link;
 
 	spin_lock_irqsave(&ndp->lock, flags);
 	hot_nc = ndp->hot_channel;
-	force_channel = ndp->force_channel;
-	force_package = ndp->force_package;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	/* Force a specific channel whether or not it has link if we have been
-	 * configured to do so
-	 */
-	if (force_package && force_channel) {
-		found = force_channel;
-		ncm = &found->modes[NCSI_MODE_LINK];
-		if (!(ncm->data[2] & 0x1))
-			netdev_info(ndp->ndev.dev,
-				    "NCSI: Channel %u forced, but it is link down\n",
-				    found->id);
-		goto out;
-	}
-
-	/* The search is done once an inactive channel with up
-	 * link is found.
+	/* By default the search is done once an inactive channel with up
+	 * link is found, unless a preferred channel is set.
+	 * If multi_package or multi_channel are configured all channels in the
+	 * whitelist with link are added to the channel queue.
 	 */
 	found = NULL;
+	with_link = false;
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
-		if (ndp->force_package && np != ndp->force_package)
+		if (!(ndp->package_whitelist & (0x1 << np->id)))
 			continue;
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			spin_lock_irqsave(&nc->lock, flags);
+			if (!(np->channel_whitelist & (0x1 << nc->id)))
+				continue;
+
+			spin_lock_irqsave(&nc->lock, cflags);
 
 			if (!list_empty(&nc->link) ||
 			    nc->state != NCSI_CHANNEL_INACTIVE) {
-				spin_unlock_irqrestore(&nc->lock, flags);
+				spin_unlock_irqrestore(&nc->lock, cflags);
 				continue;
 			}
 
@@ -916,32 +1045,49 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 
 			ncm = &nc->modes[NCSI_MODE_LINK];
 			if (ncm->data[2] & 0x1) {
-				spin_unlock_irqrestore(&nc->lock, flags);
 				found = nc;
-				goto out;
+				with_link = true;
 			}
 
-			spin_unlock_irqrestore(&nc->lock, flags);
+			/* If multi_channel is enabled configure all valid
+			 * channels whether or not they currently have link
+			 * so they will have AENs enabled.
+			 */
+			if (with_link || np->multi_channel) {
+				spin_lock_irqsave(&ndp->lock, flags);
+				list_add_tail_rcu(&nc->link,
+						  &ndp->channel_queue);
+				spin_unlock_irqrestore(&ndp->lock, flags);
+
+				netdev_dbg(ndp->ndev.dev,
+					   "NCSI: Channel %u added to queue (link %s)\n",
+					   nc->id,
+					   ncm->data[2] & 0x1 ? "up" : "down");
+			}
+
+			spin_unlock_irqrestore(&nc->lock, cflags);
+
+			if (with_link && !np->multi_channel)
+				break;
 		}
+		if (with_link && !ndp->multi_package)
+			break;
 	}
 
-	if (!found) {
+	if (list_empty(&ndp->channel_queue) && found) {
+		netdev_info(ndp->ndev.dev,
+			    "NCSI: No channel with link found, configuring channel %u\n",
+			    found->id);
+		spin_lock_irqsave(&ndp->lock, flags);
+		list_add_tail_rcu(&found->link, &ndp->channel_queue);
+		spin_unlock_irqrestore(&ndp->lock, flags);
+	} else if (!found) {
 		netdev_warn(ndp->ndev.dev,
-			    "NCSI: No channel found with link\n");
+			    "NCSI: No channel found to configure!\n");
 		ncsi_report_link(ndp, true);
 		return -ENODEV;
 	}
 
-	ncm = &found->modes[NCSI_MODE_LINK];
-	netdev_dbg(ndp->ndev.dev,
-		   "NCSI: Channel %u added to queue (link %s)\n",
-		   found->id, ncm->data[2] & 0x1 ? "up" : "down");
-
-out:
-	spin_lock_irqsave(&ndp->lock, flags);
-	list_add_tail_rcu(&found->link, &ndp->channel_queue);
-	spin_unlock_irqrestore(&ndp->lock, flags);
-
 	return ncsi_process_next_channel(ndp);
 }
 
@@ -1426,6 +1572,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	INIT_LIST_HEAD(&ndp->channel_queue);
 	INIT_LIST_HEAD(&ndp->vlan_vids);
 	INIT_WORK(&ndp->work, ncsi_dev_work);
+	ndp->package_whitelist = UINT_MAX;
 
 	/* Initialize private NCSI device */
 	spin_lock_init(&ndp->lock);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 06bb8bc2c798..0eb692fb9fd9 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -30,6 +30,9 @@ static const struct nla_policy ncsi_genl_policy[NCSI_ATTR_MAX + 1] = {
 	[NCSI_ATTR_PACKAGE_ID] =	{ .type = NLA_U32 },
 	[NCSI_ATTR_CHANNEL_ID] =	{ .type = NLA_U32 },
 	[NCSI_ATTR_DATA] =		{ .type = NLA_BINARY, .len = 2048 },
+	[NCSI_ATTR_MULTI_FLAG] =	{ .type = NLA_FLAG },
+	[NCSI_ATTR_PACKAGE_MASK] =	{ .type = NLA_U32 },
+	[NCSI_ATTR_CHANNEL_MASK] =	{ .type = NLA_U32 },
 };
 
 static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
@@ -69,7 +72,7 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 	nla_put_u32(skb, NCSI_CHANNEL_ATTR_LINK_STATE, m->data[2]);
 	if (nc->state == NCSI_CHANNEL_ACTIVE)
 		nla_put_flag(skb, NCSI_CHANNEL_ATTR_ACTIVE);
-	if (ndp->force_channel == nc)
+	if (nc == nc->package->preferred_channel)
 		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
 
 	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
@@ -114,7 +117,7 @@ static int ncsi_write_package_info(struct sk_buff *skb,
 		if (!pnest)
 			return -ENOMEM;
 		nla_put_u32(skb, NCSI_PKG_ATTR_ID, np->id);
-		if (ndp->force_package == np)
+		if ((0x1 << np->id) == ndp->package_whitelist)
 			nla_put_flag(skb, NCSI_PKG_ATTR_FORCED);
 		cnest = nla_nest_start(skb, NCSI_PKG_ATTR_CHANNEL_LIST);
 		if (!cnest) {
@@ -290,45 +293,54 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
 
-	spin_lock_irqsave(&ndp->lock, flags);
-
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
 	if (!package) {
 		/* The user has set a package that does not exist */
-		spin_unlock_irqrestore(&ndp->lock, flags);
 		return -ERANGE;
 	}
 
 	channel = NULL;
-	if (!info->attrs[NCSI_ATTR_CHANNEL_ID]) {
-		/* Allow any channel */
-		channel_id = NCSI_RESERVED_CHANNEL;
-	} else {
+	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
 		channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
 		NCSI_FOR_EACH_CHANNEL(package, nc)
-			if (nc->id == channel_id)
+			if (nc->id == channel_id) {
 				channel = nc;
+				break;
+			}
+		if (!channel) {
+			netdev_info(ndp->ndev.dev,
+				    "NCSI: Channel %u does not exist!\n",
+				    channel_id);
+			return -ERANGE;
+		}
 	}
 
-	if (channel_id != NCSI_RESERVED_CHANNEL && !channel) {
-		/* The user has set a channel that does not exist on this
-		 * package
-		 */
-		spin_unlock_irqrestore(&ndp->lock, flags);
-		netdev_info(ndp->ndev.dev, "NCSI: Channel %u does not exist!\n",
-			    channel_id);
-		return -ERANGE;
-	}
-
-	ndp->force_package = package;
-	ndp->force_channel = channel;
+	spin_lock_irqsave(&ndp->lock, flags);
+	ndp->package_whitelist = 0x1 << package->id;
+	ndp->multi_package = false;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	netdev_info(ndp->ndev.dev, "Set package 0x%x, channel 0x%x%s as preferred\n",
-		    package_id, channel_id,
-		    channel_id == NCSI_RESERVED_CHANNEL ? " (any)" : "");
+	spin_lock_irqsave(&package->lock, flags);
+	package->multi_channel = false;
+	if (channel) {
+		package->channel_whitelist = 0x1 << channel->id;
+		package->preferred_channel = channel;
+	} else {
+		/* Allow any channel */
+		package->channel_whitelist = UINT_MAX;
+		package->preferred_channel = NULL;
+	}
+	spin_unlock_irqrestore(&package->lock, flags);
+
+	if (channel)
+		netdev_info(ndp->ndev.dev,
+			    "Set package 0x%x, channel 0x%x as preferred\n",
+			    package_id, channel_id);
+	else
+		netdev_info(ndp->ndev.dev, "Set package 0x%x as preferred\n",
+			    package_id);
 
 	/* Update channel configuration */
 	ncsi_reset_dev(&ndp->ndev);
@@ -339,6 +351,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 {
 	struct ncsi_dev_priv *ndp;
+	struct ncsi_package *np;
 	unsigned long flags;
 
 	if (!info || !info->attrs)
@@ -352,11 +365,19 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!ndp)
 		return -ENODEV;
 
-	/* Clear any override */
+	/* Reset any whitelists and disable multi mode */
 	spin_lock_irqsave(&ndp->lock, flags);
-	ndp->force_package = NULL;
-	ndp->force_channel = NULL;
+	ndp->package_whitelist = UINT_MAX;
+	ndp->multi_package = false;
 	spin_unlock_irqrestore(&ndp->lock, flags);
+
+	NCSI_FOR_EACH_PACKAGE(ndp, np) {
+		spin_lock_irqsave(&np->lock, flags);
+		np->multi_channel = false;
+		np->channel_whitelist = UINT_MAX;
+		np->preferred_channel = NULL;
+		spin_unlock_irqrestore(&np->lock, flags);
+	}
 	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
 
 	/* Update channel configuration */
@@ -561,6 +582,136 @@ int ncsi_send_netlink_err(struct net_device *dev,
 	return nlmsg_unicast(net->genl_sock, skb, snd_portid);
 }
 
+static int ncsi_set_package_mask_nl(struct sk_buff *msg,
+				    struct genl_info *info)
+{
+	struct ncsi_dev_priv *ndp;
+	unsigned long flags;
+	int rc;
+
+	if (!info || !info->attrs)
+		return -EINVAL;
+
+	if (!info->attrs[NCSI_ATTR_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
+		return -EINVAL;
+
+	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
+	if (!ndp)
+		return -ENODEV;
+
+	spin_lock_irqsave(&ndp->lock, flags);
+	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
+		if (ndp->flags & NCSI_DEV_HWA) {
+			ndp->multi_package = true;
+			rc = 0;
+		} else {
+			netdev_err(ndp->ndev.dev,
+				   "NCSI: Can't use multiple packages without HWA\n");
+			rc = -EPERM;
+		}
+	} else {
+		ndp->multi_package = false;
+		rc = 0;
+	}
+
+	if (!rc)
+		ndp->package_whitelist =
+			nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_MASK]);
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
+	if (!rc) {
+		/* Update channel configuration */
+		ncsi_reset_dev(&ndp->ndev);
+	}
+
+	return rc;
+}
+
+static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
+				    struct genl_info *info)
+{
+	struct ncsi_package *np, *package;
+	struct ncsi_channel *nc, *channel;
+	u32 package_id, channel_id;
+	struct ncsi_dev_priv *ndp;
+	unsigned long flags;
+
+	if (!info || !info->attrs)
+		return -EINVAL;
+
+	if (!info->attrs[NCSI_ATTR_IFINDEX])
+		return -EINVAL;
+
+	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
+		return -EINVAL;
+
+	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
+		return -EINVAL;
+
+	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
+	if (!ndp)
+		return -ENODEV;
+
+	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
+	package = NULL;
+	NCSI_FOR_EACH_PACKAGE(ndp, np)
+		if (np->id == package_id) {
+			package = np;
+			break;
+		}
+	if (!package)
+		return -ERANGE;
+
+	spin_lock_irqsave(&package->lock, flags);
+
+	channel = NULL;
+	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
+		channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
+		NCSI_FOR_EACH_CHANNEL(np, nc)
+			if (nc->id == channel_id) {
+				channel = nc;
+				break;
+			}
+		if (!channel) {
+			spin_unlock_irqrestore(&package->lock, flags);
+			return -ERANGE;
+		}
+		netdev_dbg(ndp->ndev.dev,
+			   "NCSI: Channel %u set as preferred channel\n",
+			   channel->id);
+	}
+
+	package->channel_whitelist =
+		nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_MASK]);
+	if (package->channel_whitelist == 0)
+		netdev_dbg(ndp->ndev.dev,
+			   "NCSI: Package %u set to all channels disabled\n",
+			   package->id);
+
+	package->preferred_channel = channel;
+
+	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
+		package->multi_channel = true;
+		netdev_info(ndp->ndev.dev,
+			    "NCSI: Multi-channel enabled on package %u\n",
+			    package_id);
+	} else {
+		package->multi_channel = false;
+	}
+
+	spin_unlock_irqrestore(&package->lock, flags);
+
+	/* Update channel configuration */
+	ncsi_reset_dev(&ndp->ndev);
+
+	return 0;
+}
+
 static const struct genl_ops ncsi_ops[] = {
 	{
 		.cmd = NCSI_CMD_PKG_INFO,
@@ -587,6 +738,18 @@ static const struct genl_ops ncsi_ops[] = {
 		.doit = ncsi_send_cmd_nl,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = NCSI_CMD_SET_PACKAGE_MASK,
+		.policy = ncsi_genl_policy,
+		.doit = ncsi_set_package_mask_nl,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = NCSI_CMD_SET_CHANNEL_MASK,
+		.policy = ncsi_genl_policy,
+		.doit = ncsi_set_channel_mask_nl,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family ncsi_genl_family __ro_after_init = {
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 85fa59afae34..a94b4e813ece 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -256,7 +256,7 @@ static int ncsi_rsp_handler_dcnt(struct ncsi_request *nr)
 	if (!ncm->enable)
 		return 0;
 
-	ncm->enable = 1;
+	ncm->enable = 0;
 	return 0;
 }
 
-- 
2.19.1

