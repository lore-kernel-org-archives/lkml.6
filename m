Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57593C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A18D204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e+r0MgkF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cXUGW12i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A18D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJPAsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:48:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeJPAsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:48:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 600B760C4B; Mon, 15 Oct 2018 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539622962;
        bh=FHHqPPAb7jaZouBxx2aewee0hEA/unhD9dqh4BWEfGg=;
        h=From:To:Cc:Subject:Date:From;
        b=e+r0MgkFJHnNMJgjpr7HEHZ48A/5JUzjZzVbprVWktZskYNeg7KYFsTy3gjrhfFlT
         Ym4IScSpPrTwOrFwb+lKSxC5+DaBSofX2m6OpDc+Ra21L7BP3CAsoO3NKWqT0j/nzk
         7jYf6+gZ3OEtIA/NQLfdGFkpbyB09RdAvmFwJK+E=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97005604B4;
        Mon, 15 Oct 2018 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539622961;
        bh=FHHqPPAb7jaZouBxx2aewee0hEA/unhD9dqh4BWEfGg=;
        h=From:To:Cc:Subject:Date:From;
        b=cXUGW12iJSLaQuwe6CZkcaNMU2e4Se2U5nAOPy2O2ms7hvDbUsVCnUx99+7Qt6MhU
         GA/pj/0gZPwAUnJieSuIDmdduKYljp2PS9JcG+ZeiJCat3macjJpu2wNFV1hr57pdO
         RYTgkCrl0YNnT7jtBFmhFrjkI5XdZJ2QfI6hKeUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97005604B4
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
Subject: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date:   Mon, 15 Oct 2018 22:32:33 +0530
Message-Id: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device bindings for cpuidle states for cpu devices.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa..32262b0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -96,6 +96,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -111,6 +112,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -123,6 +125,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -135,6 +138,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -147,6 +151,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -159,6 +164,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -171,6 +177,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -183,11 +190,66 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			C0_CPU_SPC: c0_spc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <350>;
+				exit-latency-us = <461>;
+				min-residency-us = <1890>;
+				local-timer-stop;
+				idle-state-name = "pc";
+			};
+
+			C0_CPU_PC: c0_pc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <360>;
+				exit-latency-us = <531>;
+				min-residency-us = <3934>;
+				local-timer-stop;
+				idle-state-name = "rail pc";
+			};
+
+			C4_CPU_SPC: c4_spc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <264>;
+				exit-latency-us = <621>;
+				min-residency-us = <952>;
+				local-timer-stop;
+				idle-state-name = "pc";
+			};
+
+			C4_CPU_PC: c4_pc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <1061>;
+				min-residency-us = <4488>;
+				local-timer-stop;
+				idle-state-name = "rail pc";
+			};
+
+			CLUSTER_PC: cluster_pc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x400000F4>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9987>;
+				local-timer-stop;
+				idle-state-name = "cluster pc";
+			};
+		};
 	};
 
 	pmu {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

