Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A95C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AC221564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pbq0LxaH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IZNsxDk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AC221564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeHBVAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:00:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBVAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:00:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FD6960AFF; Thu,  2 Aug 2018 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533236872;
        bh=8RkbnUT5iT1aT/hw2tlljuZ2YKzh8YyrISvf2c80tbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pbq0LxaHRb+7NYtpI9iewBC9RtlFba5M1sb/xllzWuW2Oo1bCW2inlUZl/e2OSb75
         xewJwed+J3RblsxJYImTiJKnS8MzSCHur3f5FDrr7eouT5Pu5kvLydXRTuvPP0gOda
         3H87KZoTMKJJI/gJWHXccu+9XaM9R8ZLPsWxC2i8=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E57F602B7;
        Thu,  2 Aug 2018 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533236871;
        bh=8RkbnUT5iT1aT/hw2tlljuZ2YKzh8YyrISvf2c80tbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZNsxDk6rVRACC/re3adDzfZw0leak+Cn5TxskVyx8b1jnnq0AJa4CgqPhI+o8vov
         FA6P0knYH9NUrdkHcNGVqa1InFJQdVVpRFis2n++Ry9M0mQJry6RUlXWK07YJyN7gJ
         BEv4VVXK9Q2EfktdcF9b2LHHgIq31je5+AJ62Wlw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E57F602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v13 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date:   Fri,  3 Aug 2018 00:37:26 +0530
Message-Id: <20180802190732.4811-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802190732.4811-1-bgodavar@codeaurora.org>
References: <20180802190732.4811-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v13:
 * Segregated optional and required properties for wcn3990.
---
 .../bindings/net/qualcomm-bluetooth.txt       | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..824c0e23c544 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,25 @@ device the slave device is attached to.
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
+Required properties for compatible string qcom,wcn3990-bt:
+
+ - vddio-supply: VDD_IO supply regulator handle.
+ - vddxo-supply: VDD_XO supply regulator handle.
+ - vddrf-supply: VDD_RF supply regulator handle.
+ - vddch0-supply: VDD_CH0 supply regulator handle.
+
+Optional properties for compatible string qcom,wcn3990-bt:
+
+ - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +41,15 @@ serial@7570000 {
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
+		max-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

