Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73C0222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHWeIXst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437014AbfBMWHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33868 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436997AbfBMWHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id j18so1858357pfe.1;
        Wed, 13 Feb 2019 14:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iyaq3yEjkUqCdNXty1gzLutDNHaIKj6egyv5O/wPqPk=;
        b=lHWeIXstmVjHTmd88m1ivg4nObLl4jTdKn3KpN8aMDAshZHsgkPsGNbUDERKeb7BhI
         9TNquCTl+ssi4E4t0fu2NfGPToDkT8YCsdZIUQLXGryqcnBVLP2RGFi7SFetrCqPJdMA
         S9kE2MEHwHB4Xd/Djxn6/OguEWiCYOhkcQRPZRTrC6vdmxwEsNx4l2JbKMokQaVR/vRb
         mQRWbyZd4KdKTG2DhEHTIMMAMc1NejJIk2eYm5a/QqwaBGdrIeVtvnvDFS3ggnLx4pDM
         VCcn8kC20sOXRbEZRoi4IMMRlKHNSMopsdROE8ez4oVx+JvehykHujJT0jpY4j/XrGIZ
         cDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iyaq3yEjkUqCdNXty1gzLutDNHaIKj6egyv5O/wPqPk=;
        b=YSNnyD2OHlFNP4Yu+sfpzn0x3Ts9wnjXmoPIvoqgtgmPfqtXVOlxSFoSkMQlxCcjZ9
         S/v4Muh/hyIZs1iIeQ9zNpiZ5mAoKFwYH74jYpF2w/KOanJoXp7k1u2U1EkEYht92aUR
         xvOAP86wFPgi6ad02Stymfy1IJvH2PISoT/e0uc/NI2DzNfSidI+hcGeg8nEtEdgwdhA
         19silF1DjmbsY9QMhWHIiGTgoi4IVlwXPxSqbquKNDLvuB6HlhqPOPEtt03RHfU3nonu
         XZnI21Hc3sCwBiKm5Ckx5vSuKz5Mpuc2yGscKHfYzclEKyUamcs2C7c7jPxnEKc+XKJX
         0Bvw==
X-Gm-Message-State: AHQUAuYCCKp7Bwur0SD1fLy9PbBPf7y8kFRwl3ZD31EZv4AOtLQ/ArTM
        6tzRNx3cU2+aX77PEbWVf3CrclA6
X-Google-Smtp-Source: AHgI3IYHmCsEIr/eRgJhG6wyPFagIhzKMKVa4f6LxPnoo6bNFNDbtLjui+FHk4G/9EV5aBLGRhSAyQ==
X-Received: by 2002:a62:931a:: with SMTP id b26mr417644pfe.65.1550095657834;
        Wed, 13 Feb 2019 14:07:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:36 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 6/9] rocker: Check bridge flags during prepare phase
Date:   Wed, 13 Feb 2019 14:06:35 -0800
Message-Id: <20190213220638.1552-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 48 +++++++++++++++--------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5ce8d5aba603..863a8b32e6e9 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1565,37 +1565,48 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 	return wops->port_attr_stp_state_set(rocker_port, state);
 }
 
+static int
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
 static int
 rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 					unsigned long brport_flags,
-					struct switchdev_trans *trans)
+					struct switchdev_trans *trans,
+					bool pre_set)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
 
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans) && pre_set) {
+		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+		if (err)
+			return err;
+
+		if (brport_flags & ~brport_flags_s)
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
 						trans);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_support_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
-}
-
 static int
 rocker_world_port_attr_bridge_ageing_time_set(struct rocker_port *rocker_port,
 					      u32 ageing_time,
@@ -2066,6 +2077,7 @@ static int rocker_port_attr_set(struct net_device *dev,
 				struct switchdev_trans *trans)
 {
 	struct rocker_port *rocker_port = netdev_priv(dev);
+	bool pre_set = false;
 	int err = 0;
 
 	switch (attr->id) {
@@ -2074,10 +2086,12 @@ static int rocker_port_attr_set(struct net_device *dev,
 							   attr->u.stp_state,
 							   trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true; /* fall through */
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
-							      trans);
+							      trans, pre_set);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		err = rocker_world_port_attr_bridge_ageing_time_set(rocker_port,
-- 
2.17.1

