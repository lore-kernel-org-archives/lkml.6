Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6297ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35BE2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NxViLa2A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fe4rvQCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35BE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeJTDzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:55:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeJTDzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:55:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 773A460227; Fri, 19 Oct 2018 19:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539978485;
        bh=tzHvyWRsy1gFGjmfEpLLSS10BjK0trEumcoYifNWtNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxViLa2A+UMvXYQRBpXdlzm2bHh/O9/mshdHX/6+LsecBbe2Kd8HIinN5izVT4jrP
         tB5Y0oyu+zG8VNMqjXHkJTPpwIDX1FcrCgJ+Ue2DuwNa/kNj8rgJe+d/0KhJkiUMyX
         6EMjtJG623NaSxNgq5iTo+gytaIWB5qtcOu0pxkQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ACF86034D;
        Fri, 19 Oct 2018 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539978484;
        bh=tzHvyWRsy1gFGjmfEpLLSS10BjK0trEumcoYifNWtNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fe4rvQCz7QWBwRG3iOo+PSTULoa9Mo1qb+I1lIQ8sgYju3XQYZgYQFRtmY37qGkYK
         ywgKXQ3C5kGGvn9iHWlO+vtb7eA1M8US3dhSNh1Om+rr5OOdUSYL2nBKBufuXf4mC0
         w/k4fVSXYBWtryf/MAW4T+ynMt9qjZLMu0DIOQjs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ACF86034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 19 Oct 2018 13:48:03 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
Message-ID: <20181019194803.GC17444@codeaurora.org>
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15 2018 at 11:02 -0600, Raju P.L.S.S.S.N wrote:
>Add device bindings for cpuidle states for cpu devices.
>
>Cc: <devicetree@vger.kernel.org>
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>---
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

> arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index 0c9a2aa..32262b0 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>@@ -96,6 +96,7 @@
> 			reg = <0x0 0x0>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_0>;
>+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
> 			L2_0: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -111,6 +112,7 @@
> 			reg = <0x0 0x100>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_100>;
>+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
> 			L2_100: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -123,6 +125,7 @@
> 			reg = <0x0 0x200>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_200>;
>+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
> 			L2_200: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -135,6 +138,7 @@
> 			reg = <0x0 0x300>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_300>;
>+			cpu-idle-states = <&C0_CPU_SPC &C0_CPU_PC &CLUSTER_PC>;
> 			L2_300: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -147,6 +151,7 @@
> 			reg = <0x0 0x400>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_400>;
>+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
> 			L2_400: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -159,6 +164,7 @@
> 			reg = <0x0 0x500>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_500>;
>+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
> 			L2_500: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -171,6 +177,7 @@
> 			reg = <0x0 0x600>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_600>;
>+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
> 			L2_600: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -183,11 +190,66 @@
> 			reg = <0x0 0x700>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_700>;
>+			cpu-idle-states = <&C4_CPU_SPC &C4_CPU_PC &CLUSTER_PC>;
> 			L2_700: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
> 			};
> 		};
>+
>+		idle-states {
>+			entry-method = "psci";
>+
>+			C0_CPU_SPC: c0_spc {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000003>;
>+				entry-latency-us = <350>;
>+				exit-latency-us = <461>;
>+				min-residency-us = <1890>;
>+				local-timer-stop;
>+				idle-state-name = "pc";
>+			};
>+
>+			C0_CPU_PC: c0_pc {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000004>;
>+				entry-latency-us = <360>;
>+				exit-latency-us = <531>;
>+				min-residency-us = <3934>;
>+				local-timer-stop;
>+				idle-state-name = "rail pc";
>+			};
>+
>+			C4_CPU_SPC: c4_spc {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000003>;
>+				entry-latency-us = <264>;
>+				exit-latency-us = <621>;
>+				min-residency-us = <952>;
>+				local-timer-stop;
>+				idle-state-name = "pc";
>+			};
>+
>+			C4_CPU_PC: c4_pc {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000004>;
>+				entry-latency-us = <702>;
>+				exit-latency-us = <1061>;
>+				min-residency-us = <4488>;
>+				local-timer-stop;
>+				idle-state-name = "rail pc";
>+			};
>+
>+			CLUSTER_PC: cluster_pc {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x400000F4>;
>+				entry-latency-us = <3263>;
>+				exit-latency-us = <6562>;
>+				min-residency-us = <9987>;
>+				local-timer-stop;
>+				idle-state-name = "cluster pc";
>+			};
>+		};
> 	};
>
> 	pmu {
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>of the Code Aurora Forum, hosted by The Linux Foundation.
>
