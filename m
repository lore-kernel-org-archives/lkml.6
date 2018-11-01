Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7DEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1155320664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="j/fpPcuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1155320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeKAJMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:12:42 -0400
Received: from onstation.org ([52.200.56.107]:44726 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbeKAJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:12:40 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E60BCB08;
        Thu,  1 Nov 2018 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541031130;
        bh=SNQg8lSVkSCyyyeJf7CLWF0oAF1ltzx0/skv5/3GDV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/fpPcuQcA7BIfPlttXKJLnhc1CktLNhhvbpEFCFOXnyt5g7nfMitcnXaF58+YQ/s
         TXfAf6+15GPX+N1jm/OYqATjVbyapPYVDv1KO7s+T48ouqCvtwSn7ySrJBCMaQekbS
         BDsFZXzNmNIvAKoRgHrtyBKrQqrZACFgol8QeW8M=
From:   Brian Masney <masneyb@onstation.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: [PATCH v2 1/7] dt-bindings: power: supply: bq24190_charger: add bq24192 and usb-otg-vbus
Date:   Wed, 31 Oct 2018 20:11:43 -0400
Message-Id: <20181101001149.13453-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ti,bq24192 variant and a child node for the
usb-otg-vbus regulator.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../devicetree/bindings/power/supply/bq24190.txt         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
index 9e517d307070..c8ac028bd3c7 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
@@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
 Required properties:
 - compatible: contains one of the following:
     * "ti,bq24190"
+    * "ti,bq24192"
     * "ti,bq24192i"
 - reg: integer, I2C address of the charger.
 - interrupts[-extended]: configuration for charger INT pin.
@@ -19,6 +20,12 @@ Optional properties:
 - ti,system-minimum-microvolt: when power is connected and the battery is below
   minimum system voltage, the system will be regulated above this setting.
 
+child nodes:
+- usb-otg-vbus:
+  Usage: optional
+  Description: Regulator that is used to control the VBUS voltage direction for
+               either USB host mode or for charging on the OTG port.
+
 Notes:
 - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
   charge current on USB SDP ports, among other features). To simulate this on
@@ -39,6 +46,8 @@ Example:
 		interrupts-extended = <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
 		monitored-battery = <&bat>;
 		ti,system-minimum-microvolt = <3200000>;
+
+		usb_otg_vbus: usb-otg-vbus { };
 	};
 
 	&twl_gpio {
-- 
2.17.2

