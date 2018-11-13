Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D334C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF53208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JGo1lcNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF53208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbeKNDui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:50:38 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13893 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbeKNDui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:50:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5beb0f0f0000>; Tue, 13 Nov 2018 09:51:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 13 Nov 2018 09:51:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Nov 2018 09:51:29 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 17:51:28 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 17:51:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Nov 2018 17:51:28 +0000
Received: from byan-linux.NVIDIA.COM (Not Verified[172.17.136.14]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5beb0f1f0005>; Tue, 13 Nov 2018 09:51:27 -0800
From:   Bo Yan <byan@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Yan <byan@nvidia.com>
Subject: [PATCH] soc/tegra: remove duplicated function declaration
Date:   Tue, 13 Nov 2018 09:51:05 -0800
Message-ID: <1542131465-22773-1-git-send-email-byan@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542131471; bh=psuTxNDLVvtw4bUJnsfjTCMvum1Cg6Yllr/r1uKyITQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=JGo1lcNxnrRK1mlFHW2acW80zEAjGwRpWj3mT5WrjXOaolG/XVDtizR8xHjsAEw1F
         m3JuqFb0IucQFqm8bUrSeb5vJm5dCs1N7fJLtXm7rjJuIRTmak/bCxaQmE/igJ2loX
         BG8LhtYGKxtKo6tijdcqVFojhGWVgU640XxF5qgU8k0djkRNh2kMZu1b0tzKj+fpm4
         z3j45n3f8p+y1rG7TYteMgh0TBT/gHo8Hwl964rl0rUerLQP0+Cb5lNMiQ6AiDnbOI
         UHdXyEk2HAGhvO7mL4Bgw0vUHpvbfd4ldja4uSGYC6ptpuwkTRzqDmZhD2wqlIe8dL
         0cqtSpRey8PBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function tegra_read_chipid is declared twice in fuse.h. Remove
the redundant declaration.

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 include/soc/tegra/fuse.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 9b6ea0c..8fb2f8a 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -60,7 +60,6 @@ struct tegra_sku_info {
 
 u32 tegra_read_straps(void);
 u32 tegra_read_ram_code(void);
-u32 tegra_read_chipid(void);
 int tegra_fuse_readl(unsigned long offset, u32 *value);
 
 extern struct tegra_sku_info tegra_sku_info;
-- 
2.7.4

