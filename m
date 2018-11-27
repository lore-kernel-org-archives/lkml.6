Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F40208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hHQItZUC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FWZgO2SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F40208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeK1CPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:15:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbeK1CPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:15:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 083A960B26; Tue, 27 Nov 2018 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543331849;
        bh=ZLSoVfVgCjk8+NbsgXB0aqa1At7TMkQR3K0oqyPSfo0=;
        h=From:To:Cc:Subject:Date:From;
        b=hHQItZUCBJPu5mVi1HDIdM2xLbu/uboYKygH1c2+HmZYLY+YXiBWACI9GD7pB8uI3
         G+OTq8gurL09FWHLTM3GZ1hWISJUJcUjkPe1/z/4Hko4JUYRs5SOCQHpCbcEPAu6Nr
         ChvetxH55h/VOxj3sVfGlZFSXaCAYV3lnMBxflA4=
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A3CF607EB;
        Tue, 27 Nov 2018 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543331848;
        bh=ZLSoVfVgCjk8+NbsgXB0aqa1At7TMkQR3K0oqyPSfo0=;
        h=From:To:Cc:Subject:Date:From;
        b=FWZgO2SMCtOroA2X3AlFCoB+FVfFe/KYDK73/7Onw7YJhXI2YHbk37MGD8LLct9xN
         +FAYUVfqnP52VJg4REuc1MQPHw6nDvUTDiEFAKZhdybwnitILacPrS9W9ItPkrPGbo
         GyOtQwc8kwKVm4nJKL7HdCmXhb5NUWyA0rsUgG9g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A3CF607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v2] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device node
Date:   Tue, 27 Nov 2018 20:47:16 +0530
Message-Id: <20181127151716.31992-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for the ath10k SNOC platform driver probe
and add resources required for WCN3990 on qcs404 soc.
Optional clock and regulator controls are not yet available in
upstream, hence add them once available.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  4 ++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 0767389c68c1..36905524b0ff 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -310,6 +310,10 @@
 	status = "okay";
 };
 
+&wifi {
+	status = "okay";
+};
+
 /* PINCTRL - additions to nodes defined in qcs404.dtsi */
 
 &blsp1_i2c1_default {
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9ca4f061ecc5..b3b98745046f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -886,6 +886,26 @@
 			status = "disabled";
 		};
 
+		wifi: wifi@a000000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0xa000000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

