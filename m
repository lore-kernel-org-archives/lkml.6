Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E4821773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nba7jT/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfBRMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbfBRMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so17116466wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6+W3iADusyRfZQaowMEUR2yQLdWrhLi0wktJVeymUWU=;
        b=nba7jT/2dh0/2lkbHb5+MNePevskH+gCETyXV2ryNqikCOV2wUBPeAyOt/sy/Q5fvM
         H7iwsRNNsmRt4YtJHc0o07GEv0i3d36UC75ra6/Odz2HXxaP+A6RTFqrDtChCbk8emlZ
         ayKylLJGN922b4L22tFYkNMyXgVilV56P/r4lgktbEtWDSii9GJ+nPGwSElEf3sQLDB7
         FiiHlmvkNViic5FL50nb7Ev9Fq1hNhz6VmvFAu6sc325EuWHxi5JZna2dL0IuTaKDwv5
         uQC0nzZb71ed3+tKf8Ql6Tu9dnme7g71dEUpDDXmf5hQBKkaizY3nBE+r09qvXrkwSYl
         P8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6+W3iADusyRfZQaowMEUR2yQLdWrhLi0wktJVeymUWU=;
        b=FGH4H9WAzjwnSjIatKzoWJjOpk5dvvkqeusG7mL2Ccwd9cOGRwvjT1vA1jG8ikEuCA
         7zigazDsfKKz0axa4qMDleC4n7McuBVT0nCOanxyGHuf9BV3e8HvMJ5zaAlfNFRW3YlE
         +5QITK2G8jS0/3bB2rWd8VRYh6ZVNpgyYUqj3JLwU0AcxKZB1esqCFvbcF5oQaWvsafB
         DOWu3liNTrgoEpMcXH14zYx3ha+nOV5Cmvx5Af8hoIFX7ZRVngJvDUkvvP2h75eAU8vz
         xnxiKpcZCCQ264OwZ7OZdFqSivVkvLgc8XSqBP0KFAHD/v8CnZMYFPq5+P46vjcwVak2
         hMFQ==
X-Gm-Message-State: AHQUAua/bfOPL9xvW9/kGgy32TFPQp/h1zuMUf0BBNdp27SPRx8FwrVP
        dA2EuF23sab2/jaQ6zTVp82iVPe7jNs=
X-Google-Smtp-Source: AHgI3IYu12a7hlVDhkntklRnTWH11631L8Z3lwPe66fxPvTXzQe525Fb6qdJgG+sps6VAUcgapvP2g==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr10341068wmc.35.1550493366716;
        Mon, 18 Feb 2019 04:36:06 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id c65sm19504082wma.24.2019.02.18.04.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:06 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 05/12] arm64: dts: msm8998: thermal: Fix the cpu sensor numbers
Date:   Mon, 18 Feb 2019 18:05:19 +0530
Message-Id: <bbedd3634138517914449e5a488c38047aaa2fd0.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The silver cluster (typically cpu0-3) are monitored by sensor IDs 1-3 on
tsens controller 0. The gold cluster (typically cpu4-7) are monitored by
sensor IDs 7-10 on tsens controller 0.

Fixes: 4449b6f248d9a1 ("arm64: dts: qcom: msm8998: Add tsens and thermal-zones")
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index db4cb687126b..662ca458e64a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -336,7 +336,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 6>;
+			thermal-sensors = <&tsens0 1>;
 
 			trips {
 				cpu_alert0: trip0 {
@@ -357,7 +357,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 7>;
+			thermal-sensors = <&tsens0 2>;
 
 			trips {
 				cpu_alert1: trip0 {
@@ -378,7 +378,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 8>;
+			thermal-sensors = <&tsens0 3>;
 
 			trips {
 				cpu_alert2: trip0 {
@@ -399,7 +399,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 9>;
+			thermal-sensors = <&tsens0 4>;
 
 			trips {
 				cpu_alert3: trip0 {
@@ -420,7 +420,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 10>;
+			thermal-sensors = <&tsens0 7>;
 
 			trips {
 				cpu_alert4: trip0 {
@@ -441,7 +441,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 11>;
+			thermal-sensors = <&tsens0 8>;
 
 			trips {
 				cpu_alert5: trip0 {
@@ -462,7 +462,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens1 0>;
+			thermal-sensors = <&tsens0 9>;
 
 			trips {
 				cpu_alert6: trip0 {
@@ -483,7 +483,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens1 1>;
+			thermal-sensors = <&tsens0 10>;
 
 			trips {
 				cpu_alert7: trip0 {
-- 
2.17.1

