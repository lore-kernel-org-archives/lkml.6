Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C52C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03B3206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PvNL1qYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03B3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeIKWIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:08:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55090 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeIKWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:08:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BH8ZTx036279;
        Tue, 11 Sep 2018 12:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536685715;
        bh=LaNQc/q74k3JA1jOfJT1L2GMMeUxhD/RUqBb3LqEECg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PvNL1qYP/d+8pRtX9OCEOQFnSsPF1S++6f+Kp3YRAPc9Y4/iSWRx+3cQpTbUmXIg3
         EwtbG08bx03/XCZqTMDk2/7/+ilce1TbfqmKB6G0WYMYiH+lAf5GUSevevTkvczZhC
         OrIHjOhKrRcfsy9O3pNBQmmBeUGx1WHW1U1bFHJs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8ZUn017560;
        Tue, 11 Sep 2018 12:08:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:08:35 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:08:34 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8Y8T019380;
        Tue, 11 Sep 2018 12:08:34 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.156.248])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8BH8Yx21189;
        Tue, 11 Sep 2018 12:08:34 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date:   Tue, 11 Sep 2018 12:08:20 -0500
Message-ID: <20180911170825.17789-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for the LM3697 LED device
from the ti-lmu.  The LM3697 will be supported
via a stand alone LED driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - New change for the series based on the comments in https://lore.kernel.org/patchwork/patch/982550/

 .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index c885cf89b8ce..920f910be4e9 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
   LM3632       Backlight and regulator
   LM3633       Backlight, LED and fault monitor
   LM3695       Backlight
-  LM3697       Backlight and fault monitor
 
 Required properties:
   - compatible: Should be one of:
@@ -18,11 +17,10 @@ Required properties:
                 "ti,lm3632"
                 "ti,lm3633"
                 "ti,lm3695"
-                "ti,lm3697"
   - reg: I2C slave address.
          0x11 for LM3632
          0x29 for LM3631
-         0x36 for LM3633, LM3697
+         0x36 for LM3633
          0x38 for LM3532
          0x63 for LM3695
 
@@ -38,7 +36,6 @@ Optional nodes:
     Required properties:
       - compatible: Should be one of:
                     "ti,lm3633-fault-monitor"
-                    "ti,lm3697-fault-monitor"
   - leds: LED properties for LM3633. Please refer to [2].
   - regulators: Regulator properties for LM3631 and LM3632.
                 Please refer to [3].
@@ -220,24 +217,3 @@ lm3695@63 {
 		};
 	};
 };
-
-lm3697@36 {
-	compatible = "ti,lm3697";
-	reg = <0x36>;
-
-	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
-
-	backlight {
-		compatible = "ti,lm3697-backlight";
-
-		lcd {
-			led-sources = <0 1 2>;
-			ramp-up-msec = <200>;
-			ramp-down-msec = <200>;
-		};
-	};
-
-	fault-monitor {
-		compatible = "ti,lm3697-fault-monitor";
-	};
-};
-- 
2.17.0.1855.g63749b2dea

