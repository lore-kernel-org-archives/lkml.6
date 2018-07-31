Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3CAC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CF42083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QINk+XX/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QINk+XX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CF42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbeHAA1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:27:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbeHAA1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:27:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7D17602D7; Tue, 31 Jul 2018 22:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533077087;
        bh=CkVqqPXhxoYUJzX4cYejKdu34f63CVroviRU9raEtOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QINk+XX/cck8c3xhvYK7V/qeTMw28dtR1ABzoLVgbjxGYxY1bRXk41MWHlTUp5N+5
         HMlpQA5UDD8wdN0FAoIWUfZSqGtVllKU3IFgvkEwNiqnDkBlcaV6uD0vC9Vw6HFCfp
         cvzlGYXgNVmshgqaVWKYEORISreikUwkZrlJwzQU=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F42E60B7A;
        Tue, 31 Jul 2018 22:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533077087;
        bh=CkVqqPXhxoYUJzX4cYejKdu34f63CVroviRU9raEtOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QINk+XX/cck8c3xhvYK7V/qeTMw28dtR1ABzoLVgbjxGYxY1bRXk41MWHlTUp5N+5
         HMlpQA5UDD8wdN0FAoIWUfZSqGtVllKU3IFgvkEwNiqnDkBlcaV6uD0vC9Vw6HFCfp
         cvzlGYXgNVmshgqaVWKYEORISreikUwkZrlJwzQU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F42E60B7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, sboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 4/4] arm64: dts: qcom: add wake up interrupts for GPIOs
Date:   Tue, 31 Jul 2018 16:44:21 -0600
Message-Id: <20180731224421.29062-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731224421.29062-1-ilina@codeaurora.org>
References: <20180731224421.29062-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs that are wakeup capable have interrupt lines that are routed to
the always-on interrupt controller (PDC) in parallel to the pinctrl. The
interrupts listed here are the wake up lines corresponding to GPIOs.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8ccce42885c1..96ef18ced85b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -720,6 +720,75 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			interrupts-extended = <&pdc 30 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 31 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 32 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 33 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 34 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 35 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 36 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 37 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 38 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 39 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 41 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 42 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 43 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 44 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 45 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 46 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 47 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 49 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 50 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 52 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 54 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 55 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 56 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 57 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 58 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 59 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 60 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 61 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 62 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 63 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 64 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 65 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 66 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 67 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 68 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 69 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 70 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 71 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 72 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 73 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 74 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 75 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 77 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 79 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 80 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 81 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 82 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 83 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 84 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 85 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 86 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 90 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 91 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 92 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 95 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 96 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 97 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 98 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 99 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 100 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 102 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 103 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 104 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 105 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 106 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 107 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 108 IRQ_TYPE_LEVEL_HIGH>;
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

