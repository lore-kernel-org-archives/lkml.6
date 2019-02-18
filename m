Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A7920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MJH7TnUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfBRVMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:12:45 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18833 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:12:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b1fcb0000>; Mon, 18 Feb 2019 13:12:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 13:12:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 13:12:44 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 21:12:43 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 18 Feb 2019 21:12:43 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.150]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6b1fc90000>; Mon, 18 Feb 2019 13:12:42 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [PATCH V3] i2c: tegra: fix tegra186 hw feature support
Date:   Mon, 18 Feb 2019 13:12:40 -0800
Message-ID: <1550524360-29008-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550524363; bh=HaLrXyjeA/kqNrsW1idTNvDYdlNKXy7I/XwbBqQpmgQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=MJH7TnUR6GcSfm8IBcvI58GinQfri8vlCYEw4JO/6BmDgcOg2gGNc3Qt3OEtXwine
         u/+XB3FUE+7DnS53tiUejejNAJ3xAFBqLnpOYfV71FgWq4UB9kIRladeTHpCFCVAhi
         Sv1PizTTZMEx/yZMcoLMVIY8z3zxEBOtlOZxspMc2zfiPMJ9sFnZ4jnMD5s6pI+TZt
         YVij8kUT7XU5IDauuKdHVoCdAuX69U+8nqiJdKzX3qUHDKuBAgVJe8ghu7dW+ckabq
         WC7tJn/5x7u5pu8l8WxE8MHqPqUxPNjB524HDGUEajfVk2MjtTKpvoeEqpGFlnAWP4
         /WXoORDHoSNAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 does not have master fifo control register and instead
uses fifo control register like prior tegra chipset.

This patch fixes this and prevents crashing during boot when
accessing fifo control registers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a4cd79c9f7a7..e6851904acc1 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1436,7 +1436,7 @@ static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
-	.has_mst_fifo = true,
+	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = false,
-- 
2.7.4

