Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EFEC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBDC2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DTaqCfhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBDC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbeJLAUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:20:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49794 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbeJLATi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:19:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BGpUV2076269;
        Thu, 11 Oct 2018 11:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539276690;
        bh=uD8MpIhrDu4ov4RrqAi+Rgt0Wx3BG3QN/xvG6j4SP7o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DTaqCfhk+/7JZclvWk1dtayP0XTVK0XAoSWY8e0xSFIGJ2o1qIEbCOcVdz9I8damI
         XDGkUiOSbaXeyEePzxfTTCLVsXIBS4dJnZBMA+otYyigpUA21t9ih4nLRe/Mr5Np9W
         sgl1APrVIJPliyd/Ie89NuZ7uXYsfKmpZD5KhLlg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpUrk026836;
        Thu, 11 Oct 2018 11:51:30 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 11:51:30 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 11:51:29 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpTT4032594;
        Thu, 11 Oct 2018 11:51:29 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.172.124])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9BGpTx20815;
        Thu, 11 Oct 2018 11:51:29 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <lee.jones@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 6/9] dt-bindings: ti-lmu: Remove LM3633
Date:   Thu, 11 Oct 2018 11:51:20 -0500
Message-ID: <20181011165123.32198-7-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181011165123.32198-1-dmurphy@ti.com>
References: <20181011165123.32198-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for the LM3633 LED device
from the ti-lmu.  The LM3633 will be supported
via a stand alone LED driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/mfd/ti-lmu.txt        | 48 -------------------
 1 file changed, 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index 920f910be4e9..573e88578d3d 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -7,7 +7,6 @@ TI LMU driver supports lighting devices below.
   LM3532       Backlight
   LM3631       Backlight and regulator
   LM3632       Backlight and regulator
-  LM3633       Backlight, LED and fault monitor
   LM3695       Backlight
 
 Required properties:
@@ -15,12 +14,10 @@ Required properties:
                 "ti,lm3532"
                 "ti,lm3631"
                 "ti,lm3632"
-                "ti,lm3633"
                 "ti,lm3695"
   - reg: I2C slave address.
          0x11 for LM3632
          0x29 for LM3631
-         0x36 for LM3633
          0x38 for LM3532
          0x63 for LM3695
 
@@ -157,51 +154,6 @@ lm3632@11 {
 	};
 };
 
-lm3633@36 {
-	compatible = "ti,lm3633";
-	reg = <0x36>;
-
-	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
-
-	backlight {
-		compatible = "ti,lm3633-backlight";
-
-		main {
-			label = "main_lcd";
-			led-sources = <1 2>;
-			ramp-up-msec = <500>;
-			ramp-down-msec = <500>;
-		};
-
-		front {
-			label = "front_lcd";
-			led-sources = <0>;
-			ramp-up-msec = <1000>;
-			ramp-down-msec = <0>;
-		};
-	};
-
-	leds {
-		compatible = "ti,lm3633-leds";
-
-		chan1 {
-			label = "status";
-			led-sources = <1>;
-			led-max-microamp = <6000>;
-		};
-
-		chan345 {
-			label = "rgb";
-			led-sources = <3 4 5>;
-			led-max-microamp = <10000>;
-		};
-	};
-
-	fault-monitor {
-		compatible = "ti,lm3633-fault-monitor";
-	};
-};
-
 lm3695@63 {
 	compatible = "ti,lm3695";
 	reg = <0x63>;
-- 
2.19.0

