Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3932C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFF020862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="YJ3fXDfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MeEGlO0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFF020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeKHMW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:22:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35117 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbeKHMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:22:54 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id EBC1021DC4;
        Wed,  7 Nov 2018 21:49:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Nov 2018 21:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=kLLp/IXE2T/+udcyl432QjCpNga38qUpEpDF3lMA/cM=; b=YJ3fX
        Dfqk72lg0nWgm8Hiff153YzJVTlgn9pq0nYicJuZgJ2rw7wILo0OIYbE2zQYCfPf
        OZDGwcN/b5UO88NgatkiN3Eu0rMOiJXq+EoowcMXM1i+Z1z3e2OWK7CVM0RJQNex
        tb+h9dLWKEuRFKEWUWXiVlzyctLFMQ/nPV8EYUqUwSzRwvqAAPzMZHJxMNarTbl4
        dVF0t4AUvZPLXB5UHTrOqSNW6nzm8geN4KWatWhEXjvQ+blQaSJpzt/dp8F86NHn
        R9tTkMGC0xW66txjHVVZKI309JfCAfsWWz+9cUUnK425JivbUfulXWvqgo03qNMq
        YLXSPaGr+UpB7Sd4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kLLp/IXE2T/+udcyl432QjCpNga38qUpEpDF3lMA/cM=; b=MeEGlO0O
        cYybm1yGSXIfURjnIV0E85jNjlTWrzH6ktbz2NDchYGnypITP1bbBfSRr20M2qPn
        3p1nv4KFY4gG0ZCYKp+Ku8FBncRXYxc42sjsYr7n3Lt2tlZhGiFwFxiV9efM0Eho
        2fofJy8Q+bfe21Gg2zZtqNNhKlSv7UDOUxJ50Ml90JxtGNa4ySl6oojCIbSZP3cR
        l2sPLtdcRXGqMTRUvfkU//elC0qiY+3jLY5LV5VYkTETBH+wxnrhBtjeuVsidTAd
        xnWiDsWcMLa0lcLvAMXaweEpHBlC2ia14C2loIo2U0kSUMLCog9iAqFVMc2lraDo
        4SYBqo60jCT/qA==
X-ME-Sender: <xms:QqTjW2lYX5u-j_a7XmFRzxQNjejIXhHGy_Wr7UBxZgBmkQzRvLdk1g>
X-ME-Proxy: <xmx:QqTjW1gfuP_DsSNIr3ZARcoWkPHwUqLutBqhv2pUfyBets4BcMeTdw>
    <xmx:QqTjW7RJXIDk1vBoKq-AeQV6csu3FHvVNTDKplktS0X5AlaNjkRKAg>
    <xmx:QqTjW99slthtaTSpKjokjxxVttUdnKh2KsLWGx1jTf_ZKhJ6pCGR_A>
    <xmx:QqTjWxSfKwKDJJpu3vN6WUAOB_5O71vCmAyctZ4nDlEYC2U-Q2JUiA>
    <xmx:QqTjW0Y3OphWiXhmYSTcGl40mqUHKGhw8DLHc7dWf0HPFsXKpJDxwQ>
    <xmx:QqTjW136pFXMPOmeXGSmaVCxgeNr5cmKaorF2WohWXuj8i0acKpA5w>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 753E7102F2;
        Wed,  7 Nov 2018 21:49:36 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v3 2/6] net/ncsi: Probe single packages to avoid conflict
Date:   Thu,  8 Nov 2018 13:49:05 +1100
Message-Id: <20181108024909.9897-3-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108024909.9897-1-sam@mendozajonas.com>
References: <20181108024909.9897-1-sam@mendozajonas.com>
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
 net/ncsi/ncsi-manage.c | 85 +++++++++++++++---------------------------
 2 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 1dae77c54009..ec65778c41f3 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -292,6 +292,7 @@ struct ncsi_dev_priv {
 #if IS_ENABLED(CONFIG_IPV6)
 	unsigned int        inet6_addr_num;  /* Number of IPv6 addresses   */
 #endif
+	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
 	struct list_head    packages;        /* List of packages           */
 	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index d4e6e0f99097..02421d1a22c9 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1079,67 +1079,28 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
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
-			ncsi_choose_active_channel(ndp);
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
@@ -1188,22 +1149,35 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
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
@@ -1564,6 +1538,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return -ENOTTY;
 
 	if (!(ndp->flags & NCSI_DEV_PROBED)) {
+		ndp->package_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
 		schedule_work(&ndp->work);
 		return 0;
-- 
2.19.1

