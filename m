Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC1C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98BF20685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98BF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeKHSxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:53:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeKHSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:53:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA89Igcm121991;
        Thu, 8 Nov 2018 03:18:42 -0600
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA89IgR0120030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 03:18:42 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 03:18:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 03:18:42 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA89Ia9B010737;
        Thu, 8 Nov 2018 03:18:40 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tony Lindgren <tony@atomide.com>
CC:     Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
Date:   Thu, 8 Nov 2018 14:49:29 +0530
Message-ID: <20181108091931.3342-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108091931.3342-1-vigneshr@ti.com>
References: <20181108091931.3342-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoCs have same I2C IP as OMAP SoCs. Add new compatible to
handle AM654 SoCs. While at that reformat the existing compatible list
for older SoCs to list one valid compatible per line.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 7e49839d4124..4b90ba9f31b7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -1,8 +1,12 @@
 I2C for OMAP platforms
 
 Required properties :
-- compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
-  or "ti,omap4-i2c"
+- compatible : Must be
+	"ti,omap2420-i2c" for OMAP2420 SoCs
+	"ti,omap2430-i2c" for OMAP2430 SoCs
+	"ti,omap3-i2c" for OMAP3 SoCs
+	"ti,omap4-i2c" for OMAP4+ SoCs
+	"ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.19.1

