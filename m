Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4935EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AF520890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpeC+yyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AF520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeG3Xmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:42:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33349 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeG3Xmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:42:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so11882352ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e/5Df3GfYNL2NR37dOp8MdMESR5yMsZb7sZ0YNOIllA=;
        b=EpeC+yyTrMSQJpDSc29JHwWNINnNmEIlQ6ozw7fNwxAMGzgpmGNEOPEZr8td58Mczb
         /NmGaxykojG5ocyxBDO8105F9eBUjov9kOMEg90bYRLB053AgECA4wMphdTGqat4OZxu
         Pz7RJh1iLTHyIKJOTOfl2BOaCLsY8sTfDczlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e/5Df3GfYNL2NR37dOp8MdMESR5yMsZb7sZ0YNOIllA=;
        b=FnmT9t7/rga/ZOl7S3oGlV/Q4F0rQD/nebV4FCS4OdZ32IMs9hjMD5t4ItPp4bKjA9
         zVjTZwB89srv90BajJAxmRNBQ6jeg0YTi4IHt+RyZYjmuYbXHKyF6+eSZbQprtW093dt
         mXeOSbrchPjBSr3fvOUCRmKTSbsKfiJR2AaqnlJhTIhitmgCViy4eCbh99n6IHsiW4oY
         iQjwWwXTpvU+OWukdH+xiF49MkePjA+araS/8SL6cNawBBDmgXZg3klQmS6uA4LGhwZ6
         +u0xwQavCvXYPQYk1kMZ0VS75x0nxTu2dFyrjXZa2aOK082Frq7bAyl7/DsbA+KTltxc
         Gzbg==
X-Gm-Message-State: AOUpUlHE4+Mx1bkqfOIYWP5yBR1xeH35WuuSM5QNt91wq9Ttx1JDUGER
        o0t0lLPKXycASVso9ePTTE/D8g==
X-Google-Smtp-Source: AAOMgpcHubtPGB0pXFGOUS8m5vYFef+EvtucQ5pbiSwhxRUnJkj1Gm4tVuAschOPbtTckEN6SDQ/og==
X-Received: by 2002:a2e:2067:: with SMTP id g100-v6mr2767227ljg.138.1532988342793;
        Mon, 30 Jul 2018 15:05:42 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id k68-v6sm1696499lfg.22.2018.07.30.15.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:05:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com, andrew@lunn.ch,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next] net: ethernet: ti: cpsw: replace unnecessarily macroses on functions
Date:   Tue, 31 Jul 2018 01:05:39 +0300
Message-Id: <20180730220539.12319-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ugly macroses on functions.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

v4..v3:
 - use directly code instead of cpsw_src_port_detect()

v3..v2:
 - comment corrections

v2..v1:
 - removed inline for cpsw_src_port_detect()

 drivers/net/ethernet/ti/cpsw.c | 58 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b54c26c2bec..f051ce35a440 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,40 +565,28 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
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
@@ -706,7 +694,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 
 		/* program multicast address list into ALE register */
 		netdev_for_each_mc_addr(ha, ndev) {
-			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
+			cpsw_add_mcast(priv, ha->addr);
 		}
 	}
 }
@@ -798,10 +786,16 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	struct sk_buff		*skb = token;
 	struct sk_buff		*new_skb;
 	struct net_device	*ndev = skb->dev;
-	int			ret = 0;
+	int			ret = 0, port;
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
-	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
+	if (cpsw->data.dual_emac) {
+		port = CPDMA_RX_SOURCE_PORT(status);
+		if (port) {
+			ndev = cpsw->slaves[--port].ndev;
+			skb->dev = ndev;
+		}
+	}
 
 	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
 		/* In dual emac mode check for all interfaces */
-- 
2.17.1

