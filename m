Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF231ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="etwQ75iV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DYtDboGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7700920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbeGTOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:21:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeGTOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:21:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1111F60B83; Fri, 20 Jul 2018 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532093585;
        bh=jAqF8d4rjaiF6z0DN+u9CJj2J2qIWADKazmInGPbLvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etwQ75iVHsiSH9gEcjB61eWnYg794eGsI0IicwK8zDr51bMST4XMP/sA2UL4AmqbZ
         8AGu9dSrvacsOv375zrQz3eBsdvtf8ejohTB+YdNp3VWlWSTBv7R052Kift7JDSqq5
         Lf5zyDZ+LC5oHM6eNXGaDWhPNRCb1MmI8fJIlDzo=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1401060B22;
        Fri, 20 Jul 2018 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532093584;
        bh=jAqF8d4rjaiF6z0DN+u9CJj2J2qIWADKazmInGPbLvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYtDboGZ/IpBYhGo6AxuY14g0mZwQvZgyNUCidrIQr8P08KaC69/GO+dJ+SbPxpV6
         Cd7r0WGxOzpoKN4bAj8yTPhsPQaTI0RJ40X5/YSpdzq6l03KkFJ4MSerjE3zVGOhhc
         d5wLAw8UIbt+0DI4PEH3iC6kFSiP5gid/32ohceY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1401060B22
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v10 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date:   Fri, 20 Jul 2018 19:02:37 +0530
Message-Id: <20180720133243.6851-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720133243.6851-1-bgodavar@codeaurora.org>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v10:
    * added entry for regulator currents

Changes in v9:
    * updated with latest reg handle and names.
    * updated max-speed definition. 

Changes in v8:
    * Separated the optional entries between two chips

Changes in v7:
    * no change.

Changes in v6:

    * Changed the oper-speed to max-speed.

Changes in v5:

    * Added entry for oper-speed and init-speed.

---
 .../bindings/net/qualcomm-bluetooth.txt       | 42 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..ca04c4981048 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,34 @@ device the slave device is attached to.
 Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
+   * "qcom,wcn3990-bt"
+
+Optional properties for compatible string qcom,qca6174-bt:
 
-Optional properties:
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
 
-Example:
+Optional properties for compatible string qcom,wcn3990-bt:
+
+ - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
+ - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
+ - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
+ - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
+
+ - If WCN3990 is connected to platform where RPMH PMIC processor is used
+   then the load values will be 1uA. if it is connected to platform where RPM
+   PMIC processor is used then load value will be 10000 uA.
+   if it is connected to different platform, where current values are fixed
+   as in data sheet then below property are not required.
+
+   - vddio-current: Bluetooth wcn3990 VDD_IO current level in uA.
+   - vddxo-current: Bluetooth wcn3990 VDD_XO current level in uA.
+   - vddrf-current: Bluetooth wcn3990 VDD_RF current level in uA.
+   - vddch0-current: Bluetooth wcn3990 VDD_CH0 current level in uA.
+
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +50,19 @@ serial@7570000 {
 		clocks = <&divclk4>;
 	};
 };
+
+serial@898000 {
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		vddio-current = <1>;
+		vddxo-current = <1>;
+		vddrf-current = <1>;
+		vddch0-current = <1>;
+		max-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

