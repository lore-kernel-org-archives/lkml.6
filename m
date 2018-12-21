Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6152218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TqXpAVgG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ig3QK5lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbeLUMAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:00:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbeLUMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:00:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A25EF609BD; Fri, 21 Dec 2018 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393639;
        bh=VPohEwpwkQAhAd6+PHCr4kP8c1qHYsLHeJ+W1h/ZNCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqXpAVgGVeEqWnZv61VakAVnghx0yB2yVvlmNaQqu9NUQ/l9wzkIAobXi85+dv1PC
         DpmZHeT/NRagP02EVxDI3oLywwiNuurP6qGmFAxY6h2ezBOq3Q7MBPwhG7Pab5st/F
         rxy0++VNYh05U64QuhP1ozMi5bMHkwLghml7IOmc=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4D3660909;
        Fri, 21 Dec 2018 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393637;
        bh=VPohEwpwkQAhAd6+PHCr4kP8c1qHYsLHeJ+W1h/ZNCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ig3QK5lbqv7XcXmu+03+YYOqA47iDzIgBvws3oWFPxpVkRN9UhfqY/+8dx5I90AQr
         9BC8miUsC3wBFg13d8eD+KDFAfbJFcVAV5VN9wtuXCNlSj24VGbWtFXLtmGQYOrVz2
         HUOL4fWILqw0huWIwHdYvfH95TRaSQ6g9Bvd9my4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4D3660909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Date:   Fri, 21 Dec 2018 17:29:44 +0530
Message-Id: <20181221115946.10095-4-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's PDC timer.
The driver is used for programming next wake-up timer value when processor
enters SoC level deepest low power state.

Cc: devicetree@vger.kernel.org
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
index 9b86d1eff219..f24afb45d0d9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
@@ -30,6 +30,12 @@ will be an aggregate of the sleep votes from each of those subsystems. Clients
 may request a sleep value for their shared resources in addition to the active
 mode requests.
 
+When the processor enters deepest low power mode, the next wake-up timer value
+needs to be programmed to PDC (Power Domain Controller) through RSC registers
+dedicated for this purpose. PDC timer is specified as child node of RSC with
+register offets to program timer match value.
+
+
 Properties:
 
 - compatible:
@@ -86,6 +92,20 @@ Properties:
 Drivers that want to use the RSC to communicate with RPMH must specify their
 bindings as child nodes of the RSC controllers they wish to communicate with.
 
+If an RSC needs to program next wake-up in the PDC timer, it must specify the
+binding as child node with the following properties:
+
+Properties:
+- compatible:
+    Usage: required
+	Value type: <string>
+	Definition: must be "qcom,pdc-timer".
+
+- reg:
+    Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Specifies the offset of the control register.
+
 Example 1:
 
 For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
@@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
 		      <0x179d0000 0x10000>,
 		      <0x179e0000 0x10000>;
 		reg-names = "drv-0", "drv-1", "drv-2";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
 				  <SLEEP_TCS   3>,
 				  <WAKE_TCS    3>,
 				  <CONTROL_TCS 1>;
+
+		pdc_timer@38 {
+			compatible = "qcom,pdc-timer";
+			reg = <0x38 0x1>,
+			      <0x40 0x1>;
+		}
 	};
 
 Example 2:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

