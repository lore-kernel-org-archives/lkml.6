Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A436C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6368720857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="bXfmsgGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oqCS1Fr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6368720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeKHMXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:23:00 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57391 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbeKHMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:22:59 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F5042202A;
        Wed,  7 Nov 2018 21:49:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Nov 2018 21:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=TKybd/8pKkry/5GpkN2bMEomipNAgg7KmoqRbqS8cRM=; b=bXfms
        gGZnPRYZ2ETp0ArHB0uJvU3he8xQfYK9Wdq00IwCKNEuD0ti3CCqOazmw409bRXJ
        jdxPQqVwU4F1mzx2Wsp8gdYmapkkKyu29QsJAiUoF268BKR6usv/qtivKZwzfitw
        cqDsDZv94ThmVAJiEdvOOow6kJ/2yxkPAx0b14V8MHCTngy1r8C1zpo/dnPYfqBm
        0euQw4O6jp/29eBB5YJFhSa+CqB0ed+OGGPNUYbzwETx84LvWgTUZvrZugouK3oq
        3KeU53lPJs7EGmXThlj/RuOMoJzIbfA7Rw9NzN5jqOGuu+BXAHW8vnXjBtZoAICZ
        pk4JGLOv72XpWex8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=TKybd/8pKkry/5GpkN2bMEomipNAgg7KmoqRbqS8cRM=; b=oqCS1Fr1
        OsZBiPCA1F/tX2Wt54FmhlvK6omRmQV83SfQ6z3Pp4WfYbXiLi/PZ/6t0n40ncNU
        W6+bpcFpfXtfr6/7YW/kYuVasEhHNU6pTDVei700lxYFa18qt3qiTRPUrLDPsKLk
        l3VCQXjBJJ6X6ThH0wlhrslwWnaAOc4nKETBSugE0s7DIgb6ubBiqrmeZgBJo/iR
        +0vqVvF6A8xDDGp1GQJbvCbu6SUQNR1PzmvXWipCRAz3dXyMDQxginzvZD4BZcYc
        PQerAS9ZrYK+MNIL/DZUlhRg6EnsICHiGyRAHLYgnefa/dt3QlO0bWKKsfN/id85
        OqrVf8SbseZZGw==
X-ME-Sender: <xms:R6TjW8-9yG-GmJMjcb6I3EUnj2jFa_FrJ-epH_ExqqaGUlWEVoqr-A>
X-ME-Proxy: <xmx:R6TjW-Y89rgO8J_SDqdE8AsDzjN4KadD9Fdzu17makzbJFHUKKIUTw>
    <xmx:R6TjW2vHCV7q28lhQFLeIzCyDw4Us53emkc84IV89IFcEIzf4YMDAg>
    <xmx:R6TjW1ACxtC_BGNVtup7g_SBNOZbDTFdylr5OPHsvQYwC6NUHHNJow>
    <xmx:R6TjW9O-rymeYQEnVmKybkdIXiata5roN-TWWhXofdJIUgaA-XXGzg>
    <xmx:R6TjW_4SK4llFhhneeZj9aNBrBXO2c8CG0TKsSiQLbCIfJ5oOiCxvQ>
    <xmx:SKTjW1ha4GUVH6hykaxzb6aS4auemiQ8N-ym3KDRKZqFtghC2xxqbQ>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9CC7A102E4;
        Wed,  7 Nov 2018 21:49:41 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v3 4/6] net/ncsi: Don't mark configured channels inactive
Date:   Thu,  8 Nov 2018 13:49:07 +1100
Message-Id: <20181108024909.9897-5-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108024909.9897-1-sam@mendozajonas.com>
References: <20181108024909.9897-1-sam@mendozajonas.com>
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
index b8b4e765a04c..b9de5b78c4e9 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -916,12 +916,11 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
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

