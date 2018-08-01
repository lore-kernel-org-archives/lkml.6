Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B52C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D32220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D32220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbeHAMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:35:08 -0400
Received: from nbd.name ([46.4.11.11]:55692 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388688AbeHAMfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:35:07 -0400
From:   John Crispin <john@phrozen.org>
To:     Alban Bedel <albeu@free.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        John Crispin <john@phrozen.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH V2 1/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
Date:   Wed,  1 Aug 2018 12:49:39 +0200
Message-Id: <20180801104941.29432-2-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801104941.29432-1-john@phrozen.org>
References: <20180801104941.29432-1-john@phrozen.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for the HS/SS USB PHY found
inside Qualcomm Dakota SoCs.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: John Crispin <john@phrozen.org>
---
 .../bindings/phy/phy-qcom-ipq4019-usb.txt           | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt b/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
new file mode 100644
index 000000000000..320a596c45b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
@@ -0,0 +1,21 @@
+Qualcom Dakota HS/SS USB PHY
+
+Required properties:
+ - compatible: "qcom,ipq4019-usb-ss-phy",
+	       "qcom,ipq4019-usb-hs-phy"
+ - reg: offset and length of the registers
+ - #phy-cells: should be 0
+ - resets: the reset controllers as listed below
+ - reset-names: the names of the reset controllers
+	"por" - the POR reset line for SS and HS phys
+	"srif" - the SRIF reset line for HS phys
+Example:
+
+usb-phy@a8000 {
+	compatible = "qcom,ipq4019-usb-hs-phy";
+	phy-cells = <0>;
+	reg = <0xa8000 0x40>;
+	resets = <&gcc USB2_HSPHY_POR_ARES>,
+		 <&gcc USB2_HSPHY_S_ARES>;
+	reset-names = "por", "srif";
+};
-- 
2.11.0

