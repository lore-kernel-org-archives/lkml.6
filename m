Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D65EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79E217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WuaAie5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfBSEuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:50:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1202 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSEuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:50:37 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b8b210000>; Mon, 18 Feb 2019 20:50:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 20:50:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 20:50:36 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 04:50:36 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 04:50:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 04:50:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.150]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6b8b14000a>; Mon, 18 Feb 2019 20:50:29 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [PATCH V4 2/2] i2c: tegra: remove multi-master support
Date:   Mon, 18 Feb 2019 20:50:25 -0800
Message-ID: <1550551825-1245-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550551825-1245-1-git-send-email-skomatineni@nvidia.com>
References: <1550551825-1245-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550551841; bh=pzNEtKdTrbqaZqgK9hSyAwcCXgOXh5EjLj0Qvh77Ix8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WuaAie5lmFenWSJNLnhohUH3tHxvCk21/89aCOW+cpSU1nXDVXHYdPsdK9LDxiy78
         yx+a5mBCATUy5mFXvMzcZNzyimta6axe1lYrBh5tteolUXkYeDfKx0JYuvOJjyDr2k
         Dr5ix/Mf1wbbduEoCS8w571he0h/3gjRWo3/ZyubZNIrAfztPEwiPYFBkAiinwAi/O
         FSXgbH2r+4kOexr9+MB/fAvJDn4yQdWs2LZ2KuAprI1b7EcxoHMDXkjKXG4QR4f2CQ
         PbZ+YhWf4U9+dXyWA1Aqqpv1hEjh3F7gFyYeZby9abiQ4U1w9nW8xCmYB3tp4FiBKP
         T/pI0qYbgzctA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

multi-master support is defeatured on Tegra210 and Tegra186 due to
known bugs.

This patch removes multi-master support for Tegra210 and Tegra186
i2c hw feature.

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

