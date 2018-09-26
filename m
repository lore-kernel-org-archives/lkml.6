Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424802152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424802152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeIZXis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:38:48 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15763 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeIZXis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:38:48 -0400
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="20233588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 10:24:47 -0700
Received: from validation1-HP-EliteBook-8540p.mchp-main.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Wed, 26 Sep 2018 10:24:46 -0700
From:   Yuiko Oshino <yuiko.oshino@microchip.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <m.felsch@pengutronix.de>, <Markus.Niebel@tqs.de>,
        <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net] dt-bindings: net: add support for Microchip KSZ9131 Ethernet PHY
Date:   Wed, 26 Sep 2018 14:16:23 -0400
Message-ID: <1537985783-22724-1-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet phy

Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
---
 .../devicetree/bindings/net/micrel-ksz90x1.txt     | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
index e22d8cf..d23d14a 100644
--- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
+++ b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
@@ -1,4 +1,4 @@
-Micrel KSZ9021/KSZ9031 Gigabit Ethernet PHY
+Micrel/Microchip KSZ9021/KSZ9031/KSZ9131 Gigabit Ethernet PHY
 
 Some boards require special tuning values, particularly when it comes
 to clock delays. You can specify clock delay values in the PHY OF
@@ -64,6 +64,33 @@ KSZ9031:
         Attention: The link partner must be configurable as slave otherwise
         no link will be established.
 
+KSZ9131:
+
+  All skew control options are specified in picoseconds. The minimum
+  value is 0, and the maximum is property-dependent. The increment
+  step is 100ps. The default value is the neutral setting, so setting
+  rxc-skew-ps=<0> actually results in -700 picoseconds adjustment.
+
+  Optional properties:
+
+    Maximum value of 2400, default value 700:
+
+      - rxc-skew-ps : Skew control of RX clock pad
+      - txc-skew-ps : Skew control of TX clock pad
+
+    Maximum value of 1500, default value 700:
+
+      - rxdv-skew-ps : Skew control of RX CTL pad
+      - txen-skew-ps : Skew control of TX CTL pad
+      - rxd0-skew-ps : Skew control of RX data 0 pad
+      - rxd1-skew-ps : Skew control of RX data 1 pad
+      - rxd2-skew-ps : Skew control of RX data 2 pad
+      - rxd3-skew-ps : Skew control of RX data 3 pad
+      - txd0-skew-ps : Skew control of TX data 0 pad
+      - txd1-skew-ps : Skew control of TX data 1 pad
+      - txd2-skew-ps : Skew control of TX data 2 pad
+      - txd3-skew-ps : Skew control of TX data 3 pad
+
 Examples:
 
 	mdio {
-- 
2.7.4

