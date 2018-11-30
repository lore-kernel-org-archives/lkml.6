Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DD5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A7B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z5E5pRTi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hwXkI+Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A7B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLACvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:51:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLACvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:51:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D66B6147A; Fri, 30 Nov 2018 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543592507;
        bh=pvXyvEcb6BplUNYlow/82bOYJpg1wFp/qkszuvSmBv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5E5pRTi4sByyuIIv3IfL+kMygTn78fpxBqRUxLr0s8HCWgglLI3qYEvTRjdivcS1
         a95ZZnF5wvjHrxPm58Bmvs+ZVOzAgh1DT3El/KWR2i74Eg2KSffRGSj2/W/N9hyTfF
         u3mIFi+hstSq6xMS98BHchumI//u868UtDHuMI94=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23FD36143B;
        Fri, 30 Nov 2018 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543592506;
        bh=pvXyvEcb6BplUNYlow/82bOYJpg1wFp/qkszuvSmBv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwXkI+Ptgjp9OvuKeqgp4U23Wc1X6xoktY3driZ65pkkwpDW9AvLfPEBvor9xcLzN
         IMYnEUnDk6n/C65mQ7ONjWXUJmQ9fj7EuIYyeBD7T6+qkTCeH116QIypJuJircP+Ap
         cuZlSQWOi6+vyIcC2Ze9GnpHf803k7lzzTyn00X4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23FD36143B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 30 Nov 2018 08:41:45 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Message-ID: <20181130154145.GK18262@codeaurora.org>
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30 2018 at 11:23 -0600, Raju P.L.S.S.S.N wrote:
>Add device bindings for cpuidle states for cpu devices.
>
>Cc: <devicetree@vger.kernel.org>
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>---
>Changes in v2
> - Address comments from Doug
>---
>---
> arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index 0c9a2aa..3a8381e 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>@@ -96,6 +96,7 @@
> 			reg = <0x0 0x0>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_0>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
I think it might be better to use 
<&C0_CPU_PD>, <&C0_CPU_RPD>, <&CLUSTER_PD>
> 			L2_0: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -111,6 +112,7 @@
> 			reg = <0x0 0x100>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_100>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> 			L2_100: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -123,6 +125,7 @@
> 			reg = <0x0 0x200>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_200>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> 			L2_200: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -135,6 +138,7 @@
> 			reg = <0x0 0x300>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_300>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> 			L2_300: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -147,6 +151,7 @@
> 			reg = <0x0 0x400>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_400>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_400: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -159,6 +164,7 @@
> 			reg = <0x0 0x500>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_500>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_500: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -171,6 +177,7 @@
> 			reg = <0x0 0x600>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_600>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_600: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -183,11 +190,66 @@
> 			reg = <0x0 0x700>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_700>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_700: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
> 			};
> 		};
>+
>+		idle-states {
>+			entry-method = "psci";
>+
>+			C0_CPU_PD: c0-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000003>;
>+				entry-latency-us = <350>;
>+				exit-latency-us = <461>;
>+				min-residency-us = <1890>;
>+				local-timer-stop;
>+				idle-state-name = "power-down";
>+			};
>+
>+			C0_CPU_RPD: c0-rail-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000004>;
>+				entry-latency-us = <360>;
>+				exit-latency-us = <531>;
>+				min-residency-us = <3934>;
>+				local-timer-stop;
>+				idle-state-name = "rail-power-down";
>+			};
>+
>+			C4_CPU_PD: c4-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000003>;
>+				entry-latency-us = <264>;
>+				exit-latency-us = <621>;
>+				min-residency-us = <952>;
>+				local-timer-stop;
>+				idle-state-name = "power-down";
>+			};
>+
>+			C4_CPU_RPD: c4-rail-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000004>;
>+				entry-latency-us = <702>;
>+				exit-latency-us = <1061>;
>+				min-residency-us = <4488>;
>+				local-timer-stop;
>+				idle-state-name = "rail-power-down";
>+			};
>+
>+			CLUSTER_PD: cluster-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x400000F4>;
>+				entry-latency-us = <3263>;
>+				exit-latency-us = <6562>;
>+				min-residency-us = <9987>;
>+				local-timer-stop;
>+				idle-state-name = "cluster-power-down";
>+			};
>+		};
> 	};
>
> 	pmu {
>-- 
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>of the Code Aurora Forum, hosted by The Linux Foundation.
>
