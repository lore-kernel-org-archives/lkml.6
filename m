Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A380C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE162087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE162087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIJPhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:37:02 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:37544 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727674AbeIJPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:37:01 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 10 Sep 2018 19:43:33 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 27CF881552;
        Mon, 10 Sep 2018 19:43:33 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,355,1531753200"; 
   d="scan'208";a="292075066"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii2.idc.renesas.com with ESMTP; 10 Sep 2018 19:43:28 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Date:   Mon, 10 Sep 2018 11:43:14 +0100
Message-Id: <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (r8a774a1) SoC specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
v1->v2:
* dropped "renesas,rzg-gen2-can" and fixed "clocks" property description
  as per Geert's comments.

This patch applies on top of next-20180910.

 Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 94a7f33..f3b160c 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
 Required properties:
 - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
 	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
+	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
 	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
 	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
@@ -16,15 +17,21 @@ Required properties:
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
 	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
 	      compatible device.
-	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
+	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
+	      compatible device.
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
 	      followed by the generic version.
 
 - reg: physical base address and size of the R-Car CAN register map.
 - interrupts: interrupt specifier for the sole interrupt.
-- clocks: phandles and clock specifiers for 3 CAN clock inputs.
-- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
+- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
+	  devices.
+	  phandles and clock specifiers for 3 CAN clock inputs for every other
+	  SoC.
+- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
+	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
+	       "can_clk".
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
@@ -41,8 +48,9 @@ using the below properties:
 Optional properties:
 - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
 			    <0x0> (default) : Peripheral clock (clkp1)
-			    <0x1> : Peripheral clock (clkp2)
-			    <0x3> : Externally input clock
+			    <0x1> : Peripheral clock (clkp2) (not supported by
+				    RZ/G2 devices)
+			    <0x3> : External input clock
 
 Example
 -------
-- 
2.7.4

