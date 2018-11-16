Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084AFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DA82086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="Aqeuz16Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjhc7M3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DA82086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbeKPPDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:03:44 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33443 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbeKPPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:03:44 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EAB321F39;
        Thu, 15 Nov 2018 23:52:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Nov 2018 23:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=TKybd/8pKkry/5GpkN2bMEomipNAgg7KmoqRbqS8cRM=; b=Aqeuz
        16ZYEyPxniDRxrQMOY7eNtzGSwhpkUmQPKfiaC8TKQk4OMnLU67xobOc0hVFVQIC
        nF4+0WGPh6mdN/L2lEBu5EwA531Kf5yCYv1VA9CJVmY97GBJImFd7rWR8C708+V6
        E1VyaNW2gJPa1RhbeMFcy5Voo6iSQ/sal00itJlVi3+ie7QYtMj5lrYMOhth08Lt
        Oi6McEyhvyd22dHIfq4yI7ijFV+ZVS9ZMmthzQNWyEm4fr8yq5I/44zcFPANlOD9
        Ju0P7boFCGeNFxwcN4/h7fXizK9s5Cheeypgf8dwmZCRXOg6nB504baNasoQCzH3
        m0ypxLz4GFw609rhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=TKybd/8pKkry/5GpkN2bMEomipNAgg7KmoqRbqS8cRM=; b=wjhc7M3v
        7uzN38/Cye9GiFFIOfpaFwSgFV8kNdK/+eZbwgHoKaV6/uq2L2t0AmjqqxCqM8RX
        I1Aja8f7aWBW81rl9z5MwvmnCuU8p6LcCP2f7gFLynCldCtktH3JQp58/jjTBer6
        l1A/C5iYb5DhqlkkLr+DXJSP39LKpSLCB590u0m74Yqs8Zjno2Lrk7x3y0saRe7p
        ZvcPF1Cf7hxg7dx0x31aphWRJnZ9CRgE5QNKdr2LBKu3Jppwk6x9+Y4S0qqD/9zB
        7NNDzAQVkDrgKI3TpHjtTKJVo0Sdjz7iWt4/623ZbM8qKXQZOtYnHcHJ6eINVT7V
        9Xwm/QF73maZHQ==
X-ME-Sender: <xms:Jk3uW39gvDCDrGk9hTFhFkYSG35Hw3czSL5jGqa6pR56AswxL7F26g>
X-ME-Proxy: <xmx:Jk3uW90DZMEXFDdrImbyEanzhARxAgZsvQ3_3mnPnnIBjRrxIyIsMQ>
    <xmx:Jk3uW--aL5V1f2MIyMB56BpdhLJam82-JaLzH9fZP4U1wp7hGF40_g>
    <xmx:Jk3uW-2R087S7Sd3WuU_R4azIT2MbfA5rIOC1W-dSauZepXXlpHz4g>
    <xmx:Jk3uWx1ugiy-YNLfT0_iiIaP8HySg_2KAQfEWC5YavdcxHcv8N4Ftg>
    <xmx:Jk3uW6svKF8yIdpJGjsqTdLNKuMB9-PzA279n09r1PoynEjIpwkXqQ>
    <xmx:Jk3uW86vA_rUklDW1qDvCodVYelnuJ3pEaL8y4vizu8FUUZv-YTRnw>
Received: from v4.ibm.com (unknown [1.144.189.168])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F4A4E405B;
        Thu, 15 Nov 2018 23:52:49 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v4 4/6] net/ncsi: Don't mark configured channels inactive
Date:   Fri, 16 Nov 2018 15:51:57 +1100
Message-Id: <20181116045159.4980-5-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116045159.4980-1-sam@mendozajonas.com>
References: <20181116045159.4980-1-sam@mendozajonas.com>
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

