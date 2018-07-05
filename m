Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EBC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E34424053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="da37HMV3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QnUYTA6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34424053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeGEQzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:55:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754215AbeGEQzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:55:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0588C60B3B; Thu,  5 Jul 2018 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530809733;
        bh=40jr4fzMmtsy5y0KdgFZz3zrxUDLVqi1HVo7R9G662k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=da37HMV3ibsx2fxWmNnVVs8z+Y+aUBFOXKA1EqHYuarO+Y91HpQxvMoIqQDh5n/96
         nTVBp4y41ABdHpBkC87RYqWWpUgLyuNsmY3BrNM52n/8KDZR7SyuVZA17QAMAhrnqL
         kGrRO7ZQJTa+Co08ieYMVR2n6TssGJuHugHmWGgQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDA386028D;
        Thu,  5 Jul 2018 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530809732;
        bh=40jr4fzMmtsy5y0KdgFZz3zrxUDLVqi1HVo7R9G662k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnUYTA6oT/xdwbeIePcTwNh71Y3gVDLQcgVhpi2GNGaBSaf+e0MzqHLM3YYXcGRvl
         xTJjDcQjlkiNoKeBysrs73AVpPwBmPGkj/jUWNXPM+sqWnJPLSyCj7EJA1twXjnZjB
         bI4p63i4/s7radUbgc1Dz7NWOqEXkvG6aYXs9wlI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDA386028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v9 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date:   Thu,  5 Jul 2018 22:25:09 +0530
Message-Id: <20180705165515.13340-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705165515.13340-1-bgodavar@codeaurora.org>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
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
 .../bindings/net/qualcomm-bluetooth.txt       | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..ced58575e2b8 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,22 @@ device the slave device is attached to.
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
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +38,17 @@ serial@7570000 {
 		clocks = <&divclk4>;
 	};
 };
+
+serial@898000 {
+	label = "BT-UART";
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxosupply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

