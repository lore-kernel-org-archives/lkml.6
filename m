Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rYc9wdIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E78120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLKOUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:20:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40766 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLKOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:20:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBEKCnU052491;
        Tue, 11 Dec 2018 08:20:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544538012;
        bh=EGQM6vROt1iVuTmaTLPm6r2zqgzSBhLJY1SfV+6d64A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rYc9wdIgRKBGA1FPmbYpa2uoE/foph/cyW/3SGakFpSkCJMGqDrVUevyoSk5npBei
         nWu+alDFnwgWcnLEoL5tEVNgrRmDzM1CJcFjsKRIyjpxQzi+wvq3ebVgFB1rJYVihJ
         YeMEzGXwuPzXP3+FPakE/e1cVtAsTaut2H/aNZp4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBEKCe4059327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 08:20:12 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 08:20:11 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 08:20:11 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBEK6ee024675;
        Tue, 11 Dec 2018 08:20:09 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <kishon@ti.com>, <faiz_abbas@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: sdhci-omap: Add note for cpu_thermal
Date:   Tue, 11 Dec 2018 19:52:52 +0530
Message-ID: <20181211142253.23747-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211142253.23747-1-faiz_abbas@ti.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver fetches a thermal zone using the string "cpu_thermal" for
tuning operation. Add a note for the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 393848c2138e..72c4dec7e1db 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -2,6 +2,8 @@
 
 Refer to mmc.txt for standard MMC bindings.
 
+For UHS devices which require tuning, the device tree should have a "cpu_thermal" node which maps to the appropriate thermal zone. This is used to get the temperature of the zone during tuning.
+
 Required properties:
 - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
 	      Should be "ti,k2g-sdhci" for K2G
-- 
2.19.2

