Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F178BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B962D20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a71PxEPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B962D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJ3TEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeJ3TEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:04:53 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 315CC20827;
        Tue, 30 Oct 2018 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894323;
        bh=rMCSijJpBWmHWNKbSgW22S4N+CpCoGYs5NW2zeDYw28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a71PxEPdpboZtZg7DNFC5SV3T4XtT4nIY3tn9Lo5tbFIQQwn/YuVGuY1DSGu4Q9tn
         BdzFpmPdKSZpzfT3bmFDyVHRNyHH2+4ExC8GN8GmKu5tOPZ/APGhc5ZlaVy+IEafX5
         jQ+GygoXAWBVk1eYLKz2saApcKpeJHdRF99Uvl80=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 11/17] arm64: dts: qcom: pms405: add gpios
Date:   Tue, 30 Oct 2018 15:41:02 +0530
Message-Id: <20181030101108.11041-12-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181030101108.11041-1-vkoul@kernel.org>
References: <20181030101108.11041-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GPIOs present on PMS405 chip.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index cdb4547c998b..18410d9f0f8f 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -17,5 +17,21 @@
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
+
+		pms405_gpios: gpios@c000 {
+			compatible = "qcom,pms405-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc1 0 IRQ_TYPE_NONE>,
+				<0 0xc2 0 IRQ_TYPE_NONE>,
+				<0 0xc3 0 IRQ_TYPE_NONE>,
+				<0 0xc4 0 IRQ_TYPE_NONE>,
+				<0 0xc5 0 IRQ_TYPE_NONE>,
+				<0 0xc6 0 IRQ_TYPE_NONE>,
+				<0 0xc7 0 IRQ_TYPE_NONE>,
+				<0 0xca 0 IRQ_TYPE_NONE>,
+				<0 0xcb 0 IRQ_TYPE_NONE>;
+		};
 	};
 };
-- 
2.14.4

