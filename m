Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8129C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A2A20647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpBLoTmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A2A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbeG0WNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:13:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36142 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbeG0WNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:13:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so5521945lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NAl3yy/7hIcejXSfbK5GMYeiMaRlfOfS3qnBt7Q+wUY=;
        b=WpBLoTmFiXfnCpnFEmeFUPy/vbP3B/9MBcXBjycAmGKdehuxQ4WLrRWDh6YOK/t/wh
         pLcOxmJdRW8V5CCKzxbSAzPF6IwjVUSpB9XHOSjQ7zznXhDGHLi8wJG9/JCIyP8q9ffB
         jSf1hXU8Qf6616opv0CNhUaw6w5+FAcy03S8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAl3yy/7hIcejXSfbK5GMYeiMaRlfOfS3qnBt7Q+wUY=;
        b=FA8IivV/R1p0HrhcL22ZxKFfxD5VbnN4QDvd3122QyLV9aN7EwAw1mP6IVrSdSzYN8
         xIM/jzARuJL1xQbZBhixC/2J8Wh1Y370KUKkALbbO8zmobZNiWmLU2wuowCoX+Xk9vBT
         5w/M9qRmhSPORqcr083g/z94dalHk4wRjSYJKTY86oW+4oAmsO5n/UDFIu5JGbGkqX5I
         erLC4qouVAg9tmcycQgpGTpVPGustgAmmgg+LWN6NsbeH8Xhv7e0gVvFDz8bkIKByBer
         OOUNUzAqyqnhaAFchBoG09CZbC6jEwlfuS6OwD1uO32DJtlIQ8j9uZn83fJ3RS7Ddxcu
         awDA==
X-Gm-Message-State: AOUpUlFhyJV92RHsMH7ul+6gQYSkavHgMF95OEdjxu6kG0tnEI2n5vu2
        pESLYvgHxH1cTAISon7RgWOdPQ==
X-Google-Smtp-Source: AAOMgpfk6mR7n+HiVm/CkTaOJ1wEyINRQw3MIBK+1oBVkPmraGvRzsLRt9wvP7iLQyvmBeeOTAb3Ww==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr5940082ljf.67.1532724602350;
        Fri, 27 Jul 2018 13:50:02 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 14-v6sm812947ljc.74.2018.07.27.13.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 13:50:01 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     andrew@lunn.ch, joe@perches.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next] net: ethernet: ti: cpsw: replace unnecessarily macroses on functions
Date:   Fri, 27 Jul 2018 23:49:58 +0300
Message-Id: <20180727204958.23658-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ugly macroses on functions.

v2..v1:
 - removed inline for cpsw_src_port_detect()

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 63 +++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b54c26c2bec..9cacfe4ad065 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
 				(func)(slave++, ##arg);			\
 	} while (0)
 
-#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
-	do {								\
-		if (!cpsw->data.dual_emac)				\
-			break;						\
-		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
-			ndev = cpsw->slaves[0].ndev;			\
-			skb->dev = ndev;				\
-		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
-			ndev = cpsw->slaves[1].ndev;			\
-			skb->dev = ndev;				\
-		}							\
-	} while (0)
-#define cpsw_add_mcast(cpsw, priv, addr)				\
-	do {								\
-		if (cpsw->data.dual_emac) {				\
-			struct cpsw_slave *slave = cpsw->slaves +	\
-						priv->emac_port;	\
-			int slave_port = cpsw_get_slave_port(		\
-						slave->slave_num);	\
-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
-				1 << slave_port | ALE_PORT_HOST,	\
-				ALE_VLAN, slave->port_vlan, 0);		\
-		} else {						\
-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
-				ALE_ALL_PORTS,				\
-				0, 0, 0);				\
-		}							\
-	} while (0)
-
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
 }
 
+static void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
+				 struct sk_buff *skb)
+{
+	if (!cpsw->data.dual_emac)
+		return;
+
+	if (CPDMA_RX_SOURCE_PORT(status) == 1)
+		skb->dev = cpsw->slaves[0].ndev;
+	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
+		skb->dev = cpsw->slaves[1].ndev;
+}
+
+static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	if (cpsw->data.dual_emac) {
+		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
+		int slave_port = cpsw_get_slave_port(slave->slave_num);
+
+		cpsw_ale_add_mcast(cpsw->ale, addr,
+				   1 << slave_port | ALE_PORT_HOST,
+				   ALE_VLAN, slave->port_vlan, 0);
+		return;
+	}
+
+	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
+}
+
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -706,7 +706,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 
 		/* program multicast address list into ALE register */
 		netdev_for_each_mc_addr(ha, ndev) {
-			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
+			cpsw_add_mcast(priv, (u8 *)ha->addr);
 		}
 	}
 }
@@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	int			ret = 0;
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
-	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
+	cpsw_src_port_detect(cpsw, status, skb);
+	ndev = skb->dev;
 
 	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
 		/* In dual emac mode check for all interfaces */
-- 
2.17.1

