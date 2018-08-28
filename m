Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6940EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7DA20867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtaQQKn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7DA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeH1Rbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40740 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeH1Rbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so1397626edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FWtE2KHAkIFSXULL6Im8GoFyV1IDELD6oCaUTCMaqb0=;
        b=TtaQQKn6E5T7uiOcfEEX2wR9pnXW3yLleJRbxUGSNtR47cytkF9HTdC2ARR5luJsYz
         4inSqj/mFFEz13Q9FteyGEIx3caxj2oaPnyYDBOFwCzKG1FFNsBGw71GlilL8Ipvdv6S
         kOTsFgps83r6fnn7dgSzfkchVVkeqf86ufWe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FWtE2KHAkIFSXULL6Im8GoFyV1IDELD6oCaUTCMaqb0=;
        b=RY4KZl3L0EtBpemwNklT9kLCaAxuH7d7PpsGGQKEI7XQSsyaozcynUmd90toQMQVzN
         8FiskdsjsMn97DiACTAeN+z0iChpFDX7XrTqVq/VcH2AQAp2tUsaFYJh19jxsnpSmXmu
         arFmadHjtGYtW1mVfkFTK6eSEDwrIM0IZHzZklofIDGyHd2/d5yoNFsXat3RiP4qhQN/
         rmRoVex9K9yRJvUE+SV0cxmrPLrDdCQzpUqT7ffisbKFCCBBdCdA0eP4B542zs3j0SED
         kKgjRXgtXedmF3ODrx6NoWnmwt1JppC+UXKLISffMBByhgJjZ1v1YmEjgU7kXxjlhRI/
         pg6Q==
X-Gm-Message-State: APzg51CyYNXggSj+TOO5+3Kq4pI1n7X/AiilkO5q6VI5HZEIDTbnNrkP
        ZipOlspkzNfyxXLvr1IfrnLEmWwhgcA=
X-Google-Smtp-Source: ANB0VdbSA76KqaoZCT4NGgdQxrGJHdT8VP5m2TG4W4e78lNu9ZRNrcHcjND5CCLJYaLR3S5+VPiDpQ==
X-Received: by 2002:a50:9aa4:: with SMTP id p33-v6mr2525342edb.156.1535463600983;
        Tue, 28 Aug 2018 06:40:00 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id v1-v6sm556567edf.3.2018.08.28.06.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:40:00 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 10/11] arm64: dts: qcom: Add reg-names for all tsens nodes
Date:   Tue, 28 Aug 2018 19:08:39 +0530
Message-Id: <c49d9f13b3d6849604ae3eb00a92b80948ef1534.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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
index be27d8dc9e6b..c172731625f3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -765,6 +765,7 @@
 			compatible = "qcom,msm8916-tsens";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
+			reg-names = "tsens_tm", "tsens_srot";
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#qcom,sensors = <5>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cd3865e7a270..ac1d30006e6a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -381,6 +381,7 @@
 			compatible = "qcom,msm8996-tsens";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
+			reg-names = "tsens0_tm", "tsens0_srot";
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -389,6 +390,7 @@
 			compatible = "qcom,msm8996-tsens";
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
+			reg-names = "tsens1_tm", "tsens1_srot";
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa6a1b5..f1a36d6829cf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -966,6 +966,7 @@
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
 			      <0xc222000 0x1ff>; /* SROT */
+			reg-names = "tsens0_tm", "tsens0_srot";
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -974,6 +975,7 @@
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc265000 0x1ff>, /* TM */
 			      <0xc223000 0x1ff>; /* SROT */
+			reg-names = "tsens1_tm", "tsens1_srot";
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
-- 
2.17.1

