Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997D0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6384D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLb6mu5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfA2XUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:20:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43674 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfA2XUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so10078168plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9MQYc/61W8VrlVWHjYCO5F4oVU0wof84f42ny9JIzYU=;
        b=dLb6mu5vDD7uVW0F8ivJDH/37qF9DDg98o6sfwKRtaGl/ZBPOOYwcAfONyTeX8Efi8
         gnKI3+7LLqLpTsV7rfpne9BYIVIEcaq/S3+XRdLsCFsnWC9riHM42W5cEB5oIsHw8bEu
         EZ4agb8d/Q0mRpwyob4oeP3AQau1fdEmhleP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9MQYc/61W8VrlVWHjYCO5F4oVU0wof84f42ny9JIzYU=;
        b=LTqJ/iFOylKdGhVtfcNCtSho+tKIZlT1QPcI7N25vCecr/hhumvZyji4S7Vjpxv8+i
         UiBbtFyQdNkD4Hpv2415IWLQzMA1XYLa11rhVd7fQ1O3ebo5rxpiw3fr6Jlb722ZOXg3
         AqXtpvqJnw+6pdwD9T/0rryz02nYN0bEax96PXIGM+kQ8A07w5G9dCekjq1hMTdjSI4s
         DHSWqBtazhFJjK/uX0L9CX5akxGuset2agb7YYkWmeSIebdiKsi15AAzlN9k842Ys1bR
         K1RuO2XPfsrFDSJxXl6et/hKFI5yvcEIKERfhl8o7UwWUM75s9fPeh+jYhziqIu62O0y
         CaOA==
X-Gm-Message-State: AJcUukdaArYXKAPTowesC5y7Aoq9o79d/mQ3sv4ogXR/ykZqBQkivVWk
        QSbDf2lBviemmGnddSxeG3kepw==
X-Google-Smtp-Source: ALg8bN66ZyV+dMpHy/cvMPcXBOimujETg9Zinq63HJgRwPzwS77HLCIaydsillHYlX2jM75m+rtupw==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr28130572plb.321.1548804029513;
        Tue, 29 Jan 2019 15:20:29 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:28 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 01/10] arm64: dts: qcom: sdm845: Update reserved memory map
Date:   Tue, 29 Jan 2019 15:20:00 -0800
Message-Id: <20190129232009.5033-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update existing and add missing regions to the reserved memory map, as
described in version 10.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Added hyp and xbl memory nodes.
- Labeled all PIL nodes

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 71 ++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 33f5f4ba6160..c363848e9001 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -73,6 +73,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		hyp_mem: memory@85700000 {
+			reg = <0x0 0x85700000 0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0x0 0x85e00000 0 0x100000>;
+			no-map;
+		};
+
 		memory@85fc0000 {
 			reg = <0 0x85fc0000 0 0x20000>;
 			no-map;
@@ -90,12 +100,47 @@
 		};
 
 		memory@86200000 {
-			reg = <0 0x86200000 0 0x2d00000>;
+			reg = <0 0x86200000 0 0x100000>;
+			no-map;
+		};
+
+		tz_mem: memory@86300000 {
+			reg = <0 0x86300000 0 0x2c00000>;
+			no-map;
+		};
+
+		qseecom_mem: memory@8ab00000 {
+			reg = <0 0x8ab00000 0 0x1400000>;
+			no-map;
+		};
+
+		camera_mem: memory@8bf00000 {
+			reg = <0 0x8bf00000 0 0x500000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@96700000 {
-			reg = <0 0x96700000 0 0x100000>;
+		ipa_fw_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1a00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8df00000 {
+			reg = <0 0x8df00000 0 0x100000>;
 			no-map;
 		};
 
@@ -104,10 +149,30 @@
 			no-map;
 		};
 
+		venus_mem: memory@95800000 {
+			reg = <0 0x95800000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@95d00000 {
+			reg = <0 0x95d00000 0 0x800000>;
+			no-map;
+		};
+
 		mba_region: memory@96500000 {
 			reg = <0 0x96500000 0 0x200000>;
 			no-map;
 		};
+
+		slpi_mem: memory@96700000 {
+			reg = <0 0x96700000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: memory@97b00000 {
+			reg = <0 0x97b00000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	cpus {
-- 
2.18.0

