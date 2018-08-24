Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61148C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254BE2156F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254BE2156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHXHCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:02:42 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:42344 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeHXHCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:02:40 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.229])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4A5B430E;
        Fri, 24 Aug 2018 11:29:56 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 77BFD3B5;
        Fri, 24 Aug 2018 11:29:41 +0800 (CST)
X-RL-SENDER: tony.xie@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: tony.xie@rock-chips.com
X-UNIQUE-TAG: <e8331f9742410e8543d774b2391e18eb>
X-ATTACHMENT-NUM: 0
X-SENDER: xxx@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 17714YMXW02;
        Fri, 24 Aug 2018 11:29:53 +0800 (CST)
From:   Tony Xie <tony.xie@rock-chips.com>
To:     heiko@sntech.de
Cc:     broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: [PATCH v3 3/5] dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
Date:   Fri, 24 Aug 2018 11:30:39 +0800
Message-Id: <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 91b6522..c025a99 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
 The rk8xx family current members:
 rk805
 rk808
+rk809
+rk817
 rk818
 
 Required properties:
 - compatible: "rockchip,rk805"
 - compatible: "rockchip,rk808"
+- compatible: "rockchip,rk809"
+- compatible: "rockchip,rk817"
 - compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
@@ -46,6 +50,28 @@ Optional RK808 properties:
   the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
   very quickly with no slow ramp time.
 
+Optional RK809 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
+- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
+- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
+- vcc8-supply:  The input supply for SWITCH_REG1
+- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
+
+Optional RK817 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
+- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
+- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
+- vcc8-supply:  The input supply for BOOST
+- vcc9-supply:  The input supply for OTG_SWITCH
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -87,6 +113,28 @@ number as described in RK808 datasheet.
 	- SWITCH_REGn
 		- valid values for n are 1 to 2
 
+Following regulators of the RK809 PMIC block are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK808 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 5.
+	- LDO_REGn
+		- valid values for n are 1 to 9.
+	- SWITCH_REGn
+		- valid values for n are 1 to 2.
+
+Following regulators of the RK817 PMIC block are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK818 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 9.
+	- BOOST
+	- OTG_SWITCH
+
 Following regulators of the RK818 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK818 datasheet.
@@ -99,6 +147,14 @@ number as described in RK818 datasheet.
 	- HDMI_SWITCH
 	- OTG_SWITCH
 
+There are three pins needed to config for each of RK809 and RK817,
+named "gpio_ts" "gpio_gt" "gpio_slp".
+	The gpio_gt and gpio_ts pins support the gpio function.
+	The gpio_slp pin is for controlling the pmic states, as below:
+		- reset
+		- power down
+		- sleep
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details
-- 
1.9.1


