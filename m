Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23122C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C334D2174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdcgk5/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C334D2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeH0MIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40223 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so9179307lfi.7;
        Mon, 27 Aug 2018 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MT9TmywIaElj/9I+MStyljoZP2SLsnF9wGCpCMKLUw8=;
        b=Cdcgk5/MaYKrp0oDqqwXTGfTzSBNdx3DXNoVBbiQUOWFTbXnlJ++9m5I3XRyBB3zkr
         e+K3xHSJPcDfE+IeiCH6Fq4I41Ty++jR2pbyKgGTO3RYZG11BZLU6xaX9q12csSTEpKx
         OfByA2rAzcZIA6OTaTgghEMebt4YOc1UB1GA+gDVMUm1M6bneo8HZkx5rqiCqnsGXJVn
         7/viqgRE0LnJqlEXMugzuaaeFbCjETGYYEaQt6TyLxwX8U7Sk6bmPOcEq/vRb85ct0hg
         Ek7cWOe3wUk0CYTVIoX9rDzuo1iMJNiPXebNmr42EdSAPY5A5S/uoCtGbSLDl8rYgHIT
         lZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MT9TmywIaElj/9I+MStyljoZP2SLsnF9wGCpCMKLUw8=;
        b=nxGodQd0Kgs7EneiotOVJwEi4NPoaLVqUOJ5cmg6777xHqNhknSpYeBSyKPjkZLQZo
         oRopz76He7y6rO+B/X3Wh1lGi/MKA5kp7DPcOdGB7ppI0tdRDiuJlqOndiCmAjrgOHlo
         aT/r76wI8r6q7jBaRMdrfGCTQtdnZ6zv84kG0eKoVPloi3e3Xx8qqJgbWrCxa1aFrnfx
         V+qTaPIkKNV1pnEBFupyDwtkinULWeK5c/kVXG4rR5Nk8WHxaKgtnwGA0Wo2Fo6opOU9
         nM8sHhEcq5gLl/ROh7O3xA4f0G4VrZ9DTfDsL8FPfYgfOcXJo7p0MQAfa8gHfWXSPm1K
         rdcw==
X-Gm-Message-State: APzg51D8UE5bUDyo4juch8qwxEiexm4AnFWDxfwNGSJpt/NLoTbv87iW
        CmsdqKBjox5okb8nq/yCPPg=
X-Google-Smtp-Source: ANB0VdbufLyDQEcmp8zMBQWcsiA0G/zD7/hudLwbGGEW0FwCvFMmlpEKrDDayAd1Y9BxqjaFqCMG/A==
X-Received: by 2002:a19:4803:: with SMTP id v3-v6mr7285611lfa.46.1535358152476;
        Mon, 27 Aug 2018 01:22:32 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f18-v6sm2627464lja.85.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn7-0005sw-59; Mon, 27 Aug 2018 10:22:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v2 7/9] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Date:   Mon, 27 Aug 2018 10:21:51 +0200
Message-Id: <20180827082153.22537-8-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the mdio-internal
child node instead of using of_find_compatible_node(), which searches
the entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the mdio-mux node). Fortunately, this was inadvertently
balanced by a failure to drop the mdio-mux reference after lookup.

While at it, also fix the related mdio-internal- and phy-node reference
leaks.

Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index f9a61f90cfbc..0f660af01a4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -714,8 +714,9 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		return -ENODEV;
 	}
 
-	mdio_internal = of_find_compatible_node(mdio_mux, NULL,
+	mdio_internal = of_get_compatible_child(mdio_mux,
 						"allwinner,sun8i-h3-mdio-internal");
+	of_node_put(mdio_mux);
 	if (!mdio_internal) {
 		dev_err(priv->device, "Cannot get internal_mdio node\n");
 		return -ENODEV;
@@ -729,13 +730,20 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);
-			if (ret == -EPROBE_DEFER)
+			if (ret == -EPROBE_DEFER) {
+				of_node_put(iphynode);
+				of_node_put(mdio_internal);
 				return ret;
+			}
 			continue;
 		}
 		dev_info(priv->device, "Found internal PHY node\n");
+		of_node_put(iphynode);
+		of_node_put(mdio_internal);
 		return 0;
 	}
+
+	of_node_put(mdio_internal);
 	return -ENODEV;
 }
 
-- 
2.18.0

