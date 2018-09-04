Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6556C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830C22082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nELUZ3OO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iUaJCxjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIEBp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:45:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIEBp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:45:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27B7B607F4; Tue,  4 Sep 2018 21:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095913;
        bh=or092DH+i9rwptIb1hSb1dIpPy4l660Iji0v8NJWj8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nELUZ3OOY+pdKIkztsujGUmA5ShrMPILl2ENoYAn2yQJnzZaz5kbRREJkGjbT1V7u
         GtgjzHOIzDE4V0PbWfh3wQm7SwcNOx9vrGCpq/KTHqNte7YONya2cyLDE3265TOBP/
         ByPinDwfDZkkelwFuFs151tTyEIHbNgbE2sMrhlA=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE085607DC;
        Tue,  4 Sep 2018 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095909;
        bh=or092DH+i9rwptIb1hSb1dIpPy4l660Iji0v8NJWj8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUaJCxjFlxJEQrSau/g2WEHXkkg1cWp0znSg4ffr+oI+R03RepSBseDQTmZSm+8qk
         4XTJxCU4Tw2McSdOK3siZ1LnT4h/g+URA6mkjp72Nh1MTPtcUwYXJ2G45po/HDYx/9
         jb35vhVOr2v7SEEWpS2Yb1JxLRX7OH+RTVjyhNP0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE085607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 5/5] arm64: dts: qcom: add wake up interrupts for GPIOs for SDM845
Date:   Tue,  4 Sep 2018 15:18:10 -0600
Message-Id: <20180904211810.5506-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904211810.5506-1-ilina@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs that are wakeup capable have interrupt lines that are routed to
the always-on interrupt controller (PDC) in parallel to the pinctrl. The
interrupts listed here are the wake up lines corresponding to GPIOs.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
	- Define IRQ trigger type in DT
Changes in v1:
	- Use interrupt-extended for all TLMM interrupts
	- Define GPIO-PDC map using interrupt-names
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 152 ++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0208f8557ffa..8d87794092b0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -712,11 +712,161 @@
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,sdm845-pinctrl";
 			reg = <0x03400000 0xc00000>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			interrupts-extended =
+				<&intc GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 30 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 31 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 32 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 33 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 34 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 35 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 36 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 37 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 38 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 39 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 41 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 42 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 43 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 44 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 45 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 46 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 47 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 49 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 50 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 52 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 54 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 55 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 56 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 57 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 58 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 59 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 60 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 61 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 62 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 63 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 64 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 65 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 66 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 67 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 68 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 69 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 70 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 71 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 72 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 73 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 74 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 75 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 77 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 79 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 80 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 81 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 82 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 83 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 84 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 85 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 86 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 90 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 91 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 92 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 95 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 96 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 97 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 98 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 99 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 100 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 102 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 103 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 104 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 105 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 106 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 107 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 108 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "summary-irq",
+				"gpio1",
+				"gpio3",
+				"gpio5",
+				"gpio10",
+				"gpio11",
+				"gpio20",
+				"gpio22",
+				"gpio24",
+				"gpio26",
+				"gpio30",
+				"gpio32",
+				"gpio34",
+				"gpio36",
+				"gpio37",
+				"gpio38",
+				"gpio39",
+				"gpio40",
+				"gpio43",
+				"gpio44",
+				"gpio46",
+				"gpio48",
+				"gpio52",
+				"gpio53",
+				"gpio54",
+				"gpio56",
+				"gpio57",
+				"gpio58",
+				"gpio59",
+				"gpio60",
+				"gpio61",
+				"gpio62",
+				"gpio63",
+				"gpio64",
+				"gpio66",
+				"gpio68",
+				"gpio71",
+				"gpio73",
+				"gpio77",
+				"gpio78",
+				"gpio79",
+				"gpio80",
+				"gpio84",
+				"gpio85",
+				"gpio86",
+				"gpio88",
+				"gpio91",
+				"gpio92",
+				"gpio95",
+				"gpio96",
+				"gpio97",
+				"gpio101",
+				"gpio103",
+				"gpio104",
+				"gpio115",
+				"gpio116",
+				"gpio117",
+				"gpio118",
+				"gpio119",
+				"gpio120",
+				"gpio121",
+				"gpio122",
+				"gpio123",
+				"gpio124",
+				"gpio125",
+				"gpio127",
+				"gpio128",
+				"gpio129",
+				"gpio130",
+				"gpio132",
+				"gpio133",
+				"gpio145",
+				"gpio41",
+				"gpio89",
+				"gpio31",
+				"gpio49",
+				"gpio41",
+				"gpio89",
+				"gpio31",
+				"gpio49";
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

