Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5DBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DB420883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r7mFJ35R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DB420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbeIYBIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:08:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388127AbeIYBIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:08:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so20791618wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ElyGP3i983za7JT8O7IacoH2pa4Z6qAmJG+FvzufmS0=;
        b=r7mFJ35R7Te5RGzC3bKSEvVNwyQyfbM5kkM4lr/kNxDPS5TdTyScnW2kUxkY50+6U1
         BUovNyW1AQIqiKZ1QxNWCt7S6vM4CEg39N27iItBrU3EUX+Ya5TTLOdRbnZ+TbnsldQa
         0J13R+vUn7WaFyg2mTfdcku9gfJ+4+BVmWmAA0i8MLa2zT4wj6ZyvBrsnW654RFp0DHi
         U8lTQk5amv1Ak0ohNGGov3/zSyFvx2LQrT2FTBlmC1B636ugx4DDyULJfyHDy+yDDaiZ
         kaoLlSvbL+S93jZion66KjfZdJc+rQU/Hrknpe/dtRYk+HG9zQN/fwxIXiKHPJ85YvMv
         VHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ElyGP3i983za7JT8O7IacoH2pa4Z6qAmJG+FvzufmS0=;
        b=Y79HwXN9FXn+o0FZYoIiwjjClNPcAwjLKqcVsQ0RTFrUI+BYpoEV13bGAfQK9P+0+l
         tb1yJ99xwLf56HZ7p7jNojSFFf7vJy4XeAZFaRyt07IteR/2GTEMYR7oD3hgeB7idZQT
         peCyg5w5gH30DyGNdGzkZvnL0SbEMAM6BJtdkuvLlHKuGPCYQxRHOHboCmLND82eTTm1
         bYnzsNdsjpUYgAq+/qVbWArY6kEXax3cDumBIbH/jKm3yIJjFsmsCKX0R6vfRz+e+Lfr
         wmh0dNLtKFfiy442OQ6qT/cRRmj+LMr17O709yvmMUlMn06oQG9kAuagJtcQ4l30jJrr
         Wrjw==
X-Gm-Message-State: ABuFfoiktJwTgDJVGyyX7Mfi6eAC9qS1AFKU+WJD+p+dh9YC3ZYC31lu
        5cVeZPx5ERPvtSmvyrHIEJeQjg==
X-Google-Smtp-Source: ACcGV63sTUVI0HgRJ5VUlmxNENKxGBqqa/CpvyDWsm0uRMngvY03UgCo4N732GTs1wM1rUw0r2sV/Q==
X-Received: by 2002:adf:f506:: with SMTP id q6-v6mr126443wro.241.1537815874021;
        Mon, 24 Sep 2018 12:04:34 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm27721433wmd.32.2018.09.24.12.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 12:04:33 -0700 (PDT)
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
Subject: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
Date:   Mon, 24 Sep 2018 19:04:16 +0000
Message-Id: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..abcf65588576 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/stmmac.h>
+#include <linux/setbits.h>
 
 #include "stmmac_platform.h"
 
@@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
 	struct clk_gate		rgmii_tx_en;
 };
 
-static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
-				    u32 mask, u32 value)
-{
-	u32 data;
-
-	data = readl(dwmac->regs + reg);
-	data &= ~mask;
-	data |= (value & mask);
-
-	writel(data, dwmac->regs + reg);
-}
-
 static struct clk *meson8b_dwmac_register_clk(struct meson8b_dwmac *dwmac,
 					      const char *name_suffix,
 					      const char **parent_names,
@@ -192,14 +181,13 @@ static int meson8b_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE,
-					PRG_ETH0_RGMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+				PRG_ETH0_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE, 0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+				0);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -218,15 +206,15 @@ static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RGMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_EXT_PHY_MODE_MASK,
+				PRG_ETH0_EXT_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_EXT_PHY_MODE_MASK,
+				PRG_ETH0_EXT_RMII_MODE);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -255,11 +243,11 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* only relevant for RMII mode -> disable in RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK, 0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_INVERTED_RMII_CLK, 0);
 
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+				tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
 
 		/* Configure the 125MHz RGMII TX clock, the IP block changes
 		 * the output automatically (= without us having to configure
@@ -287,13 +275,13 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 
 	case PHY_INTERFACE_MODE_RMII:
 		/* invert internal clk_rmii_i to generate 25/2.5 tx_rx_clk */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK,
-					PRG_ETH0_INVERTED_RMII_CLK);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_INVERTED_RMII_CLK,
+				PRG_ETH0_INVERTED_RMII_CLK);
 
 		/* TX clock delay cannot be configured in RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+				0);
 
 		break;
 
@@ -304,8 +292,8 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	}
 
 	/* enable TX_CLK and PHY_REF_CLK generator */
-	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
-				PRG_ETH0_TX_AND_PHY_REF_CLK);
+	clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
+			PRG_ETH0_TX_AND_PHY_REF_CLK);
 
 	return 0;
 }
-- 
2.16.4

