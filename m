Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7924020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7924020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeGYGvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:51:24 -0400
Received: from nbd.name ([46.4.11.11]:49884 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbeGYGvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:51:13 -0400
From:   John Crispin <john@phrozen.org>
To:     Alban Bedel <albeu@free.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        John Crispin <john@phrozen.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
Date:   Wed, 25 Jul 2018 07:40:57 +0200
Message-Id: <20180725054059.19506-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for the HS/SS USB PHY found
inside Qualcom Dakota SoCs.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: John Crispin <john@phrozen.org>
---
 .../bindings/phy/phy-qcom-ipq4019-usb.txt           | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt b/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
new file mode 100644
index 000000000000..362877fcafed
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
@@ -0,0 +1,21 @@
+Qualcom Dakota HS/SS USB PHY
+
+Required properties:
+ - compatible: "qcom,usb-ss-ipq4019-phy",
+	       "qcom,usb-hs-ipq4019-phy"
+ - reg: offset and length of the registers
+ - #phy-cells: should be 0
+ - resets: the reset controllers as listed below
+ - reset-names: the names of the reset controllers
+	"por_rst" - the POR reset line for SS and HS phys
+	"srif_rst" - the SRIF reset line for HS phys
+Example:
+
+hsphy@a8000 {
+	compatible = "qcom,usb-hs-ipq4019-phy";
+	phy-cells = <0>;
+	reg = <0xa8000 0x40>;
+	resets = <&gcc USB2_HSPHY_POR_ARES>,
+		 <&gcc USB2_HSPHY_S_ARES>;
+	reset-names = "por_rst", "srif_rst";
+};
-- 
2.11.0

