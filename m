Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C16C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3384206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU5Crjvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfBZSqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:46:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35740 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfBZSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id t13so7349880lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q2OKdZERs/8jAWziFkYs/uIS+0wWtSfv5QZ7vRzwEFY=;
        b=DU5Crjvhw0VaZz+4UB44EKVB2DkEtQ03+SJ3M9IdzqteTvgTrTJoSqMxx9OKPvdaaP
         c+d2HHMpV47MLBrXSfcGo64o3/xCPa3+eqtvh9zSycDFLj0OdNjxcTZ7kGiQ6r1Fk4GB
         74iAtrXQapvmFfK3QufjAUNplX2GrXG0TZCFvY6VRq+G8dnw1hpq3vusiweiD1XpSik/
         EDl2orgZ33DPMghWxsqguLGIvNzNcoG00TRskHYX8mRqV+E32vRccLdsGcA65cF/zqmz
         zv/mWiXGhG1H8A7zyi5u9bbKs/V0FAVi2vK8OgQgK8XmY779SeINYGejHOdAb76w4/NM
         mmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q2OKdZERs/8jAWziFkYs/uIS+0wWtSfv5QZ7vRzwEFY=;
        b=X1IN0gxlPG2iKCEUlgdH8Apd94TdYwqBEXxcXxyJ0EF8gx3OWdZBBu7IrkLUzUhq32
         nYX2Bfm3d16osQ8LEYumr1hjCi7LKCJ0IL4HL1krf1liP0ZIGIKaL9rRZJfiDDQ7t5r0
         AQe4gLuIMG3B2bhCRHLx2zEleGe7SbWnkYha9fJVE8ZIXtUqvvIZr6DFK5qBe1LmQ3K5
         3hJdgKh+L4Y2WGEli639zJH4MsOig7nNV4Fl+r7FYpiedgB2vAcmyCfO26cesvRWZJpv
         IBE+oNKKxgxXBogHZYVIvbrWQG+0aAK+O+0bngT0Uhb7bPtoBIo++/KsKvfoM9S3ZiDL
         FHgw==
X-Gm-Message-State: AHQUAuYNoL4o3mdNPSfHwtG5yUOpGxcUsrzmNgOqOOm5eRG45aI8QXx0
        CAPAm7M4i9j6jWGOk94ODnrQtw==
X-Google-Smtp-Source: AHgI3IbznJ+DtGfmG9vIeDhwsmRW5wYSf1f8Je6D16idNJoVHhJDnVdKClxI0cfMkNytNeTqiGCQIQ==
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr14200214ljk.169.1551206795225;
        Tue, 26 Feb 2019 10:46:35 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:34 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 6/6] net: ethernet: ti: cpsw: add macvlan and ucast/vlan filtering support
Date:   Tue, 26 Feb 2019 20:45:56 +0200
Message-Id: <20190226184556.16082-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpsw supports unicast filtering as for real as for vlan devices
now, but has no flag set for that. As result, once macvlan or vlan
adds new ucast address the cpsw is silently toggled to promiscuous
mode. That's smth not expected, so patch fixes it.

A unicast address for vlan has to be presented by vlan/unicast entry
in ALE table. At this moment, while vlan address change, entry is not
created in any form, even just like real device unicast used for
macvlan, leaving only address inherited from real device created
while vlan addition.

Therefore, program unicast entries for vlans by using IVDF, it allows
to add only vlan/unicast entries for vlans, omitting real device
ucast entries unless they are added for macvans or so, as they are
redundant for vlans and just consume forwarding table and in case of
matching packet income - CPU time.

So, after this patch, cpsw has ability to handle macvlan and vlan
ucasts, synchronizing ucast tables for these devices with cpsw ALE
table exclusively.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 62 ++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index fd76d1f12911..c6d5ddc05299 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -693,6 +693,31 @@ static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
 	return ret;
 }
 
+static int cpsw_set_uc(struct net_device *ndev, const u8 *addr,
+		       int vid, int add)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int flags, port, ret;
+
+	if (vid < 0) {
+		if (cpsw->data.dual_emac)
+			vid = cpsw->slaves[priv->emac_port].port_vlan;
+		else
+			vid = 0;
+	}
+
+	port = HOST_PORT_NUM;
+	flags = vid ? ALE_VLAN : 0;
+
+	if (add)
+		ret = cpsw_ale_add_ucast(cpsw->ale, addr, port, flags, vid);
+	else
+		ret = cpsw_ale_del_ucast(cpsw->ale, addr, port, flags, vid);
+
+	return ret;
+}
+
 static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
 {
 	u16 vid;
@@ -711,6 +736,24 @@ static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
 	return 0;
 }
 
+static int cpsw_add_uc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_uc(ndev, addr, vid ? vid : -1, 1);
+	return 0;
+}
+
+static int cpsw_del_uc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_uc(ndev, addr, vid ? vid : -1, 0);
+	return 0;
+}
+
 static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -730,6 +773,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 
 	/* add/remove mcast address either for real netdev or for vlan */
 	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
+	__dev_uc_sync(ndev, cpsw_add_uc_addr, cpsw_del_uc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -2009,6 +2053,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
 	__dev_mc_unsync(ndev, cpsw_del_mc_addr);
+	__dev_uc_unsync(ndev, cpsw_del_uc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -2369,10 +2414,12 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 	if (ret != 0)
 		return ret;
 
-	ret = cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
-				 HOST_PORT_NUM, ALE_VLAN, vid);
-	if (ret != 0)
-		goto clean_vid;
+	if (!priv->ndev->vid_len) {
+		ret = cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
+					 HOST_PORT_NUM, ALE_VLAN, vid);
+		if (ret != 0)
+			goto clean_vid;
+	}
 
 	ret = cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
 				 mcast_mask, ALE_VLAN, vid, 0);
@@ -2381,8 +2428,9 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 	return 0;
 
 clean_vlan_ucast:
-	cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
-			   HOST_PORT_NUM, ALE_VLAN, vid);
+	if (!priv->ndev->vid_len)
+		cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+				   HOST_PORT_NUM, ALE_VLAN, vid);
 clean_vid:
 	cpsw_ale_del_vlan(cpsw->ale, vid, 0);
 	return ret;
@@ -3344,6 +3392,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
 	vlan_dev_ivdf_set(ndev, 1);
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
@@ -3606,6 +3655,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
 	vlan_dev_ivdf_set(ndev, 1);
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
-- 
2.17.1

