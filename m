Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4EC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF42621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026388;
	bh=RUaBm/YMp9M1Sw70QcSa4ukqGdLSql/KuV1pzCFlsWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oCSfh18I7HVpwuzo9QSoZmeQb1FSXZB1IhTD6lpkTVmph7hZwRWrDFq/JN+lwP2D7
	 2lwMM2q4GxOCwt1L7eQGwH0J2GSEHggrR3vXFJa6Zyzql4kNfg1z6aaYAjUDpXQHXt
	 Av6AxzSkccxjFeK4SLoBxIH3Gy7bEwRpx0yZMbKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbfBMCxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388501AbfBMCiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4330F222C7;
        Wed, 13 Feb 2019 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025501;
        bh=RUaBm/YMp9M1Sw70QcSa4ukqGdLSql/KuV1pzCFlsWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbWmFgdd1AY+2iDUf86OSGPC7ILdemF7pGQEY7ZdZ+c9tseGI6BNXIuI2RqDApUNs
         ptFKE4lG38SkGsse1TFxNGVAMPR8mw+zg5Xe8bLMplaSWak9AvhTtu62x1Ki/bB+hI
         3LbH2PQpbFFO3Deebcff7urTtJkGa4uF40peV8Z4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/83] net: stmmac: Check if CBS is supported before configuring
Date:   Tue, 12 Feb 2019 21:36:25 -0500
Message-Id: <20190213023701.20286-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>

[ Upstream commit 0650d4017f4d2eee67230a02285a7ae5204240c2 ]

Check if CBS is currently supported before trying to configure it in HW.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 531294f4978b..58ea18af9813 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -301,6 +301,8 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	/* Queue 0 is not AVB capable */
 	if (queue <= 0 || queue >= tx_queues_count)
 		return -EINVAL;
+	if (!priv->dma_cap.av)
+		return -EOPNOTSUPP;
 	if (priv->speed != SPEED_100 && priv->speed != SPEED_1000)
 		return -EOPNOTSUPP;
 
-- 
2.19.1

