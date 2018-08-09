Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E1CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E886621E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCR4i49B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E886621E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbeHIO6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:58:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34629 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbeHIO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:58:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so2516177plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P+8ZtXuBWeWo7/benGwezLj8nb3RsvbE1i3tK4LtIoc=;
        b=NCR4i49BGPwZ1Q345daLUuAdEIFBSZxRMTGevcSNH4M3yoq7mZWk1n9NIZLDrs/2pi
         vC2bPFG7w/ew0jpC+2tofjKhi6NBX4okIct1aSQNuTaI6WHRiPp+SyDd7ABFVZazN66Z
         bAXyvpQ74ya1J7OyLCOVh1J8z3c//t00wJiQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=P+8ZtXuBWeWo7/benGwezLj8nb3RsvbE1i3tK4LtIoc=;
        b=axSocu8ixArlERmpbDKYUDs2FfsLPIPkQlxYQDuHJAHD6CSlzUYb+onbnnYmiH4Q1N
         v2a5jb1kIGuA74/rHm1aLmS581U8EoVMZRT+W22qWF0pDRn3uq4RkdSczvjZtyVN+d4N
         AOcBnJNoivgyjxvpeUgTGEsF8F6B6Ik5CHXECFG+DXlr4CI2bLSHxzlmtNFY//HqoPQ/
         2UoXeU/NahaJyyNaaMjA8b9MvS5PTQ7nLI+155yhOzVnxsZiZQgBcun2We2IXXP+rnCX
         kxzRM0ER256PyB3+1k2Qgmha6VP2Bbx7kPur2O7brgBgbmrlOthE01/Lo/1R9eTawKCd
         yT6g==
X-Gm-Message-State: AOUpUlHeMDtdhbvTB7ysVYHIsZ6omVNoCdtp7GRncf5IywEBvrnVow82
        gu2TxttRrfk1jExi7PGIOkyhcW73mN4=
X-Google-Smtp-Source: AA+uWPygMCHE5JmIkTKVtQd6NnfXQJX7K8kxxw5k5vpscXyu5R9508aKzMEOoHPRsXEIt4uWIenY7w==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr1913890plb.172.1533818007813;
        Thu, 09 Aug 2018 05:33:27 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id f65-v6sm23210298pfj.46.2018.08.09.05.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 09/10] arm64: dts: qcom: Add reg-names for all tsens nodes
Date:   Thu,  9 Aug 2018 18:02:41 +0530
Message-Id: <188c07144d98bfbe2bbbb7d1f2941acdcf4e6682.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of showing up as thermal-sensor@<addr>, the nodes will show up as
tsens0_tm, tsen1_tm, tsens1_srot, etc. in /proc/iomem making it easier to
read.

IOW,

0c222000-0c2221fe : thermal-sensor@c263000
0c223000-0c2231fe : thermal-sensor@c265000
0c263000-0c2631fe : thermal-sensor@c263000
0c265000-0c2651fe : thermal-sensor@c265000

becomes

0c222000-0c2221fe : tsens0_srot
0c223000-0c2231fe : tsens1_srot
0c263000-0c2631fe : tsens0_tm
0c265000-0c2651fe : tsens1_tm

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 3c4b81c29798..64c9f81ddd90 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -431,6 +431,7 @@
 			compatible = "qcom,msm8974-tsens";
 			reg = <0xfc4a9000 0x1000>, /* TM */
 			      <0xfc4a8000 0x1000>; /* SROT */
+			reg-names = "tsens_tm", "tsens_srot";
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#qcom,sensors = <11>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index abf84df5a7bc..4e6a5e462a91 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -778,6 +778,7 @@
 			compatible = "qcom,msm8916-tsens";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
+			reg-names = "tsens_tm", "tsens_srot";
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#qcom,sensors = <5>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c2dca3a30091..7e5982daa2ed 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -969,6 +969,7 @@
 			compatible = "qcom,msm8996-tsens";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
+			reg-names = "tsens0_tm", "tsens0_srot";
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -977,6 +978,7 @@
 			compatible = "qcom,msm8996-tsens";
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
+			reg-names = "tsens1_tm", "tsens1_srot";
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f722785df26b..efd5d7abd1cd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1531,6 +1531,7 @@
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
 			      <0xc222000 0x1ff>; /* SROT */
+			reg-names = "tsens0_tm", "tsens0_srot";
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -1539,6 +1540,7 @@
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc265000 0x1ff>, /* TM */
 			      <0xc223000 0x1ff>; /* SROT */
+			reg-names = "tsens1_tm", "tsens1_srot";
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
-- 
2.17.1

