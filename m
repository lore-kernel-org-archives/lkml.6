Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DEBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1929920989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="TXCFJnDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1929920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeK1BH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:07:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46290 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeK1BH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:07:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so19053437edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7VSz57nUqDMmDPEyDsdeLB0RSfnPmbsNu7//avC1qTg=;
        b=TXCFJnDyoyCPnMF/PR4JElzZte+nXzwieLTl3GuW0OonU/LKRk8WXq2o04W0V4IWn+
         u9pZ0TS030IVPB+lmhobAEACAQQP04uskh5EzNMNaS7AuPLZ7tWD96jYDTpxTIyZHfAj
         nqo/gR4RNj/Dg+52WY6lmleXsqpiR0FMkNdHpvjcjqf0hkwH6YzQT111rY/kY5MeBcqO
         n16D1ni0wBjt2MWVeO39FOXeE4H4nwbmBF6Moth2JSdsAo2FKzC8+mjoEHfIBtT8vjdx
         ar/QYHu3nRFiUKevU0cm+ENoUpuB25Ww9GBEJ70GWcjcD3Ow+0o5xiv0uukxvj0WRfe8
         9I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7VSz57nUqDMmDPEyDsdeLB0RSfnPmbsNu7//avC1qTg=;
        b=Qwjcsl9/4hW047xZ01q2Z8xSo+rvX9i3jtYKYDU5O3qTIZ6y7EOuIyB6NyeirJ/WVz
         W5pazQZuVX9aEAstrh67NwxqzeAL7tsBcaEI68I9I+grzBJQUjOWgj0i+ve2cbLtnlvu
         ou3hBuSxitUNvVlwSKVC+zNQmT/J4CSfJ2udmmzLOJGrLMVPiLeo4VxvvPjo+/Qgcha2
         9MFqeWqszediII/FrQ5bQt70oClxFxLaq9sCNvoUkhUusixO0ukkYYwF8iXXFv+o3sMP
         h7ISj5FXprYefz1YCxG/rd6/mVBm/3Vd6gEASGggbyVnGZ2wDFfDzAWYczKUAkdzdWWq
         UPiQ==
X-Gm-Message-State: AGRZ1gKUAMencWZ/QO7vxEctfV446LAbv/KWuSkBqU3Ir/dbHyO+b5mj
        BYWzbCD/mfEICuaLyy7P+7wVDg==
X-Google-Smtp-Source: AJdET5dEbxJiNBVm6qvd3W8X2V8CVV/xuv7JHMktmN922Vkb6x9F7nqWh68WewCAw/3PH3AL4x9ffg==
X-Received: by 2002:a17:906:22ca:: with SMTP id q10-v6mr23715876eja.66.1543327793808;
        Tue, 27 Nov 2018 06:09:53 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id z2sm1021147edd.4.2018.11.27.06.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 06:09:53 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Cc:     matthew.weber@rockwellcollins.com,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] ARM: dts: ls1021a: add nodes for PWMs
Date:   Tue, 27 Nov 2018 15:09:44 +0100
Message-Id: <20181127140944.31018-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1021A has 8 possible PWMs, so adding them (disabled by default)

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 96 ++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..d3014da9a66b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -525,6 +525,102 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm@29d0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm1: pwm@29e0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm2: pwm@29f0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm3: pwm@2a00000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm4: pwm@2a10000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a10000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm5: pwm@2a20000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a20000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm6: pwm@2a30000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a30000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm7: pwm@2a40000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a40000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
 		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-- 
2.17.1

