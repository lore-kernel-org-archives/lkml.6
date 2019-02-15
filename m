Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0CB21900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ADlX0hj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbfBOTSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:18:10 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50284 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390823AbfBOTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:18:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJI3hW129343;
        Fri, 15 Feb 2019 13:18:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258283;
        bh=+KL0hmLdCKwW0HWMNPFWk72+310wSJ4NbSZpWmrq/I0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ADlX0hj7oBLGEo2Kx5+lEP1YJnRNE410E4pVgH26iMqTDRRgE2vEqWwuVZjxJHj/i
         btElvsZK+kYY40A3bzarXyi/Gf6i1q7+tO6QqnMJfRebXW15rZKP3avhpIAaUoo1X5
         1HJV0TlH4wr10HsqVXGIW4uyFUBAbR2yAHZYzuZw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJI2gv015913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:18:02 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:18:01 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:18:01 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV14025256;
        Fri, 15 Feb 2019 13:17:58 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 8/8] mmc: sdhci-omap: Add am335x and am437x specific compatibles
Date:   Sat, 16 Feb 2019 00:50:33 +0530
Message-ID: <20190215192033.24203-9-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new compatible for TI's am335x and am437x devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index ae9701d198d5..2e246b5b744c 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -861,6 +861,14 @@ static const struct sdhci_omap_data k2g_data = {
 	.offset = 0x200,
 };
 
+static const struct sdhci_omap_data am335_data = {
+	.offset = 0x200,
+};
+
+static const struct sdhci_omap_data am437_data = {
+	.offset = 0x200,
+};
+
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
 	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
@@ -869,6 +877,8 @@ static const struct sdhci_omap_data dra7_data = {
 static const struct of_device_id omap_sdhci_match[] = {
 	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
 	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
+	{ .compatible = "ti,am335-sdhci", .data = &am335_data },
+	{ .compatible = "ti,am437-sdhci", .data = &am437_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
-- 
2.19.2

