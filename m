Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1537FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96C420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeFMGEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:04:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53804 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbeFMGEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:04:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSyt8-0005JM-JI; Wed, 13 Jun 2018 06:04:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] WAN: LMC: fix up indentations with tabs
Date:   Wed, 13 Jun 2018 07:04:09 +0100
Message-Id: <20180613060410.735-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently this source is using a mix of 4 char spaces and tabs
for indentations.  Clean this up to consistently use tabs. Also
add some white spaces in switch statements.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wan/lmc/lmc_proto.c | 79 ++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wan/lmc/lmc_proto.c b/drivers/net/wan/lmc/lmc_proto.c
index f600075e84a2..5a6c87bce1bf 100644
--- a/drivers/net/wan/lmc/lmc_proto.c
+++ b/drivers/net/wan/lmc/lmc_proto.c
@@ -49,17 +49,17 @@
 // attach
 void lmc_proto_attach(lmc_softc_t *sc) /*FOLD00*/
 {
-    lmc_trace(sc->lmc_device, "lmc_proto_attach in");
-    if (sc->if_type == LMC_NET) {
-            struct net_device *dev = sc->lmc_device;
-            /*
-	     * They set a few basics because they don't use HDLC
-             */
-            dev->flags |= IFF_POINTOPOINT;
-            dev->hard_header_len = 0;
-            dev->addr_len = 0;
-        }
-    lmc_trace(sc->lmc_device, "lmc_proto_attach out");
+	lmc_trace(sc->lmc_device, "lmc_proto_attach in");
+	if (sc->if_type == LMC_NET) {
+		struct net_device *dev = sc->lmc_device;
+		/*
+		 * They set a few basics because they don't use HDLC
+		 */
+		dev->flags |= IFF_POINTOPOINT;
+		dev->hard_header_len = 0;
+		dev->addr_len = 0;
+	}
+	lmc_trace(sc->lmc_device, "lmc_proto_attach out");
 }
 
 int lmc_proto_ioctl(lmc_softc_t *sc, struct ifreq *ifr, int cmd)
@@ -99,37 +99,36 @@ void lmc_proto_close(lmc_softc_t *sc)
 
 __be16 lmc_proto_type(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
 {
-    lmc_trace(sc->lmc_device, "lmc_proto_type in");
-    switch(sc->if_type){
-    case LMC_PPP:
-	    return hdlc_type_trans(skb, sc->lmc_device);
-	    break;
-    case LMC_NET:
-        return htons(ETH_P_802_2);
-        break;
-    case LMC_RAW: /* Packet type for skbuff kind of useless */
-        return htons(ETH_P_802_2);
-        break;
-    default:
-        printk(KERN_WARNING "%s: No protocol set for this interface, assuming 802.2 (which is wrong!!)\n", sc->name);
-        return htons(ETH_P_802_2);
-        break;
-    }
-    lmc_trace(sc->lmc_device, "lmc_proto_tye out");
-
+	lmc_trace(sc->lmc_device, "lmc_proto_type in");
+	switch (sc->if_type) {
+	case LMC_PPP:
+		return hdlc_type_trans(skb, sc->lmc_device);
+		break;
+	case LMC_NET:
+		return htons(ETH_P_802_2);
+		break;
+	case LMC_RAW: /* Packet type for skbuff kind of useless */
+		return htons(ETH_P_802_2);
+		break;
+	default:
+		printk(KERN_WARNING "%s: No protocol set for this interface, assuming 802.2 (which is wrong!!)\n", sc->name);
+		return htons(ETH_P_802_2);
+		break;
+	}
+	lmc_trace(sc->lmc_device, "lmc_proto_tye out");
 }
 
 void lmc_proto_netif(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
 {
-    lmc_trace(sc->lmc_device, "lmc_proto_netif in");
-    switch(sc->if_type){
-    case LMC_PPP:
-    case LMC_NET:
-    default:
-        netif_rx(skb);
-        break;
-    case LMC_RAW:
-        break;
-    }
-    lmc_trace(sc->lmc_device, "lmc_proto_netif out");
+	lmc_trace(sc->lmc_device, "lmc_proto_netif in");
+	switch (sc->if_type) {
+	case LMC_PPP:
+	case LMC_NET:
+	default:
+		netif_rx(skb);
+		break;
+	case LMC_RAW:
+		break;
+	}
+	lmc_trace(sc->lmc_device, "lmc_proto_netif out");
 }
-- 
2.17.0

