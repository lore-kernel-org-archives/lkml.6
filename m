Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91EF20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91EF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLKTeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:34:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:60513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeLKTeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:34:16 -0500
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54fe-1hNFmP0NIc-00zIHc; Tue, 11
 Dec 2018 20:33:39 +0100
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
Subject: [PATCH 6/7] [DSA] tell GDMA when we are turning on the special tag
Date:   Tue, 11 Dec 2018 20:33:13 +0100
Message-Id: <20181211193314.10695-6-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:uFgKQXFf5ffjFoYiHtcDtZDgE2oDlHS562h3FDJ6QC9XXwBnE5y
 CONdUO19qPjv3zRQmvcGXVS4tLjnPeRJozuJIcvahp7pGrsM5uKsFgEQ4MN0gWFeVMBw9Gx
 +B8CcF6tBpPNoof+Uq92L/FGvYka5vZkxE7/vtEW/DfB7+lxsQyPUCmTk+/L/6kxVpMovZs
 B1zP3X69gkvpbYuWNhnLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xO9EQCi536I=:b+bOI7S7AJJsRlQortI3Sq
 i3+ejQQd/dbczxZJbXf0gavnEkFxzLfhTU6IHCKfLC21vUP3qaqNfh/AfsT3MjPoWfzu3q08+
 8ly4JxvNvC6s+4VhsX185bxDZcRG5CiaDoK193i6L5wMvAoJtHiEyynwKcohsLsyVQIqli/6b
 GeYb+h0nXf6DneF3vg76rFL+RdTBqAYsjvl5L9L1RIgFzdKKgMPRuPnAYEDPzMOY5BQKa+T3Z
 fyYG2vXwr92E6pKzCn4s5Bknugrbdx4cAA4NGgxKDCWD6H/MZzJcxJUnv5KdZ2a47vkGvbcRw
 fMlyFYzampC8n2OgBD8aGoEF9mQqz6lyhLQ4S+bGUMqrFGtAqB+sHBwN9c6Sepwgmg5Ikigre
 8FfR6vDOtv47SeP0MRI0ikMrPOrwiXRxb01LP29ZR4cI5j3l3EXDk6d8xz3X2BjcObqdF+Lmv
 gqrPEXl/euUHKzRCtbPoldTvg1sCZO4zfmszDW+oMCGQdomxPfc+SuQb1dQmHAIzC+Fbr6oLi
 7wQOhSkXBmPucuWuBnR3xTwUGnwF46/Vqqdk0nPeYE7YPyM6IWXVBsjCRLYdi3F/gUmI+bimt
 UmGKv+PsRRadlM1sO9myKVmUBqZa00fn28ejntrT4GXe6J3fQDZJPbbFhVO7AqgJdh/7vA8Ef
 BCfvzFc0JW9QoGFkMscmYzhbjx6C6blefrhkWAs0d4ciO6gl/SLlqQMYS2KWddD/2zpG4qlrn
 JfnuAuGSFG/QW3P6jz1F9G+RSPOcmvOQ0G5WrfyB9xr+boHBzVqWZN1hAjhsUdo0jixJqigCW
 w8nWL6CTh4Kal4+vTX4ojDozl5WDtejsCgblaZzWkHBGv2hra+95Wf6lBQw6GOOGciWfGv85v
 U1JVf8V4RIc0+n9nGv0t8ikqKEh0pOAnZd+ND5Md0FsEDw+lMMkW5YnKB7IZAx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0044-net-next-dsa-mediatek-tell-GDMA-when-we-are-turning-.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/dsa/mt7530.c | 6 ++++++
 drivers/net/dsa/mt7530.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 441320d4d779..83669f53cb36 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -681,6 +681,12 @@ mt7530_cpu_port_enable(struct mt7530_priv *priv,
 	mt7530_write(priv, MT7530_PVC_P(port),
 		     PORT_SPEC_TAG);
 
+	/* Enable Mediatek header mode on the GMAC that the cpu port
+	 * connects to
+	 */
+	regmap_write_bits(priv->ethernet, MTK_GDMA_FWD_CFG(port),
+			  GDMA_SPEC_TAG, GDMA_SPEC_TAG);
+
 	/* Setup the MAC by default for the cpu port */
 	mt7530_write(priv, MT7530_PMCR_P(port), PMCR_CPUP_LINK);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index d9b407a22a58..310f2536175b 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -23,6 +23,10 @@
 
 #define TRGMII_BASE(x)			(0x10000 + (x))
 
+/* Registers for GDMA configuration access */
+#define MTK_GDMA_FWD_CFG(x)		(0x500 + (x * 0x1000))
+#define GDMA_SPEC_TAG			BIT(24)
+
 /* Registers to ethsys access */
 #define ETHSYS_CLKCFG0			0x2c
 #define  ETHSYS_TRGMII_CLK_SEL362_5	BIT(11)
-- 
2.17.1

