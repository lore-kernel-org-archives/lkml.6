Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3303221470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3303221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJDTWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:22:41 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43921 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbeJDTWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:22:41 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C94E56687F;
        Thu,  4 Oct 2018 12:29:33 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 01/10] dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
Date:   Thu,  4 Oct 2018 20:28:46 +0800
Message-Id: <20181004122855.22981-2-icenowy@aosc.io>
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2.0 PHY on Allwinner H6 is similar to the ones on the ones on
older SoCs, but with holes in PHY number (USB1 and USB2 are missing, in
which USB1 is a USB3 PHY).

Add binding for the PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v4.

 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 07ca4ec4a745..f2e120af17f0 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -14,13 +14,14 @@ Required properties:
   * allwinner,sun8i-r40-usb-phy
   * allwinner,sun8i-v3s-usb-phy
   * allwinner,sun50i-a64-usb-phy
+  * allwinner,sun50i-h6-usb-phy
 - reg : a list of offset + length pairs
 - reg-names :
   * "phy_ctrl"
-  * "pmu0" for H3, V3s and A64
+  * "pmu0" for H3, V3s, A64 or H6
   * "pmu1"
   * "pmu2" for sun4i, sun6i, sun7i, sun8i-a83t or sun8i-h3
-  * "pmu3" for sun8i-h3
+  * "pmu3" for sun8i-h3 or sun50i-h6
 - #phy-cells : from the generic phy bindings, must be 1
 - clocks : phandle + clock specifier for the phy clocks
 - clock-names :
@@ -29,12 +30,13 @@ Required properties:
   * "usb0_phy", "usb1_phy" for sun8i
   * "usb0_phy", "usb1_phy", "usb2_phy" and "usb2_hsic_12M" for sun8i-a83t
   * "usb0_phy", "usb1_phy", "usb2_phy" and "usb3_phy" for sun8i-h3
+  * "usb0_phy" and "usb3_phy" for sun50i-h6
 - resets : a list of phandle + reset specifier pairs
 - reset-names :
   * "usb0_reset"
   * "usb1_reset"
   * "usb2_reset" for sun4i, sun6i, sun7i, sun8i-a83t or sun8i-h3
-  * "usb3_reset" for sun8i-h3
+  * "usb3_reset" for sun8i-h3 and sun50i-h6
 
 Optional properties:
 - usb0_id_det-gpios : gpio phandle for reading the otg id pin value
-- 
2.18.0

