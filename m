Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D421900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xBrsmXdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbfBOTRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:17:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35352 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:17:51 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJHjU0096901;
        Fri, 15 Feb 2019 13:17:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258265;
        bh=M/RL3HPRjK7bTA1EG63kiLoM0Bm8VyIGh9e1TXDeIvc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xBrsmXdJpdFn6/wNdxAjGBo7JBgNtnQl4cCSkOmLUjU9bEhCZftjhTALEejwr7oit
         SsXwtQUA43mD4SfFxqI3N/bYFXWxfrzpqJx62UCxm/NbX6AK4XhXcNXg0VQiWlNost
         hb9VY90Ci8Dj5QpR2TsvbbindU0mBytVTDsLXc6g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJHjlA049226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:17:45 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:17:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:17:44 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV0x025256;
        Fri, 15 Feb 2019 13:17:42 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using external dma
Date:   Sat, 16 Feb 2019 00:50:28 +0530
Message-ID: <20190215192033.24203-4-faiz_abbas@ti.com>
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

From: Chunyan Zhang <zhang.chunyan@linaro.org>

sdhci-omap can support both external dma controller via dmaengine
framework as well as ADMA which standard SD host controller
provides.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 72c4dec7e1db..4485dbceb373 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -14,6 +14,11 @@ Required properties:
 		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
 		 "hs200_1_8v",
 - pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
+- dmas:		List of DMA specifiers with the controller specific format as described
+		in the generic DMA client binding. A tx and rx specifier is required.
+- dma-names:	List of DMA request names. These strings correspond 1:1 with the
+		DMA specifiers listed in dmas. The string naming is to be "tx"
+		and "rx" for TX and RX DMA requests, respectively.
 
 Example:
 	mmc1: mmc@4809c000 {
@@ -22,4 +27,6 @@ Example:
 		ti,hwmods = "mmc1";
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		dmas = <&sdma 61 &sdma 62>;
+		dma-names = "tx", "rx";
 	};
-- 
2.19.2

