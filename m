Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AFB204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AFB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeJSCR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:17:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54051 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbeJSCRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:17:25 -0400
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="19728512"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 18 Oct 2018 11:15:16 -0700
Received: from validation1-HP-EliteBook-8540p.mchp-main.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 18 Oct 2018 11:15:14 -0700
From:   Yuiko Oshino <yuiko.oshino@microchip.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <f.fainelli@gmail.com>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <m.felsch@pengutronix.de>, <Markus.Niebel@tqs.de>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v3 net-next 2/2] dt-bindings: net: add support for Microchip KSZ9131
Date:   Thu, 18 Oct 2018 15:06:02 -0400
Message-ID: <1539889562-21458-3-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
References: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet PHY

Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
---
 .../devicetree/bindings/net/micrel-ksz90x1.txt     | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
index e22d8cf..5100358 100644
--- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
+++ b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
@@ -1,4 +1,4 @@
-Micrel KSZ9021/KSZ9031 Gigabit Ethernet PHY
+Micrel KSZ9021/KSZ9031/KSZ9131 Gigabit Ethernet PHY
 
 Some boards require special tuning values, particularly when it comes
 to clock delays. You can specify clock delay values in the PHY OF
@@ -64,6 +64,32 @@ KSZ9031:
         Attention: The link partner must be configurable as slave otherwise
         no link will be established.
 
+KSZ9131:
+
+  All skew control options are specified in picoseconds. The increment
+  step is 100ps. Unlike KSZ9031, the values represent picoseccond delays.
+  A negative value can be assigned as rxc-skew-psec = <(-100)>;.
+
+  Optional properties:
+
+    Range of the value -700 to 2400, default value 0:
+
+      - rxc-skew-psec : Skew control of RX clock pad
+      - txc-skew-psec : Skew control of TX clock pad
+
+    Range of the value -700 to 800, default value 0:
+
+      - rxdv-skew-psec : Skew control of RX CTL pad
+      - txen-skew-psec : Skew control of TX CTL pad
+      - rxd0-skew-psec : Skew control of RX data 0 pad
+      - rxd1-skew-psec : Skew control of RX data 1 pad
+      - rxd2-skew-psec : Skew control of RX data 2 pad
+      - rxd3-skew-psec : Skew control of RX data 3 pad
+      - txd0-skew-psec : Skew control of TX data 0 pad
+      - txd1-skew-psec : Skew control of TX data 1 pad
+      - txd2-skew-psec : Skew control of TX data 2 pad
+      - txd3-skew-psec : Skew control of TX data 3 pad
+
 Examples:
 
 	mdio {
-- 
2.7.4

