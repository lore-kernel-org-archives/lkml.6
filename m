Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C02C282D0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB90A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9vc9C12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfA1Sdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:33:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41573 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfA1Sdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so19199004wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jwkKlS341j7fyk95QNvo70XMLCAjNUCF7cHyyXT/yc=;
        b=I9vc9C123OGGrDPTEKb5TUh/XNiAw4yOfrCyECVMnCLNqO9xZI5rx/Z6EAJpySXVEt
         xDwDN/UvvPHwcg1qG1Isdt7DytmzEJEQ6U8ew76/GlCl7yThh6ae2lefENgeb8ucGlZt
         j7YQ1Z3CclpMfyTSM8r8Mj6GPj7DUjfRMOoDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jwkKlS341j7fyk95QNvo70XMLCAjNUCF7cHyyXT/yc=;
        b=MxCgDitvQiGbAVHJYagakuUqSoU/9LJ8z3mlQpSGxCB3U5jYXFz2AslHR4GnBVhudi
         oL2vOYZt5sUsJsxhrZtNg79RPKML5s9yYd6mchZQzQlT6hFnjG9A1eJGIwdfbC5kAIFo
         lCoExpZUsoWPUPdGEVG2CIFnnK2c9kYRxfopQRI8rDDxWR+R5tB7qI82P04NNv+kDP1h
         wILrqXohopRopvA7RLylWpDbOJjbBsaTAZuRJTfmMWPtWQcDvOw3ivNMGTtlNbhIpC8x
         5eIC3gLcqIO1f/wnkIXQ4ZR/SchCV029mXmltFuPeQAfTn71ePwPiEhJyoJ3h5KsCgNL
         Fzew==
X-Gm-Message-State: AJcUukeMLWEyzVSLsPAZ7MG1wnv/Elt13dZOtv8HDX6EKu74brdYAePK
        na+mCfiBma7rfk+5GJJ35v87fMLAHxc=
X-Google-Smtp-Source: ALg8bN4ANPmpripSYqtVHClOsBGDkEBMMr4PV/AL/gsrTDBadsPwLHr9Ee1OKnOCk6NaYkvg8yFXLQ==
X-Received: by 2002:adf:9521:: with SMTP id 30mr21617095wrs.192.1548700419861;
        Mon, 28 Jan 2019 10:33:39 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:39 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v2 13/14] arm64: dts: qcom: qcs404: Add cpufreq support
Date:   Mon, 28 Jan 2019 19:33:00 +0100
Message-Id: <1548700381-22376-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support CPU frequency scaling on qcs404.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 948ba3c..a0f58bf 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -30,6 +30,8 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU1: cpu@101 {
@@ -38,6 +40,8 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU2: cpu@102 {
@@ -46,6 +50,8 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU3: cpu@103 {
@@ -54,6 +60,8 @@
 			reg = <0x103>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		L2_0: l2-cache {
-- 
2.7.4

