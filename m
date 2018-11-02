Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BFC2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUyEa9sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BFC2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeKCEAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:20 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3DE42081F;
        Fri,  2 Nov 2018 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184725;
        bh=q65LVTpaBQ+Th89plhabnzf/BSsM7cCAISMTaghfRT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUyEa9sJv+OzmvbdDNnkW2pR3MZRrNZa+7cCr/HZ7SRO0lhCkHao9lwe1eAbX0kyc
         YTL39KDSCR9Z+ahJfJxH37KHk89t5ieiLBC88mKAyepyq1x2WYOnWUmtNJc37VVE+v
         BTqZYbJDEnyx63gKrZdJD4wa9+qKDWKNMMUeK7ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Keeping <john@metanate.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 081/143] mmc: dw_mmc-rockchip: correct property names in debug
Date:   Fri,  2 Nov 2018 19:34:26 +0100
Message-Id: <20181102182904.062691478@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



