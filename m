Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC60EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795CE20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795CE20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeKSUHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:07:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeKSUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:07:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJ9iGsV039027;
        Mon, 19 Nov 2018 03:44:16 -0600
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJ9iGVm056111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 03:44:16 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 03:44:15 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 03:44:15 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJ9iCCY015974;
        Mon, 19 Nov 2018 03:44:13 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654 SoCs
Date:   Mon, 19 Nov 2018 15:15:09 +0530
Message-ID: <20181119094509.22542-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
handle AM654 SoCs. Also, it seems that existing compatible strings used
in the kernel DTs were never documented. So, document them now.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index b1163bf97146..aad5e34965eb 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -2,7 +2,12 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Required properties:
+- mfd
+	compatible: Should be
+		"ti,am3359-tscadc" for AM335x/AM437x SoCs
+		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
 - child "tsc"
+	compatible: Should be "ti,am3359-tsc".
 	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
 		  support on the platform.
 	ti,x-plate-resistance: X plate resistance
@@ -25,6 +30,9 @@ Required properties:
 			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 			XP  = 0, XN = 1, YP = 2, YN = 3.
 - child "adc"
+	compatible: Should be
+		    "ti,am3359-adc" for AM335x/AM437x SoCs
+		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
 	ti,adc-channels: List of analog inputs available for ADC.
 			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 
-- 
2.19.1

