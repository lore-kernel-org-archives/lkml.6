Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B97DC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CA72190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026918;
	bh=RUaBm/YMp9M1Sw70QcSa4ukqGdLSql/KuV1pzCFlsWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PejX+ALazjN+6bceHN3zfAIUDvaskjKCVDi/DwBMfbcPbQq8xYNlqL/cXmlsDZruP
	 GIkNY/1Y6H/iACa5ZrJb3ReTgk8qKQTIUDA/tzHilb1Hxk2i72PrEpBq5oW96FYHP1
	 CoFnJumSNr/YF2twQO5kGUaMH8Y4+zYGDeJ4KFDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390318AbfBMDB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbfBMCfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F363222CA;
        Wed, 13 Feb 2019 02:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025301;
        bh=RUaBm/YMp9M1Sw70QcSa4ukqGdLSql/KuV1pzCFlsWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiOF7h/aP1OlYlUUXvCmSkvIT8veNLhfoxynBUsF9CrB4rCEUufbulENHJuWPAEzv
         Zsjl5TF8LQNuGTDDoqAUhXebWVA8WNoYHhVrFuP+avduoDYQBimISiX2clb7Lxi5mK
         KmaQxo7NUPIpnXmhUY674QlzUATpNqmiNiBkBjy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 055/105] net: stmmac: Check if CBS is supported before configuring
Date:   Tue, 12 Feb 2019 21:32:46 -0500
Message-Id: <20190213023336.19019-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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

