Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A09C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2092420675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CrTWGh4J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AVNXxhFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfBVWTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:19:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfBVWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:19:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F95360A43; Fri, 22 Feb 2019 22:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873953;
        bh=PWGH0nGhMneRBlsRXPi5PG6HarupNrLKOjM2ynX+S9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrTWGh4JcPKwfj/kwSX9YX+ZE0h22IJY60emdXXmyXUIx8ShjHAdrYFJi1jydSErm
         RjBXT7LJdXNst4qVlqp2rZAPLs2qEHKd3xVuz3+2XbaM7O3UWmKGa/H00kuwNtK3Bf
         SVsabVz67VmS5DzgLeDTYEzJNUw500XKxmy5VRn4=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D153C60A0B;
        Fri, 22 Feb 2019 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873952;
        bh=PWGH0nGhMneRBlsRXPi5PG6HarupNrLKOjM2ynX+S9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVNXxhFghHS/LuDFnR5WhQE7EQTAHvQeV9FuJpwda87cs5oEnwc+l+4whNSztH10X
         idK7Bcad4p6Bh5S4wiXK21YySbug5+c2xFg34RokfVb0Lh1//IOMJGr05sXfUao4/q
         AePaI2IvMBBKBVpFlIba7QL1FxAyKsEYdyQDRhTY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D153C60A0B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 8/9] arm64: dts: qcom: setup PDC as wakeup parent for GPIOs for SDM845
Date:   Fri, 22 Feb 2019 15:18:49 -0700
Message-Id: <20190222221850.26939-9-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222221850.26939-1-ilina@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup PDC wakeup parent for TLMM for SDM845 SoC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v4:
	- Provide irqdomain-map for GPIOs that map to PDC
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 78 ++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e55100c2705e..58f9f2111449 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -994,6 +994,84 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			wakeup-parent = <&pdc_intc>;
+			irqdomain-map = <1 0 &pdc_intc 30 0>,
+					<3 0 &pdc_intc 31 0>,
+					<5 0 &pdc_intc 32 0>,
+					<10 0 &pdc_intc 33 0>,
+					<11 0 &pdc_intc 34 0>,
+					<20 0 &pdc_intc 35 0>,
+					<22 0 &pdc_intc 36 0>,
+					<24 0 &pdc_intc 37 0>,
+					<26 0 &pdc_intc 38 0>,
+					<30 0 &pdc_intc 39 0>,
+					<31 0 &pdc_intc 117 0>,
+					<32 0 &pdc_intc 41 0>,
+					<34 0 &pdc_intc 42 0>,
+					<36 0 &pdc_intc 43 0>,
+					<37 0 &pdc_intc 44 0>,
+					<38 0 &pdc_intc 45 0>,
+					<39 0 &pdc_intc 46 0>,
+					<40 0 &pdc_intc 47 0>,
+					<41 0 &pdc_intc 115 0>,
+					<43 0 &pdc_intc 49 0>,
+					<44 0 &pdc_intc 50 0>,
+					<46 0 &pdc_intc 51 0>,
+					<48 0 &pdc_intc 52 0>,
+					<49 0 &pdc_intc 118 0>,
+					<52 0 &pdc_intc 54 0>,
+					<53 0 &pdc_intc 55 0>,
+					<54 0 &pdc_intc 56 0>,
+					<56 0 &pdc_intc 57 0>,
+					<57 0 &pdc_intc 58 0>,
+					<58 0 &pdc_intc 59 0>,
+					<59 0 &pdc_intc 60 0>,
+					<60 0 &pdc_intc 61 0>,
+					<61 0 &pdc_intc 62 0>,
+					<62 0 &pdc_intc 63 0>,
+					<63 0 &pdc_intc 64 0>,
+					<64 0 &pdc_intc 65 0>,
+					<66 0 &pdc_intc 66 0>,
+					<68 0 &pdc_intc 67 0>,
+					<71 0 &pdc_intc 68 0>,
+					<73 0 &pdc_intc 69 0>,
+					<77 0 &pdc_intc 70 0>,
+					<78 0 &pdc_intc 71 0>,
+					<79 0 &pdc_intc 72 0>,
+					<80 0 &pdc_intc 73 0>,
+					<84 0 &pdc_intc 74 0>,
+					<85 0 &pdc_intc 75 0>,
+					<86 0 &pdc_intc 76 0>,
+					<88 0 &pdc_intc 77 0>,
+					<89 0 &pdc_intc 116 0>,
+					<91 0 &pdc_intc 79 0>,
+					<92 0 &pdc_intc 80 0>,
+					<95 0 &pdc_intc 81 0>,
+					<96 0 &pdc_intc 82 0>,
+					<97 0 &pdc_intc 83 0>,
+					<101 0 &pdc_intc 84 0>,
+					<103 0 &pdc_intc 85 0>,
+					<104 0 &pdc_intc 86 0>,
+					<115 0 &pdc_intc 90 0>,
+					<116 0 &pdc_intc 91 0>,
+					<117 0 &pdc_intc 92 0>,
+					<118 0 &pdc_intc 93 0>,
+					<119 0 &pdc_intc 94 0>,
+					<120 0 &pdc_intc 95 0>,
+					<121 0 &pdc_intc 96 0>,
+					<122 0 &pdc_intc 97 0>,
+					<123 0 &pdc_intc 98 0>,
+					<124 0 &pdc_intc 99 0>,
+					<125 0 &pdc_intc 100 0>,
+					<127 0 &pdc_intc 102 0>,
+					<128 0 &pdc_intc 103 0>,
+					<129 0 &pdc_intc 104 0>,
+					<130 0 &pdc_intc 105 0>,
+					<132 0 &pdc_intc 106 0>,
+					<133 0 &pdc_intc 107 0>,
+					<145 0 &pdc_intc 108 0>;
+			irqdomain-map-mask = <0xff 0>;
+			irqdomain-map-pass-thru = <0 0xff>;
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

