Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20087C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BB1206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfAPXlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:41:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32814 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfAPXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:41:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so3849538pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 15:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fv4Anz8yqfBEeE5rRzQxGaW+VVCut0hZE37ZV8uO3I=;
        b=IHUead+PWXi3X2ZCqfxJTZ2V86VPPELZzaE4t3av0fqu3N8UF57IDdRARbFBK7jAOc
         JX4PI9c9UGvWBV9b4etovkt5TQ3l4eK0eeEZlTViBif7nrRTRIgxL0oMhiMfqlu0Zq2c
         KwQnQbshHrVf62eib48LVkN5a5EN0C2qXfY1TSfPfGpW5yMNQRa5pKnV/hdvJRu/XttJ
         0r6thw73HsoDyGr12jNc2px+aKr8rHNvT8DcMK5oZnCuirK5x19Ee2ZTur9G7JI+div1
         xyLWHvkV+nXwUpXiDSsEzJEiCJoa3MXeEk3volhxPp3RHf3LtL3ncyDvVLc/YP8lm0RP
         sg2w==
X-Gm-Message-State: AJcUuke9mCqeXrpV600qR0FxZl7pddcn6jzHCxeimEpS/75z5pxGpxOn
        fa0lTnOK4A731cASxepD3gL4qA==
X-Google-Smtp-Source: ALg8bN7x43Y2ua/thcPiCDEjmYhpCn2j68ik77XxtdyCh1QJgsO/X4O7t5AN5zFLH8bldW77yOhFhA==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr11470849pgc.25.1547682059292;
        Wed, 16 Jan 2019 15:40:59 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h64sm11334292pfc.142.2019.01.16.15.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 15:40:58 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: sdm845: Add CPU capacity values
Date:   Wed, 16 Jan 2019 15:40:39 -0800
Message-Id: <20190116234039.12935-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the relative CPU capacity of all SDM845 AP cores.

The values were provided by Qualcomm engineers.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d9be5bba62c45..e01949fd44075 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -99,6 +99,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
@@ -115,6 +116,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
@@ -128,6 +130,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
@@ -141,6 +144,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
@@ -154,6 +158,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
@@ -167,6 +172,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
@@ -180,6 +186,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
@@ -193,6 +200,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
-- 
2.20.1.321.g9e740568ce-goog

