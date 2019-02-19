Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DD42147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G/R2Y8ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfBSR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:28:59 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2055 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfBSR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:28:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6c3cda0000>; Tue, 19 Feb 2019 09:28:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Feb 2019 09:28:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Feb 2019 09:28:53 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 17:28:53 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 17:28:53 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6c3cd40001>; Tue, 19 Feb 2019 09:28:52 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [PATCH V5 2/2] i2c: tegra: remove multi-master support
Date:   Tue, 19 Feb 2019 09:28:52 -0800
Message-ID: <1550597332-21018-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550597332-21018-1-git-send-email-skomatineni@nvidia.com>
References: <1550597332-21018-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550597338; bh=UAK2VDiujQroMVpouAIUfSRRD872Y5/G5n5yoQR71HA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=G/R2Y8ourQI56wlOB86frUqKOvo2XMq7pmHpYzbcSCCtdzN9N6h4oTH2r2TUjX7bV
         +03MSC4vME5OSaKcYnLwsqMtRM5p0b8yibLdwEv5sIPAPTfhzj7xLuOW9dU4kJYZac
         PQHVTSeccEZNvSbwEs6jL9yXBFZw+l1CrZU7M5gjn1pOo2YoXNOKVQFXWTKbAostaL
         e/7vE/iLaU2TwQguXOj3lZfy4k6peXvzJ142eznypwxgsUaU/vJHdZGF02FlSrzRMX
         R+oSVL6fZwOY4pJK+YVit/0qEyu0Z6giQBlj5WoA3MpU5/iKC4gSFmBiruC3EM7Pcc
         JjK2zZp2Kth5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-master support is defeatured on Tegra210 and Tegra186 due to
known bugs.

This patch removes multi-master support for Tegra210 and Tegra186
I2C HW feature.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e6851904acc1..26f686bc3491 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1409,7 +1409,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
-	.has_multi_master_mode = true,
+	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
@@ -1434,7 +1434,7 @@ static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
-	.has_multi_master_mode = true,
+	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
-- 
2.7.4

