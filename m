Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C39ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F5021477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="IvYoNwZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcuVRYXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F5021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJRL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:58:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57273 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbeJRL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:58:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 28BCC22233;
        Wed, 17 Oct 2018 23:59:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Oct 2018 23:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=v1zOfBWuyaaEEAyQkf+kgk6paN8C62AOjPzWBpPo5qA=; b=IvYoN
        wZWLk8KXvp7vlqealKH9gOVji43LOGORsx3owq8K7GiaqNKsk4ilvBaXrjvioW1q
        IIure27BiF3glxZqGIxbL/dWULoRiJLDLJ4uEmVcvOAa0KsJuO4ODcta9+yggxQb
        vq7Bgl8BcbDo4Ap/pRqbPU8JB66xkoIu+VkU8GK9wiAUFfGTXTzR7V24M6fZoiw0
        q4xp8eav+VTmZPjpcQEk36t1RHakFMLY+5PYH5e+3Lcdph4iINZ9RtS4UXbVKDWy
        0d+3SF7EaGyHg9gOPrntxUlLH5qAx4xuSbEkEAIaI7J0BWLpl5//JC9Nl5XyZiTr
        9qEsoNy9KwjaQyX0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=v1zOfBWuyaaEEAyQkf+kgk6paN8C62AOjPzWBpPo5qA=; b=jcuVRYXB
        vC5DOO3fzGIYezktPdK9Yn7M4MrcxxKlUqD/5wSJ/rATEPI/AhEX4dGBnMqxScIZ
        T4CZSEsLrh4ds0jY/CzTUfJ2hVI7dq6qedQ+rFIATN9o408zAmXwi0joyfnBSVHW
        9uQSOepaVgSIQhyNzbcS0I+talbBLWZKOY0ENAPfXI5monjx9bBBwqR61sEiiPKu
        /4sds2MzLqmhu2LKnkDm4WjRIXUdcPirqFt+yRff5DaqrwD57EpS2qPhystPPlRU
        4ltL32B1S80Wm9ndbUNL+rbyqpjHHqIteGh4p/Nmmoc5odiO5glEe+a3iX7WglRv
        UPyUlneqg4242A==
X-ME-Sender: <xms:OwXIW8szc3a4ewDyZllgJ0AmYWqx0Eb6Ao7Gotfu_UX4dsTQ6BmzYg>
X-ME-Proxy: <xmx:OwXIW3oPHiGR3flPtQuC5hyx17_uZLFtMETwtuD2PgTFq4HEHdly4w>
    <xmx:OwXIWzDKRo5P3jTWaHNPBnHwc3vageyoX00CYr1cO8MdLaGO0l8KCA>
    <xmx:OwXIW9f1wc2szMsrvHH5daj-594fxsGyXELliV1Y9l4tPXZxVFgPuQ>
    <xmx:OwXIWzKNn_a2oXc-RP0YpgM9JumbJ95jI-LbBtime9Ymq3UfDRMf6A>
    <xmx:OwXIW9sTiPZYLhS7PwMFVItVIgDpsUak3H8A5i6Dhfv2j8DlzvEucg>
    <xmx:PAXIW_RvnpQTk3WUpNKJ43WT1LOG7B40f9n6C4i3ZZ2qW6NaKzD0TA>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id A61E6102D7;
        Wed, 17 Oct 2018 23:59:53 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 2/6] net/ncsi: Probe single packages to avoid conflict
Date:   Thu, 18 Oct 2018 14:59:13 +1100
Message-Id: <20181018035917.19413-3-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the NCSI driver sends a select-package command to all possible
packages simultaneously to discover what packages are available. However
at this stage in the probe process the driver does not know if
hardware arbitration is available: if it isn't then this process could
cause collisions on the RMII bus when packages try to respond.

