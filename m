Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8277FC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CEC20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="grqsC9v+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e7JBbqHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CEC20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbeHAA1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:27:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbeHAA1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:27:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 673F660376; Tue, 31 Jul 2018 22:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533077086;
        bh=581JxNB8Da/P0lN368HSxwfqz87i8KsLsNq8M9Crs2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grqsC9v+fJpsGx5mmuUyXZSI/dsLlkg1R4qrxuus2G8rqZLWXMZ7W7OgRv8zh6420
         ychrQk8W2xtP5p9C5O+Qft2MbKH/QeSS2XhMyVoA+oQ7LavP1irqlcf8myaEU+YxXj
         pJRfmOEpSlerACL2da3T3Pw4GyWqGAcMmbNaRUF8=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F4D9608C8;
        Tue, 31 Jul 2018 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533077085;
        bh=581JxNB8Da/P0lN368HSxwfqz87i8KsLsNq8M9Crs2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7JBbqHa3FyHNu0b3wAKAyO05fDPZ49o/RQhbENJ8Ht01BJms2kFvlDhfZymTjkaF
         YowP5+bH14jySBv9ItUKAN3441Pek78TRV84FQK0EvDSnc+I84NknqPZ5x9gd+WhZf
         I4r6GYa2cpWW63DzasQDroVOPZd1XQ6I6KR679U4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F4D9608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, sboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 3/4] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Tue, 31 Jul 2018 16:44:20 -0600
Message-Id: <20180731224421.29062-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731224421.29062-1-ilina@codeaurora.org>
References: <20180731224421.29062-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2acc17ce1a9c..8ccce42885c1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1213,6 +1213,15 @@
 			};
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0xb220000 0x30000>;
+			qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		timer@17c90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

