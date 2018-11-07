Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485F22086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gAgVyIY6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lwmjj8Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485F22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKHHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:23:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeKHHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:23:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1DD3960767; Wed,  7 Nov 2018 21:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541627479;
        bh=o/7CHat9NMNmeV0dZRqmp7qU5wrneKuZO7FjFc6Lvv4=;
        h=From:To:Cc:Subject:Date:From;
        b=gAgVyIY6kDmAc35vfiOestmDruLCcg7W5cac5646Lf1JuOrPMvDQ3EMIJZvtW3j6p
         mj6mCFo1vuNP23VPLMvn4Z0gTmw+gzhQibZMviSmxnuGKSTVY3oZASyWac9+bP3rvd
         sSfASfC8fU2ndqJPwsjJC1JpZ+3n1CyMMvSN5tU0=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C1A8601D4;
        Wed,  7 Nov 2018 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541627478;
        bh=o/7CHat9NMNmeV0dZRqmp7qU5wrneKuZO7FjFc6Lvv4=;
        h=From:To:Cc:Subject:Date:From;
        b=lwmjj8Wj9fBwjm5jvE9x9fNJAjz9h70KpXcPjBKCdCpQjN+XKD1eWzf1w0d+NRF8i
         RHuqpHLWAi7c7d3aAVyWF41TAJHUz1ksvj+yu8V/Rqgg/NOdbV9cNgmXbZWp/UpYQ0
         j1FaFW/mXnRAoxw9QGEMO3YM9qrkZMwLkLVepeXc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C1A8601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND v3 1/2] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Wed,  7 Nov 2018 14:51:08 -0700
Message-Id: <20181107215109.10720-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v3:
	- Fix PDC map, use GIC SPI port number for hwirq
Changes in v2:
	- Order by address
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..09f26ae9f803 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1256,6 +1256,15 @@
 			#power-domain-cells = <1>;
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0xb220000 0x30000>;
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

