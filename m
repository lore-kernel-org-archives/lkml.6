Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA5C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16AF20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FP0afIbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16AF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeKIUxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:53:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54184 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeKIUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:53:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9BDdPX108289;
        Fri, 9 Nov 2018 05:13:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541762019;
        bh=bTpoRF2GrK6lEDHysMZ5kXK85MxQmmDCI++q9FDvIAs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FP0afIblTv4cDpX3JerHT0eyYmnKe/A9tSyW7gI5seLRXWTlHeUus+bdlrAvNi+TP
         mubKsjcy71GqR3Y/dslq//oCUBQl686AWZIM0bhkdn6dccRm2gHXQNqhKIlbwSn6kG
         iY6k8DLEpPAmxZUw5NO5FsWm4TgnAbupCHospI/g=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9BDdP5124357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 05:13:39 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 05:13:39 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 05:13:39 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9BDYs9028715;
        Fri, 9 Nov 2018 05:13:37 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 1/3] dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
Date:   Fri, 9 Nov 2018 16:44:10 +0530
Message-ID: <20181109111412.24777-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109111412.24777-1-vigneshr@ti.com>
References: <20181109111412.24777-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

