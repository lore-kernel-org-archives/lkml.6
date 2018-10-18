Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E290BECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A5321479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="c1ovk4Wk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rApzfusz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A5321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJRL65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:58:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60027 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbeJRL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:58:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 761FF22302;
        Thu, 18 Oct 2018 00:00:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Oct 2018 00:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=FcltuIA7UvYoogZL3iaXn4YxnMWlqI5gCILUTSJYVv0=; b=c1ovk
        4WkR4FKYE/kSpE0NRPr0Y9p713CBOcLYlKX17RP9eB4wiEEWrlSI/3dkUVxCKl2O
        yX5mWcdDWuBDVLFmIBIj9LROdCvz23SULWJ+m60yiV4l+nFEPCq+k4YKLe3XAr5N
        5OUJ7FxauNTVW5tbKISudOcw3rF2LQGYIeJbjOorTKMCWKV8ErggTPVTCk/3T0f2
        Szx29Im5zRl4dueqJd32dYg5m+0fWj7jkK/6L36SvPuz3bS5cA2Mu0BXHE+7VDlU
        +tPcoSdpjxxokGmfJuOn9YwAa3HEPnHAaPveyQh1MPsUAoKL0qLPyQKUDeBxx/aP
        +XvqfCBrvMC+gXgJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FcltuIA7UvYoogZL3iaXn4YxnMWlqI5gCILUTSJYVv0=; b=rApzfusz
        nj92Bq6gWyP3woIVZuZxA3bhg41DZWxl8UGWJIeOBMyrf4aHKtbE8h7qL6E/PlV8
        a4hfw0qSYBsRuPF8/KzZbbEZFabDwf9s8feg4gFfb43yJxNp10TvZJ470xYu+r6u
        2uDjExY117wt4CNfmBungLmidCXXPm+yk1zveY3+b+xBBRkSzwdhcBHaDgffo6mW
        6lthOxBNpPWaTI1KKoVVL622Aglryy5BrsXgfvOCebZaFMDSnqSXeB97Zyq3p80i
        bwyl2c8IPX8/mhKJT4sgZGYOBs/jh4ywkV2HpFc6hAJuCp0pwfuqUdx2FsPwutMC
        98WF/th/Ng1awQ==
X-ME-Sender: <xms:QQXIW939pa9xCnmyIAQpTvpJU0vk3Ji5_uy_upScWOgAq7Av2fkvPQ>
X-ME-Proxy: <xmx:QQXIW-QnGDTB81-SlQH9TTDrSinYqYBy6vJlupM9DcHNpxlRCeDLBg>
    <xmx:QQXIW2W0A5Mp9ZzjadfCKboJIaREoLCjzxVRooxuYsdcJXVi_p3ErA>
    <xmx:QQXIW_dh4FY914pAcMYH94D1wpnfgWqV4wgKlL7E_QgtKOFuUquekA>
    <xmx:QQXIW6JVziTp6ClIaY3mvrZrmFQPFW-0fXEiJbo65rnTYkA-QwmDTw>
    <xmx:QQXIW8wxovtmT1pULMMIl7-3XujEKmyOw1h4zeLSVeI5Af2z_n-ccA>
    <xmx:QQXIW0hyy_RCwl-DAMTTqHC5byedxbuWcylfcUaSm5rNyBZ6FXzRbA>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5FAD102D7;
        Wed, 17 Oct 2018 23:59:58 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 4/6] net/ncsi: Don't mark configured channels inactive
Date:   Thu, 18 Oct 2018 14:59:15 +1100
Message-Id: <20181018035917.19413-5-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concepts of a channel being 'active' and it having link are slightly
muddled in the NCSI driver. Tweak this slightly so that
NCSI_CHANNEL_ACTIVE represents a channel that has been configured and
enabled, and NCSI_CHANNEL_INACTIVE represents a de-configured channel.
This distinction is important because a channel can be 'active' but have
its link down; in this case the channel may still need to be configured
so that it may receive AEN link-state-change packets.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-aen.c    | 17 +++++++++++------
 net/ncsi/ncsi-manage.c |  3 +--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 65f47a648be3..57f77e5d381a 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -57,6 +57,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	int state;
 	unsigned long old_data, data;
 	unsigned long flags;
+	bool had_link, has_link;
 
 	/* Find the NCSI channel */
 	ncsi_find_package_and_channel(ndp, h->common.channel, NULL, &nc);
@@ -73,6 +74,9 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	ncm->data[2] = data;
 	ncm->data[4] = ntohl(lsc->oem_status);
 
+	had_link = !!(old_data & 0x1);
+	has_link = !!(data & 0x1);
+
 	netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - channel %u state %s\n",
 		   nc->id, data & 0x1 ? "up" : "down");
 
@@ -80,15 +84,16 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	state = nc->state;
 	spin_unlock_irqrestore(&nc->lock, flags);
 
-	if (!((old_data ^ data) & 0x1) || chained)
-		return 0;
-	if (!(state == NCSI_CHANNEL_INACTIVE && (data & 0x1)) &&
-	    !(state == NCSI_CHANNEL_ACTIVE && !(data & 0x1)))
+	if (state == NCSI_CHANNEL_INACTIVE)
+		netdev_warn(ndp->ndev.dev,
+			    "NCSI: Inactive channel %u received AEN!\n",
+			    nc->id);
+
+	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (state == NCSI_CHANNEL_ACTIVE)
+	if (had_link)
 		ndp->flags |= NCSI_DEV_RESHUFFLE;
-
 	ncsi_stop_channel_monitor(nc);
 	spin_lock_irqsave(&ndp->lock, flags);
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 602af74bee81..632caeea672f 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -834,12 +834,11 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			break;
 		}
 
+		nc->state = NCSI_CHANNEL_ACTIVE;
 		if (nc->modes[NCSI_MODE_LINK].data[2] & 0x1) {
 			hot_nc = nc;
-			nc->state = NCSI_CHANNEL_ACTIVE;
 		} else {
 			hot_nc = NULL;
-			nc->state = NCSI_CHANNEL_INACTIVE;
 			netdev_dbg(ndp->ndev.dev,
 				   "NCSI: channel %u link down after config\n",
 				   nc->id);
-- 
2.19.1

