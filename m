Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C21C21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WeY98qdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C21C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeKUVFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:05:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbeKUVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:05:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wALAVNid053819;
        Wed, 21 Nov 2018 04:31:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542796283;
        bh=v/AkkzgRuzm0g5oVeWp3fvxZJE3jXzR8GJH7QUxOv94=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WeY98qdfDGB1V1rjzZC5ZYI+CjbnTPnqZb5f/LtAz+SOgZCS+oULvlZZJNe0NYRzT
         cfX3zbkrwIEbQxTBJSNAe0Ty3yJM69i/sHPF1vr5aHVZB6/0h/t1YkaNOZfs9UrfnQ
         9P4b2P30LUGpS2u0/2FMqKwZFvVEDieSaeYGan5Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wALAVNQo029062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 04:31:23 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 21
 Nov 2018 04:31:22 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 21 Nov 2018 04:31:23 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wALAVECf025951;
        Wed, 21 Nov 2018 04:31:21 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 3/3] mmc: sdhci-omap: Remove redundant structure assignments
Date:   Wed, 21 Nov 2018 16:03:57 +0530
Message-ID: <20181121103357.3448-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci_execute_tuning() function has assignment of
private pointers multiple times. Remove the redundant assignment.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 4fad47926743..f588ab679cb0 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -296,10 +296,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int ret = 0;
 	u32 reg;
 
-	pltfm_host = sdhci_priv(host);
-	omap_host = sdhci_pltfm_priv(pltfm_host);
-	dev = omap_host->dev;
-
 	/* clock tuning is not needed for upto 52MHz */
 	if (ios->clock <= 52000000)
 		return 0;
-- 
2.19.1

