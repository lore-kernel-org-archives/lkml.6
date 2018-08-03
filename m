Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F3C2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i0WDVvsl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mSudnDs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F3C2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeHCOMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:12:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44946 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeHCOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:12:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01A9460117; Fri,  3 Aug 2018 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298607;
        bh=qFfW7N0fvbHZC+fvqPkhQh3yVLJhRHmrI0DJ8I/W7kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0WDVvslnqBmtvuviMU1NXm6uxD9CNAemiTkmZk+mFPcYgdpaGjpmgmXvoKERDrlP
         DDRtzbb2e9stEAlfgly0/enxeQo06jNiX/oG3zxkDXIEyRQquo3l73w8H+y5mwjMT8
         asc0xJ5psVWGPb3vzRDA4td1ACL15mI9QCHvW8no=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DEE69602D7;
        Fri,  3 Aug 2018 12:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298606;
        bh=qFfW7N0fvbHZC+fvqPkhQh3yVLJhRHmrI0DJ8I/W7kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSudnDs8K0ixe8eRlxeOQFM9iY4spBN919UPSAFjyxXU77944o59F+zBz++bEA+Oc
         vD1JaN0FVgJWAfW7rGEIW/UcI/WNV2SKWuVllBjAvcBA2xQHMXgC1KkBLPqaVyenKf
         EpWLwIRt1+VgtNAdEKtVjM9IFHiqrcDyB/vcSK3k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEE69602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v15 1/7] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date:   Fri,  3 Aug 2018 17:46:26 +0530
Message-Id: <20180803121632.30689-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803121632.30689-1-bgodavar@codeaurora.org>
References: <20180803121632.30689-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

