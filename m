Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DDAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA61220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Neux7xUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfANKWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:22:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36170 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfANKWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:22:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so22176088wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8dAtUVNc/SrckVQO26IbIxKg4nf0RH/0OVrQbJ3H/go=;
        b=Neux7xUrwWoFXUZ7sVlRENjwWDvXD+6pnDNismmVjV6uSSqvJrw46OWS24nDJ2AePn
         y7oyCapNk6j8XZ0kCwI7CI+oxUaJTA4e7rmhf6/9xL4Yq7r6KubCv+6xcoG2PZ96k5oM
         tRSDtfOZtY2vTODgTdS0uw4hdtUN5FthqcDtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8dAtUVNc/SrckVQO26IbIxKg4nf0RH/0OVrQbJ3H/go=;
        b=W05gOVao/JCQ3GGEzY1x6dBH+9MijvMSU3+5pJ9esWYRLYol4TtHwH0+wC/OqX4MO0
         CbZ6iQiuMBPrqqP0wK8rZc+NEo155as6670V9bCHmUPYbcNkeztsb9l6qxQsY5jslL3E
         hpvXptrMNM1DSqtnjDJP6lKEb9mxXieHZm1nLxhw3/8A+5+Xvux74aY5253P1E2tSb5U
         Y7yzczsIQNF3p6CSIfcGHR8Ue3TaFSwpsXQS50W9Wru+fPlfwzA8LuDL2gSS8lHuzYCR
         65Ea/oUthX2u74M0c3tjGhYgpojWdfJaogju4NeGT0KI5XF6Uku9rsEC8qJHuZyjxo4O
         wtTg==
X-Gm-Message-State: AJcUukeZ3ZbWDPqnv0lvj6y7WQVF33Yg523gUlTHpTv5g/NqhzTKvpkb
        l9kLaS5G49UvgsFB+9NSCh5QTc4zZH0=
X-Google-Smtp-Source: ALg8bN4duYE/DVBOcjtSa9JTM1k8VOBoQhZ4+rbgDh4fgZQ1Ybd1gg/Mm3pdo9hn0Fye8mNlgmJeVA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr24501045wro.321.1547461320685;
        Mon, 14 Jan 2019 02:22:00 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id e27sm75831684wra.67.2019.01.14.02.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:22:00 -0800 (PST)
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
Subject: [PATCH v2 7/9] arm64: dts: sdm845: Increase alert trip point to 95 degrees
Date:   Mon, 14 Jan 2019 15:51:09 +0530
Message-Id: <bdd6ebf7910ac04e1255afa1330207d3a0911b72.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
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
index 0e659b0524ba..fb7da678b116 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1720,7 +1720,7 @@
 
 			trips {
 				cpu_alert0: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1741,7 +1741,7 @@
 
 			trips {
 				cpu_alert1: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1762,7 +1762,7 @@
 
 			trips {
 				cpu_alert2: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1783,7 +1783,7 @@
 
 			trips {
 				cpu_alert3: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1804,7 +1804,7 @@
 
 			trips {
 				cpu_alert4: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1825,7 +1825,7 @@
 
 			trips {
 				cpu_alert5: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1846,7 +1846,7 @@
 
 			trips {
 				cpu_alert6: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
@@ -1867,7 +1867,7 @@
 
 			trips {
 				cpu_alert7: trip0 {
-					temperature = <75000>;
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-- 
2.17.1

