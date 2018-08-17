Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D558DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FFA21933
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FFA21933
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeHQRmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:42:11 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:28065 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbeHQRmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:42:11 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 17 Aug 2018 23:38:33 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 282447ADDF;
        Fri, 17 Aug 2018 23:38:33 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,251,1531753200"; 
   d="scan'208";a="288345846"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 17 Aug 2018 23:38:29 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Date:   Fri, 17 Aug 2018 15:38:23 +0100
Message-Id: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (r8a774a1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch applies on top of next-20180817

 Documentation/devicetree/bindings/net/can/rcar_can.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 94a7f33..84afc78 100644
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
@@ -16,7 +17,8 @@ Required properties:
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
 	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
 	      compatible device.
-	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
+	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
+	      compatible device.
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
 	      followed by the generic version.
@@ -24,7 +26,9 @@ Required properties:
 - reg: physical base address and size of the R-Car CAN register map.
 - interrupts: interrupt specifier for the sole interrupt.
 - clocks: phandles and clock specifiers for 3 CAN clock inputs.
-- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
+- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk", and
+	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
+	       "can_clk".
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-- 
2.7.4

