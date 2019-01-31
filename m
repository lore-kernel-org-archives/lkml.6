Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EAFC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D982184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPzZ0xkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfAaAjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:39:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40068 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfAaAjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:39:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so583086pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9drpPMa6oVd5Osj3ji7IrS++uZ13uDxuVy5Mx8gZLY=;
        b=HPzZ0xktXeT9m0z6Y+Kc0NGCckMSJAEBmBSiDFcYWvHwLw/FjbZ7FmGvvEfUDu5tOQ
         gZ9wqUQJ5mIAYk0fdq77PpbUJ4Flf42eh2CaZryTe7ytkZ1ph9M14C9C5NL6cZLxgiEQ
         pQAJY+FTjQLgFoH8icULZAM/89lzEiejE/vDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9drpPMa6oVd5Osj3ji7IrS++uZ13uDxuVy5Mx8gZLY=;
        b=f64DPWosr2gb87EegqLGGSMAJJVgzRlKwmDNqz3hU4lfGI9q/VCEU9G4FBBE3bkboU
         XRB617EcymSp0vWEEjyTFwYK/ZqpxiSAC7ff31e3c/4c7leN4raLNCnffSR20GjpCe4t
         vL/OoE4XYItZoZx7M8bZZiPCq7dIWK2K6LipnDlGHG9P6uxtHizsXTMz4CeIXz+MQcOu
         KHGMuKYcj5equXRBnBlJ50Fz4ez8ANpLFahYGpzaOu2krA1sw9bcN0LA4WXSvfsPngi6
         ShZR5ahK3I3DLRnzEJdkdbUSG4big8Rjaq54P/omm/KRWJz+uUyHWhR/OSu/P4GzwzfN
         qk9g==
X-Gm-Message-State: AJcUukcB1oMqC1Wn+Qsr1yqjCPoyiKKZdTd7k85Wp6CDZtPl8kWBN0gj
        yCZYfLgiXjYWKd95OSGinI/X5w==
X-Google-Smtp-Source: ALg8bN5tp+PdlEAR9e3hLxsfqyrM9tR7jQvrpc1T10r0qb/oQcTe7gVymd6NQg/CmOoNUH2/bgKzLw==
X-Received: by 2002:a63:4187:: with SMTP id o129mr27482466pga.370.1548895191885;
        Wed, 30 Jan 2019 16:39:51 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:39:50 -0800 (PST)
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
Subject: [PATCH v5 01/10] arm64: dts: qcom: sdm845: Update reserved memory map
Date:   Wed, 30 Jan 2019 16:39:24 -0800
Message-Id: <20190131003933.11436-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190131003933.11436-1-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update existing and add missing regions to the reserved memory map, as
described in version 10.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Labeled aop_mem, aop_cmd_db_mem and made tz_mem span the last TZ related segment

Changes since v3:
- Added hyp and xbl memory nodes.
- Labeled all PIL nodes

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 +++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 33f5f4ba6160..45b1616392aa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -73,12 +73,22 @@
 		#size-cells = <2>;
 		ranges;
 
-		memory@85fc0000 {
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
+		aop_mem: memory@85fc0000 {
 			reg = <0 0x85fc0000 0 0x20000>;
 			no-map;
 		};
 
-		memory@85fe0000 {
+		aop_cmd_db_mem: memory@85fe0000 {
 			compatible = "qcom,cmd-db";
 			reg = <0x0 0x85fe0000 0x0 0x20000>;
 			no-map;
@@ -89,13 +99,43 @@
 			no-map;
 		};
 
-		memory@86200000 {
-			reg = <0 0x86200000 0 0x2d00000>;
+		tz_mem: memory@86200000 {
+			reg = <0 0x86200000 0 0x3c00000>;
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
+			no-map;
+		};
+
+		ipa_fw_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@96700000 {
-			reg = <0 0x96700000 0 0x100000>;
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
 
@@ -104,10 +144,30 @@
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

