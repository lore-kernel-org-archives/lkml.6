Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B169121773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZ031akI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfAJABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfAJABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so9517618wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KT2ssSeSRp8MbacDiLft/dMIIWaszjhGExCaeKpTFUw=;
        b=YZ031akIpYTDulu4BdbyinS4L8HN3Uud+/MTdtH55voTht2st1KnTRhTmxWUf9BY86
         6UjqTWRR/0E7NHV9aRFU6RCcRf9KdFiiGIlofqzvRj10EsCVEc3k98aNutcUCoNdD1ZS
         HkqET5909npbiiGDM9C3a/h3uA/F08DiNsS80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KT2ssSeSRp8MbacDiLft/dMIIWaszjhGExCaeKpTFUw=;
        b=aH3FOWabbg4MPv+5e2Q2JN114Xt5mpuhIr1miM2PQ8jQS0/Oj2TRbfygQ18PORorJ9
         AAATLVkIWhFGr8AlVg0sYaN/mMnDMeZ7XemafP4InkJ4hZEH2PZI9dlbDPBzF2T3ZW8G
         OZml5f30x6knrgHQ3HKutM9pdxy8Yz+a/vmn4vcqpgXOfI9WzM2SVoKluy37hjf5OpZG
         LL5Yh7ZUx0HXq9oeufMqlpo/K/BveoSLLkugTcMCYDs3Znd1ikx2OZjPPlqD73NGR6v2
         xSmiw58GHL6PmmG3i1JyboBTbaW91IRdaHOjwyeFiv5LmxFEsVxzJdcuShVhWpFJHhzB
         IXJQ==
X-Gm-Message-State: AJcUukdIkhNKM+b1dC09iFyG2IvMi4bmkfGfmJXhV8lyscgu4uN+WtiR
        agbYjDzxxnLIg8M9u5MZ6CGcePyt9PQ=
X-Google-Smtp-Source: ALg8bN42A70BQd6KkGyyt0ge8rR0Q1bNxqSBoAfgPcuVkio7HRfDI9P+odpmrCgJWXA23srcJB21nw==
X-Received: by 2002:adf:891a:: with SMTP id s26mr6733622wrs.44.1547078500604;
        Wed, 09 Jan 2019 16:01:40 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id g198sm21697553wmd.23.2019.01.09.16.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:40 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to 95 degrees
Date:   Thu, 10 Jan 2019 05:30:55 +0530
Message-Id: <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

75 degrees is too aggressive for throttling the CPU. After speaking to
Qualcomm engineers, increase it to 95 degrees.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..29e823b0caf4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1692,7 +1692,7 @@
 
 			trips {
 				cpu_alert0: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1713,7 +1713,7 @@
 
 			trips {
 				cpu_alert1: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1734,7 +1734,7 @@
 
 			trips {
 				cpu_alert2: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1755,7 +1755,7 @@
 
 			trips {
 				cpu_alert3: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1776,7 +1776,7 @@
 
 			trips {
 				cpu_alert4: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1797,7 +1797,7 @@
 
 			trips {
 				cpu_alert5: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1818,7 +1818,7 @@
 
 			trips {
 				cpu_alert6: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1839,7 +1839,7 @@
 
 			trips {
 				cpu_alert7: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-- 
2.17.1

