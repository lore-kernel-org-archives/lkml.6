Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F346C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7329218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Au9Jm8G5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mAyuZ2gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfAXUWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:22:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfAXUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:22:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE0ED61569; Thu, 24 Jan 2019 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361349;
        bh=zSqqsRDWt5Ma24zl3RMyJ/Vp8szImbQdhVP5OlnAcH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Au9Jm8G5Hex/RTYhsPm2KzCngKbUbOoxeOngKU7pEGIEX0Xra6JE2HQr0wIWcHJdp
         fC9eO75jWJaPxHA/ydns2oFNiun0UXActADZBHirbyrbNvSz3NkRpON3fpwsJDdMeA
         TGRDSJb1h0UaaZ+GxzUk8kutUlj/0gD/OBkpY6tQ=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCB1D60D77;
        Thu, 24 Jan 2019 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361341;
        bh=zSqqsRDWt5Ma24zl3RMyJ/Vp8szImbQdhVP5OlnAcH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAyuZ2gW40vXOOUvQXYwT1HtB9WD8oHfgx14wDRTGquPf/Oop2frS458nKx3T/xbR
         xx5bQFUBDiRXZtiwYYMsVXlWzcfjQNpYoTcVRon1CWhxBaDNIIiiAersGddDIKboL8
         BMtRigWb3PLccd8MDX4qYPM36+LnROWHt7i5WCQI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCB1D60D77
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 6/8] arm64: dts: qcom: add PDC interrupt controller for SDM845
Date:   Thu, 24 Jan 2019 13:22:03 -0700
Message-Id: <20190124202205.7940-7-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124202205.7940-1-ilina@codeaurora.org>
References: <20190124202205.7940-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>

---
Changes in v2:
	- Use updated address specification in reg
	- Rename to pdc_intc
	- Sort per address in DT
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..e55100c2705e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1534,6 +1534,15 @@
 			#power-domain-cells = <1>;
 		};
 
+		pdc_intc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0 0x0b220000 0 0x30000>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

