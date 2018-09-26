Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB1BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE820684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ViKZRkDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADE820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIZTWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:22:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55110 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbeIZTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:22:47 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QD9lu6014962;
        Wed, 26 Sep 2018 08:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537967387;
        bh=ZOnPfn3gmnGM8pf25w5xGWX9wLNw0zSaYadOc1AOrAs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ViKZRkDKzOs04XWAlhcW31u7ksx0E5tHbUB9Eq4VmemCKMVJnuvUcqVSMD16qpa68
         x3RmKVkDNQt2GeEbSaLHRkvAB7Mo2Wq4G36m+iDpO9GC+Mz6WH+SH0zBzER6XNQkZu
         j+sKOjuE4jvlYWvjMDJaXGTfZUQCCjK9Em7zPqzs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9lXf021291;
        Wed, 26 Sep 2018 08:09:47 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 08:09:47 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 08:09:47 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9l4J003530;
        Wed, 26 Sep 2018 08:09:47 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.176.238])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8QD9kx11631;
        Wed, 26 Sep 2018 08:09:46 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 2/9] dt-bindings: ti-lmu: Remove LM3697
Date:   Wed, 26 Sep 2018 08:09:14 -0500
Message-ID: <20180926130921.12329-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180926130921.12329-1-dmurphy@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
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
2.19.0

