Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D36C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DFF20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sAt12VCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DFF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbeIYBIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:08:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbeIYBII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:08:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so11176113wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ovJ89b4f0jIndSx6u2gnoJYN1C5zis8Q20nM2X/nQY=;
        b=sAt12VCAmFy8D2MjfHDSBJ+EIZUfCBgQ25eJvT6t4fIadfZJvQpl1nZfdCv2+krP0z
         0xfn+NnWS1u0MWXHPK1+OMqSaMifEva8QjL1TXXzL/+PmVO7yb+gpWIj/9c5V4AzCbTY
         0WVwwJn8Ckd/qwuqiz/lPH/JVg9wRXTYS4urzPJcXIER+dMxv+eGzNgFSnDjiQXShGX0
         vN8R8cZzM0913Mvu2QxBFvVzzxvNcVnU/oRUs/S/jOHcjnRsc5S3CEWXOvEH6gHncxsk
         F42FG1MlX0qLr7/aZRGAXOtRKtLXtFKGdJ+S2Kk6tkWMzO07+JZJMU1WBHkVDqNmJ/y8
         PZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ovJ89b4f0jIndSx6u2gnoJYN1C5zis8Q20nM2X/nQY=;
        b=HRqseUpPYT4Tv6MCtHyfkXilP2V6j4gqhcV8y0jMe8Pct6a5BOtUQmxeCrIRi04Bo+
         SfY9U8kpUWDDHlpfDg9woDNNShwsSyCjpZDufMrf7ee0YIf2lv6HaZPO4PiuoWH0OnHM
         azxRvHOW2QRqs1o5tZuNzj/0iZy2oNvNoBQ3r2PwHTphTc285kAPsyO3hs2icMEGzcK8
         3Wo8ng6M4ds8lM39myxKoWkWnpNSPD84Q89DDVtz61uqp9i5kub5F9ByTsvTaVVW/h9b
         ZmAFPfnZKqNZB88zINx/vKCYlx5VBgxHRsisGWviKGWPbNWXmXHAPlTEfEEtDwn0W7Kb
         vbAw==
X-Gm-Message-State: ABuFfohDcyvnLuLY2kendeqElt+hcDhoXh9Hl82N1fkdNnp3BQyaXOvZ
        6ED8txvRNt0HGt2Ww0SsnlqecA==
X-Google-Smtp-Source: ACcGV60mh5eBGHuaDzCS9co1quv6trb6fadSI2JQjt8gEX5/GILMOV0RbZqiY8RxsmKXDTCU2dlzuQ==
X-Received: by 2002:a1c:4857:: with SMTP id v84-v6mr8222775wma.8.1537815871871;
        Mon, 24 Sep 2018 12:04:31 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm27721433wmd.32.2018.09.24.12.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 12:04:31 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 5/7] net: ethernet: stmmac: dwmac-sun8i: use xxxsetbits32
Date:   Mon, 24 Sep 2018 19:04:14 +0000
Message-Id: <1537815856-31728-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert dwmac-sun8i driver to use all xxxsetbits32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 62 ++++++-----------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index f9a61f90cfbc..74067a59af50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/stmmac.h>
+#include <linux/setbits.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -342,50 +343,30 @@ static void sun8i_dwmac_disable_dma_irq(void __iomem *ioaddr, u32 chan)
 
 static void sun8i_dwmac_dma_start_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v |= EMAC_TX_DMA_START;
-	v |= EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	setbits_le32(ioaddr + EMAC_TX_CTL1,
+		     EMAC_TX_DMA_START | EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v |= EMAC_TX_DMA_START;
-	v |= EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	setbits_le32(ioaddr + EMAC_TX_CTL1,
+		     EMAC_TX_DMA_START | EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_stop_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v &= ~EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	clrbits_le32(ioaddr + EMAC_TX_CTL1, EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_start_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL1);
-	v |= EMAC_RX_DMA_START;
-	v |= EMAC_RX_DMA_EN;
-	writel(v, ioaddr + EMAC_RX_CTL1);
+	setbits_le32(ioaddr + EMAC_RX_CTL1,
+		     EMAC_RX_DMA_START | EMAC_RX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_stop_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL1);
-	v &= ~EMAC_RX_DMA_EN;
-	writel(v, ioaddr + EMAC_RX_CTL1);
+	clrbits_le32(ioaddr + EMAC_RX_CTL1, EMAC_RX_DMA_EN);
 }
 
 static int sun8i_dwmac_dma_interrupt(void __iomem *ioaddr,
@@ -578,7 +559,6 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
 				      unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
 	if (!addr) {
 		writel(0, ioaddr + EMAC_MACADDR_HI(reg_n));
@@ -588,9 +568,8 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
 	stmmac_set_mac_addr(ioaddr, addr, EMAC_MACADDR_HI(reg_n),
 			    EMAC_MACADDR_LO(reg_n));
 	if (reg_n > 0) {
-		v = readl(ioaddr + EMAC_MACADDR_HI(reg_n));
-		v |= MAC_ADDR_TYPE_DST;
-		writel(v, ioaddr + EMAC_MACADDR_HI(reg_n));
+		setbits_le32(ioaddr + EMAC_MACADDR_HI(reg_n),
+			     MAC_ADDR_TYPE_DST);
 	}
 }
 
@@ -608,11 +587,8 @@ static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
 static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
-	v = readl(ioaddr + EMAC_RX_CTL0);
-	v |= EMAC_RX_DO_CRC;
-	writel(v, ioaddr + EMAC_RX_CTL0);
+	setbits_le32(ioaddr + EMAC_RX_CTL0, EMAC_RX_DO_CRC);
 
 	return 1;
 }
@@ -662,21 +638,15 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
 				  unsigned int pause_time, u32 tx_cnt)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
-	v = readl(ioaddr + EMAC_RX_CTL0);
 	if (fc == FLOW_AUTO)
-		v |= EMAC_RX_FLOW_CTL_EN;
+		setbits_le32(ioaddr + EMAC_RX_CTL0, EMAC_RX_FLOW_CTL_EN);
 	else
-		v &= ~EMAC_RX_FLOW_CTL_EN;
-	writel(v, ioaddr + EMAC_RX_CTL0);
-
-	v = readl(ioaddr + EMAC_TX_FLOW_CTL);
+		clrbits_le32(ioaddr + EMAC_RX_CTL0, EMAC_RX_FLOW_CTL_EN);
 	if (fc == FLOW_AUTO)
-		v |= EMAC_TX_FLOW_CTL_EN;
+		setbits_le32(ioaddr + EMAC_TX_FLOW_CTL, EMAC_TX_FLOW_CTL_EN);
 	else
-		v &= ~EMAC_TX_FLOW_CTL_EN;
-	writel(v, ioaddr + EMAC_TX_FLOW_CTL);
+		clrbits_le32(ioaddr + EMAC_TX_FLOW_CTL, EMAC_TX_FLOW_CTL_EN);
 }
 
 static int sun8i_dwmac_reset(struct stmmac_priv *priv)
-- 
2.16.4

