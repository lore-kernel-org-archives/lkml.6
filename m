Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nvhgCIj5GFtaagAAmS7hNA
	; Thu, 07 Jun 2018 09:24:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A0C5D607DC; Thu,  7 Jun 2018 09:24:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1B963605A2;
	Thu,  7 Jun 2018 09:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B963605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFGJWt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:22:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46247 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932856AbeFGJWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:22:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A6AF81A02C5;
        Thu,  7 Jun 2018 11:22:33 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A5711A02E0;
        Thu,  7 Jun 2018 11:22:33 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id A505E40A56;
        Thu,  7 Jun 2018 02:22:32 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w579MJ4j020959;
        Thu, 7 Jun 2018 02:22:30 -0700
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 03/10] dt-binding: ptp_qoriq: add DPAA FMan support
Date: Thu,  7 Jun 2018 17:20:43 +0800
Message-Id: <20180607092050.46128-4-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add bindings description for DPAA
FMan 1588 timer, and also remove its description in
fsl-fman dt-bindings document.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- None.
---
 Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-------------------
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++++++++--
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
index df873d1..74603dd 100644
--- a/Documentation/devicetree/bindings/net/fsl-fman.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fman.txt
@@ -356,30 +356,7 @@ ethernet@e0000 {
 ============================================================================
 FMan IEEE 1588 Node
 
-DESCRIPTION
-
-The FMan interface to support IEEE 1588
-
-
-PROPERTIES
-
-- compatible
-		Usage: required
-		Value type: <stringlist>
-		Definition: A standard property.
-		Must include "fsl,fman-ptp-timer".
-
-- reg
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A standard property.
-
-EXAMPLE
-
-ptp-timer@fe000 {
-	compatible = "fsl,fman-ptp-timer";
-	reg = <0xfe000 0x1000>;
-};
+Refer to Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
 
 =============================================================================
 FMan MDIO Node
diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
index 0f569d8..c5d0e79 100644
--- a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
@@ -2,7 +2,8 @@
 
 General Properties:
 
-  - compatible   Should be "fsl,etsec-ptp"
+  - compatible   Should be "fsl,etsec-ptp" for eTSEC
+                 Should be "fsl,fman-ptp-timer" for DPAA FMan
   - reg          Offset and length of the register set for the device
   - interrupts   There should be at least two interrupts. Some devices
                  have as many as four PTP related interrupts.
@@ -43,14 +44,22 @@ Clock Properties:
   value, which will be directly written in those bits, that is why,
   according to reference manual, the next clock sources can be used:
 
+  For eTSEC,
   <0> - external high precision timer reference clock (TSEC_TMR_CLK
         input is used for this purpose);
   <1> - eTSEC system clock;
   <2> - eTSEC1 transmit clock;
   <3> - RTC clock input.
 
-  When this attribute is not used, eTSEC system clock will serve as
-  IEEE 1588 timer reference clock.
+  For DPAA FMan,
+  <0> - external high precision timer reference clock (TMR_1588_CLK)
+  <1> - MAC system clock (1/2 FMan clock)
+  <2> - reserved
+  <3> - RTC clock oscillator
+
+  When this attribute is not used, the IEEE 1588 timer reference clock
+  will use the eTSEC system clock (for Gianfar) or the MAC system
+  clock (for DPAA).
 
 Example:
 
-- 
1.7.1
