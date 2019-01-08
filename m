Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8565C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734B22087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WL94UFhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfAHFZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:25:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55750 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfAHFZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:25:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x085Ph46097497;
        Mon, 7 Jan 2019 23:25:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546925143;
        bh=heRgF3mrtp5ZQ2beqmQqhCjY1VBDmMHelHtTiXRr5xg=;
        h=From:To:CC:Subject:Date;
        b=WL94UFhPK4EYFeeaqGxZ/xzZn+W5ed1v8fbKySgs9qZcIOlgIeTez9tBLrc1CBQjq
         ExgIysaTph7OC3lAcpmqSc5jqNGs8hpwtB9ELrjv+V9ds+ZFuGKwQiJZMmT1pB/8Ez
         zPC7dTIfdbk6QTbzgq/eu37KM48tTLgsTANkVLh8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x085PhAi023672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 23:25:43 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 23:25:43 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 23:25:43 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x085Pecx011763;
        Mon, 7 Jan 2019 23:25:40 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2] dt-bindings: input: ti-tsc-adc: Add new compatible for AM654 SoCs
Date:   Tue, 8 Jan 2019 10:56:31 +0530
Message-ID: <20190108052631.4169-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoCs has ADC IP which is similar to AM335x, but without the
touchscreen part. Add new compatible to handle AM654 SoCs. Also, it
seems that existing compatible strings used in the kernel DTs were never
documented. So, document them now.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2:
Fix subject line to include subsystem name
Rebase onto v5.0-rc1
v1: https://lkml.org/lkml/2018/11/19/313

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
2.20.1

