Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8152C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61FF206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x/TSjgu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61FF206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeJXQDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:03:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50355 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbeJXQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:03:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so4221530wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L88Lfnmc/N8gUEWTdkG+BxTm3V0b7bIO1yVIVTZbeG4=;
        b=x/TSjgu25TvNgs9VmJZuSAl8dvUbcaEScHcOHuJ4At9u0M+pDuvoCmxajfBnDhK9Uf
         iZsnkrbPHXKbkM5ysIVj65CfzAz+CJ32utolctFrG0mB0jM5ZB8da+esje0wiSXy2jde
         Vxp2kSNfGRNMTA8zLH3iQvREO+Qc8nYzq7wT1WMrezbMWTDWCi2UvxXUzi2NOMQIPf0t
         GlNJJ7gg31lbwuw+nT061+8p9esBOqEahF7LvEvPe8qTG/YCjkYiZt/4Fu1B92CwI4fr
         TxagemSD/W4RYefOKNBg47DUlYlaPMmqZ4XXh0h3fWEik67bFVTaee1Cy3MqC9SZ3j01
         mJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L88Lfnmc/N8gUEWTdkG+BxTm3V0b7bIO1yVIVTZbeG4=;
        b=kgaK7lmoGvRO5cWg8Z8yaSpmx0OaZ6ndPWyf2x3fWGVpet7zVv/ym+8uabqzNA0IhE
         86aBRhFxsIYjF55lY68N8ccBAu31t+PuyFMipUjP6tyoW0+5wX1n+QiUsgB/kPaE1jAa
         SW5/eTZXzz5HQNMxuJUX9ms1z7r3bPM4PMjrmVTdd1TxGJYJ6CSQxFed7MRxyCarL8fc
         2c4Bgi+yXksViZ4HGSO5S67k61rmP12cCYLybu4IoGN1CFxao78xmwwnACJzkSgr21dB
         5Wxq+sqnN0NlA/uq66/7Fkm5CTXJQqQZMNvjeJ0M77N5VjigPz6ZJ+E9oYmS0LAPutsY
         BeuQ==
X-Gm-Message-State: AGRZ1gIntucNyFIWTu9Fa2YjJ6SRQWJu75mph2p79IxyIx+OVFfKcASQ
        hr3oG39sNNzr0klkSi4OHQmRBQ==
X-Google-Smtp-Source: AJdET5crZhAXz1KRb0S1BlPR0jMga616tJ5k9RmjLz/x7WzW7Bu/VUIAzb2xZyWoSP6tOR/tpBKDLw==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr1420888wme.97.1540366567519;
        Wed, 24 Oct 2018 00:36:07 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b139-v6sm6254351wmd.36.2018.10.24.00.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 00:36:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 5/7] net: ethernet: stmmac: dwmac-sun8i: use xxxsetbits_le32
Date:   Wed, 24 Oct 2018 07:35:51 +0000
Message-Id: <1540366553-18541-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert dwmac-sun8i driver to use all xxxsetbits_le32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 62 +++++--------------
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
2.18.1

