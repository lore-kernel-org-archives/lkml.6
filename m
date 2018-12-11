Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EA020811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EA020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeLKTeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:34:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:39693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLKTeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:34:13 -0500
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWo2-1ghIBO0hd8-00ATwi; Tue, 11
 Dec 2018 20:33:40 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 7/7] [DSA] mt7530 add linking to mdio
Date:   Tue, 11 Dec 2018 20:33:14 +0100
Message-Id: <20181211193314.10695-7-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:/kdyN1LlQRxSXve23iYRsooYQC7XQPE+MLFtGKmyRq6aCx7CaWF
 FFL6X0ozaLhzOaPZ3eJCcfEwGzk3S1V9Zo7ZboAQYEsgKPf/nwlEUPzIFwssc85YdjqdhTI
 JKif1PECzon/COVE/8r0ICX+VLuqtLg/NrMAjNUUUXjJYgNy+taT3P8yofBNTQR2Luwut+W
 6g7qSqdsx6j994w1a/V7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZLol5aRfGU=:S/NLkB66pQ1JpOSRV6VaBg
 mZQkqCMr6AAsAqw8AIO3kNQaYc87G8ISC9zFztrd+Bu3WyotEIEsqPfUgJVr0IauWbYS+yKSx
 5o7FC09dWNdbHkP2JZFwkb2T2Fqe2wHrIUPGcqtNve2lf3Tm75Tt+WXVBH0L0yu6qe9E4Q0an
 okgJVM74knJ8iScSOW6jRYHr0zpoiWW8UYpg1ITvVrXLpFMlJtwxvu+jVYxvIN/IEOgaR3hw4
 4wxrNRCQu56Ozu2vdvpkOa7A9P7GHkp7jDAwubgdYihOQ9BFJsqYRFAy9FIY5mPWi6ZeUiQOY
 H+2DfHacy+/KH2fZXUW/THAHBvCMTQ6jYuyCmSgBuwj7nCR8peeVUF3YtwZkWJIxG/xnX/KTS
 TKA18J+NcPRiaJuM4anQl/mf8MZ+F6/BwcT4OEOuo8MR0bh4LmWEaSSx1ZTE4WGVMWW4F1Adp
 /irA6jNdSJ3i8Z2gShraycWxAKhDV/QCL97v2mAjkmqHFOi6+Fv5ZuXV2y8/zPmSK6Xun6eMA
 tZTEXa8SduPQlvTOiqp6aF6MR1yd05sU0ZgM8jnzB5R8k5ogvEh6/2fIKyWWHYjlkluu98SvP
 eJ2VF64PEhqmi4XyQrXlbH+i+xIsHMIzVD9/EDeKeu/mo1Y0kDsPJkrpzuIzKZRDkn+d1ylwO
 KrKMLXmd0qCJWoaGbbhNoQ1ODOv+P8NtuGM/B0CsoETcPKXv5hatDqday83Bh1xuamBa4hy+v
 jMTUXAKD9lq+gGyzuQUggVXk5HG24S03kKlOewFXCRvVj+ErxHaHh1YBJ9FbwaY0DFyB6wqK9
 fHjM8FJiTY61DPAMDTA82uS3LaOb0D1bf4EHB4A88+e1Nc4iM6WlGlRQAjfas7AGAOkyN8eUI
 2HmbsWyYREDqIS90ZVBb4UIoA9nqMg8SBLkwOPO4LB8aXjIlfjpM03JTE+/FJ1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0045-net-dsa-mediatek-turn-into-platform-driver.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/dsa/mt7530.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 83669f53cb36..e529bc334459 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1345,7 +1345,7 @@ static int
 mt7530_probe(struct mdio_device *mdiodev)
 {
 	struct mt7530_priv *priv;
-	struct device_node *dn;
+	struct device_node *dn, *mdio;
 
 	dn = mdiodev->dev.of_node;
 
@@ -1392,8 +1392,14 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->reset);
 		}
 	}
+	mdio = of_get_parent(dn);
+	if (!mdio)
+		return -EINVAL;
+
+	priv->bus = of_mdio_find_bus(mdio);
+	if (!priv->bus)
+		return -EPROBE_DEFER;
 
-	priv->bus = mdiodev->bus;
 	priv->dev = &mdiodev->dev;
 	priv->ds->priv = priv;
 	priv->ds->ops = &mt7530_switch_ops;
-- 
2.17.1

