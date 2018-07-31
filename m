Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B5120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B5120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeGaU2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:28:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41672 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbeGaU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:27:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so9513905pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76XyzsmzEYZUY9NhKGrjYdT4OLrEbkvqeBkWmOp81tA=;
        b=q9VG2p3GoYX9vaxAkTIiMpuA/t7XwqKru/c1tRDeGnZxyANF5GwEAkJXE7NuecFlaJ
         +fuT3kyO5tbXJk3/dsnD886CGBY676XT23AwtSt7dsWjMYP+atHWRmg8d24Yit2UB0Rt
         94ZPTm2sr/Nyt1f3IbifhqvQjU3RPYWpNuDPIXoJFGqOGhiZViDd/6OmwelumdgoKf2m
         41MKNvEZAC95jpPyZ3P6f1LdDTWBjXmP9i0yXO0dGncnxiUHRzZc3gTHkc3GrG4LNWDX
         nbG9bU8mYCAjREd7F+E0xuURRGfpMyW4bMbZBynTdK8SMrlmeHtHfm4Cq+Pf7Xvi8WOc
         nfQw==
X-Gm-Message-State: AOUpUlEGqT6hTY1t5HTQXL4ybntPcFQar7N5OVIwYCurkluWQeZh+7kP
        u5S0xcQbAtpPhi5BzBomlGjMCg==
X-Google-Smtp-Source: AAOMgpeQDSNeEPxjvyjwh+H1fn0Zw/3zHct3IoSK8/VxFYfrGOiAAvFWFJVkpWuurNASWC/Vky0TEQ==
X-Received: by 2002:a62:5d55:: with SMTP id r82-v6mr23541738pfb.150.1533062781244;
        Tue, 31 Jul 2018 11:46:21 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b21-v6sm4981683pgw.79.2018.07.31.11.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:46:20 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 4/5] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Tue, 31 Jul 2018 11:45:55 -0700
Message-Id: <20180731184556.169290-4-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731184556.169290-1-mka@chromium.org>
References: <20180731184556.169290-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- none

Changes in v5:
- added tag 'Reviewed-by: Douglas Anderson <dianders@chromium.org>'

Changes in v4:
- none

Changes in v3:
- changed node name from 'qcom,temp-alarm@2400' to 'temp-alarm@2400'
- removed controller register length value from 'reg'

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..7eea94701b23 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,6 +11,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.345.g5c9ce644c3-goog

