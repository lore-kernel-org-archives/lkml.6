Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71007C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E26B217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoJRxte5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbeLQJrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36245 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732223AbeLQJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:47:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so10567223wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=trBOZeUZ42tXHraYvTz2rphVlhKTWLVThNKSv6QZHLQ=;
        b=FoJRxte5GxIjPmcVqIEkGM+x/BCDOU1h6ZYf63+VJDb0xLs7ryQZiUSVsBlpThKX4v
         PfyLuqhwQ6UN1N4rbF/rM5NLdCLQ6rat3x8M7claAyBkDAxKuY9R6FhHE2KAhflZaF1D
         6sPl5ernAuDWw9WtWPeZVPzpwnpQ/nYk27+hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=trBOZeUZ42tXHraYvTz2rphVlhKTWLVThNKSv6QZHLQ=;
        b=VPlAuZNt/vc2xS2QT5IanQh0yKyk3JhV5/TEtycISkcd/dFED3i6XOmTW3H/wySWwO
         83ZiNVIi1DPc8tJVIGDgoa/qOExpv5br2GGo5NX9FNSi/EFQwTi0X4rj39eLxg63TKXt
         HkziKF5SUXrp+RQlcihjA3d4pbno9pmJAMYt2Hs19l0+IxfhRfU+1y8+/MlRC1TMqtyF
         OVZexxXrJE6OcaOA66VzkUzMkRcwuKRg0WqEjvQKJzLuhp+LmsRL2GwHTPbmgUiG50p/
         2StYx0BCHIaWhx2HqUwEbAeSuP6BRvNWBYVCxitw4Fmeek8u7+yNXP3Sl65I7WQtwIVC
         LEFw==
X-Gm-Message-State: AA+aEWZjswvdcghWq+fVm6u89ocCgBMRYngNn2Ft03f32zt2K6BjT77K
        opLBVZLkh4d7X4AaqN3rbjs6Pw==
X-Google-Smtp-Source: AFSGD/UzwOvBjMk5OAnuhTgTLtekacbChin6HSwst6mWBMEinLXT29f0XoEfR9M5MgMwW7wd8+Vh2g==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr9993063wrq.15.1545040019026;
        Mon, 17 Dec 2018 01:46:59 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:58 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 12/13] arm64: dts: qcom: qcs404: Add cpufreq support
Date:   Mon, 17 Dec 2018 10:46:29 +0100
Message-Id: <1545039990-19984-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
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
index 2d9e70e..5a14887 100644
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