Update the probe loop to probe each package one by one, and once
complete check if HWA is universally supported.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/internal.h    |  1 +
 net/ncsi/ncsi-manage.c | 88 ++++++++++++++----------------------------
 2 files changed, 31 insertions(+), 58 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 13c9b5eeb3b7..592e3cd40728 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -283,6 +283,7 @@ struct ncsi_dev_priv {
 #if IS_ENABLED(CONFIG_IPV6)
 	unsigned int        inet6_addr_num;  /* Number of IPv6 addresses   */
 #endif
+	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
 	struct list_head    packages;        /* List of packages           */
 	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 65ee46c4d8f4..fbbfed559f9c 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -997,70 +997,28 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		nd->state = ncsi_dev_state_probe_package;
 		break;
 	case ncsi_dev_state_probe_package:
-		ndp->pending_req_num = 16;
+		ndp->pending_req_num = 1;
 
-		/* Select all possible packages */
 		nca.type = NCSI_PKT_CMD_SP;
 		nca.bytes[0] = 1;
+		nca.package = ndp->package_probe_id;
 		nca.channel = NCSI_RESERVED_CHANNEL;
-		for (index = 0; index < 8; index++) {
-			nca.package = index;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
-
-		/* Disable all possible packages */
-		nca.type = NCSI_PKT_CMD_DP;
-		for (index = 0; index < 8; index++) {
-			nca.package = index;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
-
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
 		nd->state = ncsi_dev_state_probe_channel;
 		break;
 	case ncsi_dev_state_probe_channel:
-		if (!ndp->active_package)
-			ndp->active_package = list_first_or_null_rcu(
-				&ndp->packages, struct ncsi_package, node);
-		else if (list_is_last(&ndp->active_package->node,
-				      &ndp->packages))
-			ndp->active_package = NULL;
-		else
-			ndp->active_package = list_next_entry(
-				ndp->active_package, node);
-
-		/* All available packages and channels are enumerated. The
-		 * enumeration happens for once when the NCSI interface is
-		 * started. So we need continue to start the interface after
-		 * the enumeration.
-		 *
-		 * We have to choose an active channel before configuring it.
-		 * Note that we possibly don't have active channel in extreme
-		 * situation.
-		 */
+		ndp->active_package = ncsi_find_package(ndp,
+							ndp->package_probe_id);
 		if (!ndp->active_package) {
-			ndp->flags |= NCSI_DEV_PROBED;
-			if (ncsi_check_hwa(ndp))
-				ncsi_enable_hwa(ndp);
-			else
-				ncsi_choose_active_channel(ndp);
-			return;
+			/* No response */
+			nd->state = ncsi_dev_state_probe_dp;
+			schedule_work(&ndp->work);
+			break;
 		}
-
-		/* Select the active package */
-		ndp->pending_req_num = 1;
-		nca.type = NCSI_PKT_CMD_SP;
-		nca.bytes[0] = 1;
-		nca.package = ndp->active_package->id;
-		nca.channel = NCSI_RESERVED_CHANNEL;
-		ret = ncsi_xmit_cmd(&nca);
-		if (ret)
-			goto error;
-
 		nd->state = ncsi_dev_state_probe_cis;
+		schedule_work(&ndp->work);
 		break;
 	case ncsi_dev_state_probe_cis:
 		ndp->pending_req_num = NCSI_RESERVED_CHANNEL;
@@ -1109,22 +1067,35 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 	case ncsi_dev_state_probe_dp:
 		ndp->pending_req_num = 1;
 
-		/* Deselect the active package */
+		/* Deselect the current package */
 		nca.type = NCSI_PKT_CMD_DP;
-		nca.package = ndp->active_package->id;
+		nca.package = ndp->package_probe_id;
 		nca.channel = NCSI_RESERVED_CHANNEL;
 		ret = ncsi_xmit_cmd(&nca);
 		if (ret)
 			goto error;
 
-		/* Scan channels in next package */
-		nd->state = ncsi_dev_state_probe_channel;
+		/* Probe next package */
+		ndp->package_probe_id++;
+		if (ndp->package_probe_id >= 8) {
+			/* Probe finished */
+			ndp->flags |= NCSI_DEV_PROBED;
+			break;
+		}
+		nd->state = ncsi_dev_state_probe_package;
+		ndp->active_package = NULL;
 		break;
 	default:
 		netdev_warn(nd->dev, "Wrong NCSI state 0x%0x in enumeration\n",
 			    nd->state);
 	}
 
+	if (ndp->flags & NCSI_DEV_PROBED) {
+		/* Check if all packages have HWA support */
+		ncsi_check_hwa(ndp);
+		ncsi_choose_active_channel(ndp);
+	}
+
 	return;
 error:
 	netdev_err(ndp->ndev.dev,
@@ -1485,6 +1456,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return -ENOTTY;
 
 	if (!(ndp->flags & NCSI_DEV_PROBED)) {
+		ndp->package_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
 		schedule_work(&ndp->work);
 		return 0;
-- 
2.19.1

