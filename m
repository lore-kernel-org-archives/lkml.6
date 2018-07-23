Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50ACC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047C20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esRV64x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6047C20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeGWEFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:05:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45612 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbeGWEFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:05:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id 94-v6so7605752ple.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IN5o1a/MR10AYDmv1CeefaHwvyUbJkVcoUSVobDTOvY=;
        b=esRV64x/mvP4nCgS0gMM0Cbypt4nS8+gKdsJ1dO/MPHdGQ6f2Lk81Npj8L8HZAdc1c
         6kGOlh3XcH94KZTAUnTqhU3LI8TasnnN2Qg74U2Ipoz7IhLEVyQ8gSxZQHyHqEYNJEyd
         nuqrPe4+R+sT9ZT59/orGkHzmw1Ruh3Dv6lcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IN5o1a/MR10AYDmv1CeefaHwvyUbJkVcoUSVobDTOvY=;
        b=tX1sac7Il7Nob8/Kc5Q0HFHd1J+lDxK4tyz181hK6mXVXf+8uhSGKc4CtX9aPV7TBM
         EwusQP8BgD+LiRMrVF0mt5iHcMBQA8Xfps+ACN5Bc4dgaXgiSkZJHigU8bB/OT6WBqmq
         ZjgDJquiHoVNDvG4oFgJPSCcqR7zD3LML0QVTenR0Zne/4ZD3eABOR5mM9stHdevhzdS
         oBA609kRTIsyjJKD+ePc0ctt/JVWLf6sUJQCdW77DVYieaLVLEEV/Z0+8gHArKbd2SoX
         qmxMlSuIj2o/ZfJKXxHyHU8Fhgj84taAh+7qHmWjo8tayP0jLjY9q16d6GtTTBmuEmAF
         /EMw==
X-Gm-Message-State: AOUpUlFS2Gn17/YeaT5kLy1IsF6h5SHmH9fgelHh3Opq5VmiCYgsrtge
        YE/6TsCmYG36+VPDeomJ0FlgfQ==
X-Google-Smtp-Source: AAOMgpdX57PXt/0exz6wwt6ERA+LMBBHn6c5hy3bJ+xgrkEZ/zL0s4/gPL3uJGQR9jM+5H4MpUEVvQ==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr11326905plb.80.1532315213661;
        Sun, 22 Jul 2018 20:06:53 -0700 (PDT)
Received: from localhost ([122.172.26.112])
        by smtp.gmail.com with ESMTPSA id f5-v6sm13092634pgn.34.2018.07.22.20.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:06:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hisilicon: Add missing clocks property for CPUs
Date:   Mon, 23 Jul 2018 08:36:42 +0530
Message-Id: <6de0dde994326b3fdc2b746e22fdf1afe18067d2.1532315177.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks property should either be present for all the CPUs of a
cluster or none. If these are present only for a subset of CPUs of a
cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add missing clocks property.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 919d36b91bf3..aec9e371c2a7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -99,6 +99,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER0_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -111,6 +112,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER0_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -123,6 +125,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER0_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -135,6 +138,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER1_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -147,6 +151,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER1_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -159,6 +164,7 @@
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER1_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -171,6 +177,7 @@
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			next-level-cache = <&CLUSTER1_L2>;
+			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
-- 
2.18.0.rc1.242.g61856ae69a2c

