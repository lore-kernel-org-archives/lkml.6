Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A8AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD482157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD482157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeHXLaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:30:02 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:56162 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbeHXLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:30:01 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 24 Aug 2018 16:56:32 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 2800674FB4;
        Fri, 24 Aug 2018 16:56:32 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,281,1531753200"; 
   d="scan'208";a="288949476"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 24 Aug 2018 16:56:28 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support
Date:   Fri, 24 Aug 2018 08:56:11 +0100
Message-Id: <1535097375-5561-3-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
index 47dd296..9d98266 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
@@ -1,20 +1,22 @@
 * Renesas R-Car generation 3 USB 3.0 PHY
 
 This file provides information on what the device node for the R-Car generation
-3 USB 3.0 PHY contains.
+3 and RZ/G2 USB 3.0 PHY contain.
 If you want to enable spread spectrum clock (ssc), you should use USB_EXTAL
 instead of USB3_CLK. However, if you don't want to these features, you don't
 need this driver.
 
 Required properties:
-- compatible: "renesas,r8a7795-usb3-phy" if the device is a part of an R8A7795
+- compatible: "renesas,r8a774a1-usb3-phy" if the device is a part of an R8A774A1
+	      SoC.
+	      "renesas,r8a7795-usb3-phy" if the device is a part of an R8A7795
 	      SoC.
 	      "renesas,r8a7796-usb3-phy" if the device is a part of an R8A7796
 	      SoC.
 	      "renesas,r8a77965-usb3-phy" if the device is a part of an
 	      R8A77965 SoC.
-	      "renesas,rcar-gen3-usb3-phy" for a generic R-Car Gen3 compatible
-	      device.
+	      "renesas,rcar-gen3-usb3-phy" for a generic R-Car Gen3 or RZ/G2
+	      compatible device.
 
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
-- 
2.7.4

