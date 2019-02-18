Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FD3217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIV8R5Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfBRMfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:35:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40645 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbfBRMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:35:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so8823426wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WHupAdGbaNN2KhrY3MhcPLqYgu11iPdgxPXK+ZNis4g=;
        b=rIV8R5Ae85ZTcMkMayu3fDcccmS7xZlTk6Qoq21ea3D+uUqqH7mDdyXwCUblPfnNqJ
         fYgrvSkVDtt03GHPDjkgBNk0qR8H52Jq3UZE+gzld5xiCXM7B4x633bsjtB1NNEvrmvI
         Rr50+1WblvHyPr4k7Q7vpxmt6MZ7k0Xcf3g/RpEJ70FdAEcyVLS9ygbNycKzRg7SkTk7
         prSeYjOfcy+v9Z6Vy+PqlLYiuHiYPwU1NH/nAhxUH5wIAaGAkVdrlinPT+ebrU3ByuQ1
         uuFhGzPYzyaKgQrNAk7hgW4XsYXxQ4hyynfc0684Hh6t/xjvLpT8VLs9jsWDeD/7I7vZ
         n0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WHupAdGbaNN2KhrY3MhcPLqYgu11iPdgxPXK+ZNis4g=;
        b=l2LVY15gWLvtFGpoxBPrTQAJuEyjkVE2s5v3kLqTbZn08ZPjcCF+RuZ2iM9zmkq1vI
         1uZtqSjd+A5l04msGkErSeJQm+yrvPUupDA46iPVlyHiLxZFZtyiVDTE5ZIhHRDK6Jd7
         EasTvkjdWd0QLfaDJUpyLks9Oy4hW+Vxhf7k8gv89cmO0e9y+ReVUuLCVRcMINp3XNdn
         fg+4Se0ZoNxyj73rQwiYZK3BNUcNYTqTegLphCni3uJqj64fRz/w1yoNICDkS09m8v0j
         /NH8dgy8x/RWOBLQzAJGSSJiGHknUIYfcGKQJ+6ydaMIi+ttrRFZPZs8+GnJ8vmxD15V
         uB7w==
X-Gm-Message-State: AHQUAuZpvCWAOhAVHyjcFvesu5ZwiLRbcW/S5BxjpYklF05o4E+IO52O
        61JY5MEw1pZWliW0ldCcy6X86FKFGUg=
X-Google-Smtp-Source: AHgI3Ia7OAaNxXnCH1KcWO1x7aNjUpeb1LU2SuE47A2eFi8OcstQMo57otPryCLSq2A8qct0dPFthA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr16101695wme.73.1550493348804;
        Mon, 18 Feb 2019 04:35:48 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id o7sm9766816wmc.13.2019.02.18.04.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:35:48 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 02/12] arm64: dts: msm8998: efficiency is not valid property
Date:   Mon, 18 Feb 2019 18:05:16 +0530
Message-Id: <bd63da47d92b9bbf942c9bc854d7bafcd3a0a87c.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efficiency comes from downstream. The valid upstream property is
capacity-dmips-mhz but until we can come up with those numbers, remove
this property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3c5fb2509d5f..db4cb687126b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -77,7 +77,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "arm,arch-cache";
@@ -96,7 +95,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L1_I_1: l1-icache {
 				compatible = "arm,arch-cache";
@@ -111,7 +109,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L1_I_2: l1-icache {
 				compatible = "arm,arch-cache";
@@ -126,7 +123,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L1_I_3: l1-icache {
 				compatible = "arm,arch-cache";
@@ -141,7 +137,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				compatible = "arm,arch-cache";
@@ -160,7 +155,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L1_I_101: l1-icache {
 				compatible = "arm,arch-cache";
@@ -175,7 +169,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L1_I_102: l1-icache {
 				compatible = "arm,arch-cache";
@@ -190,7 +183,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L1_I_103: l1-icache {
 				compatible = "arm,arch-cache";
-- 
2.17.1

