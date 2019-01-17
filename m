Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4011C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E8820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGdD4FKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfAQTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:16:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46338 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfAQTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:16:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so9485437ljh.13;
        Thu, 17 Jan 2019 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tKmRB7GJaHSSkIUDoo2AkZBmBsvmRkAjrjhw9AzhMk=;
        b=nGdD4FKDQtKcvmuUXxXQ0m9Wgo2DnotcIIpIJPA/G2e3hbtO1+V0d0mpyNv6bS+avf
         CDEEBrTrpDOPvOq8I+iOq+D1VIOdy4k6tCR2gfPL79JBxycC4+pUhbxM28HMXGMBCIWU
         clgNDHhKqwNUUqqIeRWIZQrk+IBHEgVKHZD/FfxrVw8eopvcOXgSWOmvURayTLilcZ3V
         3ybcdbUKFF6zDfIISo/6onWATA3vJaKgAMHXHdQvVa4xuFaqlNPwwJR/G14mhzIljNRL
         ZEVLPR94wmz37FCjKJbw4ii/6DSCsHJ1VDyjR+q3fFZLcIjksn4ukXBgwGkRWx/ZP6Bp
         QHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1tKmRB7GJaHSSkIUDoo2AkZBmBsvmRkAjrjhw9AzhMk=;
        b=M5+FCv3d5MBt6slyaOGj9u68a3VaSG56CZTqr4mxAIIQ2ZmvXEAN1Xo7bBuHFbU42I
         p42/Mv+hwRc1xSvRtaYaTWo7/4mCj9uD9qOXYOruTILELSR2P48U925WApS/pYBW1eL/
         c6m86HzEbnw26yjY8aumzjUa5bPz0oISgDefrCWRUA0gstqxSZ8wm8bJQ9uR/LFTOcfE
         jQsfVU+II42HMbLJG5xq0UNqPode+Sw9GfAUVtiDmNSEDe/+Ju8h/u3pJt5pT41Rf07n
         5eUFqbuxkyJrdsLEF3PuArgOierucgSZYr6z7wKxmc25kT/MqxOvvlG8cnvpIoi1cVhw
         c+yQ==
X-Gm-Message-State: AJcUukf73ehOjz2U/omcXIv6YfxoVEmI7eJt8zPJ5xzDCZI4vt17lo5Y
        5BapDxyrXH8UZSY6+6ZipVI=
X-Google-Smtp-Source: ALg8bN6Y/h6th3UAyWbW8ywgeUAMYwnlqDcdH0tE8E46FdpdOGQhzTIt6tact62sZoH+wdOVlgiN0Q==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr11205527lji.130.1547752569996;
        Thu, 17 Jan 2019 11:16:09 -0800 (PST)
Received: from localhost.localdomain ([31.134.130.226])
        by smtp.googlemail.com with ESMTPSA id r1-v6sm390252ljb.64.2019.01.17.11.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 11:16:09 -0800 (PST)
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     panfilov.artyom@gmail.com, Tema <panfilovartyom@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] net: stmmac: implement the SIOCGHWTSTAMP ioctl
Date:   Thu, 17 Jan 2019 22:15:36 +0300
Message-Id: <20190117191536.24699-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tema <panfilovartyom@gmail.com>

This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
processes to read the current hwtstamp_config settings
non-destructively.

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 77 ++++++++++++-------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..f9b42b0c20f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include "common.h"
 #include <linux/ptp_clock_kernel.h>
+#include <linux/net_tstamp.h>
 #include <linux/reset.h>
 
 struct stmmac_resources {
@@ -174,6 +175,7 @@ struct stmmac_priv {
 	unsigned int mode;
 	unsigned int chain_mode;
 	int extend_desc;
+	struct hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
 	unsigned int default_addend;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5afba69981cf..a6dc40a70428 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -534,7 +534,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 }
 
 /**
- *  stmmac_hwtstamp_ioctl - control hardware timestamping.
+ *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
  *  @ifr: An IOCTL specific structure, that can contain a pointer to
  *  a proprietary structure used to pass information to the driver.
@@ -544,10 +544,10 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
  *  Return Value:
  *  0 on success and an appropriate -ve integer on failure.
  */
-static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config config;
+	struct hwtstamp_config *config =  &priv->tstamp_config;
 	struct timespec64 now;
 	u64 temp = 0;
 	u32 ptp_v2 = 0;
@@ -572,31 +572,31 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 		return -EOPNOTSUPP;
 	}
 
