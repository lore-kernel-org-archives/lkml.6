Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F4CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C98214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCOTXKZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C98214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeHVOWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:22:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34511 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeHVOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id g9-v6so1089640lfh.1;
        Wed, 22 Aug 2018 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kscD0129qQm+6dtLepdo30nacGeBZA/daG2P7mOzej8=;
        b=RCOTXKZ/M9pdiVUa7E6hXQB5gNOoCAlLkjIvTMUBAdE3HvdPjYWS0UqueM6m4z+7yr
         IlVQ5hXQQ4QUgocb/PlJ2kVxNqvRvg6ptXyFR7BMp0IDGbbbmtKLlKkM9LCLHDmpcT/z
         N8Z6YBFaXVuQVN07bTrtAIF03LJNA7gM4xo82WTL6M/DVMr9yD45O1sqZvMWe/Gaq8uU
         eqO29XMvWem0pikxbVDHYPHwH/Sk3ndKAgGEwy/uVmzdDPAX0rqRm0qlXDGoCzPTvcMV
         K1OuYgcBmOuPnYfLhNKYzSKN1QqYkcPJywUoz0HquOo3qmsg1Blcf8y5H1UDnyRWrKgU
         jOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kscD0129qQm+6dtLepdo30nacGeBZA/daG2P7mOzej8=;
        b=hyiN+usbF9/VK+6tv1RFFQI4nKh0wv1+Qy/bmeCHkMpqHwpLiz9QH70J1ZKoVPUGIc
         aSRVhIoZ3P9mujALLpixb/Sfj+FrPu14tz8w6yDr8VK4fa25UYtE9wTA1LgdK86Evk8i
         diLPlXz31U8bv8EMWZxKNMqJt8tIYOB9Q1uL9CnjQyaT72DQbVLxZDp397R1n6b2RnsC
         jnYbAkBRdim4JYiRobzo17jo0tjDBkLGNNucxOOzTn+P0oYRP/S8Q5iXjYIIMLurO+l4
         NC2BqEsPLDf3IpNYhkTkhoVXpbsHFMXcEQud0DQQXqUTQX9YRVdwTc0pN4x9OMYCU3Q9
         wypQ==
X-Gm-Message-State: AOUpUlGkbAcoj+UT/QpdkJaxBCwJATGArudXvNj9RQi4ROEihJyye05l
        poFw2wCqdYpwCEf3blYozxIqQjIZ
X-Google-Smtp-Source: AA+uWPyAOuLS0mi1DWuQI9dcFbtdDF6saEKXn3caWxbL3KZ8+JbEDznXZuTs24/SNn8uuBEEQSWiUg==
X-Received: by 2002:a19:4a09:: with SMTP id x9-v6mr17304737lfa.80.1534935442376;
        Wed, 22 Aug 2018 03:57:22 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m8-v6sm234062ljj.10.2018.08.22.03.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpD-0002Xi-56; Wed, 22 Aug 2018 12:57:19 +0200
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
Subject: [PATCH 7/9] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 12:55:45 +0200
Message-Id: <20180822105547.9634-8-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the mdio-internal
child node instead of using of_find_compatible_node(), which searches
the entire tree and thus can return an unrelated (i.e. non-child) node.

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

