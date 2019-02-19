Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B317C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA88C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rxRKXpUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfBSR2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:28:54 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11994 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:28:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6c3cd40000>; Tue, 19 Feb 2019 09:28:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Feb 2019 09:28:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Feb 2019 09:28:53 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 17:28:52 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 17:28:52 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6c3cd40000>; Tue, 19 Feb 2019 09:28:52 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [PATCH V5 1/2] i2c: tegra: remove master fifo support on tegra186
Date:   Tue, 19 Feb 2019 09:28:51 -0800
Message-ID: <1550597332-21018-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550597332; bh=SI5vfHD9A9ylPQ5V7KKpG8Wp7VTFCOk05JbpZqEtpcg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=rxRKXpUop+Tb/yrAeGrrrzUDaWlD7sh2bR3XOBKVapvnRagrFUWp46Kcw2AWfg2kE
         PpdZGqmRiMEMYZBaWYSFMRbfdIfE8iew6W0+TkLVtM/ZwMgEX69O9AbMsm7xFQ9aDT
         tlcrpIsR/gaYEx1YXEpXW1hdKr0C8oHpIUWJWBWv+388gsmXRDaMdbvgD2bOQIqT0+
         1WIxZ5nN4ra9iboZWXNzPpK7yIWlgt5iii+gupz5gRRVzWbQwbMKFj+EvRSXyFbtNt
         m17LBYDSY2P+odN+T5iB9kFNS+aoV7zlA04P7KyagG7idg5xJdzc+1SmQKr0sEt7Gl
         gMVale3TRiSrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 does not have master FIFO  control register and instead
uses FIFO control register like prior Tegra chipset.

This patch fixes this and prevents crashing during boot when
accessing FIFO control registers.

Acked-by: Thierry Reding <treding@nvidia.com>
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

