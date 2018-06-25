Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3129E25961
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3129E25961
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeFYMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:41:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42080 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbeFYMjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:39:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 582B12000C4;
        Mon, 25 Jun 2018 14:39:18 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ECB98200078;
        Mon, 25 Jun 2018 14:39:17 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 6436340A70;
        Mon, 25 Jun 2018 05:39:17 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w5PCd34O025070;
        Mon, 25 Jun 2018 05:39:14 -0700
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 03/10] dt-binding: ptp_qoriq: add DPAA FMan support
Date:   Mon, 25 Jun 2018 20:37:09 +0800
Message-Id: <20180625123716.28993-4-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180625123716.28993-1-yangbo.lu@nxp.com>
References: <20180625123716.28993-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add bindings description for DPAA
FMan 1588 timer, and also remove its description in
fsl-fman dt-bindings document.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- None.
Changes for v4:
	- Added ACKs and review.
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

