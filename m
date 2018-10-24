Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F6C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3876D2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zsKdmC3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3876D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeJXQDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:03:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53587 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeJXQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:03:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id f8-v6so1838982wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9XvifWIVMLJuaC7p+Q4aHgeSVhuEGRb41PplzjfoOeA=;
        b=zsKdmC3sWrpIJ8EWu/GkW0SRR28b3qhMi3gTtdcam5oBQc8ilfdA6tr73Meirv53X7
         8HmhymsWT/Sm4Nqul938thyny9nRFzc91kfmNT/cMtzZu8Z0x8CBH/9F8lI9RWAETCni
         I/Iqyw+OyQLmVbaJtmjO17Oa7nlCCFOweEKfCIjEUzT5LGYj5eyrzcCAX0MWmPS5/uhu
         EU42pRAGHbgCC5jpK6qpt0Rsc1NlV+dYegqSuc5CJiQ3Sl2Rrub5c8W8awJa2O6NdI4u
         YvWfuAj0ujLYzOIfJ1NV1XXjss4skD87rIftxq/b+4zrIyyDvxTc4us2XgxY3PXmZvxM
         sTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9XvifWIVMLJuaC7p+Q4aHgeSVhuEGRb41PplzjfoOeA=;
        b=iMv9DGj9JAQeYgcFa55CJEJfHZgrmJ8+WqnGwtaa+co8P8iyAts9EFZne2rVhp6LPl
         sAKagI/sgQJzWSN/CD79RG4KAvQW40qm30A0xg5jlzjTrO7GMWuNzVnkmGS5nIWlmvqy
         zp4QNqlVqucdGSRzOlq3jX4XWTsdMhn/wONLiETPtcV9Sd7acrytlvZ1J73YgM1BEC+D
         I9ZgMCG3h+igGAEKJOU/LN9invabRkUDGubW8ryxaqZCLqO6CRhqcxhNan/6BgcbIzdR
         4Z8hpQBNIpzdNombrlwNCDKNaBDv/RGthj4MJCy8bdBxh0UdbIEo4xc4fo2xP8XHb/Fe
         4f9Q==
X-Gm-Message-State: AGRZ1gLYxPXELp3rr2i/s9XPgUqQaJ7j96XfazRykPzx9xM4y8BXMfO/
        YyBEilRh7bvp52ZMvBRRAbwfRA==
X-Google-Smtp-Source: AJdET5dJVREjq1d49GF0tpTa8ysMRo4t1Wv0JmvMGCs/cIdU7lQzho//rY/qods5Hpprh4oUU+GRZw==
X-Received: by 2002:a1c:2501:: with SMTP id l1-v6mr1457395wml.133.1540366569886;
        Wed, 24 Oct 2018 00:36:09 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b139-v6sm6254351wmd.36.2018.10.24.00.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 00:36:09 -0700 (PDT)
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
Subject: [PATCH v3 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits_le32
Date:   Wed, 24 Oct 2018 07:35:53 +0000
Message-Id: <1540366553-18541-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert meson stmmac glue driver to use all xxxsetbits_le32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 56 ++++++++-----------
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
2.18.1

