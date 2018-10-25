Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18030C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B8720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsCa88nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B8720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeJYWsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeJYWsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:11 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4340920854;
        Thu, 25 Oct 2018 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476915;
        bh=1VhKplTVMsDTZv/pRu1nJzjBJTvFkRc7ec/9cGqTmv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsCa88nD9iCITSsGuI8OBZa+1q63yoFCYov0r/PHu46vDP3eICJEkNNKN7qtmvU3k
         IjFironEiDCwZ14ojcQK7si014N/gOKsRpRz6sCZKa1/rBPGzG2JNNvCbEEPK84SfP
         3E82AZy2GdbBDeIWf0/HurNnQiHuNzt6LX3Eb+hA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 34/98] net: ethernet: stmmac: Fix altr_tse_pcs SGMII Initialization
Date:   Thu, 25 Oct 2018 10:13:19 -0400
Message-Id: <20181025141423.213774-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit 77032732d0e89b83c3bca75b857a1f63e9efb44b ]

Fix NETDEV WATCHDOG timeout on startup by adding missing register
writes that properly setup SGMII.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
index 489ef146201e..6a9c954492f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
@@ -37,6 +37,7 @@
 #define TSE_PCS_CONTROL_AN_EN_MASK			BIT(12)
 #define TSE_PCS_CONTROL_REG				0x00
 #define TSE_PCS_CONTROL_RESTART_AN_MASK			BIT(9)
+#define TSE_PCS_CTRL_AUTONEG_SGMII			0x1140
 #define TSE_PCS_IF_MODE_REG				0x28
 #define TSE_PCS_LINK_TIMER_0_REG			0x24
 #define TSE_PCS_LINK_TIMER_1_REG			0x26
@@ -65,6 +66,7 @@
 #define TSE_PCS_SW_RESET_TIMEOUT			100
 #define TSE_PCS_USE_SGMII_AN_MASK			BIT(1)
 #define TSE_PCS_USE_SGMII_ENA				BIT(0)
+#define TSE_PCS_IF_USE_SGMII				0x03
 
 #define SGMII_ADAPTER_CTRL_REG				0x00
 #define SGMII_ADAPTER_DISABLE				0x0001
@@ -101,7 +103,9 @@ int tse_pcs_init(void __iomem *base, struct tse_pcs *pcs)
 {
 	int ret = 0;
 
-	writew(TSE_PCS_USE_SGMII_ENA, base + TSE_PCS_IF_MODE_REG);
+	writew(TSE_PCS_IF_USE_SGMII, base + TSE_PCS_IF_MODE_REG);
+
+	writew(TSE_PCS_CTRL_AUTONEG_SGMII, base + TSE_PCS_CONTROL_REG);
 
 	writew(TSE_PCS_SGMII_LINK_TIMER_0, base + TSE_PCS_LINK_TIMER_0_REG);
 	writew(TSE_PCS_SGMII_LINK_TIMER_1, base + TSE_PCS_LINK_TIMER_1_REG);
-- 
2.17.1

