Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E094C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9D21AA7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WFqABFaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9D21AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbeHIBvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:51:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40990 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIBvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:51:44 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 188BDCD;
        Thu,  9 Aug 2018 01:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533770986;
        bh=c2EW/89rho0++mL4tGoQAnB1i5UieIRhbdlQr+XrCuI=;
        h=From:To:Cc:Subject:Date:From;
        b=WFqABFaU5uG99mzBITMdtkkJRWu98/de/OSTJyjsZjSUbBezrs9E0lS8D1PiGrjei
         QtUr2vyQPZlmUDOcg2jG5c0Cwc46FQ2jaW7s0oXcLyNOqRgYzr7+ifxh4W5GsXAvGO
         TCiRySNkDMtzvLua4iGvZJrwTSAr8Pnm97GIvV/s=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v2] dt-bindings: media: adv748x: Document re-mappable addresses
Date:   Thu,  9 Aug 2018 00:29:41 +0100
Message-Id: <20180808232941.10582-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADV748x supports configurable slave addresses for its I2C pages.
Document the page names, and provide an example for setting each of the
pages explicitly.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
v2:
 - Fix commit message
 - Extend documentation for the "required property" reg:


 .../devicetree/bindings/media/i2c/adv748x.txt    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
index 21ffb5ed8183..f7fbe221c15e 100644
--- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
+++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
@@ -10,7 +10,11 @@ Required Properties:
     - "adi,adv7481" for the ADV7481
     - "adi,adv7482" for the ADV7482
 
-  - reg: I2C slave address
+  - reg: I2C slave addresses
+    The ADV748x has up to twelve 256-byte maps that can be accessed via the
+    main I2C ports. Each map has it own I2C address and acts as a standard
+    slave device on the I2C bus. The main address is mandatory, others are
+    optional and revert to defaults if not specified.
 
 Optional Properties:
 
@@ -18,6 +22,11 @@ Optional Properties:
 		     "intrq3". All interrupts are optional. The "intrq3" interrupt
 		     is only available on the adv7481
   - interrupts: Specify the interrupt lines for the ADV748x
+  - reg-names : Names of maps with programmable addresses.
+		It can contain any map needed a non-default address.
+		Possible map names are:
+		  "main", "dpll", "cp", "hdmi", "edid", "repeater",
+		  "infoframe", "cbus", "cec", "sdp", "txa", "txb"
 
 The device node must contain one 'port' child node per device input and output
 port, in accordance with the video interface bindings defined in
@@ -47,7 +56,10 @@ Example:
 
 	video-receiver@70 {
 		compatible = "adi,adv7482";
-		reg = <0x70>;
+		reg = <0x70 0x71 0x72 0x73 0x74 0x75
+		       0x60 0x61 0x62 0x63 0x64 0x65>;
+		reg-names = "main", "dpll", "cp", "hdmi", "edid", "repeater",
+			    "infoframe", "cbus", "cec", "sdp", "txa", "txb";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

