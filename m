Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0723F96
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOBajPh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE0723F96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeGFG5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:57:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51618 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbeGFG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:57:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so13792331wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GnW9KL3F3VgyX6Arpx94FfMZtNa5kkrbUdJqLVmrorg=;
        b=SOBajPh9DpisEvF6b2H2LEOJgGRfLXdGy32dgFYcGlg3RsCFfCvVLR2xAZ8vrG9FZP
         zD3pqFwDZy67rpZ7gT0hoWqxc1BkzTrO//+m285j+Z28y31QKfXWPtjvZNhVZOlq4NTZ
         meIppILQLWCmk4dFB47QqtZe68Bkq9zhPl8t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GnW9KL3F3VgyX6Arpx94FfMZtNa5kkrbUdJqLVmrorg=;
        b=HyfqiKfwKHVxKeFgUme6/OILLVdkT6bBAs1qUhMlX8RzD2+QAf8FJjXQCss8nuTQxa
         AQv7n9A+l0cIUpHCV/RUIhvpNr2uPoRlwUzsisSEs+QuPiR8FaW5LVDgxzQ2ExcnPmj7
         ZCp7jfyFtDd7I2PQ55tOT/kmQ3YELvtzTBvRvPftL5Ibp0AJKTFJXxNtP3sWz2XFKCdW
         6xShLiFn3RR+sbjnAi0S+QmdaSMMOW0OC1VZrn51+Yk6dHmLsCXdd9Em0+J4epxGR5hA
         vI/diO6VpXg98/oKVFl2lk7miyI/ENhKCd2/gOxwo0Ecb5OAdQtho+tjj6wIzfRmy2tM
         GvxQ==
X-Gm-Message-State: APt69E3J+laqSwCYTSPE2dBke/g5htWW9sAdRzb1n398i1V6zQK/oggZ
        jkWGVcvvfquU/ME9vu/tcm8u2Ywl4pg=
X-Google-Smtp-Source: AAOMgpeSHNJNsv1aghSzfyvFA/ZzyntPYtRdJZCG0/0GaRvKdXUU71haWPLXNAdrVftbvGVyuGzYfg==
X-Received: by 2002:a1c:b8d2:: with SMTP id i201-v6mr5272283wmf.158.1530860250023;
        Thu, 05 Jul 2018 23:57:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a41c:a3ee:84e4:bb78])
        by smtp.gmail.com with ESMTPSA id g4-v6sm6183432wrq.32.2018.07.05.23.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 23:57:29 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leo.yan@linaro.org, daniel.lezcano@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] arm64: hikey960: update idle-states
Date:   Fri,  6 Jul 2018 08:57:26 +0200
Message-Id: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update entry/exit latency and residency time of hikey960 to use more
realistic figures based on unitary tests done on the platform.

The complete results (in us) :
                  big cluster
                  cluster  CPU
max entry latency     800  400
max exit latency     2900  550
residency  903Mhz    5000 1500
residency 2363Mhz       0 1500

                  little cluster
                  cluster  CPU
max entry latency     500  400
max exit latency     1600  650
residency  533Mhz    8000 4500
residency 1844Mhz       0 1500

We can see that the residency time depends of the running OPP which is not
handled for now. Then we also have to take into account the constraint of
a residency time shorter than the tick to get full advantage of idle loop
reordering(tick is stopped if idle duration is higher than tick period).
Finally the selected residency value are :
                 big cluster
                  cluster  CPU
residency            3700 1500

                  little cluster
                  cluster  CPU
residency            3500 1500

A simple test with a task waking up every 11,111ms shows improvement:
- 5% a lowest OPP
- 22% at highest OPP

The period has been chosen:
- to be shorter than old cluster residency time and longer than new
residency time od cluster off C-state
- to prevent any sync with tick (4ms) when running tests that can add
some variances between tests

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 45 ++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 421d454..890d23e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -61,7 +61,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
@@ -75,7 +75,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
@@ -87,7 +87,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
@@ -99,7 +99,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
@@ -111,7 +111,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
+			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
@@ -125,7 +125,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
+			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
@@ -137,7 +137,7 @@
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
+			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
@@ -149,7 +149,7 @@
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
+			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
@@ -158,31 +158,40 @@
 		idle-states {
 			entry-method = "psci";
 
-			CPU_SLEEP: cpu-sleep {
+			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
 				local-timer-stop;
 				arm,psci-suspend-param = <0x0010000>;
-				entry-latency-us = <40>;
-				exit-latency-us = <70>;
-				min-residency-us = <3000>;
+				entry-latency-us = <400>;
+				exit-latency-us = <650>;
+				min-residency-us = <1500>;
 			};
-
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "arm,idle-state";
 				local-timer-stop;
 				arm,psci-suspend-param = <0x1010000>;
 				entry-latency-us = <500>;
-				exit-latency-us = <5000>;
-				min-residency-us = <20000>;
+				exit-latency-us = <1600>;
+				min-residency-us = <3500>;
+			};
+
+
+			CPU_SLEEP_1: cpu-sleep-1 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <400>;
+				exit-latency-us = <550>;
+				min-residency-us = <1500>;
 			};
 
 			CLUSTER_SLEEP_1: cluster-sleep-1 {
 				compatible = "arm,idle-state";
 				local-timer-stop;
 				arm,psci-suspend-param = <0x1010000>;
-				entry-latency-us = <1000>;
-				exit-latency-us = <5000>;
-				min-residency-us = <20000>;
+				entry-latency-us = <800>;
+				exit-latency-us = <2900>;
+				min-residency-us = <3500>;
 			};
 		};
 
-- 
2.7.4

