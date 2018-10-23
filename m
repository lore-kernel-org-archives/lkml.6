Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07C920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="hTu3yL/W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRndkjDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07C920813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeJXGRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:17:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50769 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeJXGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:17:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B612821C89;
        Tue, 23 Oct 2018 17:52:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Oct 2018 17:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=/Lf2bysx9LSwEnHUIBHWsPQikReeP3wBbfwiS2/ITLE=; b=hTu3y
        L/W7vB2VBykKiXWCVuDIEq5LC83ZpmxA33+mePpUHAQzFLfB7GxXGd1xa/m+fVhE
        LY/MstMi4DpL0NwdfENcpaSDxCoKwzZv3BqPf9Oz0ioAOz+eSpSBuK4WXa7nQYim
        zRG2SsYHQbj7vgG/6OiHf4v6LWZOuwe4/UmHSj8u7CY7YEhlL4oomP9Uh9D/rBGc
        mDwVdc50CBeI4eCHdL2+SYHM1qKM+01TD0p7Q1egVupNyg+SJFirNzimpGcGC4XB
        x8ddUBEcHGToz2pOQAWGJSLDFcwM064U83kKd1N9dcNMyvCRRrnGhTByaosvXmeB
        TSgDqcM1LXbe/W8qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=/Lf2bysx9LSwEnHUIBHWsPQikReeP3wBbfwiS2/ITLE=; b=XRndkjDB
        w96ZRna2rNg+N4+YpFYNzbZOyPCBfjyqBraK76FWYBILDRA9vV9HYBoJZ04WZIXI
        pFf//o+W5kWqZ4KaPgRxPt0maU8PmjTQEQbRH1OnyWT8wClk/DW4V0GH8ul3e1mr
        25EiCkhALgNBTpNEGU867qouiGg+PApXOD47Uxzf5UePA9Uoss/lm6NJnt5X2Lhx
        xzNpKk+hN5InT/P7xmixCs7vpACtp7rh/4lohOjNR4kHnn6PtzZ/WZVY61q/r0jv
        6marbVDsb+B/8a3RmK6Kzo7OmAL6l4aTiXJTSmv3Nk6SPwKLV+xoj1iHW1Qh3pRl
        ECOZdppxcT0u/A==
X-ME-Sender: <xms:I5jPW8OY6JhRtzyCpZtoNJwfoo00lVzcYC2s_N10SrhHxKMZnPhD3Q>
X-ME-Proxy: <xmx:I5jPWy6LQsqrXbDOg41-0CHvCXQMkZCitJ6BO2wcEvljH0lwITR3dA>
    <xmx:I5jPWy2YWxN_XhzNgzxYHKePrDzF0kS9TBt2eY3s5syJajLLs12WNg>
    <xmx:I5jPW37k9GOsmvwmI1gQ3HLVpkIUIlBUUnsolSwOeuNXJDYvf24yGw>
    <xmx:I5jPW9qGKb7FBFYkB7oNM8-gJDyyip4s2p5RPnju6jp1UWTb4WOkwQ>
    <xmx:I5jPW3V2k9HwA9aSmdZbQ5rSZqmOVckTFKmPG5Cyfa_T2yxn5nKWrg>
    <xmx:I5jPW-uSlrsei0S-dH6iMfotUkNdZXlOmzgMiMzcN5HsJIwmWl7xKA>
Received: from v4.ibm.com (unknown [158.140.225.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41F81102E4;
        Tue, 23 Oct 2018 17:52:32 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v2 4/6] net/ncsi: Don't mark configured channels inactive
Date:   Wed, 24 Oct 2018 10:51:59 +1300
Message-Id: <20181023215201.27315-5-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023215201.27315-1-sam@mendozajonas.com>
References: <20181023215201.27315-1-sam@mendozajonas.com>
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
index 013437b42e94..014321ad31d3 100644
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

