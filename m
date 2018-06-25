Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D81325AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mfA4f31q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mfA4f31q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D81325AB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934215AbeFYNmv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:42:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755345AbeFYNk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 952AA60791; Mon, 25 Jun 2018 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934028;
        bh=/qoVU1NSlTfNbRJtCaj1eKbbZC1ANROnlSaCSWOm1ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfA4f31qj/id2TthuSK60uHsvnMf804jQ8OlJjK7U8or1S32xCqUAB2lKw5QYNl+S
         qOjaQPTfmatXIxMtaBW3XGB5bmaRMFMsh2H9qcehk6PGh6buzjdJCebk9FWkp8C80u
         +n5cp33BKu+vYsjAePcUJ9K0witbwmHirOmV062Y=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4494260A06;
        Mon, 25 Jun 2018 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934028;
        bh=/qoVU1NSlTfNbRJtCaj1eKbbZC1ANROnlSaCSWOm1ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfA4f31qj/id2TthuSK60uHsvnMf804jQ8OlJjK7U8or1S32xCqUAB2lKw5QYNl+S
         qOjaQPTfmatXIxMtaBW3XGB5bmaRMFMsh2H9qcehk6PGh6buzjdJCebk9FWkp8C80u
         +n5cp33BKu+vYsjAePcUJ9K0witbwmHirOmV062Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4494260A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date:   Mon, 25 Jun 2018 19:10:07 +0530
Message-Id: <20180625134013.19684-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---

Changes in v8:
    * Separated the optional entries between two chips

Changes in v7:
    * no change.

Changes in v6:

    * Changed the oper-speed to max-speed.

Changes in v5:

    * Added entry for oper-speed and init-speed.

---
 .../bindings/net/qualcomm-bluetooth.txt       | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 0ea18a53cc29..c2b09dd2bf31 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -10,12 +10,23 @@ device the slave device is attached to.
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
+ - vddio-supply: Bluetooth VDD IO regulator handle.
+ - vddxtal-supply: Bluetooth VDD XTAL regulator handle.
+ - vddpa-supply: Bluetooth VDD PA regulator handle.
+ - vddldo-supply: Bluetooth VDD LDO regulator handle.
+ - vddcore-supply: Bluetooth VDD CORE regulator handle.
+ - max-speed: Maximum operating speed of the chip.
+
+Examples:
 
 serial@7570000 {
 	label = "BT-UART";
@@ -28,3 +39,18 @@ serial@7570000 {
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
+		vddio-supply = <&pm8998_s3>;
+		vddxtal-supply = <&pm8998_s5>;
+		vddcore-supply = <&pm8998_l7>;
+		vddpa-supply = <&pm8998_l17>;
+		vddldo-supply = <&pm8998_l25>;
+		max-speed = <3200000>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

