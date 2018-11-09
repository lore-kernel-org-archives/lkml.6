Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B77C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B067820892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bimlvx3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B067820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKITZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKITZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:25:21 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988E120883;
        Fri,  9 Nov 2018 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541756735;
        bh=if+DJ4woeOEmeUfzRmjxb9oJ2+z2jt7vf7jO0fltMfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bimlvx3xKu2FnPM6n9LYD3LkHtoss7sfr4N/dAwoOgl8xJjjA9DxUPCR1BUlssZRD
         Lph/3vXteyORGkfIBw7/kurXMclhrekylCjy2I/Z0ltDgDkJfUSNx22vyamxcUnJfd
         qJIPUoyRW75REmBmqYP3UZp7rIXm0gBsNfFYcwy0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 18/18] arm64: dts: qcom: pms405: Add pon and pwrkey nodes
Date:   Fri,  9 Nov 2018 15:14:17 +0530
Message-Id: <20181109094417.12109-19-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMS405 also features PON block, so add PON and PWRKEY nodes

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 8e5a8573430e..ad2b62dfc9f6 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -2,6 +2,7 @@
 // Copyright (c) 2018, Linaro Limited
 
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 &spmi_bus {
 	pms405_0: pms405@0 {
@@ -29,6 +30,21 @@
 				<0 0xcb 0 IRQ_TYPE_NONE>;
 		};
 
+		pon@800 {
+			compatible = "qcom,pms405-pon";
+			reg = <0x0800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
-- 
2.14.4

