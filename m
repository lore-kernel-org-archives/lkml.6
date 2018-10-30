Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BFC2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nFJBSVUY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kmSKO3i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BFC2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJaCSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:18:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJaCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:18:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C0D66072E; Tue, 30 Oct 2018 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540920224;
        bh=zT684WrIQu5AnH3CB8qkHlQ5EJ/kYkJ4L3xMUO2l/3k=;
        h=From:To:Cc:Subject:Date:From;
        b=nFJBSVUYc36CXpqV0vyBg3/UI0A06JFWjwT7iKDfwnQg8Iioo1F9VBz40teu3Chc0
         52z2hi7tjEYNvnsLE+Okn7c9HAJ+FqjQjDOvcL+zmabQXkLZH6Cy5SwkDmyfloFxb/
         UU6xP9H4ke7b7YAeT6AsdDsSmjPbBQsDTPFVjsio=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C4726019F;
        Tue, 30 Oct 2018 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540920223;
        bh=zT684WrIQu5AnH3CB8qkHlQ5EJ/kYkJ4L3xMUO2l/3k=;
        h=From:To:Cc:Subject:Date:From;
        b=kmSKO3i+mqUQGSzZLJ44/PfKmIJn2QqkJSlfN5aYRxRQrhUUnVyK86qKAc2CGXuH7
         jHmJoncOOtSvBLkOIGuTH2GdoB4TurcM3NHCYbJ8gD9DrxPSKbeqif6gwb4r7X27oQ
         yjqaXGxVu0BPWRlUY3OQtd1ChI0Sj0aar/yV1CMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C4726019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date:   Tue, 30 Oct 2018 22:53:29 +0530
Message-Id: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device bindings for cpuidle states for cpu devices.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
Changes in v2
 - Address comments from Doug
---
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa..3a8381e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -96,6 +96,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -111,6 +112,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -123,6 +125,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -135,6 +138,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -147,6 +151,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -159,6 +164,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -171,6 +177,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -183,11 +190,66 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			C0_CPU_PD: c0-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <350>;
+				exit-latency-us = <461>;
+				min-residency-us = <1890>;
+				local-timer-stop;
+				idle-state-name = "power-down";
+			};
+
+			C0_CPU_RPD: c0-rail-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <360>;
+				exit-latency-us = <531>;
+				min-residency-us = <3934>;
+				local-timer-stop;
+				idle-state-name = "rail-power-down";
+			};
+
+			C4_CPU_PD: c4-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <264>;
+				exit-latency-us = <621>;
+				min-residency-us = <952>;
+				local-timer-stop;
+				idle-state-name = "power-down";
+			};
+
+			C4_CPU_RPD: c4-rail-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <1061>;
+				min-residency-us = <4488>;
+				local-timer-stop;
+				idle-state-name = "rail-power-down";
+			};
+
+			CLUSTER_PD: cluster-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x400000F4>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9987>;
+				local-timer-stop;
+				idle-state-name = "cluster-power-down";
+			};
+		};
 	};
 
 	pmu {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

