Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B76320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2J3BqTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B76320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJYWof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJYWof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEE32086C;
        Thu, 25 Oct 2018 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476699;
        bh=npRbuyT9Gch3TUyBEUf2kLEsWyqmuk4C6PMOipwK2OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2J3BqTsOCazsPipUQwZd7OnB8SE7EKDKtfO8BeZOtjdLpuEfMtFJxvrYUHrdHKKG
         LT/AEc31p1kHTyDtHuU9gzqTHF/EdiX8Em4bt9cfwB6UXNoNrpYNu5dE/A0mnkK2DN
         5tJLCXiK+GeY21xI0E4XUWxc+iPX41st060I0UP0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 32/46] mmc: dw_mmc-rockchip: correct property names in debug
Date:   Thu, 25 Oct 2018 10:10:39 -0400
Message-Id: <20181025141053.213330-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

[ Upstream commit e988867fd774d00aeaf5d3c332032bf5b97a4147 ]

Following up the device tree fixed in commits e78c637127ee ("ARM: dts:
rockchip: Fix DWMMC clocks") and ca9eee95a2de ("arm64: dts: rockchip:
Fix DWMMC clocks", 2018-02-15), avoid confusion by using the correct
property name in the debug output if clocks are not found.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 339295212935..40d7de2eea12 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -282,11 +282,11 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 
 	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drv_clk))
-		dev_dbg(host->dev, "ciu_drv not available\n");
+		dev_dbg(host->dev, "ciu-drive not available\n");
 
 	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
 	if (IS_ERR(priv->sample_clk))
-		dev_dbg(host->dev, "ciu_sample not available\n");
+		dev_dbg(host->dev, "ciu-sample not available\n");
 
 	host->priv = priv;
 
-- 
2.17.1

