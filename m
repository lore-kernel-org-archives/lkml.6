Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D706C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F5E2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQjQNWyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbeKFBHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:07:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbeKFBHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:07:02 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459E620862;
        Mon,  5 Nov 2018 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541432803;
        bh=a143pdS4tIBJr4bly2vl5U/d7jRqA/gvLriVw8cq5Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQjQNWytt6OlLZRzwxy3kenuG/QXuk75zhxXjJnwHtJdcN3IXRf857Ku3D7adF+49
         O6efISvW69H/yR0mXxPbV64+EjFVqiRG+bZHhll4aW8Dx+UmaqgM4M40A0M5Epx0DS
         bk1ldPa02OooNtJBUQuXdMI1LMu2VJXu1evP2aw8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 10/17] arm64: dts: qcom: pms405: add rtc node
Date:   Mon,  5 Nov 2018 21:15:22 +0530
Message-Id: <20181105154529.7614-11-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181105154529.7614-1-vkoul@kernel.org>
References: <20181105154529.7614-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC is found on PMIC PMS405 and is same as other PMIC used, so add the
rtc node with compatible as qcom,pm8941-rtc

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 8a585180f102..cdb4547c998b 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -11,5 +11,11 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
 	};
 };
-- 
2.14.4