-	if (copy_from_user(&config, ifr->ifr_data,
+	if (copy_from_user(config, ifr->ifr_data,
 			   sizeof(struct hwtstamp_config)))
 		return -EFAULT;
 
 	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
-		   __func__, config.flags, config.tx_type, config.rx_filter);
+		   __func__, config->flags, config->tx_type, config->rx_filter);
 
 	/* reserved for future extensions */
-	if (config.flags)
+	if (config->flags)
 		return -EINVAL;
 
-	if (config.tx_type != HWTSTAMP_TX_OFF &&
-	    config.tx_type != HWTSTAMP_TX_ON)
+	if (config->tx_type != HWTSTAMP_TX_OFF &&
+	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
 	if (priv->adv_ts) {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
 			/* time stamp no incoming packet at all */
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* take time stamp for all event messages */
 			if (xmac)
 				snap_type_sel = PTP_GMAC4_TCR_SNAPTYPSEL_1;
@@ -609,7 +609,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 			/* PTP v1, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
 
@@ -619,7 +619,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 			/* PTP v1, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -630,7 +630,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 			/* PTP v2, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
 			if (xmac)
@@ -644,7 +644,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 			/* PTP v2, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -655,7 +655,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 			/* PTP v2, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -667,7 +667,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_EVENT:
 			/* PTP v2/802.AS1 any layer, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
 			if (xmac)
@@ -682,7 +682,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_SYNC:
 			/* PTP v2/802.AS1, any layer, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -694,7 +694,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 			/* PTP v2/802.AS1, any layer, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -708,7 +708,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 		case HWTSTAMP_FILTER_NTP_ALL:
 		case HWTSTAMP_FILTER_ALL:
 			/* time stamp any incoming packet */
-			config.rx_filter = HWTSTAMP_FILTER_ALL;
+			config->rx_filter = HWTSTAMP_FILTER_ALL;
 			tstamp_all = PTP_TCR_TSENALL;
 			break;
 
@@ -716,18 +716,18 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 			return -ERANGE;
 		}
 	} else {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 		default:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			break;
 		}
 	}
-	priv->hwts_rx_en = ((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
-	priv->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
+	priv->hwts_rx_en = ((config->rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
+	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
 
 	if (!priv->hwts_tx_en && !priv->hwts_rx_en)
 		stmmac_config_hw_tstamping(priv, priv->ptpaddr, 0);
@@ -765,7 +765,28 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 				(u32)now.tv_sec, now.tv_nsec);
 	}
 
-	return copy_to_user(ifr->ifr_data, &config,
+	return copy_to_user(ifr->ifr_data, config,
+			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
+}
+
+/**
+ *  stmmac_hwtstamp_get - read hardware timestamping.
+ *  @dev: device pointer.
+ *  @ifr: An IOCTL specific structure, that can contain a pointer to
+ *  a proprietary structure used to pass information to the driver.
+ *  Description:
+ *  This function obtain the current hardware timestamping settings
+    as requested.
+ */
+static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config *config = &priv->tstamp_config;
+
+	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
+		return -EOPNOTSUPP;
+
+	return copy_to_user(ifr->ifr_data, config,
 			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
 }
 
@@ -3767,7 +3788,9 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		ret = phy_mii_ioctl(dev->phydev, rq, cmd);
 		break;
 	case SIOCSHWTSTAMP:
-		ret = stmmac_hwtstamp_ioctl(dev, rq);
+		ret = stmmac_hwtstamp_set(dev, rq);
+	case SIOCGHWTSTAMP:
+		ret = stmmac_hwtstamp_get(dev, rq);
 		break;
 	default:
 		break;
-- 
2.19.1

